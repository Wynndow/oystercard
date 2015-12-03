require 'oystercard'

describe Oystercard do
  let(:minimum_fare) {Journey::MINIMUM_FARE}
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE}
  let(:penalty_fare) {Oystercard::PENALTY_FARE}

  let(:journeylog) {double(set_entry: 0, log_new_journey: 0, fare: minimum_fare)}
  subject(:card) { described_class.new(journeylog: journeylog) }

  let(:station) {double :station}

  describe '#balance' do
    it 'creates a card with a balance' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'tops up the card by a value and returns the balance' do
      expect { card.top_up(1) }.to change { card.balance }.by 1
    end

    it 'will not allow balance to exceed maximum balance' do
      card.top_up(maximum_balance)
      expect{card.top_up(1)}.to raise_error("Maximum balance of £#{maximum_balance} exceeded")
    end
  end

  describe '#touch_in' do

    it 'raises error if insufficent funds' do
      expect{ card.touch_in(station) }.to raise_error "Insufficent funds: top up"
    end

    it 'does not deduct a fare if not needed' do
      card.top_up(minimum_fare)
      expect { card.touch_in(station) }.to change {card.balance }.by 0
    end

    context 'the customer did not touch out last journey' do
      it 'deducts a penalty charge if no touch out' do
        card.top_up(minimum_fare+10)
        card.touch_in(station)
        expect {card.touch_in(station)}.to change { card.balance }.by -penalty_fare
      end
    end

  end

  describe '#touch_out' do
    it 'charges customer when they tap out' do
      card.top_up(minimum_fare)
      card.touch_in(station)
      expect{card.touch_out((station))}.to change{card.balance}.by(-minimum_fare)
    end

    context 'the customer has not touched in' do
      it 'deducts a penalty charge if I fail to touch in' do
        card.top_up(minimum_fare)
        expect { card.touch_out(station) }.to change { card.balance }.by -penalty_fare
      end
    end

  end


end
