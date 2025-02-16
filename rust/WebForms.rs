// Compatible with WebFormsJS version 1.6

pub struct WebForms {
    web_forms_data: NameValueCollection,
}

impl WebForms {
    pub fn new() -> Self {
        WebForms {
            web_forms_data: NameValueCollection::new(),
        }
    }

    // For Extension
    pub fn add_line(&mut self, name: String, value: String) {
        self.web_forms_data.add(name, value);
    }

    // Add
    pub fn add_id(&mut self, input_place: &str, id: String) {
        self.web_forms_data.add(format!("ai{}", input_place), id);
    }

    pub fn add_name(&mut self, input_place: &str, name: String) {
        self.web_forms_data.add(format!("an{}", input_place), name);
    }

    pub fn add_value(&mut self, input_place: &str, value: String) {
        self.web_forms_data.add(format!("av{}", input_place), value);
    }

    pub fn add_class(&mut self, input_place: &str, class: String) {
        self.web_forms_data.add(format!("ac{}", input_place), class);
    }

    pub fn add_style(&mut self, input_place: &str, style: String) {
        self.web_forms_data.add(format!("as{}", input_place), style);
    }

    pub fn add_style_with_name_value(&mut self, input_place: &str, name: String, value: String) {
        self.web_forms_data
            .add(format!("as{}", input_place), format!("{}:{}", name, value));
    }

    pub fn add_option_tag(&mut self, input_place: &str, text: String, value: String, selected: bool) {
        let option_value = format!("{}|{}", value, text);
        let option_value = if selected {
            format!("{}|1", option_value)
        } else {
            option_value
        };
        self.web_forms_data
            .add(format!("ao{}", input_place), option_value);
    }

    pub fn add_check_box_tag(&mut self, input_place: &str, text: String, value: String, checked: bool) {
        let check_box_value = format!("{}|{}", value, text);
        let check_box_value = if checked {
            format!("{}|1", check_box_value)
        } else {
            check_box_value
        };
        self.web_forms_data
            .add(format!("ak{}", input_place), check_box_value);
    }

    pub fn add_title(&mut self, input_place: &str, title: String) {
        self.web_forms_data.add(format!("al{}", input_place), title);
    }

    pub fn add_text(&mut self, input_place: &str, text: String) {
        let text = text.replace('\n', "$[ln];");
        self.web_forms_data.add(format!("at{}", input_place), text);
    }

    pub fn add_text_to_up(&mut self, input_place: &str, text: String) {
        let text = text.replace('\n', "$[ln];");
        self.web_forms_data.add(format!("pt{}", input_place), text);
    }

    pub fn add_attribute(&mut self, input_place: &str, attribute: String, value: String) {
        self.web_forms_data
            .add(format!("aa{}", input_place), format!("{}|{}", attribute, value));
    }

    pub fn add_tag(&mut self, input_place: &str, tag_name: String, id: String) {
        let tag_value = if id.is_empty() {
            tag_name
        } else {
            format!("{}|{}", tag_name, id)
        };
        self.web_forms_data.add(format!("nt{}", input_place), tag_value);
    }

    pub fn add_tag_to_up(&mut self, input_place: &str, tag_name: String, id: String) {
        let tag_value = if id.is_empty() {
            tag_name
        } else {
            format!("{}|{}", tag_name, id)
        };
        self.web_forms_data.add(format!("ut{}", input_place), tag_value);
    }

    pub fn add_tag_before(&mut self, input_place: &str, tag_name: String, id: String) {
        let tag_value = if id.is_empty() {
            tag_name
        } else {
            format!("{}|{}", tag_name, id)
        };
        self.web_forms_data.add(format!("bt{}", input_place), tag_value);
    }

    pub fn add_tag_after(&mut self, input_place: &str, tag_name: String, id: String) {
        let tag_value = if id.is_empty() {
            tag_name
        } else {
            format!("{}|{}", tag_name, id)
        };
        self.web_forms_data.add(format!("ft{}", input_place), tag_value);
    }

    // Set
    pub fn set_id(&mut self, input_place: &str, id: String) {
        self.web_forms_data.add(format!("si{}", input_place), id);
    }

    pub fn set_name(&mut self, input_place: &str, name: String) {
        self.web_forms_data.add(format!("sn{}", input_place), name);
    }

    pub fn set_value(&mut self, input_place: &str, value: String) {
        self.web_forms_data.add(format!("sv{}", input_place), value);
    }

    pub fn set_class(&mut self, input_place: &str, class: String) {
        self.web_forms_data.add(format!("sc{}", input_place), class);
    }

    pub fn set_style(&mut self, input_place: &str, style: String) {
        self.web_forms_data.add(format!("ss{}", input_place), style);
    }

    pub fn set_style_with_name_value(&mut self, input_place: &str, name: String, value: String) {
        self.web_forms_data
            .add(format!("ss{}", input_place), format!("{}:{}", name, value));
    }

    pub fn set_option_tag(&mut self, input_place: &str, text: String, value: String, selected: bool) {
        let option_value = format!("{}|{}", value, text);
        let option_value = if selected {
            format!("{}|1", option_value)
        } else {
            option_value
        };
        self.web_forms_data
            .add(format!("so{}", input_place), option_value);
    }

    pub fn set_checked(&mut self, input_place: &str, checked: bool) {
        self.web_forms_data
            .add(format!("sk{}", input_place), if checked { "1" } else { "0" }.to_string());
    }

    pub fn set_check_box_tag_to_list(&mut self, input_place: &str, text: String, value: String, checked: bool) {
        let check_box_value = format!("{}|{}", value, text);
        let check_box_value = if checked {
            format!("{}|1", check_box_value)
        } else {
            check_box_value
        };
        self.web_forms_data
            .add(format!("sk{}", input_place), check_box_value);
    }

    pub fn set_title(&mut self, input_place: &str, title: String) {
        self.web_forms_data.add(format!("sl{}", input_place), title);
    }

