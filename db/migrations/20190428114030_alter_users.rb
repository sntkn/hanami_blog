Hanami::Model.migration do
  change do
    alter_table :users do
      set_column_default :token, ''
      set_column_default :activation_digest, ''
      set_column_default :activated_at, '1970-01-01 00:00:01'
      set_column_allow_null :activated_at, false
    end
  end
end
