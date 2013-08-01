class Evaluation < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :eval_test_ids
  belongs_to :user
  has_many :test_sets
  has_many :eval_tests, :through => :test_sets
end
