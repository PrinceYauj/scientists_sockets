# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:scientists) do
      primary_key :id
      Integer :madness
      Integer :attempts
      Timestamp	:created_at
    end
  end
end
