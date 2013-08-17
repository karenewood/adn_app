class Evaluation < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :eval_test_ids
  belongs_to :user
  has_many :test_sets, :dependent => :destroy
  has_many :eval_tests, :through => :test_sets
  accepts_nested_attributes_for :eval_tests, :allow_destroy => true
  has_many :resultats

  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 350 }
end
