class CreatePollHistories < ActiveRecord::Migration
  def change
    create_table :poll_histories do |t|
      t.integer :user_id
      t.string :last_fetched_id
    end
  end
end
