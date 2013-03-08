class DeleteItemCategories < ActiveRecord::Migration
	def up
		remove_column :items, :categorie
	end
end