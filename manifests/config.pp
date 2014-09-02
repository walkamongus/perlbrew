# == Class: perlbrew::config
#
# This class configures Perlbrew.
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
class perlbrew::config (

  $perlbrew_root = $perlbrew::params::perlbrew_root,

) inherits perlbrew {

  $perlbrew_sh_str = "export PERLBREW_ROOT=${perlbrew_root}
source ${perlbrew_root}/etc/bashrc
source ${perlbrew_root}/etc/perlbrew-completion.bash"

  file {'/etc/profile.d/perlbrew.sh':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $perlbrew_sh_str,
    require => Class['perlbrew::install'],
  }

}