    pub fn set_text(&mut self, input_place: &str, text: String) {
        let text = text.replace('\n', "$[ln];");
        self.web_forms_data.add(format!("st{}", input_place), text);
    }

    pub fn set_attribute(&mut self, input_place: &str, attribute: String, value: String) {
        self.web_forms_data
            .add(format!("sa{}", input_place), format!("{}|{}", attribute, value));
    }

    pub fn set_width_string(&mut self, input_place: &str, width: String) {
        self.web_forms_data.add(format!("sw{}", input_place), width);
    }

    pub fn set_width(&mut self, input_place: &str, width: i32) {
        self.set_width_string(input_place, format!("{}px", width));
    }

    pub fn set_height_string(&mut self, input_place: &str, height: String) {
        self.web_forms_data.add(format!("sh{}", input_place), height);
    }

    pub fn set_height(&mut self, input_place: &str, height: i32) {
        self.set_height_string(input_place, format!("{}px", height));
    }

    // Insert
    pub fn insert_id(&mut self, input_place: &str, id: String) {
        self.web_forms_data.add(format!("ii{}", input_place), id);
    }

    pub fn insert_name(&mut self, input_place: &str, name: String) {
        self.web_forms_data.add(format!("in{}", input_place), name);
    }

    pub fn insert_value(&mut self, input_place: &str, value: String) {
        self.web_forms_data.add(format!("iv{}", input_place), value);
    }

    pub fn insert_class(&mut self, input_place: &str, class: String) {
        self.web_forms_data.add(format!("ic{}", input_place), class);
    }

    pub fn insert_style(&mut self, input_place: &str, style: String) {
        self.web_forms_data.add(format!("is{}", input_place), style);
    }

    pub fn insert_style_with_name_value(&mut self, input_place: &str, name: String, value: String) {
        self.web_forms_data
            .add(format!("is{}", input_place), format!("{}:{}", name, value));
    }

    pub fn insert_option_tag(&mut self, input_place: &str, text: String, value: String, selected: bool) {
        let option_value = format!("{}|{}", value, text);
        let option_value = if selected {
            format!("{}|1", option_value)
        } else {
            option_value
        };
        self.web_forms_data
            .add(format!("io{}", input_place), option_value);
    }

    pub fn insert_check_box_tag(&mut self, input_place: &str, text: String, value: String, checked: bool) {
        let check_box_value = format!("{}|{}", value, text);
        let check_box_value = if checked {
            format!("{}|1", check_box_value)
        } else {
            check_box_value
        };
        self.web_forms_data
            .add(format!("ik{}", input_place), check_box_value);
    }

    pub fn insert_title(&mut self, input_place: &str, title: String) {
        self.web_forms_data.add(format!("il{}", input_place), title);
    }

    pub fn insert_text(&mut self, input_place: &str, text: String) {
        let text = text.replace('\n', "$[ln];");
        self.web_forms_data.add(format!("it{}", input_place), text);
    }

    pub fn insert_attribute(&mut self, input_place: &str, attribute: String, value: String) {
        self.web_forms_data
            .add(format!("ia{}", input_place), format!("{}|{}", attribute, value));
    }

    // Delete
    pub fn delete_id(&mut self, input_place: &str) {
        self.web_forms_data.add(format!("di{}", input_place), "1".to_string());
    }

    pub fn delete_name(&mut self, input_place: &str) {
        self.web_forms_data.add(format!("dn{}", input_place), "1".to_string());
    }

    pub fn delete_value(&mut self, input_place: &str) {
        self.web_forms_data.add(format!("dv{}", input_place), "1".to_string());
    }

    pub fn delete_class(&mut self, input_place: &str, class_name: String) {
        self.web_forms_data.add(format!("dc{}", input_place), class_name);
    }

    pub fn delete_style(&mut self, input_place: &str, style_name: String) {
        self.web_forms_data.add(format!("ds{}", input_place), style_name);
    }

    pub fn delete_option_tag(&mut self, input_place: &str, value: String) {
        self.web_forms_data.add(format!("do{}", input_place), value);
    }

    pub fn delete_all_option_tag(&mut self, input_place: &str) {
        self.web_forms_data.add(format!("do{}", input_place), "*".to_string());
    }

    pub fn delete_check_box_tag(&mut self, input_place: &str, value: String) {
        self.web_forms_data.add(format!("dk{}", input_place), value);
    }

    pub fn delete_all_check_box_tag(&mut self, input_place: &str) {
        self.web_forms_data.add(format!("dk{}", input_place), "*".to_string());
    }

    pub fn delete_title(&mut self, input_place: &str) {
        self.web_forms_data.add(format!("dl{}", input_place), "1".to_string());
    }

    pub fn delete_text(&mut self, input_place: &str) {
        self.web_forms_data.add(format!("dt{}", input_place), "1".to_string());
    }

    pub fn delete_attribute(&mut self, input_place: &str, attribute: String) {
        self.web_forms_data.add(format!("da{}", input_place), attribute);
    }

    pub fn delete(&mut self, input_place: &str) {
        self.web_forms_data.add(format!("de{}", input_place), "1".to_string());
    }

    pub fn delete_parent(&mut self, input_place: &str) {
        self.web_forms_data.add(format!("dp{}", input_place), "1".to_string());
    }

    // Other
    pub fn set_background_color(&mut self, input_place: &str, color: String) {
        self.web_forms_data.add(format!("bc{}", input_place), color);
    }

    pub fn set_text_color(&mut self, input_place: &str, color: String) {
        self.web_forms_data.add(format!("tc{}", input_place), color);
    }

    pub fn set_font_name(&mut self, input_place: &str, name: String) {
        self.web_forms_data.add(format!("fn{}", input_place), name);
    }

    pub fn set_font_size_string(&mut self, input_place: &str, size: String) {
        self.web_forms_data.add(format!("fs{}", input_place), size);
    }

    pub fn set_font_size(&mut self, input_place: &str, size: i32) {
        self.set_font_size_string(input_place, format!("{}px", size));
    }

