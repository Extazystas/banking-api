module Api
  module V1
    class CurrenciesController < ::Api::BaseController
      def index
        requested_day = params[:day]

        currencies = if requested_day.present?
          Array(Currency.where(valid_at: Time.parse(requested_day).to_date))
        else
          Currency.all
        end

        render json: currencies, each_serializer: Api::V1::CurrencySerializer, status: :ok
      end
    end
  end
end
