require 'rails_helper'

feature 'user deletes a game', %{
  As an authenticated user
  I want to delete a pending game with incorrect data
  So that loser nerds don't ruin my reputation
  Acceptance Criteria
    [x] I must be authenticated to delete a pending game
    [x] I must be able to delete the game
    [x] I must be brought to the leaderboard page after deletion
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

  xscenario 'user deletes a game' do
    expect(page).to have_content("#{Game.first.player_1.username} (W)")
    expect(page).to have_content("#{Game.first.player_2.username} (L)")
    expect(page).to have_content("Details")
    click_on "Delete this?"

    expect(page).to have_content("Game deleted successfully!")
    expect(page).to have_content("WHO'S THE BEST???")
  end

  scenario 'user cannot delete a confirmed game' do
    click_on "Approve this!"
    visit games_path(Game.last)

    expect(page).to_not have_content "Delete this?"
  end
end
