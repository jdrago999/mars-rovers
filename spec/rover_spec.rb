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

  describe '#execute!' do
    context 'when there are' do
      context 'no actions' do
        it 'returns its original position'
      end
      context 'some actions' do
        it 'returns its new position'
      end
    end
  end
end
