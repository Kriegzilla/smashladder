require 'rails_helper'

RSpec.describe Stage, type: :model do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:type) }

  it { should have_many(:games) }

end
