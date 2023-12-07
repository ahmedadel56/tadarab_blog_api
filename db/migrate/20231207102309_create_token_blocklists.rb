class CreateTokenBlocklists < ActiveRecord::Migration[7.1]
  def change
    create_table :token_blocklists do |t|
      t.string :token
      t.datetime :exp

      t.timestamps
    end
  end
end
