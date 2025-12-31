# WebForms.py 2.0 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
# Compatible with WebFormsJS version 2.0

import re
import time
from typing import Optional, List, Union

class WebForms:
    def __init__(self):
        self.web_forms_data = []
    
    def _add(self, name: str, value: str = ""):
        if value:
            self.web_forms_data.append(f"{name}={value}")
        else:
            self.web_forms_data.append(name)
    
    def _get_line_by_index(self, index: int) -> str:
        if not self.web_forms_data or index >= len(self.web_forms_data):
            return ""
        
        if index < 0:
            index = len(self.web_forms_data) + index
        
        if index < 0 or index >= len(self.web_forms_data):
            return ""
        
        return self.web_forms_data[index]
    
    def _update_line_by_index(self, index: int, name: str, value: str = ""):
        if not self.web_forms_data or index >= len(self.web_forms_data):
            return
        
        if index < 0:
            index = len(self.web_forms_data) + index
        
        if index < 0 or index >= len(self.web_forms_data):
            return
        
        if value:
            self.web_forms_data[index] = f"{name}={value}"
        else:
            self.web_forms_data[index] = name
    
    # For Extension
    def add_line(self, name: str, value: str):
        self._add(name, value)
    
    # Add
    def add_id(self, input_place: str, element_id: str):
        self._add(f"ai{input_place}", element_id)
    
    def add_name(self, input_place: str, name: str):
        self._add(f"an{input_place}", name)
    
    def add_value(self, input_place: str, value: str):
        self._add(f"av{input_place}", value)
    
    def add_class(self, input_place: str, class_name: str):
        self._add(f"ac{input_place}", class_name)
    
    def add_style(self, input_place: str, style: str):
        self._add(f"as{input_place}", style)
    
    def add_style_property(self, input_place: str, name: str, value: str):
        self._add(f"as{input_place}", f"{name}:{value}")
    
    def add_option_tag(self, input_place: str, text: str, value: str, selected: bool = False):
        self._add(f"ao{input_place}", f"{value}|{text}" + ("|1" if selected else ""))
    
    def add_checkbox_tag(self, input_place: str, text: str, value: str, checked: bool = False):
        self._add(f"ak{input_place}", f"{value}|{text}" + ("|1" if checked else ""))
    
    def add_title(self, input_place: str, title: str):
        self._add(f"al{input_place}", title)
    
    def add_label(self, input_place: str, label: str):
        self._add(f"aA{input_place}", label)
    
    def add_text(self, input_place: str, text: str):
        self._add(f"at{input_place}", text.replace('\n', '$[ln];'))
    
    def add_text_to_up(self, input_place: str, text: str):
        self._add(f"pt{input_place}", text.replace('\n', '$[ln];'))
    
    def add_attribute(self, input_place: str, attribute: str, value: str = "", splitter: str = '\0'):
        splitter_str = splitter if splitter != '\0' else ""
        self._add(f"aa{input_place}", f"{attribute}|{splitter_str}" + (f"|{value}" if value else ""))
    
    def add_tag(self, input_place: str, tag_name: str, element_id: str = ""):
        self._add(f"nt{input_place}", tag_name + (f"|{element_id}" if element_id else ""))
    
    def add_tag_to_up(self, input_place: str, tag_name: str, element_id: str = ""):
        self._add(f"ut{input_place}", tag_name + (f"|{element_id}" if element_id else ""))
    
    def add_tag_before(self, input_place: str, tag_name: str, element_id: str = ""):
        self._add(f"bt{input_place}", tag_name + (f"|{element_id}" if element_id else ""))
    
    def add_tag_after(self, input_place: str, tag_name: str, element_id: str = ""):
        self._add(f"ft{input_place}", tag_name + (f"|{element_id}" if element_id else ""))
    
    def add_hidden(self, input_place: str, value: str, element_id: str = ""):
        self._add(f"ah{input_place}", value + (f"|{element_id}" if element_id else ""))
    
    # Set
    def set_id(self, input_place: str, element_id: str):
        self._add(f"si{input_place}", element_id)
    
    def set_name(self, input_place: str, name: str):
        self._add(f"sn{input_place}", name)
    
    def set_value(self, input_place: str, value: str):
        self._add(f"sv{input_place}", value)
    
    def set_class(self, input_place: str, class_name: str):
        self._add(f"sc{input_place}", class_name)
    
    def set_style(self, input_place: str, style: str):
        self._add(f"ss{input_place}", style)
    
    def set_style_property(self, input_place: str, name: str, value: str):
        self._add(f"ss{input_place}", f"{name}:{value}")
    
    def set_option_tag(self, input_place: str, text: str, value: str, selected: bool = False):
        self._add(f"so{input_place}", f"{value}|{text}" + ("|1" if selected else ""))
    
    def set_checked(self, input_place: str, checked: bool = False):
        self._add(f"sk{input_place}", "1" if checked else "0")
    
    def set_checkbox_tag(self, input_place: str, text: str, value: str, checked: bool = False):
        self._add(f"sk{input_place}", f"{value}|{text}" + ("|1" if checked else ""))
    
    def set_title(self, input_place: str, title: str):
        self._add(f"sl{input_place}", title)
    
    def set_label(self, input_place: str, label: str):
        self._add(f"sA{input_place}", label)
    
    def set_text(self, input_place: str, text: str):
        self._add(f"st{input_place}", text.replace('\n', '$[ln];'))
    
    def set_attribute(self, input_place: str, attribute: str, value: str = ""):
        self._add(f"sa{input_place}", f"{attribute}" + (f"|{value}" if value else ""))
    
    def set_width(self, input_place: str, width: Union[str, int]):
        if isinstance(width, int):
            width = f"{width}px"
        self._add(f"sw{input_place}", width)
    
    def set_height(self, input_place: str, height: Union[str, int]):
        if isinstance(height, int):
            height = f"{height}px"
        self._add(f"sh{input_place}", height)
    
    def set_background_color(self, input_place: str, color: str):
        self._add(f"bc{input_place}", color)
    
    def set_text_color(self, input_place: str, color: str):
        self._add(f"tc{input_place}", color)
    
    def set_font_name(self, input_place: str, name: str):
        self._add(f"fn{input_place}", name)
    
    def set_font_size(self, input_place: str, size: Union[str, int]):
        if isinstance(size, int):
            size = f"{size}px"
        self._add(f"fs{input_place}", size)
    
    def set_font_bold(self, input_place: str, bold: bool):
        self._add(f"fb{input_place}", "1" if bold else "0")
    
    def set_visible(self, input_place: str, visible: bool):
        self._add(f"vi{input_place}", "1" if visible else "0")
    
    def set_text_align(self, input_place: str, align: str):
        self._add(f"ta{input_place}", align)
    
    def set_read_only(self, input_place: str, read_only: bool):
        self._add(f"sr{input_place}", "1" if read_only else "0")
    
    def set_disabled(self, input_place: str, disabled: bool):
        self._add(f"sd{input_place}", "1" if disabled else "0")
    
    def set_focus(self, input_place: str, focus: bool):
        self._add(f"sf{input_place}", "1" if focus else "0")
    
    def set_min_length(self, input_place: str, length: int):
        self._add(f"mn{input_place}", str(length))
    
    def set_max_length(self, input_place: str, length: int):
        self._add(f"mx{input_place}", str(length))
    
    def set_selected_value(self, input_place: str, value: str):
        self._add(f"ts{input_place}", value)
    
    def set_selected_index(self, input_place: str, index: int):
        self._add(f"ti{input_place}", str(index))
    
    def set_checked_value(self, input_place: str, value: str, selected: bool):
        self._add(f"ks{input_place}", f"{value}|{'1' if selected else '0'}")
    
    def set_checked_index(self, input_place: str, index: int, selected: bool):
        self._add(f"ki{input_place}", f"{index}|{'1' if selected else '0'}")
    
    # Insert
    def insert_id(self, input_place: str, element_id: str):
        self._add(f"ii{input_place}", element_id)
    
    def insert_name(self, input_place: str, name: str):
        self._add(f"in{input_place}", name)
    
    def insert_value(self, input_place: str, value: str):
        self._add(f"iv{input_place}", value)
    
    def insert_class(self, input_place: str, class_name: str):
        self._add(f"ic{input_place}", class_name)
    
    def insert_style(self, input_place: str, style: str):
        self._add(f"is{input_place}", style)
    
    def insert_style_property(self, input_place: str, name: str, value: str):
        self._add(f"is{input_place}", f"{name}:{value}")
    
    def insert_option_tag(self, input_place: str, text: str, value: str, selected: bool = False):
        self._add(f"io{input_place}", f"{value}|{text}" + ("|1" if selected else ""))
    
    def insert_checkbox_tag(self, input_place: str, text: str, value: str, checked: bool = False):
        self._add(f"ik{input_place}", f"{value}|{text}" + ("|1" if checked else ""))
    
    def insert_title(self, input_place: str, title: str):
        self._add(f"il{input_place}", title)
    
    def insert_label(self, input_place: str, label: str):
        self._add(f"iA{input_place}", label)
    
    def insert_text(self, input_place: str, text: str):
        self._add(f"it{input_place}", text.replace('\n', '$[ln];'))
    
    def insert_attribute(self, input_place: str, attribute: str, value: str = "", splitter: str = '\0'):
        splitter_str = splitter if splitter != '\0' else ""
        self._add(f"ia{input_place}", f"{attribute}|{splitter_str}" + (f"|{value}" if value else ""))
    
    # Delete
    def delete_id(self, input_place: str):
        self._add(f"di{input_place}")
    
    def delete_name(self, input_place: str):
        self._add(f"dn{input_place}")
    
    def delete_value(self, input_place: str):
        self._add(f"dv{input_place}")
    
    def delete_class(self, input_place: str, class_name: str):
        self._add(f"dc{input_place}", class_name)
    
    def delete_style(self, input_place: str, style_name: str):
        self._add(f"ds{input_place}", style_name)
    
    def delete_option_tag(self, input_place: str, value: str):
        self._add(f"do{input_place}", value)
    
    def delete_all_option_tag(self, input_place: str):
        self._add(f"do{input_place}", "*")
    
    def delete_checkbox_tag(self, input_place: str, value: str):
        self._add(f"dk{input_place}", value)
    
    def delete_all_checkbox_tag(self, input_place: str):
        self._add(f"dk{input_place}", "*")
    
    def delete_title(self, input_place: str):
        self._add(f"dl{input_place}")
    
    def delete_label(self, input_place: str):
        self._add(f"dA{input_place}")
    
    def delete_text(self, input_place: str):
        self._add(f"dt{input_place}")
    
    def delete_attribute(self, input_place: str, attribute: str):
        self._add(f"da{input_place}", attribute)
    
    def delete(self, input_place: str):
        self._add(f"de{input_place}")
    
    def delete_parent(self, input_place: str):
        self._add(f"dp{input_place}")
    
    # Tag
    def swap_tag(self, input_place: str, output_place: str):
        self._add(f"sp{input_place}", output_place)
    
    def set_reflection(self, input_place: str, tag: str):
        self._add(f"sR{input_place}", tag)
    
    def set_reflection_by_output_place(self, input_place: str, output_place: str):
        self._add(f"iR{input_place}", output_place)
    
    # Browser
    def change_url(self, url: str):
        self._add("cu", url)
    
    def set_head_title(self, title: str):
        self._add("ht", title)
    
    def clipboard_write_text(self, text: str):
        self._add("nw", text)
    
    def scroll_to(self, x: int, y: int):
        self._add("ws", f"{x}|{y}")
    
    def history_go(self, steps: int):
        self._add("wg", str(steps))
    
    def reload_page(self):
        self._add("lr")
    
    def redirect(self, path: str):
        self._add("lh", path)
    
    # Increase
    def increase_min_length(self, input_place: str, value: int):
        self._add(f"+n{input_place}", str(value))
    
    def increase_max_length(self, input_place: str, value: int):
        self._add(f"+x{input_place}", str(value))
    
    def increase_font_size(self, input_place: str, value: int):
        self._add(f"+f{input_place}", str(value))
    
    def increase_width(self, input_place: str, value: int):
        self._add(f"+w{input_place}", str(value))
    
    def increase_height(self, input_place: str, value: int):
        self._add(f"+h{input_place}", str(value))
    
    def increase_value(self, input_place: str, value: int):
        self._add(f"+v{input_place}", str(value))
    
    # Decrease
    def decrease_min_length(self, input_place: str, value: int):
        self._add(f"-n{input_place}", str(value))
    
    def decrease_max_length(self, input_place: str, value: int):
        self._add(f"-x{input_place}", str(value))
    
    def decrease_font_size(self, input_place: str, value: int):
        self._add(f"-f{input_place}", str(value))
    
    def decrease_width(self, input_place: str, value: int):
        self._add(f"-w{input_place}", str(value))
    
    def decrease_height(self, input_place: str, value: int):
        self._add(f"-h{input_place}", str(value))
    
    def decrease_value(self, input_place: str, value: int):
        self._add(f"-v{input_place}", str(value))
    
    # Event
    def trigger_event(self, input_place: str, html_event_listener: str, constructor_name: Optional[str] = None):
        value = html_event_listener
        if constructor_name:
            value += f"|{constructor_name}"
        self._add(f"TE{input_place}", value)
    
    def set_post_event(self, input_place: str, html_event: str):
        self._add(f"Ep{input_place}", html_event)
    
    def set_post_event_view(self, input_place: str, html_event: str):
        self._add(f"Ep{input_place}", f"{html_event}|+")
    
    def set_post_event_to(self, input_place: str, html_event: str, output_place: str):
        self._add(f"Ep{input_place}", f"{html_event}|{output_place}")
    
    def set_post_event_listener(self, input_place: str, html_event_listener: str):
        self._add(f"EP{input_place}", html_event_listener)
    
    def set_post_event_listener_view(self, input_place: str, html_event_listener: str):
        self._add(f"EP{input_place}", f"{html_event_listener}|+")
    
    def set_post_event_listener_to(self, input_place: str, html_event_listener: str, output_place: str):
        self._add(f"EP{input_place}", f"{html_event_listener}|{output_place}")
    
    def set_get_event(self, input_place: str, html_event: str, path: Optional[str] = None, output_place: Optional[str] = None):
        path_str = path if path else "#"
        if output_place:
            self._add(f"Eg{input_place}", f"{html_event}|{path_str}|{output_place}")
        else:
            self._add(f"Eg{input_place}", f"{html_event}|{path_str}")
    
    def set_get_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None, output_place: Optional[str] = None):
        path_str = path if path else "#"
        if output_place:
            self._add(f"EG{input_place}", f"{html_event_listener}|{path_str}|{output_place}")
        else:
            self._add(f"EG{input_place}", f"{html_event_listener}|{path_str}")
    
    def set_patch_event(self, input_place: str, html_event: str, path: Optional[str] = None, output_place: Optional[str] = None):
        path_str = path if path else "#"
        if output_place:
            self._add(f"Ea{input_place}", f"{html_event}|{path_str}|{output_place}")
        else:
            self._add(f"Ea{input_place}", f"{html_event}|{path_str}")
    
    def set_patch_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None, output_place: Optional[str] = None):
        path_str = path if path else "#"
        if output_place:
            self._add(f"EA{input_place}", f"{html_event_listener}|{path_str}|{output_place}")
        else:
            self._add(f"EA{input_place}", f"{html_event_listener}|{path_str}")
    
    def set_delete_event(self, input_place: str, html_event: str, path: Optional[str] = None, output_place: Optional[str] = None):
        path_str = path if path else "#"
        if output_place:
            self._add(f"El{input_place}", f"{html_event}|{path_str}|{output_place}")
        else:
            self._add(f"El{input_place}", f"{html_event}|{path_str}")
    
    def set_delete_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None, output_place: Optional[str] = None):
        path_str = path if path else "#"
        if output_place:
            self._add(f"EL{input_place}", f"{html_event_listener}|{path_str}|{output_place}")
        else:
            self._add(f"EL{input_place}", f"{html_event_listener}|{path_str}")
    
    def set_options_event(self, input_place: str, html_event: str, path: Optional[str] = None, output_place: Optional[str] = None):
        path_str = path if path else "#"
        if output_place:
            self._add(f"Eo{input_place}", f"{html_event}|{path_str}|{output_place}")
        else:
            self._add(f"Eo{input_place}", f"{html_event}|{path_str}")
    
    def set_options_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None, output_place: Optional[str] = None):
        path_str = path if path else "#"
        if output_place:
            self._add(f"EO{input_place}", f"{html_event_listener}|{path_str}|{output_place}")
        else:
            self._add(f"EO{input_place}", f"{html_event_listener}|{path_str}")
    
    def set_trace_event(self, input_place: str, html_event: str, path: Optional[str] = None, output_place: Optional[str] = None):
        path_str = path if path else "#"
        if output_place:
            self._add(f"Er{input_place}", f"{html_event}|{path_str}|{output_place}")
        else:
            self._add(f"Er{input_place}", f"{html_event}|{path_str}")
    
    def set_trace_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None, output_place: Optional[str] = None):
        path_str = path if path else "#"
        if output_place:
            self._add(f"ER{input_place}", f"{html_event_listener}|{path_str}|{output_place}")
        else:
            self._add(f"ER{input_place}", f"{html_event_listener}|{path_str}")
    
    def set_connect_event(self, input_place: str, html_event: str, path: Optional[str] = None, output_place: Optional[str] = None):
        path_str = path if path else "#"
        if output_place:
            self._add(f"Ec{input_place}", f"{html_event}|{path_str}|{output_place}")
        else:
            self._add(f"Ec{input_place}", f"{html_event}|{path_str}")
    
    def set_connect_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None, output_place: Optional[str] = None):
        path_str = path if path else "#"
        if output_place:
            self._add(f"EC{input_place}", f"{html_event_listener}|{path_str}|{output_place}")
        else:
            self._add(f"EC{input_place}", f"{html_event_listener}|{path_str}")
    
    def set_head_event(self, input_place: str, html_event: str, path: Optional[str] = None):
        path_str = path if path else "#"
        self._add(f"Eh{input_place}", f"{html_event}|{path_str}")
    
    def set_head_event_listener(self, input_place: str, html_event_listener: str, path: Optional[str] = None):
        path_str = path if path else "#"
        self._add(f"EH{input_place}", f"{html_event_listener}|{path_str}")
    
    def set_tag_event(self, input_place: str, html_event: str, output_place: str):
        self._add(f"Et{input_place}", f"{html_event}|{output_place}")
    
    def set_tag_event_listener(self, input_place: str, html_event_listener: str, output_place: str):
        self._add(f"ET{input_place}", f"{html_event_listener}|{output_place}")
    
    def set_comment_event(self, input_place: str, html_event: str, index: Optional[Union[str, int]] = None, output_place: Optional[str] = None):
        index_str = str(index) if index is not None else ""
        output_str = output_place if output_place else ""
        self._add(f"Eb{input_place}", f"{html_event}|{index_str}|{output_str}")
    
    def set_comment_event_listener(self, input_place: str, html_event_listener: str, index: Optional[Union[str, int]] = None, output_place: Optional[str] = None):
        index_str = str(index) if index is not None else ""
        output_str = output_place if output_place else ""
        self._add(f"EB{input_place}", f"{html_event_listener}|{index_str}|{output_str}")
    
    def set_wasm_event(self, input_place: str, html_event: str, wasm_language: str, wasm_url: str, 
                       method_name: str, args: Optional[List[str]] = None, output_place: Optional[str] = None):
        args_join = ",".join(args) if args else ""
        output_str = output_place if output_place else ""
        self._add(f"Ey{input_place}", f"{html_event}|{wasm_language}|{wasm_url}|{method_name}|{args_join}|{output_str}")
    
    def set_wasm_event_listener(self, input_place: str, html_event_listener: str, wasm_language: str, wasm_url: str, 
                               method_name: str, args: Optional[List[str]] = None, output_place: Optional[str] = None):
        args_join = ",".join(args) if args else ""
        output_str = output_place if output_place else ""
        self._add(f"EY{input_place}", f"{html_event_listener}|{wasm_language}|{wasm_url}|{method_name}|{args_join}|{output_str}")
    
    def set_websocket_event(self, input_place: str, html_event: str, path: str):
        self._add(f"Ew{input_place}", f"{html_event}|{path}")
    
    def set_websocket_event_listener(self, input_place: str, html_event_listener: str, path: str):
        self._add(f"EW{input_place}", f"{html_event_listener}|{path}")
    
    def set_sse_event(self, input_place: str, html_event: str, path: str, should_reconnect: bool = True, 
                      reconnect_try_timeout: int = 3000, output_place: Optional[str] = None):
        value = f"{html_event}|{path}|{'1' if should_reconnect else '0'}|{reconnect_try_timeout}"
        if output_place:
            value += f"|{output_place}"
        self._add(f"Ee{input_place}", value)
    
    def set_sse_event_listener(self, input_place: str, html_event_listener: str, path: str, should_reconnect: bool = True, 
                              reconnect_try_timeout: int = 3000, output_place: Optional[str] = None):
        value = f"{html_event_listener}|{path}|{'1' if should_reconnect else '0'}|{reconnect_try_timeout}"
        if output_place:
            value += f"|{output_place}"
        self._add(f"EE{input_place}", value)
    
    def set_front_event(self, input_place: str, html_event: str, module_path: str, 
                        args: Optional[List[str]] = None, output_place: Optional[str] = None):
        args_join = "|" + "|".join(args) if args else ""
        output_str = output_place if output_place else ""
        self._add(f"Ej{input_place}", f"{html_event}|{module_path}|{output_str}{args_join}")
    
    def set_front_event_listener(self, input_place: str, html_event_listener: str, module_path: str, 
                                args: Optional[List[str]] = None, output_place: Optional[str] = None):
        args_join = "|" + "|".join(args) if args else ""
        output_str = output_place if output_place else ""
        self._add(f"EJ{input_place}", f"{html_event_listener}|{module_path}|{output_str}{args_join}")
    
    def set_send_event(self, input_place: str, html_event: str, data: str, path: Optional[str] = None, 
                       method: str = "POST", is_multi_part: bool = False, content_type: str = "text/plain", 
                       output_place: Optional[str] = None):
        path_str = path if path else "#"
        data_safe = data.replace('\n', '$[ln];').replace('"', '$[dq];').replace("'", '$[sq];')
        output_str = output_place if output_place else ""
        self._add(f"En{input_place}", f"{html_event}|{data_safe}|{path_str}|{method}|{'1' if is_multi_part else '0'}|{content_type}|{output_str}")
    
    def set_send_event_listener(self, input_place: str, html_event_listener: str, data: str, path: Optional[str] = None, 
                               method: str = "POST", is_multi_part: bool = False, content_type: str = "text/plain", 
                               output_place: Optional[str] = None):
        path_str = path if path else "#"
        data_safe = data.replace('\n', '$[ln];')
        output_str = output_place if output_place else ""
        self._add(f"EN{input_place}", f"{html_event_listener}|{data_safe}|{path_str}|{method}|{'1' if is_multi_part else '0'}|{content_type}|{output_str}")
    
    def set_master_pages_event(self, input_place: str, html_event: str, output_place: Optional[str] = None):
        value = html_event
        if output_place:
            value += f"|{output_place}"
        self._add(f"Eu{input_place}", value)
    
    def set_master_pages_event_listener(self, input_place: str, html_event_listener: str, output_place: Optional[str] = None):
        value = html_event_listener
        if output_place:
            value += f"|{output_place}"
        self._add(f"EU{input_place}", value)
    
    def set_prevent_default_event(self, input_place: str, html_event: str):
        self._add(f"Ed{input_place}", html_event)
    
    def set_prevent_default_event_listener(self, input_place: str, html_event_listener: str):
        self._add(f"ED{input_place}", html_event_listener)
    
    def set_stop_propagation_event(self, input_place: str, html_event: str):
        self._add(f"Es{input_place}", html_event)
    
    def set_stop_propagation_event_listener(self, input_place: str, html_event_listener: str):
        self._add(f"ES{input_place}", html_event_listener)
    
    def set_method_event(self, input_place: str, html_event: str, method_name: str, args: Optional[List[str]] = None):
        args_join = "|" + "|".join(args) if args else ""
        self._add(f"Em{input_place}", f"{html_event}|{method_name}{args_join}")
    
    def set_method_event_listener(self, input_place: str, html_event_listener: str, method_name: str, args: Optional[List[str]] = None):
        args_join = "|" + "|".join(args) if args else ""
        self._add(f"EM{input_place}", f"{html_event_listener}|{method_name}{args_join}")
    
    def set_module_method_event(self, input_place: str, html_event: str, method_name: str, args: Optional[List[str]] = None):
        args_join = "|" + "|".join(args) if args else ""
        self._add(f"Ex{input_place}", f"{html_event}|{method_name}{args_join}")
    
    def set_module_method_event_listener(self, input_place: str, html_event_listener: str, method_name: str, args: Optional[List[str]] = None):
        args_join = "|" + "|".join(args) if args else ""
        self._add(f"EX{input_place}", f"{html_event_listener}|{method_name}{args_join}")
    
    def assign_confirm_event(self, input_place: str, html_event: str, text: str = "Are you sure you want to proceed?", 
                            type_: str = "none", title: str = "Confirm", ok_text: str = "OK", cancel_text: str = "Cancel"):
        text_str = "" if text == "Are you sure you want to proceed?" else text
        type_str = "" if type_ == "none" else type_
        title_str = "" if title == "Confirm" else title
        ok_str = "" if ok_text == "OK" else ok_text
        cancel_str = "" if cancel_text == "Cancel" else cancel_text
        self._add(f"Ef{input_place}", f"{html_event}|{text_str}|{type_str}|{title_str}|{ok_str}|{cancel_str}")
    
    def remove_post_event(self, input_place: str, html_event: str):
        self._add(f"Rp{input_place}", html_event)
    
    def remove_post_event_listener(self, input_place: str, html_event_listener: str):
        self._add(f"RP{input_place}", html_event_listener)
    
    # Note: Many more remove methods would be added here following the same pattern
    # For brevity, I'm showing a few examples
    
    def remove_get_event(self, input_place: str, html_event: str):
        self._add(f"Rg{input_place}", html_event)
    
    def remove_get_event_listener(self, input_place: str, html_event_listener: str):
        self._add(f"RG{input_place}", html_event_listener)
    
    # Custom Event
    def create_custom_dom_event(self, input_place: str, event_name: str, watch: str, key: str, 
                               compare: str, value: str, range_: str, immediate: bool = False, delay: int = 0):
        self._add(f"eC{input_place}", f"{event_name}|{watch}|{key}|{compare}|{value}|{range_}|{'1' if immediate else '0'}|{delay}")
    
    def enable_scroll_bottom_event(self, enable: bool = True):
        self._add("eb", "1" if enable else "0")
    
    def enable_reached_element_event(self, input_place: str, once: bool, enable: bool = True):
        self._add(f"er{input_place}", f"{'1' if once else '0'}|{'1' if enable else '0'}")
    
    # Module
    def load_module(self, module_path: str, methods: List[str]):
        methods_str = "|" + "|".join(methods) if methods else ""
        self._add("Ml", f"{module_path}{methods_str}")
    
    def unload_module(self, module_path: str):
        self._add("Mu", module_path)
    
    def delete_module_method(self, method_name: str):
        self._add("Md", method_name)
    
    # Unit Testing
    def assert_equal(self, input_place: str, tag: str):
        self._add(f"At{input_place}", tag.replace('\n', '$[ln];'))
    
    def assert_equal_by_output_place(self, input_place: str, output_place: str):
        self._add(f"Ao{input_place}", output_place)
    
    # Service Worker
    def service_worker_register(self, path: Optional[str] = None, scope_path: Optional[str] = None):
        self._add("wR", f"{path if path else ''}|{scope_path if scope_path else ''}")
    
    def service_worker_pre_cache_static(self, path_list: List[str]):
        self._add("wp", "|".join(path_list))
    
    def service_worker_dynamic_cache(self, path: str, seconds: int = 0):
        value = path
        if seconds > 0:
            value += f"|{seconds}"
        self._add("wc", value)
    
    def service_worker_delete_dynamic_cache(self, path: Optional[str] = None):
        if path:
            self._add("wd", path)
        else:
            self._add("wd")
    
    def service_worker_dynamic_cache_ttl_update(self, path: str, seconds: int = 0):
        value = path
        if seconds > 0:
            value += f"|{seconds}"
        self._add("wt", value)
    
    def service_worker_route_set(self, path: str, type_: str, cache_dynamic: bool = False):
        self._add("wr", f"{path}|{type_}" + ("|1" if cache_dynamic else ""))
    
    def service_worker_route_alias(self, path: str, to: str):
        self._add("wa", f"{path}|{to}")
    
    def service_worker_delete_route_alias(self, path: Optional[str] = None):
        self._add("wC", path if path else "")
    
    def service_worker_delete_route(self, path: Optional[str] = None):
        if path:
            self._add("wD", path)
        else:
            self._add("wD")
    
    # SSE
    def disconnect_sse(self, path: Optional[str] = None):
        if path:
            self._add("Ds", path)
        else:
            self._add("Ds")
    
    # State
    def add_state(self, path: Optional[str] = None, title: Optional[str] = None):
        self._add("AS", f"{path if path else ''}|{title if title else ''}")
    
    def delete_state(self, path: Optional[str] = None):
        if path:
            self._add("DS", path)
        else:
            self._add("DS", "*")
    
    def delete_all_state(self):
        self._add("DS", "*")
    
    # Cookie
    def set_cookie(self, key: str, value: str, seconds: int, path: Optional[str] = None):
        value_str = f"{key}|{value}|{seconds}"
        if path:
            value_str += f"|{path}"
        self._add("sC", value_str)
    
    # Save/Session Cache
    def save_id(self, input_place: str, key: str = "."):
        self._add(f"@gi{input_place}", key)
    
    def save_name(self, input_place: str, key: str = "."):
        self._add(f"@gn{input_place}", key)
    
    def save_value(self, input_place: str, key: str = "."):
        self._add(f"@gv{input_place}", key)
    
    def save_value_length(self, input_place: str, key: str = "."):
        self._add(f"@ge{input_place}", key)
    
    def save_class(self, input_place: str, key: str = "."):
        self._add(f"@gc{input_place}", key)
    
    def save_style(self, input_place: str, key: str = "."):
        self._add(f"@gs{input_place}", key)
    
    def save_title(self, input_place: str, key: str = "."):
        self._add(f"@gl{input_place}", key)
    
    def save_label(self, input_place: str, key: str = "."):
        self._add(f"@gA{input_place}", key)
    
    def save_text(self, input_place: str, key: str = "."):
        self._add(f"@gt{input_place}", key)
    
    def save_outer_text(self, input_place: str, key: str = "."):
        self._add(f"@go{input_place}", key)
    
    def save_text_length(self, input_place: str, key: str = "."):
        self._add(f"@gg{input_place}", key)
    
    def save_attribute(self, input_place: str, attribute: str, key: str = "."):
        self._add(f"@ga{input_place}", f"{key}|{attribute}")
    
    def save_width(self, input_place: str, key: str = "."):
        self._add(f"@gw{input_place}", key)
    
    def save_height(self, input_place: str, key: str = "."):
        self._add(f"@gh{input_place}", key)
    
    def save_read_only(self, input_place: str, key: str = "."):
        self._add(f"@gr{input_place}", key)
    
    def save_selected_index(self, input_place: str, key: str = "."):
        self._add(f"@gx{input_place}", key)
    
    def save_text_align(self, input_place: str, key: str = "."):
        self._add(f"@gT{input_place}", key)
    
    def save_node_length(self, input_place: str, key: str = "."):
        self._add(f"@gL{input_place}", key)
    
    def save_visible(self, input_place: str, key: str = "."):
        self._add(f"@gV{input_place}", key)
    
    def save_url(self, url: str, fetch_script: bool = False, key: str = "."):
        self._add(f"@gu", f"{key}|{url}" + ("|1" if fetch_script else ""))
    
    def save_index(self, input_place: str, key: str = "."):
        self._add(f"@gI{input_place}", key)
    
    def remove_session_cache(self, cache_key: str):
        self._add("rs", cache_key)
    
    def remove_all_session_cache(self):
        self._add("rs", "*")
    
    def set_session_cache(self):
        self._add("cs", "*")
    
    def add_session_cache_value(self, cache_key: str, value: str):
        self._add("SA", f"{cache_key}|{value.replace(chr(10), '$[ln];')}")
    
    def insert_session_cache_value(self, cache_key: str, value: str):
        self._add("SI", f"{cache_key}|{value.replace(chr(10), '$[ln];')}")
    
    # Cache
    def cache_id(self, input_place: str, key: str = "."):
        self._add(f"@ci{input_place}", key)
    
    def cache_name(self, input_place: str, key: str = "."):
        self._add(f"@cn{input_place}", key)
    
    def cache_value(self, input_place: str, key: str = "."):
        self._add(f"@cv{input_place}", key)
    
    def cache_value_length(self, input_place: str, key: str = "."):
        self._add(f"@ce{input_place}", key)
    
    def cache_class(self, input_place: str, key: str = "."):
        self._add(f"@cc{input_place}", key)
    
    def cache_style(self, input_place: str, key: str = "."):
        self._add(f"@cs{input_place}", key)
    
    def cache_title(self, input_place: str, key: str = "."):
        self._add(f"@cl{input_place}", key)
    
    def cache_label(self, input_place: str, key: str = "."):
        self._add(f"@cA{input_place}", key)
    
    def cache_text(self, input_place: str, key: str = "."):
        self._add(f"@ct{input_place}", key)
    
    def cache_outer_text(self, input_place: str, key: str = "."):
        self._add(f"@co{input_place}", key)
    
    def cache_text_length(self, input_place: str, key: str = "."):
        self._add(f"@cg{input_place}", key)
    
    def cache_attribute(self, input_place: str, attribute: str, key: str = "."):
        self._add(f"@ca{input_place}", f"{key}|{attribute}")
    
    def cache_width(self, input_place: str, key: str = "."):
        self._add(f"@cw{input_place}", key)
    
    def cache_height(self, input_place: str, key: str = "."):
        self._add(f"@ch{input_place}", key)
    
    def cache_read_only(self, input_place: str, key: str = "."):
        self._add(f"@cr{input_place}", key)
    
    def cache_selected_index(self, input_place: str, key: str = "."):
        self._add(f"@cx{input_place}", key)
    
    def cache_text_align(self, input_place: str, key: str = "."):
        self._add(f"@cT{input_place}", key)
    
    def cache_node_length(self, input_place: str, key: str = "."):
        self._add(f"@cL{input_place}", key)
    
    def cache_visible(self, input_place: str, key: str = "."):
        self._add(f"@cV{input_place}", key)
    
    def cache_url(self, url: str, fetch_script: bool = False, key: str = "."):
        self._add(f"@cu", f"{key}|{url}" + ("|1" if fetch_script else ""))
    
    def cache_index(self, input_place: str, key: str = "."):
        self._add(f"@cI{input_place}", key)
    
    def remove_cache(self, cache_key: str):
        self._add("rd", cache_key)
    
    def remove_all_cache(self):
        self._add("rd", "*")
    
    def set_cache(self, seconds: Optional[int] = None):
        if seconds is not None:
            self._add("cd", str(seconds))
        else:
            self._add("cd", "*")
    
    def add_cache_value(self, cache_key: str, value: str):
        self._add("CA", f"{cache_key}|{value.replace(chr(10), '$[ln];')}")
    
    def insert_cache_value(self, cache_key: str, value: str):
        self._add("CI", f"{cache_key}|{value.replace(chr(10), '$[ln];')}")
    
    # Call
    def load_url(self, input_place: str, url: str):
        self._add(f"lu{input_place}", url)
    
    def run_action_controls(self, action_controls: str, index: Optional[Union[str, int]] = None, 
                           without_webforms_section: bool = False, use_current_event: bool = True):
        index_str = str(index) if index is not None else ""
        self._add("lA", f"{'1' if use_current_event else '0'}|{'1' if without_webforms_section else '0'}|{index_str}|{action_controls}")
    
    def call_script(self, script_text: str):
        self._add("_", script_text.replace(chr(10), '$[ln];'))
    
    def call_method(self, method_name: str, args: Optional[List[str]] = None):
        args_str = "|" + "|".join(args) if args else ""
        self._add("lm", f"{method_name}{args_str}")
    
    def call_module_method(self, method_name: str, args: Optional[List[str]] = None):
        args_str = "|" + "|".join(args) if args else ""
        self._add("lM", f"{method_name}{args_str}")
    
    def call_post_back(self, form_input_place: str, output_place: Optional[str] = None):
        value = f"1|{form_input_place}"
        if output_place:
            value += f"|{output_place}"
        self._add("Lp", value)
    
    def call_tag_back(self, output_place: Optional[str] = None, use_current_event: bool = True):
        value = "1" if use_current_event else "0"
        if output_place:
            value += f"|{output_place}"
        self._add("Lt", value)
    
    def call_comment_back(self, index: Optional[Union[str, int]] = None, output_place: Optional[str] = None, 
                         use_current_event: bool = True):
        index_str = str(index) if index is not None else ""
        output_str = output_place if output_place else ""
        self._add("LC", f"{'1' if use_current_event else '0'}|{index_str}|{output_str}")
    
    def call_wasm_back(self, wasm_language: str, wasm_url: str, method_name: str, 
                      args: Optional[List[str]] = None, output_place: Optional[str] = None, 
                      use_current_event: bool = True):
        args_join = ",".join(args) if args else ""
        output_str = output_place if output_place else ""
        self._add("Ly", f"{'1' if use_current_event else '0'}|{wasm_language}|{wasm_url}|{method_name}|{args_join}|{output_str}")
    
    def call_websocket_back(self, path: str, use_current_event: bool = True):
        self._add("Lw", f"{'1' if use_current_event else '0'}|{path}")
    
    def call_sse_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True, 
                     should_reconnect: bool = True, reconnect_try_timeout: int = 3000):
        value = f"{'1' if use_current_event else '0'}|{path}|{'1' if should_reconnect else '0'}|{reconnect_try_timeout}"
        if output_place:
            value += f"|{output_place}"
        self._add("Ls", value)
    
    def call_front(self, module_path: str, args: Optional[List[str]] = None, output_place: Optional[str] = None, 
                  use_current_event: bool = True):
        args_str = "|" + "|".join(args) if args else ""
        output_str = output_place if output_place else ""
        self._add("Lj", f"{'1' if use_current_event else '0'}|{module_path}|{output_str}{args_str}")
    
    def call_get_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True):
        value = f"{'1' if use_current_event else '0'}|{path}"
        if output_place:
            value += f"|{output_place}"
        self._add("Lg", value)
    
    def call_put_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True):
        value = f"{'1' if use_current_event else '0'}|{path}"
        if output_place:
            value += f"|{output_place}"
        self._add("Lu", value)
    
    def call_patch_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True):
        value = f"{'1' if use_current_event else '0'}|{path}"
        if output_place:
            value += f"|{output_place}"
        self._add("LP", value)
    
    def call_delete_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True):
        value = f"{'1' if use_current_event else '0'}|{path}"
        if output_place:
            value += f"|{output_place}"
        self._add("Ld", value)
    
    def call_head_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True):
        value = f"{'1' if use_current_event else '0'}|{path}"
        if output_place:
            value += f"|{output_place}"
        self._add("Lh", value)
    
    def call_options_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True):
        value = f"{'1' if use_current_event else '0'}|{path}"
        if output_place:
            value += f"|{output_place}"
        self._add("Lo", value)
    
    def call_trace_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True):
        value = f"{'1' if use_current_event else '0'}|{path}"
        if output_place:
            value += f"|{output_place}"
        self._add("LT", value)
    
    def call_connect_back(self, path: str, output_place: Optional[str] = None, use_current_event: bool = True):
        value = f"{'1' if use_current_event else '0'}|{path}"
        if output_place:
            value += f"|{output_place}"
        self._add("Lc", value)
    
    def call_send_back(self, path: str, method: str, is_multi_part: bool, content_type: str, data: str, 
                      output_place: Optional[str] = None, use_current_event: bool = True):
        data_safe = data.replace(chr(10), '$[ln];').replace('|', '$[vb];')
        value = f"{'1' if use_current_event else '0'}|{path}|{method}|{'1' if is_multi_part else '0'}|{content_type}|{data_safe}"
        if output_place:
            value += f"|{output_place}"
        self._add("LS", value)
    
    # Update
    def increase(self, input_place: str, value: float):
        self._add(f"gt{input_place}", f"i|{value}")
    
    def decrease(self, input_place: str, value: float):
        self._add(f"gt{input_place}", f"i|{-value}")
    
    def replace(self, input_place: str, value: str, new_value: str, also_start_tag: bool = False, deep: bool = False):
        if value and value.startswith('@'):
            value = "$[at];" + value[1:]
        
        if new_value and new_value.startswith('@'):
            new_value = "$[at];" + new_value[1:]
        
        self._add(f"gt{input_place}", f"r|{value}|{new_value}|{'1' if also_start_tag else '0'}|{'1' if deep else '0'}")
    
    def replace_start_tag(self, input_place: str, value: str, new_value: str):
        if value and value.startswith('@'):
            value = "$[at];" + value[1:]
        
        if new_value and new_value.startswith('@'):
            new_value = "$[at];" + new_value[1:]
        
        self._add(f"gt{input_place}", f"s|{value}|{new_value}")
    
    # Pre Runner
    def assign_delay(self, milliseconds: int, index: int = -1):
        line = self._get_line_by_index(index)
        if not line:
            return
        
        parts = line.split('=', 1)
        if len(parts) == 2:
            name, value = parts
            new_name = f":{milliseconds}){name}"
            self._update_line_by_index(index, new_name, value)
        else:
            name = parts[0]
            new_name = f":{milliseconds}){name}"
            self._update_line_by_index(index, new_name)
    
    def assign_delay_change(self, milliseconds: int, index: int = -1):
        line = self._get_line_by_index(index)
        if not line:
            return
        
        parts = line.split('=', 1)
        if len(parts) == 2:
            name, value = parts
        else:
            name = parts[0]
            value = ""
        
        if name.startswith(':') and ')' in name:
            closing_bracket = name.find(')')
            name = name[closing_bracket + 1:]
        
        new_name = f":{milliseconds}){name}"
        self._update_line_by_index(index, new_name, value)
    
    def assign_interval(self, milliseconds: int, interval_id: Optional[str] = None, index: int = -1):
        line = self._get_line_by_index(index)
        if not line:
            return
        
        parts = line.split('=', 1)
        if len(parts) == 2:
            name, value = parts
            new_name = f"({milliseconds}" + (f"|{interval_id}" if interval_id else "") + f"){name}"
            self._update_line_by_index(index, new_name, value)
        else:
            name = parts[0]
            new_name = f"({milliseconds}" + (f"|{interval_id}" if interval_id else "") + f"){name}"
            self._update_line_by_index(index, new_name)
    
    def assign_interval_change(self, milliseconds: int, interval_id: Optional[str] = None, index: int = -1):
        line = self._get_line_by_index(index)
        if not line:
            return
        
        parts = line.split('=', 1)
        if len(parts) == 2:
            name, value = parts
        else:
            name = parts[0]
            value = ""
        
        if name.startswith('(') and ')' in name:
            closing_bracket = name.find(')')
            name = name[closing_bracket + 1:]
        
        new_name = f"({milliseconds}" + (f"|{interval_id}" if interval_id else "") + f"){name}"
        self._update_line_by_index(index, new_name, value)
    
    def delete_interval(self, interval_id: str):
        self._add("Di", interval_id)
    
    def assign_repeat(self, count: int, index: int = -1):
        line = self._get_line_by_index(index)
        if not line:
            return
        
        parts = line.split('=', 1)
        if len(parts) == 2:
            name, value = parts
            new_name = f",{count}){name}"
            self._update_line_by_index(index, new_name, value)
        else:
            name = parts[0]
            new_name = f",{count}){name}"
            self._update_line_by_index(index, new_name)
    
    def assign_repeat_change(self, count: int, index: int = -1):
        line = self._get_line_by_index(index)
        if not line:
            return
        
        parts = line.split('=', 1)
        if len(parts) == 2:
            name, value = parts
        else:
            name = parts[0]
            value = ""
        
        if name.startswith(',') and ')' in name:
            closing_bracket = name.find(')')
            name = name[closing_bracket + 1:]
        
        new_name = f",{count}){name}"
        self._update_line_by_index(index, new_name, value)
    
    # Index
    def start_index(self, name: str = ""):
        self._add("#", name)
    
    def go_to(self, line: Union[int, str], repeat: int = 1):
        if isinstance(line, int):
            self._add("&", f"{line}|{repeat}")
        else:
            self._add("&", f"#{line}|{repeat}")
    
    # Start
    def start_transient_dom(self, input_place: str):
        self._add("td", input_place)
    
    def end_transient_dom(self):
        self._add("td", ";")
    
    # Message
    def alert(self, text: str, type_: str = "none", title: str = "Alert", ok_text: str = "OK"):
        type_str = "" if type_ == "none" else type_
        title_str = "" if title == "Alert" else title
        ok_str = "" if ok_text == "OK" else ok_text
        self._add("Al", f"{text}|{type_str}|{title_str}|{ok_str}")
    
    def message(self, text: str, type_: str = "none", duration: int = 0):
        type_str = "" if type_ == "none" else type_
        duration_str = "" if duration == 0 else str(duration)
        self._add("me", f"{text}|{type_str}|{duration_str}")
    
    def console_message(self, text: str, type_: str = "log"):
        type_str = "" if type_ == "log" else type_
        self._add("mc", f"{text.replace(chr(10), '$[ln];')}" + (f"|{type_str}" if type_str else ""))
    
    def console_message_assert(self, text: str, condition: str):
        self._add("ma", f"{text.replace(chr(10), '$[ln];')}|{condition}")
    
    # Enable
    def enable_websocket(self, enable: bool = True):
        self._add("ew", "1" if enable else "0")
    
    def enable_websocket_once(self):
        self._add("ew", "$")
    
    def add_websocket(self, path: str):
        self._add(f"aw{path}")
    
    # Use
    def use_websocket(self, input_place: str):
        self._add(f"uw{input_place}")
    
    def use_only_change_update(self, input_place: str):
        self._add(f"uo{input_place}")
    
    # Condition
    def confirm_is_true_accept(self, text: str = "Are you sure you want to proceed?", type_: str = "none", 
                              title: str = "Confirm", ok_text: str = "OK", cancel_text: str = "Cancel", 
                              interval: float = 100):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        text_str = "" if text == "Are you sure you want to proceed?" else text
        type_str = "" if type_ == "none" else type_
        title_str = "" if title == "Confirm" else title
        ok_str = "" if ok_text == "OK" else ok_text
        cancel_str = "" if cancel_text == "Cancel" else cancel_text
        self._add(f"{prefix}ct", f"{text_str}|{type_str}|{title_str}|{ok_str}|{cancel_str}")
    
    def confirm_is_false_accept(self, text: str = "Are you sure you want to proceed?", type_: str = "none", 
                               title: str = "Confirm", ok_text: str = "OK", cancel_text: str = "Cancel", 
                               interval: float = 100):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        text_str = "" if text == "Are you sure you want to proceed?" else text
        type_str = "" if type_ == "none" else type_
        title_str = "" if title == "Confirm" else title
        ok_str = "" if ok_text == "OK" else ok_text
        cancel_str = "" if cancel_text == "Cancel" else cancel_text
        self._add(f"{prefix}cf", f"{text_str}|{type_str}|{title_str}|{ok_str}|{cancel_str}")
    
    def is_greater_than(self, first_value: str, second_value: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}gt", f"{first_value}|{second_value}")
    
    def is_less_than(self, first_value: str, second_value: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}lt", f"{first_value}|{second_value}")
    
    def is_equal_to(self, first_value: str, second_value: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}et", f"{first_value}|{second_value}")
    
    def is_not_equal_to(self, first_value: str, second_value: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}Nt", f"{first_value}|{second_value}")
    
    def exist(self, value: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}ex", value)
    
    def not_exist(self, value: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}nx", value)
    
    def is_true(self, value: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}tr", value)
    
    def is_false(self, value: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}fa", value)
    
    def is_match_media(self, value: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}mm", value)
    
    def is_not_match_media(self, value: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}nm", value)
    
    def include(self, text: str, value: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}In", f"{value}|{text}")
    
    def not_include(self, text: str, value: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}Nn", f"{value}|{text}")
    
    def element_exists(self, input_place: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}eE", input_place)
    
    def element_not_exists(self, input_place: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}nE", input_place)
    
    def is_regex_match(self, value: str, pattern: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}re", f"{value}|{pattern}")
    
    def is_regex_not_match(self, value: str, pattern: str, interval: int = -1):
        prefix = f"{{({interval})" if interval >= 0 else "{"
        self._add(f"{prefix}rn", f"{value}|{pattern}")
    
    def break_condition(self):
        self._add(";")
    
    def start_bracket(self):
        self._add("{")
    
    def end_bracket(self):
        self._add("}")
    
    # Async
    def async_start(self):
        self._add("{(a)")
    
    def delay(self, milliseconds: int):
        self._add("De", str(milliseconds))
    
    # Format Storage
    def create_format_storage(self, key: str, data: str):
        self._add(".C", f"{key}|{data}")
    
    def delete_format_storage(self, key: str):
        self._add(".D", key)
    
    def add_json(self, key: str, path: str, value: str):
        self._add(".a", f"{key}|j|{value}|{path}")
    
    def add_xml(self, key: str, path: str, name: str, value: Optional[str] = None):
        if name and name.startswith('@'):
            name = "$[at];" + name[1:]
        name_safe = name.replace("@", "$[at];")
        self._add(".a", f"{key}|x|{name_safe}|{value if value else ''}|{path}")
    
    def add_ini(self, key: str, path: str, value: str, is_ini_like: bool = False):
        self._add(".a", f"{key}|i|{'1' if is_ini_like else '0'}|{value}|{path}")
    
    def add_text_line(self, key: str, line: int, text: str):
        self._add(".a", f"{key}|t|{text}|{line}")
    
    def add_variable(self, key: str, value: str):
        self._add(".a", f"{key}|v|{value}")
    
    def update_json(self, key: str, path: str, value: str):
        self._add(".u", f"{key}|j|{value}|{path}")
    
    def update_xml(self, key: str, path: str, value: str):
        self._add(".u", f"{key}|x|{value}|{path}")
    
    def update_ini(self, key: str, path: str, value: str, is_ini_like: bool = False):
        self._add(".u", f"{key}|i|{'1' if is_ini_like else '0'}|{value}|{path}")
    
    def update_text_line(self, key: str, line: int, text: str):
        self._add(".u", f"{key}|t|{text}|{line}")
    
    def update_variable(self, key: str, value: str):
        self._add(".u", f"{key}|v|{value}")
    
    def increase_variable(self, key: str, value: int):
        self._add(".i", f"{key}|v|{value}")
    
    def decrease_variable(self, key: str, value: int):
        self.increase_variable(key, -value)
    
    def delete_json(self, key: str, path: str):
        self._add(".d", f"{key}|j|{path}")
    
    def delete_xml(self, key: str, path: str):
        self._add(".d", f"{key}|x|{path}")
    
    def delete_ini(self, key: str, path: str, is_ini_like: bool = False):
        self._add(".d", f"{key}|i|{is_ini_like}|{path}")
    
    def delete_text_line(self, key: str, line: int):
        self._add(".d", f"{key}|t|{line}")
    
    def delete_variable(self, key: str):
        self._add(".d", f"{key}|v")
    
    # Inject
    @staticmethod
    def inject(value: str) -> str:
        return f"$[{value}];"
    
    # Hash and Checksum
    def set_hash(self):
        self._add("SH")
    
    def set_checksum(self):
        self._add("CS")
    
    @staticmethod
    def checksum_calculation(text: str) -> str:
        sum_val = 0
        mod = 65536
        shift = 5
        
        for c in text:
            sum_val = ((sum_val << shift) | (sum_val >> (16 - shift))) ^ ord(c)
            sum_val %= mod
        
        return str(sum_val)
    
    def get_checksum(self) -> str:
        return self.checksum_calculation(self.get_webforms_data())
    
    # Get
    def get_forms_action_data(self) -> str:
        return "\n".join(self.web_forms_data)
    
    def response(self) -> str:
        return "[web-forms]\n" + self.get_forms_action_data()
    
    def get_forms_action_data_line_break(self) -> str:
        data = self.get_forms_action_data()
        processed_data = data.replace('"', '$[dq];')
        return processed_data.replace('\n', '$[sln];')
    
    # Export
    def export_to_webforms_tag(self, src: Optional[str] = None) -> str:
        src_str = f' src="{src}"' if src else ""
        return f'<web-forms ac="{self.get_forms_action_data_line_break()}"{src_str}></web-forms>'
    
    def export_to_line_break(self, src: Optional[str] = None) -> str:
        src_str = f' src="{src}"' if src else ""
        return f'[web-forms]$[sln];{self.get_forms_action_data_line_break()}'
    
    def export_to_webforms_tag_with_size(self, width: Union[str, int], height: Union[str, int], src: Optional[str] = None) -> str:
        if isinstance(width, int):
            width = f"{width}px"
        if isinstance(height, int):
            height = f"{height}px"
        
        src_str = f' src="{src}"' if src else ""
        return f'<web-forms ac="{self.get_forms_action_data_line_break()}" width="{width}" height="{height}"{src_str}></web-forms>'
    
    def done_to_webforms_tag(self, element_id: Optional[str] = None) -> str:
        id_str = f' id="{element_id}" done="true"' if element_id else ""
        return f'<web-forms ac="{self.get_forms_action_data_line_break()}"{id_str}></web-forms>'
    
    def export_to_html_comment(self, add_line: bool = False) -> str:
        prefix = "\n" if add_line else ""
        return f"{prefix}<!--{self.response()}-->"
    
    def get_webforms_data(self) -> str:
        return "\n".join(self.web_forms_data)
    
    def append_form(self, form: 'WebForms'):
        if form:
            other_data = form.get_webforms_data()
            if other_data:
                if self.web_forms_data:
                    self.web_forms_data.extend(other_data.split('\n'))
                else:
                    self.web_forms_data = other_data.split('\n')
    
    def clean(self):
        self.web_forms_data = []


