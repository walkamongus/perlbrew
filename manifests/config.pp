# == Class: perlbrew::config
#
# This class configures Perlbrew and is meant to be called from perlbrew.
#
class perlbrew::config {

  concat {$perlbrew::perlbrew_init_file:
    owner          => 'root',
    group          => 'root',
    mode           => '0644',
    ensure_newline => true,
    require        => Class['perlbrew::install'],
  }

  Concat::Fragment {
    target         => $perlbrew::perlbrew_init_file,
  }

  concat::fragment {'export_perlbrew_root':
    content => "export PERLBREW_ROOT=${perlbrew::perlbrew_root}",
    order   => 01,
  }

  concat::fragment {'source_perlbrew_bashrc':
    content => "source ${perlbrew::perlbrew_root}/etc/bashrc",
    order   => 02,
  }

  concat::fragment {'source_perlbrew_completion':
    content => "source ${perlbrew::perlbrew_root}/etc/perlbrew-completion.bash",
    order   => 03,
  }

}
