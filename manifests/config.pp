# == Class: perlbrew::config
#
# This class configures Perlbrew and is meant to be called from perlbrew.
#
class perlbrew::config {

  $perlbrew_sh_str = "export PERLBREW_ROOT=${perlbrew::perlbrew_root}
source ${perlbrew::perlbrew_root}/etc/bashrc
source ${perlbrew::perlbrew_root}/etc/perlbrew-completion.bash"

  file {'/etc/profile.d/perlbrew.sh':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $perlbrew_sh_str,
    require => Class['perlbrew::install'],
  }

}
