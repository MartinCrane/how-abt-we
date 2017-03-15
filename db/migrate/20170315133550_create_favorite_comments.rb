class CreateFavoriteComments < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_comments do |t|
      t.integer :comment_id
      t.integer :favorite_id
    end
  end
end
