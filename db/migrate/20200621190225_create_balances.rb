class CreateBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :balances do |t|
      t.references :account, foreign_key: true
      t.references :deposit, foreign_key: true
      t.references :withdraw, foreign_key: true
      t.references :transfer, foreign_key: true

      t.timestamps
    end
  end
end
