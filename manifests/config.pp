# == Class: perlbrew::config
#
# This class configures Perlbrew and is meant to be called from perlbrew.
#
class perlbrew::config {

  concat {$perlbrew::perlbrew_init_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Class['perlbrew::install'],
  }

  concat::fragment {'export_perlbrew_root':
    target  => $perlbrew::perlbrew_init_file,
    content => "export PERLBREW_ROOT=${perlbrew::perlbrew_root}",
    order   => 01,
  }

  concat::fragment {'source_perlbrew_bashrc':
    target  => $perlbrew::perlbrew_init_file,
    content => "source ${perlbrew::perlbrew_root}/etc/bashrc",
    order   => 02,
  }

  concat::fragment {'source_perlbrew_completion':
    target  => $perlbrew::perlbrew_init_file,
    content => "source ${perlbrew::perlbrew_root}/etc/perlbrew-completion.bash",
    order   => 03,
  }

}
