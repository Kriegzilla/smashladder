class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true
  validates :username, presence: true, length: { maximum: 20 }

  belongs_to :character

  def games
    Game.where("player_1_id = ? OR player_2_id = ?", id, id)
  end

  def confirmed_games
    g = Game.where(p2_confirmation: true)
    g.where("player_1_id = ? OR player_2_id = ?", id, id)
  end

  def games_won
    games_won = []
    confirmed_games.each do |game|
      if game.winner == self
        games_won << game
      end
    end
    games_won
  end

  def rivals
    player_games = confirmed_games
    lost_games = []
    rivals = {}
    player_games.each do |game|
      if game.loser == self
        lost_games << game
      end
    end
    lost_games.each do |game|
      if rivals.has_key?(game.winner.username)
        rivals[game.winner.username] += 1
      else
        rivals[game.winner.username] = 1
      end
    end
    if rivals == {}
      rivals = { "n/a" => 0 }
    else
      rivals = rivals.sort{ |a, b| b[1] <=> a[1] }
    end
  end

  def opponents
    player_games = confirmed_games
    opponents = []
    player_games.each do |game|
      if game.player_1 == self && !opponents.include?(game.player_2.username)
        opponents << game.player_2.username
      elsif game.player_2 == self && !opponents.include?(game.player_1.username)
        opponents << game.player_1.username
      end
    end
    opponents
  end

  def wins_against(user)
    player_games = confirmed_games
    wins = 0
    player_games.each do |game|
      if game.loser.username == user
        wins += 1
      end
    end
    wins
  end

  def losses_against(user)
    player_games = confirmed_games
    losses = 0
    player_games.each do |game|
      if game.winner.username == user
        losses += 1
      end
    end
    losses
  end

  def wins_and_losses
    players = opponents
    win_loss = []
    players.each do |user, index|
      wins = wins_against(user)
      losses = losses_against(user)
      win_loss << [user, wins, losses]
    end
    win_loss
  end

  def nemesis
    if rivals == { "n/a" => 0 }
      ["Undefeated!", 0]
    else
      rivals.sort{ |a, b| b[1] <=> a[1] }.first
    end
  end

  def played_with(character)
    played_with_chara = []
    confirmed_games.each do |game|
      if game.player_1 == self
        if game.player_1_character == character
          played_with_chara << game
        end
      elsif game.player_2 == self
        if game.player_2_character == character
          played_with_chara << game
        end
      end
    end
    played_with_chara
  end

  def most_played_characters
    characters = Character.all
    top_4 = {}
    characters.each do |character|
      play_count = played_with(character).length
      if top_4.length < 4
        top_4[character] = play_count
      else
        top_4 = top_4.sort { |a, b| b[1] <=> a[1] }
        if play_count > top_4[3][1]
          top_4.pop
          top_4 << [character, play_count]
        end
        top_4 = top_4.sort { |a, b| b[1] <=> a[1] }
      end
    end
    top_4
  end

  def won_with(character)
    won_with_chara = []
    games_won.each do |game|
      if game.player_1 == self
        if game.player_1_character == character
          won_with_chara << game
        end
      elsif game.player_2 == self
        if game.player_2_character == character
          won_with_chara << game
        end
      end
    end
    won_with_chara
  end

  def best_character
    characters = Character.all
    best_character = Character.find_by(name: "Fox")
    chara_wins = 0
    characters.each do |character|
      if won_with(character).length > chara_wins
        chara_wins = won_with(character).length
        best_character = character
      end
    end
    best_character
  end
end
