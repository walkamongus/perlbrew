# == Class: perlbrew::perl
#
# This class installs a version of Perl using Perlbrew.
#
# === Parameters
#
# Document parameters here.
#
# [*perlbrew_root*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# [*version*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# [*compile_options*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class perlbrew::perl (

  $version         = '5.16.3',
  $compile_options = [],

) {

  include perlbrew

  if (is_array($compile_options)) {
    $compile_opts = join($compile_options, ' ')
  }

  exec {"install_perl_${version}":
    environment => [
      "PERLBREW_ROOT=${perlbrew::perlbrew_root}",
      'PERLBREW_HOME=/tmp/.perlbrew',
      'HOME=/opt',
    ],
    command     => "/bin/bash --login -c \"source ${perlbrew::perlbrew_root}/etc/bashrc; ${perlbrew::perlbrew_root}/bin/perlbrew install perl-${version} ${compile_opts}\"",
    creates     => "${perlbrew::perlbrew_root}/perls/perl-${version}/bin/perl",
    provider    => shell,
    timeout     => 0,
    require     => [ Class['perlbrew::install'], ],
  }

  exec {"switch_to_perl_${version}":
    command  => "/bin/bash --login -c \"source /etc/profile; ${perlbrew::perlbrew_root}/bin/perlbrew switch perl-${version}\"",
    provider => shell,
    unless   => "perl -e 'print $^V' | grep v${version}",
    require  => Exec["install_perl_${version}"],
  }

  exec{"perl_${version}_install_cpan":
    command => "/usr/bin/curl -L http://cpanmin.us | ${perlbrew::perlbrew_root}/perls/perl-${version}/bin/perl - App::cpanminus",
    creates => "${perlbrew::perlbrew_root}/perls/perl-${version}/bin/cpanm",
    require => Exec["switch_to_perl_${version}"],
  }

  Concat::Fragment {
    target  => $perlbrew::perlbrew_init_file,
  }

  concat::fragment {'perlbrew_manpath':
    target  => $perlbrew::perlbrew_init_file,
    content => "export PERLBREW_MANPATH=\"${perlbrew::perlbrew_root}/perls/perl-${version}/man\"",
    order   => 02,
    require => Exec["install_perl_${version}"],
  }

  concat::fragment {'perlbrew_path':
    target  => $perlbrew::perlbrew_init_file,
    content => "export PERLBREW_PATH=\"${perlbrew::perlbrew_root}/bin:${perlbrew::perlbrew_root}/perls/perl-${version}/bin\"",
    order   => 03,
    require => Exec["install_perl_${version}"],
  }

  concat::fragment {'perlbrew_perl':
    target  => $perlbrew::perlbrew_init_file,
    content => "export PERLBREW_PERL=\"perl-${version}\"",
    order   => 04,
    require => Exec["install_perl_${version}"],
  }

  concat::fragment {'source_perlbrew_bashrc':
    target  => $perlbrew::perlbrew_init_file,
    content => "source ${perlbrew::perlbrew_root}/etc/bashrc",
    order   => 05,
  }

  concat::fragment {'source_perlbrew_completion':
    target  => $perlbrew::perlbrew_init_file,
    content => "source ${perlbrew::perlbrew_root}/etc/perlbrew-completion.bash",
    order   => 06,
  }
}
