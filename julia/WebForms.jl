# WebForms.jl 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
# Compatible with WebFormsJS version 2.1

module WebFormsCore

const GS = '\x1d'
const US = '\x1f'

mutable struct WebForms
    data::String
    WebForms() = new("")
end

function add(w::WebForms, name::AbstractString, value::AbstractString)
    if !isempty(w.data)
        w.data *= "\n"
    end

    w.data *= name
    w.data *= "="
    w.data *= value
end

function add(w::WebForms, name::AbstractString)
    if !isempty(w.data)
        w.data *= "\n"
    end

    w.data *= name
end

function add_to_up(w::WebForms, name::AbstractString, value::AbstractString)
    line = string(name, "=", value)

    if !isempty(w.data)
        line *= "\n"
    end

    w.data = line * w.data
end

function add_to_up(w::WebForms, name::AbstractString)
    line = string(name)

    if !isempty(w.data)
        line *= "\n"
    end

    w.data = line * w.data
end

function get_line_by_index(w::WebForms, index::Integer)
    if isempty(w.data)
        return ""
    end

    lines = split(w.data, '\n')

    if index < 0
        index = length(lines) + index
    end

    if index < 0 || index >= length(lines)
        return ""
    end

    return String(lines[index + 1])
end

function update_line_by_index(w::WebForms, index::Integer, name::AbstractString, value::AbstractString)
    if isempty(w.data)
        return
    end

    lines = split(w.data, '\n')

    if index < 0
        index = length(lines) + index
    end

    if index < 0 || index >= length(lines)
        return
    end

    lines[index + 1] = string(name, isempty(value) ? "" : "=" * value)

    w.data = join(lines, "\n")
end

# For Extension
add_line(w::WebForms, name::AbstractString, value::AbstractString) = add(w, name, value)

# Add
# Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.
add_id(w::WebForms, input_place::AbstractString, id::AbstractString) = add(w, "ai" * input_place, id)
add_name(w::WebForms, input_place::AbstractString, name::AbstractString) = add(w, "an" * input_place, name)
add_value(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "av" * input_place, value)
add_class(w::WebForms, input_place::AbstractString, class::AbstractString) = add(w, "ac" * input_place, class)
add_style(w::WebForms, input_place::AbstractString, style::AbstractString) = add(w, "as" * input_place, style)
add_style(w::WebForms, input_place::AbstractString, name::AbstractString, value::AbstractString) = add(w, "as" * input_place, string(name, ':', value))
add_option_tag(w::WebForms, input_place::AbstractString, text::AbstractString, value::AbstractString, selected::Bool=false) = add(w, "ao" * input_place, string(value, GS, text, selected ? string(GS, "1") : ""))
add_check_box_tag(w::WebForms, input_place::AbstractString, text::AbstractString, value::AbstractString, checked::Bool=false) = add(w, "ak" * input_place, string(value, GS, text, checked ? string(GS, "1") : ""))
add_title(w::WebForms, input_place::AbstractString, title::AbstractString) = add(w, "al" * input_place, title)
add_label(w::WebForms, input_place::AbstractString, label::AbstractString) = add(w, "aA" * input_place, label)
add_text(w::WebForms, input_place::AbstractString, text::AbstractString) = add(w, "at" * input_place, replace(text, "\n" => "\$[ln];"))
add_text_to_up(w::WebForms, input_place::AbstractString, text::AbstractString) = add(w, "pt" * input_place, replace(text, "\n" => "\$[ln];"))
add_attribute(w::WebForms, input_place::AbstractString, attribute::AbstractString, value::AbstractString="", splitter::Char='\0') = add(w, "aa" * input_place, string(attribute, GS, splitter != '\0' ? string(splitter) : "", isempty(value) ? "" : string(GS, value)))
add_tag(w::WebForms, input_place::AbstractString, tag_name::AbstractString, id::AbstractString="") = add(w, "nt" * input_place, string(tag_name, isempty(id) ? "" : string(GS, id)))
add_tag_to_up(w::WebForms, input_place::AbstractString, tag_name::AbstractString, id::AbstractString="") = add(w, "ut" * input_place, string(tag_name, isempty(id) ? "" : string(GS, id)))
add_tag_before(w::WebForms, input_place::AbstractString, tag_name::AbstractString, id::AbstractString="") = add(w, "bt" * input_place, string(tag_name, isempty(id) ? "" : string(GS, id)))
add_tag_after(w::WebForms, input_place::AbstractString, tag_name::AbstractString, id::AbstractString="") = add(w, "ft" * input_place, string(tag_name, isempty(id) ? "" : string(GS, id)))
add_hidden(w::WebForms, input_place::AbstractString, name::AbstractString, value::AbstractString, id::AbstractString="") = add(w, "ah" * input_place, string(name, GS, value, isempty(id) ? "" : string(GS, id)))

# Set
# Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.
set_id(w::WebForms, input_place::AbstractString, id::AbstractString) = add(w, "si" * input_place, id)
set_name(w::WebForms, input_place::AbstractString, name::AbstractString) = add(w, "sn" * input_place, name)
set_value(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "sv" * input_place, value)
set_class(w::WebForms, input_place::AbstractString, class::AbstractString) = add(w, "sc" * input_place, class)
set_style(w::WebForms, input_place::AbstractString, style::AbstractString) = add(w, "ss" * input_place, style)
set_style(w::WebForms, input_place::AbstractString, name::AbstractString, value::AbstractString) = add(w, "ss" * input_place, string(name, ':', value))
set_option_tag(w::WebForms, input_place::AbstractString, text::AbstractString, value::AbstractString, selected::Bool=false) = add(w, "so" * input_place, string(value, GS, text, selected ? string(GS, "1") : ""))
set_checked(w::WebForms, input_place::AbstractString, checked::Bool=false) = add(w, "sk" * input_place, checked ? "1" : "0")
set_check_box_tag(w::WebForms, input_place::AbstractString, text::AbstractString, value::AbstractString, checked::Bool=false) = add(w, "sk" * input_place, string(value, GS, text, checked ? string(GS, "1") : ""))
set_title(w::WebForms, input_place::AbstractString, title::AbstractString) = add(w, "sl" * input_place, title)
set_label(w::WebForms, input_place::AbstractString, label::AbstractString) = add(w, "sA" * input_place, label)
set_text(w::WebForms, input_place::AbstractString, text::AbstractString) = add(w, "st" * input_place, replace(text, "\n" => "\$[ln];"))
set_attribute(w::WebForms, input_place::AbstractString, attribute::AbstractString, value::AbstractString="") = add(w, "sa" * input_place, string(attribute, GS, isempty(value) ? "" : string(GS, value)))
set_width(w::WebForms, input_place::AbstractString, width::AbstractString) = add(w, "sw" * input_place, width)
set_width(w::WebForms, input_place::AbstractString, width::Integer) = set_width(w, input_place, string(width, "px"))
set_height(w::WebForms, input_place::AbstractString, height::AbstractString) = add(w, "sh" * input_place, height)
set_height(w::WebForms, input_place::AbstractString, height::Integer) = set_height(w, input_place, string(height, "px"))
set_background_color(w::WebForms, input_place::AbstractString, color::AbstractString) = add(w, "bc" * input_place, color)
set_text_color(w::WebForms, input_place::AbstractString, color::AbstractString) = add(w, "tc" * input_place, color)
set_font_name(w::WebForms, input_place::AbstractString, name::AbstractString) = add(w, "fn" * input_place, name)
set_font_size(w::WebForms, input_place::AbstractString, size::AbstractString) = add(w, "fs" * input_place, size)
set_font_size(w::WebForms, input_place::AbstractString, size::Integer) = add(w, "fs" * input_place, string(size, "px"))
set_font_bold(w::WebForms, input_place::AbstractString, bold::Bool) = add(w, "fb" * input_place, bold ? "1" : "0")
set_visible(w::WebForms, input_place::AbstractString, visible::Bool) = add(w, "vi" * input_place, visible ? "1" : "0")
set_text_align(w::WebForms, input_place::AbstractString, align::AbstractString) = add(w, "ta" * input_place, align)
set_read_only(w::WebForms, input_place::AbstractString, read_only::Bool) = add(w, "sr" * input_place, read_only ? "1" : "0")
set_disabled(w::WebForms, input_place::AbstractString, disabled::Bool) = add(w, "sd" * input_place, disabled ? "1" : "0")
set_focus(w::WebForms, input_place::AbstractString, focus::Bool) = add(w, "sf" * input_place, focus ? "1" : "0")
set_min_length(w::WebForms, input_place::AbstractString, length::AbstractString) = add(w, "mn" * input_place, length)
set_min_length(w::WebForms, input_place::AbstractString, length::Integer) = set_min_length(w, input_place, string(length))
set_max_length(w::WebForms, input_place::AbstractString, length::AbstractString) = add(w, "mx" * input_place, length)
set_max_length(w::WebForms, input_place::AbstractString, length::Integer) = set_max_length(w, input_place, string(length))
set_selected_value(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "ts" * input_place, value)
set_selected_index(w::WebForms, input_place::AbstractString, index::AbstractString) = add(w, "ti" * input_place, index)
set_selected_index(w::WebForms, input_place::AbstractString, index::Integer) = set_selected_index(w, input_place, string(index))
set_checked_value(w::WebForms, input_place::AbstractString, value::AbstractString, checked::Bool) = add(w, "ks" * input_place, string(value, GS, checked ? "1" : "0"))
set_checked_index(w::WebForms, input_place::AbstractString, index::AbstractString, checked::Bool) = add(w, "ki" * input_place, string(index, GS, checked ? "1" : "0"))
set_checked_index(w::WebForms, input_place::AbstractString, index::Integer, checked::Bool) = set_checked_index(w, input_place, string(index), checked)

