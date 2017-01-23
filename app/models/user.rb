class User < ApplicationRecord

  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users
  has_many :objectives

  has_secure_password

  searchable do
    text :first_name
    text :last_name
    text :email
  end
end
