require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "smstrade_de"
    gem.summary = 'Gem for sending SMS via smstrade.de Gateway.'
    gem.email = "maikel@urlitzki.de"
    gem.homepage = "http://github.com/maikelcoke/smstrade_de"
    gem.authors = ["Maikel Urlitzki"]

    gem.has_rdoc = true
    gem.extra_rdoc_files = [ "README.rdoc" ]

    gem.test_files = Dir.glob('test/test_*.rb')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

# Test
require 'rake/testtask'
desc 'Default: run unit tests.'
task :default => :test
task :test => :check_dependencies

Rake::TestTask.new(:test) do |test|
  test.test_files = FileList.new('test/test_*.rb')
  test.libs << 'test'
  test.verbose = true
end

# RDoc
require 'rake/rdoctask'
Rake::RDocTask.new do |rd|
  rd.title = "Valuedate"
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc", "lib/*.rb")
  rd.rdoc_dir = "doc"
end
