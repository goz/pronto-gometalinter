require 'spec_helper'

module Pronto
  describe Gometalinter do
    let(:gometalinter) { Gometalinter.new(patches) }
    let(:patches) { nil }

    describe '#run' do
      subject(:run) { gometalinter.run }

      context 'patches are nil' do
        it { should == [] }
      end

      context 'no patches' do
        let(:patches) { [] }
        it { should == [] }
      end

      context 'patches with a one warning' do
        include_context 'test repo'

        let(:patches) { repo.diff('master') }

        it 'returns correct number of violations' do
          expect(run.count).to eql(1)
        end

        it 'returns expected error message' do
          expect(run.first.msg).to eql('Opening brace should be on a new line')
        end
      end
    end
  end
end
