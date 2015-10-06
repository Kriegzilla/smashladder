class Stage < ActiveRecord::Base
  has_many :games

  validates :name, presence: true, uniqueness: true
  validates :legality, presence: true

end
