# WebForms.py 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
# Compatible with WebFormsJS version 2.1

from typing import Optional, Union, List, Callable

class WebForms:
    def __init__(self):
        self._GS = chr(29)
        self._US = chr(31)
        self._web_forms_data = ""

    def _add(self, name: str, value: Optional[str] = None) -> None:
        if len(self._web_forms_data) > 0:
            self._web_forms_data += '\n'
        self._web_forms_data += name
        if value is not None:
            self._web_forms_data += '=' + value

    def _add_to_up(self, name: str, value: Optional[str] = None) -> None:
        line = name + ('=' + value if value is not None else '')
        if len(self._web_forms_data) > 0:
            line += "\n"
        self._web_forms_data = line + self._web_forms_data

    def _get_line_by_index(self, index: int) -> str:
        if len(self._web_forms_data) == 0:
            return ""
        lines = self._web_forms_data.split('\n')
        if index < 0:
            index = len(lines) + index
        if index < 0 or index >= len(lines):
            return ""
        return lines[index]

    def _update_line_by_index(self, index: int, name: str, value: Optional[str] = None) -> None:
        if len(self._web_forms_data) == 0:
            return
        lines = self._web_forms_data.split('\n')
        if index < 0:
            index = len(lines) + index
        if index < 0 or index >= len(lines):
            return
        
        val_part = ("=" + value) if value else ""
        lines[index] = name + val_part
        self._web_forms_data = "\n".join(lines)

    # For Extension
    def add_line(self, name: str, value: str) -> None:
        self._add(name, value)

    # Add
    # Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.
    def add_id(self, input_place: str, id_val: str) -> None:
        self._add("ai" + input_place, id_val)

    def add_name(self, input_place: str, name: str) -> None:
        self._add("an" + input_place, name)

    def add_value(self, input_place: str, value: str) -> None:
        self._add("av" + input_place, value)

    def add_class(self, input_place: str, class_val: str) -> None:
        self._add("ac" + input_place, class_val)

    def add_style(self, input_place: str, style: str) -> None:
        self._add("as" + input_place, style)

    def add_style_name_value(self, input_place: str, name: str, value: str) -> None:
        self._add("as" + input_place, name + ':' + value)

    def add_option_tag(self, input_place: str, text: str, value: str, selected: bool = False) -> None:
        self._add("ao" + input_place, value + self._GS + text + (self._GS + "1" if selected else ""))

    def add_check_box_tag(self, input_place: str, text: str, value: str, checked: bool = False) -> None:
        self._add("ak" + input_place, value + self._GS + text + (self._GS + "1" if checked else ""))

    def add_title(self, input_place: str, title: str) -> None:
        self._add("al" + input_place, title)

    def add_label(self, input_place: str, label: str) -> None:
        self._add("aA" + input_place, label)

    def add_text(self, input_place: str, text: str) -> None:
        self._add("at" + input_place, text.replace('\n', "$[ln];"))

    def add_text_to_up(self, input_place: str, text: str) -> None:
        self._add("pt" + input_place, text.replace('\n', "$[ln];"))

    def add_attribute(self, input_place: str, attribute: str, value: str = "", splitter: str = "") -> None:
        splitter_str = splitter if splitter else ""
        value_str = self._GS + value if value else ""
        self._add("aa" + input_place, attribute + self._GS + splitter_str + value_str)

    def add_tag(self, input_place: str, tag_name: str, id_val: str = "") -> None:
        self._add("nt" + input_place, tag_name + (self._GS + id_val if id_val else ""))

    def add_tag_to_up(self, input_place: str, tag_name: str, id_val: str = "") -> None:
        self._add("ut" + input_place, tag_name + (self._GS + id_val if id_val else ""))

    def add_tag_before(self, input_place: str, tag_name: str, id_val: str = "") -> None:
        self._add("bt" + input_place, tag_name + (self._GS + id_val if id_val else ""))

    def add_tag_after(self, input_place: str, tag_name: str, id_val: str = "") -> None:
        self._add("ft" + input_place, tag_name + (self._GS + id_val if id_val else ""))

    def add_hidden(self, input_place: str, name: str, value: str, id_val: str = "") -> None:
        self._add("ah" + input_place, name + self._GS + value + (self._GS + id_val if id_val else ""))

    # Set
    # Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.
    def set_id(self, input_place: str, id_val: str) -> None:
        self._add("si" + input_place, id_val)

    def set_name(self, input_place: str, name: str) -> None:
        self._add("sn" + input_place, name)

    def set_value(self, input_place: str, value: str) -> None:
        self._add("sv" + input_place, value)

    def set_class(self, input_place: str, class_val: str) -> None:
        self._add("sc" + input_place, class_val)

    def set_style(self, input_place: str, style: str) -> None:
        self._add("ss" + input_place, style)

    def set_style_name_value(self, input_place: str, name: str, value: str) -> None:
        self._add("ss" + input_place, name + ':' + value)

    def set_option_tag(self, input_place: str, text: str, value: str, selected: bool = False) -> None:
        self._add("so" + input_place, value + self._GS + text + (self._GS + "1" if selected else ""))

    def set_checked(self, input_place: str, checked: bool = False) -> None:
        self._add("sk" + input_place, "1" if checked else "0")

    def set_check_box_tag(self, input_place: str, text: str, value: str, checked: bool = False) -> None:
        self._add("sk" + input_place, value + self._GS + text + (self._GS + "1" if checked else ""))

    def set_title(self, input_place: str, title: str) -> None:
        self._add("sl" + input_place, title)

    def set_label(self, input_place: str, label: str) -> None:
        self._add("sA" + input_place, label)

    def set_text(self, input_place: str, text: str) -> None:
        self._add("st" + input_place, text.replace('\n', "$[ln];"))

    def set_attribute(self, input_place: str, attribute: str, value: str = "") -> None:
        self._add("sa" + input_place, attribute + self._GS + (self._GS + value if value else ""))

    def set_width(self, input_place: str, width: str) -> None:
        self._add("sw" + input_place, width)

    def set_width_int(self, input_place: str, width: int) -> None:
        self.set_width(input_place, str(width) + "px")

    def set_height(self, input_place: str, height: str) -> None:
        self._add("sh" + input_place, height)

    def set_height_int(self, input_place: str, height: int) -> None:
        self.set_height(input_place, str(height) + "px")

    def set_background_color(self, input_place: str, color: str) -> None:
        self._add("bc" + input_place, color)

    def set_text_color(self, input_place: str, color: str) -> None:
        self._add("tc" + input_place, color)

    def set_font_name(self, input_place: str, name: str) -> None:
        self._add("fn" + input_place, name)

    def set_font_size(self, input_place: str, size: str) -> None:
        self._add("fs" + input_place, size)

    def set_font_size_int(self, input_place: str, size: int) -> None:
        self._add("fs" + input_place, str(size) + "px")

    def set_font_bold(self, input_place: str, bold: bool) -> None:
        self._add("fb" + input_place, "1" if bold else "0")

    def set_visible(self, input_place: str, visible: bool) -> None:
        self._add("vi" + input_place, "1" if visible else "0")

    def set_text_align(self, input_place: str, align: str) -> None:
        self._add("ta" + input_place, align)

    def set_read_only(self, input_place: str, read_only: bool) -> None:
        self._add("sr" + input_place, "1" if read_only else "0")

    def set_disabled(self, input_place: str, disabled: bool) -> None:
        self._add("sd" + input_place, "1" if disabled else "0")

    def set_focus(self, input_place: str, focus: bool) -> None:
        self._add("sf" + input_place, "1" if focus else "0")

    def set_min_length(self, input_place: str, length: str) -> None:
        self._add("mn" + input_place, length)

    def set_min_length_int(self, input_place: str, length: int) -> None:
        self.set_min_length(input_place, str(length))

    def set_max_length(self, input_place: str, length: str) -> None:
        self._add("mx" + input_place, length)

    def set_max_length_int(self, input_place: str, length: int) -> None:
        # Replicating C# behavior exactly (missing 'mx' prefix in C# original)
        self._add(input_place, str(length))

    def set_selected_value(self, input_place: str, value: str) -> None:
        self._add("ts" + input_place, value)

    def set_selected_index(self, input_place: str, index: str) -> None:
        self._add("ti" + input_place, index)

    def set_selected_index_int(self, input_place: str, index: int) -> None:
        self.set_selected_index(input_place, str(index))

    def set_checked_value(self, input_place: str, value: str, checked: bool) -> None:
        self._add("ks" + input_place, value + self._GS + ("1" if checked else "0"))

    def set_checked_index(self, input_place: str, index: str, checked: bool) -> None:
        self._add("ki" + input_place, index + self._GS + ("1" if checked else "0"))

    def set_checked_index_int(self, input_place: str, index: int, checked: bool) -> None:
        self.set_checked_index(input_place, str(index), checked)

    # Insert
    # Creates the Data only if it does not exist; otherwise, does nothing.
    def insert_id(self, input_place: str, id_val: str) -> None:
        self._add("ii" + input_place, id_val)

    def insert_name(self, input_place: str, name: str) -> None:
        self._add("in" + input_place, name)

    def insert_value(self, input_place: str, value: str) -> None:
        self._add("iv" + input_place, value)

    def insert_class(self, input_place: str, class_val: str) -> None:
        self._add("ic" + input_place, class_val)

    def insert_style(self, input_place: str, style: str) -> None:
        self._add("is" + input_place, style)

    def insert_style_name_value(self, input_place: str, name: str, value: str) -> None:
        self._add("is" + input_place, name + ':' + value)

    def insert_option_tag(self, input_place: str, text: str, value: str, selected: bool = False) -> None:
        self._add("io" + input_place, value + self._GS + text + (self._GS + "1" if selected else ""))

    def insert_check_box_tag(self, input_place: str, text: str, value: str, checked: bool = False) -> None:
        self._add("ik" + input_place, value + self._GS + text + (self._GS + "1" if checked else ""))

    def insert_title(self, input_place: str, title: str) -> None:
        self._add("il" + input_place, title)

    def insert_label(self, input_place: str, label: str) -> None:
        self._add("iA" + input_place, label)

    def insert_text(self, input_place: str, text: str) -> None:
        self._add("it" + input_place, text.replace('\n', "$[ln];"))

    def insert_attribute(self, input_place: str, attribute: str, value: str = "", splitter: str = "") -> None:
        splitter_str = splitter if splitter else ""
        value_str = self._GS + value if value else ""
        self._add("ia" + input_place, attribute + self._GS + splitter_str + value_str)

    # Delete
    def delete_id(self, input_place: str) -> None:
        self._add("di" + input_place)

    def delete_name(self, input_place: str) -> None:
        self._add("dn" + input_place)

    def delete_value(self, input_place: str) -> None:
        self._add("dv" + input_place)

    def delete_class(self, input_place: str, class_name: str) -> None:
        self._add("dc" + input_place, class_name)

    def delete_style(self, input_place: str, style_name: str) -> None:
        self._add("ds" + input_place, style_name)

    def delete_option_tag(self, input_place: str, value: str) -> None:
        self._add("do" + input_place, value)

    def delete_all_option_tag(self, input_place: str) -> None:
        self._add("do" + input_place, "*")

    def delete_check_box_tag(self, input_place: str, value: str) -> None:
        self._add("dk" + input_place, value)

    def delete_all_check_box_tag(self, input_place: str) -> None:
        self._add("dk" + input_place, "*")

    def delete_title(self, input_place: str) -> None:
        self._add("dl" + input_place)

    def delete_label(self, input_place: str) -> None:
        self._add("dA" + input_place)

    def delete_text(self, input_place: str) -> None:
        self._add("dt" + input_place)

    def delete_attribute(self, input_place: str, attribute: str) -> None:
        self._add("da" + input_place, attribute)

    def delete(self, input_place: str) -> None:
        self._add("de" + input_place)

    def delete_parent(self, input_place: str) -> None:
        self._add("dp" + input_place)

    # Tag
    def swap_tag(self, input_place: str, output_place: str) -> None:
        self._add("sp" + input_place, output_place)

    def set_reflection(self, input_place: str, tag: str) -> None:
        self._add("sR" + input_place, tag)

    def set_reflection_by_output_place(self, input_place: str, output_place: str) -> None:
        self._add("iR" + input_place, output_place)

    def set_morph(self, input_place: str, tag: str) -> None:
        self._add("sM" + input_place, tag)

    def set_morph_by_output_place(self, input_place: str, output_place: str) -> None:
        self._add("iM" + input_place, output_place)

    # Browser
    def change_url(self, url: str) -> None:
        self._add("cu", url)

    def set_head_title(self, title: str) -> None:
        self._add("ht", title)

    def clipboard_write_text(self, text: str) -> None:
        self._add("nw", text)

    def scroll_to(self, x: str, y: str) -> None:
        self._add("ws", x + self._GS + y)

    def scroll_to_int(self, x: int, y: int) -> None:
        self.scroll_to(str(x), str(y))

    def history_go(self, steps: str) -> None:
        self._add("wg", steps)

    def history_go_int(self, steps: int) -> None:
        self.history_go(str(steps))

    def reload_page(self) -> None:
        self._add("lr")

    def redirect(self, path: str) -> None:
        self._add("lh", path)

    # Increase
    def increase_min_length(self, input_place: str, value: str) -> None:
        self._add("+n" + input_place, value)

    def increase_min_length_int(self, input_place: str, value: int) -> None:
        self.increase_min_length(input_place, str(value))

    def increase_max_length(self, input_place: str, value: str) -> None:
        self._add("+x" + input_place, value)

    def increase_max_length_int(self, input_place: str, value: int) -> None:
        self.increase_max_length(input_place, str(value))

    def increase_font_size(self, input_place: str, value: str) -> None:
        self._add("+f" + input_place, value)

    def increase_font_size_int(self, input_place: str, value: int) -> None:
        self.increase_font_size(input_place, str(value))

    def increase_width(self, input_place: str, value: str) -> None:
        self._add("+w" + input_place, value)

    def increase_width_int(self, input_place: str, value: int) -> None:
        self.increase_width(input_place, str(value))

    def increase_height(self, input_place: str, value: str) -> None:
        self._add("+h" + input_place, value)

    def increase_height_int(self, input_place: str, value: int) -> None:
        self.increase_height(input_place, str(value))

    def increase_value(self, input_place: str, value: str) -> None:
        self._add("+v" + input_place, value)

    def increase_value_int(self, input_place: str, value: int) -> None:
        self.increase_value(input_place, str(value))

    # Decrease
    def decrease_min_length(self, input_place: str, value: str) -> None:
        self._add("-n" + input_place, value)

    def decrease_min_length_int(self, input_place: str, value: int) -> None:
        self.decrease_min_length(input_place, str(value))

    def decrease_max_length(self, input_place: str, value: str) -> None:
        self._add("-x" + input_place, value)

    def decrease_max_length_int(self, input_place: str, value: int) -> None:
        self.decrease_max_length(input_place, str(value))

    def decrease_font_size(self, input_place: str, value: str) -> None:
        self._add("-f" + input_place, value)

    def decrease_font_size_int(self, input_place: str, value: int) -> None:
        self.decrease_font_size(input_place, str(value))

    def decrease_width(self, input_place: str, value: str) -> None:
        self._add("-w" + input_place, value)

    def decrease_width_int(self, input_place: str, value: int) -> None:
        self.decrease_width(input_place, str(value))

    def decrease_height(self, input_place: str, value: str) -> None:
        self._add("-h" + input_place, value)

    def decrease_height_int(self, input_place: str, value: int) -> None:
        self.decrease_height(input_place, str(value))

    def decrease_value(self, input_place: str, value: str) -> None:
        self._add("-v" + input_place, value)

    def decrease_value_int(self, input_place: str, value: int) -> None:
        self.decrease_value(input_place, str(value))

    # Event
    # ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
    # All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.
    def trigger_event(self, input_place: str, html_event_listener: str, constructor_name: Optional[str] = None) -> None:
        self._add("TE" + input_place, html_event_listener + (self._GS + constructor_name if constructor_name else ""))

    def set_post_event(self, input_place: str, html_event: str, output_place: Optional[str] = None) -> None:
        if output_place is not None:
            self._add("Ep" + input_place, html_event + self._GS + output_place)
        else:
            self._add("Ep" + input_place, html_event)

    def set_post_event_add_view(self, input_place: str, html_event: str) -> None:
        self._add("Ep" + input_place, html_event + self._GS + "+")

    def set_post_event_listener(self, input_place: str, html_event_listener: str, output_place: Optional[str] = None) -> None:
        if output_place is not None:
            self._add("EP" + input_place, html_event_listener + self._GS + output_place)
        else:
            self._add("EP" + input_place, html_event_listener)

    def set_post_event_listener_add_view(self, input_place: str, html_event_listener: str) -> None:
        self._add("EP" + input_place, html_event_listener + self._GS + "+")

    def set_get_event(self, input_place: str, html_event: str, path: Optional[str] = None, output_place: Optional[str] = None) -> None:
        p = path if path is not None else "#"
        if output_place is not None:
            self._add("Eg" + input_place, html_event + self._GS + p + self._GS + output_place)
        else:
            self._add("Eg" + input_place, html_event + self._GS + p)

    def set_get_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None, output_place: Optional[str] = None) -> None:
        p = path if path is not None else "#"
        if output_place is not None:
            self._add("EG" + input_place, html_event_listener + self._GS + p + self._GS + output_place)
        else:
            self._add("EG" + input_place, html_event_listener + self._GS + p)

    def set_put_event(self, input_place: str, html_event: str, path: Optional[str] = None, output_place: Optional[str] = None) -> None:
        p = path if path is not None else "#"
        if output_place is not None:
            self._add("Et" + input_place, html_event + self._GS + p + self._GS + output_place)
        else:
            self._add("Et" + input_place, html_event + self._GS + p)

    def set_put_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None, output_place: Optional[str] = None) -> None:
        p = path if path is not None else "#"
        if output_place is not None:
            self._add("ET" + input_place, html_event_listener + self._GS + p + self._GS + output_place)
        else:
            self._add("ET" + input_place, html_event_listener + self._GS + p)

    def set_patch_event(self, input_place: str, html_event: str, path: Optional[str] = None, output_place: Optional[str] = None) -> None:
        p = path if path is not None else "#"
        if output_place is not None:
            self._add("Ea" + input_place, html_event + self._GS + p + self._GS + output_place)
        else:
            self._add("Ea" + input_place, html_event + self._GS + p)

    def set_patch_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None, output_place: Optional[str] = None) -> None:
        p = path if path is not None else "#"
        if output_place is not None:
            self._add("EA" + input_place, html_event_listener + self._GS + p + self._GS + output_place)
        else:
            self._add("EA" + input_place, html_event_listener + self._GS + p)

    def set_delete_event(self, input_place: str, html_event: str, path: Optional[str] = None, output_place: Optional[str] = None) -> None:
        p = path if path is not None else "#"
        if output_place is not None:
            self._add("El" + input_place, html_event + self._GS + p + self._GS + output_place)
        else:
            self._add("El" + input_place, html_event + self._GS + p)

    def set_delete_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None, output_place: Optional[str] = None) -> None:
        p = path if path is not None else "#"
        if output_place is not None:
            self._add("EL" + input_place, html_event_listener + self._GS + p + self._GS + output_place)
        else:
            self._add("EL" + input_place, html_event_listener + self._GS + p)

    def set_options_event(self, input_place: str, html_event: str, path: Optional[str] = None, output_place: Optional[str] = None) -> None:
        p = path if path is not None else "#"
        if output_place is not None:
            self._add("Eo" + input_place, html_event + self._GS + p + self._GS + output_place)
        else:
            self._add("Eo" + input_place, html_event + self._GS + p)

    def set_options_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None, output_place: Optional[str] = None) -> None:
        p = path if path is not None else "#"
        if output_place is not None:
            self._add("EO" + input_place, html_event_listener + self._GS + p + self._GS + output_place)
        else:
            self._add("EO" + input_place, html_event_listener + self._GS + p)

    def set_head_event(self, input_place: str, html_event: str, path: Optional[str] = None) -> None:
        p = path if path is not None else "#"
        self._add("Eh" + input_place, html_event + self._GS + p)

    def set_head_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None) -> None:
        p = path if path is not None else "#"
        self._add("EH" + input_place, html_event_listener + self._GS + p)

    # IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
    def set_send_event(self, input_place: str, html_event: str, data: str, path: Optional[str] = None, method: str = "POST", is_multi_part: bool = False, content_type: str = "text/plain", output_place: Optional[str] = None) -> None:
        clean_data = data.replace('\n', "$[ln];").replace('"', "$[dq];").replace("'", "$[sq];")
        p = path if path is not None else "#"
        mp = "1" if is_multi_part else "0"
        self._add("En" + input_place, html_event + self._GS + clean_data + self._GS + p + self._GS + method + self._GS + mp + self._GS + content_type + self._GS + (output_place or ""))

    def set_send_event_listener(self, input_place: str, html_event_listener: str, data: str, path: Optional[str] = None, method: str = "POST", is_multi_part: bool = False, content_type: str = "text/plain", output_place: Optional[str] = None) -> None:
        clean_data = data.replace('\n', "$[ln];")
        p = path if path is not None else "#"
        mp = "1" if is_multi_part else "0"
        self._add("EN" + input_place, html_event_listener + self._GS + clean_data + self._GS + p + self._GS + method + self._GS + mp + self._GS + content_type + self._GS + (output_place or ""))

    def set_comment_event(self, input_place: str, html_event: str, index: Optional[str] = None, output_place: Optional[str] = None) -> None:
        self._add("Eb" + input_place, html_event + self._GS + (index or "") + self._GS + (output_place or ""))

    def set_comment_event_int(self, input_place: str, html_event: str, index: int, output_place: Optional[str] = None) -> None:
        self.set_comment_event(input_place, html_event, str(index), output_place)

    def set_comment_event_listener(self, input_place: str, html_event_listener: str, index: Optional[str] = None, output_place: Optional[str] = None) -> None:
        self._add("EB" + input_place, html_event_listener + self._GS + (index or "") + self._GS + (output_place or ""))

    def set_comment_event_listener_int(self, input_place: str, html_event_listener: str, index: int, output_place: Optional[str] = None) -> None:
        self.set_comment_event_listener(input_place, html_event_listener, str(index), output_place)

    def set_wasm_event(self, input_place: str, html_event: str, wasm_language: str, wasm_url: str, method_name: str, args: Optional[List[str]] = None, output_place: Optional[str] = None) -> None:
        args_join = ""
        if args is not None and len(args) > 0:
            args_join = "[" + self._US.join(args)
        self._add("Ey" + input_place, html_event + self._GS + wasm_language + self._GS + wasm_url + self._GS + method_name + self._GS + args_join + self._GS + (output_place or ""))

    def set_wasm_event_listener(self, input_place: str, html_event_listener: str, wasm_language: str, wasm_url: str, method_name: str, args: Optional[List[str]] = None, output_place: Optional[str] = None) -> None:
        args_join = ""
        if args is not None and len(args) > 0:
            args_join = "[" + self._US.join(args)
        self._add("EY" + input_place, html_event_listener + self._GS + wasm_language + self._GS + wasm_url + self._GS + method_name + self._GS + args_join + self._GS + (output_place or ""))

    def set_web_socket_event(self, input_place: str, html_event: str, path: str) -> None:
        self._add("Ew" + input_place, html_event + self._GS + path)

    def set_web_socket_event_listener(self, input_place: str, html_event_listener: str, path: str) -> None:
        self._add("EW" + input_place, html_event_listener + self._GS + path)

    def set_sse_event(self, input_place: str, html_event: str, path: str, output_place: Optional[str] = None, should_reconnect: bool = True, reconnect_try_timeout: int = 3000) -> None:
        val = html_event + self._GS + path + self._GS + ("1" if should_reconnect else "0") + self._GS + str(reconnect_try_timeout)
        if output_place is not None:
            val += self._GS + output_place
        self._add("Ee" + input_place, val)

    def set_sse_event_with_output(self, input_place: str, html_event: str, path: str, output_place: str, should_reconnect: bool = True, reconnect_try_timeout: int = 3000) -> None:
        self.set_sse_event(input_place, html_event, path, should_reconnect, reconnect_try_timeout, output_place)

    def set_sse_event_listener(self, input_place: str, html_event_listener: str, path: str, output_place: Optional[str] = None, should_reconnect: bool = True, reconnect_try_timeout: int = 3000) -> None:
        val = html_event_listener + self._GS + path + self._GS + ("1" if should_reconnect else "0") + self._GS + str(reconnect_try_timeout)
        if output_place is not None:
            val += self._GS + output_place
        self._add("EE" + input_place, val)

    def set_sse_event_listener_with_output(self, input_place: str, html_event_listener: str, path: str, output_place: str, should_reconnect: bool = True, reconnect_try_timeout: int = 3000) -> None:
        self.set_sse_event_listener(input_place, html_event_listener, path, should_reconnect, reconnect_try_timeout, output_place)

    def set_front_event(self, input_place: str, html_event: str, module_path: str, args: Optional[List[str]] = None, output_place: Optional[str] = None) -> None:
        args_join = ""
        if args is not None and len(args) > 0:
            args_join = self._GS + "[" + self._US.join(args)
        self._add("Ej" + input_place, html_event + self._GS + module_path + self._GS + (output_place or "") + args_join)

    def set_front_event_listener(self, input_place: str, html_event_listener: str, module_path: str, args: Optional[List[str]] = None, output_place: Optional[str] = None) -> None:
        args_join = ""
        if args is not None and len(args) > 0:
            args_join = self._GS + "[" + self._US.join(args)
        self._add("EJ" + input_place, html_event_listener + self._GS + module_path + self._GS + (output_place or "") + args_join)

    def set_master_pages_event(self, input_place: str, html_event: str, output_place: Optional[str] = None) -> None:
        self._add("Eu" + input_place, html_event + self._GS + (output_place or ""))

    def set_master_pages_event_listener(self, input_place: str, html_event_listener: str, output_place: Optional[str] = None) -> None:
        self._add("EU" + input_place, html_event_listener + self._GS + (output_place or ""))

    def set_prevent_default_event(self, input_place: str, html_event: str) -> None:
        self._add("Ed" + input_place, html_event)

    def set_prevent_default_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("ED" + input_place, html_event_listener)

    def set_stop_propagation_event(self, input_place: str, html_event: str) -> None:
        self._add("Es" + input_place, html_event)

    def set_stop_propagation_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("ES" + input_place, html_event_listener)

    def set_method_event(self, input_place: str, html_event: str, method_name: str, args: Optional[List[str]] = None) -> None:
        args_join = ""
        if args is not None and len(args) > 0:
            args_join = self._GS + "[" + self._US.join(args)
        self._add("Em" + input_place, html_event + self._GS + method_name + args_join)

    def set_method_event_listener(self, input_place: str, html_event_listener: str, method_name: str, args: Optional[List[str]] = None) -> None:
        args_join = ""
        if args is not None and len(args) > 0:
            args_join = self._GS + "[" + self._US.join(args)
        self._add("EM" + input_place, html_event_listener + self._GS + method_name + args_join)

    def set_module_method_event(self, input_place: str, html_event: str, method_name: str, args: Optional[List[str]] = None) -> None:
        args_join = ""
        if args is not None and len(args) > 0:
            args_join = self._GS + "[" + self._US.join(args)
        self._add("Ex" + input_place, html_event + self._GS + method_name + args_join)

    def set_module_method_event_listener(self, input_place: str, html_event_listener: str, method_name: str, args: Optional[List[str]] = None) -> None:
        args_join = ""
        if args is not None and len(args) > 0:
            args_join = self._GS + "[" + self._US.join(args)
        self._add("EX" + input_place, html_event_listener + self._GS + method_name + args_join)

    def assign_confirm_event(self, input_place: str, html_event: str, text: str = "Are you sure you want to proceed?", type_val: str = "none", title: str = "Confirm", ok_text: str = "OK", cancel_text: str = "Cancel") -> None:
        self._add("Ef" + input_place, html_event + self._GS + ("" if text == "Are you sure you want to proceed?" else text) + self._GS + ("" if type_val == "none" else type_val) + self._GS + ("" if title == "Confirm" else title) + self._GS + ("" if ok_text == "OK" else ok_text) + self._GS + ("" if cancel_text == "Cancel" else cancel_text))

    def remove_post_event(self, input_place: str, html_event: str) -> None:
        self._add("Rp" + input_place, html_event)

    def remove_post_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RP" + input_place, html_event_listener)

    def remove_get_event(self, input_place: str, html_event: str) -> None:
        self._add("Rg" + input_place, html_event)

    def remove_get_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RG" + input_place, html_event_listener)

    def remove_put_event(self, input_place: str, html_event: str) -> None:
        self._add("Rt" + input_place, html_event)

    def remove_put_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RT" + input_place, html_event_listener)

    def remove_patch_event(self, input_place: str, html_event: str) -> None:
        self._add("Ra" + input_place, html_event)

    def remove_patch_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RA" + input_place, html_event_listener)

    def remove_delete_event(self, input_place: str, html_event: str) -> None:
        self._add("Rl" + input_place, html_event)

    def remove_delete_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RL" + input_place, html_event_listener)

    def remove_options_event(self, input_place: str, html_event: str) -> None:
        self._add("Ro" + input_place, html_event)

    def remove_options_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RO" + input_place, html_event_listener)

    def remove_head_event(self, input_place: str, html_event: str) -> None:
        self._add("Rh" + input_place, html_event)

    def remove_head_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RH" + input_place, html_event_listener)

    def remove_send_event(self, input_place: str, html_event: str) -> None:
        self._add("Rn" + input_place, html_event)

    def remove_send_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RN" + input_place, html_event_listener)

    def remove_comment_event(self, input_place: str, html_event: str) -> None:
        self._add("Rb" + input_place, html_event)

    def remove_comment_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RB" + input_place, html_event_listener)

    def remove_wasm_event(self, input_place: str, html_event: str) -> None:
        self._add("Ry" + input_place, html_event)

    def remove_wasm_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RY" + input_place, html_event_listener)

    def remove_web_socket_event(self, input_place: str, html_event: str) -> None:
        self._add("Rw" + input_place, html_event)

    def remove_web_socket_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RW" + input_place, html_event_listener)

    def remove_sse_event(self, input_place: str, html_event: str) -> None:
        self._add("Re" + input_place, html_event)

    def remove_sse_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RE" + input_place, html_event_listener)

    def remove_front_event(self, input_place: str, html_event: str) -> None:
        self._add("Rj" + input_place, html_event)

    def remove_front_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RJ" + input_place, html_event_listener)

    def remove_prevent_default_event(self, input_place: str, html_event: str) -> None:
        self._add("Rd" + input_place, html_event)

    def remove_prevent_default_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RD" + input_place, html_event_listener)

    def remove_master_pages_event(self, input_place: str, html_event: str) -> None:
        self._add("Ru" + input_place, html_event)

    def remove_master_pages_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RU" + input_place, html_event_listener)

    def remove_stop_propagation_event(self, input_place: str, html_event: str) -> None:
        self._add("Rs" + input_place, html_event)

    def remove_stop_propagation_event_listener(self, input_place: str, html_event_listener: str) -> None:
        self._add("RS" + input_place, html_event_listener)

    def remove_method_event(self, input_place: str, html_event: str, method_name: str) -> None:
        self._add("Rm" + input_place, html_event + self._GS + method_name)

    def remove_method_event_listener(self, input_place: str, html_event_listener: str, method_name: str) -> None:
        self._add("RM" + input_place, html_event_listener + self._GS + method_name)

    def remove_module_method_event(self, input_place: str, html_event: str, method_name: str) -> None:
        self._add("Rx" + input_place, html_event + self._GS + method_name)

    def remove_module_method_event_listener(self, input_place: str, html_event_listener: str, method_name: str) -> None:
        self._add("RX" + input_place, html_event_listener + self._GS + method_name)

    def remove_confirm_event(self, input_place: str, html_event: str) -> None:
        self._add("Rf" + input_place, html_event)

    # Custom Event
    # This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
    # Watch: attribute, style, text, children, value
    # Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
    # Range: Only Use For Compare With inrange Value. Split By Comma ","
    # Key: Only Use For Watch With attribute And style Value
    def create_custom_dom_event(self, input_place: str, event_name: str, watch: str, key: str, compare: str, value: str, range_val: str, immediate: bool = False, delay: str = "0") -> None:
        self._add("eC" + input_place, event_name + self._GS + watch + self._GS + key + self._GS + compare + self._GS + value + self._GS + range_val + self._GS + ("1" if immediate else "0") + self._GS + delay)

    def create_custom_dom_event_int_delay(self, input_place: str, event_name: str, watch: str, key: str, compare: str, value: str, range_val: str, immediate: bool, delay: int) -> None:
        self.create_custom_dom_event(input_place, event_name, watch, key, compare, value, range_val, immediate, str(delay))

    def enable_scroll_bottom_event(self, enable: bool = True) -> None:
        self._add("eb", "1" if enable else "0")

    def enable_reached_element_event(self, input_place: str, once: bool, enable: bool = True) -> None:
        self._add("er" + input_place, ("1" if once else "0") + self._GS + ("1" if enable else "0"))

    # Module
    def load_module(self, module_path: str, methods: Optional[List[str]] = None) -> None:
        if methods is None:
            methods = []
        self._add("Ml", module_path + (self._GS + "[" + self._US.join(methods) if len(methods) > 0 else ""))

    def unload_module(self, module_path: str) -> None:
        self._add("Mu", module_path)

    def delete_module_method(self, method_name: str) -> None:
        self._add("Md", method_name)

    # Unit Testing
    # InputPlace Is Actual, Expected Is Tag/OutputPlace
    def assert_equal(self, input_place: str, tag: str) -> None:
        self._add("At" + input_place, tag.replace('\n', "$[ln];"))

    def assert_equal_by_output_place(self, input_place: str, output_place: str) -> None:
        self._add("Ao" + input_place, output_place)

    # Debug
    def create_debugger(self, pause: bool = False) -> None:
        self._add("Dc", "1" if pause else "0")

    # Service Worker
    # To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
    def service_worker_register(self, path: Optional[str] = None, scope_path: Optional[str] = None) -> None:
        self._add("wR", (path or "") + self._GS + (scope_path or ""))

    def service_worker_pre_cache_static(self, path_list: List[str]) -> None:
        self._add("wp", self._GS.join(path_list))

    def service_worker_dynamic_cache(self, path: str, seconds: str = "") -> None:
        self._add("wc", path + (self._GS + seconds if seconds else ""))

    def service_worker_dynamic_cache_int(self, path: str, seconds: int) -> None:
        self.service_worker_dynamic_cache(path, str(seconds) if seconds > 0 else "")

    def service_worker_delete_dynamic_cache(self, path: Optional[str] = None) -> None:
        if path is not None:
            self._add("wd", path)
        else:
            self._add("wd")

    def service_worker_dynamic_cache_ttl_update(self, path: str, seconds: str = "") -> None:
        self._add("wt", path + (self._GS + seconds if seconds else ""))

    def service_worker_dynamic_cache_ttl_update_int(self, path: str, seconds: int) -> None:
        self.service_worker_dynamic_cache_ttl_update(path, str(seconds) if seconds > 0 else "")

    # Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
    # Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
    # CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
    def service_worker_route_set(self, path: str, type_val: str, cache_dynamic: bool = False) -> None:
        self._add("wr", path + self._GS + type_val + (self._GS + "1" if cache_dynamic else ""))

    def service_worker_route_alias(self, path: str, to: str) -> None:
        self._add("wa", path + self._GS + to)

    def service_worker_delete_route_alias(self, path: Optional[str] = None) -> None:
        if path is not None:
            self._add("wC", path)
        else:
            self._add("wC")

    # Delete All Route And Alias
    def service_worker_delete_route(self, path: Optional[str] = None) -> None:
        if path is not None:
            self._add("wD", path)
        else:
            self._add("wD")

    # SSE
    def disconnect_sse(self, path: Optional[str] = None) -> None:
        if path is not None:
            self._add("Ds", path)
        else:
            self._add("Ds")

    def disconnect_all_sse(self) -> None:
        self._add("Ds")

    # State
    def add_state(self, path: Optional[str] = None, title: Optional[str] = None) -> None:
        self._add("AS", (path or "") + self._GS + (title or ""))

    def save_state(self, path: Optional[str] = None, title: Optional[str] = None) -> None:
        self._add("As", (path or "") + self._GS + (title or ""))

    def load_state(self, path: str) -> None:
        self._add("ls", path)

    def delete_state(self, path: Optional[str] = None) -> None:
        if path is not None:
            self._add("DS", path)
        else:
            self._add("DS", "*")

    def delete_all_state(self) -> None:
        self._add("DS", "*")

    # Cookie
    def set_cookie(self, key: str, value: str, seconds: str, path: Optional[str] = None) -> None:
        self._add("sC", key + self._GS + value + self._GS + seconds + (self._GS + path if path else ""))

    def set_cookie_int(self, key: str, value: str, seconds: int, path: Optional[str] = None) -> None:
        self.set_cookie(key, value, str(seconds), path)

    # Save (Session Cache)
    def save_id(self, input_place: str, key: str = ".") -> None:
        self._add("@gi" + input_place, key)

    def save_name(self, input_place: str, key: str = ".") -> None:
        self._add("@gn" + input_place, key)

    def save_value(self, input_place: str, key: str = ".") -> None:
        self._add("@gv" + input_place, key)

    def save_value_length(self, input_place: str, key: str = ".") -> None:
        self._add("@ge" + input_place, key)

    def save_class(self, input_place: str, key: str = ".") -> None:
        self._add("@gc" + input_place, key)

    def save_style(self, input_place: str, key: str = ".") -> None:
        self._add("@gs" + input_place, key)

    def save_title(self, input_place: str, key: str = ".") -> None:
        self._add("@gl" + input_place, key)

    def save_label(self, input_place: str, key: str = ".") -> None:
        self._add("@gA" + input_place, key)

    def save_text(self, input_place: str, key: str = ".") -> None:
        self._add("@gt" + input_place, key)

    def save_outer_text(self, input_place: str, key: str = ".") -> None:
        self._add("@go" + input_place, key)

    def save_text_length(self, input_place: str, key: str = ".") -> None:
        self._add("@gg" + input_place, key)

    def save_attribute(self, input_place: str, attribute: str, key: str = ".") -> None:
        self._add("@ga" + input_place, key + self._GS + attribute)

    def save_width(self, input_place: str, key: str = ".") -> None:
        self._add("@gw" + input_place, key)

    def save_height(self, input_place: str, key: str = ".") -> None:
        self._add("@gh" + input_place, key)

    def save_read_only(self, input_place: str, key: str = ".") -> None:
        self._add("@gr" + input_place, key)

    def save_selected_index(self, input_place: str, key: str = ".") -> None:
        self._add("@gx" + input_place, key)

    def save_text_align(self, input_place: str, key: str = ".") -> None:
        self._add("@gT" + input_place, key)

    def save_node_length(self, input_place: str, key: str = ".") -> None:
        self._add("@gL" + input_place, key)

    def save_visible(self, input_place: str, key: str = ".") -> None:
        self._add("@gV" + input_place, key)

    def save_url(self, url: str, fetch_script: bool = False, key: str = ".") -> None:
        self._add("@gu", key + self._GS + url + (self._GS + "1" if fetch_script else ""))

    def save_index(self, input_place: str, key: str = ".") -> None:
        self._add("@gI" + input_place, key)

    def remove_save(self, cache_key: str) -> None:
        self._add("rs", cache_key)

    def remove_all_save(self) -> None:
        self._add("rs", "*")

    # Calling the SetSave Method Causes Action Control Requests Triggered by Events Using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send Event, to be Temporarily Saved on the Active Page, so the Request will not be Sent to the Server Again.
    def set_save(self) -> None:
        self._add("cs", "*")

    def add_save_value(self, cache_key: str, value: str) -> None:
        self._add("SA", cache_key + self._GS + value.replace('\n', "$[ln];"))

    def insert_save_value(self, cache_key: str, value: str) -> None:
        self._add("SI", cache_key + self._GS + value.replace('\n', "$[ln];"))

    def append_save_value(self, cache_key: str, value: str) -> None:
        self._add("SP", cache_key + self._GS + value.replace('\n', "$[ln];"))

    def replace_save_value(self, cache_key: str, search_value: str, value: str) -> None:
        self._add("SR", cache_key + self._GS + value.replace('\n', "$[ln];") + self._GS + search_value.replace('\n', "$[ln];"))

    # Cache
    def cache_id(self, input_place: str, key: str = ".") -> None:
        self._add("@ci" + input_place, key)

    def cache_name(self, input_place: str, key: str = ".") -> None:
        self._add("@cn" + input_place, key)

    def cache_value(self, input_place: str, key: str = ".") -> None:
        self._add("@cv" + input_place, key)

    def cache_value_length(self, input_place: str, key: str = ".") -> None:
        self._add("@ce" + input_place, key)

    def cache_class(self, input_place: str, key: str = ".") -> None:
        self._add("@cc" + input_place, key)

    def cache_style(self, input_place: str, key: str = ".") -> None:
        self._add("@cs" + input_place, key)

    def cache_title(self, input_place: str, key: str = ".") -> None:
        self._add("@cl" + input_place, key)

    def cache_label(self, input_place: str, key: str = ".") -> None:
        self._add("@cA" + input_place, key)

    def cache_text(self, input_place: str, key: str = ".") -> None:
        self._add("@ct" + input_place, key)

    def cache_outer_text(self, input_place: str, key: str = ".") -> None:
        self._add("@co" + input_place, key)

    def cache_text_length(self, input_place: str, key: str = ".") -> None:
        self._add("@cg" + input_place, key)

    def cache_attribute(self, input_place: str, attribute: str, key: str = ".") -> None:
        self._add("@ca" + input_place, key + self._GS + attribute)

    def cache_width(self, input_place: str, key: str = ".") -> None:
        self._add("@cw" + input_place, key)

    def cache_height(self, input_place: str, key: str = ".") -> None:
        self._add("@ch" + input_place, key)

    def cache_read_only(self, input_place: str, key: str = ".") -> None:
        self._add("@cr" + input_place, key)

    def cache_selected_index(self, input_place: str, key: str = ".") -> None:
        self._add("@cx" + input_place, key)

    def cache_text_align(self, input_place: str, key: str = ".") -> None:
        self._add("@cT" + input_place, key)

    def cache_node_length(self, input_place: str, key: str = ".") -> None:
        self._add("@cL" + input_place, key)

    def cache_visible(self, input_place: str, key: str = ".") -> None:
        self._add("@cV" + input_place, key)

    def cache_url(self, url: str, fetch_script: bool = False, key: str = ".") -> None:
        self._add("@cu", key + self._GS + url + (self._GS + "1" if fetch_script else ""))

    def cache_index(self, input_place: str, key: str = ".") -> None:
        self._add("@cI" + input_place, key)

    def remove_cache(self, cache_key: str) -> None:
        self._add("rd", cache_key)

    def remove_all_cache(self) -> None:
        self._add("rd", "*")

    # Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
    def set_cache(self, second: str) -> None:
        self._add("cd", second)

    def set_cache_int(self, second: int) -> None:
        self.set_cache(str(second))

    def set_cache_no_time(self) -> None:
        self._add("cd", "*")

    def add_cache_value(self, cache_key: str, value: str) -> None:
        self._add("CA", cache_key + self._GS + value.replace('\n', "$[ln];"))

    def insert_cache_value(self, cache_key: str, value: str) -> None:
        self._add("CI", cache_key + self._GS + value.replace('\n', "$[ln];"))

    def append_cache_value(self, cache_key: str, value: str) -> None:
        self._add("CP", cache_key + self._GS + value.replace('\n', "$[ln];"))

    def replace_cache_value(self, cache_key: str, search_value: str, value: str) -> None:
        self._add("CR", cache_key + self._GS + value.replace('\n', "$[ln];") + self._GS + search_value.replace('\n', "$[ln];"))

    # Call
    def load_url(self, input_place: str, url: str) -> None:
        self._add("lu" + input_place, url)

    def run_action_controls(self, action_controls: str, without_web_forms_section: bool = True, index: Optional[str] = None, use_current_event: bool = True) -> None:
        self._add("lA", ("1" if use_current_event else "0") + self._GS + ("1" if without_web_forms_section else "0") + self._GS + (index or "") + self._GS + action_controls)

    def call_script(self, script_text: str) -> None:
        self._add("_", script_text.replace('\n', "$[ln];"))

    def call_method(self, method_name: str, args: Optional[List[str]] = None) -> None:
        args_join = ""
        if args is not None and len(args) > 0:
            args_join = self._GS + "[" + self._US.join(args)
        self._add("lm", method_name + args_join)

    def call_module_method(self, method_name: str, args: Optional[List[str]] = None) -> None:
        args_join = ""
        if args is not None and len(args) > 0:
            args_join = self._GS + "[" + self._US.join(args)
        self._add("lM", method_name + args_join)

    def call_post_back(self, form_input_place: str, output_place: Optional[str] = None) -> None:
        self._add("Lp", "1" + self._GS + form_input_place + (self._GS + output_place if output_place else ""))

    def call_comment_back(self, index: Optional[str] = None, input_place: Optional[str] = None, use_current_event: bool = True) -> None:
        self._add("LC", ("1" if use_current_event else "0") + self._GS + (index or "") + self._GS + (input_place or ""))

    def call_comment_back_int(self, index: int, input_place: Optional[str] = None, use_current_event: bool = True) -> None:
        self.call_comment_back(str(index), input_place, use_current_event)

    def call_wasm_back(self, wasm_language: str, wasm_url: str, method_name: str, args: Optional[List[str]] = None, output_place: Optional[str] = None, use_current_event: bool = True) -> None:
        args_join = ""
        if args is not None and len(args) > 0:
            args_join = "[" + self._US.join(args)
        self._add("Ly", ("1" if use_current_event else "0") + self._GS + wasm_language + self._GS + wasm_url + self._GS + method_name + self._GS + args_join + self._GS + (output_place or ""))

    def call_web_socket_back(self, path: str, use_current_event: bool = True) -> None:
        self._add("Lw", ("1" if use_current_event else "0") + self._GS + path)

    def call_sse_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True, should_reconnect: bool = True, reconnect_try_timeout: str = "3000") -> None:
        val = ("1" if use_current_event else "0") + self._GS + path + self._GS + ("1" if should_reconnect else "0") + self._GS + reconnect_try_timeout
        if output_place is not None:
            val += self._GS + output_place
        self._add("Ls", val)

    def call_sse_back_int(self, path: str, output_place: Optional[str], use_current_event: bool, should_reconnect: bool, reconnect_try_timeout: int) -> None:
        self.call_sse_back(path, output_place, use_current_event, should_reconnect, str(reconnect_try_timeout))

    def call_front(self, module_path: str, args: Optional[List[str]] = None, output_place: Optional[str] = None, use_current_event: bool = True) -> None:
        args_join = ""
        if args is not None and len(args) > 0:
            args_join = self._GS + "[" + self._US.join(args)
        self._add("Lj", ("1" if use_current_event else "0") + self._GS + module_path + self._GS + (output_place or "") + args_join)

    def call_get_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True) -> None:
        self._add("Lg", ("1" if use_current_event else "0") + self._GS + path + (self._GS + output_place if output_place else ""))

    def call_put_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True) -> None:
        self._add("Lt", ("1" if use_current_event else "0") + self._GS + path + (self._GS + output_place if output_place else ""))

    def call_patch_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True) -> None:
        self._add("LP", ("1" if use_current_event else "0") + self._GS + path + (self._GS + output_place if output_place else ""))

    def call_delete_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True) -> None:
        self._add("Ld", ("1" if use_current_event else "0") + self._GS + path + (self._GS + output_place if output_place else ""))

    def call_head_back(self, path: str, use_current_event: bool = True) -> None:
        self._add("Lh", ("1" if use_current_event else "0") + self._GS + path)

    def call_options_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True) -> None:
        self._add("Lo", ("1" if use_current_event else "0") + self._GS + path + (self._GS + output_place if output_place else ""))

    def call_send_back(self, path: str, method: str, is_multi_part: bool, content_type: str, data: str, output_place: Optional[str] = None, use_current_event: bool = True) -> None:
        self._add("LS", ("1" if use_current_event else "0") + self._GS + path + self._GS + method + self._GS + ("1" if is_multi_part else "0") + self._GS + content_type + self._GS + data.replace('\n', "$[ln];") + (self._GS + output_place if output_place else ""))

    # Update
    def increase(self, input_place: str, value: float) -> None:
        self._add("gt" + input_place, "i" + self._GS + str(value))

    def decrease(self, input_place: str, value: float) -> None:
        self._add("gt" + input_place, "i" + self._GS + str(value * -1))

    # If You Don't Use Deep Mode, any Tags Inside the Current Tag Will Simply Be Treated as Strings. Deep Mode Does not Remove Inner Elements.
    def replace(self, input_place: str, value: str, new_value: str, also_start_tag: bool = False, deep: bool = True) -> None:
        self._add("gt" + input_place, "r" + self._GS + value + self._GS + new_value + self._GS + ("1" if also_start_tag else "0") + self._GS + ("1" if deep else "0"))

    # HTML Converts Attribute Names to Lowercase, so they Need to Be Written in Lowercase.
    def replace_start_tag(self, input_place: str, value: str, new_value: str) -> None:
        self._add("gt" + input_place, "s" + self._GS + value + self._GS + new_value)

    # Pre Runner
    def assign_delay(self, mili_second: int, index: int = -1) -> None:
        current_line = self._get_line_by_index(index)
        if not current_line:
            return
        parts = current_line.split('=', 1)
        new_name = ":" + str(mili_second) + ")" + parts[0]
        new_value = parts[1] if len(parts) > 1 else ""
        self._update_line_by_index(index, new_name, new_value)

    def assign_delay_change(self, mili_second: int, index: int = -1) -> None:
        current_line = self._get_line_by_index(index)
        if not current_line:
            return
        parts = current_line.split('=', 1)
        current_name = parts[0]
        if current_name.startswith(":") and ")" in current_name:
            closing_bracket = current_name.index(')')
            current_name = current_name[closing_bracket + 1:]
        new_name = ":" + str(mili_second) + ")" + current_name
        new_value = parts[1] if len(parts) > 1 else ""
        self._update_line_by_index(index, new_name, new_value)

    def assign_interval(self, mili_second: int, id_val: Optional[str] = None, index: int = -1) -> None:
        current_line = self._get_line_by_index(index)
        if not current_line:
            return
        parts = current_line.split('=', 1)
        new_name = "(" + str(mili_second) + ("|" + id_val if id_val else "") + ")" + parts[0]
        new_value = parts[1] if len(parts) > 1 else ""
        self._update_line_by_index(index, new_name, new_value)

    def assign_interval_change(self, mili_second: int, id_val: Optional[str] = None, index: int = -1) -> None:
        current_line = self._get_line_by_index(index)
        if not current_line:
            return
        parts = current_line.split('=', 1)
        current_name = parts[0]
        if current_name.startswith("(") and ")" in current_name:
            closing_bracket = current_name.index(')')
            current_name = current_name[closing_bracket + 1:]
        new_name = "(" + str(mili_second) + ("|" + id_val if id_val else "") + ")" + current_name
        new_value = parts[1] if len(parts) > 1 else ""
        self._update_line_by_index(index, new_name, new_value)

    def delete_interval(self, id_val: str) -> None:
        self._add("Di", id_val)

    def assign_repeat(self, count: int, index: int = -1) -> None:
        current_line = self._get_line_by_index(index)
        if not current_line:
            return
        parts = current_line.split('=', 1)
        new_name = "," + str(count) + ")" + parts[0]
        new_value = parts[1] if len(parts) > 1 else ""
        self._update_line_by_index(index, new_name, new_value)

    def assign_repeat_change(self, count: int, index: int = -1) -> None:
        current_line = self._get_line_by_index(index)
        if not current_line:
            return
        parts = current_line.split('=', 1)
        current_name = parts[0]
        if current_name.startswith(",") and ")" in current_name:
            closing_bracket = current_name.index(')')
            current_name = current_name[closing_bracket + 1:]
        new_name = "," + str(count) + ")" + current_name
        new_value = parts[1] if len(parts) > 1 else ""
        self._update_line_by_index(index, new_name, new_value)

    # Index
    def start_index(self, name: Optional[str] = None) -> None:
        self._add("#", name if name is not None else "")

    # This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
    def start_state(self) -> None:
        self.start_index("$")

    def go_to(self, line: str, repeat: str) -> None:
        self._add("&", line + self._GS + repeat)

    def go_to_int(self, line: int, repeat: int = 1) -> None:
        self.go_to(str(line), str(repeat))

    def go_to_index(self, index: str, repeat: int = 1) -> None:
        self._add("&", "#" + index + self._GS + str(repeat))

    # Start
    def start_transient_dom(self, input_place: str) -> None:
        self._add("td", input_place)

    def end_transient_dom(self) -> None:
        self._add("td", ";")

    # Message
    # Type: warning, problem, help, success, none
    def alert(self, text: str, type_val: str = "none", title: str = "Alert", ok_text: str = "OK") -> None:
        self._add("Al", text + self._GS + ("" if type_val == "none" else type_val) + self._GS + ("" if title == "Alert" else title) + self._GS + ("" if ok_text == "OK" else ok_text))

    def message(self, text: str, type_val: str = "none", duration: str = "0") -> None:
        self._add("me", text + self._GS + ("" if type_val == "none" else type_val) + self._GS + ("" if duration == "0" else duration))

    def message_int(self, text: str, type_val: str, duration: int) -> None:
        self.message(text, type_val, str(duration))

    def message_duration_int(self, text: str, duration: int) -> None:
        self.message(text, "", str(duration))

    # Type: log, info, warn, error, debug, trace, group, groupend, table
    def console_message(self, text: str, type_val: str = "log") -> None:
        self._add("mc", text.replace('\n', "$[ln];") + ("" if type_val == "log" else self._GS + type_val))

    def console_message_assert(self, text: str, condition: str) -> None:
        self._add("ma", text.replace('\n', "$[ln];") + self._GS + condition)

    # Enable
    # Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
    def enable_web_socket(self, enable: bool = True) -> None:
        self._add("ew", "1" if enable else "0")

    def enable_web_socket_once(self) -> None:
        self._add("ew", "$")

    def add_web_socket(self, path: str) -> None:
        self._add("aw" + path)

    # Disconnected WebSocket
    def delete_web_socket(self, path: str) -> None:
        self._add("dw" + path)

    # Use
    # InputPlace Using Only For form Element
    def use_web_socket(self, input_place: str) -> None:
        self._add("uw" + input_place)

    def use_only_change_update(self, input_place: str) -> None:
        self._add("uo" + input_place)

    # Condition And Loop
    # Condition And Loop Supports Brackets and Then
    # Type: warning, problem, help, success, none
    # Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
    # Nested Conditions and Nested Loops are Possible.
    def confirm_is_true_accept(self, text: str = "Are you sure you want to proceed?", type_val: str = "none", title: str = "Confirm", ok_text: str = "OK", cancel_text: str = "Cancel", interval: int = 100) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "ct", ("" if text == "Are you sure you want to proceed?" else text) + self._GS + ("" if type_val == "none" else type_val) + self._GS + ("" if title == "Confirm" else title) + self._GS + ("" if ok_text == "OK" else ok_text) + self._GS + ("" if cancel_text == "Cancel" else cancel_text))
        return self

    def confirm_is_false_accept(self, text: str = "Are you sure you want to proceed?", type_val: str = "none", title: str = "Confirm", ok_text: str = "OK", cancel_text: str = "Cancel", interval: int = 100) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "cf", ("" if text == "Are you sure you want to proceed?" else text) + self._GS + ("" if type_val == "none" else type_val) + self._GS + ("" if title == "Confirm" else title) + self._GS + ("" if ok_text == "OK" else ok_text) + self._GS + ("" if cancel_text == "Cancel" else cancel_text))
        return self

    def is_greater_than(self, first_value: str, second_value: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "gt", first_value + self._GS + second_value)
        return self

    def is_less_than(self, first_value: str, second_value: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "lt", first_value + self._GS + second_value)
        return self

    def is_equal_to(self, first_value: str, second_value: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "et", first_value + self._GS + second_value)
        return self

    def is_not_equal_to(self, first_value: str, second_value: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "Nt", first_value + self._GS + second_value)
        return self

    def exist(self, value: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "ex", value)
        return self

    def not_exist(self, value: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "nx", value)
        return self

    def is_true(self, value: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "tr", value)
        return self

    def is_false(self, value: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "fa", value)
        return self

    def is_match_media(self, value: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "mm", value)
        return self

    def is_not_match_media(self, value: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "nm", value)
        return self

    def include(self, text: str, value: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "In", value + self._GS + text)
        return self

    def not_include(self, text: str, value: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "Nn", value + self._GS + text)
        return self

    def element_exists(self, input_place: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "eE", input_place)
        return self

    def element_not_exists(self, input_place: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "nE", input_place)
        return self

    def is_regex_match(self, value: str, pattern: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "re", value + self._GS + pattern)
        return self

    def is_regex_not_match(self, value: str, pattern: str, interval: int = -1) -> 'WebForms':
        prefix = "{(" + str(interval) + ")" if interval >= 0 else "{"
        self._add(prefix + "rn", value + self._GS + pattern)
        return self

    # In: Everything Becomes A JSON List.
    # Key: Creates A Temporary Data In The Browser IndexedDB.
    # Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
    def for_each(self, path: str, in_val: str, key: str = ".") -> 'WebForms':
        self._add("{fe", path + self._GS + in_val + self._GS + key)
        return self

    def break_loop(self) -> None:
        self._add(";")

    def else_branch(self) -> 'WebForms':
        self._add("}e")
        return self

    def start_bracket(self) -> None:
        self._add("{")

    def end_bracket(self) -> None:
        self._add("}")

    # Used Then In Condition And Loop Methods
    def then(self, new_form: Optional['WebForms']) -> 'WebForms':
        if new_form is None:
            return self
        data = new_form.get_web_forms_data()
        if data:
            if '\n' in data:
                new_form._add_to_up("{")
                new_form._add("}")
        self.append_form(new_form)
        return self

    def then_closure(self, configure: Callable[['WebForms'], None]) -> 'WebForms':
        new_form = WebForms()
        configure(new_form)
        data = new_form.get_web_forms_data()
        if data:
            if '\n' in data:
                new_form._add_to_up("{")
                new_form._add("}")
        self.append_form(new_form)
        return self

    def repeat(self, new_form: 'WebForms', repeat: int) -> 'WebForms':
        if new_form is None:
            return self
        body_data = new_form.get_web_forms_data()
        if not body_data:
            return self
        start_line = len(body_data.split('\n')) * -1
        self.append_form(new_form)
        self.go_to_int(start_line, repeat - 1)
        return self

    def repeat_with_index(self, new_form: 'WebForms', repeat: int, index: str) -> 'WebForms':
        if new_form is None:
            return self
        self.go_to_index(index)
        self.start_index(index)
        body_data = new_form.get_web_forms_data()
        if not body_data:
            return self
        self.append_form(new_form)
        if not index:
            index_number = -1
            for x in self.get_web_forms_data().split('\n'):
                if x.startswith("#"):
                    index_number += 1
            self.go_to_int(index_number, repeat - 1)
        else:
            self.go_to_index(index, repeat - 1)
        return self

    def repeat_closure(self, configure: Callable[['WebForms'], None], repeat: int) -> 'WebForms':
        new_form = WebForms()
        configure(new_form)
        return self.repeat(new_form, repeat)

    def repeat_closure_with_index(self, configure: Callable[['WebForms'], None], repeat: int, index: str) -> 'WebForms':
        new_form = WebForms()
        configure(new_form)
        return self.repeat_with_index(new_form, repeat, index)

    # Async
    # It Supports Brackets and Then
    def async_method(self) -> 'WebForms':
        self._add("{(a)")
        return self

    def delay(self, mili_second: str) -> None:
        self._add("De", mili_second)

    def delay_int(self, mili_second: int) -> None:
        self.delay(str(mili_second))

    # Option
    def change_option(self, name: str, value: str) -> None:
        self._add("co", name + self._GS + value)

    def reset_option(self, name: Optional[str] = None) -> None:
        if name is not None:
            self._add("ro", name)
        else:
            self._add("ro")

    # Format Storage
    def create_format_storage(self, key: str, data: str) -> None:
        self._add(".C", key + self._GS + data)

    def delete_format_storage(self, key: str) -> None:
        self._add(".D", key)

    def add_json(self, key: str, path: str, value: str) -> None:
        self._add(".a", key + self._GS + "j" + self._GS + value + self._GS + path)

    # Name: For Support Attribute, Set Double At Sign (@@) Before Name.
    def add_xml(self, key: str, path: str, name: str, value: Optional[str] = None) -> None:
        self._add(".a", key + self._GS + "x" + self._GS + name + self._GS + (value or "") + self._GS + path)

    def add_ini(self, key: str, path: str, value: str, is_ini_like: bool = False) -> None:
        self._add(".a", key + self._GS + "i" + self._GS + ("1" if is_ini_like else "0") + self._GS + value + self._GS + path)

    def add_text_line(self, key: str, line: str, text: str) -> None:
        self._add(".a", key + self._GS + "t" + self._GS + text + self._GS + line)

    def add_text_line_int(self, key: str, line: int, text: str) -> None:
        self.add_text_line(key, str(line), text)

    def add_variable(self, key: str, value: str) -> None:
        self._add(".a", key + self._GS + "v" + self._GS + value)

    def update_json(self, key: str, path: str, value: str) -> None:
        self._add(".u", key + self._GS + "j" + self._GS + value + self._GS + path)

    def update_xml(self, key: str, path: str, value: str) -> None:
        self._add(".u", key + self._GS + "x" + self._GS + value + self._GS + path)

    def update_ini(self, key: str, path: str, value: str, is_ini_like: bool = False) -> None:
        self._add(".u", key + self._GS + "i" + self._GS + ("1" if is_ini_like else "0") + self._GS + value + self._GS + path)

    def update_tex_line(self, key: str, line: str, text: str) -> None:
        self._add(".u", key + self._GS + "t" + self._GS + text + self._GS + line)

    def update_tex_line_int(self, key: str, line: int, text: str) -> None:
        self.update_tex_line(key, str(line), text)

    def update_variable(self, key: str, value: str) -> None:
        self._add(".u", key + self._GS + "v" + self._GS + value)

    def increace_variable(self, key: str, value: str) -> None:
        self._add(".i", key + self._GS + "v" + self._GS + value)

    def increace_variable_int(self, key: str, value: int) -> None:
        self.increace_variable(key, str(value))

    def decrease_variable(self, key: str, value: int) -> None:
        self.increace_variable(key, str(value * -1))

    def delete_json(self, key: str, path: str) -> None:
        self._add(".d", key + self._GS + "j" + self._GS + path)

    def delete_xml(self, key: str, path: str) -> None:
        self._add(".d", key + self._GS + "x" + self._GS + path)

    def delete_ini(self, key: str, path: str, is_ini_like: bool = False) -> None:
        self._add(".d", key + self._GS + "i" + self._GS + ("1" if is_ini_like else "0") + self._GS + path)

    def delete_text_line(self, key: str, line: str) -> None:
        self._add(".d", key + self._GS + "t" + self._GS + line)

    def delete_text_line_int(self, key: str, line: int) -> None:
        self.delete_text_line(key, str(line))

    def delete_variable(self, key: str) -> None:
        self._add(".d", key + self._GS + "v")

    # Template Engine
    # Pattern Example: {{value}}, ((value)), *value*, $value;
    def bind_json_to_template(self, input_place: str, json_text: str, path: str, pattern: str, also_start_tag: bool = True) -> None:
        self._add("Tj" + input_place, json_text + self._GS + path + self._GS + pattern + self._GS + ("1" if also_start_tag else "0"))

    # Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
    def bind_xml_to_template(self, input_place: str, xml_text: str, path: str, pattern: str, also_start_tag: bool = True) -> None:
        self._add("Tx" + input_place, xml_text + self._GS + path + self._GS + pattern + self._GS + ("1" if also_start_tag else "0"))

    def bind_ini_to_template(self, input_place: str, ini_text: str, path: str, pattern: str, also_start_tag: bool = True) -> None:
        self._add("Ti" + input_place, ini_text + self._GS + path + self._GS + pattern + self._GS + ("1" if also_start_tag else "0"))

    # Inject
    # Need Add @: to First of String
    def inject(self, value: str) -> str:
        return "$[" + value + "];"

    # Action Control
    def replace_action_control(self, search_value: str, value: str, adding_to_up: bool = False) -> None:
        if adding_to_up:
            self._add_to_up("rE", search_value + self._GS + value)
        else:
            self._add("rE", search_value + self._GS + value)

    def assign_replace(self, search_value: str, value: str, index: int = -1) -> None:
        current_line = self._get_line_by_index(index)
        if not current_line:
            return
        parts = current_line.split('=', 1)
        new_name = ";" + search_value + self._GS + value + self._GS + parts[0]
        new_value = parts[1] if len(parts) > 1 else ""
        self._update_line_by_index(index, new_name, new_value)

    # Hash And Checksum
    def set_hash(self) -> None:
        self._add("SH")

    def set_checksum(self) -> None:
        self._add("CS")

    def checksum_calculation(self, text: str) -> str:
        sum_val = 0
        mod = 65536
        shift = 5
        for c in text:
            sum_val = ((sum_val << shift) | (sum_val >> (16 - shift))) ^ ord(c)
            sum_val %= mod
        return str(sum_val)

    def get_checksum(self) -> str:
        return self.checksum_calculation(self.get_web_forms_data())

    # Get
    def get_forms_action_data(self) -> str:
        return self._web_forms_data

    def response(self) -> str:
        return "[web-forms]\n" + self.get_forms_action_data()

    def get_forms_action_data_line_break(self) -> str:
        if not self._web_forms_data:
            return ""
        processed_data = self._web_forms_data.replace('"', "$[dq];")
        return processed_data.replace('\n', "$[sln];")

    # Export
    def export_to_html_comment(self, add_line: bool = False) -> str:
        response = self.response().replace("--", "$[dd];")
        if response.endswith('-'):
            response = response[:-1] + "$[da];"
        return ("\n" if add_line else "") + "<!--" + response + "-->"

    # Using it for SSE Response
    def export_to_line_break(self, src: Optional[str] = None) -> str:
        return "[web-forms]$[sln];" + self.get_forms_action_data_line_break()

    def get_web_forms_data(self) -> str:
        return self._web_forms_data

    def append_form(self, form: Optional['WebForms']) -> None:
        if form is None:
            return
        other_data = form.get_web_forms_data()
        if other_data:
            if len(self._web_forms_data) > 0:
                self._web_forms_data += '\n'
            self._web_forms_data += other_data

    def clean(self) -> None:
        self._web_forms_data = ""


