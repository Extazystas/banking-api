require 'rails_helper'

RSpec.describe Api::V1::CurrenciesController, type: :request do
  let(:requested_day) { Time.parse('2020-10-10') }
  let!(:currency) do
    create(:currency, valid_at: Time.now.to_date, daily_rates: { 'USD' => { value: 3.0 } })
  end

  before { travel_to requested_day }
  after  { travel_back }

  describe 'GET /index' do
    before { get api_v1_currencies_url, params: params }

    let(:params) { {} }

    it 'renders a successful response' do
      expect(response).to be_successful
      expect(JSON.parse(response.body))
        .to include(Api::V1::CurrencySerializer.new(currency).serializable_hash.stringify_keys)
    end

    context 'with day parameter' do
      context 'when currency is found for requested day' do
        let(:params) { { day: requested_day } }

        it do
          expect(response).to be_successful
          expect(JSON.parse(response.body))
            .to include(Api::V1::CurrencySerializer.new(currency).serializable_hash.stringify_keys)
        end
      end

      context 'when currency is not found for requested day' do
        let(:params) { { day: Time.new('2010-01-10') } }

        it do
          expect(response).to be_successful
          expect(JSON.parse(response.body)).to be_blank
        end
      end
    end
  end
end
