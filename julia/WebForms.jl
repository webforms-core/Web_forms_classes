# Compatible with WebFormsJS version 1.6

struct NameValue
    name::String
    value::String
end

mutable struct NameValueCollection
    data::Vector{NameValue}
    
    NameValueCollection() = new(Vector{NameValue}())
end

function add!(collection::NameValueCollection, name::String, value::String)
    push!(collection.data, NameValue(name, value))
end

function set!(collection::NameValueCollection, name::String, value::String)
    index = findfirst(nv -> nv.name == name, collection.data)
    if index === nothing
        add!(collection, name, value)
    else
        collection.data[index] = NameValue(name, value)
    end
end

function delete!(collection::NameValueCollection, name::String)
    filter!(nv -> nv.name != name, collection.data)
end

function delete_by_index!(collection::NameValueCollection, index::Int)
    if index < 0
        index = length(collection.data) + index + 1
    end
    deleteat!(collection.data, index)
end

function empty!(collection::NameValueCollection)
    empty!(collection.data)
end

function exist(collection::NameValueCollection, name::String)
    return any(nv -> nv.name == name, collection.data)
end

function change_value!(collection::NameValueCollection, name::String, value::String)
    index = findfirst(nv -> nv.name == name, collection.data)
    if index !== nothing
        collection.data[index] = NameValue(name, value)
    end
end

function change_name!(collection::NameValueCollection, name::String, new_name::String)
    index = findfirst(nv -> nv.name == name, collection.data)
    if index !== nothing
        collection.data[index] = NameValue(new_name, collection.data[index].value)
    end
end

function change_value_by_index!(collection::NameValueCollection, index::Int, value::String)
    if index < 0
        index = length(collection.data) + index + 1
    end
    collection.data[index] = NameValue(collection.data[index].name, value)
end

function change_name_by_index!(collection::NameValueCollection, index::Int, name::String)
    if index < 0
        index = length(collection.data) + index + 1
    end
    collection.data[index] = NameValue(name, collection.data[index].value)
end

function change_name_value_by_index!(collection::NameValueCollection, index::Int, name::String, value::String)
    if index < 0
        index = length(collection.data) + index + 1
    end
    collection.data[index] = NameValue(name, value)
end

function add_list!(collection::NameValueCollection, new_data::Vector{NameValue})
    append!(collection.data, new_data)
end

function get_value(collection::NameValueCollection, name::String)
    index = findfirst(nv -> nv.name == name, collection.data)
    return index === nothing ? "" : collection.data[index].value
end

function get_name_by_index(collection::NameValueCollection, index::Int)
    if index < 0
        index = length(collection.data) + index + 1
    end
    return collection.data[index].name
end

function get_value_by_index(collection::NameValueCollection, index::Int)
    if index < 0
        index = length(collection.data) + index + 1
    end
    return collection.data[index].value
end

function get_list(collection::NameValueCollection)
    return collection.data
end

mutable struct WebForms
    web_forms_data::NameValueCollection
    
    WebForms() = new(NameValueCollection())
end

# For Extension
function add_line!(web_forms::WebForms, name::String, value::String)
    add!(web_forms.web_forms_data, name, value)
end

# Add
function add_id!(web_forms::WebForms, input_place::String, id::String)
    add!(web_forms.web_forms_data, "ai" * input_place, id)
end

function add_name!(web_forms::WebForms, input_place::String, name::String)
    add!(web_forms.web_forms_data, "an" * input_place, name)
end

function add_value!(web_forms::WebForms, input_place::String, value::String)
    add!(web_forms.web_forms_data, "av" * input_place, value)
end

function add_class!(web_forms::WebForms, input_place::String, class::String)
    add!(web_forms.web_forms_data, "ac" * input_place, class)
end

function add_style!(web_forms::WebForms, input_place::String, style::String)
    add!(web_forms.web_forms_data, "as" * input_place, style)
end

function add_style!(web_forms::WebForms, input_place::String, name::String, value::String)
    add!(web_forms.web_forms_data, "as" * input_place, name * ':' * value)
end

function add_option_tag!(web_forms::WebForms, input_place::String, text::String, value::String, selected::Bool = false)
    add!(web_forms.web_forms_data, "ao" * input_place, value * '|' * text * (selected ? "|1" : ""))
end

function add_check_box_tag!(web_forms::WebForms, input_place::String, text::String, value::String, checked::Bool = false)
    add!(web_forms.web_forms_data, "ak" * input_place, value * '|' * text * (checked ? "|1" : ""))
end

function add_title!(web_forms::WebForms, input_place::String, title::String)
    add!(web_forms.web_forms_data, "al" * input_place, title)
end

function add_text!(web_forms::WebForms, input_place::String, text::String)
    add!(web_forms.web_forms_data, "at" * input_place, replace(text, '\n' => "\$[ln];"))
end

function add_text_to_up!(web_forms::WebForms, input_place::String, text::String)
    add!(web_forms.web_forms_data, "pt" * input_place, replace(text, '\n' => "\$[ln];"))