class Security:
    def safe_value(self, value: str) -> str:
        if len(value) < 1:
            return value
        if value[0] == '@':
            value = "@" + value
        value = value.replace('\n', "$[ln];")
        value = value.replace(",@", "$[co];@")
        value = value.replace(chr(28), '\0')
        value = value.replace(chr(29), '\0')
        value = value.replace(chr(30), '\0')
        value = value.replace(chr(31), '\0')
        return value


# WebForms Place Criteria (WPC) DSL
class InputPlace:
    DOCUMENT = ","
    WINDOW = "`"
    # When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
    ROOT = "~"
    HTML = "."
    HEAD = "^"
    SCREEN_ORIENTATION = "%"
    ALL = "*"
    PARENT = "/"
    CURRENT = "$"
    TARGET = "!"
    UPPER = "-"

    @staticmethod
    def id(id_val: str) -> str:
        return id_val

    @staticmethod
    def name(name: str, index: Optional[int] = None) -> str:
        if index is not None:
            return '(' + name + ')' + str(index)
        return '(' + name + ')'

    @staticmethod
    def all_names(name: str) -> str:
        return "(" + name + ")*"

    @staticmethod
    def tag(tag: str, index: Optional[int] = None) -> str:
        if index is not None:
            return '<' + tag + '>' + str(index)
        return '<' + tag + '>'

    @staticmethod
    def all_tags(tag: str) -> str:
        return "<" + tag + ">*"

    @staticmethod
    def child(index: Optional[int] = None) -> str:
        if index is not None:
            return "<>" + str(index)
        return "<>"

    @staticmethod
    def all_child() -> str:
        return "<>*"

    @staticmethod
    def class_val(class_val: str, index: Optional[int] = None) -> str:
        if index is not None:
            return '{' + class_val + '}' + str(index)
        return '{' + class_val + '}'

    @staticmethod
    def all_classes(class_val: str) -> str:
        return "{" + class_val + "}*"

    @staticmethod
    def attribute(name: str, index_or_value: Union[int, str, None] = None, value_or_index: Union[int, str, None] = None, operator: str = "") -> str:
        # Replicating C# overload logic
        if index_or_value is None:
            return '"' + name + '"'
        if isinstance(index_or_value, int):
            return '"' + name + '"' + str(index_or_value)
        
        op_str = operator if operator else ""
        if isinstance(value_or_index, int):
            return '"' + name + op_str + "'" + str(index_or_value) + '"' + str(value_or_index)
        
        return '"' + name + op_str + "'" + str(index_or_value) + '"'

    @staticmethod
    def all_attributes(name: str, value: Optional[str] = None, operator: str = "") -> str:
        if value is None:
            return '"' + name + '"*'
        op_str = operator if operator else ""
        return '"' + name + op_str + "'" + value + '"*'

    @staticmethod
    def query(query: str) -> str:
        return "*" + query.replace("=", "$[eq];").replace("|", "$[vb];").replace("?", "$[qu];")

    @staticmethod
    def query_all(query: str) -> str:
        return "[" + query.replace("=", "$[eq];").replace("|", "$[vb];").replace("?", "$[qu];")


