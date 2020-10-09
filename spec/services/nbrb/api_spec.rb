require 'rails_helper'

describe 'Nbrb::Api', type: :api do
  subject { Nbrb::Api }

  describe 'currencies rates' do
    describe '#daily_rates' do
      let(:response) { fixture('nbrb/response.xml') }

      it 'returns properly structured hash for each currency rate' do
        savon.expects(:ex_rates_daily).with(message: { on_date: Time.now.to_date }).returns(response)

        expect(subject.daily_rates).to eq(
          {
            'AUD' =>
              {
                cur_quot_name: '1 австралийский доллар',
                cur_scale: '1',
                cur_official_rate: '42.42',
                cur_code: '036',
                cur_abbreviation: 'AUD'
              }
          }
        )
      end
    end
  end

  describe '#call' do
    it 'throws StandardError exception on invalid call' do
      expect { subject.call(:not_exist) }.to raise_exception StandardError
    end

    it 'delegates the call to soap client' do
      sample_operation = subject.client.operations.first

      expect(subject.client).to receive(:call).with(sample_operation, anything)
      subject.call(sample_operation)
    end
  end
end
