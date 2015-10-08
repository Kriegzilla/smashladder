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
    fd = FactoryGirl.create(:stage)
    fox = Character.create(name: "Fox", icon: "/ssbm_icons/fox_icon.jpg")
    falco = Character.create(name: "Falco", icon: "/ssbm_icons/falco_icon.jpg")
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    login(user)
    Game.create(player_1_id: user2.id,
                player_2_id: user.id,
                player_1_character_id: fox.id,
                player_2_character_id: falco.id,
                player_1_stock: 4,
                player_2_stock: 0,
                stage: fd,
                p2_confirmation: false,
                )
    click_on "Your Pending Games"
  end

  scenario 'user approves a game' do
    expect(page).to have_content("#{Game.first.player_1.username} (W)")
    expect(page).to have_content("#{Game.first.player_2.username} (L)")
    expect(page).to have_content("Details")
    click_on "Approve this!"

    expect(page).to have_content("Game Approved!")
  end

  scenario 'user has no games to approve' do
    click_on "Approve this!"
    click_on "Your Pending Games"
    expect(page).to have_content("No games are pending! Go play more!")
  end
end