end

function add_attribute!(web_forms::WebForms, input_place::String, attribute::String, value::String = "")
    add!(web_forms.web_forms_data, "aa" * input_place, attribute * '|' * value)
end

function add_tag!(web_forms::WebForms, input_place::String, tag_name::String, id::String = "")
    add!(web_forms.web_forms_data, "nt" * input_place, tag_name * (isempty(id) ? "" : '|' * id))
end

function add_tag_to_up!(web_forms::WebForms, input_place::String, tag_name::String, id::String = "")
    add!(web_forms.web_forms_data, "ut" * input_place, tag_name * (isempty(id) ? "" : '|' * id))
end

function add_tag_before!(web_forms::WebForms, input_place::String, tag_name::String, id::String = "")
    add!(web_forms.web_forms_data, "bt" * input_place, tag_name * (isempty(id) ? "" : '|' * id))
end

function add_tag_after!(web_forms::WebForms, input_place::String, tag_name::String, id::String = "")
    add!(web_forms.web_forms_data, "ft" * input_place, tag_name * (isempty(id) ? "" : '|' * id))
end

# Set
function set_id!(web_forms::WebForms, input_place::String, id::String)
    add!(web_forms.web_forms_data, "si" * input_place, id)
end

function set_name!(web_forms::WebForms, input_place::String, name::String)
    add!(web_forms.web_forms_data, "sn" * input_place, name)
end

function set_value!(web_forms::WebForms, input_place::String, value::String)
    add!(web_forms.web_forms_data, "sv" * input_place, value)
end

function set_class!(web_forms::WebForms, input_place::String, class::String)
    add!(web_forms.web_forms_data, "sc" * input_place, class)
end

function set_style!(web_forms::WebForms, input_place::String, style::String)
    add!(web_forms.web_forms_data, "ss" * input_place, style)
end

function set_style!(web_forms::WebForms, input_place::String, name::String, value::String)
    add!(web_forms.web_forms_data, "ss" * input_place, name * ':' * value)
end

function set_option_tag!(web_forms::WebForms, input_place::String, text::String, value::String, selected::Bool = false)
    add!(web_forms.web_forms_data, "so" * input_place, value * '|' * text * (selected ? "|1" : ""))
end

function set_checked!(web_forms::WebForms, input_place::String, checked::Bool = false)
    add!(web_forms.web_forms_data, "sk" * input_place, checked ? "1" : "0")
end

function set_check_box_tag_to_list!(web_forms::WebForms, input_place::String, text::String, value::String, checked::Bool = false)
    add!(web_forms.web_forms_data, "sk" * input_place, value * '|' * text * (checked ? "|1" : ""))
end

function set_title!(web_forms::WebForms, input_place::String, title::String)
    add!(web_forms.web_forms_data, "sl" * input_place, title)
end

function set_text!(web_forms::WebForms, input_place::String, text::String)
    add!(web_forms.web_forms_data, "st" * input_place, replace(text, '\n' => "\$[ln];"))
end

function set_attribute!(web_forms::WebForms, input_place::String, attribute::String, value::String = "")
    add!(web_forms.web_forms_data, "sa" * input_place, attribute * (isempty(value) ? "" : '|' * value))
end

function set_width!(web_forms::WebForms, input_place::String, width::String)
    add!(web_forms.web_forms_data, "sw" * input_place, width)
end

function set_width!(web_forms::WebForms, input_place::String, width::Int)
    set_width!(web_forms, input_place, string(width) * "px")
end

function set_height!(web_forms::WebForms, input_place::String, height::String)
    add!(web_forms.web_forms_data, "sh" * input_place, height)
end

function set_height!(web_forms::WebForms, input_place::String, height::Int)
    set_height!(web_forms, input_place, string(height) * "px")
end

# Insert
function insert_id!(web_forms::WebForms, input_place::String, id::String)
    add!(web_forms.web_forms_data, "ii" * input_place, id)
end

function insert_name!(web_forms::WebForms, input_place::String, name::String)
    add!(web_forms.web_forms_data, "in" * input_place, name)
end

function insert_value!(web_forms::WebForms, input_place::String, value::String)
    add!(web_forms.web_forms_data, "iv" * input_place, value)
end

function insert_class!(web_forms::WebForms, input_place::String, class::String)
    add!(web_forms.web_forms_data, "ic" * input_place, class)
end

function insert_style!(web_forms::WebForms, input_place::String, style::String)
    add!(web_forms.web_forms_data, "is" * input_place, style)
end

function insert_style!(web_forms::WebForms, input_place::String, name::String, value::String)
    add!(web_forms.web_forms_data, "is" * input_place, name * ':' * value)
end

function insert_option_tag!(web_forms::WebForms, input_place::String, text::String, value::String, selected::Bool = false)
    add!(web_forms.web_forms_data, "io" * input_place, value * '|' * text * (selected ? "|1" : ""))
end

