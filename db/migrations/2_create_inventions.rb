# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:inventions) do
      primary_key :id
      foreign_key :scientist_id, :scientists, on_update: :restrict
      String :name
      Integer :power
      Timestamp	:created_at
    end
  end
end
