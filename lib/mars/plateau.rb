
module Mars
  class InvalidPlateauCommandError < StandardError; end
  class Plateau
    def self.parse_command(input)
      match = /^(?<width>\d+)\s(?<height>\d+)$/.match(input) or raise InvalidPlateauCommandError.new 'The command "%s" is invalid' % input
      command = Hash[ match.names.map(&:to_sym).zip( match.captures ) ]
      command
    end

    attr_reader :width, :height
    def initialize(width:, height:)
      @width = width
      @height = height
    end
  end
end
