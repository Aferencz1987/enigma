require 'time'
require './lib/encryption'

new_file = File.open('encrypt.rb', "r")
new_file.write("all the text you want")
new_file.close


arg 0 is what is being opened and then
message = new_file.read
