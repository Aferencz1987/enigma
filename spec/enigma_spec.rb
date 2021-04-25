require './lib/enigma'

RSpec.describe Enigma do

  it 'exists' do
    enigma1 = Enigma.new

    expect(enigma1).to be_instance_of(Enigma)
  end

  it 'can encrypt' do #!!!!!!!!!!!!!!!!!!!fix me
    enigma1 = Enigma.new
    mock_offset = [7, 6, 3, 1]
    allow(enigma1).to receive(:create_offset).and_return(mock_offset)



    expect(enigma1.encrypt("Alex Ferencz", "170987")).to eq("hmlycllxltfe")
  end

  it 'can decrypt' do
    enigma1 = Enigma.new

    expect(enigma1.decrypt(encrypt[:encryption])).to eq("Alex Ferencz")
  end
end
