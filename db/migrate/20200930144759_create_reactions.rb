class CreateReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :reactions do |t|
      t.references :comment, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :reaction_type, null: false

      t.timestamps

      t.index [:user_id, :comment_id], unique: true
    end
  end
end
