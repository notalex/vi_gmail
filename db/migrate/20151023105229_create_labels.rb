class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.integer :user_id
      t.integer :message_id
      t.string :name
    end

    add_index :labels, [:message_id, :name], unique: true
  end
end
