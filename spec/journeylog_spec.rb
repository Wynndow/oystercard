require 'journeylog'

describe JourneyLog do
  subject(:journeylog) {described_class.new}
  let(:card) {double(:Oystercard)}
  let(:minimum_fare) {Oystercard::MINIMUM_FARE}

  describe 'defaults' do
    it 'is initially not in a journey' do
      expect(journeylog.journey.current_journey[:entry_station]).to eq(nil)
    end

    it 'has an empty journey list' do
      expect(journeylog.journey_history).to eq []
    end
  end

  context 'touch in' do
    it 'remembers the station the journey started from' do
      journeylog.touch_in(:station)
      expect(journeylog.journey.current_journey[:entry_station]).to eq :station
    end
  end

  context 'touch out' do
    it 'clears entry station on touch out' do
      journeylog.touch_in(:station)
      journeylog.touch_out(:station)
      expect(journeylog.journey.current_journey[:entry_station]).to eq nil
    end
  end

  context 'completed journeys' do
    it 'can recall previous journeys' do
      entry_station = double(:station)
      exit_station = double(:station)
      journeylog.touch_in(entry_station)
      journeylog.touch_out(exit_station)
      expect(journeylog.journey_history).to eq [{entry_station: entry_station, exit_station: exit_station}]
    end
  end
end
