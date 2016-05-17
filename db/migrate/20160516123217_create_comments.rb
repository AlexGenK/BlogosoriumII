class CreateComments < ActiveRecord::Migration
  def change

  	create_table :comments do |c|
  		c.text :c_name
  		c.text :c_comments
  		c.integer :post_id

  		c.timestamps
  	end

  end
end
