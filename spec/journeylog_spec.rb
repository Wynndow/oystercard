require 'journeylog'

describe JourneyLog do
  subject(:journeylog) {described_class.new}
  let(:card) {double(:Oystercard)}
  let(:minimum_fare) {Oystercard::MINIMUM_FARE}

  describe 'default' do

    it 'has an empty journey list' do
      expect(journeylog.journey_history).to eq []
    end
  end

  context 'touch out' do
    it 'clears entry station on touch out' do
      journeylog.set_entry(:station)
      journeylog.log_new_journey
      expect(journeylog.journey.current_journey[:entry_station]).to eq nil
    end
  end

  context 'completed journeys' do
    it 'can recall previous journeys' do
      entry_station = double(:station)
      exit_station = double(:station)
      journeylog.set_entry(entry_station)
      journeylog.set_exit(exit_station)
      journeylog.log_new_journey
      expect(journeylog.journey_history).to eq [{entry_station: entry_station, exit_station: exit_station}]
    end
  end
end
