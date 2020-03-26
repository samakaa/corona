class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.integer :confirmed
      t.integer :recovered
      t.integer :death

      t.timestamps
    end
  end
end
