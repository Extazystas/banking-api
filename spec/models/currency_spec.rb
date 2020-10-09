require 'rails_helper'

RSpec.describe Currency, type: :model do
  subject { build(:currency) }

  it { expect(subject).to be_valid }
end
