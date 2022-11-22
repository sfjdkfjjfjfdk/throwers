class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.bigint :user_id, null: false
      t.string :name, null: false, default: ""
      t.date :date, null: false, default: ""
      t.text :time, null: false, default: ""
      t.text :weather, null: false, default: ""
      t.text :practice, null: false, default: ""
      t.text :skill, null: false, default: ""
      t.text :improvement, null: false, default: ""

      t.timestamps
    end
  end
end
