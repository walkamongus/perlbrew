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

  $version = undef,

) {

  include perlbrew::perl
  include perlbrew::cpan::install

  concat::fragment {"perl_module_${title}":
    ensure  => present,
    target  => "${perlbrew::cpanfile_dir}/cpanfile",
    content => template('perlbrew/cpanfile_entry.erb'),
    notify  => Exec['install_perl_modules'],
  }

}
