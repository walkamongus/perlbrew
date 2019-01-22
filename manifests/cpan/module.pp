# == Class: perlbrew::cpan::module
#
# install a cpan module using a Perlbrew-ed Perl.
#
# === Parameters
#
# Document parameters here.
#
# [*perlbrew_root*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
#  class { perlbrew::cpan::module
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
define perlbrew::cpan::module (

  $version = undef,

) {

  include perlbrew::perl
  include perlbrew::cpan::install

  concat::fragment {"perl_module_${title}"  :
    target  => "${perlbrew::cpan::install::cpanfile_dir}/${perlbrew::cpan::install::cpanfile_name}",
    content => template('perlbrew/cpanfile_entry.erb'),
  }

}
