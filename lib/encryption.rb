require 'time'

class Encryption
  def initialize
  end

  def key_generator
    key_step_one = number_sampler
    @key = []
      cons_keys = key_step_one.each_cons(2) do |chunk|
        @key.push(chunk.join.to_i)
      end
      @key
  end

  def number_sampler
    numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    key_step_one = numbers.sample(5)
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
end
