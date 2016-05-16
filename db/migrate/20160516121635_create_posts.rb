class CreatePosts < ActiveRecord::Migration
  def change

  	create_table :posts do |c|
  		c.text :p_name
  		c.text :p_post

  		c.timestamps
  	end

  end
end