function insert_check_box_tag!(web_forms::WebForms, input_place::String, text::String, value::String, checked::Bool = false)
    add!(web_forms.web_forms_data, "ik" * input_place, value * '|' * text * (checked ? "|1" : ""))
end

function insert_title!(web_forms::WebForms, input_place::String, title::String)
    add!(web_forms.web_forms_data, "il" * input_place, title)
end

function insert_text!(web_forms::WebForms, input_place::String, text::String)
    add!(web_forms.web_forms_data, "it" * input_place, replace(text, '\n' => "\$[ln];"))
end

function insert_attribute!(web_forms::WebForms, input_place::String, attribute::String, value::String = "")
    add!(web_forms.web_forms_data, "ia" * input_place, attribute * (isempty(value) ? "" : '|' * value))
end

# Delete
function delete_id!(web_forms::WebForms, input_place::String)
    add!(web_forms.web_forms_data, "di" * input_place, "1")
end

function delete_name!(web_forms::WebForms, input_place::String)
    add!(web_forms.web_forms_data, "dn" * input_place, "1")
end

function delete_value!(web_forms::WebForms, input_place::String)
    add!(web_forms.web_forms_data, "dv" * input_place, "1")
end

function delete_class!(web_forms::WebForms, input_place::String, class_name::String)
    add!(web_forms.web_forms_data, "dc" * input_place, class_name)
end

function delete_style!(web_forms::WebForms, input_place::String, style_name::String)
    add!(web_forms.web_forms_data, "ds" * input_place, style_name)
end

function delete_option_tag!(web_forms::WebForms, input_place::String, value::String)
    add!(web_forms.web_forms_data, "do" * input_place, value)
end

function delete_all_option_tag!(web_forms::WebForms, input_place::String)
    add!(web_forms.web_forms_data, "do" * input_place, "*")
end

function delete_check_box_tag!(web_forms::WebForms, input_place::String, value::String)
    add!(web_forms.web_forms_data, "dk" * input_place, value)
end

function delete_all_check_box_tag!(web_forms::WebForms, input_place::String)
    add!(web_forms.web_forms_data, "dk" * input_place, "*")
end

function delete_title!(web_forms::WebForms, input_place::String)
    add!(web_forms.web_forms_data, "dl" * input_place, "1")
end

function delete_text!(web_forms::WebForms, input_place::String)
    add!(web_forms.web_forms_data, "dt" * input_place, "1")
end

function delete_attribute!(web_forms::WebForms, input_place::String, attribute::String)
    add!(web_forms.web_forms_data, "da" * input_place, attribute)
end

function delete!(web_forms::WebForms, input_place::String)
    add!(web_forms.web_forms_data, "de" * input_place, "1")
end

function delete_parent!(web_forms::WebForms, input_place::String)
    add!(web_forms.web_forms_data, "dp" * input_place, "1")
end

# Other
function set_background_color!(web_forms::WebForms, input_place::String, color::String)
    add!(web_forms.web_forms_data, "bc" * input_place, color)
end

function set_text_color!(web_forms::WebForms, input_place::String, color::String)
    add!(web_forms.web_forms_data, "tc" * input_place, color)
end

function set_font_name!(web_forms::WebForms, input_place::String, name::String)
    add!(web_forms.web_forms_data, "fn" * input_place, name)
end

function set_font_size!(web_forms::WebForms, input_place::String, size::String)
    add!(web_forms.web_forms_data, "fs" * input_place, size)
end

function set_font_size!(web_forms::WebForms, input_place::String, size::Int)
    set_font_size!(web_forms, input_place, string(size) * "px")
end

function set_font_bold!(web_forms::WebForms, input_place::String, bold::Bool)
    add!(web_forms.web_forms_data, "fb" * input_place, bold ? "1" : "0")
end

function set_visible!(web_forms::WebForms, input_place::String, visible::Bool)
    add!(web_forms.web_forms_data, "vi" * input_place, visible ? "1" : "0")
end

function set_text_align!(web_forms::WebForms, input_place::String, align::String)
    add!(web_forms.web_forms_data, "ta" * input_place, align)
end

function set_read_only!(web_forms::WebForms, input_place::String, read_only::Bool)
    add!(web_forms.web_forms_data, "sr" * input_place, read_only ? "1" : "0")
end

function set_disabled!(web_forms::WebForms, input_place::String, disabled::Bool)
    add!(web_forms.web_forms_data, "sd" * input_place, disabled ? "1" : "0")
end

function set_focus!(web_forms::WebForms, input_place::String, focus::Bool)
    add!(web_forms.web_forms_data, "sf" * input_place, focus ? "1" : "0")
end

function set_min_length!(web_forms::WebForms, input_place::String, length::Int)
    add!(web_forms.web_forms_data, "mn" * input_place, string(length))
end

function set_max_length!(web_forms::WebForms, input_place::String, length::Int)
    add!(web_forms.web_forms_data, "mx" * input_place, string(length))
end