class OutputPlace(InputPlace):
    pass


# Do not Add any Data Before or After it
class Fetch:
    _RS = chr(30)
    _US = chr(31)

    # Method
    @staticmethod
    def random(max_value: int, min_value: Optional[int] = None) -> str:
        if min_value is not None:
            return "@mr" + str(max_value) + Fetch._RS + str(min_value)
        return "@mr" + str(max_value)

    @staticmethod
    def space_to_char(text: str, character: str = "-") -> str:
        return "@sc" + character + Fetch._RS + text

    @staticmethod
    def encode_uri(text: str) -> str:
        return "@ue" + text

    @staticmethod
    def decode_uri(text: str) -> str:
        return "@ud" + text

    @staticmethod
    def method(method_name: str, args: Optional[List[str]] = None) -> str:
        return_value = "@cm" + method_name
        if args is not None and len(args) > 0:
            return_value += Fetch._RS + Fetch._US.join(args)
        return return_value

    @staticmethod
    def module_method(method_name: str, args: Optional[List[str]] = None) -> str:
        return_value = "@cM" + method_name
        if args is not None and len(args) > 0:
            return_value += Fetch._RS + Fetch._US.join(args)
        return return_value

    # MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
    @staticmethod
    def wasm_method(wasm_language: str, wasm_url: str, method_name: str, args: Optional[List[str]] = None, key: str = ".") -> str:
        return_value = "@wA" + wasm_language + Fetch._RS + wasm_url + Fetch._RS + method_name
        if args is not None and len(args) > 0:
            return_value += Fetch._RS + Fetch._US.join(args)
        return return_value

    @staticmethod
    def script(script_text: str) -> str:
        return "@_" + script_text.replace('\n', "$[ln];")

    @staticmethod
    def load_url(url: str, fetch_script: bool = False) -> str:
        return "@lu" + url + (Fetch._RS + "1" if fetch_script else "")

    @staticmethod
    def load_html(url: str, fetch_input_place: str = "", fetch_script: bool = False) -> str:
        return "@lh" + url + Fetch._RS + ("1" if fetch_script else "0") + (Fetch._RS + fetch_input_place if fetch_input_place else "")

    @staticmethod
    def load_line(url: str, line: int) -> str:
        return "@ll" + url + Fetch._RS + str(line)

    @staticmethod
    def load_ini(url: str, name: str, is_ini_like: bool = False) -> str:
        return "@li" + url + Fetch._RS + name + (Fetch._RS + "1" if is_ini_like else "")

    # Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
    @staticmethod
    def load_json(url: str, name: str) -> str:
        return "@lj" + url + Fetch._RS + name

    # Name: Name Or XPath; XPath Index Starts At 1
    @staticmethod
    def load_xml(url: str, name: str) -> str:
        return "@lx" + url + Fetch._RS + name

    # MethodName: It's Check Function Or Variable
    @staticmethod
    def has_method(method_name: str) -> str:
        return "@hm" + method_name

    @staticmethod
    def has_module_method(method_name: str) -> str:
        return "@hM" + method_name

    # This Method Return True Or False If Key Pressed
    # Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
    @staticmethod
    def get_modifier_state(modifier: str) -> str:
        return "@ms" + modifier

    # Math
    @staticmethod
    def math(method_name: str, args: Optional[List[str]] = None) -> str:
        return_value = "@M#" + method_name
        if args is not None and len(args) > 0:
            return_value += Fetch._RS + Fetch._US.join(args)
        return return_value

    # Data
    DATE_YEAR = "@dy"
    # Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1 
    DATE_MONTH = "@dm"
    DATE_DAY = "@dd"
    DATE_DATE = "@dD"
    DATE_HOURS = "@dh"
    DATE_MINUTES = "@di"
    DATE_SECONDS = "@ds"
    DATE_MILLISECONDS = "@dl"

    # String
    SPACE = "@sp"
    AT_SIGN = "@sa"

    # Tag
    @staticmethod
    def get_id(input_place: str) -> str:
        return "@$i" + input_place

    @staticmethod
    def get_name(input_place: str) -> str:
        return "@$n" + input_place

    @staticmethod
    def get_value(input_place: str) -> str:
        return "@$v" + input_place

    @staticmethod
    def get_value_length(input_place: str) -> str:
        return "@$e" + input_place

    @staticmethod
    def get_class(input_place: str) -> str:
        return "@$c" + input_place

    @staticmethod
    def get_style(input_place: str) -> str:
        return "@$s" + input_place

    @staticmethod
    def get_title(input_place: str) -> str:
        return "@$l" + input_place

    @staticmethod
    def get_label(input_place: str) -> str:
        return "@$A" + input_place

    @staticmethod
    def get_text(input_place: str) -> str:
        return "@$t" + input_place

    @staticmethod
    def get_outer_text(input_place: str) -> str:
        return "@$o" + input_place

    @staticmethod
    def get_text_length(input_place: str) -> str:
        return "@$g" + input_place

    @staticmethod
    def get_attribute(input_place: str, attribute: str) -> str:
        return "@$a" + input_place + Fetch._RS + attribute

    @staticmethod
    def get_width(input_place: str) -> str:
        return "@$w" + input_place

    @staticmethod
    def get_height(input_place: str) -> str:
        return "@$h" + input_place

    @staticmethod
    def get_is_read_only(input_place: str) -> str:
        return "@$r" + input_place

    @staticmethod
    def get_selected_index(input_place: str) -> str:
        return "@$x" + input_place

    @staticmethod
    def get_index(input_place: str) -> str:
        return "@$I" + input_place

    @staticmethod
    def get_text_align(input_place: str) -> str:
        return "@$T" + input_place

    @staticmethod
    def get_node_length(input_place: str) -> str:
        return "@$L" + input_place

    @staticmethod
    def get_is_visible(input_place: str) -> str:
        return "@$V" + input_place

    # Save
    @staticmethod
    def has_hash(hash_val: str) -> str:
        return "@HH" + hash_val

    @staticmethod
    def cookie(key: str) -> str:
        return "@co" + key

    @staticmethod
    def save(key: str = ".", replace_value: Optional[str] = None) -> str:
        if replace_value is not None:
            return "@cs" + key + Fetch._RS + replace_value
        return "@cs" + key

    @staticmethod
    def save_then_remove(key: str) -> str:
        return "@cl" + key

    @staticmethod
    def save_length(key: str = ".") -> str:
        return "@cg" + key

    @staticmethod
    def cache(key: str = ".", replace_value: Optional[str] = None) -> str:
        if replace_value is not None:
            return "@cd" + key + Fetch._RS + replace_value
        return "@cd" + key

    @staticmethod
    def cache_then_remove(key: str) -> str:
        return "@ct" + key

    @staticmethod
    def cache_length(key: str = ".") -> str:
        return "@cG" + key

    @staticmethod
    def save_line(key: str = ".", line: int = 0) -> str:
        return "@lL" + key + "[" + str(line)

    @staticmethod
    def save_line_consume(key: str = ".") -> str:
        return "@lL" + key

    # INIKey: Only Direct Key is Supported
    @staticmethod
    def save_ini(key: str, ini_key: str) -> str:
        return "@lI" + key + "[" + ini_key

    @staticmethod
    def cache_line(key: str = ".", line: int = 0) -> str:
        return "@dL" + key + "[" + str(line)

    @staticmethod
    def cache_line_consume(key: str = ".") -> str:
        return "@dL" + key

    # INIKey: Only Direct Key is Supported
    @staticmethod
    def cache_ini(key: str, ini_key: str) -> str:
        return "@dI" + key + "[" + ini_key

    # Format Storage
    @staticmethod
    def format_store(key: str) -> str:
        return "@fr" + key

    @staticmethod
    def format_store_by_xml_query(key: str, xpath: str) -> str:
        return "@fx" + key + Fetch._RS + xpath

    @staticmethod
    def format_store_by_json_query(key: str, query: str) -> str:
        return "@fj" + key + Fetch._RS + query

    @staticmethod
    def format_store_by_ini(key: str, name: str) -> str:
        return "@fi" + key + Fetch._RS + name

    @staticmethod
    def format_store_by_text(key: str, line: int) -> str:
        return "@ft" + key + Fetch._RS + str(line)

    @staticmethod
    def format_store_by_variable(key: str) -> str:
        return "@fv" + key

    # State
    @staticmethod
    def has_state(path: str) -> str:
        return "@hs" + path

    # SSE
    @staticmethod
    def sse_is_connected(path: str) -> str:
        return "@Sc" + path

    # WebSockets
    @staticmethod
    def web_sockets_is_connected(path: str = "") -> str:
        return "@Wc" + path

    # Document
    TAB_IS_ACTIVE = "@da"

    # Window
    HREF = "@wf"
    PATH_NAME = "@wP"
    
    @staticmethod
    def query(name: str = "*") -> str:
        return "@wq" + name
        
    HASH = "@wh"
    HOST = "@wH"
    HOST_NAME = "@wn"
    PORT = "@wT"
    ORIGIN = "@wo"
    GET_SELECTION = "@ws"
    SCROLL_X = "@wx"
    SCROLL_Y = "@wy"
    
    @staticmethod
    def segment(index: int) -> str:
        return "@wS" + str(index)
        
    # It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
    @staticmethod
    def hash_segment(index: int) -> str:
        return "@wt" + str(index)

    # Navigator
    CLIPBOARD_TEXT = "@nC"
    GEO_LATITUDE = "@nW"
    GEO_LONGITUDE = "@nO"
    LANGUAGE = "@nL"
    IS_ON_LINE = "@no"
    USER_AGENT = "@na"

    # Screen
    SCREEN_WIDTH = "@sw"
    SCREEN_HEIGHT = "@sh"
    SCREEN_ORIENTATION_TYPE = "@so"
    SCREEN_ORIENTATION_ANGLE = "@sr"

    # Performance
    TIME_ORIGIN = "@pt"
    PERFORMANCE_NOW = "@pn"

    # Event
    EVENT = "@EV"
    EVENT_SERIALIZE = "@Es"
    EVENT_KEY = "@ek"
    EVENT_WHICH = "@ew"
    EVENT_CLIENT_X = "@ex"
    EVENT_CLIENT_Y = "@ey"
    EVENT_PAGE_X = "@eX"
    EVENT_PAGE_Y = "@eY"
    EVENT_OFFSET_X = "@Ex"
    EVENT_OFFSET_Y = "@Ey"
    EVENT_DELTA_Y = "@ed"


