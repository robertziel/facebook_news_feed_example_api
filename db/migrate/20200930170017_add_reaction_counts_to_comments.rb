class AddReactionCountsToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :like_reactions_count, :integer, null: false, default: 0
    add_column :comments, :smile_reactions_count, :integer, null: false, default: 0
    add_column :comments, :thumbs_up_reactions_count, :integer, null: false, default: 0
  end
end
