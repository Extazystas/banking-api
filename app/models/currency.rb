class Currency < ApplicationRecord
  validates :daily_rates, :valid_at, presence: true
end
