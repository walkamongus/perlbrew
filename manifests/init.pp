# == Class: perlbrew
#
# This class installs and configures perlbrew.
# It does not install any versions of Perl by default.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class perlbrew (

  $perlbrew_root      = $perlbrew::params::perlbrew_root,
  $perlbrew_init_file = $perlbrew::params::perlbrew_init_file,
  $cpanfile_name      = $perlbrew::params::cpanfile_name,
  $cpanfile_dir       = $perlbrew::params::cpanfile_dir,


) inherits perlbrew::params {

  # param validation

  class { 'perlbrew::install': } ->
  class { 'perlbrew::config': }
  
}
