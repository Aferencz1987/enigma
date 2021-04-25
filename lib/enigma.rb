require 'time'
require './lib/encryption'

class Enigma
  attr_reader :encryption
  def initialize
    @first_offset_impacted = [97, 101, 105, 109, 113, 117, 121]
    @second_offset_impacted = [98, 102, 106, 110, 114, 118, 122]
    @third_offset_impacted = [99, 103, 107, 111, 115, 119, 32]
    @fourth_offset_impacted = [100, 104, 108, 112, 116, 120]
    @encryption = Encryption.new
  end

  def encrypt(user_input = ARGV, key = @encryption.key_generator, date = Time.now.strftime('%d%m%y'))
    hash = Hash.new
    @user_input = "Alex Ferencz"
    offset_key = @encryption.create_offset(date)
    useable_user_input = @user_input.downcase.split('')
    result = []
    useable_user_input.each do |letter|
      if @first_offset_impacted.include?(letter.ord)
        new_ordinal_value = (letter.ord + offset_key[0])
        if new_ordinal_value < 123
          result.push((new_ordinal_value).chr)
        elsif new_ordinal_value > 122
          result.push((new_ordinal_value - 27).chr)
        end
      elsif @second_offset_impacted.include?(letter.ord)
        new_ordinal_value = (letter.ord + offset_key[1])
        if new_ordinal_value < 123
          result.push((new_ordinal_value).chr)
        elsif new_ordinal_value > 122
          result.push((new_ordinal_value - 27).chr)
        end
      elsif @third_offset_impacted.include?(letter.ord)
        new_ordinal_value = (letter.ord + offset_key[2])
        if letter.ord == 32
           result.push((96 + offset_key[2]).chr)
        elsif new_ordinal_value < 123
          result.push((new_ordinal_value).chr)
        elsif new_ordinal_value > 122
          result.push((new_ordinal_value - 27).chr)
        end
      elsif @fourth_offset_impacted.include?(letter.ord)
        new_ordinal_value = (letter.ord + offset_key[3])
        if new_ordinal_value < 123
          result.push((new_ordinal_value).chr)
        elsif new_ordinal_value > 122
          result.push((new_ordinal_value - 27).chr)
        end
      end
    end
    hash[:encryption] = result.join
    hash[:key] = key
    hash[:date] = date

    p hash
  end
end


  # def letter_change
  #   step_1 = create_offset(date)
  #
  # end

  # def encrypt(date, user_input)
  #   offset = create_offset(date)
  #   # usable_input = user_input.downcase
  #   encrypted_alphabet = []
  #   @letters.each_index do |index|
  #     if index % 4 == 0
  #       offset1 = @letters[index].ord + offset[0]
  #       if offset1 < 123
  #         encrypted_alphabet.push(offset1.chr)
  #       elsif offset1 > 122
  #         encrypted_alphabet.push((offset1 - 27).chr)
  #       end
  #     elsif index % 4 == 1
  #       offset2 = @letters[index].ord + offset[1]
  #       if offset2 < 123
  #         encrypted_alphabet.push(offset2.chr)
  #       elsif offset2 > 122
  #         encrypted_alphabet.push((offset2 - 27).chr)
  #       end
  #     elsif index % 4 == 2
  #       offset3 = @letters[index].ord + offset[2]
  #       if @letters[index].ord == 32
  #         offset3 = 96 + offset[2]
  #         encrypted_alphabet.push((offset3).chr) ####### math
  #       elsif offset3 < 123
  #         encrypted_alphabet.push(offset3.chr)
  #       elsif offset3 > 122
  #         encrypted_alphabet.push((offset3 - 27).chr)
  #       end
  #     elsif index % 4 == 3
  #       offset4 = @letters[index].ord + offset[3]
  #       if offset4 < 123
  #         encrypted_alphabet.push(offset4.chr)
  #       elsif offset4 > 122
  #         encrypted_alphabet.push((offset4 - 27).chr)
  #       end
  #     end
  #   end
  #   encrypted_alphabet
  #   require "pry"; binding.pry
  # end