    pub fn set_font_bold(&mut self, input_place: &str, bold: bool) {
        self.web_forms_data
            .add(format!("fb{}", input_place), if bold { "1" } else { "0" }.to_string());
    }

    pub fn set_visible(&mut self, input_place: &str, visible: bool) {
        self.web_forms_data
            .add(format!("vi{}", input_place), if visible { "1" } else { "0" }.to_string());
    }

    pub fn set_text_align(&mut self, input_place: &str, align: String) {
        self.web_forms_data.add(format!("ta{}", input_place), align);
    }

    pub fn set_read_only(&mut self, input_place: &str, read_only: bool) {
        self.web_forms_data
            .add(format!("sr{}", input_place), if read_only { "1" } else { "0" }.to_string());
    }

    pub fn set_disabled(&mut self, input_place: &str, disabled: bool) {
        self.web_forms_data
            .add(format!("sd{}", input_place), if disabled { "1" } else { "0" }.to_string());
    }

    pub fn set_focus(&mut self, input_place: &str, focus: bool) {
        self.web_forms_data
            .add(format!("sf{}", input_place), if focus { "1" } else { "0" }.to_string());
    }

    pub fn set_min_length(&mut self, input_place: &str, length: i32) {
        self.web_forms_data
            .add(format!("mn{}", input_place), length.to_string());
    }

    pub fn set_max_length(&mut self, input_place: &str, length: i32) {
        self.web_forms_data
            .add(format!("mx{}", input_place), length.to_string());
    }

    pub fn set_selected_value(&mut self, input_place: &str, value: String) {
        self.web_forms_data.add(format!("ts{}", input_place), value);
    }

    pub fn set_selected_index(&mut self, input_place: &str, index: i32) {
        self.web_forms_data
            .add(format!("ti{}", input_place), index.to_string());
    }

    pub fn set_checked_value(&mut self, input_place: &str, value: String, selected: bool) {
        self.web_forms_data
            .add(format!("ks{}", input_place), format!("{}|{}", value, if selected { "1" } else { "0" }));
    }

    pub fn set_checked_index(&mut self, input_place: &str, index: i32, selected: bool) {
        self.web_forms_data
            .add(format!("ki{}", input_place), format!("{}|{}", index, if selected { "1" } else { "0" }));
    }

    pub fn call_script(&mut self, script_text: String) {
        let script_text = script_text.replace('\n', "$[ln];");
        self.web_forms_data.add("_".to_string(), script_text);
    }

    pub fn load_url(&mut self, input_place: &str, url: String) {
        self.web_forms_data.add(format!("lu{}", input_place), url);
    }

    pub fn change_url(&mut self, url: String) {
        self.web_forms_data.add("cu".to_string(), url);
    }

    pub fn remove_session_cache(&mut self, cache_key: String) {
        self.web_forms_data.add("rs".to_string(), cache_key);
    }

    pub fn remove_all_session_cache(&mut self) {
        self.web_forms_data.add("rs".to_string(), "*".to_string());
    }

    pub fn remove_cache(&mut self, cache_key: String) {
        self.web_forms_data.add("rd".to_string(), cache_key);
    }

    pub fn remove_all_cache(&mut self) {
        self.web_forms_data.add("rd".to_string(), "*".to_string());
    }

    pub fn set_session_cache(&mut self) {
        self.web_forms_data.add("cs".to_string(), "1".to_string());
    }

    pub fn set_cache(&mut self, second: i32) {
        self.web_forms_data
            .add("cd".to_string(), second.to_string());
    }

    pub fn set_cache_no_time(&mut self) {
        self.web_forms_data.add("cd".to_string(), "*".to_string());
    }

    // Increase
    pub fn increase_min_length(&mut self, input_place: &str, value: i32) {
        self.web_forms_data
            .add(format!("+n{}", input_place), value.to_string());
    }

    pub fn increase_max_length(&mut self, input_place: &str, value: i32) {
        self.web_forms_data
            .add(format!("+x{}", input_place), value.to_string());
    }

    pub fn increase_font_size(&mut self, input_place: &str, value: i32) {
        self.web_forms_data
            .add(format!("+f{}", input_place), value.to_string());
    }

    pub fn increase_width(&mut self, input_place: &str, value: i32) {
        self.web_forms_data
            .add(format!("+w{}", input_place), value.to_string());
    }

    pub fn increase_height(&mut self, input_place: &str, value: i32) {
        self.web_forms_data
            .add(format!("+h{}", input_place), value.to_string());
    }

    pub fn increase_value(&mut self, input_place: &str, value: i32) {
        self.web_forms_data
            .add(format!("+v{}", input_place), value.to_string());
    }

    // Decrease
    pub fn decrease_min_length(&mut self, input_place: &str, value: i32) {
        self.web_forms_data
            .add(format!("-n{}", input_place), value.to_string());
    }

    pub fn decrease_max_length(&mut self, input_place: &str, value: i32) {
        self.web_forms_data
            .add(format!("-x{}", input_place), value.to_string());
    }

    pub fn decrease_font_size(&mut self, input_place: &str, value: i32) {
        self.web_forms_data
            .add(format!("-f{}", input_place), value.to_string());
    }

    pub fn decrease_width(&mut self, input_place: &str, value: i32) {
        self.web_forms_data
            .add(format!("-w{}", input_place), value.to_string());
    }

    pub fn decrease_height(&mut self, input_place: &str, value: i32) {
        self.web_forms_data
            .add(format!("-h{}", input_place), value.to_string());
    }

    pub fn decrease_value(&mut self, input_place: &str, value: i32) {
        self.web_forms_data
            .add(format!("-v{}", input_place), value.to_string());
    }

    // Event
    pub fn set_post_event(&mut self, input_place: &str, html_event: String) {
        self.web_forms_data
            .add(format!("Ep{}", input_place), html_event);
    }

    pub fn set_post_event_adding(&mut self, input_place: &str, html_event: String) {
        self.web_forms_data
            .add(format!("Ep{}", input_place), format!("{}|+", html_event));
    }

