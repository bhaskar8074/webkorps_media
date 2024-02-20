class CreateBlogPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :content
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :category, null: false, foreign_key: true
      t.string :slug
      t.string :tags, array: true
      t.string :featured_image_url
      t.integer :status, default: 0
      t.datetime :published_at

      t.timestamps
    end
  end
end
