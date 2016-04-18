
module Mars
  class InvalidRoverCommandError < StandardError; end
  class Rover
    def self.parse_command(input)
      match = %r{
        (?<x_position>\d+)
        \s+
        (?<y_position>\d+)
        \s
        (?<orientation>[NSEW])
        \n
        (?<actions>[LRM]+)
      }x.match(input) or raise InvalidRoverCommandError.new 'The input "%s" is invalid.' % input
      command = Hash[ match.names.map(&:to_sym).zip( match.captures ) ]

      # Also parse the actions:
      command[:actions] = command[:actions].split(//)
      command
    end

    attr_reader :actions
    attr_accessor :x_position, :y_position, :orientation
    def initialize(x_position:, y_position:, orientation:, actions:)
      @x_position = x_position
      @y_position = y_position
      @orientation = orientation
      @actions = actions
    end

    def position
      [
        x_position,
        y_position,
        orientation
      ].join(' ')
    end

    def execute!
      actions.map do |action|
        case action
        when 'L', 'R'
          rotate(action)
        when 'M'
          move
        end
      end
    end

    private
    def move
    end

    def rotate(direction)
    end
  end
end
