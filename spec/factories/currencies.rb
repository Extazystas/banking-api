FactoryBot.define do
  factory :currency do
    daily_rates do
      { 'AUD' =>
        { cur_quot_name: '1 Австралийский доллар',
          cur_scale: '1',
          cur_official_rate: '1.8710',
          cur_code: '036',
          cur_abbreviation: 'AUD' },
        'BGN' =>
        { cur_quot_name: '1 Болгарский лев',
          cur_scale: '1',
          cur_official_rate: '1.5712',
          cur_code: '975',
          cur_abbreviation: 'BGN' },
        'USD' =>
        { cur_quot_name: '1 Доллар США',
          cur_scale: '1',
          cur_official_rate: '2.6130',
          cur_code: '840',
          cur_abbreviation: 'USD' },
        'EUR' =>
        { cur_quot_name: '1 Евро',
          cur_scale: '1',
          cur_official_rate: '3.0743',
          cur_code: '978',
          cur_abbreviation: 'EUR' },
        'CAD' =>
        { cur_quot_name: '1 Канадский доллар',
          cur_scale: '1',
          cur_official_rate: '1.9741',
          cur_code: '124',
          cur_abbreviation: 'CAD' } }
    end
    valid_at { Faker::Date.backward(days: 90) }
  end
end
