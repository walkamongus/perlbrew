# perlbrew

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with perlbrew](#setup)
    * [What perlbrew affects](#what-perlbrew-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with perlbrew](#beginning-with-perlbrew)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs and configures Perlbrew.  It also includes optional classes 
to install Perl and CPAN moudles via Perlbew.

## Module Description

This module primarily focuses on installing and configuring Perlbrew. There are
optional classes that may be declared for installing a spcific version of Perl
as well as installing CPAN modules for a Perl installed with Perlbrew.

Perlbrew configuration is currently limited. Perl compile-time options may be 
passed through the perlbrew::perl class. CPAN installation options may be 
passed in the perlbrew::cpan::module class. Future versions of the
perlbrew::cpan::module class will allow for installing from a **cpanfile**.

## Setup

### What perlbrew affects

* Installs curl package if necessary
* Installs Perlbrew into $perlbrew_root
* Optionally install a specific Perl version via Perlbrew
* Optionaly install CPAN modules using Perlbrew-ed Perl

### Setup Requirements **OPTIONAL**

None.

### Beginning with perlbrew

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

Developed using:
* Puppet 3.6.2
* CentOS 6.5 

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
