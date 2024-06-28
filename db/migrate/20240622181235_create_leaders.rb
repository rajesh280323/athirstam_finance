class CreateLeaders < ActiveRecord::Migration[7.1]
  def change
    create_table :leaders do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :email
      t.string :phone_number
      t.string :aadhar_number
      t.timestamps
      t.references :area, null: true, foreign_key: true
    end
  end
end
