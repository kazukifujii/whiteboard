class CreateStickyNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :sticky_notes do |t|
      t.text :content
      t.string :color
      t.integer :top
      t.integer :left

      t.timestamps
    end
  end
end