class WasmLanguage:
    # The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
    C = "c"
    CPP = "c"
    RUST = "rust"
    C_SHARP = "csharp"
    # .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
    C_SHARP_MEDIATOR = "csharp-m"
    GO = "go"
    JAVA = "java"
    ASSEMBLY_SCRIPT = "as"


class HtmlEvent:
    ON_ABORT = "onabort"
    ON_AFTER_PRINT = "onafterprint"
    ON_BEFORE_PRINT = "onbeforeprint"
    ON_BEFORE_UNLOAD = "onbeforeunload"
    ON_BLUR = "onblur"
    ON_CAN_PLAY = "oncanplay"
    ON_CAN_PLAY_THROUGH = "oncanplaythrough"
    ON_CHANGE = "onchange"
    ON_CLICK = "onclick"
    ON_COPY = "oncopy"
    ON_CUT = "oncut"
    ON_DOUBLE_CLICK = "ondblclick"
    ON_DRAG = "ondrag"
    ON_DRAG_END = "ondragend"
    ON_DRAG_ENTER = "ondragenter"
    ON_DRAG_LEAVE = "ondragleave"
    ON_DRAG_OVER = "ondragover"
    ON_DRAG_START = "ondragstart"
    ON_DROP = "ondrop"
    ON_DURATION_CHANGE = "ondurationchange"
    ON_ENDED = "onended"
    ON_ERROR = "onerror"
    ON_FOCUS = "onfocus"
    ON_FOCUS_IN = "onfocusin"
    ON_FOCUS_OUT = "onfocusout"
    ON_HASH_CHANGE = "onhashchange"
    ON_INPUT = "oninput"
    ON_INVALID = "oninvalid"
    ON_KEY_DOWN = "onkeydown"
    ON_KEY_PRESS = "onkeypress"
    ON_KEY_UP = "onkeyup"
    ON_LOAD = "onload"
    ON_LOADED_DATA = "onloadeddata"
    ON_LOADED_META_DATA = "onloadedmetadata"
    ON_LOAD_START = "onloadstart"
    ON_MOUSE_DOWN = "onmousedown"
    ON_MOUSE_ENTER = "onmouseenter"
    ON_MOUSE_LEAVE = "onmouseleave"
    ON_MOUSE_MOVE = "onmousemove"
    ON_MOUSE_OVER = "onmouseover"
    ON_MOUSE_OUT = "onmouseout"
    ON_MOUSE_UP = "onmouseup"
    ON_OFFLINE = "onoffline"
    ON_ONLINE = "ononline"
    ON_PAGE_HIDE = "onpagehide"
    ON_PAGE_SHOW = "onpageshow"
    ON_PASTE = "onpaste"
    ON_PAUSE = "onpause"
    ON_PLAY = "onplay"
    ON_PLAYING = "onplaying"
    ON_PROGRESS = "onprogress"
    ON_RATE_CHANGE = "onratechange"
    ON_RESIZE = "onresize"
    ON_RESET = "onreset"
    ON_SCROLL = "onscroll"
    ON_SEARCH = "onsearch"
    ON_SEEKED = "onseeked"
    ON_SEEKING = "onseeking"
    ON_SELECT = "onselect"
    ON_STALLED = "onstalled"
    ON_SUBMIT = "onsubmit"
    ON_SUSPEND = "onsuspend"
    ON_TIME_UPDATE = "ontimeupdate"
    ON_TOGGLE = "ontoggle"
    ON_TOUCH_CANCEL = "ontouchcancel"
    ON_TOUCH_END = "ontouchend"
    ON_TOUCH_MOVE = "ontouchmove"
    ON_TOUCH_START = "ontouchstart"
    ON_UNLOAD = "onunload"
    ON_VOLUME_CHANGE = "onvolumechange"
    ON_WAITING = "onwaiting"
    ON_WHEEL = "onwheel"


