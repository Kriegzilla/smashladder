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
  before do
    FactoryGirl.create(:stage)
    Character.create(name: "Fox", icon: "/ssbm_icons/fox_icon.jpg")
    Character.create(name: "Falco", icon: "/ssbm_icons/falco_icon.jpg")
  end

  scenario 'user tries to submit while logged out' do
    visit new_game_path

    expect(page).to have_content('need to sign in or sign up before continuing')
  end

  scenario 'user submits a game' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    login(user)

    click_on "Add a Game"
    select "#{user2.username}", from: "Player 2"
    select "Fox", from: "Your Character"
    select "Falco", from: "Player 2's Character"
    select "4", from: "Your Remaining Stock"
    select "0", from: "P2 Remaining Stock"
    select "Final Destination", from: "Stage"
    click_on "Submit"

    expect(page).to have_content("Game saved!")
  end

  scenario 'user submits an incomplete form' do
    user = FactoryGirl.create(:user)
    login(user)

    click_on "Add a Game"
    click_on "Submit"

    expect(page).to have_content("Game must have a winner and loser!")
  end
end
