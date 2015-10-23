class CreateMessageThreads < ActiveRecord::Migration
  def change
    create_table :message_threads do |t|
      t.integer :user_id
      t.string :source_id, unique: true
    end
  end
end
