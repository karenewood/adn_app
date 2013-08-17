class Participation < ActiveRecord::Base
  attr_accessible :user_id, :equipe_id
  	belongs_to :user
	belongs_to :equipe
end
