require 'spec_helper'

describe Mars::Plateau do
  describe 'instantiation' do
    before do
      @valid_args = {width: 10, height: 10}
    end
    context 'initialization' do
      before do
        @plateau = described_class.new(@valid_args)
      end
      it 'sets width' do
        expect(@plateau.width).to eq @valid_args[:width]
      end
      it 'sets height' do
        expect(@plateau.height).to eq @valid_args[:height]
      end
    end
    context 'validations' do
      it 'requires width' do
        expect{Mars::Plateau.new(@valid_args.except(:width))}.to raise_error(ArgumentError, /missing keyword\: width/)
      end
      it 'requires height' do
        expect{Mars::Plateau.new(@valid_args.except(:height))}.to raise_error(ArgumentError, /missing keyword\: height/)
      end
    end
  end

  describe '.parse_command(dimensions)' do
    context 'when the dimensions' do
      context 'are valid' do
        before do
          @input = '5 5'
        end
        it 'returns a hash' do
          expect(described_class.parse_command(@input)).to be_a Hash
        end
        context 'the hash returned' do
          let(:subject) { described_class.parse_command(@input) }
          it { should have_key :width }
          it { should have_key :height }
        end
      end
      context 'are invalid' do
        before do
          @input = 'hello world!'
        end
        it 'raises an exception' do
          expect{described_class.parse_command(@input)}.to raise_error Mars::InvalidPlateauCommandError
        end
      end
    end
  end
end
