class Team < ApplicationRecord
  has_many :team_users, dependent: :destory
  has_many :users, through: :team_users 
end