function set_selected_value!(web_forms::WebForms, input_place::String, value::String)
    add!(web_forms.web_forms_data, "ts" * input_place, value)
end

function set_selected_index!(web_forms::WebForms, input_place::String, index::Int)
    add!(web_forms.web_forms_data, "ti" * input_place, string(index))
end

function set_checked_value!(web_forms::WebForms, input_place::String, value::String, selected::Bool)
    add!(web_forms.web_forms_data, "ks" * input_place, value * "|" * (selected ? "1" : "0"))
end

function set_checked_index!(web_forms::WebForms, input_place::String, index::Int, selected::Bool)
    add!(web_forms.web_forms_data, "ki" * input_place, string(index) * "|" * (selected ? "1" : "0"))
end

function call_script!(web_forms::WebForms, script_text::String)
    add!(web_forms.web_forms_data, "_", replace(script_text, '\n' => "\$[ln];"))
end

function load_url!(web_forms::WebForms, input_place::String, url::String)
    add!(web_forms.web_forms_data, "lu" * input_place, url)
end

function change_url!(web_forms::WebForms, url::String)
    add!(web_forms.web_forms_data, "cu", url)
end

function remove_session_cache!(web_forms::WebForms, cache_key::String)
    add!(web_forms.web_forms_data, "rs", cache_key)
end

function remove_all_session_cache!(web_forms::WebForms)
    add!(web_forms.web_forms_data, "rs", "*")
end

function remove_cache!(web_forms::WebForms, cache_key::String)
    add!(web_forms.web_forms_data, "rd", cache_key)
end

function remove_all_cache!(web_forms::WebForms)
    add!(web_forms.web_forms_data, "rd", "*")
end

function set_session_cache!(web_forms::WebForms)
    add!(web_forms.web_forms_data, "cs", "1")
end

function set_cache!(web_forms::WebForms, second::Int)
    add!(web_forms.web_forms_data, "cd", string(second))
end

function set_cache!(web_forms::WebForms)
    add!(web_forms.web_forms_data, "cd", "*")
end

# Increase
function increase_min_length!(web_forms::WebForms, input_place::String, value::Int)
    add!(web_forms.web_forms_data, "+n" * input_place, string(value))
end

function increase_max_length!(web_forms::WebForms, input_place::String, value::Int)
    add!(web_forms.web_forms_data, "+x" * input_place, string(value))
end

function increase_font_size!(web_forms::WebForms, input_place::String, value::Int)
    add!(web_forms.web_forms_data, "+f" * input_place, string(value))
end

function increase_width!(web_forms::WebForms, input_place::String, value::Int)
    add!(web_forms.web_forms_data, "+w" * input_place, string(value))
end

function increase_height!(web_forms::WebForms, input_place::String, value::Int)
    add!(web_forms.web_forms_data, "+h" * input_place, string(value))
end

function increase_value!(web_forms::WebForms, input_place::String, value::Int)
    add!(web_forms.web_forms_data, "+v" * input_place, string(value))
end

# Decrease
function decrease_min_length!(web_forms::WebForms, input_place::String, value::Int)
    add!(web_forms.web_forms_data, "-n" * input_place, string(value))
end

function decrease_max_length!(web_forms::WebForms, input_place::String, value::Int)
    add!(web_forms.web_forms_data, "-x" * input_place, string(value))
end

function decrease_font_size!(web_forms::WebForms, input_place::String, value::Int)
    add!(web_forms.web_forms_data, "-f" * input_place, string(value))
end

function decrease_width!(web_forms::WebForms, input_place::String, value::Int)
    add!(web_forms.web_forms_data, "-w" * input_place, string(value))
end

function decrease_height!(web_forms::WebForms, input_place::String, value::Int)
    add!(web_forms.web_forms_data, "-h" * input_place, string(value))
end

function decrease_value!(web_forms::WebForms, input_place::String, value::Int)
    add!(web_forms.web_forms_data, "-v" * input_place, string(value))
end

# Event
function set_post_event!(web_forms::WebForms, input_place::String, html_event::String)
    add!(web_forms.web_forms_data, "Ep" * input_place, html_event)
end

function set_post_event_adding!(web_forms::WebForms, input_place::String, html_event::String)
    add!(web_forms.web_forms_data, "Ep" * input_place, html_event * "|+")
end

function set_post_event_to!(web_forms::WebForms, input_place::String, html_event::String, output_place::String)
    add!(web_forms.web_forms_data, "Ep" * input_place, html_event * "|" * output_place)
end

function set_post_event_listener!(web_forms::WebForms, input_place::String, html_event_listener::String)
    add!(web_forms.web_forms_data, "EP" * input_place, html_event_listener)
end

function set_post_event_listener_adding!(web_forms::WebForms, input_place::String, html_event_listener::String)
    add!(web_forms.web_forms_data, "EP" * input_place, html_event_listener * "|+")
end