    pub fn set_post_event_to(&mut self, input_place: &str, html_event: String, output_place: String) {
        self.web_forms_data
            .add(format!("Ep{}", input_place), format!("{}|{}", html_event, output_place));
    }

    pub fn set_post_event_listener(&mut self, input_place: &str, html_event_listener: String) {
        self.web_forms_data
            .add(format!("EP{}", input_place), html_event_listener);
    }

    pub fn set_post_event_listener_adding(&mut self, input_place: &str, html_event_listener: String) {
        self.web_forms_data
            .add(format!("EP{}", input_place), format!("{}|+", html_event_listener));
    }

    pub fn set_post_event_listener_to(&mut self, input_place: &str, html_event_listener: String, output_place: String) {
        self.web_forms_data
            .add(format!("EP{}", input_place), format!("{}|{}", html_event_listener, output_place));
    }
	
	pub fn set_get_event(&mut self, input_place: &str, html_event: String, path: String) {
		let path = if path.is_empty() { "#".to_string() } else { path };
		self.web_forms_data
			.add(format!("Eg{}", input_place), format!("{}|{}", html_event, path));
	}

    pub fn set_get_event_with_output(&mut self, input_place: &str, html_event: String, output_place: String, path: String) {
        let path = if path.is_empty() { "#".to_string() } else { path };
        self.web_forms_data
            .add(format!("Eg{}", input_place), format!("{}|{}|{}", html_event, path, output_place));
    }

    pub fn set_get_event_in_form(&mut self, input_place: &str, html_event: String) {
        self.web_forms_data
            .add(format!("Eg{}", input_place), html_event);
    }

    pub fn set_get_event_in_form_with_output(&mut self, input_place: &str, html_event: String, output_place: String) {
        self.web_forms_data
            .add(format!("Eg{}", input_place), format!("{}|{}", html_event, output_place));
    }

    pub fn set_get_event_listener(&mut self, input_place: &str, html_event_listener: String, path: String) {
        let path = if path.is_empty() { "#".to_string() } else { path };
        self.web_forms_data
            .add(format!("EG{}", input_place), format!("{}|{}", html_event_listener, path));
    }

    pub fn set_get_event_listener_with_output(&mut self, input_place: &str, html_event_listener: String, output_place: String, path: String) {
        let path = if path.is_empty() { "#".to_string() } else { path };
        self.web_forms_data
            .add(format!("EG{}", input_place), format!("{}|{}|{}", html_event_listener, path, output_place));
    }

    pub fn set_get_event_in_form_listener(&mut self, input_place: &str, html_event_listener: String) {
        self.web_forms_data
            .add(format!("EG{}", input_place), html_event_listener);
    }

    pub fn set_get_event_in_form_listener_with_output(&mut self, input_place: &str, html_event_listener: String, output_place: String) {
        self.web_forms_data
            .add(format!("EG{}", input_place), format!("{}|{}", html_event_listener, output_place));
    }

    pub fn set_tag_event(&mut self, input_place: &str, html_event: String, output_place: String) {
        self.web_forms_data
            .add(format!("Et{}", input_place), format!("{}|{}", html_event, output_place));
    }

    pub fn set_tag_event_listener(&mut self, input_place: &str, html_event: String, output_place: String) {
        self.web_forms_data
            .add(format!("ET{}", input_place), format!("{}|{}", html_event, output_place));
    }

    pub fn remove_post_event(&mut self, input_place: &str, html_event: String) {
        self.web_forms_data
            .add(format!("Rp{}", input_place), html_event);
    }

    pub fn remove_get_event(&mut self, input_place: &str, html_event: String) {
        self.web_forms_data
            .add(format!("Rg{}", input_place), html_event);
    }

    pub fn remove_tag_event(&mut self, input_place: &str, html_event: String) {
        self.web_forms_data
            .add(format!("Rt{}", input_place), html_event);
    }

    pub fn remove_post_event_listener(&mut self, input_place: &str, html_event_listener: String) {
        self.web_forms_data
            .add(format!("RP{}", input_place), html_event_listener);
    }

    pub fn remove_get_event_listener(&mut self, input_place: &str, html_event_listener: String) {
        self.web_forms_data
            .add(format!("RG{}", input_place), html_event_listener);
    }

    pub fn remove_tag_event_listener(&mut self, input_place: &str, html_event_listener: String) {
        self.web_forms_data
            .add(format!("RT{}", input_place), html_event_listener);
    }

    // Save
    pub fn save_id(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@gi{}", input_place), key);
    }

    pub fn save_name(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@gn{}", input_place), key);
    }

    pub fn save_value(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@gv{}", input_place), key);
    }

    pub fn save_value_length(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@ge{}", input_place), key);
    }

    pub fn save_class(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@gc{}", input_place), key);
    }

    pub fn save_style(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@gs{}", input_place), key);
    }

    pub fn save_title(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@gl{}", input_place), key);
    }

    pub fn save_text(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@gt{}", input_place), key);
    }

    pub fn save_text_length(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@gg{}", input_place), key);
    }

    pub fn save_attribute(&mut self, input_place: &str, attribute: String, key: String) {
        self.web_forms_data
            .add(format!("@ga{}", input_place), format!("{}|{}", key, attribute));
    }

    pub fn save_width(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@gw{}", input_place), key);
    }

    pub fn save_height(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@gh{}", input_place), key);
    }

    pub fn save_read_only(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@gr{}", input_place), key);
    }

    pub fn save_selected_index(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@gx{}", input_place), key);
    }

    pub fn save_text_align(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@ta{}", input_place), key);
    }

    pub fn save_node_length(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@nl{}", input_place), key);
    }

    pub fn save_visible(&mut self, input_place: &str, key: String) {
        self.web_forms_data
            .add(format!("@vi{}", input_place), key);
    }

	// Pre Runner
    pub fn assign_delay(&mut self, second: f32, index: isize) {
        if let Some(current_name) = self.web_forms_data.get_name_by_index(index) {
            self.web_forms_data.change_name_by_index(index, format!(":{}){}", second, current_name));
        }
    }

