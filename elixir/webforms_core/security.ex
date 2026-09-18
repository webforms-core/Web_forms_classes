# webforms.ex 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
# Compatible with WebFormsJS version 2.1

defmodule WebFormsCore.Security do
  def safe_value(value) do
    if value == "" do
      value
    else
      value = if String.first(value) == "@", do: "@" <> value, else: value

      value
      |> String.replace("\n", "$[ln];")
      |> String.replace(",@", "$[co];@")
      |> String.replace(<<28>>, <<0>>)
      |> String.replace(<<29>>, <<0>>)
      |> String.replace(<<30>>, <<0>>)
      |> String.replace(<<31>>, <<0>>)
    end
  end
end