function set_post_event_listener_to!(web_forms::WebForms, input_place::String, html_event_listener::String, output_place::String)
    add!(web_forms.web_forms_data, "EP" * input_place, html_event_listener * "|" * output_place)
end

function set_get_event!(web_forms::WebForms, input_place::String, html_event::String, path::String = "#")
    add!(web_forms.web_forms_data, "Eg" * input_place, html_event * "|" * (isempty(path) ? "#" : path))
end

function set_get_event!(web_forms::WebForms, input_place::String, html_event::String, output_place::String, path::String = "#")
    add!(web_forms.web_forms_data, "Eg" * input_place, html_event * "|" * (isempty(path) ? "#" : path) * "|" * output_place)
end

function set_get_event_in_form!(web_forms::WebForms, input_place::String, html_event::String)
    add!(web_forms.web_forms_data, "Eg" * input_place, html_event)
end

function set_get_event_in_form!(web_forms::WebForms, input_place::String, html_event::String, output_place::String)
    add!(web_forms.web_forms_data, "Eg" * input_place, html_event * "|" * output_place)
end

function set_get_event_listener!(web_forms::WebForms, input_place::String, html_event_listener::String, path::String = "#")
    add!(web_forms.web_forms_data, "EG" * input_place, html_event_listener * "|" * (isempty(path) ? "#" : path))
end

function set_get_event_listener!(web_forms::WebForms, input_place::String, html_event_listener::String, output_place::String, path::String = "#")
    add!(web_forms.web_forms_data, "EG" * input_place, html_event_listener * "|" * (isempty(path) ? "#" : path) * "|" * output_place)
end

function set_get_event_in_form_listener!(web_forms::WebForms, input_place::String, html_event_listener::String)
    add!(web_forms.web_forms_data, "EG" * input_place, html_event_listener)
end

function set_get_event_in_form_listener!(web_forms::WebForms, input_place::String, html_event_listener::String, output_place::String)
    add!(web_forms.web_forms_data, "EG" * input_place, html_event_listener * "|" * output_place)
end

function set_tag_event!(web_forms::WebForms, input_place::String, html_event::String, output_place::String)
    add!(web_forms.web_forms_data, "Et" * input_place, html_event * "|" * output_place)
end

function set_tag_event_listener!(web_forms::WebForms, input_place::String, html_event::String, output_place::String)
    add!(web_forms.web_forms_data, "ET" * input_place, html_event * "|" * output_place)
end

function remove_post_event!(web_forms::WebForms, input_place::String, html_event::String)
    add!(web_forms.web_forms_data, "Rp" * input_place, html_event)
end

function remove_get_event!(web_forms::WebForms, input_place::String, html_event::String)
    add!(web_forms.web_forms_data, "Rg" * input_place, html_event)
end

function remove_tag_event!(web_forms::WebForms, input_place::String, html_event::String)
    add!(web_forms.web_forms_data, "Rt" * input_place, html_event)
end

function remove_post_event_listener!(web_forms::WebForms, input_place::String, html_event_listener::String)
    add!(web_forms.web_forms_data, "RP" * input_place, html_event_listener)
end

function remove_get_event_listener!(web_forms::WebForms, input_place::String, html_event_listener::String)
    add!(web_forms.web_forms_data, "RG" * input_place, html_event_listener)
end

function remove_tag_event_listener!(web_forms::WebForms, input_place::String, html_event_listener::String)
    add!(web_forms.web_forms_data, "RT" * input_place, html_event_listener)
end

# Save
function save_id!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@gi" * input_place, key)
end

function save_name!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@gn" * input_place, key)
end

function save_value!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@gv" * input_place, key)
end

function save_value_length!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@ge" * input_place, key)
end

function save_class!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@gc" * input_place, key)
end

function save_style!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@gs" * input_place, key)
end

function save_title!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@gl" * input_place, key)
end

function save_text!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@gt" * input_place, key)
end

function save_text_length!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@gg" * input_place, key)
end

function save_attribute!(web_forms::WebForms, input_place::String, attribute::String, key::String = ".")
    add!(web_forms.web_forms_data, "@ga" * input_place, key * '|' * attribute)
end

function save_width!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@gw" * input_place, key)
end

function save_height!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@gh" * input_place, key)
end

function save_read_only!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@gr" * input_place, key)
end

function save_selected_index!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@gx" * input_place, key)
end

function save_text_align!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@ta" * input_place, key)
end

function save_node_length!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@nl" * input_place, key)
end

function save_visible!(web_forms::WebForms, input_place::String, key::String = ".")
    add!(web_forms.web_forms_data, "@vi" * input_place, key)
end

# Pre Runner
function assign_delay!(web_forms::WebForms, second::Float32, index::Int = -1)
    current_name = get_name_by_index(web_forms.web_forms_data, index)
    if isempty(current_name)
        return
    end
    change_name_by_index!(web_forms.web_forms_data, index, ":" * string(second) * ")" * current_name)
end

