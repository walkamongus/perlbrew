require 'spec_helper'

describe 'perlbrew::perl' do
  context 'supported operating systems' do
    ['RedHat',].each do |osfamily|
      describe "perlbrew::perl class with default parameters on #{osfamily}" do
        let(:facts) {{
          :osfamily       => osfamily,
          :concat_basedir => '/tmp',
        }}

        default_perl          = '5.16.3'
        default_perlbrew_root = '/opt/perl5'
  
        it { should compile.with_all_deps }

        it { should contain_class('perlbrew') }
        it { should contain_exec("install_perl_#{default_perl}").that_requires('Class[perlbrew::install]').that_requires('Class[perlbrew::config]').with({
          :command => "source #{default_perlbrew_root}/etc/bashrc; #{default_perlbrew_root}/bin/perlbrew install perl-#{default_perl} "
        }) }
        it { should contain_exec("switch_to_perl_#{default_perl}").that_requires("Exec[install_perl_#{default_perl}]").with({
          :command => "source /etc/profile; #{default_perlbrew_root}/bin/perlbrew switch perl-#{default_perl}"
        }) }
        it { should contain_exec('install_cpan').that_requires("Exec[switch_to_perl_#{default_perl}]").with({
          :command => "/usr/bin/curl -L http://cpanmin.us | #{default_perlbrew_root}/perls/perl-#{default_perl}/bin/perl - App::cpanminus"
        }) }
        it { should contain_concat__fragment('perlbrew_manpath').with({
          :target  => '/etc/profile.d/perlbrew.sh',
          :content => "export PERLBREW_MANPATH=\"#{default_perlbrew_root}/perls/perl-#{default_perl}/man\"",
          :order   => '02'
        }) }
        it { should contain_concat__fragment('perlbrew_path').with({
          :target  => '/etc/profile.d/perlbrew.sh',
          :content => "export PERLBREW_PATH=\"#{default_perlbrew_root}/bin:#{default_perlbrew_root}/perls/perl-#{default_perl}/bin\"",
          :order   => '03'
        }) }
        it { should contain_concat__fragment('perlbrew_perl').with({
          :target  => '/etc/profile.d/perlbrew.sh',
          :content => "export PERLBREW_PERL=\"perl-#{default_perl}\"",
          :order   => '04'
        }) }
        it { should contain_concat__fragment('source_perlbrew_bashrc').with({
          :target  => '/etc/profile.d/perlbrew.sh',
          :content => "source #{default_perlbrew_root}/etc/bashrc",
          :order   => '05'
        }) }
        it { should contain_concat__fragment('source_perlbrew_completion').with({
          :target  => '/etc/profile.d/perlbrew.sh',
          :content => "source #{default_perlbrew_root}/etc/perlbrew-completion.bash",
          :order   => '06'
        }) }
      end
    end
  end
  
  context 'unsupported operating system' do
    describe 'perlbrew::perl class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}
  
      it 'should fail' do
        expect { should compile }.to raise_error(/Nexenta not supported/)
      end
    end
  end
end
