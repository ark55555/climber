class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      
      t.integer :user_id
      t.string :image_id
      t.string :goods_name
      t.text :caption
      t.float :rate

      t.timestamps
    end
  end
end
