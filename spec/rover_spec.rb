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
end
