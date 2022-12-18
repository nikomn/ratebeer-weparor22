class RemoveBeerIdFromStyles < ActiveRecord::Migration[7.0]
  def change
    change_table :styles do |t|
      t.remove :beer_id
    end
  end
end
