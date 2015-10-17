class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :source_id
      t.string :to
      t.string :from
      t.string :subject
      t.datetime :date
      t.text :plain_body
    end

    add_index :messages, :source_id, unique: true
  end
end
