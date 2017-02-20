class CreateVariablesSistemas < ActiveRecord::Migration
  def change
    create_table :variables_sistemas do |t|

      t.timestamps null: false
    end
  end
end
