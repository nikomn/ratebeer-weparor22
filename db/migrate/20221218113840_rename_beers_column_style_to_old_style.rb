class RenameBeersColumnStyleToOldStyle < ActiveRecord::Migration[7.0]
  def change
    add_column :beers, :style_id, :integer
    change_table :beers do |t|
      t.rename :style, :old_style
    end
    beers = Beer.all
    beers.each do |beer |
      s = Style.where name: beer.old_style
      beer.style = s.first
      beer.save
    end
  end
end
