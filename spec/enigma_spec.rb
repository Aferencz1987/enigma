require './lib/enigma'
require 'time'

RSpec.describe Enigma do

  it 'exists' do
    enigma1 = Enigma.new

    expect(enigma1).to be_instance_of(Enigma)
  end

  it 'can sample numbers' do
    enigma1 = Enigma.new

    expect(enigma1.number_sampler.count).to eq(5)
  end

  it 'can generate key' do
    enigma1 = Enigma.new
    mock_key_step_one = [0, 3, 2, 4, 6]
    allow(enigma1).to receive(:number_sampler) do
      mock_key_step_one
    end

    expect(enigma1.key_generator).to eq([0, 3, 2, 4, 6])
  end

  it 'can create offset' do
    enigma1 = Enigma.new
    mock_key_step_one = [0, 3, 2, 4, 6]
    allow(enigma1).to receive(:number_sampler) do
      mock_key_step_one
    end

    expect(enigma1.create_offset("03246")).to eq([10, 7, 1, 20])
    expect(enigma1.create_offset("03246", "170987")).to eq([7, 6, 3, 1])
  end

  it 'can encrypt' do
    enigma1 = Enigma.new
    mock_key_step_one = [1, 2, 1, 2, 1]
    allow(enigma1).to receive(:number_sampler) do
      mock_key_step_one
    end

    expect(enigma1.encrypt("Alex Ferencz!?")).to eq({:date=>Time.now.strftime('%d%m%y'),
                                                     :encryption=>"thussbumxjsu!?",
                                                     :key=>"12121"
                                                    })
    expect(enigma1.encrypt("Alex Ferencz!?", "03246")).to eq({:date=>Time.now.strftime('%d%m%y'),
                                                              :encryption=>"ksfqjmfkouds!?",
                                                              :key=>"03246"
                                                            })
    expect(enigma1.encrypt("Alex Ferencz!?", "03246", "170987")).to eq({:date=>"170987",
                                                                        :encryption=>"hrhyglhsltf !?",
                                                                        :key=>"03246"
                                                                      })
  end

  it 'can decrypt' do
    enigma1 = Enigma.new
    mock_key_step_one = [0, 3, 2, 4, 6]
    allow(enigma1).to receive(:number_sampler) do
      mock_key_step_one
    end

    expect(enigma1.decrypt("ksfqjmfkouds!?", "03246")).to eq({:date=>Time.now.strftime('%d%m%y'),
                                                              :decryption=>"alex ferencz!?",
                                                              :key=>"03246"
                                                            })
    expect(enigma1.decrypt("hrhyglhsltf !?", "03246", "170987")).to eq({:date=>"170987",
                                                                        :decryption=>"alex ferencz!?",
                                                                        :key=>"03246"
                                                                        })
  end
end
