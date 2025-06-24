defmodule Globi.BloodCompatibility do

  @moduledoc """
  Módulo para determinar los tipos de sangre compatibles e incompatibles  a partir del tipo de sangre
  """

  @spec compatibility(String.t()) :: %{compatibles: [String.t()], incompatibles: [String.t()]}

  @blood_types ["O-", "O+", "A-", "A+", "B-", "B+", "AB-", "AB+"]

  @compatibility %{
    "O-" => ["O-"],
    "O+" => ["O-", "O+"],
    "A-" => ["O-", "A-"],
    "A+" => ["O-", "O+", "A-", "A+"],
    "B-" => ["O-", "B-"],
    "B+" => ["O-", "O+", "B-", "B+"],
    "AB-" => ["O-", "A-", "B-", "AB-"],
    "AB+" => ["O-", "O+", "A-", "A+", "B-", "B+", "AB-", "AB+"]
  }

  def compatibility(blood_type) do
    case Map.get(@compatibility, blood_type) do
      nil ->
        raise ArgumentError,
              "Tipo de sangre inválido. Debe ser uno de: #{@blood_types |> Enum.join(", ")}"

      compatibles ->
        incompatibles =
          @blood_types
          |> Enum.reject(&(&1 in compatibles))

        %{
          compatibles: Enum.sort(compatibles),
          incompatibles: Enum.sort(incompatibles)
        }
    end
  end

end
