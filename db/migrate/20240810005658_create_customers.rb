class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :cx_id, null: false
      t.string :photo_url

      t.references :created_by, foreign_key: { to_table: :users }
      t.references :updated_by, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
