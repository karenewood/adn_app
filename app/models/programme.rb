class Programme < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :exercise_ids
  belongs_to :user
  has_many :exercise_sets, :dependent => :destroy
  has_many :exercises, :through => :exercise_sets

  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 350 }
end
