class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.integer :category, null: false

      t.timestamps
    end
  end
end
