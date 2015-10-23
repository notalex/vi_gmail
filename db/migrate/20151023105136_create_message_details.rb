class CreateMessageDetails < ActiveRecord::Migration
  def change
    create_table :message_details do |t|
      t.integer :message_id, index: true

      t.string :to
      t.text :plain_body
    end
  end
end
