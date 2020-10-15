module Api
  module V1
    class CurrenciesController < ::Api::BaseController
      def index
        requested_day = params[:day]
        @datetime     = requested_day.present? ? Time.parse(requested_day) : Time.now
        currency      = fetch_currency || create_currency

        if currency.present?
          render json: currency, each_serializer: Api::V1::CurrencySerializer, status: :ok
        else
          render json: nil
        end
      end

      private

      def fetch_currency
        Currency.find_by(valid_at: @datetime.to_date)
      end

      def create_currency
        currency = Currency.create(valid_at: @datetime, daily_rates: Nbrb::Api.daily_rates(@datetime))
        currency.valid? ? currency : nil
      end
    end
  end
end
