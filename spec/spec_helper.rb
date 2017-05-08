ENV['TEST'] = '1'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "pp"
require "byebug"

root = File.expand_path('../../', __FILE__)
require "#{root}/lib/ufo"

module Helpers
  def execute(cmd)
    puts "Running: #{cmd.colorize(:magenta)}" if ENV['DEBUG']
    out = `#{cmd}`
    puts out if ENV['DEBUG']
    out
  end

  def create_starter_project_fixture
    FileUtils.rm_rf("spec/fixtures/hi")
    execute("bin/ufo init --cluster prod --image tongueroo/hi --project-root spec/fixtures/hi --app hi")
  end
end

RSpec.configure do |c|
  c.include Helpers

  c.before(:each) do
    # ensures we never called real aws api since the fixture home folder does not have ~/.aws/credentails setup
    ENV['HOME'] = "spec/fixtures/home"
  end
end
