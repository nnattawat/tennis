require 'spec_helper'

describe Tennis do
  it 'Example game' do
    game = Tennis::Game.new('player 1', 'player 2')
    game.point_won_by('player 1')
    game.point_won_by('player 2')
    expect(game.score).to eq('15-15')

    game.point_won_by('player 1')
    game.point_won_by('player 1')
    expect(game.score).to eq('40-15')

    game.point_won_by('player 2')
    game.point_won_by('player 2')
    expect(game.score).to eq('Deuce')

    game.point_won_by('player 1')
    expect(game.score).to eq('Advantage player 1')

    game.point_won_by('player 1')
    expect(game.score).to eq('Player 1 wins')
  end
end
