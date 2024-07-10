class CreateApplicantUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :applicant_users do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :email
      t.string :phone_number
      t.string :area
      t.string :aadhar_number
      t.string :property
      t.string :husband_name
      t.string :family_card_number
      t.string :street_name
      t.string :city
      t.integer :pincode
      t.timestamps
      t.references :leader, null: true, foreign_key: true
    end
  end
end