    pub fn assign_delay_change(&mut self, second: f32, index: isize) {
        if let Some(current_name) = self.web_forms_data.get_name_by_index(index) {
            let current_name = current_name.trim_start_matches(':').trim_end_matches(')');
            self.web_forms_data.change_name_by_index(index, format!(":{}){}", second, current_name));
        }
    }

    pub fn assign_interval(&mut self, second: f32, index: isize) {
        if let Some(current_name) = self.web_forms_data.get_name_by_index(index) {
            self.web_forms_data.change_name_by_index(index, format!("({}){}", second, current_name));
        }
    }

    pub fn assign_interval_change(&mut self, second: f32, index: isize) {
        if let Some(current_name) = self.web_forms_data.get_name_by_index(index) {
            let current_name = current_name.trim_start_matches('(').trim_end_matches(')');
            self.web_forms_data.change_name_by_index(index, format!("({}){}", second, current_name));
        }
    }

    // Index
    pub fn start_index(&mut self, name: String) {
        self.web_forms_data.add("#".to_string(), name);
    }

    pub fn start_index_default(&mut self) {
        self.start_index("".to_string());
    }

    // Get
    pub fn get_forms_action_data(&self) -> String {
        let mut return_value = String::new();
        for nv in self.web_forms_data.get_list() {
            return_value.push_str(&format!("\n{}", nv.name));
            if !nv.value.is_empty() {
                return_value.push_str(&format!("={}", nv.value));
            }
        }
        return_value
    }

    pub fn response(&self) -> String {
        format!("[web-forms]{}", self.get_forms_action_data())
    }

    // Overload
    pub fn response_with_context(&self, _context: &str) -> String {
        // Here, _context could be used if needed to set up headers or something similar
        self.response()
    }

    pub fn get_forms_action_data_line_break(&self) -> String {
        let mut return_value = String::new();
        let name_value_list = self.web_forms_data.get_list();
        let mut i = name_value_list.len();
        for nv in name_value_list {
            return_value.push_str(&nv.name);
            if !nv.value.is_empty() {
                return_value.push_str(&format!("={}", nv.value.replace("\"", "$[dq];")));
            }
            if i > 1 {
                return_value.push_str("$[sln];");
            }
            i -= 1;
        }
        return_value
    }

    // Export
	pub fn export_to_web_forms_tag(&self) -> String {
		format!("<web-forms ac=\"{}\"></web-forms>", self.get_forms_action_data_line_break())
	}
	
	// Overload
	pub fn export_to_web_forms_tag_with_src(&self, src: String) -> String {
		let src = if src.is_empty() { "#".to_string() } else { src };
		format!("<web-forms ac=\"{}\" src=\"{}\"></web-forms>", self.get_forms_action_data_line_break(), src)
	}

	// Overload
	pub fn export_to_web_forms_tag_with_string_dimensions(&self, width: String, height: String) -> String {
		format!("<web-forms ac=\"{}\" width=\"{}\" height=\"{}\"></web-forms>", self.get_forms_action_data_line_break(), width, height)
	}
	
	// Overload
	pub fn export_to_web_forms_tag_with_string_dimensions_with_src(&self, width: String, height: String, src: String) -> String {
		let src = if src.is_empty() { "#".to_string() } else { src };
		format!("<web-forms ac=\"{}\" width=\"{}\" height=\"{}\" src=\"{}\"></web-forms>", self.get_forms_action_data_line_break(), width, height, src)
	}

    // Overload
	pub fn export_to_web_forms_tag_with_dimensions(&self, width: i32, height: i32, src: String) -> String {
		let src = if src.is_empty() { "#".to_string() } else { src };
		self.export_to_web_forms_tag_with_string_dimensions(format!("{}px", width), format!("{}px", height))
	}

    // Overload
	pub fn export_to_web_forms_tag_with_dimensions_with_src(&self, width: i32, height: i32, src: String) -> String {
		let src = if src.is_empty() { "#".to_string() } else { src };
		self.export_to_web_forms_tag_with_string_dimensions_with_src(format!("{}px", width), format!("{}px", height), src)
	}
	
	pub fn done_to_web_forms_tag(&self) -> String {
		format!("<web-forms ac=\"{}\" done=\"true\"></web-forms>", self.get_forms_action_data_line_break())
	}
	
	// Overload
	pub fn done_to_web_forms_tag_with_id(&self, id: String) -> String {
		let id = if id.is_empty() { "#".to_string() } else { id };
		format!("<web-forms ac=\"{}\" id=\"{}\" done=\"true\"></web-forms>", self.get_forms_action_data_line_break(), id)
	}

    pub fn export_to_name_value(&self) -> &NameValueCollection {
        &self.web_forms_data
    }

    pub fn append_form(&mut self, form: WebForms) {
        self.web_forms_data.add_list(form.export_to_name_value().get_list().clone());
    }

    pub fn clean(&mut self) {
        self.web_forms_data.empty();
    }
}

pub struct InputPlace;

impl InputPlace {
    pub fn id(id: &str) -> &str {
        id
    }

    pub fn name(name: &str) -> String {
        format!("({})", name)
    }

    pub fn name_with_index(name: &str, index: i32) -> String {
        format!("({}){}", name, index)
    }

    pub fn tag(tag: &str) -> String {
        format!("<{}>", tag)
    }

    pub fn tag_with_index(tag: &str, index: i32) -> String {
        format!("<{}>{}", tag, index)
    }

    pub fn class(class: &str) -> String {
        format!("{{{}}}", class)
    }

    pub fn class_with_index(class: &str, index: i32) -> String {
        format!("{{{}}}{}", class, index)
    }

    pub fn query(query: &str) -> String {
        format!("*{}", query.replace("=", "$[eq];"))
    }

    pub fn query_all(query: &str) -> String {
        format!("[{}]", query.replace("=", "$[eq];"))
    }
}

pub struct OutputPlace;

impl OutputPlace {
    pub fn id(id: &str) -> &str {
        InputPlace::id(id)
    }

    pub fn name(name: &str) -> String {
        InputPlace::name(name)
    }

