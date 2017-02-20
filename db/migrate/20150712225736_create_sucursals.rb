class CreateSucursals < ActiveRecord::Migration
  def change
    create_table :sucursals do |t|

      t.timestamps null: false
    end
  end
end
