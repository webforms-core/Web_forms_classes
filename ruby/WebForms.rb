# Compatible with WebFormsJS version 1.6

class WebForms
  attr_accessor :web_forms_data

  def initialize
    @web_forms_data = NameValueCollection.new
  end

  # For Extension
  def add_line(name, value)
    @web_forms_data.add(name, value)
  end

  # Add
  def add_id(input_place, id)
    @web_forms_data.add("ai#{input_place}", id)
  end

  def add_name(input_place, name)
    @web_forms_data.add("an#{input_place}", name)
  end

  def add_value(input_place, value)
    @web_forms_data.add("av#{input_place}", value)
  end

  def add_class(input_place, class_name)
    @web_forms_data.add("ac#{input_place}", class_name)
  end

  def add_style(input_place, style)
    @web_forms_data.add("as#{input_place}", style)
  end

  def add_style_with_name_value(input_place, name, value)
    @web_forms_data.add("as#{input_place}", "#{name}:#{value}")
  end

  def add_option_tag(input_place, text, value, selected = false)
    option_value = "#{value}|#{text}#{selected ? '|1' : ''}"
    @web_forms_data.add("ao#{input_place}", option_value)
  end

  def add_check_box_tag(input_place, text, value, checked = false)
    check_box_value = "#{value}|#{text}#{checked ? '|1' : ''}"
    @web_forms_data.add("ak#{input_place}", check_box_value)
  end

  def add_title(input_place, title)
    @web_forms_data.add("al#{input_place}", title)
  end

  def add_text(input_place, text)
    @web_forms_data.add("at#{input_place}", text.gsub("\n", "$[ln];"))
  end

  def add_text_to_up(input_place, text)
    @web_forms_data.add("pt#{input_place}", text.gsub("\n", "$[ln];"))
  end

  def add_attribute(input_place, attribute, value = "")
    @web_forms_data.add("aa#{input_place}", "#{attribute}|#{value}")
  end

  def add_tag(input_place, tag_name, id = "")
    @web_forms_data.add("nt#{input_place}", "#{tag_name}#{id.empty? ? '' : "|#{id}"}")
  end

  def add_tag_to_up(input_place, tag_name, id = "")
    @web_forms_data.add("ut#{input_place}", "#{tag_name}#{id.empty? ? '' : "|#{id}"}")
  end

  def add_tag_before(input_place, tag_name, id = "")
    @web_forms_data.add("bt#{input_place}", "#{tag_name}#{id.empty? ? '' : "|#{id}"}")
  end

  def add_tag_after(input_place, tag_name, id = "")
    @web_forms_data.add("ft#{input_place}", "#{tag_name}#{id.empty? ? '' : "|#{id}"}")
  end

  # Set
  def set_id(input_place, id)
    @web_forms_data.add("si#{input_place}", id)
  end

  def set_name(input_place, name)
    @web_forms_data.add("sn#{input_place}", name)
  end

  def set_value(input_place, value)
    @web_forms_data.add("sv#{input_place}", value)
  end

  def set_class(input_place, class_name)
    @web_forms_data.add("sc#{input_place}", class_name)
  end

  def set_style(input_place, style)
    @web_forms_data.add("ss#{input_place}", style)
  end

  def set_style_with_name_value(input_place, name, value)
    @web_forms_data.add("ss#{input_place}", "#{name}:#{value}")
  end

  def set_option_tag(input_place, text, value, selected = false)
    option_value = "#{value}|#{text}#{selected ? '|1' : ''}"
    @web_forms_data.add("so#{input_place}", option_value)
  end

  def set_checked(input_place, checked = false)
    @web_forms_data.add("sk#{input_place}", checked ? "1" : "0")
  end

  def set_check_box_tag_to_list(input_place, text, value, checked = false)
    check_box_value = "#{value}|#{text}#{checked ? '|1' : ''}"
    @web_forms_data.add("sk#{input_place}", check_box_value)
  end

  def set_title(input_place, title)
    @web_forms_data.add("sl#{input_place}", title)
  end

  def set_text(input_place, text)
    @web_forms_data.add("st#{input_place}", text.gsub("\n", "$[ln];"))
  end

  def set_attribute(input_place, attribute, value = "")
    @web_forms_data.add("sa#{input_place}", "#{attribute}#{value.empty? ? '' : "|#{value}"}")
  end

  def set_width(input_place, width)
    @web_forms_data.add("sw#{input_place}", width)
  end

  def set_width_px(input_place, width)
    set_width(input_place, "#{width}px")
  end

  def set_height(input_place, height)
    @web_forms_data.add("sh#{input_place}", height)
  end

  def set_height_px(input_place, height)
    set_height(input_place, "#{height}px")
  end

  # Insert
  def insert_id(input_place, id)
    @web_forms_data.add("ii#{input_place}", id)
  end

  def insert_name(input_place, name)
    @web_forms_data.add("in#{input_place}", name)
  end

  def insert_value(input_place, value)
    @web_forms_data.add("iv#{input_place}", value)
  end

  def insert_class(input_place, class_name)
    @web_forms_data.add("ic#{input_place}", class_name)
  end

  def insert_style(input_place, style)
    @web_forms_data.add("is#{input_place}", style)
  end

  def insert_style_with_name_value(input_place, name, value)
    @web_forms_data.add("is#{input_place}", "#{name}:#{value}")
  end

  def insert_option_tag(input_place, text, value, selected = false)
    option_value = "#{value}|#{text}#{selected ? '|1' : ''}"
    @web_forms_data.add("io#{input_place}", option_value)
  end

  def insert_check_box_tag(input_place, text, value, checked = false)
    check_box_value = "#{value}|#{text}#{checked ? '|1' : ''}"
    @web_forms_data.add("ik#{input_place}", check_box_value)
  end

  def insert_title(input_place, title)
    @web_forms_data.add("il#{input_place}", title)
  end

  def insert_text(input_place, text)
    @web_forms_data.add("it#{input_place}", text.gsub("\n", "$[ln];"))
  end

  def insert_attribute(input_place, attribute, value = "")
    @web_forms_data.add("ia#{input_place}", "#{attribute}#{value.empty? ? '' : "|#{value}"}")
  end

  # Delete
  def delete_id(input_place)
    @web_forms_data.add("di#{input_place}", "1")
  end

  def delete_name(input_place)
    @web_forms_data.add("dn#{input_place}", "1")
  end

  def delete_value(input_place)
    @web_forms_data.add("dv#{input_place}", "1")
  end

  def delete_class(input_place, class_name)
    @web_forms_data.add("dc#{input_place}", class_name)
  end

  def delete_style(input_place, style_name)
    @web_forms_data.add("ds#{input_place}", style_name)
  end

  def delete_option_tag(input_place, value)
    @web_forms_data.add("do#{input_place}", value)
  end

  def delete_all_option_tag(input_place)
    @web_forms_data.add("do#{input_place}", "*")
  end

  def delete_check_box_tag(input_place, value)
    @web_forms_data.add("dk#{input_place}", value)
  end

  def delete_all_check_box_tag(input_place)
    @web_forms_data.add("dk#{input_place}", "*")
  end

  def delete_title(input_place)
    @web_forms_data.add("dl#{input_place}", "1")
  end

  def delete_text(input_place)
    @web_forms_data.add("dt#{input_place}", "1")
  end

  def delete_attribute(input_place, attribute)
    @web_forms_data.add("da#{input_place}", attribute)
  end

  def delete(input_place)
    @web_forms_data.add("de#{input_place}", "1")
  end

  def delete_parent(input_place)
    @web_forms_data.add("dp#{input_place}", "1")
  end

  # Other
  def set_background_color(input_place, color)
    @web_forms_data.add("bc#{input_place}", color)
  end

  def set_text_color(input_place, color)
    @web_forms_data.add("tc#{input_place}", color)
  end

  def set_font_name(input_place, name)
    @web_forms_data.add("fn#{input_place}", name)
  end

  def set_font_size_string(input_place, size)
    @web_forms_data.add("fs#{input_place}", size)
  end

  def set_font_size(input_place, size)
    set_font_size_string(input_place, "#{size}px")
  end

  def set_font_bold(input_place, bold)
    @web_forms_data.add("fb#{input_place}", bold ? "1" : "0")
  end

  def set_visible(input_place, visible)
    @web_forms_data.add("vi#{input_place}", visible ? "1" : "0")
  end

  def set_text_align(input_place, align)
    @web_forms_data.add("ta#{input_place}", align)
  end

  def set_read_only(input_place, read_only)
    @web_forms_data.add("sr#{input_place}", read_only ? "1" : "0")
  end

  def set_disabled(input_place, disabled)
    @web_forms_data.add("sd#{input_place}", disabled ? "1" : "0")
  end

  def set_focus(input_place, focus)
    @web_forms_data.add("sf#{input_place}", focus ? "1" : "0")
  end

  def set_min_length(input_place, length)
    @web_forms_data.add("mn#{input_place}", length.to_s)
  end

  def set_max_length(input_place, length)
    @web_forms_data.add("mx#{input_place}", length.to_s)
  end

  def set_selected_value(input_place, value)
    @web_forms_data.add("ts#{input_place}", value)
  end

  def set_selected_index(input_place, index)
    @web_forms_data.add("ti#{input_place}", index.to_s)
  end

  def set_checked_value(input_place, value, selected)
    @web_forms_data.add("ks#{input_place}", "#{value}|#{selected ? '1' : '0'}")
  end

  def set_checked_index(input_place, index, selected)
    @web_forms_data.add("ki#{input_place}", "#{index}|#{selected ? '1' : '0'}")
  end

  def call_script(script_text)
    @web_forms_data.add("_", script_text.gsub("\n", "$[ln];"))
  end

  def load_url(input_place, url)
    @web_forms_data.add("lu#{input_place}", url)
  end

  def change_url(url)
    @web_forms_data.add("cu", url)
  end

  def remove_session_cache(cache_key)
    @web_forms_data.add("rs", cache_key)
  end

  def remove_all_session_cache
    @web_forms_data.add("rs", "*")
  end

  def remove_cache(cache_key)
    @web_forms_data.add("rd", cache_key)
  end

  def remove_all_cache
    @web_forms_data.add("rd", "*")
  end

  def set_session_cache
    @web_forms_data.add("cs", "1")
  end

  def set_cache(second = nil)
    @web_forms_data.add("cd", second ? second.to_s : "*")
  end

  # Increase
  def increase_min_length(input_place, value)
    @web_forms_data.add("+n#{input_place}", value.to_s)
  end

  def increase_max_length(input_place, value)
    @web_forms_data.add("+x#{input_place}", value.to_s)
  end

  def increase_font_size(input_place, value)
    @web_forms_data.add("+f#{input_place}", value.to_s)
  end

  def increase_width(input_place, value)
    @web_forms_data.add("+w#{input_place}", value.to_s)
  end

  def increase_height(input_place, value)
    @web_forms_data.add("+h#{input_place}", value.to_s)
  end

  def increase_value(input_place, value)
    @web_forms_data.add("+v#{input_place}", value.to_s)
  end

  # Decrease
  def decrease_min_length(input_place, value)
    @web_forms_data.add("-n#{input_place}", value.to_s)
  end

  def decrease_max_length(input_place, value)
    @web_forms_data.add("-x#{input_place}", value.to_s)
  end

  def decrease_font_size(input_place, value)
    @web_forms_data.add("-f#{input_place}", value.to_s)
  end

  def decrease_width(input_place, value)
    @web_forms_data.add("-w#{input_place}", value.to_s)
  end

  def decrease_height(input_place, value)
    @web_forms_data.add("-h#{input_place}", value.to_s)
  end

  def decrease_value(input_place, value)
    @web_forms_data.add("-v#{input_place}", value.to_s)
  end

  # Event
  def set_post_event(input_place, html_event)
    @web_forms_data.add("Ep#{input_place}", html_event)
  end

  def set_post_event_adding(input_place, html_event)
    @web_forms_data.add("Ep#{input_place}", "#{html_event}|+")
  end

  def set_post_event_to(input_place, html_event, output_place)
    @web_forms_data.add("Ep#{input_place}", "#{html_event}|#{output_place}")
  end

  def set_post_event_listener(input_place, html_event_listener)
    @web_forms_data.add("EP#{input_place}", html_event_listener)
  end

  def set_post_event_listener_adding(input_place, html_event_listener)
    @web_forms_data.add("EP#{input_place}", "#{html_event_listener}|+")
  end

  def set_post_event_listener_to(input_place, html_event_listener, output_place)
    @web_forms_data.add("EP#{input_place}", "#{html_event_listener}|#{output_place}")
  end

  def set_get_event(input_place, html_event, path = nil)
    @web_forms_data.add("Eg#{input_place}", "#{html_event}|#{path || '#'}")
  end

  def set_get_event_with_output(input_place, html_event, output_place, path = nil)
    @web_forms_data.add("Eg#{input_place}", "#{html_event}|#{path || '#'}|#{output_place}")
  end

  def set_get_event_in_form(input_place, html_event)
    @web_forms_data.add("Eg#{input_place}", html_event)
  end

  def set_get_event_in_form_with_output(input_place, html_event, output_place)
    @web_forms_data.add("Eg#{input_place}", "#{html_event}|#{output_place}")
  end

  def set_get_event_listener(input_place, html_event_listener, path = nil)
    @web_forms_data.add("EG#{input_place}", "#{html_event_listener}|#{path || '#'}")
  end

  def set_get_event_listener_with_output(input_place, html_event_listener, output_place, path = nil)
    @web_forms_data.add("EG#{input_place}", "#{html_event_listener}|#{path || '#'}|#{output_place}")
  end

  def set_get_event_in_form_listener(input_place, html_event_listener)
    @web_forms_data.add("EG#{input_place}", html_event_listener)
  end

  def set_get_event_in_form_listener_with_output(input_place, html_event_listener, output_place)
    @web_forms_data.add("EG#{input_place}", "#{html_event_listener}|#{output_place}")
  end

  def set_tag_event(input_place, html_event, output_place)
    @web_forms_data.add("Et#{input_place}", "#{html_event}|#{output_place}")
  end

  def set_tag_event_listener(input_place, html_event, output_place)
    @web_forms_data.add("ET#{input_place}", "#{html_event}|#{output_place}")
  end

  def remove_post_event(input_place, html_event)
    @web_forms_data.add("Rp#{input_place}", html_event)
  end

  def remove_get_event(input_place, html_event)
    @web_forms_data.add("Rg#{input_place}", html_event)
  end

  def remove_tag_event(input_place, html_event)
    @web_forms_data.add("Rt#{input_place}", html_event)
  end

  def remove_post_event_listener(input_place, html_event_listener)
    @web_forms_data.add("RP#{input_place}", html_event_listener)
  end

  def remove_get_event_listener(input_place, html_event_listener)
    @web_forms_data.add("RG#{input_place}", html_event_listener)
  end

  def remove_tag_event_listener(input_place, html_event_listener)
    @web_forms_data.add("RT#{input_place}", html_event_listener)
  end

  # Save
  def save_id(input_place, key = ".")
    @web_forms_data.add("@gi#{input_place}", key)
  end

  def save_name(input_place, key = ".")
    @web_forms_data.add("@gn#{input_place}", key)
  end

  def save_value(input_place, key = ".")
    @web_forms_data.add("@gv#{input_place}", key)
  end

  def save_value_length(input_place, key = ".")
    @web_forms_data.add("@ge#{input_place}", key)
  end

  def save_class(input_place, key = ".")
    @web_forms_data.add("@gc#{input_place}", key)
  end

  def save_style(input_place, key = ".")
    @web_forms_data.add("@gs#{input_place}", key)
  end

  def save_title(input_place, key = ".")
    @web_forms_data.add("@gl#{input_place}", key)
  end

  def save_text(input_place, key = ".")
    @web_forms_data.add("@gt#{input_place}", key)
  end

  def save_text_length(input_place, key = ".")
    @web_forms_data.add("@gg#{input_place}", key)
  end

  def save_attribute(input_place, attribute, key = ".")
    @web_forms_data.add("@ga#{input_place}", "#{key}|#{attribute}")
  end

  def save_width(input_place, key = ".")
    @web_forms_data.add("@gw#{input_place}", key)
  end

  def save_height(input_place, key = ".")
    @web_forms_data.add("@gh#{input_place}", key)
  end

  def save_read_only(input_place, key = ".")
    @web_forms_data.add("@gr#{input_place}", key)
  end

  def save_selected_index(input_place, key = ".")
    @web_forms_data.add("@gx#{input_place}", key)
  end

  def save_text_align(input_place, key = ".")
    @web_forms_data.add("@ta#{input_place}", key)
  end

  def save_node_length(input_place, key = ".")
    @web_forms_data.add("@nl#{input_place}", key)
  end

  def save_visible(input_place, key = ".")
    @web_forms_data.add("@vi#{input_place}", key)
  end

  # Pre Runner
  def assign_delay(second, index = -1)
    current_name = @web_forms_data.get_name_by_index(index)
    return if current_name.nil? || current_name.empty?

    @web_forms_data.change_name_by_index(index, ":#{second})#{current_name}")
  end

  def assign_delay_change(second, index = -1)
    current_name = @web_forms_data.get_name_by_index(index)
    return if current_name.nil? || current_name.empty?

    current_name = current_name.gsub(/^:|\)/, '')
    @web_forms_data.change_name_by_index(index, ":#{second})#{current_name}")
  end

  def assign_interval(second, index = -1)
    current_name = @web_forms_data.get_name_by_index(index)
    return if current_name.nil? || current_name.empty?

    @web_forms_data.change_name_by_index(index, "(#{second})#{current_name}")
  end

  def assign_interval_change(second, index = -1)
    current_name = @web_forms_data.get_name_by_index(index)
    return if current_name.nil? || current_name.empty?

    current_name = current_name.gsub(/^\(|\)/, '')
    @web_forms_data.change_name_by_index(index, "(#{second})#{current_name}")
  end

  # Index
  def start_index(name = "")
    @web_forms_data.add("#", name)
  end

  # Get
  def get_forms_action_data
    return_value = ""
    @web_forms_data.get_list.each do |nv|
      return_value += "\n#{nv.name}"
      return_value += "=#{nv.value}" unless nv.value.empty?
    end
    return_value
  end

  def response
    "[web-forms]#{get_forms_action_data}"
  end

  def get_forms_action_data_line_break
    return_value = ""
    web_forms_data_list = @web_forms_data.get_list
    i = web_forms_data_list.size
    web_forms_data_list.each do |nv|
      return_value += nv.name
      return_value += "=#{nv.value.gsub('"', '$[dq];')}" unless nv.value.empty?
      return_value += "$[sln];" if (i -= 1) > 0
    end
    return_value
  end

  # Export
  def export_to_web_forms_tag(src = nil)
    "<web-forms ac=\"#{get_forms_action_data_line_break}\"#{src ? " src=\"#{src}\"" : ''}></web-forms>"
  end

  def export_to_web_forms_tag_with_size(width, height, src = nil)
    "<web-forms ac=\"#{get_forms_action_data_line_break}\" width=\"#{width}\" height=\"#{height}\"#{src ? " src=\"#{src}\"" : ''}></web-forms>"
  end

  def export_to_web_forms_tag_with_size_px(width, height, src = nil)
    export_to_web_forms_tag_with_size("#{width}px", "#{height}px", src)
  end

  def done_to_web_forms_tag(id = nil)
    "<web-forms ac=\"#{get_forms_action_data_line_break}\"#{id ? " id=\"#{id}\" done=\"true\"" : ''}></web-forms>"
  end

  def export_to_name_value
    @web_forms_data
  end

  def append_form(form)
    @web_forms_data.add_list(form.export_to_name_value.get_list)
  end

  def clean
    @web_forms_data = NameValueCollection.new
  end
end

class InputPlace
  def self.id(id)
    id
  end

  def self.name(name)
    "(#{name})"
  end

  def self.name_with_index(name, index)
    "(#{name})#{index}"
  end

  def self.tag(tag)
    "<#{tag}>"
  end

  def self.tag_with_index(tag, index)
    "<#{tag}>#{index}"
  end

  def self.class(class_name)
    "{#{class_name}}"
  end

  def self.class_with_index(class_name, index)
    "{#{class_name}}#{index}"
  end

  def self.query(query)
    "*#{query.gsub('=', '$[eq];')}"
  end

  def self.query_all(query)
    "[#{query.gsub('=', '$[eq];')}"
  end
end

class OutputPlace < InputPlace
end

class Fetch
  def self.random(max_value)
    "@mr#{max_value}"
  end

  def self.random_range(min_value, max_value)
    "@mr#{max_value},#{min_value}"
  end

  def self.date_year
    "@dy"
  end

  def self.date_month
    "@dm"
  end

  def self.date_day
    "@dd"
  end

  def self.date_hours
    "@dh"
  end

  def self.date_minutes
    "@di"
  end

  def self.date_seconds
    "@ds"
  end

  def self.date_milliseconds
    "@dl"
  end

  def self.cookie(key)
    "@co#{key}"
  end

  def self.session(key)
    "@cs#{key}"
  end

  def self.session_with_replace(key, replace_value)
    "@cs#{key},#{replace_value}"
  end

  def self.session_and_remove(key)
    "@cl#{key}"
  end

  def self.session_and_remove_with_replace(key, replace_value)
    "@cl#{key},#{replace_value}"
  end

  def self.saved(key = ".")
    "@cl#{key}"
  end

  def self.cache(key)
    "@cd#{key}"
  end

  def self.cache_with_replace(key, replace_value)
    "@cd#{key},#{replace_value}"
  end

  def self.cache_and_remove(key)
    "@ct#{key}"
  end

  def self.cache_and_remove_with_replace(key, replace_value)
    "@ct#{key},#{replace_value}"
  end

  def self.script(script_text)
    "@_#{script_text.gsub("\n", '$[ln];')}"
  end
end

class HtmlEvent
  def self.on_abort
    "onabort"
  end

  def self.on_after_print
    "onafterprint"
  end

  def self.on_before_print
    "onbeforeprint"
  end

  def self.on_before_unload
    "onbeforeunload"
  end

  def self.on_blur
    "onblur"
  end

  def self.on_can_play
    "oncanplay"
  end

  def self.on_can_play_through
    "oncanplaythrough"
  end

  def self.on_change
    "onchange"
  end

  def self.on_click
    "onclick"
  end

  def self.on_copy
    "oncopy"
  end

  def self.on_cut
    "oncut"
  end

  def self.on_double_click
    "ondblclick"
  end

  def self.on_drag
    "ondrag"
  end

  def self.on_drag_end
    "ondragend"
  end

  def self.on_drag_enter
    "ondragenter"
  end

  def self.on_drag_leave
    "ondragleave"
  end

  def self.on_drag_over
    "ondragover"
  end

  def self.on_drag_start
    "ondragstart"
  end

  def self.on_drop
    "ondrop"
  end

  def self.on_duration_change
    "ondurationchange"
  end

  def self.on_ended
    "onended"
  end

  def self.on_error
    "onerror"
  end

  def self.on_focus
    "onfocus"
  end

  def self.on_focus_in
    "onfocusin"
  end

  def self.on_focus_out
    "onfocusout"
  end

  def self.on_hash_change
    "onhashchange"
  end

  def self.on_input
    "oninput"
  end

  def self.on_invalid
    "oninvalid"
  end

  def self.on_key_down
    "onkeydown"
  end

  def self.on_key_press
    "onkeypress"
  end

  def self.on_key_up
    "onkeyup"
  end

  def self.on_load
    "onload"
  end

  def self.on_loaded_data
    "onloadeddata"
  end

  def self.on_loaded_metadata
    "onloadedmetadata"
  end

  def self.on_load_start
    "onloadstart"
  end

  def self.on_mouse_down
    "onmousedown"
  end

  def self.on_mouse_enter
    "onmouseenter"
  end

  def self.on_mouse_leave
    "onmouseleave"
  end

  def self.on_mouse_move
    "onmousemove"
  end

  def self.on_mouse_over
    "onmouseover"
  end

  def self.on_mouse_out
    "onmouseout"
  end

  def self.on_mouse_up
    "onmouseup"
  end

  def self.on_offline
    "onoffline"
  end

  def self.on_online
    "ononline"
  end

  def self.on_page_hide
    "onpagehide"
  end

  def self.on_page_show
    "onpageshow"
  end

  def self.on_paste
    "onpaste"
  end

  def self.on_pause
    "onpause"
  end

  def self.on_play
    "onplay"
  end

  def self.on_playing
    "onplaying"
  end

  def self.on_progress
    "onprogress"
  end

  def self.on_rate_change
    "onratechange"
  end

  def self.on_resize
    "onresize"
  end

  def self.on_reset
    "onreset"
  end

  def self.on_scroll
    "onscroll"
  end

  def self.on_search
    "onsearch"
  end

  def self.on_seeked
    "onseeked"
  end

  def self.on_seeking
    "onseeking"
  end

  def self.on_select
    "onselect"
  end

  def self.on_stalled
    "onstalled"
  end

  def self.on_submit
    "onsubmit"
  end

  def self.on_suspend
    "onsuspend"
  end

  def self.on_time_update
    "ontimeupdate"
  end

  def self.on_toggle
    "ontoggle"
  end

  def self.on_touch_cancel
    "ontouchcancel"
  end

  def self.on_touch_end
    "ontouchend"
  end

  def self.on_touch_move
    "ontouchmove"
  end

  def self.on_touch_start
    "ontouchstart"
  end

  def self.on_unload
    "onunload"
  end

  def self.on_volume_change
    "onvolumechange"
  end

  def self.on_waiting
    "onwaiting"
  end
end

class HtmlEventListener
  def self.abort
    "abort"
  end

  def self.after_print
    "afterprint"
  end

  def self.before_print
    "beforeprint"
  end

  def self.before_unload
    "beforeunload"
  end

  def self.blur
    "blur"
  end

  def self.can_play
    "canplay"
  end

  def self.can_play_through
    "canplaythrough"
  end

  def self.change
    "change"
  end

  def self.click
    "click"
  end

  def self.copy
    "copy"
  end

  def self.cut
    "cut"
  end

  def self.double_click
    "dblclick"
  end

  def self.drag
    "drag"
  end

  def self.drag_end
    "dragend"
  end

  def self.drag_enter
    "dragenter"
  end

  def self.drag_leave
    "dragleave"
  end

  def self.drag_over
    "dragover"
  end

  def self.drag_start
    "dragstart"
  end

  def self.drop
    "drop"
  end

  def self.duration_change
    "durationchange"
  end

  def self.ended
    "ended"
  end

  def self.error
    "error"
  end

  def self.focus
    "focus"
  end

  def self.focus_in
    "focusin"
  end

  def self.focus_out
    "focusout"
  end

  def self.hash_change
    "hashchange"
  end

  def self.input
    "input"
  end

  def self.invalid
    "invalid"
  end

  def self.key_down
    "keydown"
  end

  def self.key_press
    "keypress"
  end

  def self.key_up
    "keyup"
  end

  def self.load
    "load"
  end

  def self.loaded_data
    "loadeddata"
  end

  def self.loaded_metadata
    "loadedmetadata"
  end

  def self.load_start
    "loadstart"
  end

  def self.mouse_down
    "mousedown"
  end

  def self.mouse_enter
    "mouseenter"
  end

  def self.mouse_leave
    "mouseleave"
  end

  def self.mouse_move
    "mousemove"
  end

  def self.mouse_over
    "mouseover"
  end

  def self.mouse_out
    "mouseout"
  end

  def self.mouse_up
    "mouseup"
  end

  def self.offline
    "offline"
  end

  def self.online
    "online"
  end

  def self.page_hide
    "pagehide"
  end

  def self.page_show
    "pageshow"
  end

  def self.paste
    "paste"
  end

  def self.pause
    "pause"
  end

  def self.play
    "play"
  end

  def self.playing
    "playing"
  end

  def self.progress
    "progress"
  end

  def self.rate_change
    "ratechange"
  end

  def self.resize
    "resize"
  end

  def self.reset
    "reset"
  end

  def self.scroll
    "scroll"
  end

  def self.search
    "search"
  end

  def self.seeked
    "seeked"
  end

  def self.seeking
    "seeking"
  end

  def self.select
    "select"
  end

  def self.stalled
    "stalled"
  end

  def self.submit
    "submit"
  end

  def self.suspend
    "suspend"
  end

  def self.time_update
    "timeupdate"
  end

  def self.toggle
    "toggle"
  end

  def self.touch_cancel
    "touchcancel"
  end

  def self.touch_end
    "touchend"
  end

  def self.touch_move
    "touchmove"
  end

  def self.touch_start
    "touchstart"
  end

  def self.unload
    "unload"
  end

  def self.volume_change
    "volumechange"
  end

  def self.waiting
    "waiting"
  end

  def self.animation_end
    "animationend"
  end

  def self.animation_iteration
    "animationiteration"
  end

  def self.animation_start
    "animationstart"
  end

  def self.context_menu
    "contextmenu"
  end

  def self.full_screen_change
    "fullscreenchange"
  end

  def self.full_screen_error
    "fullscreenerror"
  end

  def self.pop_state
    "popstate"
  end

  def self.transition_end
    "transitionend"
  end

  def self.storage
    "storage"
  end

  def self.wheel
    "wheel"
  end
end

class ExtensionWebFormsMethods
  def self.append_place(text, value)
    return value if text.empty?
    "#{text}|#{value}"
  end

  def self.append_parent(text)
    "/#{text}"
  end

  def self.export_to_web_forms_tag(src)
    "<web-forms src=\"#{src}\"></web-forms>"
  end

  def self.export_to_web_forms_tag_with_size(src, width, height)
    "<web-forms src=\"#{src}\" width=\"#{width}\" height=\"#{height}\"></web-forms>"
  end

  def self.export_action_controls_to_web_forms_tag(action_controls)
    "<web-forms ac=\"#{action_controls}\"></web-forms>"
  end

  def self.remove_outer(text, start_string, end_string)
    start_index = text.index(start_string)
    return text if start_index.nil?

    end_index = text.index(end_string, start_index + start_string.length)
    return text if end_index.nil?

    text[0...start_index] + text[end_index + end_string.length..-1]
  end
end

class NameValue
  attr_accessor :name, :value

  def initialize(name = nil, value = nil)
    @name = name
    @value = value
  end
end

class NameValueCollection
  def initialize
    @name_value_list = []
  end

  def add(name, value)
    @name_value_list << NameValue.new(name, value)
  end

  def set(name, value)
    if exist?(name)
      change_value(name, value)
    else
      add(name, value)
    end
  end

  def delete(name)
    @name_value_list.reject! { |nv| nv.name == name }
  end

  def delete_by_index(index)
    index = normalize_index(index)
    @name_value_list.delete_at(index)
  end

  def empty
    @name_value_list = []
  end

  def exist?(name)
    @name_value_list.any? { |nv| nv.name == name }
  end

  def change_value(name, value)
    @name_value_list.each do |nv|
      if nv.name == name
        nv.value = value
        break
      end
    end
  end

  def change_name(name, new_name)
    @name_value_list.each do |nv|
      if nv.name == name
        nv.name = new_name
        break
      end
    end
  end

  def change_value_by_index(index, value)
    index = normalize_index(index)
    @name_value_list[index].value = value
  end

  def change_name_by_index(index, name)
    index = normalize_index(index)
    @name_value_list[index].name = name
  end

  def change_name_value_by_index(index, name, value)
    index = normalize_index(index)
    @name_value_list[index].name = name
    @name_value_list[index].value = value
  end

  def add_list(name_value_list)
    name_value_list.each { |nv| @name_value_list << nv }
  end

  def get_value(name)
    nv = @name_value_list.find { |nv| nv.name == name }
    nv ? nv.value : ""
  end

  def get_name_by_index(index)
    index = normalize_index(index)
    @name_value_list[index].name
  end

  def get_value_by_index(index)
    index = normalize_index(index)
    @name_value_list[index].value
  end

  def get_list
    @name_value_list
  end

  private

  def normalize_index(index)
    index >= 0 ? index : @name_value_list.size + index
  end
end
