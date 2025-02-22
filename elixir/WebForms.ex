# Compatible with WebFormsJS version 1.6

defmodule NameValue do
  defstruct name: nil, value: nil
end

defmodule NameValueCollection do
  defstruct data: []

  def add(collection, name, value) do
    %{collection | data: [%NameValue{name: name, value: value} | collection.data]}
  end

  def set(collection, name, value) do
    if exist?(collection, name) do
      change_value(collection, name, value)
    else
      add(collection, name, value)
    end
  end

  def delete(collection, name) do
    %{collection | data: Enum.reject(collection.data, fn nv -> nv.name == name end)}
  end

  def delete_by_index(collection, index) do
    index = if index < 0, do: length(collection.data) + index, else: index
    %{collection | data: List.delete_at(collection.data, index)}
  end

  def empty(collection) do
    %{collection | data: []}
  end

  def exist?(collection, name) do
    Enum.any?(collection.data, fn nv -> nv.name == name end)
  end

  def change_value(collection, name, value) do
    %{collection | data: Enum.map(collection.data, fn nv ->
      if nv.name == name, do: %{nv | value: value}, else: nv
    end)}
  end

  def change_name(collection, name, new_name) do
    %{collection | data: Enum.map(collection.data, fn nv ->
      if nv.name == name, do: %{nv | name: new_name}, else: nv
    end)}
  end

  def change_value_by_index(collection, index, value) do
    index = if index < 0, do: length(collection.data) + index, else: index
    %{collection | data: List.update_at(collection.data, index, fn nv -> %{nv | value: value} end)}
  end

  def change_name_by_index(collection, index, name) do
    index = if index < 0, do: length(collection.data) + index, else: index
    %{collection | data: List.update_at(collection.data, index, fn nv -> %{nv | name: name} end)}
  end

  def change_name_value_by_index(collection, index, name, value) do
    index = if index < 0, do: length(collection.data) + index, else: index
    %{collection | data: List.update_at(collection.data, index, fn nv -> %{nv | name: name, value: value} end)}
  end

  def add_list(collection, new_data) do
    %{collection | data: collection.data ++ new_data}
  end

  def get_value(collection, name) do
    case Enum.find(collection.data, fn nv -> nv.name == name end) do
      nil -> ""
      nv -> nv.value
    end
  end

  def get_name_by_index(collection, index) do
    index = if index < 0, do: length(collection.data) + index, else: index
    Enum.at(collection.data, index).name
  end

  def get_value_by_index(collection, index) do
    index = if index < 0, do: length(collection.data) + index, else: index
    Enum.at(collection.data, index).value
  end

  def get_list(collection) do
    collection.data
  end
end

