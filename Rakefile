require 'rake/packagetask'
require 'rake/clean'


require 'jasmine-headless-webkit'
require 'jasmine/headless/task'

require 'cucumber'
require 'cucumber/rake/task'

include Rake::DSL if defined?(Rake::DSL)

Jasmine::Headless::Task.new
Cucumber::Rake::Task.new

# Rake::PackageTask.new("words", :noversion) do |p|
#   p.package_dir = "dist"
#   p.need_zip = true
#   p.package_files.include("public/**/*")
# end
# 
# 
# task :zip_it do
#  file "words.zip" => "dist/words.zip" do
#     chdir("dist/words/public") do
#       sh %{zip ../../words *}
#       puts "ZIP"
#     end
#  end
# end

task :default => ['jasmine:headless', 'cucumber']

