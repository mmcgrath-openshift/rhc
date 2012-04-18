## Add some testing for when we are building a rpm and when we're not
unless ENV['RHC_RPMBUILD']
  require 'rubygems'
  require 'rubygems/command.rb'
  require 'rubygems/dependency_installer.rb' 
  begin
    Gem::Command.build_args = ARGV
  rescue NoMethodError
  end 
  inst = Gem::DependencyInstaller.new
  begin
    if RUBY_VERSION > "1.9"
      inst.install "test-unit"
    end

    if ENV['JSON_PURE'] or (RUBY_VERSION == "1.8.6" or RUBY_PLATFORM =~ /mswin/ or RUBY_PLATFORM =~ /darwin/)
      inst.install('json_pure')
    else
      inst.install('json')
    end

  rescue
    exit(1)
  end 
end

f = File.open(File.join(File.dirname(__FILE__), "Rakefile"), "w")   # create dummy rakefile to indicate success
f.write("task :default\n")
f.close
