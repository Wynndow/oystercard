require 'oystercard'

describe Oystercard do
  let(:minimum_fare) {Journey::MINIMUM_FARE}
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE}
  let(:penalty_fare) {Oystercard::PENALTY_FARE}

  let(:journeylog) {double(set_entry: 0, set_exit: 0, log_new_journey: 0, reset_journey: 0, fare: minimum_fare)}
  subject(:card) { described_class.new(journeylog: journeylog) }

  let(:station) {double :station}

  describe '#balance' do
    it 'by default is zero' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'changes balance by given amount' do
      expect { card.top_up(1) }.to change { card.balance }.by 1
    end

    context 'when at maximum balance'do
    it 'raises an error' do
      card.top_up(maximum_balance)
      expect{card.top_up(1)}.to raise_error("Maximum balance of £#{maximum_balance} exceeded")
    end
    end
  end

  describe '#touch_in' do

    context 'when below minimum balance' do

    it 'raises an error' do
      expect{ card.touch_in(station) }.to raise_error "Insufficent funds: top up"
    end

    end

    context 'when customer does not miss touch out' do

    it 'does not deduct a fare' do
      card.top_up(minimum_fare)
      expect { card.touch_in(station) }.to change {card.balance }.by 0
    end

    end

    context 'when customer misses touch out' do
      it 'deducts penalty charge' do
        card.top_up(minimum_fare+10)
        card.touch_in(station)
        expect {card.touch_in(station)}.to change { card.balance }.by -penalty_fare
      end
    end

  end

  describe '#touch_out' do
    context 'when customer does not miss touch in' do
    it 'charges fare' do
      card.top_up(minimum_fare)
      card.touch_in(station)
      expect{card.touch_out((station))}.to change{card.balance}.by(-minimum_fare)
    end
    end

    context 'when customer misses touch in' do
      it 'deducts penalty charge' do
        card.top_up(minimum_fare)
        expect { card.touch_out(station) }.to change { card.balance }.by -penalty_fare
      end
    end

  end


end
