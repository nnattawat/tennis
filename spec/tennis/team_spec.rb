require 'spec_helper'

describe Tennis::Team do
  let(:team) { Tennis::Team.new(name: 'player 1') }

  describe '#initialize' do
    it 'initializes with point 0' do
      expect(team.name).to eq('player 1')
      expect(team.point).to eq(0)
    end
  end

  describe '#win_a_point' do
    it 'adds point by one' do
      expect { team.win_a_point }.to change { team.point }.from(0).to(1)
    end
  end

  describe '#score' do
    subject { team.score }

    context '0 point' do
      it { is_expected.to eq('0') }
    end

    context '1 points' do
      let(:team) { Tennis::Team.new(name: 'player 1', point: 1) }
      it { is_expected.to eq('15') }
    end

    context '2 points' do
      let(:team) { Tennis::Team.new(name: 'player 1', point: 2) }
      it { is_expected.to eq('30') }
    end

    context '3 points' do
      let(:team) { Tennis::Team.new(name: 'player 1', point: 3) }
      it { is_expected.to eq('40') }
    end

    context '> 3 points' do
      let(:team) { Tennis::Team.new(name: 'player 1', point: 4) }
      it { is_expected.to be_nil }
    end
  end
end