defmodule WebForms do
  defstruct web_forms_data: %NameValueCollection{}

  # For Extension
  def add_line(web_forms, name, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, name, value)}
  end

  # Add
  def add_id(web_forms, input_place, id) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ai" <> input_place, id)}
  end

  def add_name(web_forms, input_place, name) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "an" <> input_place, name)}
  end

  def add_value(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "av" <> input_place, value)}
  end

  def add_class(web_forms, input_place, class) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ac" <> input_place, class)}
  end

  def add_style(web_forms, input_place, style) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "as" <> input_place, style)}
  end

  def add_style(web_forms, input_place, name, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "as" <> input_place, name <> ":" <> value)}
  end

  def add_option_tag(web_forms, input_place, text, value, selected \\ false) do
    selected_str = if selected, do: "|1", else: ""
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ao" <> input_place, value <> "|" <> text <> selected_str)}
  end

  def add_check_box_tag(web_forms, input_place, text, value, checked \\ false) do
    checked_str = if checked, do: "|1", else: ""
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ak" <> input_place, value <> "|" <> text <> checked_str)}
  end

  def add_title(web_forms, input_place, title) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "al" <> input_place, title)}
  end

  def add_text(web_forms, input_place, text) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "at" <> input_place, String.replace(text, "\n", "$[ln];"))}
  end

  def add_text_to_up(web_forms, input_place, text) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "pt" <> input_place, String.replace(text, "\n", "$[ln];"))}
  end

  def add_attribute(web_forms, input_place, attribute, value \\ "") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "aa" <> input_place, attribute <> "|" <> value)}
  end

  def add_tag(web_forms, input_place, tag_name, id \\ "") do
    id_str = if id == "", do: "", else: "|" <> id
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "nt" <> input_place, tag_name <> id_str)}
  end

  def add_tag_to_up(web_forms, input_place, tag_name, id \\ "") do
    id_str = if id == "", do: "", else: "|" <> id
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ut" <> input_place, tag_name <> id_str)}
  end

  def add_tag_before(web_forms, input_place, tag_name, id \\ "") do
    id_str = if id == "", do: "", else: "|" <> id
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "bt" <> input_place, tag_name <> id_str)}
  end

  def add_tag_after(web_forms, input_place, tag_name, id \\ "") do
    id_str = if id == "", do: "", else: "|" <> id
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ft" <> input_place, tag_name <> id_str)}
  end

  # Set
  def set_id(web_forms, input_place, id) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "si" <> input_place, id)}
  end

  def set_name(web_forms, input_place, name) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "sn" <> input_place, name)}
  end

  def set_value(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "sv" <> input_place, value)}
  end

  def set_class(web_forms, input_place, class) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "sc" <> input_place, class)}
  end

  def set_style(web_forms, input_place, style) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ss" <> input_place, style)}
  end

  def set_style(web_forms, input_place, name, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ss" <> input_place, name <> ":" <> value)}
  end

  def set_option_tag(web_forms, input_place, text, value, selected \\ false) do
    selected_str = if selected, do: "|1", else: ""
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "so" <> input_place, value <> "|" <> text <> selected_str)}
  end

  def set_checked(web_forms, input_place, checked \\ false) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "sk" <> input_place, if(checked, do: "1", else: "0"))}
  end

  def set_check_box_tag_to_list(web_forms, input_place, text, value, checked \\ false) do
    checked_str = if checked, do: "|1", else: ""
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "sk" <> input_place, value <> "|" <> text <> checked_str)}
  end

  def set_title(web_forms, input_place, title) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "sl" <> input_place, title)}
  end

  def set_text(web_forms, input_place, text) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "st" <> input_place, String.replace(text, "\n", "$[ln];"))}
  end

  def set_attribute(web_forms, input_place, attribute, value \\ "") do
    value_str = if value == "", do: "", else: "|" <> value
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "sa" <> input_place, attribute <> value_str)}
  end

  def set_width(web_forms, input_place, width) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "sw" <> input_place, width)}
  end

  def set_width(web_forms, input_place, width) when is_integer(width) do
    set_width(web_forms, input_place, Integer.to_string(width) <> "px")
  end

  def set_height(web_forms, input_place, height) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "sh" <> input_place, height)}
  end

  def set_height(web_forms, input_place, height) when is_integer(height) do
    set_height(web_forms, input_place, Integer.to_string(height) <> "px")
  end

  # Insert
  def insert_id(web_forms, input_place, id) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ii" <> input_place, id)}
  end

  def insert_name(web_forms, input_place, name) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "in" <> input_place, name)}
  end

  def insert_value(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "iv" <> input_place, value)}
  end

  def insert_class(web_forms, input_place, class) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ic" <> input_place, class)}
  end

  def insert_style(web_forms, input_place, style) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "is" <> input_place, style)}
  end

  def insert_style(web_forms, input_place, name, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "is" <> input_place, name <> ":" <> value)}
  end

  def insert_option_tag(web_forms, input_place, text, value, selected \\ false) do
    selected_str = if selected, do: "|1", else: ""
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "io" <> input_place, value <> "|" <> text <> selected_str)}
  end

  def insert_check_box_tag(web_forms, input_place, text, value, checked \\ false) do
    checked_str = if checked, do: "|1", else: ""
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ik" <> input_place, value <> "|" <> text <> checked_str)}
  end

  def insert_title(web_forms, input_place, title) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "il" <> input_place, title)}
  end

  def insert_text(web_forms, input_place, text) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "it" <> input_place, String.replace(text, "\n", "$[ln];"))}
  end

  def insert_attribute(web_forms, input_place, attribute, value \\ "") do
    value_str = if value == "", do: "", else: "|" <> value
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ia" <> input_place, attribute <> value_str)}
  end

  # Delete
  def delete_id(web_forms, input_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "di" <> input_place, "1")}
  end

  def delete_name(web_forms, input_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "dn" <> input_place, "1")}
  end

  def delete_value(web_forms, input_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "dv" <> input_place, "1")}
  end

  def delete_class(web_forms, input_place, class_name) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "dc" <> input_place, class_name)}
  end

  def delete_style(web_forms, input_place, style_name) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ds" <> input_place, style_name)}
  end

  def delete_option_tag(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "do" <> input_place, value)}
  end

  def delete_all_option_tag(web_forms, input_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "do" <> input_place, "*")}
  end

  def delete_check_box_tag(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "dk" <> input_place, value)}
  end

  def delete_all_check_box_tag(web_forms, input_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "dk" <> input_place, "*")}
  end

  def delete_title(web_forms, input_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "dl" <> input_place, "1")}
  end

  def delete_text(web_forms, input_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "dt" <> input_place, "1")}
  end

  def delete_attribute(web_forms, input_place, attribute) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "da" <> input_place, attribute)}
  end

  def delete(web_forms, input_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "de" <> input_place, "1")}
  end

  def delete_parent(web_forms, input_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "dp" <> input_place, "1")}
  end

  # Other
  def set_background_color(web_forms, input_place, color) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "bc" <> input_place, color)}
  end

  def set_text_color(web_forms, input_place, color) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "tc" <> input_place, color)}
  end

  def set_font_name(web_forms, input_place, name) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "fn" <> input_place, name)}
  end

  def set_font_size(web_forms, input_place, size) when is_binary(size) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "fs" <> input_place, size)}
  end

  def set_font_size(web_forms, input_place, size) when is_integer(size) do
    set_font_size(web_forms, input_place, Integer.to_string(size) <> "px")
  end

  def set_font_bold(web_forms, input_place, bold) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "fb" <> input_place, if(bold, do: "1", else: "0"))}
  end

  def set_visible(web_forms, input_place, visible) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "vi" <> input_place, if(visible, do: "1", else: "0"))}
  end

  def set_text_align(web_forms, input_place, align) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ta" <> input_place, align)}
  end

  def set_read_only(web_forms, input_place, read_only) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "sr" <> input_place, if(read_only, do: "1", else: "0")}
  end

  def set_disabled(web_forms, input_place, disabled) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "sd" <> input_place, if(disabled, do: "1", else: "0")}
  end

  def set_focus(web_forms, input_place, focus) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "sf" <> input_place, if(focus, do: "1", else: "0")}
  end

  def set_min_length(web_forms, input_place, length) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "mn" <> input_place, Integer.to_string(length))}
  end

  def set_max_length(web_forms, input_place, length) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "mx" <> input_place, Integer.to_string(length))}
  end

  def set_selected_value(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ts" <> input_place, value)}
  end

  def set_selected_index(web_forms, input_place, index) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ti" <> input_place, Integer.to_string(index))}
  end

  def set_checked_value(web_forms, input_place, value, selected) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ks" <> input_place, value <> "|" <> if(selected, do: "1", else: "0"))}
  end

  def set_checked_index(web_forms, input_place, index, selected) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ki" <> input_place, Integer.to_string(index) <> "|" <> if(selected, do: "1", else: "0"))}
  end

  def call_script(web_forms, script_text) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "_", String.replace(script_text, "\n", "$[ln];"))}
  end

  def load_url(web_forms, input_place, url) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "lu" <> input_place, url)}
  end

  def change_url(web_forms, url) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "cu", url)}
  end

  def remove_session_cache(web_forms, cache_key) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "rs", cache_key)}
  end

  def remove_all_session_cache(web_forms) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "rs", "*")}
  end

  def remove_cache(web_forms, cache_key) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "rd", cache_key)}
  end

  def remove_all_cache(web_forms) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "rd", "*")}
  end

  def set_session_cache(web_forms) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "cs", "1")}
  end

  def set_cache(web_forms, second) when is_integer(second) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "cd", Integer.to_string(second))}
  end

  def set_cache(web_forms) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "cd", "*")}
  end

  # Increase
  def increase_min_length(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "+n" <> input_place, Integer.to_string(value))}
  end

  def increase_max_length(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "+x" <> input_place, Integer.to_string(value))}
  end

  def increase_font_size(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "+f" <> input_place, Integer.to_string(value))}
  end

  def increase_width(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "+w" <> input_place, Integer.to_string(value))}
  end

  def increase_height(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "+h" <> input_place, Integer.to_string(value))}
  end

  def increase_value(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "+v" <> input_place, Integer.to_string(value))}
  end

  # Descrease
  def decrease_min_length(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "-n" <> input_place, Integer.to_string(value))}
  end

  def decrease_max_length(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "-x" <> input_place, Integer.to_string(value))}
  end

  def decrease_font_size(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "-f" <> input_place, Integer.to_string(value))}
  end

  def decrease_width(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "-w" <> input_place, Integer.to_string(value))}
  end

  def decrease_height(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "-h" <> input_place, Integer.to_string(value))}
  end

  def decrease_value(web_forms, input_place, value) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "-v" <> input_place, Integer.to_string(value))}
  end

  # Event
  def set_post_event(web_forms, input_place, html_event) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "Ep" <> input_place, html_event)}
  end

  def set_post_event_adding(web_forms, input_place, html_event) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "Ep" <> input_place, html_event <> "|+")}
  end

  def set_post_event_to(web_forms, input_place, html_event, output_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "Ep" <> input_place, html_event <> "|" <> output_place)}
  end

  def set_post_event_listener(web_forms, input_place, html_event_listener) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "EP" <> input_place, html_event_listener)}
  end

  def set_post_event_listener_adding(web_forms, input_place, html_event_listener) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "EP" <> input_place, html_event_listener <> "|+")}
  end

  def set_post_event_listener_to(web_forms, input_place, html_event_listener, output_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "EP" <> input_place, html_event_listener <> "|" <> output_place)}
  end

  def set_get_event(web_forms, input_place, html_event, path \\ nil) do
    path_str = if path, do: path, else: "#"
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "Eg" <> input_place, html_event <> "|" <> path_str)}
  end

  def set_get_event(web_forms, input_place, html_event, output_place, path \\ nil) do
    path_str = if path, do: path, else: "#"
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "Eg" <> input_place, html_event <> "|" <> path_str <> "|" <> output_place)}
  end

  def set_get_event_in_form(web_forms, input_place, html_event) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "Eg" <> input_place, html_event)}
  end

  def set_get_event_in_form(web_forms, input_place, html_event, output_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "Eg" <> input_place, html_event <> "|" <> output_place)}
  end

  def set_get_event_listener(web_forms, input_place, html_event_listener, path \\ nil) do
    path_str = if path, do: path, else: "#"
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "EG" <> input_place, html_event_listener <> "|" <> path_str)}
  end

  def set_get_event_listener(web_forms, input_place, html_event_listener, output_place, path \\ nil) do
    path_str = if path, do: path, else: "#"
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "EG" <> input_place, html_event_listener <> "|" <> path_str <> "|" <> output_place)}
  end

  def set_get_event_in_form_listener(web_forms, input_place, html_event_listener) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "EG" <> input_place, html_event_listener)}
  end

  def set_get_event_in_form_listener(web_forms, input_place, html_event_listener, output_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "EG" <> input_place, html_event_listener <> "|" <> output_place)}
  end

  def set_tag_event(web_forms, input_place, html_event, output_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "Et" <> input_place, html_event <> "|" <> output_place)}
  end

  def set_tag_event_listener(web_forms, input_place, html_event, output_place) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "ET" <> input_place, html_event <> "|" <> output_place)}
  end

  def remove_post_event(web_forms, input_place, html_event) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "Rp" <> input_place, html_event)}
  end

  def remove_get_event(web_forms, input_place, html_event) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "Rg" <> input_place, html_event)}
  end

  def remove_tag_event(web_forms, input_place, html_event) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "Rt" <> input_place, html_event)}
  end

  def remove_post_event_listener(web_forms, input_place, html_event_listener) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "RP" <> input_place, html_event_listener)}
  end

  def remove_get_event_listener(web_forms, input_place, html_event_listener) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "RG" <> input_place, html_event_listener)}
  end

  def remove_tag_event_listener(web_forms, input_place, html_event_listener) do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "RT" <> input_place, html_event_listener)}
  end

  # Save
  def save_id(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@gi" <> input_place, key)}
  end

  def save_name(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@gn" <> input_place, key)}
  end

  def save_value(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@gv" <> input_place, key)}
  end

  def save_value_length(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@ge" <> input_place, key)}
  end

  def save_class(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@gc" <> input_place, key)}
  end

  def save_style(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@gs" <> input_place, key)}
  end

  def save_title(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@gl" <> input_place, key)}
  end

  def save_text(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@gt" <> input_place, key)}
  end

  def save_text_length(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@gg" <> input_place, key)}
  end

  def save_attribute(web_forms, input_place, attribute, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@ga" <> input_place, key <> "|" <> attribute)}
  end

  def save_width(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@gw" <> input_place, key)}
  end

  def save_height(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@gh" <> input_place, key)}
  end

  def save_read_only(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@gr" <> input_place, key)}
  end

  def save_selected_index(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@gx" <> input_place, key)}
  end

  def save_text_align(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@ta" <> input_place, key)}
  end

  def save_node_length(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@nl" <> input_place, key)}
  end

  def save_visible(web_forms, input_place, key \\ ".") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "@vi" <> input_place, key)}
  end

  # Pre Runner
  def assign_delay(web_forms, second, index \\ -1) do
    current_name = NameValueCollection.get_name_by_index(web_forms.web_forms_data, index)
    if current_name == "" do
      web_forms
    else
      new_name = ":" <> Float.to_string(second) <> ")" <> current_name
      %{web_forms | web_forms_data: NameValueCollection.change_name_by_index(web_forms.web_forms_data, index, new_name)}
    end
  end

  def assign_delay_change(web_forms, second, index \\ -1) do
    current_name = NameValueCollection.get_name_by_index(web_forms.web_forms_data, index)
    if current_name == "" do
      web_forms
    else
      current_name = String.replace(current_name, ~r/^:.*\)/, "")
      new_name = ":" <> Float.to_string(second) <> ")" <> current_name
      %{web_forms | web_forms_data: NameValueCollection.change_name_by_index(web_forms.web_forms_data, index, new_name)}
    end
  end

  def assign_interval(web_forms, second, index \\ -1) do
    current_name = NameValueCollection.get_name_by_index(web_forms.web_forms_data, index)
    if current_name == "" do
      web_forms
    else
      new_name = "(" <> Float.to_string(second) <> ")" <> current_name
      %{web_forms | web_forms_data: NameValueCollection.change_name_by_index(web_forms.web_forms_data, index, new_name)}
    end
  end

  def assign_interval_change(web_forms, second, index \\ -1) do
    current_name = NameValueCollection.get_name_by_index(web_forms.web_forms_data, index)
    if current_name == "" do
      web_forms
    else
      current_name = String.replace(current_name, ~r/^\(.*\)/, "")
      new_name = "(" <> Float.to_string(second) <> ")" <> current_name
      %{web_forms | web_forms_data: NameValueCollection.change_name_by_index(web_forms.web_forms_data, index, new_name)}
    end
  end

  # Index
  def start_index(web_forms, name \\ "") do
    %{web_forms | web_forms_data: NameValueCollection.add(web_forms.web_forms_data, "#", name)}
  end

  # Get
  def get_forms_action_data(web_forms) do
    Enum.reduce(NameValueCollection.get_list(web_forms.web_forms_data), "", fn nv, acc ->
      acc <> "\n" <> nv.name <> (if nv.value == "", do: "", else: "=" <> nv.value)
    end
  end

  def response(web_forms) do
    "[web-forms]" <> get_forms_action_data(web_forms)
  end

  # Overload
  def response(web_forms, context) do
    set_headers(context)
    response(web_forms)
  end

  def get_forms_action_data_line_break(web_forms) do
    web_forms_data_list = NameValueCollection.get_list(web_forms.web_forms_data)
    i = length(web_forms_data_list)
    Enum.reduce(web_forms_data_list, "", fn nv, acc ->
      acc <> nv.name <> (if nv.value == "", do: "", else: "=" <> String.replace(nv.value, "\"", "$[dq];")) <> (if i > 1, do: "$[sln];", else: "")
    end)
  end

  # Export
  def export_to_web_forms_tag(web_forms, src \\ nil) do
    "<web-forms ac=\"" <> get_forms_action_data_line_break(web_forms) <> "\"" <> (if src, do: " src=\"" <> src <> "\"", else: "") <> "></web-forms>"
  end

  # Overload
  def export_to_web_forms_tag(web_forms, width, height, src \\ nil) do
    "<web-forms ac=\"" <> get_forms_action_data_line_break(web_forms) <> "\" width=\"" <> width <> "\" height=\"" <> height <> "\"" <> (if src, do: " src=\"" <> src <> "\"", else: "") <> "></web-forms>"
  end

  # Overload
  def export_to_web_forms_tag(web_forms, width, height, src \\ nil) when is_integer(width) and is_integer(height) do
    export_to_web_forms_tag(web_forms, Integer.to_string(width) <> "px", Integer.to_string(height) <> "px", src)
  end

  def done_to_web_forms_tag(web_forms, id \\ nil) do
    "<web-forms ac=\"" <> get_forms_action_data_line_break(web_forms) <> "\"" <> (if id, do: " id=\"" <> id <> "\" done=\"true\"", else: "") <> "></web-forms>"
  end

  def export_to_name_value(web_forms) do
    web_forms.web_forms_data
  end

  def append_form(web_forms, form) do
    %{web_forms | web_forms_data: NameValueCollection.add_list(web_forms.web_forms_data, NameValueCollection.get_list(form.web_forms_data))}
  end

  def set_headers(context) do
    context.response.headers["Content-Type"] = "text/plain"
  end

  def clean(web_forms) do
    %{web_forms | web_forms_data: NameValueCollection.empty(web_forms.web_forms_data)}
  end
end

defmodule InputPlace do
  def id(id), do: id
  def name(name), do: "(" <> name <> ")"
  def name(name, index), do: "(" <> name <> ")" <> Integer.to_string(index)
  def tag(tag), do: "<" <> tag <> ">"
  def tag(tag, index), do: "<" <> tag <> ">" <> Integer.to_string(index)
  def class(class), do: "{" <> class <> "}"
  def class(class, index), do: "{" <> class <> "}" <> Integer.to_string(index)
  def query(query), do: "*" <> String.replace(query, "=", "$[eq];")
  def query_all(query), do: "[" <> String.replace(query, "=", "$[eq];")
end

defmodule OutputPlace do
  use InputPlace
end

# Do Not Add Any Data Before Or After It
defmodule Fetch do
  def random(max_value), do: "@mr" <> Integer.to_string(max_value)
  def random(min_value, max_value), do: "@mr" <> Integer.to_string(max_value) <> "," <> Integer.to_string(min_value)
  def date_year, do: "@dy"
  def date_month, do: "@dm"
  def date_day, do: "@dd"
  def date_hours, do: "@dh"
  def date_minutes, do: "@di"
  def date_seconds, do: "@ds"
  def date_milliseconds, do: "@dl"
  def cookie(key), do: "@co" <> key
  def session(key), do: "@cs" <> key
  def session(key, replace_value), do: "@cs" <> key <> "," <> replace_value
  def session_and_remove(key), do: "@cl" <> key
  def session_and_remove(key, replace_value), do: "@cl" <> key <> "," <> replace_value
  def saved(key \\ "."), do: "@cl" <> key
  def cache(key), do: "@cd" <> key
  def cache(key, replace_value), do: "@cd" <> key <> "," <> replace_value
  def cache_and_remove(key), do: "@ct" <> key
  def cache_and_remove(key, replace_value), do: "@ct" <> key <> "," <> replace_value
  def script(script_text), do: "@_" <> String.replace(script_text, "\n", "$[ln];")
end

defmodule HtmlEvent do
  def on_abort, do: "onabort"
  def on_after_print, do: "onafterprint"
  def on_before_print, do: "onbeforeprint"
  def on_before_unload, do: "onbeforeunload"
  def on_blur, do: "onblur"
  def on_can_play, do: "oncanplay"
  def on_can_play_through, do: "oncanplaythrough"
  def on_change, do: "onchange"
  def on_click, do: "onclick"
  def on_copy, do: "oncopy"
  def on_cut, do: "oncut"
  def on_double_click, do: "ondblclick"
  def on_drag, do: "ondrag"
  def on_drag_end, do: "ondragend"
  def on_drag_enter, do: "ondragenter"
  def on_drag_leave, do: "ondragleave"
  def on_drag_over, do: "ondragover"
  def on_drag_start, do: "ondragstart"
  def on_drop, do: "ondrop"
  def on_duration_change, do: "ondurationchange"
  def on_ended, do: "onended"
  def on_error, do: "onerror"
  def on_focus, do: "onfocus"
  def on_focusin, do: "onfocusin"
  def on_focus_out, do: "onfocusout"
  def on_hash_change, do: "onhashchange"
  def on_input, do: "oninput"
  def on_invalid, do: "oninvalid"
  def on_key_down, do: "onkeydown"
  def on_key_press, do: "onkeypress"
  def on_key_up, do: "onkeyup"
  def on_load, do: "onload"
  def on_loaded_data, do: "onloadeddata"
  def on_loaded_meta_data, do: "onloadedmetadata"
  def on_load_start, do: "onloadstart"
  def on_mouse_down, do: "onmousedown"
  def on_mouse_enter, do: "onmouseenter"
  def on_mouse_leave, do: "onmouseleave"
  def on_mouse_move, do: "onmousemove"
  def on_mouse_over, do: "onmouseover"
  def on_mouse_out, do: "onmouseout"
  def on_mouse_up, do: "onmouseup"
  def on_offline, do: "onoffline"
  def on_online, do: "ononline"
  def on_page_hide, do: "onpagehide"
  def on_page_show, do: "onpageshow"
  def on_paste, do: "onpaste"
  def on_pause, do: "onpause"
  def on_play, do: "onplay"
  def on_playing, do: "onplaying"
  def on_progress, do: "onprogress"
  def on_rate_change, do: "onratechange"
  def on_resize, do: "onresize"
  def on_reset, do: "onreset"
  def on_scroll, do: "onscroll"
  def on_search, do: "onsearch"
  def on_seeked, do: "onseeked"
  def on_seeking, do: "onseeking"
  def on_select, do: "onselect"
  def on_stalled, do: "onstalled"
  def on_submit, do: "onsubmit"
  def on_suspend, do: "onsuspend"
  def on_time_update, do: "ontimeupdate"
  def on_toggle, do: "ontoggle"
  def on_touch_cancel, do: "ontouchcancel"
  def on_touchend, do: "ontouchend"
  def on_touch_move, do: "ontouchmove"
  def on_touch_start, do: "ontouchstart"
  def on_unload, do: "onunload"
  def on_volume_change, do: "onvolumechange"
  def on_waiting, do: "onwaiting"
end

defmodule HtmlEventListener do
  def abort, do: "abort"
  def after_print, do: "afterprint"
  def before_print, do: "beforeprint"
  def before_unload, do: "beforeunload"
  def blur, do: "blur"
  def can_play, do: "canplay"
  def can_play_through, do: "canplaythrough"
  def change, do: "change"
  def click, do: "click"
  def copy, do: "copy"
  def cut, do: "cut"
  def double_click, do: "dblclick"
  def drag, do: "drag"
  def drag_end, do: "dragend"
  def drag_enter, do: "dragenter"
  def drag_leave, do: "dragleave"
  def drag_over, do: "dragover"
  def drag_start, do: "dragstart"
  def drop, do: "drop"
  def duration_change, do: "durationchange"
  def ended, do: "ended"
  def error, do: "error"
  def focus, do: "focus"
  def focusin, do: "focusin"
  def focus_out, do: "focusout"
  def hash_change, do: "hashchange"
  def input, do: "input"
  def invalid, do: "invalid"
  def key_down, do: "keydown"
  def key_press, do: "keypress"
  def key_up, do: "keyup"
  def load, do: "load"
  def loaded_data, do: "loadeddata"
  def loaded_meta_data, do: "loadedmetadata"
  def load_start, do: "loadstart"
  def mouse_down, do: "mousedown"
  def mouse_enter, do: "mouseenter"
  def mouse_leave, do: "mouseleave"
  def mouse_move, do: "mousemove"
  def mouse_over, do: "mouseover"
  def mouse_out, do: "mouseout"
  def mouse_up, do: "mouseup"
  def offline, do: "offline"
  def online, do: "online"
  def page_hide, do: "pagehide"
  def page_show, do: "pageshow"
  def paste, do: "paste"
  def pause, do: "pause"
  def play, do: "play"
  def playing, do: "playing"
  def progress, do: "progress"
  def rate_change, do: "ratechange"
  def resize, do: "resize"
  def reset, do: "reset"
  def scroll, do: "scroll"
  def search, do: "search"
  def seeked, do: "seeked"
  def seeking, do: "seeking"
  def select, do: "select"
  def stalled, do: "stalled"
  def submit, do: "submit"
  def suspend, do: "suspend"
  def time_update, do: "timeupdate"
  def toggle, do: "toggle"
  def touch_cancel, do: "touchcancel"
  def touchend, do: "touchend"
  def touch_move, do: "touchmove"
  def touch_start, do: "touchstart"
  def unload, do: "unload"
  def volume_change, do: "volumechange"
  def waiting, do: "waiting"

  def animation_end, do: "animationend"
  def animation_iteration, do: "animationiteration"
  def animation_start, do: "animationstart"
  def context_menu, do: "contextmenu"
  def full_screen_change, do: "fullscreenchange"
  def full_screen_error, do: "fullscreenerror"
  def pop_state, do: "popstate"
  def transition_end, do: "transitionend"
  def storage, do: "storage"
  def wheel, do: "wheel"
end

defmodule ExtensionWebFormsMethods do
  # This Method Does Not Support QueryAll
  def append_place(text, value) do
    if String.length(text) < 1 do
      value
    else
      text <> "|" <> value
    end
  end

  def append_parent(text) do
    "/" <> text
  end

  def export_to_web_forms_tag(src) do
    "<web-forms src=\"" <> src <> "\"></web-forms>"
  end

  # Overload
  def export_to_web_forms_tag(src, width, height) do
    "<web-forms src=\"" <> src <> "\" width=\"" <> Integer.to_string(width) <> "\" height=\"" <> Integer.to_string(height) <> "\"></web-forms>"
  end

  def export_action_controls_to_web_forms_tag(action_controls) do
    "<web-forms ac=\"" <> action_controls <> "\"></web-forms>"
  end

  def remove_outer(text, start_string, end_string) do
    start = String.starts_with?(text, start_string)
    if start do
      end_pos = String.ends_with?(text, end_string)
      if end_pos do
        String.slice(text, String.length(start_string)..-String.length(end_string)-1
      else
        text
      end
    else
      text
    end
  end
end
