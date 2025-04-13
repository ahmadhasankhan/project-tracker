# frozen_string_literal: true

class CreateProjectHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :project_histories do |t|
      t.references :project, null: false, foreign_key: true
      t.string :from_status
      t.string :to_status
      t.references :user, null: false, foreign_key: true # in case you want to track who made the change

      t.timestamps
    end
  end
end
