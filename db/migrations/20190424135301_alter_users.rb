Hanami::Model.migration do
  change do
    alter_table :users do
      add_column :unconfirmed_email, String, null: false, default: ''
      add_column :confirmation_digest, String, null: false, size: 255, default: ''
      add_column :confirmation_expired_at, DateTime, null: false, default: '1970-01-01 00:00:01'
    end
  end
end
