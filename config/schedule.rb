# Bank currencies are set daily at 1 pm, allow 5 min for a delay
every 1.day, at: '1:05 pm' do
  Currency.create(valid_at: Time.now.to_date, daily_rates: Nbrb::Api.daily_rates)
  # NOTE: error notification if currency is invalid can be triggered here
end
