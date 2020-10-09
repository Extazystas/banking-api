module Nbrb
  module Currencies
    NESTED_PATH = %w[
      Body
      ExRatesDailyResponse
      ExRatesDailyResult
      diffgram
      NewDataSet
      DailyExRatesOnDate
    ].freeze

    def daily_rates(date = Date.today)
      response = call(:ex_rates_daily, message: { on_date: date.to_date })
      rates    = response.find(*NESTED_PATH)

      raise Nbrb::Api::GeneralError, 'No exchange rates found for operation ex_rates_daily' if rates.blank?

      [rates].flatten.each_with_object({}) do |rate, result|
        result[rate[:cur_abbreviation]] = cleanup_rate_row(rate)
      end
    end

    def cleanup_rate_row(row)
      row.each do |key, _value|
        row.delete(key) if key.to_s[0] == '@'
      end
      row
    end
  end
end
