class Equipe < ActiveRecord::Base
  attr_accessible :description, :name, :equipe_type_id, :coach_id, :assistant_id, :user_ids

  belongs_to :user
  has_many :participations, :dependent => :destroy
  has_many :users, :through => :participations
  belongs_to :equipe_type
  accepts_nested_attributes_for :equipe_type
  has_many :resultats

  validates :name, presence: true
  validates :description, presence: true
  validates :equipe_type_id, presence: true
end
