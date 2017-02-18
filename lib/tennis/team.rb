module Tennis
  class Team
    attr_accessor :name, :point

    SCORE_MAPPING = {
      "0" => "0",
      "1" => "15",
      "2" => "30",
      "3" => "40"
    }.freeze

    def initialize(name:, point: 0)
      @name = name
      @point = point
    end

    def win_a_point
      @point += 1
    end

    def score
      SCORE_MAPPING[@point.to_s]
    end
  end
end
