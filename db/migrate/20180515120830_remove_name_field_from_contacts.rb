class RemoveNameFieldFromContacts < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :name, :string
  end
end
