require 'rails_helper'

RSpec.describe Api::V1::CurrenciesController, type: :request do
  let(:user)          { create(:user) }
  let(:requested_day) { Time.parse('2020-10-10') }
  let!(:currency) do
    create(:currency, valid_at: Time.now.to_date, daily_rates: { 'USD' => { value: 3.0 } })
  end

  before { travel_to requested_day }
  after  { travel_back }

  describe 'GET /index' do
    before { get api_v1_currencies_url, params: params, headers: headers }
    let(:params) { {} }
    let(:headers) { {} }

    context 'when not authorized' do
      it 'renders a successful response' do
        expect(response).not_to be_successful
        expect(response.status).to eq 401
      end
    end

    context 'when authorized' do
      let(:headers) do
        { 'CONTENT_TYPE' => 'application/json' }.merge(jwt_token_for(user))
      end

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
end