    pub fn name_with_index(name: &str, index: i32) -> String {
        InputPlace::name_with_index(name, index)
    }

    pub fn tag(tag: &str) -> String {
        InputPlace::tag(tag)
    }

    pub fn tag_with_index(tag: &str, index: i32) -> String {
        InputPlace::tag_with_index(tag, index)
    }

    pub fn class(class: &str) -> String {
        InputPlace::class(class)
    }

    pub fn class_with_index(class: &str, index: i32) -> String {
        InputPlace::class_with_index(class, index)
    }

    pub fn query(query: &str) -> String {
        InputPlace::query(query)
    }

    pub fn query_all(query: &str) -> String {
        InputPlace::query_all(query)
    }
}

pub struct Fetch;

impl Fetch {
    pub fn random(max_value: i32) -> String {
        format!("@mr{}", max_value)
    }

    pub fn random_with_min(min_value: i32, max_value: i32) -> String {
        format!("@mr{},{}", max_value, min_value)
    }

    pub const DATE_YEAR: &'static str = "@dy";
    pub const DATE_MONTH: &'static str = "@dm";
    pub const DATE_DAY: &'static str = "@dd";
    pub const DATE_HOURS: &'static str = "@dh";
    pub const DATE_MINUTES: &'static str = "@di";
    pub const DATE_SECONDS: &'static str = "@ds";
    pub const DATE_MILLISECONDS: &'static str = "@dl";

    pub fn cookie(key: &str) -> String {
        format!("@co{}", key)
    }

    pub fn session(key: &str) -> String {
        format!("@cs{}", key)
    }

    pub fn session_with_replace_value(key: &str, replace_value: &str) -> String {
        format!("@cs{},{}", key, replace_value)
    }

    pub fn session_and_remove(key: &str) -> String {
        format!("@cl{}", key)
    }

    pub fn session_and_remove_with_replace_value(key: &str, replace_value: &str) -> String {
        format!("@cl{},{}", key, replace_value)
    }

    pub fn saved(key: &str) -> String {
        if key.is_empty() {
            "@cl.".to_string()
        } else {
            format!("@cl{}", key)
        }
    }

    pub fn cache(key: &str) -> String {
        format!("@cd{}", key)
    }

    pub fn cache_with_replace_value(key: &str, replace_value: &str) -> String {
        format!("@cd{},{}", key, replace_value)
    }

    pub fn cache_and_remove(key: &str) -> String {
        format!("@ct{}", key)
    }

    pub fn cache_and_remove_with_replace_value(key: &str, replace_value: &str) -> String {
        format!("@ct{},{}", key, replace_value)
    }

    pub fn script(script_text: &str) -> String {
        format!("@_{}", script_text.replace("\n", "$[ln];"))
    }
}

pub struct HtmlEvent;

impl HtmlEvent {
    pub const ON_ABORT: &'static str = "onabort";
    pub const ON_AFTER_PRINT: &'static str = "onafterprint";
    pub const ON_BEFORE_PRINT: &'static str = "onbeforeprint";
    pub const ON_BEFORE_UNLOAD: &'static str = "onbeforeunload";
    pub const ON_BLUR: &'static str = "onblur";
    pub const ON_CAN_PLAY: &'static str = "oncanplay";
    pub const ON_CAN_PLAY_THROUGH: &'static str = "oncanplaythrough";
    pub const ON_CHANGE: &'static str = "onchange";
    pub const ON_CLICK: &'static str = "onclick";
    pub const ON_COPY: &'static str = "oncopy";
    pub const ON_CUT: &'static str = "oncut";
    pub const ON_DOUBLE_CLICK: &'static str = "ondblclick";
    pub const ON_DRAG: &'static str = "ondrag";
    pub const ON_DRAG_END: &'static str = "ondragend";
    pub const ON_DRAG_ENTER: &'static str = "ondragenter";
    pub const ON_DRAG_LEAVE: &'static str = "ondragleave";
    pub const ON_DRAG_OVER: &'static str = "ondragover";
    pub const ON_DRAG_START: &'static str = "ondragstart";
    pub const ON_DROP: &'static str = "ondrop";
    pub const ON_DURATION_CHANGE: &'static str = "ondurationchange";
    pub const ON_ENDED: &'static str = "onended";
    pub const ON_ERROR: &'static str = "onerror";
    pub const ON_FOCUS: &'static str = "onfocus";
    pub const ON_FOCUS_IN: &'static str = "onfocusin";
    pub const ON_FOCUS_OUT: &'static str = "onfocusout";
    pub const ON_HASH_CHANGE: &'static str = "onhashchange";
    pub const ON_INPUT: &'static str = "oninput";
    pub const ON_INVALID: &'static str = "oninvalid";
    pub const ON_KEY_DOWN: &'static str = "onkeydown";
    pub const ON_KEY_PRESS: &'static str = "onkeypress";
    pub const ON_KEY_UP: &'static str = "onkeyup";
    pub const ON_LOAD: &'static str = "onload";
    pub const ON_LOADED_DATA: &'static str = "onloadeddata";
    pub const ON_LOADED_METADATA: &'static str = "onloadedmetadata";
    pub const ON_LOAD_START: &'static str = "onloadstart";
    pub const ON_MOUSE_DOWN: &'static str = "onmousedown";
    pub const ON_MOUSE_ENTER: &'static str = "onmouseenter";
    pub const ON_MOUSE_LEAVE: &'static str = "onmouseleave";
    pub const ON_MOUSE_MOVE: &'static str = "onmousemove";
    pub const ON_MOUSE_OVER: &'static str = "onmouseover";
    pub const ON_MOUSE_OUT: &'static str = "onmouseout";
    pub const ON_MOUSE_UP: &'static str = "onmouseup";
    pub const ON_OFFLINE: &'static str = "onoffline";
    pub const ON_ONLINE: &'static str = "ononline";
    pub const ON_PAGE_HIDE: &'static str = "onpagehide";
    pub const ON_PAGE_SHOW: &'static str = "onpageshow";
    pub const ON_PASTE: &'static str = "onpaste";
    pub const ON_PAUSE: &'static str = "onpause";
    pub const ON_PLAY: &'static str = "onplay";
    pub const ON_PLAYING: &'static str = "onplaying";
    pub const ON_PROGRESS: &'static str = "onprogress";
    pub const ON_RATE_CHANGE: &'static str = "onratechange";
    pub const ON_RESIZE: &'static str = "onresize";
    pub const ON_RESET: &'static str = "onreset";
    pub const ON_SCROLL: &'static str = "onscroll";
    pub const ON_SEARCH: &'static str = "onsearch";
    pub const ON_SEEKED: &'static str = "onseeked";
    pub const ON_SEEKING: &'static str = "onseeking";
    pub const ON_SELECT: &'static str = "onselect";
    pub const ON_STALLED: &'static str = "onstalled";
    pub const ON_SUBMIT: &'static str = "onsubmit";
    pub const ON_SUSPEND: &'static str = "onsuspend";
    pub const ON_TIME_UPDATE: &'static str = "ontimeupdate";
    pub const ON_TOGGLE: &'static str = "ontoggle";
    pub const ON_TOUCH_CANCEL: &'static str = "ontouchcancel";
    pub const ON_TOUCH_END: &'static str = "ontouchend";
    pub const ON_TOUCH_MOVE: &'static str = "ontouchmove";
    pub const ON_TOUCH_START: &'static str = "ontouchstart";
    pub const ON_UNLOAD: &'static str = "onunload";
    pub const ON_VOLUME_CHANGE: &'static str = "onvolumechange";
    pub const ON_WAITING: &'static str = "onwaiting";
}

