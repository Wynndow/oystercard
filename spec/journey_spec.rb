require 'journey'

describe Journey do
subject(:journey) {described_class.new}

let(:station) {double(:station)}


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

end
