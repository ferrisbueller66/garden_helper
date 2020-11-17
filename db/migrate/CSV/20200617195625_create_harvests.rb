class CreateHarvests < ActiveRecord::Migration[6.0]
  def change
    create_table :harvests do |t|
      t.float :weight
      t.date :harvest_date
      t.belongs_to :plant, index: true, foreign_key: true
      t.timestamps
    end
  end
end