class Security:
    @staticmethod
    def safe_value(value: str) -> str:
        if not value:
            return value
            
        if value.startswith('@'):
            value = "$[at];" + value[1:]
        
        value = value.replace('\n', '$[ln];')
        value = value.replace('|', '$[vb];')
        value = value.replace(',@', '$[co];@')
        
        return value


class InputPlace:
    WINDOW = '`'
    ROOT = '~'
    CURRENT = '$'
    TARGET = '!'
    UPPER = '-'
    HEAD = '^'
    SCREEN_ORIENTATION = '%'

    @staticmethod
    def id(element_id: str) -> str:
        return element_id

    @staticmethod
    def name(name: str, index: Optional[int] = None) -> str:
        return f'({name}){index}' if index is not None else f'({name})'

    @staticmethod
    def all_names(name: str) -> str:
        return f'({name})*'

    @staticmethod
    def tag(tag_name: str, index: Optional[int] = None) -> str:
        return f'<{tag_name}>{index}' if index is not None else f'<{tag_name}>'

    @staticmethod
    def all_tags(tag_name: str) -> str:
        return f'<{tag_name}>*'

    @staticmethod
    def css_class(class_name: str, index: Optional[int] = None) -> str:
        return f'{{{class_name}}}{index}' if index is not None else f'{{{class_name}}}'

    @staticmethod
    def all_css_classes(class_name: str) -> str:
        return f'{{{class_name}}}*'

    @staticmethod
    def query(query_str: str) -> str:
        return "*" + query_str.replace("=", "$[eq];")

    @staticmethod
    def query_all(query_str: str) -> str:
        return "[" + query_str.replace("=", "$[eq];")


