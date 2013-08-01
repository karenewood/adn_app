class TestSet < ActiveRecord::Base
  attr_accessible :eval_test_id, :evaluation_id

  belongs_to :eval_test
  belongs_to :evaluation
end
