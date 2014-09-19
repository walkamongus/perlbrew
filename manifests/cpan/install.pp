# == Class: perlbrew::cpan::install
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
#  class { perlbrew::cpan::install
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Chadwick Banning <walkamongus@users.noreply.github.com>
#
class perlbrew::cpan::install (

  $options = [
    '--installdeps',
  ],

) {

  include perlbrew::perl

  $install_opts = join($options,' ')

  exec {'install_perl_modules':
    command     => "${perlbrew::perlbrew_root}/perls/perl-${perlbrew::perl::version}/bin/cpanm ${install_opts} ${perlbrew::cpanfile_dir}",
    subscribe   => Concat["${perlbrew::cpanfile_dir}/cpanfile"],
    refreshonly => true,
  }

}
