class Team < ApplicationRecord
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  has_many :objectives
  has_many :meetings
  
  belongs_to :department

  searchable do
    text :name
  end
end
