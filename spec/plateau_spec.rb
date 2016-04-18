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
end
