require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }

  it { should validate_length_of(:username).is_at_most(20) }

  it { should have_valid(:username).when("FlyAmanita") }
  it { should_not have_valid(:username).when(nil, "") }

  it { should have_valid(:email).when("leffen@teamsolomid.com") }
  it { should_not have_valid(:email).when(nil, "") }

end
