class ApplicantUser < ApplicationRecord
	belongs_to :leader
	has_many :loans

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :leader_id, presence: true
end
