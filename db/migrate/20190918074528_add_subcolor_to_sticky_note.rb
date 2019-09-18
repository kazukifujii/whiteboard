class AddSubcolorToStickyNote < ActiveRecord::Migration[5.2]
  def change
    rename_column :sticky_notes, :color, :main_color
    add_column :sticky_notes, :sub_color, :string
  end
end
