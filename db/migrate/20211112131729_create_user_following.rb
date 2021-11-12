class CreateUserFollowing < ActiveRecord::Migration[6.1]
  def change
    create_table :user_following, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :followable, null: false, type: :uuid, polymorphic: true

      t.timestamps
    end
  end
end
