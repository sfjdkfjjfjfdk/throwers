class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.bigint :user_id, null: false
      t.string :name, null: false
      t.date :date, null: false
      t.text :time, null: false
      t.text :weather, null: false
      t.text :practice, null: false
      t.text :skill, null: false
      t.text :improvement, null: false

      t.timestamps
    end
  end
end
