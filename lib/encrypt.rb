require 'time'
require './lib/enigma'
enigma1 = Enigma.new


instance_of_read = File.open(ARGV[0], "r")

user_input = instance_of_read.read
  #pull out of file and make into a string
  #we assing action to a variable name because we want to be able to use it later. we are "catching the information"

instance_of_read.close
  #now please close the reading action
output_from_enigma_encrypt = enigma1.encrypt(user_input.chomp, ARGV[2], ARGV[3])

instance_of_write = File.open(ARGV[1], "w")
 #this creates a writer file

 instance_of_write.write(output_from_enigma_encrypt[:encryption])
 #we dont assign this a variable name because we dont need to use it again here. We are "throwing the information".

instance_of_write.close

puts "Created #{ARGV[1]} with the key #{output_from_enigma_encrypt[:key]} and date #{output_from_enigma_encrypt[:date]}"
