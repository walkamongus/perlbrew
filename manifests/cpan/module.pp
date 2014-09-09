# == Class: perlbrew::cpan::module
#
# install cpan modules using a Perlbrew-ed Perl.
#
# === Parameters
#
# Document parameters here.
#
# [*perlbrew_root*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# [*perl_version*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# [*url*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# [*options*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# === Examples
#
#  class { perlbrew::cpan::module
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Chadwick Banning <walkamongus@users.noreply.github.com>
#
define perlbrew::cpan::module (

  $perlbrew_root = $perlbrew::params::perlbrew_root,
  $perl_version  = $perlbrew::perl::version,
  $url           = '',
  $options       = [
    '--install',
  ],

) {

  include perlbrew::perl

  $pkg_name = $url ? {
    ''      => $title,
    default => $url,
  }

  if (is_array($options)) {
    $opts = join($options, ' ')
  }

  exec {"install_Bundle::LWP":
    command => "${perlbrew_root}/perls/perl-${perl_version}/bin/cpanm --install Bundle::LWP",
    unless  => "${perlbrew_root}/perls/perl-${perl_version}/bin/perl -MBundle::LWP -e 1",
    require => Class['perlbrew::perl']
  } ->
  exec {"install_Crypt::SSLeay":
    command => "${perlbrew_root}/perls/perl-${perl_version}/bin/cpanm --install Bundle::LWP",
    unless  => "${perlbrew_root}/perls/perl-${perl_version}/bin/perl -MCrypt::SSLeay -e 1",
    require => Class['perlbrew::perl'],
  } ->
  exec {"install_${pkg_name}":
    command => "${perlbrew_root}/perls/perl-${perl_version}/bin/cpanm ${opts} ${pkg_name}",
    unless  => "${perlbrew_root}/perls/perl-${perl_version}/bin/perl -M${title} -e 1",
    require => Class['perlbrew::perl']
  }

}
