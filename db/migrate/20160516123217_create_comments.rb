class CreateComments < ActiveRecord::Migration
  def change

  	create_table :comments do |c|
  		c.text :c_name
  		c.text :c_comments
  		c.integer :p_id

  		c.timestamps
  	end

  end
end
