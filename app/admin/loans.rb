ActiveAdmin.register Loan do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :loan_amount, :roi, :tenure_weeks, :disbursement_amount, :disbursement_date, :weekly_collection_amount, :weekly_collection_date, :first_ewi_date, :loan_closing_date, :leader_id, :applicant_user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:loan_amount, :roi, :tenure_weeks, :disbursement_amount, :disbursement_date, :weekly_collection_amount, :weekly_collection_date, :first_ewi_date, :loan_closing_date, :leader_id, :applicant_user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
   form do |f|
    f.inputs 'Loan Details' do
      f.input :loan_amount
      f.input :roi
      f.input :tenure_weeks
      f.input :disbursement_amount
      f.input :weekly_collection_amount
      f.input :disbursement_date
      f.input :weekly_collection_date
      f.input :first_ewi_date
      f.input :loan_closing_date
      f.input :applicant_user_id, as: :select, collection: ApplicantUser.all.pluck(:first_name, :id)
      f.input :leader_id, as: :select, collection: Leader.all.map { |leader| ["#{leader.first_name} - #{leader.area.name}", leader.id] }

    end
    f.actions
  end

end
