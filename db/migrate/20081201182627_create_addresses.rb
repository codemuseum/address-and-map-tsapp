class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :organization_uid
      t.string :name
      t.string :street_line1
      t.string :street_line2
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.string :email
      t.string :phone
      t.string :fax
      t.string :link
      t.text :note

      t.timestamps
    end
    add_index :addresses, :organization_uid
    add_index :addresses, :name
  end

  def self.down
    drop_table :addresses
  end
end
