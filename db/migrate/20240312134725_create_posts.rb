class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :image
      t.text :text
      t.timestamps
    end
  end
end
