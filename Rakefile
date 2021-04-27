require 'rake/testtask'

task :test do
  ENV['RACK_ENV'] = 'test'
  Rake::Task['test'].invoke
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end
