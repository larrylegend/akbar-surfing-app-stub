class CreateLocation < ActiveRecord::Migration
  def up
  	create_table :locations do |t|
  		t.string :name
  		t.float :temperature
  		t.string :conditions
  	end
  end
 
  def down
  	drop_table :locations
  end
end
