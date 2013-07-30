class EvalTest < ActiveRecord::Base
  attr_accessible :description, :name, :image, :video, :exercise_ids
  belongs_to :user
  has_many :prescriptions
  has_many :exercises, :through => :prescriptions

  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 350 }

  has_attached_file :image, styles: { medium: '200x200>' }
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']

end