class OutputPlace(InputPlace):
    pass


class Fetch:
    # Method
    @staticmethod
    def random(max_value: int, min_value: Optional[int] = None) -> str:
        if min_value is not None:
            return f"@mr{max_value},{min_value}"
        return f"@mr{max_value}"
    
    @staticmethod
    def space_to_char(text: str, char: str = "-") -> str:
        return f"@sc{char},{text}"
    
    @staticmethod
    def encode_uri(text: str) -> str:
        return f"@ue{text}"
    
    @staticmethod
    def decode_uri(text: str) -> str:
        return f"@ud{text}"
    
    @staticmethod
    def method(method_name: str, args: Optional[List[str]] = None) -> str:
        result = f"@cm{method_name}"
        if args:
            result += "," + ",".join(args)
        return result
    
    @staticmethod
    def module_method(method_name: str, args: Optional[List[str]] = None) -> str:
        result = f"@cM{method_name}"
        if args:
            result += "," + ",".join(args)
        return result
    
    @staticmethod
    def wasm_method(wasm_language: str, wasm_url: str, method_name: str, 
                    args: Optional[List[str]] = None, key: str = ".") -> str:
        result = f"@wA{wasm_language},{wasm_url},{method_name}"
        if args:
            result += "," + ",".join(args)
        return result
    
    @staticmethod
    def script(script_text: str) -> str:
        return f"@_{script_text.replace(chr(10), '$[ln];')}"
    
    @staticmethod
    def load_url(url: str, fetch_script: bool = False) -> str:
        return f"@lu{url}" + (",1" if fetch_script else "")
    
    @staticmethod
    def load_html(url: str, fetch_input_place: str = "", fetch_script: bool = False) -> str:
        result = f"@lh{url}," + ("1" if fetch_script else "0")
        if fetch_input_place:
            result += f",{fetch_input_place}"
        return result
    
    @staticmethod
    def load_line(url: str, line: int) -> str:
        return f"@ll{url},{line}"
    
    @staticmethod
    def load_ini(url: str, name: str, is_ini_like: bool = False) -> str:
        return f"@li{url},{name}" + (",1" if is_ini_like else "")
    
    @staticmethod
    def load_json(url: str, name: str) -> str:
        return f"@lj{url},{name}"
    
    @staticmethod
    def load_xml(url: str, name: str) -> str:
        return f"@lx{url},{name}"
    
    @staticmethod
    def has_method(method_name: str) -> str:
        return f"@hm{method_name}"
    
    @staticmethod
    def has_module_method(method_name: str) -> str:
        return f"@hM{method_name}"
    
    @staticmethod
    def get_modifier_state(modifier: str) -> str:
        return f"@ms{modifier}"
    
    # Math
    @staticmethod
    def math(method_name: str, args: Optional[List[str]] = None) -> str:
        result = f"@M#{method_name}"
        if args:
            result += "," + ",".join(args)
        return result
    
    # Data
    DATE_YEAR = "@dy"
    DATE_MONTH = "@dm"
    DATE_DAY = "@dd"
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
        return f"@$i{input_place}"
    
    @staticmethod
    def get_name(input_place: str) -> str:
        return f"@$n{input_place}"
    
    @staticmethod
    def get_value(input_place: str) -> str:
        return f"@$v{input_place}"
    
    @staticmethod
    def get_value_length(input_place: str) -> str:
        return f"@$e{input_place}"
    
    @staticmethod
    def get_class(input_place: str) -> str:
        return f"@$c{input_place}"
    
    @staticmethod
    def get_style(input_place: str) -> str:
        return f"@$s{input_place}"
    
    @staticmethod
    def get_title(input_place: str) -> str:
        return f"@$l{input_place}"
    
    @staticmethod
    def get_label(input_place: str) -> str:
        return f"@$A{input_place}"
    
    @staticmethod
    def get_text(input_place: str) -> str:
        return f"@$t{input_place}"
    
    @staticmethod
    def get_outer_text(input_place: str) -> str:
        return f"@$o{input_place}"
    
    @staticmethod
    def get_text_length(input_place: str) -> str:
        return f"@$g{input_place}"
    
    @staticmethod
    def get_attribute(input_place: str, attribute: str) -> str:
        return f"@$a{input_place},{attribute}"
    
    @staticmethod
    def get_width(input_place: str) -> str:
        return f"@$w{input_place}"
    
    @staticmethod
    def get_height(input_place: str) -> str:
        return f"@$h{input_place}"
    
    @staticmethod
    def get_is_read_only(input_place: str) -> str:
        return f"@$r{input_place}"
    
    @staticmethod
    def get_selected_index(input_place: str) -> str:
        return f"@$x{input_place}"
    
    @staticmethod
    def get_index(input_place: str) -> str:
        return f"@$I{input_place}"
    
    @staticmethod
    def get_text_align(input_place: str) -> str:
        return f"@$T{input_place}"
    
    @staticmethod
    def get_node_length(input_place: str) -> str:
        return f"@$L{input_place}"
    
    @staticmethod
    def get_is_visible(input_place: str) -> str:
        return f"@$V{input_place}"
    
    # Save
    @staticmethod
    def has_hash(hash_value: str) -> str:
        return f"@HH{hash_value}"
    
    @staticmethod
    def cookie(key: str) -> str:
        return f"@co{key}"
    
    @staticmethod
    def session(key: str, replace_value: Optional[str] = None) -> str:
        if replace_value:
            return f"@cs{key},{replace_value}"
        return f"@cs{key}"
    
    @staticmethod
    def session_and_remove(key: str) -> str:
        return f"@cl{key}"
    
    @staticmethod
    def saved(key: str = ".") -> str:
        return Fetch.session(key)
    
    @staticmethod
    def cache(key: str = ".", replace_value: Optional[str] = None) -> str:
        if replace_value:
            return f"@cd{key},{replace_value}"
        return f"@cd{key}"
    
    @staticmethod
    def cache_and_remove(key: str) -> str:
        return f"@ct{key}"
    
    @staticmethod
    def saved_line(key: str = ".", line: int = 0) -> str:
        return f"@lL{key}[{line}"
    
    @staticmethod
    def saved_line_consume(key: str = ".") -> str:
        return f"@lL{key}"
    
    @staticmethod
    def saved_ini(key: str, ini_key: str) -> str:
        return f"@lI{key}[{ini_key}"
    
    @staticmethod
    def cache_line(key: str = ".", line: int = 0) -> str:
        return f"@dL{key}[{line}"
    
    @staticmethod
    def cache_line_consume(key: str = ".") -> str:
        return f"@dL{key}"
    
    @staticmethod
    def cache_ini(key: str, ini_key: str) -> str:
        return f"@dI{key}[{ini_key}"
    
    # Format Storage
    @staticmethod
    def format_store(key: str) -> str:
        return f"@fr{key}"
    
    @staticmethod
    def format_store_by_xml_query(key: str, xpath: str) -> str:
        return f"@fx{key},{xpath}"
    
    @staticmethod
    def format_store_by_json_query(key: str, query: str) -> str:
        return f"@fj{key},{query}"
    
    @staticmethod
    def format_store_by_ini(key: str, name: str) -> str:
        return f"@fi{key},{name}"
    
    @staticmethod
    def format_store_by_text(key: str, line: int) -> str:
        return f"@ft{key},{line}"
    
    @staticmethod
    def format_store_by_variable(key: str) -> str:
        return f"@fv{key}"
    
    # Document
    TAB_IS_ACTIVE = "@da"
    
    # Window
    HREF = "@wf"
    PATH_NAME = "@wP"
    QUERY = "@wq"
    HASH = "@wh"
    HOST = "@wH"
    HOST_NAME = "@wn"
    PORT = "@wT"
    ORIGIN = "@wo"
    GET_SELECTION = "@ws"
    SCROLL_X = "@wx"
    SCROLL_Y = "@wy"
    
    # Navigator
    CLIPBOARD_TEXT = "@nC"
    GEO_LATITUDE = "@nW"
    GEO_LONGITUDE = "@nO"
    LANGUAGE = "@nL"
    IS_ONLINE = "@no"
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
    C = "c"
    CPP = "c"
    RUST = "rust"
    CSHARP = "csharp"
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
    ON_FOCUSIN = "onfocusin"
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
    ON_TOUCHEND = "ontouchend"
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
    FOCUSIN = "focusin"
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
    TOUCHEND = "touchend"
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
    SCROLL_BOTTOM = "scrollbottom"
    ELEMENT_REACHED = "elementreached"


# Extension methods
def append_place(text: str, value: str) -> str:
    if not text:
        return value
    return f"{text}|{value}"

def append_parent(text: str) -> str:
    return f"/{text}"

def export_action_controls_to_webforms_tag(action_controls: str, add_line: bool = False) -> str:
    prefix = "\n" if add_line else ""
    return f'{prefix}<web-forms ac="{action_controls}"></web-forms>'

def export_action_controls_to_html_comment(action_controls: str, add_line: bool = False) -> str:
    prefix = "\n" if add_line else ""
    return f'{prefix}<!--[web-forms]\n{action_controls}-->'

def export_action_controls_to_response(action_controls: str) -> str:
    return f"[web-forms]\n{action_controls}"

def remove_outer(text: str, start_string: str, end_string: str) -> str:
    start = text.find(start_string)
    if start == -1:
        return text
    
    end = text.find(end_string, start)
    if end == -1:
        return text
    
    length_to_remove = (end - start) + len(end_string)
    return text[:start] + text[end + len(end_string):]

def line_break(text: str) -> str:
    return text.replace("\n", "$[sln]")


