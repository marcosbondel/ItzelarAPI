class CreateUserSession < ActiveRecord::Migration[8.0]
  def change
    create_table :user_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :user_uuid
      t.string :user_agent
      t.integer :usage_count, default: 0
      
      t.string :ip_address
      
      t.string :session_uuid
      t.string :session_token
      t.integer :session_source
      
      t.datetime :expires_at
      t.datetime :last_used_at
      t.datetime :revoked_at

      t.timestamps
    end
  end
end
