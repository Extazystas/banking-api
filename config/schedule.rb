# Bank currencies are set at 1 pm, allow 5 min for a delay
every 1.day, at: '1:05 pm' do
  # TODO: Execute background job for fetching and populating currencies to DB
end
