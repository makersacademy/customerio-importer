class AddRandomOptStringToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :random_opt_string, :string
  end
end
