class Area < ApplicationRecord
	has_many :leaders, dependent: :destroy
    validates :name, presence: true, uniqueness: { case_sensitive: false }

end
