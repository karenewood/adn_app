class EquipeType < ActiveRecord::Base
  attr_accessible :name
  has_many :equipes

  validates :name, presence: true
end
