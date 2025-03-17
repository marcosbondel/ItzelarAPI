class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :exam, null: false, foreign_key: true
      t.string :question
      t.string :question_type

      t.timestamps
    end
  end
end
