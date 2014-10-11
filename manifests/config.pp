# == Class: perlbrew::config
#
# This class configures Perlbrew and is meant to be called from perlbrew.
#
class perlbrew::config {

  concat {$perlbrew::perlbrew_init_file:
    owner          => 'root',
    group          => 'root',
    mode           => '0755',
    ensure_newline => true,
    require        => Class['perlbrew::install'],
  }

  Concat::Fragment {
    target => $perlbrew::perlbrew_init_file,
  }

  concat::fragment {'perlbrew_bash':
    target  => $perlbrew::perlbrew_init_file,
    content => '#!/bin/bash',
    order   => 00
  }
  concat::fragment {'export_perlbrew_root':
    target  => $perlbrew::perlbrew_init_file,
    content => "export PERLBREW_ROOT=\"${perlbrew::perlbrew_root}\"",
    order   => 01,
  }
}
