require 'spec_helper'

describe Mars::Mission do
  describe '.dispatch!(commands)' do
    context 'when the commands' do
      context 'are valid' do
        before do
          @file = File.open('spec/fixtures/input.txt')
        end
        it 'initializes and calls execute!' do
          expect_any_instance_of(described_class).to receive(:execute!)
          described_class.dispatch!(@file)
        end
      end
      context 'are invalid' do
        before do
          @file = File.open('spec/fixtures/input.txt')
        end
        context 'because the' do
          context 'plateau data cannot be parsed' do
            before do
              expect(Mars::Plateau).to receive(:parse_command) do
                raise Mars::InvalidPlateauCommandError.new 'test error '
              end
            end
            it 'raises an error' do
              expect{described_class.dispatch!(@file)}.to raise_error Mars::InvalidPlateauCommandError
            end
          end
          context 'rover commands cannot be parsed' do
            before do
              expect(Mars::Rover).to receive(:parse_command) do
                raise Mars::InvalidRoverCommandError.new 'test error '
              end
            end
            it 'raises an error' do
              expect{described_class.dispatch!(@file)}.to raise_error Mars::InvalidRoverCommandError
            end
          end
        end
      end
    end
  end
  describe '#execute!' do
    before do
      @plateau_args = {
        width: 5,
        height: 5
      }
      @rover_args = [
        {
          x_position: 0,
          y_position: 1,
          orientation: 'N',
          actions: []
        },
        {
          x_position: 1,
          y_position: 2,
          orientation: 'S',
          actions: []
        }
      ]
    end
    context 'when there are' do
      context 'no rovers' do
        before do
          @mission = described_class.new(
            plateau_args: @plateau_args,
            rover_args: [ ]
          )
        end
        it 'returns an empty array' do
          expect(@mission.execute!).to be_empty
        end
      end
      context 'some rovers' do
        before do
          @fake_rover = double('rover')
          expect(@fake_rover).to receive(:execute!){ 'test-result' }
          @rover_args.shift
          expect(Mars::Rover).to receive(:new).with(@rover_args.first){ @fake_rover }
          @mission = described_class.new(
            plateau_args: @plateau_args,
            rover_args: @rover_args
          )
        end
        it 'calls execute! on all rovers' do
          result = @mission.execute!
          expect(result).to eq ['test-result']
        end
      end
    end
  end
end
