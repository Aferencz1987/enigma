require 'time'

class Enigma
  attr_reader :encryption
  def initialize
  end

  def number_sampler
    numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    key_step_one = numbers.sample(5)
  end

  def key_generator(input = nil)
    if input == nil
      @key_step_one = number_sampler
    else
      @key_step_one = input.split('').map do |number|
        number.to_i
      end
    end
  end

  def create_offset(key, date = "270421")#Time.now.strftime('%d%m%y'))
    key_1 = key_generator(key)
    offset = []
      key_1.each_cons(2) do |chunk|
        offset.push(chunk.join.to_i)
      end
    squared_date = (date.to_i**2).to_s
    last_4_of_squared_date = squared_date[-4..-1].to_i
    index_count = 0
    combined_numbers = offset.map do |key_element|
      result = key_element + (last_4_of_squared_date.to_s[index_count]).to_i
      index_count += 1
      result
    end
    shift = combined_numbers.map do |number|
      number % 27
    end
    shift
  end

  def encrypt(user_input, key = nil, date = nil)
    if date == nil
      date = "270421"#Time.now.strftime('%d%m%y')
    end
    if key == nil
      key = key_generator.join
    end
    @hash = Hash.new
    offset_key = create_offset(key, date)
    usable_user_input = user_input.downcase.split('')
    counter = 0
    encrypted_message = []
    usable_user_input.each do |letter|
      if counter == 4
        counter = 0
      end
      if letter.ord == 32
        result = 32
        if offset_key[counter] > 0
          result = 96 + offset_key[counter]
        end
        encrypted_message.push(result.chr)
      elsif
        if (letter.ord + offset_key[counter]) < 123
          if (33..64).include?(letter.ord)
            result = letter
            encrypted_message.push(result.chr)
          else
            result = (letter.ord + offset_key[counter])
            encrypted_message.push(result.chr)
          end
        elsif (letter.ord + offset_key[counter]) > 123
          result = (letter.ord + offset_key[counter]) - 27
          encrypted_message.push(result.chr)
        elsif (letter.ord + offset_key[counter]) == 123
           result = ' '.ord
           encrypted_message.push(result.chr)
        end
      end
      counter += 1
    end
    @hash[:encryption] = encrypted_message.join
    @hash[:key] = key
    @hash[:date] = date
   @hash
  end

  def decrypt(message, key = nil, date = nil)
    if date == nil
      date = "270421"#Time.now.strftime('%d%m%y')
    end
    if key == nil
      key = key_generator.join
    end
    @hash = Hash.new
    offset_key = create_offset(key, date)
    usable_message = message.downcase.split('')
    counter = 0
    decrypted_message = []
    usable_message.each do |letter|
      if counter == 4
        counter = 0
      end
      if letter.ord == ' '.ord
        result = (123 - offset_key[counter])
        decrypted_message.push(result.chr)
      elsif (letter.ord - offset_key[counter]) > 96
        result = (letter.ord - offset_key[counter])
        decrypted_message.push(result.chr)
      elsif (letter.ord - offset_key[counter]) < 97
        if (33..64).include?(letter.ord)
          result = letter
          decrypted_message.push(result.chr)
        elsif (letter.ord - offset_key[counter]) == 96
          result = ' '.ord
          decrypted_message.push(result.chr)
        elsif
          result = (letter.ord - offset_key[counter]) + 27
          decrypted_message.push(result.chr)
        end
      end
      counter += 1
    end
    @hash[:decryption] = decrypted_message.join
    @hash[:key] = key
    @hash[:date] = date
   @hash
  end
end
