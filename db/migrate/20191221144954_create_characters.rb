class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :image, null: false
    end

    create_table :categories do |t|
      t.string :name, null: false
    end

    create_table :character_categories do |t|
      t.belongs_to :character
      t.belongs_to :category
    end
  end
end