# Insert
# Creates the Data only if it does not exist; otherwise, does nothing.
insert_id(w::WebForms, input_place::AbstractString, id::AbstractString) = add(w, "ii" * input_place, id)
insert_name(w::WebForms, input_place::AbstractString, name::AbstractString) = add(w, "in" * input_place, name)
insert_value(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "iv" * input_place, value)
insert_class(w::WebForms, input_place::AbstractString, class::AbstractString) = add(w, "ic" * input_place, class)
insert_style(w::WebForms, input_place::AbstractString, style::AbstractString) = add(w, "is" * input_place, style)
insert_style(w::WebForms, input_place::AbstractString, name::AbstractString, value::AbstractString) = add(w, "is" * input_place, string(name, ':', value))
insert_option_tag(w::WebForms, input_place::AbstractString, text::AbstractString, value::AbstractString, selected::Bool=false) = add(w, "io" * input_place, string(value, GS, text, selected ? string(GS, "1") : ""))
insert_check_box_tag(w::WebForms, input_place::AbstractString, text::AbstractString, value::AbstractString, checked::Bool=false) = add(w, "ik" * input_place, string(value, GS, text, checked ? string(GS, "1") : ""))
insert_title(w::WebForms, input_place::AbstractString, title::AbstractString) = add(w, "il" * input_place, title)
insert_label(w::WebForms, input_place::AbstractString, label::AbstractString) = add(w, "iA" * input_place, label)
insert_text(w::WebForms, input_place::AbstractString, text::AbstractString) = add(w, "it" * input_place, replace(text, "\n" => "\$[ln];"))
insert_attribute(w::WebForms, input_place::AbstractString, attribute::AbstractString, value::AbstractString="", splitter::Char='\0') = add(w, "ia" * input_place, string(attribute, GS, splitter != '\0' ? string(splitter) : "", isempty(value) ? "" : string(GS, value)))

# Delete
delete_id(w::WebForms, input_place::AbstractString) = add(w, "di" * input_place)
delete_name(w::WebForms, input_place::AbstractString) = add(w, "dn" * input_place)
delete_value(w::WebForms, input_place::AbstractString) = add(w, "dv" * input_place)
delete_class(w::WebForms, input_place::AbstractString, class_name::AbstractString) = add(w, "dc" * input_place, class_name)
delete_style(w::WebForms, input_place::AbstractString, style_name::AbstractString) = add(w, "ds" * input_place, style_name)
delete_option_tag(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "do" * input_place, value)
delete_all_option_tag(w::WebForms, input_place::AbstractString) = add(w, "do" * input_place, "*")
delete_check_box_tag(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "dk" * input_place, value)
delete_all_check_box_tag(w::WebForms, input_place::AbstractString) = add(w, "dk" * input_place, "*")
delete_title(w::WebForms, input_place::AbstractString) = add(w, "dl" * input_place)
delete_label(w::WebForms, input_place::AbstractString) = add(w, "dA" * input_place)
delete_text(w::WebForms, input_place::AbstractString) = add(w, "dt" * input_place)
delete_attribute(w::WebForms, input_place::AbstractString, attribute::AbstractString) = add(w, "da" * input_place, attribute)
delete(w::WebForms, input_place::AbstractString) = add(w, "de" * input_place)
delete_parent(w::WebForms, input_place::AbstractString) = add(w, "dp" * input_place)

# Tag
swap_tag(w::WebForms, input_place::AbstractString, output_place::AbstractString) = add(w, "sp" * input_place, output_place)
set_reflection(w::WebForms, input_place::AbstractString, tag::AbstractString) = add(w, "sR" * input_place, tag)
set_reflection_by_output_place(w::WebForms, input_place::AbstractString, output_place::AbstractString) = add(w, "iR" * input_place, output_place)
set_morph(w::WebForms, input_place::AbstractString, tag::AbstractString) = add(w, "sM" * input_place, tag)
set_morph_by_output_place(w::WebForms, input_place::AbstractString, output_place::AbstractString) = add(w, "iM" * input_place, output_place)

# Browser
change_url(w::WebForms, url::AbstractString) = add(w, "cu", url)
set_head_title(w::WebForms, title::AbstractString) = add(w, "ht", title)
clipboard_write_text(w::WebForms, text::AbstractString) = add(w, "nw", text)
scroll_to(w::WebForms, x::AbstractString, y::AbstractString) = add(w, "ws", string(x, GS, y))
scroll_to(w::WebForms, x::Integer, y::Integer) = scroll_to(w, string(x), string(y))
history_go(w::WebForms, steps::AbstractString) = add(w, "wg", steps)
history_go(w::WebForms, steps::Integer) = history_go(w, string(steps))
reload_page(w::WebForms) = add(w, "lr")
redirect(w::WebForms, path::AbstractString) = add(w, "lh", path)

# Increase
increase_min_length(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "+n" * input_place, value)
increase_min_length(w::WebForms, input_place::AbstractString, value::Integer) = increase_min_length(w, input_place, string(value))
increase_max_length(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "+x" * input_place, value)
increase_max_length(w::WebForms, input_place::AbstractString, value::Integer) = increase_max_length(w, input_place, string(value))
increase_font_size(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "+f" * input_place, value)
increase_font_size(w::WebForms, input_place::AbstractString, value::Integer) = increase_font_size(w, input_place, string(value))
increase_width(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "+w" * input_place, value)
increase_width(w::WebForms, input_place::AbstractString, value::Integer) = increase_width(w, input_place, string(value))
increase_height(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "+h" * input_place, value)
increase_height(w::WebForms, input_place::AbstractString, value::Integer) = increase_height(w, input_place, string(value))
increase_value(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "+v" * input_place, value)
increase_value(w::WebForms, input_place::AbstractString, value::Integer) = increase_value(w, input_place, string(value))

# Decrease
decrease_min_length(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "-n" * input_place, value)
decrease_min_length(w::WebForms, input_place::AbstractString, value::Integer) = decrease_min_length(w, input_place, string(value))
decrease_max_length(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "-x" * input_place, value)
decrease_max_length(w::WebForms, input_place::AbstractString, value::Integer) = decrease_max_length(w, input_place, string(value))
decrease_font_size(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "-f" * input_place, value)
decrease_font_size(w::WebForms, input_place::AbstractString, value::Integer) = decrease_font_size(w, input_place, string(value))
decrease_width(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "-w" * input_place, value)
decrease_width(w::WebForms, input_place::AbstractString, value::Integer) = decrease_width(w, input_place, string(value))
decrease_height(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "-h" * input_place, value)
decrease_height(w::WebForms, input_place::AbstractString, value::Integer) = decrease_height(w, input_place, string(value))
decrease_value(w::WebForms, input_place::AbstractString, value::AbstractString) = add(w, "-v" * input_place, value)
decrease_value(w::WebForms, input_place::AbstractString, value::Integer) = decrease_value(w, input_place, string(value))

# Event
# ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
# All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.
trigger_event(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, constructor_name::Union{Nothing, AbstractString}=nothing) = add(w, "TE" * input_place, string(html_event_listener, !isnothing(constructor_name) && !isempty(constructor_name) ? string(GS, constructor_name) : ""))
set_post_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Ep" * input_place, html_event)
set_post_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, output_place::AbstractString) = add(w, "Ep" * input_place, string(html_event, GS, output_place))
set_post_event_add_view(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Ep" * input_place, string(html_event, GS, "+"))
set_post_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "EP" * input_place, html_event_listener)
set_post_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, output_place::AbstractString) = add(w, "EP" * input_place, string(html_event_listener, GS, output_place))
set_post_event_listener_add_view(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "EP" * input_place, string(html_event_listener, GS, "+"))
set_get_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "Eg" * input_place, string(html_event, GS, !isnothing(path) && !isempty(path) ? path : "#"))
set_get_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, output_place::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "Eg" * input_place, string(html_event, GS, !isnothing(path) && !isempty(path) ? path : "#", GS, output_place))
set_get_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "EG" * input_place, string(html_event_listener, GS, !isnothing(path) && !isempty(path) ? path : "#"))
set_get_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, output_place::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "EG" * input_place, string(html_event_listener, GS, !isnothing(path) && !isempty(path) ? path : "#", GS, output_place))
set_put_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "Et" * input_place, string(html_event, GS, !isnothing(path) && !isempty(path) ? path : "#"))
set_put_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, output_place::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "Et" * input_place, string(html_event, GS, !isnothing(path) && !isempty(path) ? path : "#", GS, output_place))
set_put_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "ET" * input_place, string(html_event_listener, GS, !isnothing(path) && !isempty(path) ? path : "#"))
set_put_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, output_place::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "ET" * input_place, string(html_event_listener, GS, !isnothing(path) && !isempty(path) ? path : "#", GS, output_place))
set_patch_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "Ea" * input_place, string(html_event, GS, !isnothing(path) && !isempty(path) ? path : "#"))
set_patch_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, output_place::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "Ea" * input_place, string(html_event, GS, !isnothing(path) && !isempty(path) ? path : "#", GS, output_place))
set_patch_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "EA" * input_place, string(html_event_listener, GS, !isnothing(path) && !isempty(path) ? path : "#"))
set_patch_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, output_place::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "EA" * input_place, string(html_event_listener, GS, !isnothing(path) && !isempty(path) ? path : "#", GS, output_place))
set_delete_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "El" * input_place, string(html_event, GS, !isnothing(path) && !isempty(path) ? path : "#"))
set_delete_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, output_place::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "El" * input_place, string(html_event, GS, !isnothing(path) && !isempty(path) ? path : "#", GS, output_place))
set_delete_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "EL" * input_place, string(html_event_listener, GS, !isnothing(path) && !isempty(path) ? path : "#"))
set_delete_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, output_place::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "EL" * input_place, string(html_event_listener, GS, !isnothing(path) && !isempty(path) ? path : "#", GS, output_place))
set_options_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "Eo" * input_place, string(html_event, GS, !isnothing(path) && !isempty(path) ? path : "#"))
set_options_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, output_place::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "Eo" * input_place, string(html_event, GS, !isnothing(path) && !isempty(path) ? path : "#", GS, output_place))
set_options_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "EO" * input_place, string(html_event_listener, GS, !isnothing(path) && !isempty(path) ? path : "#"))
set_options_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, output_place::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "EO" * input_place, string(html_event_listener, GS, !isnothing(path) && !isempty(path) ? path : "#", GS, output_place))
set_head_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "Eh" * input_place, string(html_event, GS, !isnothing(path) && !isempty(path) ? path : "#"))
set_head_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "EH" * input_place, string(html_event_listener, GS, !isnothing(path) && !isempty(path) ? path : "#"))
# IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
set_send_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, data::AbstractString, path::Union{Nothing, AbstractString}=nothing, method::AbstractString="POST", is_multi_part::Bool=false, content_type::AbstractString="text/plain", output_place::Union{Nothing, AbstractString}=nothing) = add(w, "En" * input_place, string(html_event, GS, replace(replace(replace(data, "\n" => "\$[ln];"), "\"" => "\$[dq];"), "'" => "\$[sq];"), GS, !isnothing(path) && !isempty(path) ? path : "#", GS, method, GS, is_multi_part ? "1" : "0", GS, content_type, GS, output_place))
set_send_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, data::AbstractString, path::Union{Nothing, AbstractString}=nothing, method::AbstractString="POST", is_multi_part::Bool=false, content_type::AbstractString="text/plain", output_place::Union{Nothing, AbstractString}=nothing) = add(w, "EN" * input_place, string(html_event_listener, GS, replace(data, "\n" => "\$[ln];"), GS, !isnothing(path) && !isempty(path) ? path : "#", GS, method, GS, is_multi_part ? "1" : "0", GS, content_type, GS, output_place))
set_comment_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, index::Union{Nothing, AbstractString}=nothing, output_place::Union{Nothing, AbstractString}=nothing) = add(w, "Eb" * input_place, string(html_event, GS, index, GS, output_place))
set_comment_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, index::Integer, output_place::Union{Nothing, AbstractString}=nothing) = set_comment_event(w, input_place, html_event, string(index), output_place)
set_comment_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, index::Union{Nothing, AbstractString}=nothing, output_place::Union{Nothing, AbstractString}=nothing) = add(w, "EB" * input_place, string(html_event_listener, GS, index, GS, output_place))
set_comment_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, index::Integer, output_place::Union{Nothing, AbstractString}=nothing) = set_comment_event_listener(w, input_place, html_event_listener, string(index), output_place)

