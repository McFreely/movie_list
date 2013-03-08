class ChangeAttributeToItems < ActiveRecord::Migration
	def up
		change_column :items, :synopsys, :text
	end
	def down
		# this causes problems becauses the synopsis are longer than 255 chars
		change_column :items, :synopsys, :string
	end
end