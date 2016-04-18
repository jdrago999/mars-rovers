
require 'active_support/core_ext/array'

module Mars
  class Mission
    def self.dispatch(file)
      # Naive parsing:

      # The first line of input is the upper-right coordinates of the plateau,
      # the lower-left coordinates are assumed to be 0,0.
      plateau_args = Mars::Plateau.parse_command( file.lines.first.chomp )

      # Each rover has two lines of input:
      rover_args = file.lines.to_a.in_groups_of(2, false).map do |rover_command|
        Mars::Rover.parse_command( rover_command )
      end
    end

    attr_reader :plateau, :rovers
    def initialize(plateau_args, rover_args)
      @plateau = Mars::Plateau.new(plateau_args)
    end

  end
end
