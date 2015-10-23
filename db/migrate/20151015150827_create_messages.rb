class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id, index: true
      t.integer :thread_id, index: true
      t.string :source_id

      t.string :from
      t.string :subject
      t.string :snippet

      t.datetime :date
    end
  end
end
