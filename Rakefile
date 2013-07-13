require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "sorter"
    gem.summary = %Q{A replacement to sort that maintains structure.}
    gem.description = %Q{A replacement to sort that maintains structure.}
    gem.email = "jhiggs@eml.cc"
    gem.homepage = "http://github.com/jonhiggs/sorter"
    gem.authors = ["Jon Higgs"]
    gem.add_development_dependency "riot"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

Rake::TestTask.new(:test_parser) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_parser.rb'
  test.verbose = true
end

Rake::TestTask.new(:test_indentation) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_indentation.rb'
  test.verbose = true
end

Rake::TestTask.new(:test_sorter) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_sorter.rb'
  test.verbose = true
end

task :default => :test