function set_wasm_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, wasm_language::AbstractString, wasm_url::AbstractString, method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing, output_place::Union{Nothing, AbstractString}=nothing)
    args_join = ""

    if !isnothing(args)
        args_join = (length(args) > 0) ? "[" * join(args, US) : ""
    end

    add(w, "Ey" * input_place, string(html_event, GS, wasm_language, GS, wasm_url, GS, method_name, GS, args_join, GS, output_place))
end

function set_wasm_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, wasm_language::AbstractString, wasm_url::AbstractString, method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing, output_place::Union{Nothing, AbstractString}=nothing)
    args_join = ""

    if !isnothing(args)
        args_join = (length(args) > 0) ? "[" * join(args, US) : ""
    end

    add(w, "EY" * input_place, string(html_event_listener, GS, wasm_language, GS, wasm_url, GS, method_name, GS, args_join, GS, output_place))
end

set_web_socket_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, path::AbstractString) = add(w, "Ew" * input_place, string(html_event, GS, path))
set_web_socket_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, path::AbstractString) = add(w, "EW" * input_place, string(html_event_listener, GS, path))
set_sse_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, path::AbstractString, should_reconnect::Bool=true, reconnect_try_timeout::Integer=3000) = add(w, "Ee" * input_place, string(html_event, GS, path, GS, should_reconnect ? "1" : "0", GS, reconnect_try_timeout))
set_sse_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, path::AbstractString, output_place::AbstractString, should_reconnect::Bool=true, reconnect_try_timeout::Integer=3000) = add(w, "Ee" * input_place, string(html_event, GS, path, GS, should_reconnect ? "1" : "0", GS, reconnect_try_timeout, GS, output_place))
set_sse_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, path::AbstractString, should_reconnect::Bool=true, reconnect_try_timeout::Integer=3000) = add(w, "EE" * input_place, string(html_event_listener, GS, path, GS, should_reconnect ? "1" : "0", GS, reconnect_try_timeout))
set_sse_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, path::AbstractString, output_place::AbstractString, should_reconnect::Bool=true, reconnect_try_timeout::Integer=3000) = add(w, "EE" * input_place, string(html_event_listener, GS, path, GS, should_reconnect ? "1" : "0", GS, reconnect_try_timeout, GS, output_place))

function set_front_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, module_path::AbstractString, args::Union{Nothing, Vector{Any}}=nothing, output_place::Union{Nothing, AbstractString}=nothing)
    args_join = ""

    if !isnothing(args)
        args_join = (length(args) > 0) ? string(GS, "[") * join(args, US) : ""
    end

    add(w, "Ej" * input_place, string(html_event, GS, module_path, GS, output_place, args_join))
end

function set_front_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, module_path::AbstractString, args::Union{Nothing, Vector{Any}}=nothing, output_place::Union{Nothing, AbstractString}=nothing)
    args_join = ""

    if !isnothing(args)
        args_join = (length(args) > 0) ? string(GS, "[") * join(args, US) : ""
    end

    add(w, "EJ" * input_place, string(html_event_listener, GS, module_path, GS, output_place, args_join))
end

set_master_pages_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, output_place::Union{Nothing, AbstractString}=nothing) = add(w, "Eu" * input_place, string(html_event, GS, output_place))
set_master_pages_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, output_place::Union{Nothing, AbstractString}=nothing) = add(w, "EU" * input_place, string(html_event_listener, GS, output_place))
set_prevent_default_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Ed" * input_place, html_event)
set_prevent_default_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "ED" * input_place, html_event_listener)
set_stop_propagation_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Es" * input_place, html_event)
set_stop_propagation_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "ES" * input_place, html_event_listener)

function set_method_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing)
    args_join = ""

    if !isnothing(args)
        args_join = (length(args) > 0) ? string(GS, "[") * join(args, US) : ""
    end

    add(w, "Em" * input_place, string(html_event, GS, method_name, args_join))
end

function set_method_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing)
    args_join = ""

    if !isnothing(args)
        args_join = (length(args) > 0) ? string(GS, "[") * join(args, US) : ""
    end

    add(w, "EM" * input_place, string(html_event_listener, GS, method_name, args_join))
end

function set_module_method_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing)
    args_join = ""

    if !isnothing(args)
        args_join = (length(args) > 0) ? string(GS, "[") * join(args, US) : ""
    end

    add(w, "Ex" * input_place, string(html_event, GS, method_name, args_join))
end

function set_module_method_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing)
    args_join = ""

    if !isnothing(args)
        args_join = (length(args) > 0) ? string(GS, "[") * join(args, US) : ""
    end

    add(w, "EX" * input_place, string(html_event_listener, GS, method_name, args_join))
end

assign_confirm_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, text::AbstractString="Are you sure you want to proceed?", type::AbstractString="none", title::AbstractString="Confirm", ok_text::AbstractString="OK", cancel_text::AbstractString="Cancel") = add(w, "Ef" * input_place, string(html_event, GS, text == "Are you sure you want to proceed?" ? "" : text, GS, type == "none" ? "" : type, GS, title == "Confirm" ? "" : title, GS, ok_text == "OK" ? "" : ok_text, GS, cancel_text == "Cancel" ? "" : cancel_text))
remove_post_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Rp" * input_place, html_event)
remove_post_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RP" * input_place, html_event_listener)
remove_get_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Rg" * input_place, html_event)
remove_get_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RG" * input_place, html_event_listener)
remove_put_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Rt" * input_place, html_event)
remove_put_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RT" * input_place, html_event_listener)
remove_patch_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Ra" * input_place, html_event)
remove_patch_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RA" * input_place, html_event_listener)
remove_delete_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Rl" * input_place, html_event)
remove_delete_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RL" * input_place, html_event_listener)
remove_options_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Ro" * input_place, html_event)
remove_options_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RO" * input_place, html_event_listener)
remove_head_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Rh" * input_place, html_event)
remove_head_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RH" * input_place, html_event_listener)
remove_send_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Rn" * input_place, html_event)
remove_send_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RN" * input_place, html_event_listener)
remove_comment_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Rb" * input_place, html_event)
remove_comment_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RB" * input_place, html_event_listener)
remove_wasm_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Ry" * input_place, html_event)
remove_wasm_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RY" * input_place, html_event_listener)
remove_web_socket_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Rw" * input_place, html_event)
remove_web_socket_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RW" * input_place, html_event_listener)
remove_sse_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Re" * input_place, html_event)
remove_sse_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RE" * input_place, html_event_listener)
remove_front_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Rj" * input_place, html_event)
remove_front_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RJ" * input_place, html_event_listener)
remove_prevent_default_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Rd" * input_place, html_event)
remove_prevent_default_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RD" * input_place, html_event_listener)
remove_master_pages_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Ru" * input_place, html_event)
remove_master_pages_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RU" * input_place, html_event_listener)
remove_stop_propagation_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Rs" * input_place, html_event)
remove_stop_propagation_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString) = add(w, "RS" * input_place, html_event_listener)
remove_method_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, method_name::AbstractString) = add(w, "Rm" * input_place, string(html_event, GS, method_name))
remove_method_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, method_name::AbstractString) = add(w, "RM" * input_place, string(html_event_listener, GS, method_name))
remove_module_method_event(w::WebForms, input_place::AbstractString, html_event::AbstractString, method_name::AbstractString) = add(w, "Rx" * input_place, string(html_event, GS, method_name))
remove_module_method_event_listener(w::WebForms, input_place::AbstractString, html_event_listener::AbstractString, method_name::AbstractString) = add(w, "RX" * input_place, string(html_event_listener, GS, method_name))
remove_confirm_event(w::WebForms, input_place::AbstractString, html_event::AbstractString) = add(w, "Rf" * input_place, html_event)

