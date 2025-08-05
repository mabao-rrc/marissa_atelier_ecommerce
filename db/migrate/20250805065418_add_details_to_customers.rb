class AddDetailsToCustomers < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :first_name, :string
    add_column :customers, :last_name, :string
    # The following line caused a conflict and has been removed:
    # add_column :customers, :username, :string
    add_column :customers, :phone, :string
    add_column :customers, :address, :text
  end
end
