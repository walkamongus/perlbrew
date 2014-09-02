# == Class: perlbrew::install
#
# This class installs Perlbrew.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { perlbrew:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Chadwick Banning <walkamongus@users.noreply.github.com>
#
class perlbrew::install (

  $perlbrew_root = $perlbrew::params::perlbrew_root,

) inherits perlbrew {

  if !defined(Package['curl']) {
    package {'curl':
      ensure => present,
    }
  }

  file {$perlbrew_root:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  exec {'install_perlbrew':
    environment => 'PERLBREW_ROOT=/opt/perl5',
    command     => '/usr/bin/curl -L http://install.perlbrew.pl | /bin/bash',
    creates     => "${perlbrew_root}/bin/perlbrew",
    require     => Package['curl'],
  }

  exec {'perlbrew_init':
    command => "${perlbrew_root}/bin/perlbrew init",
    creates => '/.perlbrew/init',
    require => Exec['install_perlbrew'],
  }

}
