Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id
      column :name, String, null: false, size: 255
      column :email, String, null: false, unique: true, size: 255
      column :password, String, null: false, size: 255
      column :token, String, null: false, size: 255
      column :activation_digest, String, null: false, size: 255
      column :activated, TrueClass, null: false, default: false
      column :activated_at, DateTime
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
