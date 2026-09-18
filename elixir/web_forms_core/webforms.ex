# webforms.ex 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
# Compatible with WebFormsJS version 2.1

defmodule WebFormsCore.WebForms do
  import Bitwise

  @gs <<29>>
  @us <<31>>

  defstruct data: ""

  def new, do: %__MODULE__{}

  # Add
  # Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.

  def add_line(form, name, value), do: add(form, name, value)

  # For Extension
  # internal Add
  defp add(form, name, value \\ nil) do
    line = if value == nil, do: name, else: name <> "=" <> value
    new_data =
      if byte_size(form.data) > 0 do
        form.data <> "\n" <> line
      else
        line
      end
    %{form | data: new_data}
  end

  # internal AddToUp
  defp add_to_up(form, name, value \\ nil) do
    line = if value == nil, do: name, else: name <> "=" <> value
    line = if byte_size(form.data) > 0, do: line <> "\n", else: line
    %{form | data: line <> form.data}
  end

  # internal GetLineByIndex
  defp get_line_by_index(form, index) do
    if byte_size(form.data) == 0 do
      ""
    else
      lines = String.split(form.data, "\n")
      index = if index < 0, do: length(lines) + index, else: index
      if index < 0 or index >= length(lines) do
        ""
      else
        Enum.at(lines, index)
      end
    end
  end

  # internal UpdateLineByIndex
  defp update_line_by_index(form, index, name, value) do
    if byte_size(form.data) == 0 do
      form
    else
      lines = String.split(form.data, "\n")
      index = if index < 0, do: length(lines) + index, else: index
      if index < 0 or index >= length(lines) do
        form
      else
        new_line = name <> if(value in [nil, ""], do: "", else: "=" <> value)
        new_lines = List.replace_at(lines, index, new_line)
        %{form | data: Enum.join(new_lines, "\n")}
      end
    end
  end

  # Add
  def add_id(form, input_place, id), do: add(form, "ai" <> input_place, id)
  def add_name(form, input_place, name), do: add(form, "an" <> input_place, name)
  def add_value(form, input_place, value), do: add(form, "av" <> input_place, value)
  def add_class(form, input_place, class), do: add(form, "ac" <> input_place, class)

  def add_style(form, input_place, style_or_name, value \\ nil) do
    content = if value == nil, do: style_or_name, else: style_or_name <> ":" <> value
    add(form, "as" <> input_place, content)
  end

  def add_option_tag(form, input_place, text, value, selected \\ false) do
    add(form, "ao" <> input_place, value <> @gs <> text <> if(selected, do: @gs <> "1", else: ""))
  end

  def add_check_box_tag(form, input_place, text, value, checked \\ false) do
    add(form, "ak" <> input_place, value <> @gs <> text <> if(checked, do: @gs <> "1", else: ""))
  end

  def add_title(form, input_place, title), do: add(form, "al" <> input_place, title)
  def add_label(form, input_place, label), do: add(form, "aA" <> input_place, label)
  def add_text(form, input_place, text), do: add(form, "at" <> input_place, String.replace(text, "\n", "$[ln];"))
  def add_text_to_up(form, input_place, text), do: add(form, "pt" <> input_place, String.replace(text, "\n", "$[ln];"))

  def add_attribute(form, input_place, attribute, value \\ "", splitter \\ 0) do
    splitter_str = if splitter != 0, do: <<splitter::utf8>>, else: ""
    value_part = if value in [nil, ""], do: "", else: @gs <> value
    add(form, "aa" <> input_place, attribute <> @gs <> splitter_str <> value_part)
  end

  def add_tag(form, input_place, tag_name, id \\ "") do
    add(form, "nt" <> input_place, tag_name <> if(id in [nil, ""], do: "", else: @gs <> id))
  end

  def add_tag_to_up(form, input_place, tag_name, id \\ "") do
    add(form, "ut" <> input_place, tag_name <> if(id in [nil, ""], do: "", else: @gs <> id))
  end

  def add_tag_before(form, input_place, tag_name, id \\ "") do
    add(form, "bt" <> input_place, tag_name <> if(id in [nil, ""], do: "", else: @gs <> id))
  end

  def add_tag_after(form, input_place, tag_name, id \\ "") do
    add(form, "ft" <> input_place, tag_name <> if(id in [nil, ""], do: "", else: @gs <> id))
  end

  def add_hidden(form, input_place, name, value, id \\ "") do
    add(form, "ah" <> input_place, name <> @gs <> value <> if(id in [nil, ""], do: "", else: @gs <> id))
  end

  # Set
  # Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.

  def set_id(form, input_place, id), do: add(form, "si" <> input_place, id)
  def set_name(form, input_place, name), do: add(form, "sn" <> input_place, name)
  def set_value(form, input_place, value), do: add(form, "sv" <> input_place, value)
  def set_class(form, input_place, class), do: add(form, "sc" <> input_place, class)

  def set_style(form, input_place, style_or_name, value \\ nil) do
    content = if value == nil, do: style_or_name, else: style_or_name <> ":" <> value
    add(form, "ss" <> input_place, content)
  end

  def set_option_tag(form, input_place, text, value, selected \\ false) do
    add(form, "so" <> input_place, value <> @gs <> text <> if(selected, do: @gs <> "1", else: ""))
  end

  def set_checked(form, input_place, checked \\ false) do
    add(form, "sk" <> input_place, if(checked, do: "1", else: "0"))
  end

  def set_check_box_tag(form, input_place, text, value, checked \\ false) do
    add(form, "sk" <> input_place, value <> @gs <> text <> if(checked, do: @gs <> "1", else: ""))
  end

  def set_title(form, input_place, title), do: add(form, "sl" <> input_place, title)
  def set_label(form, input_place, label), do: add(form, "sA" <> input_place, label)
  def set_text(form, input_place, text), do: add(form, "st" <> input_place, String.replace(text, "\n", "$[ln];"))
  def set_attribute(form, input_place, attribute, value \\ ""), do: add(form, "sa" <> input_place, attribute <> @gs <> if(value in [nil, ""], do: "", else: @gs <> value))

  def set_width(form, input_place, width), do: add(form, "sw" <> input_place, (if is_integer(width), do: "#{width}px", else: width))
  def set_height(form, input_place, height), do: add(form, "sh" <> input_place, (if is_integer(height), do: "#{height}px", else: height))
  def set_background_color(form, input_place, color), do: add(form, "bc" <> input_place, color)
  def set_text_color(form, input_place, color), do: add(form, "tc" <> input_place, color)
  def set_font_name(form, input_place, name), do: add(form, "fn" <> input_place, name)
  def set_font_size(form, input_place, size), do: add(form, "fs" <> input_place, (if is_integer(size), do: "#{size}px", else: size))
  def set_font_bold(form, input_place, bold), do: add(form, "fb" <> input_place, if(bold, do: "1", else: "0"))
  def set_visible(form, input_place, visible), do: add(form, "vi" <> input_place, if(visible, do: "1", else: "0"))
  def set_text_align(form, input_place, align), do: add(form, "ta" <> input_place, align)
  def set_read_only(form, input_place, read_only), do: add(form, "sr" <> input_place, if(read_only, do: "1", else: "0"))
  def set_disabled(form, input_place, disabled), do: add(form, "sd" <> input_place, if(disabled, do: "1", else: "0"))
  def set_focus(form, input_place, focus), do: add(form, "sf" <> input_place, if(focus, do: "1", else: "0"))
  def set_min_length(form, input_place, length), do: add(form, "mn" <> input_place, to_string(length))
  def set_max_length(form, input_place, length), do: add(form, "mx" <> input_place, to_string(length))
  def set_selected_value(form, input_place, value), do: add(form, "ts" <> input_place, value)
  def set_selected_index(form, input_place, index), do: add(form, "ti" <> input_place, to_string(index))

  def set_checked_value(form, input_place, value, checked) do
    add(form, "ks" <> input_place, value <> @gs <> if(checked, do: "1", else: "0"))
  end

  def set_checked_index(form, input_place, index, checked) do
    add(form, "ki" <> input_place, to_string(index) <> @gs <> if(checked, do: "1", else: "0"))
  end

  # Insert
  # Creates the Data only if it does not exist; otherwise, does nothing.

  def insert_id(form, input_place, id), do: add(form, "ii" <> input_place, id)
  def insert_name(form, input_place, name), do: add(form, "in" <> input_place, name)
  def insert_value(form, input_place, value), do: add(form, "iv" <> input_place, value)
  def insert_class(form, input_place, class), do: add(form, "ic" <> input_place, class)

  def insert_style(form, input_place, style_or_name, value \\ nil) do
    content = if value == nil, do: style_or_name, else: style_or_name <> ":" <> value
    add(form, "is" <> input_place, content)
  end

  def insert_option_tag(form, input_place, text, value, selected \\ false) do
    add(form, "io" <> input_place, value <> @gs <> text <> if(selected, do: @gs <> "1", else: ""))
  end

  def insert_check_box_tag(form, input_place, text, value, checked \\ false) do
    add(form, "ik" <> input_place, value <> @gs <> text <> if(checked, do: @gs <> "1", else: ""))
  end

  def insert_title(form, input_place, title), do: add(form, "il" <> input_place, title)
  def insert_label(form, input_place, label), do: add(form, "iA" <> input_place, label)
  def insert_text(form, input_place, text), do: add(form, "it" <> input_place, String.replace(text, "\n", "$[ln];"))

  def insert_attribute(form, input_place, attribute, value \\ "", splitter \\ 0) do
    splitter_str = if splitter != 0, do: <<splitter::utf8>>, else: ""
    value_part = if value in [nil, ""], do: "", else: @gs <> value
    add(form, "ia" <> input_place, attribute <> @gs <> splitter_str <> value_part)
  end

  # Delete

  def delete_id(form, input_place), do: add(form, "di" <> input_place)
  def delete_name(form, input_place), do: add(form, "dn" <> input_place)
  def delete_value(form, input_place), do: add(form, "dv" <> input_place)
  def delete_class(form, input_place, class_name), do: add(form, "dc" <> input_place, class_name)
  def delete_style(form, input_place, style_name), do: add(form, "ds" <> input_place, style_name)
  def delete_option_tag(form, input_place, value), do: add(form, "do" <> input_place, value)
  def delete_all_option_tag(form, input_place), do: add(form, "do" <> input_place, "*")
  def delete_check_box_tag(form, input_place, value), do: add(form, "dk" <> input_place, value)
  def delete_all_check_box_tag(form, input_place), do: add(form, "dk" <> input_place, "*")
  def delete_title(form, input_place), do: add(form, "dl" <> input_place)
  def delete_label(form, input_place), do: add(form, "dA" <> input_place)
  def delete_text(form, input_place), do: add(form, "dt" <> input_place)
  def delete_attribute(form, input_place, attribute), do: add(form, "da" <> input_place, attribute)
  def delete(form, input_place), do: add(form, "de" <> input_place)
  def delete_parent(form, input_place), do: add(form, "dp" <> input_place)

  # Tag

  def swap_tag(form, input_place, output_place), do: add(form, "sp" <> input_place, output_place)
  def set_reflection(form, input_place, tag), do: add(form, "sR" <> input_place, tag)
  def set_reflection_by_output_place(form, input_place, output_place), do: add(form, "iR" <> input_place, output_place)
  def set_morph(form, input_place, tag), do: add(form, "sM" <> input_place, tag)
  def set_morph_by_output_place(form, input_place, output_place), do: add(form, "iM" <> input_place, output_place)

  # Browser

  def change_url(form, url), do: add(form, "cu", url)
  def set_head_title(form, title), do: add(form, "ht", title)
  def clipboard_write_text(form, text), do: add(form, "nw", text)
  def scroll_to(form, x, y), do: add(form, "ws", to_string(x) <> @gs <> to_string(y))
  def history_go(form, steps), do: add(form, "wg", to_string(steps))
  def reload_page(form), do: add(form, "lr")
  def redirect(form, path), do: add(form, "lh", path)

  # Increase

  def increase_min_length(form, input_place, value), do: add(form, "+n" <> input_place, to_string(value))
  def increase_max_length(form, input_place, value), do: add(form, "+x" <> input_place, to_string(value))
  def increase_font_size(form, input_place, value), do: add(form, "+f" <> input_place, to_string(value))
  def increase_width(form, input_place, value), do: add(form, "+w" <> input_place, to_string(value))
  def increase_height(form, input_place, value), do: add(form, "+h" <> input_place, to_string(value))
  def increase_value(form, input_place, value), do: add(form, "+v" <> input_place, to_string(value))

  # Decrease

  def decrease_min_length(form, input_place, value), do: add(form, "-n" <> input_place, to_string(value))
  def decrease_max_length(form, input_place, value), do: add(form, "-x" <> input_place, to_string(value))
  def decrease_font_size(form, input_place, value), do: add(form, "-f" <> input_place, to_string(value))
  def decrease_width(form, input_place, value), do: add(form, "-w" <> input_place, to_string(value))
  def decrease_height(form, input_place, value), do: add(form, "-h" <> input_place, to_string(value))
  def decrease_value(form, input_place, value), do: add(form, "-v" <> input_place, to_string(value))

  # Event
  # ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
  # All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.

  def trigger_event(form, input_place, html_event_listener, constructor_name \\ nil) do
    add(form, "TE" <> input_place, html_event_listener <> if(constructor_name in [nil, ""], do: "", else: @gs <> constructor_name))
  end

  def set_post_event(form, input_place, html_event, output_place \\ nil) do
    value = if output_place == nil, do: html_event, else: html_event <> @gs <> output_place
    add(form, "Ep" <> input_place, value)
  end

  def set_post_event_add_view(form, input_place, html_event), do: add(form, "Ep" <> input_place, html_event <> @gs <> "+")

  def set_post_event_listener(form, input_place, html_event_listener, output_place \\ nil) do
    value = if output_place == nil, do: html_event_listener, else: html_event_listener <> @gs <> output_place
    add(form, "EP" <> input_place, value)
  end

  def set_post_event_listener_add_view(form, input_place, html_event_listener), do: add(form, "EP" <> input_place, html_event_listener <> @gs <> "+")

  def set_get_event(form, input_place, html_event) do
    add(form, "Eg" <> input_place, html_event <> @gs <> "#")
  end

  def set_get_event(form, input_place, html_event, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "Eg" <> input_place, html_event <> @gs <> path_str)
  end

  def set_get_event(form, input_place, html_event, output_place, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "Eg" <> input_place, html_event <> @gs <> path_str <> @gs <> output_place)
  end

  def set_get_event_listener(form, input_place, html_event_listener) do
    add(form, "EG" <> input_place, html_event_listener <> @gs <> "#")
  end

  def set_get_event_listener(form, input_place, html_event_listener, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "EG" <> input_place, html_event_listener <> @gs <> path_str)
  end

  def set_get_event_listener(form, input_place, html_event_listener, output_place, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "EG" <> input_place, html_event_listener <> @gs <> path_str <> @gs <> output_place)
  end

  def set_put_event(form, input_place, html_event) do
    add(form, "Et" <> input_place, html_event <> @gs <> "#")
  end

  def set_put_event(form, input_place, html_event, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "Et" <> input_place, html_event <> @gs <> path_str)
  end

  def set_put_event(form, input_place, html_event, output_place, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "Et" <> input_place, html_event <> @gs <> path_str <> @gs <> output_place)
  end

  def set_put_event_listener(form, input_place, html_event_listener) do
    add(form, "ET" <> input_place, html_event_listener <> @gs <> "#")
  end

  def set_put_event_listener(form, input_place, html_event_listener, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "ET" <> input_place, html_event_listener <> @gs <> path_str)
  end

  def set_put_event_listener(form, input_place, html_event_listener, output_place, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "ET" <> input_place, html_event_listener <> @gs <> path_str <> @gs <> output_place)
  end

  def set_patch_event(form, input_place, html_event) do
    add(form, "Ea" <> input_place, html_event <> @gs <> "#")
  end

  def set_patch_event(form, input_place, html_event, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "Ea" <> input_place, html_event <> @gs <> path_str)
  end

  def set_patch_event(form, input_place, html_event, output_place, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "Ea" <> input_place, html_event <> @gs <> path_str <> @gs <> output_place)
  end

  def set_patch_event_listener(form, input_place, html_event_listener) do
    add(form, "EA" <> input_place, html_event_listener <> @gs <> "#")
  end

  def set_patch_event_listener(form, input_place, html_event_listener, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "EA" <> input_place, html_event_listener <> @gs <> path_str)
  end

  def set_patch_event_listener(form, input_place, html_event_listener, output_place, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "EA" <> input_place, html_event_listener <> @gs <> path_str <> @gs <> output_place)
  end

  def set_delete_event(form, input_place, html_event) do
    add(form, "El" <> input_place, html_event <> @gs <> "#")
  end

  def set_delete_event(form, input_place, html_event, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "El" <> input_place, html_event <> @gs <> path_str)
  end

  def set_delete_event(form, input_place, html_event, output_place, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "El" <> input_place, html_event <> @gs <> path_str <> @gs <> output_place)
  end

  def set_delete_event_listener(form, input_place, html_event_listener) do
    add(form, "EL" <> input_place, html_event_listener <> @gs <> "#")
  end

  def set_delete_event_listener(form, input_place, html_event_listener, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "EL" <> input_place, html_event_listener <> @gs <> path_str)
  end

  def set_delete_event_listener(form, input_place, html_event_listener, output_place, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "EL" <> input_place, html_event_listener <> @gs <> path_str <> @gs <> output_place)
  end

  def set_options_event(form, input_place, html_event) do
    add(form, "Eo" <> input_place, html_event <> @gs <> "#")
  end

  def set_options_event(form, input_place, html_event, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "Eo" <> input_place, html_event <> @gs <> path_str)
  end

  def set_options_event(form, input_place, html_event, output_place, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "Eo" <> input_place, html_event <> @gs <> path_str <> @gs <> output_place)
  end

  def set_options_event_listener(form, input_place, html_event_listener) do
    add(form, "EO" <> input_place, html_event_listener <> @gs <> "#")
  end

  def set_options_event_listener(form, input_place, html_event_listener, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "EO" <> input_place, html_event_listener <> @gs <> path_str)
  end

  def set_options_event_listener(form, input_place, html_event_listener, output_place, path) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "EO" <> input_place, html_event_listener <> @gs <> path_str <> @gs <> output_place)
  end

  def set_head_event(form, input_place, html_event, path \\ nil) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "Eh" <> input_place, html_event <> @gs <> path_str)
  end

  def set_head_event_listener(form, input_place, html_event_listener, path \\ nil) do
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "EH" <> input_place, html_event_listener <> @gs <> path_str)
  end

  # IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
  def set_send_event(form, input_place, html_event, data, path \\ nil, method \\ "POST", is_multi_part \\ false, content_type \\ "text/plain", output_place \\ nil) do
    sanitized_data =
      data
      |> String.replace("\n", "$[ln];")
      |> String.replace("\"", "$[dq];")
      |> String.replace("'", "$[sq];")
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "En" <> input_place,
      html_event <> @gs <> sanitized_data <> @gs <> path_str <> @gs <> method <> @gs <>
      (if is_multi_part, do: "1", else: "0") <> @gs <> content_type <> @gs <> (output_place || ""))
  end

  def set_send_event_listener(form, input_place, html_event_listener, data, path \\ nil, method \\ "POST", is_multi_part \\ false, content_type \\ "text/plain", output_place \\ nil) do
    sanitized_data = String.replace(data, "\n", "$[ln];")
    path_str = if path in [nil, ""], do: "#", else: path
    add(form, "EN" <> input_place,
      html_event_listener <> @gs <> sanitized_data <> @gs <> path_str <> @gs <> method <> @gs <>
      (if is_multi_part, do: "1", else: "0") <> @gs <> content_type <> @gs <> (output_place || ""))
  end

  def set_comment_event(form, input_place, html_event, index \\ nil, output_place \\ nil) do
    index_str = if index == nil, do: "", else: to_string(index)
    add(form, "Eb" <> input_place, html_event <> @gs <> index_str <> @gs <> (output_place || ""))
  end

  def set_comment_event_listener(form, input_place, html_event_listener, index \\ nil, output_place \\ nil) do
    index_str = if index == nil, do: "", else: to_string(index)
    add(form, "EB" <> input_place, html_event_listener <> @gs <> index_str <> @gs <> (output_place || ""))
  end

  def set_wasm_event(form, input_place, html_event, wasm_language, wasm_url, method_name, args \\ nil, output_place \\ nil) do
    args_join =
      if args != nil and length(args) > 0 do
        "[" <> Enum.map_join(args, @us, &to_string/1)
      else
        ""
      end
    add(form, "Ey" <> input_place,
      html_event <> @gs <> wasm_language <> @gs <> wasm_url <> @gs <> method_name <> @gs <>
      args_join <> @gs <> (output_place || ""))
  end

  def set_wasm_event_listener(form, input_place, html_event_listener, wasm_language, wasm_url, method_name, args \\ nil, output_place \\ nil) do
    args_join =
      if args != nil and length(args) > 0 do
        "[" <> Enum.map_join(args, @us, &to_string/1)
      else
        ""
      end
    add(form, "EY" <> input_place,
      html_event_listener <> @gs <> wasm_language <> @gs <> wasm_url <> @gs <> method_name <> @gs <>
      args_join <> @gs <> (output_place || ""))
  end

  def set_web_socket_event(form, input_place, html_event, path), do: add(form, "Ew" <> input_place, html_event <> @gs <> path)
  def set_web_socket_event_listener(form, input_place, html_event_listener, path), do: add(form, "EW" <> input_place, html_event_listener <> @gs <> path)

  def set_sse_event(form, input_place, html_event, path),
    do: do_set_sse_event(form, input_place, "Ee", html_event, path, nil, true, 3000)

  def set_sse_event(form, input_place, html_event, path, should_reconnect) when is_boolean(should_reconnect),
    do: do_set_sse_event(form, input_place, "Ee", html_event, path, nil, should_reconnect, 3000)

  def set_sse_event(form, input_place, html_event, path, output_place) when is_binary(output_place),
    do: do_set_sse_event(form, input_place, "Ee", html_event, path, output_place, true, 3000)

  def set_sse_event(form, input_place, html_event, path, should_reconnect, reconnect_try_timeout)
      when is_boolean(should_reconnect) and is_integer(reconnect_try_timeout),
    do: do_set_sse_event(form, input_place, "Ee", html_event, path, nil, should_reconnect, reconnect_try_timeout)

  def set_sse_event(form, input_place, html_event, path, output_place, should_reconnect) when is_binary(output_place) and is_boolean(should_reconnect),
    do: do_set_sse_event(form, input_place, "Ee", html_event, path, output_place, should_reconnect, 3000)

  def set_sse_event(form, input_place, html_event, path, output_place, should_reconnect, reconnect_try_timeout) when is_binary(output_place) and is_boolean(should_reconnect) and is_integer(reconnect_try_timeout),
    do: do_set_sse_event(form, input_place, "Ee", html_event, path, output_place, should_reconnect, reconnect_try_timeout)

  def set_sse_event_listener(form, input_place, html_event_listener, path),
    do: do_set_sse_event(form, input_place, "EE", html_event_listener, path, nil, true, 3000)

  def set_sse_event_listener(form, input_place, html_event_listener, path, should_reconnect) when is_boolean(should_reconnect),
    do: do_set_sse_event(form, input_place, "EE", html_event_listener, path, nil, should_reconnect, 3000)

  def set_sse_event_listener(form, input_place, html_event_listener, path, output_place) when is_binary(output_place),
    do: do_set_sse_event(form, input_place, "EE", html_event_listener, path, output_place, true, 3000)

  def set_sse_event_listener(form, input_place, html_event_listener, path, should_reconnect, reconnect_try_timeout)
      when is_boolean(should_reconnect) and is_integer(reconnect_try_timeout),
    do: do_set_sse_event(form, input_place, "EE", html_event_listener, path, nil, should_reconnect, reconnect_try_timeout)

  def set_sse_event_listener(form, input_place, html_event_listener, path, output_place, should_reconnect) when is_binary(output_place) and is_boolean(should_reconnect),
    do: do_set_sse_event(form, input_place, "EE", html_event_listener, path, output_place, should_reconnect, 3000)

  def set_sse_event_listener(form, input_place, html_event_listener, path, output_place, should_reconnect, reconnect_try_timeout) when is_binary(output_place) and is_boolean(should_reconnect) and is_integer(reconnect_try_timeout),
    do: do_set_sse_event(form, input_place, "EE", html_event_listener, path, output_place, should_reconnect, reconnect_try_timeout)

  defp do_set_sse_event(form, input_place, prefix, event_key, path, output_place, should_reconnect, reconnect_try_timeout) do
    base = event_key <> @gs <> path <> @gs <> (if should_reconnect, do: "1", else: "0") <> @gs <> Integer.to_string(reconnect_try_timeout)
    value = if output_place == nil, do: base, else: base <> @gs <> output_place
    add(form, prefix <> input_place, value)
  end

  def set_front_event(form, input_place, html_event, module_path, args \\ nil, output_place \\ nil) do
    args_join =
      if args != nil and length(args) > 0 do
        @gs <> "[" <> Enum.map_join(args, @us, &to_string/1)
      else
        ""
      end
    add(form, "Ej" <> input_place, html_event <> @gs <> module_path <> @gs <> (output_place || "") <> args_join)
  end

  def set_front_event_listener(form, input_place, html_event_listener, module_path, args \\ nil, output_place \\ nil) do
    args_join =
      if args != nil and length(args) > 0 do
        @gs <> "[" <> Enum.map_join(args, @us, &to_string/1)
      else
        ""
      end
    add(form, "EJ" <> input_place, html_event_listener <> @gs <> module_path <> @gs <> (output_place || "") <> args_join)
  end

  def set_master_pages_event(form, input_place, html_event, output_place \\ nil), do: add(form, "Eu" <> input_place, html_event <> @gs <> (output_place || ""))
  def set_master_pages_event_listener(form, input_place, html_event_listener, output_place \\ nil), do: add(form, "EU" <> input_place, html_event_listener <> @gs <> (output_place || ""))

  def set_prevent_default_event(form, input_place, html_event), do: add(form, "Ed" <> input_place, html_event)
  def set_prevent_default_event_listener(form, input_place, html_event_listener), do: add(form, "ED" <> input_place, html_event_listener)
  def set_stop_propagation_event(form, input_place, html_event), do: add(form, "Es" <> input_place, html_event)
  def set_stop_propagation_event_listener(form, input_place, html_event_listener), do: add(form, "ES" <> input_place, html_event_listener)

  def set_method_event(form, input_place, html_event, method_name, args \\ nil) do
    args_join =
      if args != nil and length(args) > 0 do
        @gs <> "[" <> Enum.map_join(args, @us, &to_string/1)
      else
        ""
      end
    add(form, "Em" <> input_place, html_event <> @gs <> method_name <> args_join)
  end

  def set_method_event_listener(form, input_place, html_event_listener, method_name, args \\ nil) do
    args_join =
      if args != nil and length(args) > 0 do
        @gs <> "[" <> Enum.map_join(args, @us, &to_string/1)
      else
        ""
      end
    add(form, "EM" <> input_place, html_event_listener <> @gs <> method_name <> args_join)
  end

  def set_module_method_event(form, input_place, html_event, method_name, args \\ nil) do
    args_join =
      if args != nil and length(args) > 0 do
        @gs <> "[" <> Enum.map_join(args, @us, &to_string/1)
      else
        ""
      end
    add(form, "Ex" <> input_place, html_event <> @gs <> method_name <> args_join)
  end

  def set_module_method_event_listener(form, input_place, html_event_listener, method_name, args \\ nil) do
    args_join =
      if args != nil and length(args) > 0 do
        @gs <> "[" <> Enum.map_join(args, @us, &to_string/1)
      else
        ""
      end
    add(form, "EX" <> input_place, html_event_listener <> @gs <> method_name <> args_join)
  end

  def assign_confirm_event(form, input_place, html_event, text \\ "Are you sure you want to proceed?", type \\ "none", title \\ "Confirm", ok_text \\ "OK", cancel_text \\ "Cancel") do
    add(form, "Ef" <> input_place,
      html_event <> @gs <>
      (if text == "Are you sure you want to proceed?", do: "", else: text) <> @gs <>
      (if type == "none", do: "", else: type) <> @gs <>
      (if title == "Confirm", do: "", else: title) <> @gs <>
      (if ok_text == "OK", do: "", else: ok_text) <> @gs <>
      (if cancel_text == "Cancel", do: "", else: cancel_text))
  end

  def remove_post_event(form, input_place, html_event), do: add(form, "Rp" <> input_place, html_event)
  def remove_post_event_listener(form, input_place, html_event_listener), do: add(form, "RP" <> input_place, html_event_listener)
  def remove_get_event(form, input_place, html_event), do: add(form, "Rg" <> input_place, html_event)
  def remove_get_event_listener(form, input_place, html_event_listener), do: add(form, "RG" <> input_place, html_event_listener)
  def remove_put_event(form, input_place, html_event), do: add(form, "Rt" <> input_place, html_event)
  def remove_put_event_listener(form, input_place, html_event_listener), do: add(form, "RT" <> input_place, html_event_listener)
  def remove_patch_event(form, input_place, html_event), do: add(form, "Ra" <> input_place, html_event)
  def remove_patch_event_listener(form, input_place, html_event_listener), do: add(form, "RA" <> input_place, html_event_listener)
  def remove_delete_event(form, input_place, html_event), do: add(form, "Rl" <> input_place, html_event)
  def remove_delete_event_listener(form, input_place, html_event_listener), do: add(form, "RL" <> input_place, html_event_listener)
  def remove_options_event(form, input_place, html_event), do: add(form, "Ro" <> input_place, html_event)
  def remove_options_event_listener(form, input_place, html_event_listener), do: add(form, "RO" <> input_place, html_event_listener)
  def remove_head_event(form, input_place, html_event), do: add(form, "Rh" <> input_place, html_event)
  def remove_head_event_listener(form, input_place, html_event_listener), do: add(form, "RH" <> input_place, html_event_listener)
  def remove_send_event(form, input_place, html_event), do: add(form, "Rn" <> input_place, html_event)
  def remove_send_event_listener(form, input_place, html_event_listener), do: add(form, "RN" <> input_place, html_event_listener)
  def remove_comment_event(form, input_place, html_event), do: add(form, "Rb" <> input_place, html_event)
  def remove_comment_event_listener(form, input_place, html_event_listener), do: add(form, "RB" <> input_place, html_event_listener)
  def remove_wasm_event(form, input_place, html_event), do: add(form, "Ry" <> input_place, html_event)
  def remove_wasm_event_listener(form, input_place, html_event_listener), do: add(form, "RY" <> input_place, html_event_listener)
  def remove_web_socket_event(form, input_place, html_event), do: add(form, "Rw" <> input_place, html_event)
  def remove_web_socket_event_listener(form, input_place, html_event_listener), do: add(form, "RW" <> input_place, html_event_listener)
  def remove_sse_event(form, input_place, html_event), do: add(form, "Re" <> input_place, html_event)
  def remove_sse_event_listener(form, input_place, html_event_listener), do: add(form, "RE" <> input_place, html_event_listener)
  def remove_front_event(form, input_place, html_event), do: add(form, "Rj" <> input_place, html_event)
  def remove_front_event_listener(form, input_place, html_event_listener), do: add(form, "RJ" <> input_place, html_event_listener)
  def remove_prevent_default_event(form, input_place, html_event), do: add(form, "Rd" <> input_place, html_event)
  def remove_prevent_default_event_listener(form, input_place, html_event_listener), do: add(form, "RD" <> input_place, html_event_listener)
  def remove_master_pages_event(form, input_place, html_event), do: add(form, "Ru" <> input_place, html_event)
  def remove_master_pages_event_listener(form, input_place, html_event_listener), do: add(form, "RU" <> input_place, html_event_listener)
  def remove_stop_propagation_event(form, input_place, html_event), do: add(form, "Rs" <> input_place, html_event)
  def remove_stop_propagation_event_listener(form, input_place, html_event_listener), do: add(form, "RS" <> input_place, html_event_listener)
  def remove_method_event(form, input_place, html_event, method_name), do: add(form, "Rm" <> input_place, html_event <> @gs <> method_name)
  def remove_method_event_listener(form, input_place, html_event_listener, method_name), do: add(form, "RM" <> input_place, html_event_listener <> @gs <> method_name)
  def remove_module_method_event(form, input_place, html_event, method_name), do: add(form, "Rx" <> input_place, html_event <> @gs <> method_name)
  def remove_module_method_event_listener(form, input_place, html_event_listener, method_name), do: add(form, "RX" <> input_place, html_event_listener <> @gs <> method_name)
  def remove_confirm_event(form, input_place, html_event), do: add(form, "Rf" <> input_place, html_event)

  # Custom Event
  # This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
  # Watch: attribute, style, text, children, value
  # Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
  # Range: Only Use For Compare With inrange Value. Split By Comma ","
  # Key: Only Use For Watch With attribute And style Value
  def create_custom_dom_event(form, input_place, event_name, watch, key, compare, value, range, immediate \\ false, delay \\ "0") do
    add(form, "eC" <> input_place,
      event_name <> @gs <> watch <> @gs <> key <> @gs <> compare <> @gs <> value <> @gs <> range <> @gs <>
      (if immediate, do: "1", else: "0") <> @gs <> to_string(delay))
  end

  def enable_scroll_bottom_event(form, enable \\ true), do: add(form, "eb", if(enable, do: "1", else: "0"))

  def enable_reached_element_event(form, input_place, once, enable \\ true) do
    add(form, "er" <> input_place, (if once, do: "1", else: "0") <> @gs <> (if enable, do: "1", else: "0"))
  end

  # Module

  def load_module(form, module_path, methods \\ nil) do
    methods = methods || []
    suffix = if length(methods) > 0, do: @gs <> "[" <> Enum.map_join(methods, @us, &to_string/1), else: ""
    add(form, "Ml", module_path <> suffix)
  end

  def unload_module(form, module_path), do: add(form, "Mu", module_path)
  def delete_module_method(form, method_name), do: add(form, "Md", method_name)

  # Unit Testing
  # InputPlace Is Actual, Expected Is Tag/OutputPlace
  def assert_equal(form, input_place, tag), do: add(form, "At" <> input_place, String.replace(tag, "\n", "$[ln];"))
  def assert_equal_by_output_place(form, input_place, output_place), do: add(form, "Ao" <> input_place, output_place)

  # Debug

  def create_debugger(form, pause \\ false), do: add(form, "Dc", if(pause, do: "1", else: "0"))

  # Service Worker
  # To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
  def service_worker_register(form, path \\ nil, scope_path \\ nil), do: add(form, "wR", (path || "") <> @gs <> (scope_path || ""))
  def service_worker_pre_cache_static(form, path_list), do: add(form, "wp", Enum.join(path_list, @gs))
  def service_worker_dynamic_cache(form, path, seconds \\ ""), do: add(form, "wc", path <> if(seconds == "", do: "", else: @gs <> to_string(seconds)))
  def service_worker_delete_dynamic_cache(form), do: add(form, "wd")
  def service_worker_delete_dynamic_cache(form, path), do: add(form, "wd", path)
  def service_worker_dynamic_cache_ttl_update(form, path, seconds \\ ""), do: add(form, "wt", path <> if(seconds == "", do: "", else: @gs <> to_string(seconds)))

  # Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
  # Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
  # CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
  def service_worker_route_set(form, path, type, cache_dynamic \\ false) do
    add(form, "wr", path <> @gs <> type <> if(cache_dynamic, do: @gs <> "1", else: ""))
  end

  def service_worker_route_alias(form, path, to), do: add(form, "wa", path <> @gs <> to)
  def service_worker_delete_route_alias(form, path \\ nil), do: add(form, "wC", path || "")
  # Delete All Route And Alias
  def service_worker_delete_route(form), do: add(form, "wD")
  def service_worker_delete_route(form, path), do: add(form, "wD", path)

  # SSE

  def disconnect_sse(form, path), do: add(form, "Ds", path)
  def disconnect_all_sse(form), do: add(form, "Ds")

  # State

  def add_state(form, path \\ nil, title \\ nil), do: add(form, "AS", (path || "") <> @gs <> (title || ""))
  def save_state(form, path \\ nil, title \\ nil), do: add(form, "As", (path || "") <> @gs <> (title || ""))
  def load_state(form, path), do: add(form, "ls", path)
  def delete_state(form, path \\ nil), do: add(form, "DS", path || "")
  def delete_all_state(form), do: add(form, "DS", "*")

  # Cookie

  def set_cookie(form, key, value, seconds, path \\ nil) do
    add(form, "sC", key <> @gs <> value <> @gs <> to_string(seconds) <> if(path in [nil, ""], do: "", else: @gs <> path))
  end

  # Save (Session Cache)

  def save_id(form, input_place, key \\ "."), do: add(form, "@gi" <> input_place, key)
  def save_name(form, input_place, key \\ "."), do: add(form, "@gn" <> input_place, key)
  def save_value(form, input_place, key \\ "."), do: add(form, "@gv" <> input_place, key)
  def save_value_length(form, input_place, key \\ "."), do: add(form, "@ge" <> input_place, key)
  def save_class(form, input_place, key \\ "."), do: add(form, "@gc" <> input_place, key)
  def save_style(form, input_place, key \\ "."), do: add(form, "@gs" <> input_place, key)
  def save_title(form, input_place, key \\ "."), do: add(form, "@gl" <> input_place, key)
  def save_label(form, input_place, key \\ "."), do: add(form, "@gA" <> input_place, key)
  def save_text(form, input_place, key \\ "."), do: add(form, "@gt" <> input_place, key)
  def save_outer_text(form, input_place, key \\ "."), do: add(form, "@go" <> input_place, key)
  def save_text_length(form, input_place, key \\ "."), do: add(form, "@gg" <> input_place, key)
  def save_attribute(form, input_place, attribute, key \\ "."), do: add(form, "@ga" <> input_place, key <> @gs <> attribute)
  def save_width(form, input_place, key \\ "."), do: add(form, "@gw" <> input_place, key)
  def save_height(form, input_place, key \\ "."), do: add(form, "@gh" <> input_place, key)
  def save_read_only(form, input_place, key \\ "."), do: add(form, "@gr" <> input_place, key)
  def save_selected_index(form, input_place, key \\ "."), do: add(form, "@gx" <> input_place, key)
  def save_text_align(form, input_place, key \\ "."), do: add(form, "@gT" <> input_place, key)
  def save_node_length(form, input_place, key \\ "."), do: add(form, "@gL" <> input_place, key)
  def save_visible(form, input_place, key \\ "."), do: add(form, "@gV" <> input_place, key)
  def save_url(form, url, fetch_script \\ false, key \\ "."), do: add(form, "@gu", key <> @gs <> url <> if(fetch_script, do: @gs <> "1", else: ""))
  def save_index(form, input_place, key \\ "."), do: add(form, "@gI" <> input_place, key)
  def remove_save(form, cache_key), do: add(form, "rs", cache_key)
  def remove_all_save(form), do: add(form, "rs", "*")
  # Calling the SetSave Method Causes Action Control Requests Triggered by Events Using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send Event, to be Temporarily Saved on the Active Page, so the Request will not be Sent to the Server Again.
  def set_save(form), do: add(form, "cs", "*")
  def add_save_value(form, cache_key, value), do: add(form, "SA", cache_key <> @gs <> String.replace(value, "\n", "$[ln];"))
  def insert_save_value(form, cache_key, value), do: add(form, "SI", cache_key <> @gs <> String.replace(value, "\n", "$[ln];"))
  def append_save_value(form, cache_key, value), do: add(form, "SP", cache_key <> @gs <> String.replace(value, "\n", "$[ln];"))

  def replace_save_value(form, cache_key, search_value, value) do
    add(form, "SR", cache_key <> @gs <> String.replace(value, "\n", "$[ln];") <> @gs <> String.replace(search_value, "\n", "$[ln];"))
  end

  # Cache

  def cache_id(form, input_place, key \\ "."), do: add(form, "@ci" <> input_place, key)
  def cache_name(form, input_place, key \\ "."), do: add(form, "@cn" <> input_place, key)
  def cache_value(form, input_place, key \\ "."), do: add(form, "@cv" <> input_place, key)
  def cache_value_length(form, input_place, key \\ "."), do: add(form, "@ce" <> input_place, key)
  def cache_class(form, input_place, key \\ "."), do: add(form, "@cc" <> input_place, key)
  def cache_style(form, input_place, key \\ "."), do: add(form, "@cs" <> input_place, key)
  def cache_title(form, input_place, key \\ "."), do: add(form, "@cl" <> input_place, key)
  def cache_label(form, input_place, key \\ "."), do: add(form, "@cA" <> input_place, key)
  def cache_text(form, input_place, key \\ "."), do: add(form, "@ct" <> input_place, key)
  def cache_outer_text(form, input_place, key \\ "."), do: add(form, "@co" <> input_place, key)
  def cache_text_length(form, input_place, key \\ "."), do: add(form, "@cg" <> input_place, key)
  def cache_attribute(form, input_place, attribute, key \\ "."), do: add(form, "@ca" <> input_place, key <> @gs <> attribute)
  def cache_width(form, input_place, key \\ "."), do: add(form, "@cw" <> input_place, key)
  def cache_height(form, input_place, key \\ "."), do: add(form, "@ch" <> input_place, key)
  def cache_read_only(form, input_place, key \\ "."), do: add(form, "@cr" <> input_place, key)
  def cache_selected_index(form, input_place, key \\ "."), do: add(form, "@cx" <> input_place, key)
  def cache_text_align(form, input_place, key \\ "."), do: add(form, "@cT" <> input_place, key)
  def cache_node_length(form, input_place, key \\ "."), do: add(form, "@cL" <> input_place, key)
  def cache_visible(form, input_place, key \\ "."), do: add(form, "@cV" <> input_place, key)
  def cache_url(form, url, fetch_script \\ false, key \\ "."), do: add(form, "@cu", key <> @gs <> url <> if(fetch_script, do: @gs <> "1", else: ""))
  def cache_index(form, input_place, key \\ "."), do: add(form, "@cI" <> input_place, key)
  def remove_cache(form, cache_key), do: add(form, "rd", cache_key)
  def remove_all_cache(form), do: add(form, "rd", "*")
  # Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
  def set_cache(form, second), do: add(form, "cd", to_string(second))
  def set_cache(form), do: add(form, "cd", "*")
  def add_cache_value(form, cache_key, value), do: add(form, "CA", cache_key <> @gs <> String.replace(value, "\n", "$[ln];"))
  def insert_cache_value(form, cache_key, value), do: add(form, "CI", cache_key <> @gs <> String.replace(value, "\n", "$[ln];"))
  def append_cache_value(form, cache_key, value), do: add(form, "CP", cache_key <> @gs <> String.replace(value, "\n", "$[ln];"))

  def replace_cache_value(form, cache_key, search_value, value) do
    add(form, "CR", cache_key <> @gs <> String.replace(value, "\n", "$[ln];") <> @gs <> String.replace(search_value, "\n", "$[ln];"))
  end

  # Call

  def load_url(form, input_place, url), do: add(form, "lu" <> input_place, url)

  def run_action_controls(form, action_controls, without_web_forms_section \\ true, index \\ nil, use_current_event \\ true) do
    add(form, "lA",
      (if use_current_event, do: "1", else: "0") <> @gs <>
      (if without_web_forms_section, do: "1", else: "0") <> @gs <>
      (index || "") <> @gs <> action_controls)
  end

  def call_script(form, script_text), do: add(form, "_", String.replace(script_text, "\n", "$[ln];"))

  def call_method(form, method_name, args \\ nil) do
    args_join =
      if args != nil and length(args) > 0 do
        @gs <> "[" <> Enum.map_join(args, @us, &to_string/1)
      else
        ""
      end
    add(form, "lm", method_name <> args_join)
  end

  def call_module_method(form, method_name, args \\ nil) do
    args_join =
      if args != nil and length(args) > 0 do
        @gs <> "[" <> Enum.map_join(args, @us, &to_string/1)
      else
        ""
      end
    add(form, "lM", method_name <> args_join)
  end

  def call_post_back(form, form_input_place, output_place \\ nil) do
    add(form, "Lp", "1" <> @gs <> form_input_place <> if(output_place in [nil, ""], do: "", else: @gs <> output_place))
  end

  def call_comment_back(form, index \\ nil, input_place \\ nil, use_current_event \\ true) do
    index_str = if index == nil, do: "", else: to_string(index)
    add(form, "LC", (if use_current_event, do: "1", else: "0") <> @gs <> index_str <> @gs <> (input_place || ""))
  end

  def call_wasm_back(form, wasm_language, wasm_url, method_name, args \\ nil, output_place \\ nil, use_current_event \\ true) do
    args_join =
      if args != nil and length(args) > 0 do
        "[" <> Enum.map_join(args, @us, &to_string/1)
      else
        ""
      end
    add(form, "Ly",
      (if use_current_event, do: "1", else: "0") <> @gs <>
      wasm_language <> @gs <> wasm_url <> @gs <> method_name <> @gs <> args_join <> @gs <> (output_place || ""))
  end

  def call_web_socket_back(form, path, use_current_event \\ true) do
    add(form, "Lw", (if use_current_event, do: "1", else: "0") <> @gs <> path)
  end

  def call_sse_back(form, path, output_place \\ nil, use_current_event \\ true, should_reconnect \\ true, reconnect_try_timeout \\ "3000") do
    add(form, "Ls",
      (if use_current_event, do: "1", else: "0") <> @gs <> path <> @gs <>
      (if should_reconnect, do: "1", else: "0") <> @gs <> to_string(reconnect_try_timeout) <>
      if(output_place in [nil, ""], do: "", else: @gs <> output_place))
  end

  def call_front(form, module_path, args \\ nil, output_place \\ nil, use_current_event \\ true) do
    args_join =
      if args != nil and length(args) > 0 do
        @gs <> "[" <> Enum.map_join(args, @us, &to_string/1)
      else
        ""
      end
    add(form, "Lj", (if use_current_event, do: "1", else: "0") <> @gs <> module_path <> @gs <> (output_place || "") <> args_join)
  end

  def call_get_back(form, path, output_place \\ nil, use_current_event \\ true) do
    add(form, "Lg", (if use_current_event, do: "1", else: "0") <> @gs <> path <> if(output_place in [nil, ""], do: "", else: @gs <> output_place))
  end

  def call_put_back(form, path, output_place \\ nil, use_current_event \\ true) do
    add(form, "Lt", (if use_current_event, do: "1", else: "0") <> @gs <> path <> if(output_place in [nil, ""], do: "", else: @gs <> output_place))
  end

  def call_patch_back(form, path, output_place \\ nil, use_current_event \\ true) do
    add(form, "LP", (if use_current_event, do: "1", else: "0") <> @gs <> path <> if(output_place in [nil, ""], do: "", else: @gs <> output_place))
  end

  def call_delete_back(form, path, output_place \\ nil, use_current_event \\ true) do
    add(form, "Ld", (if use_current_event, do: "1", else: "0") <> @gs <> path <> if(output_place in [nil, ""], do: "", else: @gs <> output_place))
  end

  def call_head_back(form, path, use_current_event \\ true) do
    add(form, "Lh", (if use_current_event, do: "1", else: "0") <> @gs <> path)
  end

  def call_options_back(form, path, output_place \\ nil, use_current_event \\ true) do
    add(form, "Lo", (if use_current_event, do: "1", else: "0") <> @gs <> path <> if(output_place in [nil, ""], do: "", else: @gs <> output_place))
  end

  def call_send_back(form, path, method, is_multi_part, content_type, data, output_place \\ nil, use_current_event \\ true) do
    add(form, "LS",
      (if use_current_event, do: "1", else: "0") <> @gs <> path <> @gs <> method <> @gs <>
      (if is_multi_part, do: "1", else: "0") <> @gs <> content_type <> @gs <> String.replace(data, "\n", "$[ln];") <>
      if(output_place in [nil, ""], do: "", else: @gs <> output_place))
  end

  # Update

  def increase(form, input_place, value), do: add(form, "gt" <> input_place, "i" <> @gs <> to_string(value))
  def decrease(form, input_place, value), do: add(form, "gt" <> input_place, "i" <> @gs <> to_string(value * -1))
  # If You Don't Use Deep Mode, any Tags Inside the Current Tag Will Simply Be Treated as Strings. Deep Mode Does not Remove Inner Elements.
  def replace(form, input_place, value, new_value, also_start_tag \\ false, deep \\ true) do
    add(form, "gt" <> input_place, "r" <> @gs <> value <> @gs <> new_value <> @gs <> (if also_start_tag, do: "1", else: "0") <> @gs <> (if deep, do: "1", else: "0"))
  end
  # HTML Converts Attribute Names to Lowercase, so they Need to Be Written in Lowercase.
  def replace_start_tag(form, input_place, value, new_value), do: add(form, "gt" <> input_place, "s" <> @gs <> value <> @gs <> new_value)

  # Pre Runner

  def assign_delay(form, mili_second, index \\ -1) do
    current_line = get_line_by_index(form, index)
    if current_line in [nil, ""] do
      form
    else
      parts = String.split(current_line, "=", parts: 2)
      new_name = ":" <> Integer.to_string(mili_second) <> ")" <> hd(parts)
      new_value = if length(parts) > 1, do: Enum.at(parts, 1), else: ""
      update_line_by_index(form, index, new_name, new_value)
    end
  end

  def assign_delay_change(form, mili_second, index \\ -1) do
    current_line = get_line_by_index(form, index)
    if current_line in [nil, ""] do
      form
    else
      parts = String.split(current_line, "=", parts: 2)
      current_name = hd(parts)
      current_name =
        if String.starts_with?(current_name, ":") and String.contains?(current_name, ")") do
          closing_bracket = :binary.match(current_name, ")") |> elem(0)
          binary_part(current_name, closing_bracket + 1, byte_size(current_name) - closing_bracket - 1)
        else
          current_name
        end
      new_name = ":" <> Integer.to_string(mili_second) <> ")" <> current_name
      new_value = if length(parts) > 1, do: Enum.at(parts, 1), else: ""
      update_line_by_index(form, index, new_name, new_value)
    end
  end

  def assign_interval(form, mili_second, id \\ nil, index \\ -1) do
    current_line = get_line_by_index(form, index)
    if current_line in [nil, ""] do
      form
    else
      parts = String.split(current_line, "=", parts: 2)
      id_part = if id in [nil, ""], do: "", else: "|" <> id
      new_name = "(" <> Integer.to_string(mili_second) <> id_part <> ")" <> hd(parts)
      new_value = if length(parts) > 1, do: Enum.at(parts, 1), else: ""
      update_line_by_index(form, index, new_name, new_value)
    end
  end

  def assign_interval_change(form, mili_second, id \\ nil, index \\ -1) do
    current_line = get_line_by_index(form, index)
    if current_line in [nil, ""] do
      form
    else
      parts = String.split(current_line, "=", parts: 2)
      current_name = hd(parts)
      current_name =
        if String.starts_with?(current_name, "(") and String.contains?(current_name, ")") do
          closing_bracket = :binary.match(current_name, ")") |> elem(0)
          binary_part(current_name, closing_bracket + 1, byte_size(current_name) - closing_bracket - 1)
        else
          current_name
        end
      id_part = if id in [nil, ""], do: "", else: "|" <> id
      new_name = "(" <> Integer.to_string(mili_second) <> id_part <> ")" <> current_name
      new_value = if length(parts) > 1, do: Enum.at(parts, 1), else: ""
      update_line_by_index(form, index, new_name, new_value)
    end
  end

  def delete_interval(form, id), do: add(form, "Di", id)

  def assign_repeat(form, count, index \\ -1) do
    current_line = get_line_by_index(form, index)
    if current_line in [nil, ""] do
      form
    else
      parts = String.split(current_line, "=", parts: 2)
      new_name = "," <> Integer.to_string(count) <> ")" <> hd(parts)
      new_value = if length(parts) > 1, do: Enum.at(parts, 1), else: ""
      update_line_by_index(form, index, new_name, new_value)
    end
  end

  def assign_repeat_change(form, count, index \\ -1) do
    current_line = get_line_by_index(form, index)
    if current_line in [nil, ""] do
      form
    else
      parts = String.split(current_line, "=", parts: 2)
      current_name = hd(parts)
      current_name =
        if String.starts_with?(current_name, ",") and String.contains?(current_name, ")") do
          closing_bracket = :binary.match(current_name, ")") |> elem(0)
          binary_part(current_name, closing_bracket + 1, byte_size(current_name) - closing_bracket - 1)
        else
          current_name
        end
      new_name = "," <> Integer.to_string(count) <> ")" <> current_name
      new_value = if length(parts) > 1, do: Enum.at(parts, 1), else: ""
      update_line_by_index(form, index, new_name, new_value)
    end
  end

  # Index

  def start_index(form, name), do: add(form, "#", name)
  def start_index(form), do: start_index(form, "")
  # This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
  def start_state(form), do: start_index(form, "$")

  def go_to(form, line), do: go_to(form, line, 1)

  def go_to(form, line, repeat) when is_integer(line) do
    go_to(form, Integer.to_string(line), to_string(repeat))
  end

  def go_to(form, line, repeat) when is_binary(line) and is_binary(repeat) do
    add(form, "&", line <> @gs <> repeat)
  end

  def go_to(form, index, repeat) when is_binary(index) and is_integer(repeat) do
    add(form, "&", "#" <> index <> @gs <> Integer.to_string(repeat))
  end

  # Start

  def start_transient_dom(form, input_place), do: add(form, "td", input_place)
  def end_transient_dom(form), do: add(form, "td", ";")

  # Message
  # Type: warning, problem, help, success, none
  def alert(form, text, type \\ "none", title \\ "Alert", ok_text \\ "OK") do
    add(form, "Al",
      text <> @gs <>
      (if type == "none", do: "", else: type) <> @gs <>
      (if title == "Alert", do: "", else: title) <> @gs <>
      (if ok_text == "OK", do: "", else: ok_text))
  end

  def message(form, text), do: message(form, text, "none", "0")

  def message(form, text, duration) when is_integer(duration) do
    message(form, text, "", Integer.to_string(duration))
  end

  def message(form, text, type) when is_binary(type) do
    message(form, text, type, "0")
  end

  def message(form, text, type, duration) when is_integer(duration) do
    message(form, text, type, Integer.to_string(duration))
  end

  def message(form, text, type, duration) do
    add(form, "me",
      text <> @gs <>
      (if type == "none", do: "", else: type) <> @gs <>
      (if duration == "0", do: "", else: duration))
  end

  # Type: log, info, warn, error, debug, trace, group, groupend, table
  def console_message(form, text, type \\ "log") do
    add(form, "mc", String.replace(text, "\n", "$[ln];") <> if(type == "log", do: "", else: @gs <> type))
  end

  def console_message_assert(form, text, condition), do: add(form, "ma", String.replace(text, "\n", "$[ln];") <> @gs <> condition)

  # Enable
  # Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
  def enable_web_socket(form, enable \\ true), do: add(form, "ew", if(enable, do: "1", else: "0"))
  def enable_web_socket_once(form), do: add(form, "ew", "$")
  def add_web_socket(form, path), do: add(form, "aw" <> path)
  # Disconnected WebSocket
  def delete_web_socket(form, path), do: add(form, "dw" <> path)

  # Use
  # InputPlace Using Only For form Element
  def use_web_socket(form, input_place), do: add(form, "uw" <> input_place)
  def use_only_change_update(form, input_place), do: add(form, "uo" <> input_place)

  # Condition And Loop
  # Condition And Loop Supports Brackets and Then
  # Type: warning, problem, help, success, none
  # Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
  # Nested Conditions and Nested Loops are Possible.

  defp interval_prefix(interval) when interval >= 0, do: "{(" <> Integer.to_string(interval) <> ")"
  defp interval_prefix(_), do: "{"

  def confirm_is_true_accept(form, text \\ "Are you sure you want to proceed?", type \\ "none", title \\ "Confirm", ok_text \\ "OK", cancel_text \\ "Cancel", interval \\ 100) do
    value =
      (if text == "Are you sure you want to proceed?", do: "", else: text) <> @gs <>
      (if type == "none", do: "", else: type) <> @gs <>
      (if title == "Confirm", do: "", else: title) <> @gs <>
      (if ok_text == "OK", do: "", else: ok_text) <> @gs <>
      (if cancel_text == "Cancel", do: "", else: cancel_text)
    add(form, interval_prefix(interval) <> "ct", value)
  end

  def confirm_is_false_accept(form, text \\ "Are you sure you want to proceed?", type \\ "none", title \\ "Confirm", ok_text \\ "OK", cancel_text \\ "Cancel", interval \\ 100) do
    value =
      (if text == "Are you sure you want to proceed?", do: "", else: text) <> @gs <>
      (if type == "none", do: "", else: type) <> @gs <>
      (if title == "Confirm", do: "", else: title) <> @gs <>
      (if ok_text == "OK", do: "", else: ok_text) <> @gs <>
      (if cancel_text == "Cancel", do: "", else: cancel_text)
    add(form, interval_prefix(interval) <> "cf", value)
  end

  def is_greater_than(form, first_value, second_value, interval \\ -1), do: add(form, interval_prefix(interval) <> "gt", first_value <> @gs <> second_value)
  def is_less_than(form, first_value, second_value, interval \\ -1), do: add(form, interval_prefix(interval) <> "lt", first_value <> @gs <> second_value)
  def is_equal_to(form, first_value, second_value, interval \\ -1), do: add(form, interval_prefix(interval) <> "et", first_value <> @gs <> second_value)
  def is_not_equal_to(form, first_value, second_value, interval \\ -1), do: add(form, interval_prefix(interval) <> "Nt", first_value <> @gs <> second_value)
  def exist(form, value, interval \\ -1), do: add(form, interval_prefix(interval) <> "ex", value)
  def not_exist(form, value, interval \\ -1), do: add(form, interval_prefix(interval) <> "nx", value)
  def is_true(form, value, interval \\ -1), do: add(form, interval_prefix(interval) <> "tr", value)
  def is_false(form, value, interval \\ -1), do: add(form, interval_prefix(interval) <> "fa", value)
  def is_match_media(form, value, interval \\ -1), do: add(form, interval_prefix(interval) <> "mm", value)
  def is_not_match_media(form, value, interval \\ -1), do: add(form, interval_prefix(interval) <> "nm", value)
  def include(form, text, value, interval \\ -1), do: add(form, interval_prefix(interval) <> "In", value <> @gs <> text)
  def not_include(form, text, value, interval \\ -1), do: add(form, interval_prefix(interval) <> "Nn", value <> @gs <> text)
  def element_exists(form, input_place, interval \\ -1), do: add(form, interval_prefix(interval) <> "eE", input_place)
  def element_not_exists(form, input_place, interval \\ -1), do: add(form, interval_prefix(interval) <> "nE", input_place)
  def is_regex_match(form, value, pattern, interval \\ -1), do: add(form, interval_prefix(interval) <> "re", value <> @gs <> pattern)
  def is_regex_not_match(form, value, pattern, interval \\ -1), do: add(form, interval_prefix(interval) <> "rn", value <> @gs <> pattern)

  # In: Everything Becomes A JSON List.
  # Key: Creates A Temporary Data In The Browser IndexedDB.
  # Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
  def for_each(form, path, in_, key \\ ".") do
    add(form, "{fe", path <> @gs <> in_ <> @gs <> key)
  end

  def break(form), do: add(form, ";")

  def else_(form), do: add(form, "}e")

  def start_bracket(form), do: add(form, "{")
  def end_bracket(form), do: add(form, "}")

  # Used Then In Condition And Loop Methods
  def then(form, %__MODULE__{} = new_form) do
    data = new_form.data
    new_form =
      if data in [nil, ""] do
        new_form
      else
        if String.contains?(data, "\n") do
          new_form
          |> add_to_up("{")
          |> add("}")
        else
          new_form
        end
      end
    append_form(form, new_form)
  end

  def then(form, configure) when is_function(configure, 1) do
    new_form = configure.(%__MODULE__{})
    then(form, new_form)
  end

  def repeat(form, %__MODULE__{} = new_form, repeat_count) do
    if new_form == nil do
      form
    else
      body_data = new_form.data
      if body_data in [nil, ""] do
        form
      else
        start_line = -(length(String.split(body_data, "\n")))
        form
        |> append_form(new_form)
        |> go_to(start_line, repeat_count - 1)
      end
    end
  end

  def repeat(form, configure, repeat_count) when is_function(configure, 1) do
    new_form = configure.(%__MODULE__{})
    repeat(form, new_form, repeat_count)
  end

  def repeat(form, %__MODULE__{} = new_form, repeat_count, index) do
    if new_form == nil do
      form
    else
      form = form |> go_to(index) |> start_index(index)
      body_data = new_form.data
      if body_data in [nil, ""] do
        form
      else
        form = append_form(form, new_form)
        if index in [nil, ""] do
          index_number =
            form.data
            |> String.split("\n")
            |> Enum.reduce(-1, fn x, acc ->
              if String.starts_with?(x, "#"), do: acc + 1, else: acc
            end)
          go_to(form, Integer.to_string(index_number), repeat_count - 1)
        else
          go_to(form, index, repeat_count - 1)
        end
      end
    end
  end

  def repeat(form, configure, repeat_count, index) when is_function(configure, 1) do
    new_form = configure.(%__MODULE__{})
    repeat(form, new_form, repeat_count, index)
  end

  # Async
  # It Supports Brackets and Then
  def async(form), do: add(form, "{(a)")

  def delay(form, mili_second), do: add(form, "De", to_string(mili_second))

  # Option

  def change_option(form, name, value), do: add(form, "co", name <> @gs <> value)
  def reset_option(form), do: add(form, "ro")
  def reset_option(form, name), do: add(form, "ro", name)

  # Format Storage

  def create_format_storage(form, key, data), do: add(form, ".C", key <> @gs <> data)
  def delete_format_storage(form, key), do: add(form, ".D", key)
  def add_json(form, key, path, value), do: add(form, ".a", key <> @gs <> "j" <> @gs <> value <> @gs <> path)
  # Name: For Support Attribute, Set Double At Sign (@@) Before Name.
  def add_xml(form, key, path, name, value \\ nil), do: add(form, ".a", key <> @gs <> "x" <> @gs <> name <> @gs <> (value || "") <> @gs <> path)
  def add_ini(form, key, path, value, is_ini_like \\ false), do: add(form, ".a", key <> @gs <> "i" <> @gs <> (if is_ini_like, do: "1", else: "0") <> @gs <> value <> @gs <> path)
  def add_text_line(form, key, line, text), do: add(form, ".a", key <> @gs <> "t" <> @gs <> text <> @gs <> to_string(line))
  def add_variable(form, key, value), do: add(form, ".a", key <> @gs <> "v" <> @gs <> value)
  def update_json(form, key, path, value), do: add(form, ".u", key <> @gs <> "j" <> @gs <> value <> @gs <> path)
  def update_xml(form, key, path, value), do: add(form, ".u", key <> @gs <> "x" <> @gs <> value <> @gs <> path)
  def update_ini(form, key, path, value, is_ini_like \\ false), do: add(form, ".u", key <> @gs <> "i" <> @gs <> (if is_ini_like, do: "1", else: "0") <> @gs <> value <> @gs <> path)
  def update_tex_line(form, key, line, text), do: add(form, ".u", key <> @gs <> "t" <> @gs <> text <> @gs <> to_string(line))
  def update_variable(form, key, value), do: add(form, ".u", key <> @gs <> "v" <> @gs <> value)
  def increase_variable(form, key, value), do: add(form, ".i", key <> @gs <> "v" <> @gs <> to_string(value))
  def decrease_variable(form, key, value), do: increase_variable(form, key, value * -1)
  def delete_json(form, key, path), do: add(form, ".d", key <> @gs <> "j" <> @gs <> path)
  def delete_xml(form, key, path), do: add(form, ".d", key <> @gs <> "x" <> @gs <> path)
  def delete_ini(form, key, path, is_ini_like \\ false), do: add(form, ".d", key <> @gs <> "i" <> @gs <> (if is_ini_like, do: "True", else: "False") <> @gs <> path)
  def delete_text_line(form, key, line), do: add(form, ".d", key <> @gs <> "t" <> @gs <> to_string(line))
  def delete_variable(form, key), do: add(form, ".d", key <> @gs <> "v")

  # Template Engine
  # Pattern Example: {{value}}, ((value)), *value*, $value;
  def bind_json_to_template(form, input_place, json_text, path, pattern, also_start_tag \\ true) do
    add(form, "Tj" <> input_place, json_text <> @gs <> path <> @gs <> pattern <> @gs <> (if also_start_tag, do: "1", else: "0"))
  end
  # Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
  def bind_xml_to_template(form, input_place, xml_text, path, pattern, also_start_tag \\ true) do
    add(form, "Tx" <> input_place, xml_text <> @gs <> path <> @gs <> pattern <> @gs <> (if also_start_tag, do: "1", else: "0"))
  end
  def bind_ini_to_template(form, input_place, ini_text, path, pattern, also_start_tag \\ true) do
    add(form, "Ti" <> input_place, ini_text <> @gs <> path <> @gs <> pattern <> @gs <> (if also_start_tag, do: "1", else: "0"))
  end

  # Inject
  # Need Add @: to First of String
  def inject(value), do: "$[" <> value <> "];"

  # Action Control

  def replace_action_control(form, search_value, value, adding_to_up \\ false) do
    content = search_value <> @gs <> value
    if adding_to_up do
      add_to_up(form, "rE", content)
    else
      add(form, "rE", content)
    end
  end

  def assign_replace(form, search_value, value, index \\ -1) do
    current_line = get_line_by_index(form, index)
    if current_line in [nil, ""] do
      form
    else
      parts = String.split(current_line, "=", parts: 2)
      new_name = ";" <> search_value <> @gs <> value <> @gs <> hd(parts)
      new_value = if length(parts) > 1, do: Enum.at(parts, 1), else: ""
      update_line_by_index(form, index, new_name, new_value)
    end
  end

  # Hash And Checksum

  def set_hash(form), do: add(form, "SH")
  def set_checksum(form), do: add(form, "CS")

  def checksum_calculation(text) do
    mod = 65536
    shift = 5

    utf16 = :unicode.characters_to_binary(text, :utf8, :utf16)

    sum =
      for <<cu::16 <- utf16>>, reduce: 0 do
        sum ->
          s = bxor(bor(bsl(sum, shift), bsr(sum, 16 - shift)), cu)
          rem(s, mod)
      end

    Integer.to_string(sum)
  end

  def get_checksum(form), do: checksum_calculation(get_web_forms_data(form))

  # Get

  def get_forms_action_data(form) do
    if byte_size(form.data) == 0, do: "", else: form.data
  end

  def response(form), do: "[web-forms]\n" <> get_forms_action_data(form)

  def get_forms_action_data_line_break(form) do
    if byte_size(form.data) == 0 do
      ""
    else
      form.data
      |> String.replace("\"", "$[dq];")
      |> String.replace("\n", "$[sln];")
    end
  end

  # Export

  def export_to_html_comment(form, add_line \\ false) do
    response = form |> response() |> String.replace("--", "$[dd];")
    response =
      if String.ends_with?(response, "-") do
        binary_part(response, 0, byte_size(response) - 1) <> "$[da];"
      else
        response
      end
    (if add_line, do: "\n", else: "") <> "<!--" <> response <> "-->"
  end

  # Using it for SSE Response
  def export_to_line_break(form, _src \\ nil) do
    "[web-forms]$[sln];" <> get_forms_action_data_line_break(form)
  end

  def get_web_forms_data(form), do: form.data

  def append_form(form, nil), do: form

  def append_form(form, other_form) do
    other_data = other_form.data
    if other_data in [nil, ""] do
      form
    else
      new_data =
        if byte_size(form.data) > 0 do
          form.data <> "\n" <> other_data
        else
          other_data
        end
      %{form | data: new_data}
    end
  end

  def clean(form), do: %{form | data: ""}
end
