# perlbrew

[![Build Status](https://travis-ci.org/walkamongus/puppet-perlbrew.svg)](https://travis-ci.org/walkamongus/puppet-perlbrew)

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
passed to the perlbrew::perl class. CPAN installation options may be 
passed to the perlbrew::cpan::module class. Future versions of the
perlbrew::cpan::module class will allow for installing from a **cpanfile**.

## Setup

### What perlbrew affects

* Installs curl package if necessary
* Installs Perlbrew into $perlbrew_root
* Optionally install a specific Perl version via Perlbrew
* Optionaly install CPAN modules using Perlbrew-ed Perl

### Beginning with perlbrew

Install and configure Perlbrew with defaults:

`include ::perlbrew`

## Usage

Install Perlbrew to a custom directory:

`
class {'::perlbrew':
  perlbrew_root => '/usr/local/perlbrew',
}
`

Install a Perl version using Perlbrew:

`
perlbrew::perl{'my_perl_install':
  version         => '5.12.3',
  compile_options => ['-Duseshrplib', '-Dusethreads']
}
`

Install a CPAN module:

`
perlbrew::cpan::module {'Class::DBI': }
`

Install a CPAN module from a URL with install options:

`
perlbrew::cpan::module {'':
  url     => '',
  options => [
    '-n',
    '--mirror-only',
    '--mirror http://www.perl.com/CPAN'
  ]
}
`

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

Developed using:
* Puppet 3.6.2
* CentOS 6.5 
