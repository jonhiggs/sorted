$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '/sorted')

require 'formatter'
require 'indentation'
require 'parser'
require 'sorter'
