class CreateBeds < ActiveRecord::Migration[6.0]
  def change
    create_table :beds do |t|
      t.string :name
      t.string :location
      t.integer :size
      t.string :medium

      t.timestamps
    end
  end
end
