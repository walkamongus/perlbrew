# == Class: perlbrew
#
# This class installs and configures perlbrew.
# It does not install any versions of Perl by default.
#
# === Parameters
#
# === Variables
#
# === Examples
#
# === Authors
#
# Chadwick Banning <walkamongus@users.noreply.github.com>
#
class perlbrew inherits perlbrew::params {

  include perlbrew::install
  include perlbrew::config
  
}