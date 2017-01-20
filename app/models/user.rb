class User < ApplicationRecord
  has_many :team_users, dependent: :destory
  has_many :teams, through: :team_users
  has_many :objectives
end