pub struct HtmlEventListener;

impl HtmlEventListener {
    pub const ABORT: &'static str = "abort";
    pub const AFTER_PRINT: &'static str = "afterprint";
    pub const BEFORE_PRINT: &'static str = "beforeprint";
    pub const BEFORE_UNLOAD: &'static str = "beforeunload";
    pub const BLUR: &'static str = "blur";
    pub const CAN_PLAY: &'static str = "canplay";
    pub const CAN_PLAY_THROUGH: &'static str = "canplaythrough";
    pub const CHANGE: &'static str = "change";
    pub const CLICK: &'static str = "click";
    pub const COPY: &'static str = "copy";
    pub const CUT: &'static str = "cut";
    pub const DOUBLE_CLICK: &'static str = "dblclick";
    pub const DRAG: &'static str = "drag";
    pub const DRAG_END: &'static str = "dragend";
    pub const DRAG_ENTER: &'static str = "dragenter";
    pub const DRAG_LEAVE: &'static str = "dragleave";
    pub const DRAG_OVER: &'static str = "dragover";
    pub const DRAG_START: &'static str = "dragstart";
    pub const DROP: &'static str = "drop";
    pub const DURATION_CHANGE: &'static str = "durationchange";
    pub const ENDED: &'static str = "ended";
    pub const ERROR: &'static str = "error";
    pub const FOCUS: &'static str = "focus";
    pub const FOCUS_IN: &'static str = "focusin";
    pub const FOCUS_OUT: &'static str = "focusout";
    pub const HASH_CHANGE: &'static str = "hashchange";
    pub const INPUT: &'static str = "input";
    pub const INVALID: &'static str = "invalid";
    pub const KEY_DOWN: &'static str = "keydown";
    pub const KEY_PRESS: &'static str = "keypress";
    pub const KEY_UP: &'static str = "keyup";
    pub const LOAD: &'static str = "load";
    pub const LOADED_DATA: &'static str = "loadeddata";
    pub const LOADED_METADATA: &'static str = "loadedmetadata";
    pub const LOAD_START: &'static str = "loadstart";
    pub const MOUSE_DOWN: &'static str = "mousedown";
    pub const MOUSE_ENTER: &'static str = "mouseenter";
    pub const MOUSE_LEAVE: &'static str = "mouseleave";
    pub const MOUSE_MOVE: &'static str = "mousemove";
    pub const MOUSE_OVER: &'static str = "mouseover";
    pub const MOUSE_OUT: &'static str = "mouseout";
    pub const MOUSE_UP: &'static str = "mouseup";
    pub const OFFLINE: &'static str = "offline";
    pub const ONLINE: &'static str = "online";
    pub const PAGE_HIDE: &'static str = "pagehide";
    pub const PAGE_SHOW: &'static str = "pageshow";
    pub const PASTE: &'static str = "paste";
    pub const PAUSE: &'static str = "pause";
    pub const PLAY: &'static str = "play";
    pub const PLAYING: &'static str = "playing";
    pub const PROGRESS: &'static str = "progress";
    pub const RATE_CHANGE: &'static str = "ratechange";
    pub const RESIZE: &'static str = "resize";
    pub const RESET: &'static str = "reset";
    pub const SCROLL: &'static str = "scroll";
    pub const SEARCH: &'static str = "search";
    pub const SEEKED: &'static str = "seeked";
    pub const SEEKING: &'static str = "seeking";
    pub const SELECT: &'static str = "select";
    pub const STALLED: &'static str = "stalled";
    pub const SUBMIT: &'static str = "submit";
    pub const SUSPEND: &'static str = "suspend";
    pub const TIME_UPDATE: &'static str = "timeupdate";
    pub const TOGGLE: &'static str = "toggle";
    pub const TOUCH_CANCEL: &'static str = "touchcancel";
    pub const TOUCH_END: &'static str = "touchend";
    pub const TOUCH_MOVE: &'static str = "touchmove";
    pub const TOUCH_START: &'static str = "touchstart";
    pub const UNLOAD: &'static str = "unload";
    pub const VOLUME_CHANGE: &'static str = "volumechange";
    pub const WAITING: &'static str = "waiting";

