# webforms.ex 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
# Compatible with WebFormsJS version 2.1

defmodule WebFormsCore.ExtensionWebFormsMethods do
  def child(text, value) do
    if text == "" do
      value
    else
      text <> "|" <> value
    end
  end

  def parent(text) do
    cond do
      text == "" -> text
      String.ends_with?(text, "|/") or String.ends_with?(text, "//") -> text <> "/"
      true -> text <> "|/"
    end
  end

  def criteria(text, value) do
    if text == "" do
      value
    else
      text <> "?" <> (value |> String.replace("|", "$[vb];") |> String.replace("?", "$[qu];"))
    end
  end

  def append_fetch_replace(text, search_value, value) do
    fs = <<28>>
    text = String.slice(text, 1..-1)
    "@;" <> search_value <> fs <> value <> fs <> text
  end

  def line_break(text, encode_line \\ false) do
    encode = if encode_line, do: "$[sln];", else: ""

    text
    |> String.replace("\r\n", encode)
    |> String.replace("\n", encode)
    |> String.replace("\r", encode)
  end

  # Converts Numbers to Strings
  def to_js_string(text), do: "\"" <> text <> "\""

  # Get JS Object Momentary
  def to_js_object(text), do: "$" <> text

  # Get JS Object Returned Value Once
  def to_js_return_object(text), do: "$@" <> text
end