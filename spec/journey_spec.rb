require 'journey'

describe Journey do
subject(:journey) {described_class.new}

let(:entry_station) {double(:entry_station, zone: 1)}
let(:exit_station) {double(:exit_station, zone: 3)}


describe 'defaults' do
  it 'is initially not in a journey' do
    expect(journey.current_journey[:entry_station]).to eq(nil)
  end
end

context '#set_entry' do
  it 'remembers the station the journey started from' do
    journey.set_entry(:station)
    expect(journey.current_journey[:entry_station]).to eq :station
  end
end

context '#fare' do
  it 'calculates correct fare based on moving across two zones' do
    journey.set_entry(entry_station)
    journey.set_exit(exit_station)
    expect(journey.fare).to eq Journey::MINIMUM_FARE + 2
  end
  it 'calculates correct fare based on moving within a zone' do
    journey.set_entry(entry_station)
    journey.set_exit(entry_station)
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end
end

end
