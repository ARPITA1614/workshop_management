class CreateCustomers < ActiveRecord::Migration[8.1]
  def change
    create_table :customers do |t|
      t.string :full_name
      t.string :email
      t.string :contact_number
      t.string :stripe_customer_id

      t.timestamps
    end
  end
end
