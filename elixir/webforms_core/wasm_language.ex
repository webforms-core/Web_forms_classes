# webforms.ex 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
# Compatible with WebFormsJS version 2.1

defmodule WebFormsCore.WasmLanguage do
  # The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
  def c, do: "c"
  def cpp, do: "c"
  def rust, do: "rust"
  def c_sharp, do: "csharp"
  # .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
  def c_sharp_mediator, do: "csharp-m"
  def go, do: "go"
  def java, do: "java"
  def assembly_script, do: "as"
end