ActiveAdmin.register ApplicantUser do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :first_name, :last_name, :email, :phone_number, :area, :aadhar_number, :leader_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :email, :phone_number, :area, :aadhar_number, :leader_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.inputs 'Leader Details' do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone_number
      f.input :area, as: :select, collection: Area.all.pluck(:name, :id)
      f.input :aadhar_number, placeholder: 'Aadhar Number'
      # f.input :leader_id, as: :select, collection: Leader.all.pluck(:first_name, :id)
      f.input :leader_id, as: :select, collection: Leader.all.map { |leader| ["#{leader.first_name} - #{leader.area.name}", leader.id] }
  
    end
    f.actions
  end
end