class HtmlEventListener:
    ABORT = "abort"
    AFTER_PRINT = "afterprint"
    BEFORE_PRINT = "beforeprint"
    BEFORE_UNLOAD = "beforeunload"
    BLUR = "blur"
    CAN_PLAY = "canplay"
    CAN_PLAY_THROUGH = "canplaythrough"
    CHANGE = "change"
    CLICK = "click"
    COPY = "copy"
    CUT = "cut"
    DOUBLE_CLICK = "dblclick"
    DRAG = "drag"
    DRAG_END = "dragend"
    DRAG_ENTER = "dragenter"
    DRAG_LEAVE = "dragleave"
    DRAG_OVER = "dragover"
    DRAG_START = "dragstart"
    DROP = "drop"
    DURATION_CHANGE = "durationchange"
    ENDED = "ended"
    ERROR = "error"
    FOCUS = "focus"
    FOCUS_IN = "focusin"
    FOCUS_OUT = "focusout"
    HASH_CHANGE = "hashchange"
    INPUT = "input"
    INVALID = "invalid"
    KEY_DOWN = "keydown"
    KEY_PRESS = "keypress"
    KEY_UP = "keyup"
    LOAD = "load"
    LOADED_DATA = "loadeddata"
    LOADED_META_DATA = "loadedmetadata"
    LOAD_START = "loadstart"
    MOUSE_DOWN = "mousedown"
    MOUSE_ENTER = "mouseenter"
    MOUSE_LEAVE = "mouseleave"
    MOUSE_MOVE = "mousemove"
    MOUSE_OVER = "mouseover"
    MOUSE_OUT = "mouseout"
    MOUSE_UP = "mouseup"
    OFFLINE = "offline"
    ONLINE = "online"
    PAGE_HIDE = "pagehide"
    PAGE_SHOW = "pageshow"
    PASTE = "paste"
    PAUSE = "pause"
    PLAY = "play"
    PLAYING = "playing"
    PROGRESS = "progress"
    RATE_CHANGE = "ratechange"
    RESIZE = "resize"
    RESET = "reset"
    SCROLL = "scroll"
    SEARCH = "search"
    SEEKED = "seeked"
    SEEKING = "seeking"
    SELECT = "select"
    STALLED = "stalled"
    SUBMIT = "submit"
    SUSPEND = "suspend"
    TIME_UPDATE = "timeupdate"
    TOGGLE = "toggle"
    TOUCH_CANCEL = "touchcancel"
    TOUCH_END = "touchend"
    TOUCH_MOVE = "touchmove"
    TOUCH_START = "touchstart"
    UNLOAD = "unload"
    VOLUME_CHANGE = "volumechange"
    WAITING = "waiting"
    WHEEL = "wheel"

    ANIMATION_END = "animationend"
    ANIMATION_ITERATION = "animationiteration"
    ANIMATION_START = "animationstart"
    CONTEXT_MENU = "contextmenu"
    FULL_SCREEN_CHANGE = "fullscreenchange"
    FULL_SCREEN_ERROR = "fullscreenerror"
    POP_STATE = "popstate"
    TRANSITION_END = "transitionend"
    STORAGE = "storage"

    # Custom
    SCROLL_BOTTOM = "scrollbottom" # Need Call EnableScrollBottomEvent Method Before
    ELEMENT_REACHED = "elementreached" # Need Call EnableReachedElementEvent Method Before


