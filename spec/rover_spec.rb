require 'spec_helper'

describe Mars::Rover do
  describe '.parse_command(input)' do
    context 'when the input' do
      context 'is valid' do
        before do
          @input = "0 3 E\nLMRM"
          @result = described_class.parse_command(@input)
        end
        it 'returns valid rover arguments' do
          expect(@result).to be_a Hash
          expect{described_class.new(@result)}.not_to raise_error
        end
      end
      context 'is invalid' do
        before do
          @input = 'some invalid input'
        end
        it 'raises an exception' do
          expect{described_class.parse_command(@input)}.to raise_error Mars::InvalidRoverCommandError
        end
      end
    end
  end

  describe '#position' do
    before do
      @rover = described_class.new(
        x_position: 0,
        y_position: 0,
        orientation: 'N',
        actions: [ ]
      )
    end
    it 'returns the current position of the rover' do
      expect(@rover.position).to eq '0 0 N'
    end
  end

  describe '#rotate' do
    before do
      @rover_args = {
        x_position: 0,
        y_position: 0,
        orientation: 'N',
        actions: [ ]
      }
    end
    context 'when rotating left' do
      [['N','W'],['W','S'],['S','E'],['E','N']].each do |pair|
        context 'and the original orientation is %s' % pair.first do
          before do
            @rover = described_class.new(@rover_args.merge(orientation: pair.first))
            expect(@rover.orientation).to eq pair.first
            @rover.rotate('L')
          end
          it 'changes orientation to %s' % pair.last do
            expect(@rover.orientation).to eq pair.last
          end
        end
      end
    end
    context 'when rotating right' do
      [['N','E'],['E','S'],['S','W'],['W','N']].each do |pair|
        context 'and the original orientation is %s' % pair.first do
          before do
            @rover = described_class.new(@rover_args.merge(orientation: pair.first))
            expect(@rover.orientation).to eq pair.first
            @rover.rotate('R')
          end
          it 'changes orientation to %s' % pair.last do
            expect(@rover.orientation).to eq pair.last
          end
        end
      end
    end
  end

  describe '#move' do
    [
      {orientation: 'N', x_delta: 0, y_delta: 1},
      {orientation: 'E', x_delta: 1, y_delta: 0},
      {orientation: 'S', x_delta: 0, y_delta: -1},
      {orientation: 'W', x_delta: -1, y_delta: 0},
    ].each do |change|
      context 'when the orientation is %s' % change[:orientation] do
        before do
          @rover = described_class.new(
            x_position: 10,
            y_position: 10,
            orientation: change[:orientation],
            actions: [ ]
          )
          @original_x_position = @rover.x_position
          @original_y_position = @rover.y_position
          @rover.move
        end
        it 'moving changes its X position by %d' % change[:x_delta] do
          expect(@rover.x_position).to eq(@original_x_position + change[:x_delta])
        end
        it 'moving changes its Y position by %d' % change[:y_delta] do
          expect(@rover.y_position).to eq(@original_y_position + change[:y_delta])
        end
      end
    end
  end

  describe '#execute!' do
    context 'when there are' do
      context 'no actions' do
        before do
          @rover = described_class.new(
            x_position: 0,
            y_position: 0,
            orientation: 'N',
            actions: [ ]
          )
          @original_position = @rover.position
          @rover.execute!
        end
        it 'returns its original position' do
          expect(@rover.position).to eq @original_position
        end
      end
      context 'some actions' do
        before do
          @rover = described_class.new(
            x_position: 5,
            y_position: 3,
            orientation: 'N',
            actions: ['L','M']
          )
          @rover.execute!
        end
        it 'returns its new position' do
          expect(@rover.position).to eq '4 3 W'
        end
      end
    end
  end
end
