#!/usr/bin/env ruby
$LOAD_PATH << '.'

require './init'

n=20

#procedure = DelOpenkey.new(Task.find(n))
#procedure = AddOpenkey.new(Task.find(n))
procedure = AddUser.new(Task.find(n))
puts procedure.perform ? 'Succeed!' : 'Failed...'

puts procedure.comment

