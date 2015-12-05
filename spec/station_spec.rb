require 'station'

describe Station do

let(:station) {described_class.new(:station, 1)}

describe '#name' do
  it 'gives name of station' do
    expect(station.name).to eq :station
  end
end

describe '#zone' do
  it 'gives zone number of station' do
    expect(station.zone).to eq 1
  end
end


end
