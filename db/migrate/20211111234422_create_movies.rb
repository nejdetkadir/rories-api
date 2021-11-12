class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies, id: :uuid do |t|
      t.string :title, null: false, default: ""
      t.text :storyline, null: false, default: ""
      t.string :cover, null: false
      t.string :trailer
      t.string :imdb_id, null: false, default: ""
      t.decimal :imdb_rating, precision: 10, scale: 2
      t.integer :minimum_age
      t.integer :minutes, null: false
      t.integer :released_at, null: false
      t.boolean :success, default: false

      t.timestamps
    end
  end
end
