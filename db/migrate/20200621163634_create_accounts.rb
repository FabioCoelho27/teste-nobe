class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.belongs_to :user, null: false, index: {:unique=>true}, foreign_key: true

      t.timestamps
    end
  end
end
