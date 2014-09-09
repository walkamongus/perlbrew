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

  exec {"install_${pkg_name}":
    command => "${perlbrew::perlbrew_root}/perls/perl-${perlbrew::perl::version}/bin/cpanm ${opts} ${pkg_name}",
    unless  => "${perlbrew::perlbrew_root}/perls/perl-${perlbrew::perl::version}/bin/perl -M${title} -e 1",
    require => Class['perlbrew::perl']
  }

}