# Custom Event
# This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
# Watch: attribute, style, text, children, value
# Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
# Range: Only Use For Compare With inrange Value. Split By Comma ","
# Key: Only Use For Watch With attribute And style Value
create_custom_dom_event(w::WebForms, input_place::AbstractString, event_name::AbstractString, watch::AbstractString, key::AbstractString, compare::AbstractString, value::AbstractString, range::AbstractString, immediate::Bool=false, delay::AbstractString="0") = add(w, "eC" * input_place, string(event_name, GS, watch, GS, key, GS, compare, GS, value, GS, range, GS, immediate ? "1" : "0", GS, delay))
create_custom_dom_event(w::WebForms, input_place::AbstractString, event_name::AbstractString, watch::AbstractString, key::AbstractString, compare::AbstractString, value::AbstractString, range::AbstractString, immediate::Bool, delay::Integer) = create_custom_dom_event(w, input_place, event_name, watch, key, compare, value, range, immediate, string(delay))
enable_scroll_bottom_event(w::WebForms, enable::Bool=true) = add(w, "eb", enable ? "1" : "0")
enable_reached_element_event(w::WebForms, input_place::AbstractString, once::Bool, enable::Bool=true) = add(w, "er" * input_place, string(once ? "1" : "0", GS, enable ? "1" : "0"))

# Module
function load_module(w::WebForms, module_path::AbstractString, methods::Union{Nothing, Vector{String}}=nothing)
    if isnothing(methods)
        methods = String[]
    end
    add(w, "Ml", module_path * ((length(methods) > 0) ? string(GS, "[") * join(methods, US) : ""))
end
unload_module(w::WebForms, module_path::AbstractString) = add(w, "Mu", module_path)
delete_module_method(w::WebForms, method_name::AbstractString) = add(w, "Md", method_name)

# Unit Testing
# InputPlace Is Actual, Expected Is Tag/OutputPlace
assert_equal(w::WebForms, input_place::AbstractString, tag::AbstractString) = add(w, "At" * input_place, replace(tag, "\n" => "\$[ln];"))
assert_equal_by_output_place(w::WebForms, input_place::AbstractString, output_place::AbstractString) = add(w, "Ao" * input_place, output_place)

# Debug
create_debugger(w::WebForms, pause::Bool=false) = add(w, "Dc", pause ? "1" : "0")

# Service Worker
# To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
service_worker_register(w::WebForms, path::Union{Nothing, AbstractString}=nothing, scope_path::Union{Nothing, AbstractString}=nothing) = add(w, "wR", string(path, GS, scope_path))
service_worker_pre_cache_static(w::WebForms, path_list::Vector{String}) = add(w, "wp", join(path_list, GS))
service_worker_dynamic_cache(w::WebForms, path::AbstractString, seconds::AbstractString="") = add(w, "wc", path * (seconds != "" ? string(GS, seconds) : ""))
service_worker_dynamic_cache(w::WebForms, path::AbstractString, seconds::Integer) = service_worker_dynamic_cache(w, path, seconds > 0 ? string(seconds) : "")
service_worker_delete_dynamic_cache(w::WebForms) = add(w, "wd")
service_worker_delete_dynamic_cache(w::WebForms, path::AbstractString) = add(w, "wd", path)
service_worker_dynamic_cache_ttl_update(w::WebForms, path::AbstractString, seconds::AbstractString="") = add(w, "wt", path * (seconds != "" ? string(GS, seconds) : ""))
service_worker_dynamic_cache_ttl_update(w::WebForms, path::AbstractString, seconds::Integer) = service_worker_dynamic_cache_ttl_update(w, path, seconds > 0 ? string(seconds) : "")
# Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
# Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
# CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
service_worker_route_set(w::WebForms, path::AbstractString, type::AbstractString, cache_dynamic::Bool=false) = add(w, "wr", string(path, GS, type, cache_dynamic ? string(GS, "1") : ""))
service_worker_route_alias(w::WebForms, path::AbstractString, to::AbstractString) = add(w, "wa", string(path, GS, to))
service_worker_delete_route_alias(w::WebForms, path::Union{Nothing, AbstractString}=nothing) = add(w, "wC", path)
# Delete All Route And Alias
service_worker_delete_route(w::WebForms) = add(w, "wD")
service_worker_delete_route(w::WebForms, path::AbstractString) = add(w, "wD", path)

# SSE
disconnect_sse(w::WebForms, path::AbstractString) = add(w, "Ds", path)
disconnect_all_sse(w::WebForms) = add(w, "Ds")

# State
add_state(w::WebForms, path::Union{Nothing, AbstractString}=nothing, title::Union{Nothing, AbstractString}=nothing) = add(w, "AS", string(path, GS, title))
save_state(w::WebForms, path::Union{Nothing, AbstractString}=nothing, title::Union{Nothing, AbstractString}=nothing) = add(w, "As", string(path, GS, title))
load_state(w::WebForms, path::AbstractString) = add(w, "ls", path)
delete_state(w::WebForms, path::Union{Nothing, AbstractString}=nothing) = add(w, "DS", path)
delete_all_state(w::WebForms) = add(w, "DS", "*")

# Cookie
set_cookie(w::WebForms, key::AbstractString, value::AbstractString, seconds::AbstractString, path::Union{Nothing, AbstractString}=nothing) = add(w, "sC", string(key, GS, value, GS, seconds, !isnothing(path) && !isempty(path) ? string(GS, path) : ""))
set_cookie(w::WebForms, key::AbstractString, value::AbstractString, seconds::Integer, path::Union{Nothing, AbstractString}=nothing) = set_cookie(w, key, value, string(seconds), path)

