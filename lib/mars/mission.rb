
require 'active_support/core_ext/array'

module Mars
  class Mission
    def self.dispatch!(file)
      # The first line of input is the upper-right coordinates of the plateau,
      # the lower-left coordinates are assumed to be 0,0.
      plateau_args = Mars::Plateau.parse_command( file.each_line.first.chomp )

      # Each rover has two lines of input:
      rover_args = file.each_line.to_a.in_groups_of(2, false).map do |rover_command|
        Mars::Rover.parse_command( rover_command.join.chomp )
      end

      self.new(plateau_args: plateau_args, rover_args: rover_args).execute!
    end

    attr_reader :plateau, :rovers
    def initialize(plateau_args:, rover_args:)
      @plateau = Mars::Plateau.new(plateau_args)
      @rovers = rover_args.map{ |args| Mars::Rover.new(args) }
    end

    def execute!
      rovers.map &:execute!
    end

  end
end
