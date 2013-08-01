class Programme < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :exercise_ids
  belongs_to :user
  has_many :exercise_sets
  has_many :exercises, :through => :exercise_sets
end
