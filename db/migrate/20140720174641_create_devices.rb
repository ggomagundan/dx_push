class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :device_id
      t.string :gcm_id
      t.integer :device_type
      t.integer :gcm_type

      t.timestamps
    end
  end
end
