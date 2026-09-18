# webforms.ex 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
# Compatible with WebFormsJS version 2.1

defmodule WebFormsCore.OutputPlace do
  defdelegate document(), to: WebFormsCore.InputPlace
  defdelegate window(), to: WebFormsCore.InputPlace
  defdelegate root(), to: WebFormsCore.InputPlace
  defdelegate html(), to: WebFormsCore.InputPlace
  defdelegate head(), to: WebFormsCore.InputPlace
  defdelegate screen_orientation(), to: WebFormsCore.InputPlace
  defdelegate all(), to: WebFormsCore.InputPlace
  defdelegate parent(), to: WebFormsCore.InputPlace
  defdelegate current(), to: WebFormsCore.InputPlace
  defdelegate target(), to: WebFormsCore.InputPlace
  defdelegate upper(), to: WebFormsCore.InputPlace
  defdelegate id(id), to: WebFormsCore.InputPlace
  defdelegate name(name), to: WebFormsCore.InputPlace
  defdelegate name(name, index), to: WebFormsCore.InputPlace
  defdelegate all_names(name), to: WebFormsCore.InputPlace
  defdelegate tag(tag), to: WebFormsCore.InputPlace
  defdelegate tag(tag, index), to: WebFormsCore.InputPlace
  defdelegate all_tags(tag), to: WebFormsCore.InputPlace
  defdelegate child(), to: WebFormsCore.InputPlace
  defdelegate child(index), to: WebFormsCore.InputPlace
  defdelegate all_child(), to: WebFormsCore.InputPlace
  defdelegate class(class), to: WebFormsCore.InputPlace
  defdelegate class(class, index), to: WebFormsCore.InputPlace
  defdelegate all_classes(class), to: WebFormsCore.InputPlace
  defdelegate attribute(name), to: WebFormsCore.InputPlace
  defdelegate attribute(name, index), to: WebFormsCore.InputPlace
  defdelegate all_attributes(name), to: WebFormsCore.InputPlace
  defdelegate attribute(name, value, operator), to: WebFormsCore.InputPlace
  defdelegate attribute(name, value, index, operator), to: WebFormsCore.InputPlace
  defdelegate all_attributes(name, value, operator), to: WebFormsCore.InputPlace
  defdelegate query(query), to: WebFormsCore.InputPlace
  defdelegate query_all(query), to: WebFormsCore.InputPlace
end