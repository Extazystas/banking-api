module Api
  module V1
    class CurrencySerializer < ActiveModel::Serializer
      attributes :id, :valid_at, :daily_rates

      def valid_at
        object.valid_at.strftime('%Y-%m-%d')
      end
    end
  end
end