function assign_delay_change!(web_forms::WebForms, second::Float32, index::Int = -1)
    current_name = get_name_by_index(web_forms.web_forms_data, index)
    if isempty(current_name)
        return
    end
    current_name = replace(current_name, r"^:.*\)" => "")
    change_name_by_index!(web_forms.web_forms_data, index, ":" * string(second) * ")" * current_name)
end

function assign_interval!(web_forms::WebForms, second::Float32, index::Int = -1)
    current_name = get_name_by_index(web_forms.web_forms_data, index)
    if isempty(current_name)
        return
    end
    change_name_by_index!(web_forms.web_forms_data, index, "(" * string(second) * ")" * current_name)
end

function assign_interval_change!(web_forms::WebForms, second::Float32, index::Int = -1)
    current_name = get_name_by_index(web_forms.web_forms_data, index)
    if isempty(current_name)
        return
    end
    current_name = replace(current_name, r"^\(.*\)" => "")
    change_name_by_index!(web_forms.web_forms_data, index, "(" * string(second) * ")" * current_name)
end

# Index
function start_index!(web_forms::WebForms, name::String = "")
    add!(web_forms.web_forms_data, "#", name)
end

# Get
function get_forms_action_data(web_forms::WebForms)
    return join([nv.name * (isempty(nv.value) ? "" : "=" * nv.value) for nv in get_list(web_forms.web_forms_data)], "\n")
end

function response(web_forms::WebForms)
    return "[web-forms]" * get_forms_action_data(web_forms)
end

# Overload
function response(web_forms::WebForms, context::HttpContext)
    set_headers(context)
    return response(web_forms)
end

function get_forms_action_data_line_break(web_forms::WebForms)
    web_forms_data_list = get_list(web_forms.web_forms_data)
    i = length(web_forms_data_list)
    return join([nv.name * (isempty(nv.value) ? "" : "=" * replace(nv.value, "\"" => "\$[dq];")) * (i -= 1) > 0 ? "\$[sln];" : "" for nv in web_forms_data_list])
end

# Export
function export_to_web_forms_tag(web_forms::WebForms, src::String = "")
    return "<web-forms ac=\"" * get_forms_action_data_line_break(web_forms) * "\"" * (isempty(src) ? "" : " src=\"" * src * "\"") * "></web-forms>"
end

# Overload
function export_to_web_forms_tag(web_forms::WebForms, width::String, height::String, src::String = "")
    return "<web-forms ac=\"" * get_forms_action_data_line_break(web_forms) * "\" width=\"" * width * "\" height=\"" * height * "\"" * (isempty(src) ? "" : " src=\"" * src * "\"") * "></web-forms>"
end

# Overload
function export_to_web_forms_tag(web_forms::WebForms, width::Int, height::Int, src::String = "")
    return export_to_web_forms_tag(web_forms, string(width) * "px", string(height) * "px", src)
end

function done_to_web_forms_tag(web_forms::WebForms, id::String = "")
    return "<web-forms ac=\"" * get_forms_action_data_line_break(web_forms) * "\"" * (isempty(id) ? "" : " id=\"" * id * "\" done=\"true\"") * "></web-forms>"
end

function export_to_name_value(web_forms::WebForms)
    return web_forms.web_forms_data
end

function append_form!(web_forms::WebForms, form::WebForms)
    add_list!(web_forms.web_forms_data, get_list(form.web_forms_data))
end

function set_headers(context::HttpContext)
    context.response.headers["Content-Type"] = "text/plain"
end

function clean!(web_forms::WebForms)
    web_forms.web_forms_data = NameValueCollection()
end

module InputPlace
    export Id, Name, Tag, Class, Query, QueryAll

    Id(id::String) = id

    Name(name::String) = "($name)"
    Name(name::String, index::Int) = "($name)$index"

    Tag(tag::String) = "<$tag>"
    Tag(tag::String, index::Int) = "<$tag>$index"

    Class(class::String) = "{$class}"
    Class(class::String, index::Int) = "{$class}$index"

    Query(query::String) = "*" * replace(query, "=" => "\$[eq];")
    QueryAll(query::String) = "[" * replace(query, "=" => "\$[eq];")
end

module OutputPlace
    using ..InputPlace
    export Id, Name, Tag, Class, Query, QueryAll
end

module Fetch
    export Random, DateYear, DateMonth, DateDay, DateHours, DateMinutes, DateSeconds, DateMilliseconds,
           Cookie, Session, SessionAndRemove, Saved, Cache, CacheAndRemove, Script

    Random(max_value::Int) = "@mr$max_value"
    Random(min_value::Int, max_value::Int) = "@mr$max_value,$min_value"

    const DateYear = "@dy"
    const DateMonth = "@dm"
    const DateDay = "@dd"
    const DateHours = "@dh"
    const DateMinutes = "@di"
    const DateSeconds = "@ds"
    const DateMilliseconds = "@dl"

    Cookie(key::String) = "@co$key"

    Session(key::String) = "@cs$key"
    Session(key::String, replace_value::String) = "@cs$key,$replace_value"

    SessionAndRemove(key::String) = "@cl$key"
    SessionAndRemove(key::String, replace_value::String) = "@cl$key,$replace_value"

    Saved(key::String = ".") = "@cl$key"

    Cache(key::String) = "@cd$key"
    Cache(key::String, replace_value::String) = "@cd$key,$replace_value"

    CacheAndRemove(key::String) = "@ct$key"
    CacheAndRemove(key::String, replace_value::String) = "@ct$key,$replace_value"

    Script(script_text::String) = "@_" * replace(script_text, '\n' => "\$[ln];")
