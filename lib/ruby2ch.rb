$:.unshift(File.dirname(__FILE__)) unless 
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "ruby2ch/version"
require "ruby2ch/thre"
require 'ruby2ch/board'
require 'ruby2ch/datparse'
include Ruby2ch
#module Ruby2ch
  # Your code goes here...
  
#end
