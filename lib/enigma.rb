require 'time'
require './lib/encryption'

class Enigma
  attr_reader :encryption
  def initialize
    @first_offset_impacted = [97, 101, 105, 109, 113, 117, 121]
    @second_offset_impacted = [98, 102, 106, 110, 114, 118, 122]
    @third_offset_impacted = [99, 103, 107, 111, 115, 119, 32]
    @fourth_offset_impacted = [100, 104, 108, 112, 116, 120]
    @letters = ("a".."z").to_a << " "
    @encryption = Encryption.new
  end

  def number_sampler
    numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    key_step_one = numbers.sample(5)
  end

  def key_generator
    key_step_one = number_sampler
    @key = []
      cons_keys = key_step_one.each_cons(2) do |chunk|
        @key.push(chunk.join.to_i)
      end
      @key
  end

  def create_offset(date = Time.now.strftime('%d%m%y')) #29236554169
    key_generator
    squared_date = (date.to_i**2).to_s
    last_4_of_squared_date = squared_date[-4..-1].to_i
    index_count = 0
    step_3 = @key.map do |key_element|
      result = key_element + (last_4_of_squared_date.to_s[index_count]).to_i
      index_count += 1
      result
    end
    offset = step_3.map do |number|
      number % 27
    end
    offset
  end

  def encrypt(user_input = ARGV, key = key_generator.join, date = Time.now.strftime('%d%m%y'))
    @hash = Hash.new
    @user_input = "Alex Ferencz"
    offset_key = create_offset(date)
    usable_user_input = @user_input.downcase.split('')
    counter = 0
    encrypted_message = []
    usable_user_input.each do |letter|
      if counter == 4
        counter = 0
      end
      if letter.ord == 32
        result = 96 + offset_key[counter]
        encrypted_message.push(result.chr)
        counter += 1
      else
        if result = (letter.ord + offset_key[counter]) < 123
          result = (letter.ord + offset_key[counter])
          encrypted_message.push(result.chr)
          counter += 1

        elsif
          result = (letter.ord + offset_key[counter]) >= 123
          result = (letter.ord + offset_key[counter]) - 26
          encrypted_message.push(result.chr)
          counter += 1
        end
      end
    end
    @hash[:encryption] = encrypted_message.join
    @hash[:key] = key
    @hash[:date] = date

   @hash
  end

  def decrypt(message, key = key_generator.join, date = Time.now.strftime('%d%m%y'))
    @hash = Hash.new

    offset_key = create_offset(date)
    usable_message = message.downcase.split('')
    counter = 0
    decrypted_message = []
    usable_message.each do |letter|
      if counter == 4
        counter = 0
      end
      if result = (letter.ord - offset_key[counter]) > 96
        result = (letter.ord - offset_key[counter])
        counter += 1
        decrypted_message.push(result.chr)
      elsif result = (letter.ord - offset_key[counter]) < 97
        if result = (letter.ord - offset_key[counter]) == 96
          result = 32
          counter += 1
          decrypted_message.push(result.chr)
        else result = (letter.ord - offset_key[counter]) + 27
          decrypted_message.push(result.chr)
          counter += 1
        end
      end
    end
    @hash[:encryption] = decrypted_message.join
    @hash[:key] = key
    @hash[:date] = date

   @hash
  end
end