end

module HtmlEvent
    export OnAbort, OnAfterPrint, OnBeforePrint, OnBeforeUnload, OnBlur, OnCanPlay, OnCanPlayThrough,
           OnChange, OnClick, OnCopy, OnCut, OnDoubleClick, OnDrag, OnDragEnd, OnDragEnter, OnDragLeave,
           OnDragOver, OnDragStart, OnDrop, OnDurationChange, OnEnded, OnError, OnFocus, OnFocusin,
           OnFocusOut, OnHashChange, OnInput, OnInvalid, OnKeyDown, OnKeyPress, OnKeyUp, OnLoad,
           OnLoadedData, OnLoadedMetaData, OnLoadStart, OnMouseDown, OnMouseEnter, OnMouseLeave,
           OnMouseMove, OnMouseOver, OnMouseOut, OnMouseUp, OnOffline, OnOnline, OnPageHide, OnPageShow,
           OnPaste, OnPause, OnPlay, OnPlaying, OnProgress, OnRateChange, OnResize, OnReset, OnScroll,
           OnSearch, OnSeeked, OnSeeking, OnSelect, OnStalled, OnSubmit, OnSuspend, OnTimeUpdate,
           OnToggle, OnTouchCancel, OnTouchend, OnTouchMove, OnTouchStart, OnUnload, OnVolumeChange,
           OnWaiting

    const OnAbort = "onabort"
    const OnAfterPrint = "onafterprint"
    const OnBeforePrint = "onbeforeprint"
    const OnBeforeUnload = "onbeforeunload"
    const OnBlur = "onblur"
    const OnCanPlay = "oncanplay"
    const OnCanPlayThrough = "oncanplaythrough"
    const OnChange = "onchange"
    const OnClick = "onclick"
    const OnCopy = "oncopy"
    const OnCut = "oncut"
    const OnDoubleClick = "ondblclick"
    const OnDrag = "ondrag"
    const OnDragEnd = "ondragend"
    const OnDragEnter = "ondragenter"
    const OnDragLeave = "ondragleave"
    const OnDragOver = "ondragover"
    const OnDragStart = "ondragstart"
    const OnDrop = "ondrop"
    const OnDurationChange = "ondurationchange"
    const OnEnded = "onended"
    const OnError = "onerror"
    const OnFocus = "onfocus"
    const OnFocusin = "onfocusin"
    const OnFocusOut = "onfocusout"
    const OnHashChange = "onhashchange"
    const OnInput = "oninput"
    const OnInvalid = "oninvalid"
    const OnKeyDown = "onkeydown"
    const OnKeyPress = "onkeypress"
    const OnKeyUp = "onkeyup"
    const OnLoad = "onload"
    const OnLoadedData = "onloadeddata"
    const OnLoadedMetaData = "onloadedmetadata"
    const OnLoadStart = "onloadstart"
    const OnMouseDown = "onmousedown"
    const OnMouseEnter = "onmouseenter"
    const OnMouseLeave = "onmouseleave"
    const OnMouseMove = "onmousemove"
    const OnMouseOver = "onmouseover"
    const OnMouseOut = "onmouseout"
    const OnMouseUp = "onmouseup"
    const OnOffline = "onoffline"
    const OnOnline = "ononline"
    const OnPageHide = "onpagehide"
    const OnPageShow = "onpageshow"
    const OnPaste = "onpaste"
    const OnPause = "onpause"
    const OnPlay = "onplay"
    const OnPlaying = "onplaying"
    const OnProgress = "onprogress"
    const OnRateChange = "onratechange"
    const OnResize = "onresize"
    const OnReset = "onreset"
    const OnScroll = "onscroll"
    const OnSearch = "onsearch"
    const OnSeeked = "onseeked"
    const OnSeeking = "onseeking"
    const OnSelect = "onselect"
    const OnStalled = "onstalled"
    const OnSubmit = "onsubmit"
    const OnSuspend = "onsuspend"
    const OnTimeUpdate = "ontimeupdate"
    const OnToggle = "ontoggle"
    const OnTouchCancel = "ontouchcancel"
    const OnTouchend = "ontouchend"
    const OnTouchMove = "ontouchmove"
    const OnTouchStart = "ontouchstart"
    const OnUnload = "onunload"
    const OnVolumeChange = "onvolumechange"
    const OnWaiting = "onwaiting"
end

