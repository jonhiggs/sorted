BASE_PATH = File.join(File.dirname(__FILE__), '../')
$:.unshift File.join(BASE_PATH, 'lib')

require 'byebug'
require 'riot'
require 'rubygems'

require 'sorted'

@example_dir = File.join(File.dirname(__FILE__), "/examples/")
EXAMPLES = {
  json: {
    simple: IO.read(File.join(@example_dir, "simple.json"))
  }
}
