class CreateMovieCast < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_cast, id: :uuid do |t|
      t.references :movie, null: false, foreign_key: true, type: :uuid
      t.references :cast, null: false, foreign_key: true, type: :uuid
      t.integer :role

      t.timestamps
    end
  end
end
