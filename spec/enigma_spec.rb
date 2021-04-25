require './lib/enigma'
require 'date'

RSpec.describe Enigma do

  it 'exists' do
    enigma1 = Enigma.new

    expect(enigma1).to be_instance_of(Enigma)
  end


  it 'can generate key' do
    enigma1 = Enigma.new
    mock_key_step_one = [0, 3, 2, 4, 6]
    allow(enigma1).to receive(:number_sampler) do
      mock_key_step_one
    end
    expect(enigma1.key_generator).to eq([3, 32, 24, 46])
  end

  it 'can sample numbers' do
    enigma1 = Enigma.new
    mock_numbers = [0, 0, 1, 1, 1]
    allow(enigma1).to receive(:number_sampler) do
      mock_numbers
    end

    expect(enigma1.number_sampler.include?(1)).to eq(true)
    expect(enigma1.number_sampler.include?(4)).to eq(false)
  end

  it 'can create offset' do
    enigma1 = Enigma.new
    mock_key_step_one = [0, 3, 2, 4, 6]
    allow(enigma1).to receive(:number_sampler) do
      mock_key_step_one
    end

    expect(enigma1.create_offset("170987")).to eq([7, 6, 3, 1])
  end

  it 'can encrypt' do
    enigma1 = Enigma.new
    mock_key_step_one = [0, 3, 2, 4, 6]
    allow(enigma1).to receive(:number_sampler) do
      mock_key_step_one
    end
    expect(enigma1.encrypt("Alex Ferencz", "170987")).to eq({"hmlycllxltfe"})
  end
end