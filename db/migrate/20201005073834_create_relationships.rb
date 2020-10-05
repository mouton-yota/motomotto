class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :target_user, null: false, foreign_key: false

      t.timestamps
    end
  end
end
