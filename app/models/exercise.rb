class Exercise < ActiveRecord::Base
  attr_accessible :description, :name, :image, :video
  belongs_to :user
  has_many :prescriptions
  has_many :eval_tests, :through => :prescriptions
  has_many :exercise_sets
  has_many :programmes, :through => :exercise_set

  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 350 }

  has_attached_file :image, styles: { thumbnail: '50x50>', medium: '200x200>', large: '400x400>'}
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp']
end
