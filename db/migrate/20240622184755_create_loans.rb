class CreateLoans < ActiveRecord::Migration[7.1]
  def change
    create_table :loans do |t|
      t.integer :loan_amount
      t.float :roi
      t.integer :tenure_weeks
      t.integer :disbursement_amount
      t.date :disbursement_date
      t.integer :weekly_collection_amount
      t.date :weekly_collection_date
      t.date :first_ewi_date
      t.date :loan_closing_date
      t.integer :status, default: '0'

      t.timestamps
      t.references :leader, null: true, foreign_key: true
      t.references :applicant_user, null: true, foreign_key: true
    end
  end
end
