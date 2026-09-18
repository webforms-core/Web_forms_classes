# webforms.ex 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
# Compatible with WebFormsJS version 2.1

# Do not Add any Data Before or After it
defmodule WebFormsCore.Fetch do
  @rs <<30>>
  @us <<31>>

  # Method
  def random(max_value), do: "@mr" <> to_string(max_value)
  def random(min_value, max_value), do: "@mr" <> to_string(max_value) <> @rs <> to_string(min_value)
  def space_to_char(text, character \\ "-"), do: "@sc" <> character <> @rs <> text
  def encode_uri(text), do: "@ue" <> text
  def decode_uri(text), do: "@ud" <> text

  def method(method_name, args \\ nil) do
    return_value = "@cm" <> method_name

    if args != nil do
      if length(args) > 0 do
        return_value <> @rs <> Enum.map_join(args, @us, &to_string/1)
      else
        return_value
      end
    else
      return_value
    end
  end

  def module_method(method_name, args \\ nil) do
    return_value = "@cM" <> method_name

    if args != nil do
      if length(args) > 0 do
        return_value <> @rs <> Enum.map_join(args, @us, &to_string/1)
      else
        return_value
      end
    else
      return_value
    end
  end

  # MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
  def wasm_method(wasm_language, wasm_url, method_name, args \\ nil, _key \\ ".") do
    return_value = "@wA" <> wasm_language <> @rs <> wasm_url <> @rs <> method_name

    if args != nil do
      if length(args) > 0 do
        return_value <> @rs <> Enum.map_join(args, @us, &to_string/1)
      else
        return_value
      end
    else
      return_value
    end
  end

  def script(script_text), do: "@_" <> String.replace(script_text, "\n", "$[ln];")
  def load_url(url, fetch_script \\ false), do: "@lu" <> url <> if(fetch_script, do: @rs <> "1", else: "")
  def load_html(url, fetch_input_place \\ "", fetch_script \\ false),
    do: "@lh" <> url <> @rs <> (if fetch_script, do: "1", else: "0") <> if(fetch_input_place in [nil, ""], do: "", else: @rs <> fetch_input_place)
  def load_line(url, line), do: "@ll" <> url <> @rs <> to_string(line)
  def load_ini(url, name, is_ini_like \\ false), do: "@li" <> url <> @rs <> name <> if(is_ini_like, do: @rs <> "1", else: "")
  # Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
  def load_json(url, name), do: "@lj" <> url <> @rs <> name
  # Name: Name Or XPath; XPath Index Starts At 1
  def load_xml(url, name), do: "@lx" <> url <> @rs <> name
  # MethodName: It's Check Function Or Variable
  def has_method(method_name), do: "@hm" <> method_name
  def has_module_method(method_name), do: "@hM" <> method_name
  # This Method Return True Or False If Key Pressed
  # Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
  def get_modifier_state(modifier), do: "@ms" <> modifier

  # Math
  def math(method_name, args \\ nil) do
    return_value = "@M#" <> method_name

    if args != nil do
      if length(args) > 0 do
        return_value <> @rs <> Enum.map_join(args, @us, &to_string/1)
      else
        return_value
      end
    else
      return_value
    end
  end

  # Data
  def date_year, do: "@dy"
  # Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1
  def date_month, do: "@dm"
  def date_day, do: "@dd"
  def date_date, do: "@dD"
  def date_hours, do: "@dh"
  def date_minutes, do: "@di"
  def date_seconds, do: "@ds"
  def date_milliseconds, do: "@dl"

  # String
  def space, do: "@sp"
  def at_sign, do: "@sa"

  # Tag
  def get_id(input_place), do: "@$i" <> input_place
  def get_name(input_place), do: "@$n" <> input_place
  def get_value(input_place), do: "@$v" <> input_place
  def get_value_length(input_place), do: "@$e" <> input_place
  def get_class(input_place), do: "@$c" <> input_place
  def get_style(input_place), do: "@$s" <> input_place
  def get_title(input_place), do: "@$l" <> input_place
  def get_label(input_place), do: "@$A" <> input_place
  def get_text(input_place), do: "@$t" <> input_place
  def get_outer_text(input_place), do: "@$o" <> input_place
  def get_text_length(input_place), do: "@$g" <> input_place
  def get_attribute(input_place, attribute), do: "@$a" <> input_place <> @rs <> attribute
  def get_width(input_place), do: "@$w" <> input_place
  def get_height(input_place), do: "@$h" <> input_place
  def get_is_read_only(input_place), do: "@$r" <> input_place
  def get_selected_index(input_place), do: "@$x" <> input_place
  def get_index(input_place), do: "@$I" <> input_place
  def get_text_align(input_place), do: "@$T" <> input_place
  def get_node_length(input_place), do: "@$L" <> input_place
  def get_is_visible(input_place), do: "@$V" <> input_place

  # Save
  def has_hash(hash), do: "@HH" <> hash
  def cookie(key), do: "@co" <> key
  def save(key \\ "."), do: "@cs" <> key
  def save(key, replace_value), do: "@cs" <> key <> @rs <> replace_value
  def save_then_remove(key), do: "@cl" <> key
  def save_length(key \\ "."), do: "@cg" <> key
  def cache(key \\ "."), do: "@cd" <> key
  def cache(key, replace_value), do: "@cd" <> key <> @rs <> replace_value
  def cache_then_remove(key), do: "@ct" <> key
  def cache_length(key \\ "."), do: "@cG" <> key
  def save_line(key \\ ".", line \\ 0), do: "@lL" <> key <> "[" <> to_string(line)
  def save_line_consume(key \\ "."), do: "@lL" <> key
  # INIKey: Only Direct Key is Supported
  def save_ini(key, ini_key), do: "@lI" <> key <> "[" <> ini_key
  def cache_line(key \\ ".", line \\ 0), do: "@dL" <> key <> "[" <> to_string(line)
  def cache_line_consume(key \\ "."), do: "@dL" <> key
  # INIKey: Only Direct Key is Supported
  def cache_ini(key, ini_key), do: "@dI" <> key <> "[" <> ini_key

  # Format Storage
  def format_store(key), do: "@fr" <> key
  def format_store_by_xml_query(key, xpath), do: "@fx" <> key <> @rs <> xpath
  def format_store_by_json_query(key, query), do: "@fj" <> key <> @rs <> query
  def format_store_by_ini(key, name), do: "@fi" <> key <> @rs <> name
  def format_store_by_text(key, line), do: "@ft" <> key <> @rs <> to_string(line)
  def format_store_by_variable(key), do: "@fv" <> key

  # State
  def has_state(path), do: "@hs" <> path

  # SSE
  def sse_is_connected(path), do: "@Sc" <> path

  # WebSockets
  def web_sockets_is_connected(path \\ ""), do: "@Wc" <> path

  # Document
  def tab_is_active, do: "@da"

  # Window
  def href, do: "@wf"
  def path_name, do: "@wP"
  def query(name \\ "*"), do: "@wq" <> name
  def hash, do: "@wh"
  def host, do: "@wH"
  def host_name, do: "@wn"
  def port, do: "@wT"
  def origin, do: "@wo"
  def get_selection, do: "@ws"
  def scroll_x, do: "@wx"
  def scroll_y, do: "@wy"
  def segment(index), do: "@wS" <> to_string(index)
  # It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
  def hash_segment(index), do: "@wt" <> to_string(index)

  # Navigator
  def clipboard_text, do: "@nC"
  def geo_latitude, do: "@nW"
  def geo_longitude, do: "@nO"
  def language, do: "@nL"
  def is_on_line, do: "@no"
  def user_agent, do: "@na"

  # Screen
  def screen_width, do: "@sw"
  def screen_height, do: "@sh"
  def screen_orientation_type, do: "@so"
  def screen_orientation_angle, do: "@sr"

  # Performance
  def time_origin, do: "@pt"
  def performance_now, do: "@pn"

  # Event
  def event, do: "@EV"
  def event_serialize, do: "@Es"
  def event_key, do: "@ek"
  def event_which, do: "@ew"
  def event_client_x, do: "@ex"
  def event_client_y, do: "@ey"
  def event_page_x, do: "@eX"
  def event_page_y, do: "@eY"
  def event_offset_x, do: "@Ex"
  def event_offset_y, do: "@Ey"
  def event_delta_y, do: "@ed"
end