class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.json :daily_rates, null: false, default: '{}'
      t.datetime :valid_at, null: false

      t.timestamps
    end
  end
end