    pub const ANIMATION_END: &'static str = "animationend";
    pub const ANIMATION_ITERATION: &'static str = "animationiteration";
    pub const ANIMATION_START: &'static str = "animationstart";
    pub const CONTEXT_MENU: &'static str = "contextmenu";
    pub const FULL_SCREEN_CHANGE: &'static str = "fullscreenchange";
    pub const FULL_SCREEN_ERROR: &'static str = "fullscreenerror";
    pub const POP_STATE: &'static str = "popstate";
    pub const TRANSITION_END: &'static str = "transitionend";
    pub const STORAGE: &'static str = "storage";
    pub const WHEEL: &'static str = "wheel";
}

trait ExtensionWebFormsMethods {
    fn append_place(&self, value: &str) -> String;
    fn append_parent(&self) -> String;
    fn export_to_web_forms_tag(&self) -> String;
    fn export_to_web_forms_tag_with_size(&self, width: i32, height: i32) -> String;
    fn export_action_controls_to_web_forms_tag(&self) -> String;
    fn remove_outer(&self, start_string: &str, end_string: &str) -> String;
}

impl ExtensionWebFormsMethods for String {
    fn append_place(&self, value: &str) -> String {
        if self.is_empty() {
            value.to_string()
        } else {
            format!("{}|{}", self, value)
        }
    }

    fn append_parent(&self) -> String {
        format!("/{}", self)
    }

    fn export_to_web_forms_tag(&self) -> String {
        format!("<web-forms src=\"{}\"></web-forms>", self)
    }

    fn export_to_web_forms_tag_with_size(&self, width: i32, height: i32) -> String {
        format!("<web-forms src=\"{}\" width=\"{}\" height=\"{}\"></web-forms>", self, width, height)
    }

    fn export_action_controls_to_web_forms_tag(&self) -> String {
        format!("<web-forms ac=\"{}\"></web-forms>", self)
    }

    fn remove_outer(&self, start_string: &str, end_string: &str) -> String {
        let start = self.find(start_string).unwrap_or(0);
        let end = self.rfind(end_string).unwrap_or(self.len());
        if start < end {
            format!("{}{}", &self[..start], &self[end + end_string.len()..])
        } else {
            self.clone()
        }
    }
}

#[derive(Clone)]
pub struct NameValue {
    pub name: String,
    pub value: String,
}

impl NameValue {
    pub fn new(name: String, value: String) -> Self {
        NameValue { name, value }
    }
}

pub struct NameValueCollection {
    name_value_list: Vec<NameValue>,
}

impl NameValueCollection {
    pub fn new() -> Self {
        NameValueCollection {
            name_value_list: Vec::new(),
        }
    }

    pub fn add(&mut self, name: String, value: String) {
        self.name_value_list.push(NameValue::new(name, value));
    }

    pub fn set(&mut self, name: String, value: String) {
        if !self.exist(&name) {
            self.add(name, value);
        } else {
            self.change_value(&name, value);
        }
    }

    pub fn delete(&mut self, name: &str) {
        self.name_value_list.retain(|nv| nv.name != name);
    }

    pub fn delete_by_index(&mut self, index: isize) {
        let len = self.name_value_list.len();
        let idx = if index >= 0 {
            index as usize
        } else {
            len.wrapping_add(index as usize)
        };
        if idx < len {
            self.name_value_list.remove(idx);
        }
    }

    pub fn empty(&mut self) {
        self.name_value_list.clear();
    }

    pub fn exist(&self, name: &str) -> bool {
        self.name_value_list.iter().any(|nv| nv.name == name)
    }

    pub fn change_value(&mut self, name: &str, value: String) {
        if let Some(nv) = self.name_value_list.iter_mut().find(|nv| nv.name == name) {
            nv.value = value;
        }
    }

    pub fn change_name(&mut self, name: &str, new_name: String) {
        if let Some(nv) = self.name_value_list.iter_mut().find(|nv| nv.name == name) {
            nv.name = new_name;
        }
    }

    pub fn change_value_name(&mut self, name: &str, new_name: String, value: String) {
        if let Some(nv) = self.name_value_list.iter_mut().find(|nv| nv.name == name) {
            nv.name = new_name;
            nv.value = value;
        }
    }

    pub fn change_value_by_index(&mut self, index: isize, value: String) {
        let len = self.name_value_list.len();
        let idx = if index >= 0 {
            index as usize
        } else {
            len.wrapping_add(index as usize)
        };
        if idx < len {
            self.name_value_list[idx].value = value;
        }
    }

    pub fn change_name_by_index(&mut self, index: isize, name: String) {
        let len = self.name_value_list.len();
        let idx = if index >= 0 {
            index as usize
        } else {
            len.wrapping_add(index as usize)
        };
        if idx < len {
            self.name_value_list[idx].name = name;
        }
    }

    pub fn change_name_value_by_index(&mut self, index: isize, name: String, value: String) {
        let len = self.name_value_list.len();
        let idx = if index >= 0 {
            index as usize
        } else {
            len.wrapping_add(index as usize)
        };
        if idx < len {
            self.name_value_list[idx].name = name;
            self.name_value_list[idx].value = value;
        }
    }

    pub fn add_list(&mut self, name_value_list: Vec<NameValue>) {
        self.name_value_list.extend(name_value_list);
    }

    pub fn get_value(&self, name: &str) -> Option<&str> {
        self.name_value_list
            .iter()
            .find(|nv| nv.name == name)
            .map(|nv| nv.value.as_str())
    }

    pub fn get_name_by_index(&self, index: isize) -> Option<&str> {
        let len = self.name_value_list.len();
        let idx = if index >= 0 {
            index as usize
        } else {
            len.wrapping_add(index as usize)
        };
        self.name_value_list
            .get(idx)
            .map(|nv| nv.name.as_str())
    }

    pub fn get_value_by_index(&self, index: isize) -> Option<&str> {
        let len = self.name_value_list.len();
        let idx = if index >= 0 {
            index as usize
        } else {
            len.wrapping_add(index as usize)
        };
        self.name_value_list
            .get(idx)
            .map(|nv| nv.value.as_str())
    }

    pub fn get_list(&self) -> &Vec<NameValue> {
        &self.name_value_list
    }
}
