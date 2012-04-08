class AddCategorieToItems < ActiveRecord::Migration
  def change
    add_column :items, :categorie, :string

  end
end
