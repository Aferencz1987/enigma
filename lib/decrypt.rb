require 'time'
require './lib/enigma'
enigma1 = Enigma.new

instance_of_read = File.open(ARGV[0], "r")

user_input = instance_of_read.read

instance_of_read.close

output_from_enigma_decrypt = enigma1.decrypt(user_input, ARGV[2], ARGV[3])

instance_of_write = File.open(ARGV[1], "w")

instance_of_write.write(output_from_enigma_decrypt[:decryption])

instance_of_write.close

puts "Created #{ARGV[1]} with the key #{output_from_enigma_decrypt[:key]} and date #{output_from_enigma_decrypt[:date]}"
