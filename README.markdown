# perlbrew Puppet Module

[![Build Status](https://travis-ci.org/walkamongus/perlbrew.svg)](https://travis-ci.org/walkamongus/perlbrew)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup - The basics of getting started with perlbrew](#setup)
    * [What perlbrew affects](#what-perlbrew-affects)
    * [Beginning with perlbrew](#beginning-with-perlbrew)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This module installs and configures Perlbrew.  It also includes optional classes 
to install Perl and CPAN modules via Perlbew.

## Module Description

This module primarily focuses on installing and configuring Perlbrew. There are
optional classes that may be declared for installing a spcific version of Perl
as well as installing CPAN modules for a Perl installed with Perlbrew.

Perlbrew configuration is currently limited. Perl compile-time options may be 
passed to the perlbrew::perl class.

Using the perlbrew:perl class will automatically install the Bundle::LWP and 
Crypt::SSLeay modules if they are not present on the system. This enables the 
installation of CPAN modules from HTTPS mirrors.

CPAN module installation is done via a dynamically generated cpanfile.

## Setup

### What perlbrew affects

* Packages
    * curl
* Files
    * perlbrew root directory
    * cpanfile
* Execs
    * perlbrew installation
    * perl installation
    * switch to perl version
    * cpan installation
    * Bundle::LWP and Crypt::SSLeay installation
    * additional cpan module installation

### Beginning with perlbrew

Install and configure Perlbrew with defaults:

    include ::perlbrew

## Usage

Install Perlbrew to a custom directory:

    class {'::perlbrew':
      perlbrew_root => '/usr/local/perlbrew',
    }

Install default Perl version 5.16.3:

    perlbrew::perl {'my_perl_install': }

Install a different customized Perl version using Perlbrew:

    perlbrew::perl {'my_perl_install':
      version         => '5.12.3',
      compile_options => [
        '-Duseshrplib',
        '-Dusethreads',
      ],
    }

Install a CPAN module:

    perlbrew::cpan::module {'Class::DBI': }

Install a CPAN module with custom install options:

    perlbrew::cpan::module {'Class::C3': }
    class {'perlbrew::cpan::install':
      options => [
        '--mirror ftp://cpan.cse.msu.edu/',
        '--notest',
        '--force',
      ],
    }

## Reference

###Parameters

***perlbrew***
* `perlbrew_root`: perlbrew installation root directory. Defaults to '/opt/perl5' 
* `perlbrew_init_file`: file to hold required perlbrew ENV variables.  This file should 
be sourced by users on login. Defaults to '/etc/profile.d/perlbrew.sh'

***perlbrew::perl***
* `version`: perl version string to install via perlbrew. Should be recognizeable 
by perlbrew. Defaults to '5.16.3'
* `compile_options`: Array of perlbrew options that get passed to the perlbrew perl 
installation command.  Defaults to empty array

***perlbrew::cpan::install***
* `cpanfile_dir`: Directory in which the cpanfile is placed.  Defaults to '/tmp'
* `options`: Array of options passed to the cpan command for module installation. 
The '--installdeps' option is always passed in order to install from the cpanfile.

***perlbrew::cpan::module***
* `version`: Version string or range for the module to install. 
See [Version_Formats](http://search.cpan.org/~dagolden/CPAN-Meta-2.142060/lib/CPAN/Meta/Spec.pm#Version_Formats) 
for more information.

###Classes
* perlbrew::params
* perlbrew::init
* perlbrew::install
* perlbrew::config
* perlbrew::perl
* perlbrew::cpan::install
* perlbrew::cpan::module

## Limitations

Developed using:
* Puppet 3.6.2
* CentOS 6.5 
