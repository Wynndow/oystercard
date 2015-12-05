require 'journey'

describe Journey do
subject(:journey) {described_class.new}

let(:entry_station) {double(:entry_station)}
let(:exit_station) {double(:exit_station)}

describe '#current_journey' do
  context 'by default' do
    it 'returns a nil value' do
      expect(journey.current_journey[:entry_station]).to eq(nil)
    end
  end
  context 'when #set_entry applied to a station' do
    it 'should have an :entry_station key with the station as its value' do
      journey.set_entry(entry_station)
      expect(journey.current_journey[:entry_station]).to eq(entry_station)
    end
  end
  context 'when #set_exit applied to a station' do
    it 'should have an :exit_station key with the station as its value' do
      journey.set_exit(exit_station)
      expect(journey.current_journey[:exit_station]).to eq(exit_station)
    end
  end

end

describe '#fare' do
  before(:example) do
    journey.set_entry(entry_station)
    journey.set_exit(exit_station)
  end
  it 'calculates a fare for zone 1 to zone 1' do
    update_zones(1,1)
    expect(subject.fare).to eq Journey::MINIMUM_FARE
  end

  it 'calculates a fare for zone 1 to zone 2' do
    update_zones(1,2)
    expect(subject.fare).to eq Journey::MINIMUM_FARE + 1
  end

  it 'calculates a fare for zone 6 to zone 5' do
    update_zones(6,5)
    expect(subject.fare).to eq Journey::MINIMUM_FARE + 1
  end

  it 'calculates a fare for zone 6 to zone 1' do
    update_zones(6,2)
    expect(subject.fare).to eq Journey::MINIMUM_FARE + 4
  end

end

def update_zones(entry_zone, exit_zone)
    allow(entry_station).to receive(:zone).and_return(entry_zone)
    allow(exit_station).to receive(:zone).and_return(exit_zone)
  end

end
