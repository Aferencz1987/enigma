require './lib/enigma'
require './lib/encryption'


RSpec.describe Encryption do
  it 'exist' do
    encryption1 = Encryption.new

    expect(encryption1).to be_instance_of(Encryption)
  end

  it 'can generate key' do
    encryption1 = Encryption.new
    mock_key_step_one = [0, 3, 2, 4, 6]
    allow(encryption1).to receive(:number_sampler) do
      mock_key_step_one
    end
    expect(encryption1.key_generator).to eq([3, 32, 24, 46])
  end

  it 'can sample numbers' do
    encryption1 = Encryption.new
    mock_numbers = [0, 0, 1, 1, 1]
    allow(encryption1).to receive(:number_sampler) do
      mock_numbers
    end

    expect(encryption1.number_sampler.include?(1)).to eq(true)
    expect(encryption1.number_sampler.include?(4)).to eq(false)
  end

  it 'can create offset' do
    encryption1 = Encryption.new
    mock_key_step_one = [0, 3, 2, 4, 6]
    allow(encryption1).to receive(:number_sampler) do
      mock_key_step_one
    end

    expect(encryption1.create_offset("170987")).to eq([7, 6, 3, 1])
  end
end
