class Resultat < ActiveRecord::Base
  attr_accessible :user_id, :athlete_id, :evaluation_id, :equipe_id, :eval_test_id, :value

  belongs_to :user
  belongs_to :athlete, :class_name => "User", :foreign_key => "athlete_id"
  belongs_to :equipe
  belongs_to :evaluation
  belongs_to :eval_test

  validates :value, presence: true
end
