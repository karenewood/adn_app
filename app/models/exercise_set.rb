class ExerciseSet < ActiveRecord::Base
  attr_accessible :exercise_id, :programme_id

  belongs_to :exercise
  belongs_to :programme
end
