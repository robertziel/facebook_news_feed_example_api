class CreateNewsFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :news_feeds do |t|
      t.text :title, null: false
      t.text :content, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
