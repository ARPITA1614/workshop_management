class AddSlugToWorkshops < ActiveRecord::Migration[8.1]
  def change
    add_column :workshops, :slug, :string
    add_index :workshops, :slug, unique: true
  end
end
