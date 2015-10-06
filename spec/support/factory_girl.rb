require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    sequence(:username) { |n| "user#{n}"}
    crew_tag 'TSM'
  end

  factory :stage do
    name "Final Destination"
    legality "Neutral"
  end

  factory :game do
    player_1_id user
    player_2_id user
    player_1_character "Fox"
    player_2_character "Falco"
    player_1_stock 2
    player_2_stock 0
    stage
  end

end
