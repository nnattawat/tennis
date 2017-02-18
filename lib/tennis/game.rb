module Tennis
  class Game
    attr_reader :teams

    def initialize(*team_names)
      @teams = team_names.map do |team_name|
        Team.new(name: team_name)
      end
    end

    def point_won_by(team_name)
      team = find_team(team_name)
      team.win_a_point
    end

    def score
      return "#{leader.name.capitalize} wins" if game_end?
      return 'Deuce' if deuce?
      return "Advantage #{leader.name}" if advantage?

      @teams.map(&:score).join('-')
    end

    private

    def find_team(team_name)
      @teams.find { |team| team.name == team_name }
    end

    def deuce?
      reach_three_points? && @teams.map(&:point).uniq.size == 1
    end

    def advantage?
      reach_three_points? && points_different == 1
    end

    def reach_three_points?
      @teams.all? { |team| team.point >= 3 }
    end

    def leader
      @teams.sort_by { |team| team.point }.last
    end

    def game_end?
      points_different >=2 && @teams.any? { |team| team.point >= 4 }
    end

    def points_different
      # assuming that there are only two teams
      (@teams.first.point - @teams.last.point).abs
    end
  end
end
