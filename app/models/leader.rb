class Leader < ApplicationRecord
	belongs_to :area
	has_many :applicant_users
	has_many :loans
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :area_id, presence: true
end
