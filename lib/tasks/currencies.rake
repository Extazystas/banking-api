namespace :currencies do
  desc 'Fetch and populate in DB currencies for a previous month'
  task generate_for_a_month_before_today: :environment do
    DAYS_TO_IMPORT = 31

    progress_bar =
      ProgressBar.create(
        format:         "%a %b\u{15E7}%i %c/%C %p%% %e",
        progress_mark:  ' ',
        remainder_mark: "\u{FF65}",
        starting_at:    0,
        total:          DAYS_TO_IMPORT + 1)

    log_msg =
      lambda do |msg|
        progress_bar.log(msg)
        File.open(Rails.root.join("log/import_currencies.log"), 'a+') { |f| f.write(msg) }
      end

    prepared_currencies_data =
      (0..DAYS_TO_IMPORT).each_with_object([]) do |day, result|
          date = Time.now.to_date - day.days
          next if Currency.where(valid_at: date).present?

          result << {
            valid_at: date,
            daily_rates: Nbrb::Api.daily_rates(date),
            created_at: Time.now,
            updated_at: Time.now
          }
          progress_bar.increment
      end

    begin
      Currency.insert_all(prepared_currencies_data)
      puts "Import of #{DAYS_TO_IMPORT} currencies successfully finished."
    rescue => e
      puts "Currencies import error: #{e}"
      log_msg.call(e.message)
    end
  end
end
