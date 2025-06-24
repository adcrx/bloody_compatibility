defmodule Globi.Repo.Migrations.AddNameLastNameAndBloodTypeToUsers do
  use Ecto.Migration

  def change do
  alter table(:users) do
    add :name, :string, null: false
    add :last_name, :string, null: false
    add :blood_type, :string, null: false
  end

  execute """
  ALTER TABLE users
  ADD CONSTRAINT blood_type_check
  CHECK (blood_type IN ('O-', 'O+', 'A-', 'A+', 'B-', 'B+', 'AB-', 'AB+'))
  """
end

end
