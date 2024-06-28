class Loan < ApplicationRecord
  belongs_to :leader, optional: true
  belongs_to :applicant_user, optional: true
  validate :leader_or_applicant_user_present

   private

  def leader_or_applicant_user_present
    if applicant_user_id.present? && leader_id.present?
      errors.add(:base, 'Specify either a applicant user or an leader, not both.')
    elsif applicant_user_id.blank? && leader_id.blank?
      errors.add(:base, 'Specify either a applicant user or an leader.')
    end
  end
end
