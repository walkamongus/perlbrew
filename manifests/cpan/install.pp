# == Class: perlbrew::cpan::install
#
# run cpan command to install modules using a cpanfile.
#
# === Parameters
#
# [*options*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
#  class { perlbrew::cpan::install
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
class perlbrew::cpan::install (

  $cpanfile_name = 'cpanfile',
  $cpanfile_dir  = '/tmp',
  $options       = [],

) {

  include perlbrew::perl

  $default_options = [
    '--installdeps',
  ]

  $merged_options = concat($default_options, $options)
  $install_opts = join($merged_options, ' ')

  concat {"${cpanfile_dir}/${cpanfile_name}":
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  exec {"install_perl_${perlbrew::perl::version}_modules":
    command     => "/bin/bash --login -c \"cpanm ${install_opts} ${cpanfile_dir}\"",
    provider    => shell,
    subscribe   => Concat["${cpanfile_dir}/${cpanfile_name}"],
    refreshonly => true,
    timeout     => 0,
    require     => Exec["perl_${perlbrew::perl::version}_install_cpan"],
  }
}
