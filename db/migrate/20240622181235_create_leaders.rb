class CreateLeaders < ActiveRecord::Migration[7.1]
  def change
    create_table :leaders do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :email
      t.string :phone_number
      t.string :aadhar_number
      t.string :property
      t.string :husband_name
      t.string :family_card_number
      t.string :street_name
      t.string :city
      t.integer :pincode
      t.timestamps
      t.references :area, null: true, foreign_key: true
    end
  end
end
