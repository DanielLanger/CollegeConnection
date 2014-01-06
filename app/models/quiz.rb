class Quiz < ActiveRecord::Base

	belongs_to :user
	
	validates :q1, :presence => true
	validates :q2, :presence => true
	validates :q3, :presence => true
	validates :q4, :presence => true
	validates :q5, :presence => true
	serialize :q1
	serialize :q2
	serialize :q5
	

	has_many :activities
	has_many :majors


end
