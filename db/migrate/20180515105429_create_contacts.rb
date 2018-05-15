class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.boolean :b2c_customer
      t.boolean :b2c_alumnus
      t.boolean :b2c_apprentice
      t.boolean :b2c_fellow
      t.boolean :b2b_person
      t.boolean :other

      t.timestamps
    end
  end
end
