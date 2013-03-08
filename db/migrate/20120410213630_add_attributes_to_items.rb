class AddAttributesToItems < ActiveRecord::Migration
  def change
    add_column :items, :year, :string

    add_column :items, :runtime, :string

    add_column :items, :ratings, :integer

    add_column :items, :synopsys, :text

    add_column :items, :poster, :string

    add_column :items, :link, :string

  end
end