module HtmlEventListener
    export Abort, AfterPrint, BeforePrint, BeforeUnload, Blur, CanPlay, CanPlayThrough, Change, Click,
           Copy, Cut, DoubleClick, Drag, DragEnd, DragEnter, DragLeave, DragOver, DragStart, Drop,
           DurationChange, Ended, Error, Focus, Focusin, FocusOut, HashChange, Input, Invalid, KeyDown,
           KeyPress, KeyUp, Load, LoadedData, LoadedMetaData, LoadStart, MouseDown, MouseEnter, MouseLeave,
           MouseMove, MouseOver, MouseOut, MouseUp, Offline, Online, PageHide, PageShow, Paste, Pause,
           Play, Playing, Progress, RateChange, Resize, Reset, Scroll, Search, Seeked, Seeking, Select,
           Stalled, Submit, Suspend, TimeUpdate, Toggle, TouchCancel, Touchend, TouchMove, TouchStart,
           Unload, VolumeChange, Waiting, AnimationEnd, AnimationIteration, AnimationStart, ContextMenu,
           FullScreenChange, FullScreenError, PopState, TransitionEnd, Storage, Wheel

    const Abort = "abort"
    const AfterPrint = "afterprint"
    const BeforePrint = "beforeprint"
    const BeforeUnload = "beforeunload"
    const Blur = "blur"
    const CanPlay = "canplay"
    const CanPlayThrough = "canplaythrough"
    const Change = "change"
    const Click = "click"
    const Copy = "copy"
    const Cut = "cut"
    const DoubleClick = "dblclick"
    const Drag = "drag"
    const DragEnd = "dragend"
    const DragEnter = "dragenter"
    const DragLeave = "dragleave"
    const DragOver = "dragover"
    const DragStart = "dragstart"
    const Drop = "drop"
    const DurationChange = "durationchange"
    const Ended = "ended"
    const Error = "error"
    const Focus = "focus"
    const Focusin = "focusin"
    const FocusOut = "focusout"
    const HashChange = "hashchange"
    const Input = "input"
    const Invalid = "invalid"
    const KeyDown = "keydown"
    const KeyPress = "keypress"
    const KeyUp = "keyup"
    const Load = "load"
    const LoadedData = "loadeddata"
    const LoadedMetaData = "loadedmetadata"
    const LoadStart = "loadstart"
    const MouseDown = "mousedown"
    const MouseEnter = "mouseenter"
    const MouseLeave = "mouseleave"
    const MouseMove = "mousemove"
    const MouseOver = "mouseover"
    const MouseOut = "mouseout"
    const MouseUp = "mouseup"
    const Offline = "offline"
    const Online = "online"
    const PageHide = "pagehide"
    const PageShow = "pageshow"
    const Paste = "paste"
    const Pause = "pause"
    const Play = "play"
    const Playing = "playing"
    const Progress = "progress"
    const RateChange = "ratechange"
    const Resize = "resize"
    const Reset = "reset"
    const Scroll = "scroll"
    const Search = "search"
    const Seeked = "seeked"
    const Seeking = "seeking"
    const Select = "select"
    const Stalled = "stalled"
    const Submit = "submit"
    const Suspend = "suspend"
    const TimeUpdate = "timeupdate"
    const Toggle = "toggle"
    const TouchCancel = "touchcancel"
    const Touchend = "touchend"
    const TouchMove = "touchmove"
    const TouchStart = "touchstart"
    const Unload = "unload"
    const VolumeChange = "volumechange"
    const Waiting = "waiting"

    const AnimationEnd = "animationend"
    const AnimationIteration = "animationiteration"
    const AnimationStart = "animationstart"
    const ContextMenu = "contextmenu"
    const FullScreenChange = "fullscreenchange"
    const FullScreenError = "fullscreenerror"
    const PopState = "popstate"
    const TransitionEnd = "transitionend"
    const Storage = "storage"
    const Wheel = "wheel"
end

module ExtensionWebFormsMethods
    export append_place, append_parent, export_to_web_forms_tag, remove_outer

    function append_place(text::String, value::String)
        if isempty(text)
            return value
        end
        return text * "|" * value
    end

    function append_parent(text::String)
        return "/" * text
    end

    function export_to_web_forms_tag(src::String)
        return "<web-forms src=\"$src\"></web-forms>"
    end

    function export_to_web_forms_tag(src::String, width::Int, height::Int)
        return "<web-forms src=\"$src\" width=\"$width\" height=\"$height\"></web-forms>"
    end

    function export_action_controls_to_web_forms_tag(action_controls::String)
        return "<web-forms ac=\"$action_controls\"></web-forms>"
    end

    function remove_outer(text::String, start_string::String, end_string::String)
        start = findfirst(start_string, text)
        if start === nothing
            return text
        end
        end_pos = findfirst(end_string, text[start[end]+1:end])
        if end_pos === nothing
            return text
        end
        return text[1:start[1]-1] * text[start[end]+end_pos[end]:end]
    end
end