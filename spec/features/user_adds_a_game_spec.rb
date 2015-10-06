require 'rails_helper'

feature 'user adds a game', %{
  As an authenticated user
  I want to add a completed game
  So that I can keep track of who I've played and the results
  Acceptance Criteria
    [x] I must be authenticated to post new game
    [x] I must provide a second player for the game
    [x] I must provide characters for both players
    [x] I must provide the stock of both players
    [x] I must see an error if I submit an incorrect form
    [x] I must be brought to the game's details page after submission
} do
  before { FactoryGirl.create(:stage) }

  scenario 'user submits a game' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    login(user)

    click_on "Add a Game"
    select "#{user2.username}", from: "Player 2"
    select "Fox", from: "Your Character"
    select "Falco", from: "Player 2's Character"
    find('#game_player_1_stock_4').click
    find('#game_player_2_stock_0').click
    select "Final Destination", from: "Stage"
    click_on "Submit"

  end
end
