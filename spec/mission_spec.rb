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
end
