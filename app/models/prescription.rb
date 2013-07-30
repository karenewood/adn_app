class Prescription < ActiveRecord::Base
	attr_accessible :eval_test_id, :exercise_id
  	belongs_to :eval_test
	belongs_to :exercise
end
