# webforms.ex 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
# Compatible with WebFormsJS version 2.1

# WebForms Place Criteria (WPC) DSL
defmodule WebFormsCore.InputPlace do
  def document, do: ","
  def window, do: "`"
  # When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
  def root, do: "~"
  def html, do: "."
  def head, do: "^"
  def screen_orientation, do: "%"
  def all, do: "*"
  def parent, do: "/"
  def current, do: "$"
  def target, do: "!"
  def upper, do: "-"

  def id(id), do: id
  def name(name), do: "(" <> name <> ")"
  def name(name, index), do: "(" <> name <> ")" <> to_string(index)
  def all_names(name), do: "(" <> name <> ")*"
  def tag(tag), do: "<" <> tag <> ">"
  def tag(tag, index), do: "<" <> tag <> ">" <> to_string(index)
  def all_tags(tag), do: "<" <> tag <> ">*"
  def child, do: "<>"
  def child(index), do: "<>" <> to_string(index)
  def all_child, do: "<>*"
  def class(class), do: "{" <> class <> "}"
  def class(class, index), do: "{" <> class <> "}" <> to_string(index)
  def all_classes(class), do: "{" <> class <> "}*"
  def attribute(name), do: "\"" <> name <> "\""
  def attribute(name, index) when is_integer(index), do: "\"" <> name <> "\"" <> to_string(index)
  def all_attributes(name), do: "\"" <> name <> "\"*"

  # Operator: '^', '$', '*', '~'
  def attribute(name, value, operator \\ 0) do
    "\"" <> name <> (if operator != 0, do: <<operator::utf8>>, else: "") <> "'" <> value <> "\""
  end

  def attribute(name, value, index, operator) when is_integer(index) do
    "\"" <> name <> (if operator != 0, do: <<operator::utf8>>, else: "") <> "'" <> value <> "\"" <> to_string(index)
  end

  def all_attributes(name, value, operator \\ 0) do
    "\"" <> name <> (if operator != 0, do: <<operator::utf8>>, else: "") <> "'" <> value <> "\"*"
  end

  def query(query) do
    "*" <>
      (query
       |> String.replace("=", "$[eq];")
       |> String.replace("|", "$[vb];")
       |> String.replace("?", "$[qu];"))
  end

  def query_all(query) do
    "[" <>
      (query
       |> String.replace("=", "$[eq];")
       |> String.replace("|", "$[vb];")
       |> String.replace("?", "$[qu];"))
  end
end