class EvalTest < ActiveRecord::Base
  attr_accessible :description, :name, :image, :video, :exercise_ids
  belongs_to :user
  has_many :prescriptions, :dependent => :destroy
  has_many :exercises, :through => :prescriptions
  has_many :resultats

  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 350 }

  has_attached_file :image, styles: { thumbnail: '50x50#', medium: '200x200>', large: '400x400>'}
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp']

end