class ExtensionWebFormsMethods:
    @staticmethod
    def child(text: str, value: str) -> str:
        if len(text) < 1:
            return value
        return text + "|" + value

    @staticmethod
    def parent(text: str) -> str:
        if len(text) < 1:
            return text
        if text.endswith("|/") or text.endswith("//"):
            return text + '/'
        return text + "|/"

    @staticmethod
    def criteria(text: str, value: str) -> str:
        if len(text) < 1:
            return value
        return text + "?" + value.replace("|", "$[vb];").replace("?", "$[qu];")

    @staticmethod
    def append_fetch_replace(text: str, search_value: str, value: str) -> str:
        fs = chr(28)
        text = text[1:] if len(text) > 0 else ""
        return "@;" + search_value + fs + value + fs + text

    @staticmethod
    def line_break(text: str, encode_line: bool = False) -> str:
        encode = "$[sln];" if encode_line else ""
        return text.replace("\r\n", encode).replace("\n", encode).replace("\r", encode)

    # Converts Numbers to Strings
    @staticmethod
    def to_js_string(text: str) -> str:
        return '"' + text + '"'

    # Get JS Object Momentary 
    @staticmethod
    def to_js_object(text: str) -> str:
        return "$" + text

    # Get JS Object Returned Value Once
    @staticmethod
    def to_js_return_object(text: str) -> str:
        return "$@" + text
