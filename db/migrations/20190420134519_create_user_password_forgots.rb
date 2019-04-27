Hanami::Model.migration do
  change do
    create_table :user_password_forgots do
      primary_key :id
      foreign_key :user_id, :users, on_delete: :cascade, null: false, unique: true

      column :password_digest, String, null: false, size: 255
      column :expired_at, DateTime, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
