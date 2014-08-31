require 'rubygems'
require 'riot'
require 'byebug'

@example_dir = File.join(File.dirname(__FILE__), "/examples/")
EXAMPLES = {
  json: {
    simple: IO.read(File.join(@example_dir, "simple.json"))
  }
}
