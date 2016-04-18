
module Mars
  class InvalidRoverCommandError < StandardError; end
  class Rover
    def self.parse_command(input)
      match = %r{^
        (?<x_position>\d+)
        \s+
        (?<y_position>\d+)
        \s+
        (?<orientation>[NESW])
        \n
        (?<actions>[LRM]+)
        \n*
      $}x.match(input) or raise InvalidRoverCommandError.new 'The input "%s" is invalid.' % input
      command = Hash[ match.names.map(&:to_sym).zip( match.captures ) ]

      # Also parse the actions:
      command[:actions] = command[:actions].split(//)
      command
    end

    attr_reader :actions
    attr_accessor :x_position, :y_position, :orientation, :compass
    def initialize(x_position:, y_position:, orientation:, actions:)
      self.x_position = x_position.to_i
      self.y_position = y_position.to_i
      self.orientation = orientation
      init_compass
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
      actions.each do |action|
        case action
        when 'L', 'R'
          rotate(action)
        when 'M'
          move
        end
      end
      position
    end

    def rotate(direction)
      case direction
      when 'R'
        compass.push( @compass.shift )
      when 'L'
        compass.unshift( @compass.pop )
      end
      self.orientation = compass.first
    end

    def move
      case orientation
      when 'N'
        self.y_position += 1
      when 'E'
        self.x_position += 1
      when 'S'
        self.y_position += -1
      when 'W'
        self.x_position += -1
      end
    end

    private

    def init_compass
      self.compass = %w(N E S W).to_a
      wanted_orientation = orientation
      until compass.first == wanted_orientation do
        rotate('L')
      end
    end
  end
end
