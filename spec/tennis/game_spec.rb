require 'spec_helper'

describe Tennis::Game do
  let(:game) { Tennis::Game.new('player 1', 'player 2') }

  describe '#initialize' do
    it 'builds Team objects' do
      game.teams.each do |team|
        expect(team).to be_a Tennis::Team
      end
    end

    it 'build with the given names' do
      expect(game.teams.map(&:name)).to match_array(['player 1', 'player 2'])
    end
  end

  describe '#point_won_by' do
    it 'increase 1 point to a team' do
      team = game.teams.first
      expect { game.point_won_by(team.name) }.to change { team.point }.from(0).to(1)
    end
  end

  describe '#find_team' do
    it 'find team by name' do
      team = game.send(:find_team, 'player 2')

      expect(team).to be_a Tennis::Team
      expect(team.name).to eq('player 2')
    end
  end

  describe '#score' do
    subject { game.score }

    context 'normal score' do
      it { is_expected.to eq('0-0') }
    end

    context 'deuce'  do
      before(:each) do
        game.teams.each { |team| team.point = 3 }
      end

      it { is_expected.to eq('Deuce') }
    end

    context 'advantage' do
      before(:each) do
        game.teams.first.point = 3
        game.teams.last.point = 4
      end

      it { is_expected.to eq('Advantage player 2') }
    end

    context 'win' do
      before(:each) do
        game.teams.first.point = 2
        game.teams.last.point = 4
      end

      it { is_expected.to eq('Player 2 wins') }
    end
  end

  describe '#deuce?' do
    subject { game.send(:deuce?) }

    context 'all teams have the same point but still < 3' do
      before(:each) do
        game.teams.each { |team| team.point = 2 }
      end

      it { is_expected.to be_falsy }
    end

    context 'all teams have 3 points' do
      before(:each) do
        game.teams.each { |team| team.point = 3 }
      end

      it { is_expected.to be_truthy }
    end

    context 'all teams have the same point which are > 3' do
      before(:each) do
        game.teams.each { |team| team.point = 4 }
      end

      it { is_expected.to be_truthy }
    end

    context 'each team has different points' do
      before(:each) do
        game.teams.each_with_index { |team, index| team.point = index }
      end

      it { is_expected.to be_falsy }
    end
  end

  describe '#advantage?' do
    subject { game.send(:advantage?) }

    context 'one point different after duece' do
      before(:each) do
        game.teams.first.point = 4
        game.teams.last.point = 3
      end

      it { is_expected.to be_truthy }
    end

    context 'one point different before duece' do
      before(:each) do
        game.teams.first.point = 3
        game.teams.last.point = 2
      end

      it { is_expected.to be_falsy }
    end
  end

  describe '#reach_three_points?' do
    subject { game.send(:reach_three_points?) }

    context 'all teams have at least 3 points' do
      before(:each) do
        game.teams.each { |team| team.point = 3 }
      end

      it { is_expected.to be_truthy }
    end

    context 'all teams have < 3 points' do
      before(:each) do
        game.teams.each { |team| team.point = 2 }
      end

      it { is_expected.to be_falsy }
    end
  end

  describe '#leader' do
    before(:each) do
      game.teams.first.point = 4
      game.teams.last.point = 3
    end

    it 'return the team leading the game' do
      expect(game.send(:leader)).to eq(game.teams.first)
    end
  end

  describe '#game_end?' do
    subject { game.send(:game_end?) }

    context 'reach 4 points with 2 points different' do
      before(:each) do
        game.teams.first.point = 4
        game.teams.last.point = 2
      end

      it { is_expected.to be_truthy }
    end

    context 'reach 4 points with 1 points different' do
      before(:each) do
        game.teams.first.point = 5
        game.teams.last.point = 4
      end

      it { is_expected.to be_falsy }
    end

    context '2 points different but teams have not reached 4 points' do
      before(:each) do
        game.teams.first.point = 0
        game.teams.last.point = 2
      end

      it { is_expected.to be_falsy }
    end
  end

  describe '#points_different' do
    before(:each) do
      game.teams.first.point = 4
      game.teams.last.point = 2
    end

    it 'return the team leading the game' do
      expect(game.send(:points_different)).to eq(2)
    end
  end
end
