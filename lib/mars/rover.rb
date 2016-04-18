
module Mars
  class InvalidRoverCommandError < StandardError; end
  class Rover
    def self.parse_command(input)
      match = %r{
        (?<x_position>\d+)
        \s+
        (?<y_position>\d+)
        \s
        (?<orientation>\d+)
        \n
        (?<movements>[LRM]+)
      }x.match(input) or raise InvalidRoverCommandError.new 'The input "%s" is invalid.' % input
      command = Hash[ match.names.map(&:to_sym).zip( match.captures ) ]

      # Also parse the movements:
      command[:movements] = command[:movements].split(//)
      command
    end
  end
end