# Save (Session Cache)
save_id(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gi" * input_place, key)
save_name(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gn" * input_place, key)
save_value(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gv" * input_place, key)
save_value_length(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@ge" * input_place, key)
save_class(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gc" * input_place, key)
save_style(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gs" * input_place, key)
save_title(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gl" * input_place, key)
save_label(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gA" * input_place, key)
save_text(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gt" * input_place, key)
save_outer_text(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@go" * input_place, key)
save_text_length(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gg" * input_place, key)
save_attribute(w::WebForms, input_place::AbstractString, attribute::AbstractString, key::AbstractString=".") = add(w, "@ga" * input_place, string(key, GS, attribute))
save_width(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gw" * input_place, key)
save_height(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gh" * input_place, key)
save_read_only(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gr" * input_place, key)
save_selected_index(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gx" * input_place, key)
save_text_align(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gT" * input_place, key)
save_node_length(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gL" * input_place, key)
save_visible(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gV" * input_place, key)
save_url(w::WebForms, url::AbstractString, fetch_script::Bool=false, key::AbstractString=".") = add(w, "@gu", string(key, GS, url, fetch_script ? string(GS, "1") : ""))
save_index(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@gI" * input_place, key)
remove_save(w::WebForms, cache_key::AbstractString) = add(w, "rs", cache_key)
remove_all_save(w::WebForms) = add(w, "rs", "*")
# Calling the SetSave Method Causes Action Control Requests Triggered by Events Using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send Event, to be Temporarily Saved on the Active Page, so the Request will not be Sent to the Server Again.
set_save(w::WebForms) = add(w, "cs", "*")
add_save_value(w::WebForms, cache_key::AbstractString, value::AbstractString) = add(w, "SA", string(cache_key, GS, replace(value, "\n" => "\$[ln];")))
insert_save_value(w::WebForms, cache_key::AbstractString, value::AbstractString) = add(w, "SI", string(cache_key, GS, replace(value, "\n" => "\$[ln];")))
append_save_value(w::WebForms, cache_key::AbstractString, value::AbstractString) = add(w, "SP", string(cache_key, GS, replace(value, "\n" => "\$[ln];")))
replace_save_value(w::WebForms, cache_key::AbstractString, search_value::AbstractString, value::AbstractString) = add(w, "SR", string(cache_key, GS, replace(value, "\n" => "\$[ln];"), GS, replace(search_value, "\n" => "\$[ln];")))

# Cache
cache_id(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@ci" * input_place, key)
cache_name(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cn" * input_place, key)
cache_value(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cv" * input_place, key)
cache_value_length(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@ce" * input_place, key)
cache_class(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cc" * input_place, key)
cache_style(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cs" * input_place, key)
cache_title(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cl" * input_place, key)
cache_label(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cA" * input_place, key)
cache_text(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@ct" * input_place, key)
cache_outer_text(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@co" * input_place, key)
cache_text_length(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cg" * input_place, key)
cache_attribute(w::WebForms, input_place::AbstractString, attribute::AbstractString, key::AbstractString=".") = add(w, "@ca" * input_place, string(key, GS, attribute))
cache_width(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cw" * input_place, key)
cache_height(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@ch" * input_place, key)
cache_read_only(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cr" * input_place, key)
cache_selected_index(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cx" * input_place, key)
cache_text_align(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cT" * input_place, key)
cache_node_length(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cL" * input_place, key)
cache_visible(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cV" * input_place, key)
cache_url(w::WebForms, url::AbstractString, fetch_script::Bool=false, key::AbstractString=".") = add(w, "@cu", string(key, GS, url, fetch_script ? string(GS, "1") : ""))
cache_index(w::WebForms, input_place::AbstractString, key::AbstractString=".") = add(w, "@cI" * input_place, key)
remove_cache(w::WebForms, cache_key::AbstractString) = add(w, "rd", cache_key)
remove_all_cache(w::WebForms) = add(w, "rd", "*")
# Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
set_cache(w::WebForms, second::AbstractString) = add(w, "cd", second)
set_cache(w::WebForms, second::Integer) = set_cache(w, string(second))
set_cache(w::WebForms) = add(w, "cd", "*")
add_cache_value(w::WebForms, cache_key::AbstractString, value::AbstractString) = add(w, "CA", string(cache_key, GS, replace(value, "\n" => "\$[ln];")))
insert_cache_value(w::WebForms, cache_key::AbstractString, value::AbstractString) = add(w, "CI", string(cache_key, GS, replace(value, "\n" => "\$[ln];")))
append_cache_value(w::WebForms, cache_key::AbstractString, value::AbstractString) = add(w, "CP", string(cache_key, GS, replace(value, "\n" => "\$[ln];")))
replace_cache_value(w::WebForms, cache_key::AbstractString, search_value::AbstractString, value::AbstractString) = add(w, "CR", string(cache_key, GS, replace(value, "\n" => "\$[ln];"), GS, replace(search_value, "\n" => "\$[ln];")))

# Call
load_url(w::WebForms, input_place::AbstractString, url::AbstractString) = add(w, "lu" * input_place, url)
run_action_controls(w::WebForms, action_controls::AbstractString, without_web_forms_section::Bool=true, index::Union{Nothing, AbstractString}=nothing, use_current_event::Bool=true) = add(w, "lA", string(use_current_event ? "1" : "0", GS, without_web_forms_section ? "1" : "0", GS, index, GS, action_controls))
call_script(w::WebForms, script_text::AbstractString) = add(w, "_", replace(script_text, "\n" => "\$[ln];"))

function call_method(w::WebForms, method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing)
    args_join = ""

    if !isnothing(args)
        args_join = (length(args) > 0) ? string(GS, "[") * join(args, US) : ""
    end

    add(w, "lm", method_name * args_join)
end

function call_module_method(w::WebForms, method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing)
    args_join = ""

    if !isnothing(args)
        args_join = (length(args) > 0) ? string(GS, "[") * join(args, US) : ""
    end

    add(w, "lM", method_name * args_join)
end

call_post_back(w::WebForms, form_input_place::AbstractString, output_place::Union{Nothing, AbstractString}=nothing) = add(w, "Lp", "1" * string(GS, form_input_place, (!isnothing(output_place) && !isempty(output_place)) ? string(GS, output_place) : ""))
call_comment_back(w::WebForms, index::Union{Nothing, AbstractString}=nothing, input_place::Union{Nothing, AbstractString}=nothing, use_current_event::Bool=true) = add(w, "LC", string(use_current_event ? "1" : "0", GS, index, GS, input_place))
call_comment_back(w::WebForms, index::Integer, input_place::Union{Nothing, AbstractString}=nothing, use_current_event::Bool=true) = call_comment_back(w, string(index), input_place, use_current_event)

function call_wasm_back(w::WebForms, wasm_language::AbstractString, wasm_url::AbstractString, method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing, output_place::Union{Nothing, AbstractString}=nothing, use_current_event::Bool=true)
    args_join = ""

    if !isnothing(args)
        args_join = (length(args) > 0) ? "[" * join(args, US) : ""
    end

    add(w, "Ly", string(use_current_event ? "1" : "0", GS, wasm_language, GS, wasm_url, GS, method_name, GS, args_join, GS, output_place))
end

call_web_socket_back(w::WebForms, path::AbstractString, use_current_event::Bool=true) = add(w, "Lw", string(use_current_event ? "1" : "0", GS, path))
call_sse_back(w::WebForms, path::AbstractString, output_place::Union{Nothing, AbstractString}=nothing, use_current_event::Bool=true, should_reconnect::Bool=true, reconnect_try_timeout::AbstractString="3000") = add(w, "Ls", string(use_current_event ? "1" : "0", GS, path, GS, should_reconnect ? "1" : "0", GS, reconnect_try_timeout, (!isnothing(output_place) && !isempty(output_place)) ? string(GS, output_place) : ""))
call_sse_back(w::WebForms, path::AbstractString, output_place::AbstractString, use_current_event::Bool, should_reconnect::Bool, reconnect_try_timeout::Integer) = call_sse_back(w, path, output_place, use_current_event, should_reconnect, string(reconnect_try_timeout))

function call_front(w::WebForms, module_path::AbstractString, args::Union{Nothing, Vector{Any}}=nothing, output_place::Union{Nothing, AbstractString}=nothing, use_current_event::Bool=true)
    args_join = ""

    if !isnothing(args)
        args_join = (length(args) > 0) ? string(GS, "[") * join(args, US) : ""
    end

    add(w, "Lj", string(use_current_event ? "1" : "0", GS, module_path, GS, output_place, args_join))
end

call_get_back(w::WebForms, path::AbstractString, output_place::Union{Nothing, AbstractString}=nothing, use_current_event::Bool=true) = add(w, "Lg", string(use_current_event ? "1" : "0", GS, path, (!isnothing(output_place) && !isempty(output_place)) ? string(GS, output_place) : ""))
call_put_back(w::WebForms, path::AbstractString, output_place::Union{Nothing, AbstractString}=nothing, use_current_event::Bool=true) = add(w, "Lt", string(use_current_event ? "1" : "0", GS, path, (!isnothing(output_place) && !isempty(output_place)) ? string(GS, output_place) : ""))
call_patch_back(w::WebForms, path::AbstractString, output_place::Union{Nothing, AbstractString}=nothing, use_current_event::Bool=true) = add(w, "LP", string(use_current_event ? "1" : "0", GS, path, (!isnothing(output_place) && !isempty(output_place)) ? string(GS, output_place) : ""))
call_delete_back(w::WebForms, path::AbstractString, output_place::Union{Nothing, AbstractString}=nothing, use_current_event::Bool=true) = add(w, "Ld", string(use_current_event ? "1" : "0", GS, path, (!isnothing(output_place) && !isempty(output_place)) ? string(GS, output_place) : ""))
call_head_back(w::WebForms, path::AbstractString, use_current_event::Bool=true) = add(w, "Lh", string(use_current_event ? "1" : "0", GS, path))
call_options_back(w::WebForms, path::AbstractString, output_place::Union{Nothing, AbstractString}=nothing, use_current_event::Bool=true) = add(w, "Lo", string(use_current_event ? "1" : "0", GS, path, (!isnothing(output_place) && !isempty(output_place)) ? string(GS, output_place) : ""))
call_send_back(w::WebForms, path::AbstractString, method::AbstractString, is_multi_part::Bool, content_type::AbstractString, data::AbstractString, output_place::Union{Nothing, AbstractString}=nothing, use_current_event::Bool=true) = add(w, "LS", string(use_current_event ? "1" : "0", GS, path, GS, method, GS, is_multi_part ? "1" : "0", GS, content_type, GS, replace(data, "\n" => "\$[ln];"), (!isnothing(output_place) && !isempty(output_place)) ? string(GS, output_place) : ""))

# Update
increase(w::WebForms, input_place::AbstractString, value::Float64) = add(w, "gt" * input_place, "i" * string(GS, value))
decrease(w::WebForms, input_place::AbstractString, value::Float64) = add(w, "gt" * input_place, "i" * string(GS, value * -1))
# If You Don't Use Deep Mode, any Tags Inside the Current Tag Will Simply Be Treated as Strings. Deep Mode Does not Remove Inner Elements.
replace_(w::WebForms, input_place::AbstractString, value::AbstractString, new_value::AbstractString, also_start_tag::Bool=false, deep::Bool=true) = add(w, "gt" * input_place, string("r", GS, value, GS, new_value, GS, also_start_tag ? "1" : "0", GS, deep ? "1" : "0"))
# HTML Converts Attribute Names to Lowercase, so they Need to Be Written in Lowercase.
replace_start_tag(w::WebForms, input_place::AbstractString, value::AbstractString, new_value::AbstractString) = add(w, "gt" * input_place, string("s", GS, value, GS, new_value))

# Pre Runner
function assign_delay(w::WebForms, mili_second::Integer, index::Integer=-1)
    current_line = get_line_by_index(w, index)
    if isempty(current_line)
        return
    end

    parts = split(current_line, '='; limit=2)
    new_name = ":" * string(mili_second) * ")" * parts[1]
    new_value = length(parts) > 1 ? String(parts[2]) : ""

    update_line_by_index(w, index, new_name, new_value)
end

function assign_delay_change(w::WebForms, mili_second::Integer, index::Integer=-1)
    current_line = get_line_by_index(w, index)
    if isempty(current_line)
        return
    end

    parts = split(current_line, '='; limit=2)
    current_name = String(parts[1])

    if startswith(current_name, ":") && occursin(")", current_name)
        closing_bracket = findfirst(')', current_name)
        current_name = current_name[closing_bracket + 1:end]
    end

    new_name = ":" * string(mili_second) * ")" * current_name
    new_value = length(parts) > 1 ? String(parts[2]) : ""

    update_line_by_index(w, index, new_name, new_value)
end

function assign_interval(w::WebForms, mili_second::Integer, id::Union{Nothing, AbstractString}=nothing, index::Integer=-1)
    current_line = get_line_by_index(w, index)
    if isempty(current_line)
        return
    end

    parts = split(current_line, '='; limit=2)
    new_name = "(" * string(mili_second) * ((!isnothing(id) && !isempty(id)) ? "|" * id : "") * ")" * parts[1]
    new_value = length(parts) > 1 ? String(parts[2]) : ""

    update_line_by_index(w, index, new_name, new_value)
end

function assign_interval_change(w::WebForms, mili_second::Integer, id::Union{Nothing, AbstractString}=nothing, index::Integer=-1)
    current_line = get_line_by_index(w, index)
    if isempty(current_line)
        return
    end

    parts = split(current_line, '='; limit=2)
    current_name = String(parts[1])

    if startswith(current_name, "(") && occursin(")", current_name)
        closing_bracket = findfirst(')', current_name)
        current_name = current_name[closing_bracket + 1:end]
    end

    new_name = "(" * string(mili_second) * ((!isnothing(id) && !isempty(id)) ? "|" * id : "") * ")" * current_name
    new_value = length(parts) > 1 ? String(parts[2]) : ""

    update_line_by_index(w, index, new_name, new_value)
end

delete_interval(w::WebForms, id::AbstractString) = add(w, "Di", id)

function assign_repeat(w::WebForms, count::Integer, index::Integer=-1)
    current_line = get_line_by_index(w, index)
    if isempty(current_line)
        return
    end

    parts = split(current_line, '='; limit=2)
    new_name = "," * string(count) * ")" * parts[1]
    new_value = length(parts) > 1 ? String(parts[2]) : ""

    update_line_by_index(w, index, new_name, new_value)
end

function assign_repeat_change(w::WebForms, count::Integer, index::Integer=-1)
    current_line = get_line_by_index(w, index)
    if isempty(current_line)
        return
    end

    parts = split(current_line, '='; limit=2)
    current_name = String(parts[1])

    if startswith(current_name, ",") && occursin(")", current_name)
        closing_bracket = findfirst(')', current_name)
        current_name = current_name[closing_bracket + 1:end]
    end

    new_name = "," * string(count) * ")" * current_name
    new_value = length(parts) > 1 ? String(parts[2]) : ""

    update_line_by_index(w, index, new_name, new_value)
end

# Index
start_index(w::WebForms, name::AbstractString) = add(w, "#", name)
start_index(w::WebForms) = start_index(w, "")
# This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
start_state(w::WebForms) = start_index(w, "\$")
go_to(w::WebForms, line::AbstractString, repeat::AbstractString) = add(w, "&", string(line, GS, repeat))
go_to(w::WebForms, line::Integer, repeat::Integer=1) = go_to(w, string(line), string(repeat))
go_to(w::WebForms, index::AbstractString, repeat::Integer=1) = add(w, "&", string("#", index, GS, repeat))

# Start
start_transient_dom(w::WebForms, input_place::AbstractString) = add(w, "td", input_place)
end_transient_dom(w::WebForms) = add(w, "td", ";")

# Message
# Type: warning, problem, help, success, none
alert_(w::WebForms, text::AbstractString, type::AbstractString="none", title::AbstractString="Alert", ok_text::AbstractString="OK") = add(w, "Al", string(text, GS, type == "none" ? "" : type, GS, title == "Alert" ? "" : title, GS, ok_text == "OK" ? "" : ok_text))
message(w::WebForms, text::AbstractString, type::AbstractString="none", duration::AbstractString="0") = add(w, "me", string(text, GS, type == "none" ? "" : type, GS, duration == "0" ? "" : duration))
message(w::WebForms, text::AbstractString, type::AbstractString, duration::Integer) = message(w, text, type, string(duration))
message(w::WebForms, text::AbstractString, duration::Integer) = message(w, text, "", string(duration))

# Type: log, info, warn, error, debug, trace, group, groupend, table
console_message(w::WebForms, text::AbstractString, type::AbstractString="log") = add(w, "mc", replace(text, "\n" => "\$[ln];") * (type == "log" ? "" : string(GS, type)))
console_message_assert(w::WebForms, text::AbstractString, condition::AbstractString) = add(w, "ma", string(replace(text, "\n" => "\$[ln];"), GS, condition))

# Enable
# Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
enable_web_socket(w::WebForms, enable::Bool=true) = add(w, "ew", enable ? "1" : "0")
enable_web_socket_once(w::WebForms) = add(w, "ew", "\$")
add_web_socket(w::WebForms, path::AbstractString) = add(w, "aw" * path)
# Disconnected WebSocket
delete_web_socket(w::WebForms, path::AbstractString) = add(w, "dw" * path)

# Use
# InputPlace Using Only For form Element
use_web_socket(w::WebForms, input_place::AbstractString) = add(w, "uw" * input_place)
use_only_change_update(w::WebForms, input_place::AbstractString) = add(w, "uo" * input_place)

# Condition And Loop
# Condition And Loop Supports Brackets and Then
# Type: warning, problem, help, success, none
# Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
# Nested Conditions and Nested Loops are Possible.
function confirm_is_true_accept(w::WebForms, text::AbstractString="Are you sure you want to proceed?", type::AbstractString="none", title::AbstractString="Confirm", ok_text::AbstractString="OK", cancel_text::AbstractString="Cancel", interval::Integer=100)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "ct", string(text == "Are you sure you want to proceed?" ? "" : text, GS, type == "none" ? "" : type, GS, title == "Confirm" ? "" : title, GS, ok_text == "OK" ? "" : ok_text, GS, cancel_text == "Cancel" ? "" : cancel_text))
    return w
end

function confirm_is_false_accept(w::WebForms, text::AbstractString="Are you sure you want to proceed?", type::AbstractString="none", title::AbstractString="Confirm", ok_text::AbstractString="OK", cancel_text::AbstractString="Cancel", interval::Integer=100)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "cf", string(text == "Are you sure you want to proceed?" ? "" : text, GS, type == "none" ? "" : type, GS, title == "Confirm" ? "" : title, GS, ok_text == "OK" ? "" : ok_text, GS, cancel_text == "Cancel" ? "" : cancel_text))
    return w
end

function is_greater_than(w::WebForms, first_value::AbstractString, second_value::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "gt", string(first_value, GS, second_value))
    return w
end

function is_less_than(w::WebForms, first_value::AbstractString, second_value::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "lt", string(first_value, GS, second_value))
    return w
end

function is_equal_to(w::WebForms, first_value::AbstractString, second_value::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "et", string(first_value, GS, second_value))
    return w
end

function is_not_equal_to(w::WebForms, first_value::AbstractString, second_value::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "Nt", string(first_value, GS, second_value))
    return w
end

function exist(w::WebForms, value::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "ex", value)
    return w
end

function not_exist(w::WebForms, value::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "nx", value)
    return w
end

function is_true(w::WebForms, value::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "tr", value)
    return w
end

function is_false(w::WebForms, value::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "fa", value)
    return w
end

function is_match_media(w::WebForms, value::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "mm", value)
    return w
end

function is_not_match_media(w::WebForms, value::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "nm", value)
    return w
end

function include_(w::WebForms, text::AbstractString, value::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "In", string(value, GS, text))
    return w
end

function not_include(w::WebForms, text::AbstractString, value::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "Nn", string(value, GS, text))
    return w
end

function element_exists(w::WebForms, input_place::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "eE", input_place)
    return w
end

function element_not_exists(w::WebForms, input_place::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "nE", input_place)
    return w
end

function is_regex_match(w::WebForms, value::AbstractString, pattern::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "re", string(value, GS, pattern))
    return w
end

function is_regex_not_match(w::WebForms, value::AbstractString, pattern::AbstractString, interval::Integer=-1)
    add(w, (interval >= 0 ? "{(" * string(interval) * ")" : "{") * "rn", string(value, GS, pattern))
    return w
end

# In: Everything Becomes A JSON List.
# Key: Creates A Temporary Data In The Browser IndexedDB.
# Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
function for_each(w::WebForms, path::AbstractString, in_::AbstractString, key::AbstractString=".")
    add(w, "{fe", string(path, GS, in_, GS, key))
    return w
end

break_(w::WebForms) = add(w, ";")

function else_(w::WebForms)
    add(w, "}e")
    return w
end

start_bracket(w::WebForms) = add(w, "{")
end_bracket(w::WebForms) = add(w, "}")

# Used Then In Condition And Loop Methods
function then_(w::WebForms, new_form::WebForms)
    data = !isnothing(new_form) ? get_web_forms_data(new_form) : nothing

    if !isnothing(data) && !isempty(data)
        if occursin('\n', data)
            add_to_up(new_form, "{")
            add(new_form, "}")
        end
    end

    append_form(w, new_form)
    return w
end

function then_(w::WebForms, configure::Function)
    new_form = WebForms()
    configure(new_form)

    data = !isnothing(new_form) ? get_web_forms_data(new_form) : nothing

    if !isnothing(data) && !isempty(data)
        if occursin('\n', data)
            add_to_up(new_form, "{")
            add(new_form, "}")
        end
    end

    append_form(w, new_form)
    return w
end

function repeat_(w::WebForms, new_form::WebForms, repeat::Integer)
    if isnothing(new_form)
        return w
    end

    body_data = get_web_forms_data(new_form)

    if isempty(body_data)
        return w
    end

    start_line = -1 * length(split(body_data, '\n'))

    append_form(w, new_form)
    go_to(w, start_line, repeat - 1)

    return w
end

function repeat_(w::WebForms, new_form::WebForms, repeat::Integer, index::AbstractString)
    if isnothing(new_form)
        return w
    end

    go_to(w, index)
    start_index(w, index)

    body_data = get_web_forms_data(new_form)

    if isempty(body_data)
        return w
    end

    append_form(w, new_form)

    if isempty(index)
        index_number = -1

        for x in split(get_web_forms_data(w), '\n')
            if startswith(x, "#")
                index_number += 1
            end
        end

        go_to(w, index_number, repeat - 1)
    else
        go_to(w, index, repeat - 1)
    end

    return w
end

function repeat_(w::WebForms, configure::Function, repeat::Integer)
    new_form = WebForms()
    configure(new_form)
    return repeat_(w, new_form, repeat)
end

function repeat_(w::WebForms, configure::Function, repeat::Integer, index::AbstractString)
    new_form = WebForms()
    configure(new_form)
    return repeat_(w, new_form, repeat, index)
end

# Async
# It Supports Brackets and Then
function async_(w::WebForms)
    add(w, "{(a)")
    return w
end

delay(w::WebForms, mili_second::AbstractString) = add(w, "De", mili_second)
delay(w::WebForms, mili_second::Integer) = delay(w, string(mili_second))

# Option
change_option(w::WebForms, name::AbstractString, value::AbstractString) = add(w, "co", string(name, GS, value))
reset_option(w::WebForms) = add(w, "ro")
reset_option(w::WebForms, name::AbstractString) = add(w, "ro", name)

# Format Storage
create_format_storage(w::WebForms, key::AbstractString, data::AbstractString) = add(w, ".C", string(key, GS, data))
delete_format_storage(w::WebForms, key::AbstractString) = add(w, ".D", key)
add_json(w::WebForms, key::AbstractString, path::AbstractString, value::AbstractString) = add(w, ".a", string(key, GS, "j", GS, value, GS, path))
# Name: For Support Attribute, Set Double At Sign (@@) Before Name.
add_xml(w::WebForms, key::AbstractString, path::AbstractString, name::AbstractString, value::Union{Nothing, AbstractString}=nothing) = add(w, ".a", string(key, GS, "x", GS, name, GS, value, GS, path))
add_ini(w::WebForms, key::AbstractString, path::AbstractString, value::AbstractString, is_ini_like::Bool=false) = add(w, ".a", string(key, GS, "i", GS, is_ini_like ? "1" : "0", GS, value, GS, path))
add_text_line(w::WebForms, key::AbstractString, line::AbstractString, text::AbstractString) = add(w, ".a", string(key, GS, "t", GS, text, GS, line))
add_text_line(w::WebForms, key::AbstractString, line::Integer, text::AbstractString) = add_text_line(w, key, string(line), text)
add_variable(w::WebForms, key::AbstractString, value::AbstractString) = add(w, ".a", string(key, GS, "v", GS, value))
update_json(w::WebForms, key::AbstractString, path::AbstractString, value::AbstractString) = add(w, ".u", string(key, GS, "j", GS, value, GS, path))
update_xml(w::WebForms, key::AbstractString, path::AbstractString, value::AbstractString) = add(w, ".u", string(key, GS, "x", GS, value, GS, path))
update_ini(w::WebForms, key::AbstractString, path::AbstractString, value::AbstractString, is_ini_like::Bool=false) = add(w, ".u", string(key, GS, "i", GS, is_ini_like ? "1" : "0", GS, value, GS, path))
update_tex_line(w::WebForms, key::AbstractString, line::AbstractString, text::AbstractString) = add(w, ".u", string(key, GS, "t", GS, text, GS, line))
update_tex_line(w::WebForms, key::AbstractString, line::Integer, text::AbstractString) = update_tex_line(w, key, string(line), text)
update_variable(w::WebForms, key::AbstractString, value::AbstractString) = add(w, ".u", string(key, GS, "v", GS, value))
increase_variable(w::WebForms, key::AbstractString, value::AbstractString) = add(w, ".i", string(key, GS, "v", GS, value))
increase_variable(w::WebForms, key::AbstractString, value::Integer) = increase_variable(w, key, string(value))
decrease_variable(w::WebForms, key::AbstractString, value::Integer) = increase_variable(w, key, value * -1)
delete_json(w::WebForms, key::AbstractString, path::AbstractString) = add(w, ".d", string(key, GS, "j", GS, path))
delete_xml(w::WebForms, key::AbstractString, path::AbstractString) = add(w, ".d", string(key, GS, "x", GS, path))
delete_ini(w::WebForms, key::AbstractString, path::AbstractString, is_ini_like::Bool=false) = add(w, ".d", string(key, GS, "i", GS, is_ini_like, GS, path))
delete_text_line(w::WebForms, key::AbstractString, line::AbstractString) = add(w, ".d", string(key, GS, "t", GS, line))
delete_text_line(w::WebForms, key::AbstractString, line::Integer) = delete_text_line(w, key, string(line))
delete_variable(w::WebForms, key::AbstractString) = add(w, ".d", string(key, GS, "v"))

# Template Engine
# Pattern Example: {{value}}, ((value)), *value*, $value;
bind_json_to_template(w::WebForms, input_place::AbstractString, json_text::AbstractString, path::AbstractString, pattern::AbstractString, also_start_tag::Bool=true) = add(w, "Tj" * input_place, string(json_text, GS, path, GS, pattern, GS, also_start_tag ? "1" : "0"))
# Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
bind_xml_to_template(w::WebForms, input_place::AbstractString, xml_text::AbstractString, path::AbstractString, pattern::AbstractString, also_start_tag::Bool=true) = add(w, "Tx" * input_place, string(xml_text, GS, path, GS, pattern, GS, also_start_tag ? "1" : "0"))
bind_ini_to_template(w::WebForms, input_place::AbstractString, ini_text::AbstractString, path::AbstractString, pattern::AbstractString, also_start_tag::Bool=true) = add(w, "Ti" * input_place, string(ini_text, GS, path, GS, pattern, GS, also_start_tag ? "1" : "0"))

# Inject
# Need Add @: to First of String
inject_(w::WebForms, value::AbstractString) = "\$[" * value * "];"

# Action Control
function replace_action_control(w::WebForms, search_value::AbstractString, value::AbstractString, adding_to_up::Bool=false)
    if adding_to_up
        add_to_up(w, "rE", string(search_value, GS, value))
    else
        add(w, "rE", string(search_value, GS, value))
    end
end

function assign_replace(w::WebForms, search_value::AbstractString, value::AbstractString, index::Integer=-1)
    current_line = get_line_by_index(w, index)
    if isempty(current_line)
        return
    end

    parts = split(current_line, '='; limit=2)
    new_name = ";" * string(search_value, GS, value, GS, parts[1])
    new_value = length(parts) > 1 ? String(parts[2]) : ""

    update_line_by_index(w, index, new_name, new_value)
end

# Hash And Checksum
set_hash(w::WebForms) = add(w, "SH")
set_checksum(w::WebForms) = add(w, "CS")

function checksum_calculation(text::AbstractString)
    sum_val = Int32(0)
    mod_val = Int32(65536)
    shift = 5

    for c in text
        sum_val = ((sum_val << shift) | (sum_val >> (16 - shift))) ⊻ Int32(c)
        sum_val %= mod_val
    end

    return string(sum_val)
end

get_checksum(w::WebForms) = checksum_calculation(get_web_forms_data(w))

# Get
function get_forms_action_data(w::WebForms)
    if isempty(w.data)
        return ""
    end

    return w.data
end

function response(w::WebForms)
    return "[web-forms]\n" * get_forms_action_data(w)
end

function get_forms_action_data_line_break(w::WebForms)
    if isempty(w.data)
        return ""
    end

    processed_data = replace(w.data, "\"" => "\$[dq];")
    return replace(processed_data, "\n" => "\$[sln];")
end

# Export
function export_to_html_comment(w::WebForms, add_line::Bool=false)
    resp = replace(response(w), "--" => "\$[dd];")
    if resp[end] == '-'
        resp = resp[1:end-1] * "\$[da];"
    end

    return (add_line ? "\n" : "") * "<!--" * resp * "-->"
end

# Using it for SSE Response
function export_to_line_break(w::WebForms, src::Union{Nothing, AbstractString}=nothing)
    return "[web-forms]\$[sln];" * get_forms_action_data_line_break(w)
end

get_web_forms_data(w::WebForms) = w.data

function append_form(w::WebForms, form::WebForms)
    if isnothing(form)
        return
    end

    other_data = get_web_forms_data(form)
    if !isempty(other_data)
        if !isempty(w.data)
            w.data *= "\n"
        end
        w.data *= other_data
    end
end

function clean(w::WebForms)
    w.data = ""
end

struct Security end

function safe_value(::Security, value::AbstractString)
    if length(value) < 1
        return value
    end

    if value[1] == '@'
        value = "@" * value
    end

    value = replace(value, "\n" => "\$[ln];")
    value = replace(value, ",@" => "\$[co];@")
    value = replace(value, '\x1c' => '\0')
    value = replace(value, '\x1d' => '\0')
    value = replace(value, '\x1e' => '\0')
    value = replace(value, '\x1f' => '\0')

    return value
end

# WebForms Place Criteria (WPC) DSL
module InputPlace

const DOCUMENT = ","
const WINDOW = "`"
# When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
const ROOT = "~"
const HTML = "."
const HEAD = "^"
const SCREEN_ORIENTATION = "%"
const ALL = "*"
const PARENT = "/"
const CURRENT = "\$"
const TARGET = "!"
const UPPER = "-"

id(id_val::AbstractString) = id_val
name(name_val::AbstractString) = "(" * name_val * ")"
name(name_val::AbstractString, index::Integer) = "(" * name_val * ")" * string(index)
all_names(name_val::AbstractString) = "(" * name_val * ")*"
tag(tag_val::AbstractString) = "<" * tag_val * ">"
tag(tag_val::AbstractString, index::Integer) = "<" * tag_val * ">" * string(index)
all_tags(tag_val::AbstractString) = "<" * tag_val * ">*"
child() = "<>"
child(index::Integer) = "<>" * string(index)
all_child() = "<>*"
class(class_val::AbstractString) = "{" * class_val * "}"
class(class_val::AbstractString, index::Integer) = "{" * class_val * "}" * string(index)
all_classes(class_val::AbstractString) = "{" * class_val * "}*"
attribute(name_val::AbstractString) = "\"" * name_val * "\""
attribute(name_val::AbstractString, index::Integer) = "\"" * name_val * "\"" * string(index)
all_attributes(name_val::AbstractString) = "\"" * name_val * "\"*"
# Operator: '^', '$', '*', '~'
attribute(name_val::AbstractString, value::AbstractString, operator::Char='\0') = "\"" * name_val * (operator != '\0' ? string(operator) : "") * "'" * value * "\""
attribute(name_val::AbstractString, value::AbstractString, index::Integer, operator::Char='\0') = "\"" * name_val * (operator != '\0' ? string(operator) : "") * "'" * value * "\"" * string(index)
all_attributes(name_val::AbstractString, value::AbstractString, operator::Char='\0') = "\"" * name_val * (operator != '\0' ? string(operator) : "") * "'" * value * "\"*"
query(query_val::AbstractString) = "*" * replace(replace(replace(query_val, "=" => "\$[eq];"), "|" => "\$[vb];"), "?" => "\$[qu];")
query_all(query_val::AbstractString) = "[" * replace(replace(replace(query_val, "=" => "\$[eq];"), "|" => "\$[vb];"), "?" => "\$[qu];")

end

const OutputPlace = InputPlace

# Do not Add any Data Before or After it
module Fetch

const RS = '\x1e'
const US = '\x1f'

# Method
random(max_value::Integer) = "@mr" * string(max_value)
random(min_value::Integer, max_value::Integer) = "@mr" * string(max_value) * RS * string(min_value)
space_to_char(text::AbstractString, character::AbstractString="-") = "@sc" * character * RS * text
encode_uri(text::AbstractString) = "@ue" * text
decode_uri(text::AbstractString) = "@ud" * text

function method(method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing)
    return_value = "@cm" * method_name

    if !isnothing(args)
        return_value *= (length(args) > 0) ? RS * join(args, US) : ""
    end

    return return_value
end

function module_method(method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing)
    return_value = "@cM" * method_name

    if !isnothing(args)
        return_value *= (length(args) > 0) ? RS * join(args, US) : ""
    end

    return return_value
end

# MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
function wasm_method(wasm_language::AbstractString, wasm_url::AbstractString, method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing, key::AbstractString=".")
    return_value = "@wA" * wasm_language * RS * wasm_url * RS * method_name

    if !isnothing(args)
        return_value *= (length(args) > 0) ? RS * join(args, US) : ""
    end

    return return_value
end

script(script_text::AbstractString) = "@_" * replace(script_text, "\n" => "\$[ln];")
load_url(url::AbstractString, fetch_script::Bool=false) = "@lu" * url * (fetch_script ? RS * "1" : "")
load_html(url::AbstractString, fetch_input_place::AbstractString="", fetch_script::Bool=false) = "@lh" * url * RS * (fetch_script ? "1" : "0") * ((!isnothing(fetch_input_place) && !isempty(fetch_input_place)) ? RS * fetch_input_place : "")
load_line(url::AbstractString, line::Integer) = "@ll" * url * RS * string(line)
load_ini(url::AbstractString, name::AbstractString, is_ini_like::Bool=false) = "@li" * url * RS * name * (is_ini_like ? RS * "1" : "")
# Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
load_json(url::AbstractString, name::AbstractString) = "@lj" * url * RS * name
# Name: Name Or XPath; XPath Index Starts At 1
load_xml(url::AbstractString, name::AbstractString) = "@lx" * url * RS * name
# MethodName: It's Check Function Or Variable
has_method(method_name::AbstractString) = "@hm" * method_name
has_module_method(method_name::AbstractString) = "@hM" * method_name
# This Method Return True Or False If Key Pressed
# Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
get_modifier_state(modifier::AbstractString) = "@ms" * modifier

# Math
function math(method_name::AbstractString, args::Union{Nothing, Vector{Any}}=nothing)
    return_value = "@M#" * method_name

    if !isnothing(args)
        return_value *= (length(args) > 0) ? RS * join(args, US) : ""
    end

    return return_value
end

# Data
const DATE_YEAR = "@dy"
# Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1
const DATE_MONTH = "@dm"
const DATE_DAY = "@dd"
const DATE_DATE = "@dD"
const DATE_HOURS = "@dh"
const DATE_MINUTES = "@di"
const DATE_SECONDS = "@ds"
const DATE_MILLISECONDS = "@dl"

# String
const SPACE = "@sp"
const AT_SIGN = "@sa"

# Tag
get_id(input_place::AbstractString) = "@\$i" * input_place
get_name(input_place::AbstractString) = "@\$n" * input_place
get_value(input_place::AbstractString) = "@\$v" * input_place
get_value_length(input_place::AbstractString) = "@\$e" * input_place
get_class(input_place::AbstractString) = "@\$c" * input_place
get_style(input_place::AbstractString) = "@\$s" * input_place
get_title(input_place::AbstractString) = "@\$l" * input_place
get_label(input_place::AbstractString) = "@\$A" * input_place
get_text(input_place::AbstractString) = "@\$t" * input_place
get_outer_text(input_place::AbstractString) = "@\$o" * input_place
get_text_length(input_place::AbstractString) = "@\$g" * input_place
get_attribute(input_place::AbstractString, attribute::AbstractString) = "@\$a" * input_place * RS * attribute
get_width(input_place::AbstractString) = "@\$w" * input_place
get_height(input_place::AbstractString) = "@\$h" * input_place
get_is_read_only(input_place::AbstractString) = "@\$r" * input_place
get_selected_index(input_place::AbstractString) = "@\$x" * input_place
get_index(input_place::AbstractString) = "@\$I" * input_place
get_text_align(input_place::AbstractString) = "@\$T" * input_place
get_node_length(input_place::AbstractString) = "@\$L" * input_place
get_is_visible(input_place::AbstractString) = "@\$V" * input_place

# Save
has_hash(hash::AbstractString) = "@HH" * hash
cookie(key::AbstractString) = "@co" * key
save(key::AbstractString=".") = "@cs" * key
save(key::AbstractString, replace_value::AbstractString) = "@cs" * key * RS * replace_value
save_then_remove(key::AbstractString) = "@cl" * key
save_length(key::AbstractString=".") = "@cg" * key
cache(key::AbstractString=".") = "@cd" * key
cache(key::AbstractString, replace_value::AbstractString) = "@cd" * key * RS * replace_value
cache_then_remove(key::AbstractString) = "@ct" * key
cache_length(key::AbstractString=".") = "@cG" * key
save_line(key::AbstractString=".", line::Integer=0) = "@lL" * key * "[" * string(line)
save_line_consume(key::AbstractString=".") = "@lL" * key
# INIKey: Only Direct Key is Supported
save_ini(key::AbstractString, ini_key::AbstractString) = "@lI" * key * "[" * ini_key
cache_line(key::AbstractString=".", line::Integer=0) = "@dL" * key * "[" * string(line)
cache_line_consume(key::AbstractString=".") = "@dL" * key
# INIKey: Only Direct Key is Supported
cache_ini(key::AbstractString, ini_key::AbstractString) = "@dI" * key * "[" * ini_key

# Format Storage
format_store(key::AbstractString) = "@fr" * key
format_store_by_xml_query(key::AbstractString, xpath::AbstractString) = "@fx" * key * RS * xpath
format_store_by_json_query(key::AbstractString, query::AbstractString) = "@fj" * key * RS * query
format_store_by_ini(key::AbstractString, name::AbstractString) = "@fi" * key * RS * name
format_store_by_text(key::AbstractString, line::Integer) = "@ft" * key * RS * string(line)
format_store_by_variable(key::AbstractString) = "@fv" * key

# State
has_state(path::AbstractString) = "@hs" * path

# SSE
sse_is_connected(path::AbstractString) = "@Sc" * path

# WebSockets
web_sockets_is_connected(path::AbstractString="") = "@Wc" * path

# Document
const TAB_IS_ACTIVE = "@da"

# Window
const HREF = "@wf"
const PATH_NAME = "@wP"
query(name::AbstractString="*") = "@wq" * name
const HASH = "@wh"
const HOST = "@wH"
const HOST_NAME = "@wn"
const PORT = "@wT"
const ORIGIN = "@wo"
const GET_SELECTION = "@ws"
const SCROLL_X = "@wx"
const SCROLL_Y = "@wy"
segment(index::Integer) = "@wS" * string(index)
# It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
hash_segment(index::Integer) = "@wt" * string(index)

# Navigator
const CLIPBOARD_TEXT = "@nC"
const GEO_LATITUDE = "@nW"
const GEO_LONGITUDE = "@nO"
const LANGUAGE = "@nL"
const IS_ON_LINE = "@no"
const USER_AGENT = "@na"

# Screen
const SCREEN_WIDTH = "@sw"
const SCREEN_HEIGHT = "@sh"
const SCREEN_ORIENTATION_TYPE = "@so"
const SCREEN_ORIENTATION_ANGLE = "@sr"

# Performance
const TIME_ORIGIN = "@pt"
const PERFORMANCE_NOW = "@pn"

# Event
const EVENT = "@EV"
const EVENT_SERIALIZE = "@Es"
const EVENT_KEY = "@ek"
const EVENT_WHICH = "@ew"
const EVENT_CLIENT_X = "@ex"
const EVENT_CLIENT_Y = "@ey"
const EVENT_PAGE_X = "@eX"
const EVENT_PAGE_Y = "@eY"
const EVENT_OFFSET_X = "@Ex"
const EVENT_OFFSET_Y = "@Ey"
const EVENT_DELTA_Y = "@ed"

end

module WasmLanguage

# The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
const C = "c"
const CPP = "c"
const Rust = "rust"
const CSharp = "csharp"
# .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
const CSharpMediator = "csharp-m"
const GO = "go"
const JAVA = "java"
const AssemblyScript = "as"

end

module HtmlEvent

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
const OnWheel = "onwheel"

end

module HtmlEventListener

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
const Wheel = "wheel"

const AnimationEnd = "animationend"
const AnimationIteration = "animationiteration"
const AnimationStart = "animationstart"
const ContextMenu = "contextmenu"
const FullScreenChange = "fullscreenchange"
const FullScreenError = "fullscreenerror"
const PopState = "popstate"
const TransitionEnd = "transitionend"
const Storage = "storage"

# Custom
const ScrollBottom = "scrollbottom" # Need Call EnableScrollBottomEvent Method Before
const ElementReached = "elementreached" # Need Call EnableReachedElementEvent Method Before

end

function child(text::AbstractString, value::AbstractString)
    if length(text) < 1
        return value
    end

    return text * "|" * value
end

function parent(text::AbstractString)
    if length(text) < 1
        return text
    end

    if endswith(text, "|/") || endswith(text, "//")
        return text * "/"
    end

    return text * "|/"
end

function criteria(text::AbstractString, value::AbstractString)
    if length(text) < 1
        return value
    end

    return text * "?" * replace(replace(value, "|" => "\$[vb];"), "?" => "\$[qu];")
end

function append_fetch_replace(text::AbstractString, search_value::AbstractString, value::AbstractString)
    FS = '\x1c'

    text = text[2:end]
    return "@;" * search_value * FS * value * FS * text
end

function line_break(text::AbstractString, encode_line::Bool=false)
    encode = encode_line ? "\$[sln];" : ""
    return replace(replace(replace(text, "\r\n" => encode), "\n" => encode), "\r" => encode)
end

# Converts Numbers to Strings
to_js_string(text::AbstractString) = "\"" * text * "\""

# Get JS Object Momentary
to_js_object(text::AbstractString) = "\$" * text

# Get JS Object Returned Value Once
to_js_return_object(text::AbstractString) = "\$@" * text

end
