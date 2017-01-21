class Department < ApplicationRecord
  has_many :teams
  has_many :objectives
end
