require 'journeylog'

describe JourneyLog do
  subject(:journeylog) {described_class.new(journey: double(:journey, current_journey: {}))}

  describe '#journey_history' do
    context 'when no journeys have been logged' do
      it 'is empty' do
        expect(journeylog.journey_history).to eq []
      end
    end
    context 'when a journey has been logged' do
      before(:example){journeylog.log_new_journey}

      it 'stores the current_journey' do
        expect(journeylog.journey_history).to eq [{}]
      end
      it 'cannot be ammended' do
        journeylog.journey_history.pop
        expect(journeylog.journey_history).to eq [{}]
      end
    end
  end
end
