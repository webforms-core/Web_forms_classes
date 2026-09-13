# webforms.pm 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
# Compatible with WebFormsJS version 2.1

package WebForms;
use strict;
use warnings;
use v5.36;

use constant GS => chr(29);
use constant US => chr(31);

sub new {
    my ($class) = @_;
    my $self = {
        web_forms_data => "",
    };
    bless $self, $class;
    return $self;
}

sub _add {
    my ($self, $name, $value) = @_;
    if (length($self->{web_forms_data}) > 0) {
        $self->{web_forms_data} .= "\n";
    }
    $self->{web_forms_data} .= $name;
    if (@_ > 2) {
        $self->{web_forms_data} .= "=" . (defined $value ? $value : "");
    }
}

sub _add_to_up {
    my ($self, $name, $value) = @_;
    my $line = defined $value ? "$name=$value" : $name;
    if (length($self->{web_forms_data}) > 0) {
        $line .= "\n";
    }
    $self->{web_forms_data} = $line . $self->{web_forms_data};
}

sub _get_line_by_index {
    my ($self, $index) = @_;
    return "" if length($self->{web_forms_data}) == 0;
    my @lines = split(/\n/, $self->{web_forms_data}, -1);
    $index = scalar(@lines) + $index if $index < 0;
    return "" if $index < 0 || $index >= scalar(@lines);
    return $lines[$index];
}

sub _update_line_by_index {
    my ($self, $index, $name, $value) = @_;
    return if length($self->{web_forms_data}) == 0;
    my @lines = split(/\n/, $self->{web_forms_data}, -1);
    $index = scalar(@lines) + $index if $index < 0;
    return if $index < 0 || $index >= scalar(@lines);
    $lines[$index] = $name . (!defined($value) || $value eq '' ? "" : "=" . $value);
    $self->{web_forms_data} = join("\n", @lines);
}

# For Extension
sub add_line {
    my ($self, $name, $value) = @_;
    $self->_add($name, $value);
}

# Add
# Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.
sub add_id {
    my ($self, $input_place, $id) = @_;
    $self->_add("ai" . $input_place, $id);
}

sub add_name {
    my ($self, $input_place, $name) = @_;
    $self->_add("an" . $input_place, $name);
}

sub add_value {
    my ($self, $input_place, $value) = @_;
    $self->_add("av" . $input_place, $value);
}

sub add_class {
    my ($self, $input_place, $class) = @_;
    $self->_add("ac" . $input_place, $class);
}

sub add_style {
    my ($self, $input_place, $name_or_style, $value) = @_;
    if (@_ == 3) {
        $self->_add("as" . $input_place, $name_or_style);
    } else {
        $self->_add("as" . $input_place, $name_or_style . ':' . $value);
    }
}

sub add_option_tag {
    my ($self, $input_place, $text, $value, $selected) = @_;
    $selected = 0 if !defined $selected;
    $self->_add("ao" . $input_place, $value . GS . $text . ($selected ? GS . "1" : ""));
}

sub add_check_box_tag {
    my ($self, $input_place, $text, $value, $checked) = @_;
    $checked = 0 if !defined $checked;
    $self->_add("ak" . $input_place, $value . GS . $text . ($checked ? GS . "1" : ""));
}

sub add_title {
    my ($self, $input_place, $title) = @_;
    $self->_add("al" . $input_place, $title);
}

sub add_label {
    my ($self, $input_place, $label) = @_;
    $self->_add("aA" . $input_place, $label);
}

sub add_text {
    my ($self, $input_place, $text) = @_;
    $text =~ s/\n/\$[ln];/g;
    $self->_add("at" . $input_place, $text);
}

sub add_text_to_up {
    my ($self, $input_place, $text) = @_;
    $text =~ s/\n/\$[ln];/g;
    $self->_add("pt" . $input_place, $text);
}

sub add_attribute {
    my ($self, $input_place, $attribute, $value, $splitter) = @_;
    $value = "" if !defined $value;
    $splitter = "\0" if !defined $splitter;
    my $splitter_str = ($splitter ne "\0") ? $splitter : "";
    my $value_part = ($value ne "") ? GS . $value : "";
    $self->_add("aa" . $input_place, $attribute . GS . $splitter_str . $value_part);
}

sub add_tag {
    my ($self, $input_place, $tag_name, $id) = @_;
    $id = "" if !defined $id;
    my $id_part = ($id ne "") ? GS . $id : "";
    $self->_add("nt" . $input_place, $tag_name . $id_part);
}

sub add_tag_to_up {
    my ($self, $input_place, $tag_name, $id) = @_;
    $id = "" if !defined $id;
    my $id_part = ($id ne "") ? GS . $id : "";
    $self->_add("ut" . $input_place, $tag_name . $id_part);
}

sub add_tag_before {
    my ($self, $input_place, $tag_name, $id) = @_;
    $id = "" if !defined $id;
    my $id_part = ($id ne "") ? GS . $id : "";
    $self->_add("bt" . $input_place, $tag_name . $id_part);
}

sub add_tag_after {
    my ($self, $input_place, $tag_name, $id) = @_;
    $id = "" if !defined $id;
    my $id_part = ($id ne "") ? GS . $id : "";
    $self->_add("ft" . $input_place, $tag_name . $id_part);
}

sub add_hidden {
    my ($self, $input_place, $name, $value, $id) = @_;
    $id = "" if !defined $id;
    my $id_part = ($id ne "") ? GS . $id : "";
    $self->_add("ah" . $input_place, $name . GS . $value . $id_part);
}

# Set
# Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.
sub set_id {
    my ($self, $input_place, $id) = @_;
    $self->_add("si" . $input_place, $id);
}

sub set_name {
    my ($self, $input_place, $name) = @_;
    $self->_add("sn" . $input_place, $name);
}

sub set_value {
    my ($self, $input_place, $value) = @_;
    $self->_add("sv" . $input_place, $value);
}

sub set_class {
    my ($self, $input_place, $class) = @_;
    $self->_add("sc" . $input_place, $class);
}

sub set_style {
    my ($self, $input_place, $name_or_style, $value) = @_;
    if (@_ == 3) {
        $self->_add("ss" . $input_place, $name_or_style);
    } else {
        $self->_add("ss" . $input_place, $name_or_style . ':' . $value);
    }
}

sub set_option_tag {
    my ($self, $input_place, $text, $value, $selected) = @_;
    $selected = 0 if !defined $selected;
    $self->_add("so" . $input_place, $value . GS . $text . ($selected ? GS . "1" : ""));
}

sub set_checked {
    my ($self, $input_place, $checked) = @_;
    $checked = 0 if !defined $checked;
    $self->_add("sk" . $input_place, $checked ? "1" : "0");
}

sub set_check_box_tag {
    my ($self, $input_place, $text, $value, $checked) = @_;
    $checked = 0 if !defined $checked;
    $self->_add("sk" . $input_place, $value . GS . $text . ($checked ? GS . "1" : ""));
}

sub set_title {
    my ($self, $input_place, $title) = @_;
    $self->_add("sl" . $input_place, $title);
}

sub set_label {
    my ($self, $input_place, $label) = @_;
    $self->_add("sA" . $input_place, $label);
}

sub set_text {
    my ($self, $input_place, $text) = @_;
    $text =~ s/\n/\$[ln];/g;
    $self->_add("st" . $input_place, $text);
}

sub set_attribute {
    my ($self, $input_place, $attribute, $value) = @_;
    $value = "" if !defined $value;
    my $value_part = ($value ne "") ? GS . $value : "";
    $self->_add("sa" . $input_place, $attribute . GS . $value_part);
}

sub set_width {
    my ($self, $input_place, $width) = @_;
    my $final_width = ($width =~ /^-?\d+$/) ? "${width}px" : $width;
    $self->_add("sw" . $input_place, $final_width);
}

sub set_height {
    my ($self, $input_place, $height) = @_;
    my $final_height = ($height =~ /^-?\d+$/) ? "${height}px" : $height;
    $self->_add("sh" . $input_place, $final_height);
}

sub set_background_color {
    my ($self, $input_place, $color) = @_;
    $self->_add("bc" . $input_place, $color);
}

sub set_text_color {
    my ($self, $input_place, $color) = @_;
    $self->_add("tc" . $input_place, $color);
}

sub set_font_name {
    my ($self, $input_place, $name) = @_;
    $self->_add("fn" . $input_place, $name);
}

sub set_font_size {
    my ($self, $input_place, $size) = @_;
    my $final_size = ($size =~ /^-?\d+$/) ? "${size}px" : $size;
    $self->_add("fs" . $input_place, $final_size);
}

sub set_font_bold {
    my ($self, $input_place, $bold) = @_;
    $self->_add("fb" . $input_place, $bold ? "1" : "0");
}

sub set_visible {
    my ($self, $input_place, $visible) = @_;
    $self->_add("vi" . $input_place, $visible ? "1" : "0");
}

sub set_text_align {
    my ($self, $input_place, $align) = @_;
    $self->_add("ta" . $input_place, $align);
}

sub set_read_only {
    my ($self, $input_place, $read_only) = @_;
    $self->_add("sr" . $input_place, $read_only ? "1" : "0");
}

sub set_disabled {
    my ($self, $input_place, $disabled) = @_;
    $self->_add("sd" . $input_place, $disabled ? "1" : "0");
}

sub set_focus {
    my ($self, $input_place, $focus) = @_;
    $self->_add("sf" . $input_place, $focus ? "1" : "0");
}

sub set_min_length {
    my ($self, $input_place, $length) = @_;
    $self->_add("mn" . $input_place, "$length");
}

sub set_max_length {
    my ($self, $input_place, $length) = @_;
    $self->_add("mx" . $input_place, "$length");
}

sub set_selected_value {
    my ($self, $input_place, $value) = @_;
    $self->_add("ts" . $input_place, $value);
}

sub set_selected_index {
    my ($self, $input_place, $index) = @_;
    $self->_add("ti" . $input_place, "$index");
}

sub set_checked_value {
    my ($self, $input_place, $value, $checked) = @_;
    $self->_add("ks" . $input_place, $value . GS . ($checked ? "1" : "0"));
}

sub set_checked_index {
    my ($self, $input_place, $index, $checked) = @_;
    $self->_add("ki" . $input_place, "$index" . GS . ($checked ? "1" : "0"));
}

# Insert
# Creates the Data only if it does not exist; otherwise, does nothing.
sub insert_id {
    my ($self, $input_place, $id) = @_;
    $self->_add("ii" . $input_place, $id);
}

sub insert_name {
    my ($self, $input_place, $name) = @_;
    $self->_add("in" . $input_place, $name);
}

sub insert_value {
    my ($self, $input_place, $value) = @_;
    $self->_add("iv" . $input_place, $value);
}

sub insert_class {
    my ($self, $input_place, $class) = @_;
    $self->_add("ic" . $input_place, $class);
}

sub insert_style {
    my ($self, $input_place, $name_or_style, $value) = @_;
    if (@_ == 3) {
        $self->_add("is" . $input_place, $name_or_style);
    } else {
        $self->_add("is" . $input_place, $name_or_style . ':' . $value);
    }
}

sub insert_option_tag {
    my ($self, $input_place, $text, $value, $selected) = @_;
    $selected = 0 if !defined $selected;
    $self->_add("io" . $input_place, $value . GS . $text . ($selected ? GS . "1" : ""));
}

sub insert_check_box_tag {
    my ($self, $input_place, $text, $value, $checked) = @_;
    $checked = 0 if !defined $checked;
    $self->_add("ik" . $input_place, $value . GS . $text . ($checked ? GS . "1" : ""));
}

sub insert_title {
    my ($self, $input_place, $title) = @_;
    $self->_add("il" . $input_place, $title);
}

sub insert_label {
    my ($self, $input_place, $label) = @_;
    $self->_add("iA" . $input_place, $label);
}

sub insert_text {
    my ($self, $input_place, $text) = @_;
    $text =~ s/\n/\$[ln];/g;
    $self->_add("it" . $input_place, $text);
}

sub insert_attribute {
    my ($self, $input_place, $attribute, $value, $splitter) = @_;
    $value = "" if !defined $value;
    $splitter = "\0" if !defined $splitter;
    my $splitter_str = ($splitter ne "\0") ? $splitter : "";
    my $value_part = ($value ne "") ? GS . $value : "";
    $self->_add("ia" . $input_place, $attribute . GS . $splitter_str . $value_part);
}

# Delete
sub delete_id {
    my ($self, $input_place) = @_;
    $self->_add("di" . $input_place);
}

sub delete_name {
    my ($self, $input_place) = @_;
    $self->_add("dn" . $input_place);
}

sub delete_value {
    my ($self, $input_place) = @_;
    $self->_add("dv" . $input_place);
}

sub delete_class {
    my ($self, $input_place, $class_name) = @_;
    $self->_add("dc" . $input_place, $class_name);
}

sub delete_style {
    my ($self, $input_place, $style_name) = @_;
    $self->_add("ds" . $input_place, $style_name);
}

sub delete_option_tag {
    my ($self, $input_place, $value) = @_;
    $self->_add("do" . $input_place, $value);
}

sub delete_all_option_tag {
    my ($self, $input_place) = @_;
    $self->_add("do" . $input_place, "*");
}

sub delete_check_box_tag {
    my ($self, $input_place, $value) = @_;
    $self->_add("dk" . $input_place, $value);
}

sub delete_all_check_box_tag {
    my ($self, $input_place) = @_;
    $self->_add("dk" . $input_place, "*");
}

sub delete_title {
    my ($self, $input_place) = @_;
    $self->_add("dl" . $input_place);
}

sub delete_label {
    my ($self, $input_place) = @_;
    $self->_add("dA" . $input_place);
}

sub delete_text {
    my ($self, $input_place) = @_;
    $self->_add("dt" . $input_place);
}

sub delete_attribute {
    my ($self, $input_place, $attribute) = @_;
    $self->_add("da" . $input_place, $attribute);
}

sub delete {
    my ($self, $input_place) = @_;
    $self->_add("de" . $input_place);
}

sub delete_parent {
    my ($self, $input_place) = @_;
    $self->_add("dp" . $input_place);
}

# Tag
sub swap_tag {
    my ($self, $input_place, $output_place) = @_;
    $self->_add("sp" . $input_place, $output_place);
}

sub set_reflection {
    my ($self, $input_place, $tag) = @_;
    $self->_add("sR" . $input_place, $tag);
}

sub set_reflection_by_output_place {
    my ($self, $input_place, $output_place) = @_;
    $self->_add("iR" . $input_place, $output_place);
}

sub set_morph {
    my ($self, $input_place, $tag) = @_;
    $self->_add("sM" . $input_place, $tag);
}

sub set_morph_by_output_place {
    my ($self, $input_place, $output_place) = @_;
    $self->_add("iM" . $input_place, $output_place);
}

# Browser
sub change_url {
    my ($self, $url) = @_;
    $self->_add("cu", $url);
}

sub set_head_title {
    my ($self, $title) = @_;
    $self->_add("ht", $title);
}

sub clipboard_write_text {
    my ($self, $text) = @_;
    $self->_add("nw", $text);
}

sub scroll_to {
    my ($self, $x, $y) = @_;
    $self->_add("ws", "$x" . GS . "$y");
}

sub history_go {
    my ($self, $steps) = @_;
    $self->_add("wg", "$steps");
}

sub reload_page {
    my ($self) = @_;
    $self->_add("lr");
}

sub redirect {
    my ($self, $path) = @_;
    $self->_add("lh", $path);
}

# Increase
sub increase_min_length {
    my ($self, $input_place, $value) = @_;
    $self->_add("+n" . $input_place, "$value");
}

sub increase_max_length {
    my ($self, $input_place, $value) = @_;
    $self->_add("+x" . $input_place, "$value");
}

sub increase_font_size {
    my ($self, $input_place, $value) = @_;
    $self->_add("+f" . $input_place, "$value");
}

sub increase_width {
    my ($self, $input_place, $value) = @_;
    $self->_add("+w" . $input_place, "$value");
}

sub increase_height {
    my ($self, $input_place, $value) = @_;
    $self->_add("+h" . $input_place, "$value");
}

sub increase_value {
    my ($self, $input_place, $value) = @_;
    $self->_add("+v" . $input_place, "$value");
}

# Decrease
sub decrease_min_length {
    my ($self, $input_place, $value) = @_;
    $self->_add("-n" . $input_place, "$value");
}

sub decrease_max_length {
    my ($self, $input_place, $value) = @_;
    $self->_add("-x" . $input_place, "$value");
}

sub decrease_font_size {
    my ($self, $input_place, $value) = @_;
    $self->_add("-f" . $input_place, "$value");
}

sub decrease_width {
    my ($self, $input_place, $value) = @_;
    $self->_add("-w" . $input_place, "$value");
}

sub decrease_height {
    my ($self, $input_place, $value) = @_;
    $self->_add("-h" . $input_place, "$value");
}

sub decrease_value {
    my ($self, $input_place, $value) = @_;
    $self->_add("-v" . $input_place, "$value");
}

# Event
# ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
# All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.
sub trigger_event {
    my ($self, $input_place, $html_event_listener, $constructor_name) = @_;
    $constructor_name = "" if !defined $constructor_name;
    my $constructor_part = ($constructor_name ne "") ? GS . $constructor_name : "";
    $self->_add("TE" . $input_place, $html_event_listener . $constructor_part);
}

sub set_post_event {
    my ($self, $input_place, $html_event, $output_place) = @_;
    if (@_ == 3) {
        $self->_add("Ep" . $input_place, $html_event);
    } elsif (@_ == 4 && $output_place eq "+") {
        $self->_add("Ep" . $input_place, $html_event . GS . "+");
    } else {
        $self->_add("Ep" . $input_place, $html_event . GS . $output_place);
    }
}

sub set_post_event_listener {
    my ($self, $input_place, $html_event_listener, $output_place) = @_;
    if (@_ == 3) {
        $self->_add("EP" . $input_place, $html_event_listener);
    } elsif (@_ == 4 && $output_place eq "+") {
        $self->_add("EP" . $input_place, $html_event_listener . GS . "+");
    } else {
        $self->_add("EP" . $input_place, $html_event_listener . GS . $output_place);
    }
}

sub set_get_event {
    my ($self, $input_place, $html_event, $path_or_output, $output_place) = @_;
    my $path = (!defined $path_or_output || $path_or_output eq "") ? "#" : $path_or_output;
    if (@_ == 3) {
        $self->_add("Eg" . $input_place, $html_event . GS . $path);
    } else {
        $self->_add("Eg" . $input_place, $html_event . GS . $path . GS . $output_place);
    }
}

sub set_get_event_listener {
    my ($self, $input_place, $html_event_listener, $path_or_output, $output_place) = @_;
    my $path = (!defined $path_or_output || $path_or_output eq "") ? "#" : $path_or_output;
    if (@_ == 3) {
        $self->_add("EG" . $input_place, $html_event_listener . GS . $path);
    } else {
        $self->_add("EG" . $input_place, $html_event_listener . GS . $path . GS . $output_place);
    }
}

sub set_put_event {
    my ($self, $input_place, $html_event, $path_or_output, $output_place) = @_;
    my $path = (!defined $path_or_output || $path_or_output eq "") ? "#" : $path_or_output;
    if (@_ == 3) {
        $self->_add("Et" . $input_place, $html_event . GS . $path);
    } else {
        $self->_add("Et" . $input_place, $html_event . GS . $path . GS . $output_place);
    }
}

sub set_put_event_listener {
    my ($self, $input_place, $html_event_listener, $path_or_output, $output_place) = @_;
    my $path = (!defined $path_or_output || $path_or_output eq "") ? "#" : $path_or_output;
    if (@_ == 3) {
        $self->_add("ET" . $input_place, $html_event_listener . GS . $path);
    } else {
        $self->_add("ET" . $input_place, $html_event_listener . GS . $path . GS . $output_place);
    }
}

sub set_patch_event {
    my ($self, $input_place, $html_event, $path_or_output, $output_place) = @_;
    my $path = (!defined $path_or_output || $path_or_output eq "") ? "#" : $path_or_output;
    if (@_ == 3) {
        $self->_add("Ea" . $input_place, $html_event . GS . $path);
    } else {
        $self->_add("Ea" . $input_place, $html_event . GS . $path . GS . $output_place);
    }
}

sub set_patch_event_listener {
    my ($self, $input_place, $html_event_listener, $path_or_output, $output_place) = @_;
    my $path = (!defined $path_or_output || $path_or_output eq "") ? "#" : $path_or_output;
    if (@_ == 3) {
        $self->_add("EA" . $input_place, $html_event_listener . GS . $path);
    } else {
        $self->_add("EA" . $input_place, $html_event_listener . GS . $path . GS . $output_place);
    }
}

sub set_delete_event {
    my ($self, $input_place, $html_event, $path_or_output, $output_place) = @_;
    my $path = (!defined $path_or_output || $path_or_output eq "") ? "#" : $path_or_output;
    if (@_ == 3) {
        $self->_add("El" . $input_place, $html_event . GS . $path);
    } else {
        $self->_add("El" . $input_place, $html_event . GS . $path . GS . $output_place);
    }
}

sub set_delete_event_listener {
    my ($self, $input_place, $html_event_listener, $path_or_output, $output_place) = @_;
    my $path = (!defined $path_or_output || $path_or_output eq "") ? "#" : $path_or_output;
    if (@_ == 3) {
        $self->_add("EL" . $input_place, $html_event_listener . GS . $path);
    } else {
        $self->_add("EL" . $input_place, $html_event_listener . GS . $path . GS . $output_place);
    }
}

sub set_options_event {
    my ($self, $input_place, $html_event, $path_or_output, $output_place) = @_;
    my $path = (!defined $path_or_output || $path_or_output eq "") ? "#" : $path_or_output;
    if (@_ == 3) {
        $self->_add("Eo" . $input_place, $html_event . GS . $path);
    } else {
        $self->_add("Eo" . $input_place, $html_event . GS . $path . GS . $output_place);
    }
}

sub set_options_event_listener {
    my ($self, $input_place, $html_event_listener, $path_or_output, $output_place) = @_;
    my $path = (!defined $path_or_output || $path_or_output eq "") ? "#" : $path_or_output;
    if (@_ == 3) {
        $self->_add("EO" . $input_place, $html_event_listener . GS . $path);
    } else {
        $self->_add("EO" . $input_place, $html_event_listener . GS . $path . GS . $output_place);
    }
}

sub set_head_event {
    my ($self, $input_place, $html_event, $path) = @_;
    $path = "#" if !defined $path || $path eq "";
    $self->_add("Eh" . $input_place, $html_event . GS . $path);
}

sub set_head_event_listener {
    my ($self, $input_place, $html_event_listener, $path) = @_;
    $path = "#" if !defined $path || $path eq "";
    $self->_add("EH" . $input_place, $html_event_listener . GS . $path);
}

# IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
sub set_send_event {
    my ($self, $input_place, $html_event, $data, $path, $method, $is_multi_part, $content_type, $output_place) = @_;
    $path = "#" if !defined $path || $path eq "";
    $method = "POST" if !defined $method;
    $is_multi_part = 0 if !defined $is_multi_part;
    $content_type = "text/plain" if !defined $content_type;
    $output_place = "" if !defined $output_place;
    
    my $processed_data = $data;
    $processed_data =~ s/\n/\$[ln];/g;
    $processed_data =~ s/"/\$[dq];/g;
    $processed_data =~ s/'/\$[sq];/g;
    
    my $output_part = ($output_place ne "") ? $output_place : "";
    $self->_add("En" . $input_place, $html_event . GS . $processed_data . GS . $path . GS . $method . GS . ($is_multi_part ? "1" : "0") . GS . $content_type . GS . $output_part);
}

sub set_send_event_listener {
    my ($self, $input_place, $html_event_listener, $data, $path, $method, $is_multi_part, $content_type, $output_place) = @_;
    $path = "#" if !defined $path || $path eq "";
    $method = "POST" if !defined $method;
    $is_multi_part = 0 if !defined $is_multi_part;
    $content_type = "text/plain" if !defined $content_type;
    $output_place = "" if !defined $output_place;
    
    my $processed_data = $data;
    $processed_data =~ s/\n/\$[ln];/g;
    
    my $output_part = ($output_place ne "") ? $output_place : "";
    $self->_add("EN" . $input_place, $html_event_listener . GS . $processed_data . GS . $path . GS . $method . GS . ($is_multi_part ? "1" : "0") . GS . $content_type . GS . $output_part);
}

sub set_comment_event {
    my ($self, $input_place, $html_event, $index, $output_place) = @_;
    $index = "" if !defined $index;
    $output_place = "" if !defined $output_place;
    $self->_add("Eb" . $input_place, $html_event . GS . $index . GS . $output_place);
}

sub set_comment_event_listener {
    my ($self, $input_place, $html_event_listener, $index, $output_place) = @_;
    $index = "" if !defined $index;
    $output_place = "" if !defined $output_place;
    $self->_add("EB" . $input_place, $html_event_listener . GS . $index . GS . $output_place);
}

sub set_wasm_event {
    my ($self, $input_place, $html_event, $wasm_language, $wasm_url, $method_name, $args, $output_place) = @_;
    $output_place = "" if !defined $output_place;
    my $args_join = "";
    if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
        $args_join = "[" . join(US, @$args);
    }
    $self->_add("Ey" . $input_place, $html_event . GS . $wasm_language . GS . $wasm_url . GS . $method_name . GS . $args_join . GS . $output_place);
}

sub set_wasm_event_listener {
    my ($self, $input_place, $html_event_listener, $wasm_language, $wasm_url, $method_name, $args, $output_place) = @_;
    $output_place = "" if !defined $output_place;
    my $args_join = "";
    if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
        $args_join = "[" . join(US, @$args);
    }
    $self->_add("EY" . $input_place, $html_event_listener . GS . $wasm_language . GS . $wasm_url . GS . $method_name . GS . $args_join . GS . $output_place);
}

sub set_web_socket_event {
    my ($self, $input_place, $html_event, $path) = @_;
    $self->_add("Ew" . $input_place, $html_event . GS . $path);
}

sub set_web_socket_event_listener {
    my ($self, $input_place, $html_event_listener, $path) = @_;
    $self->_add("EW" . $input_place, $html_event_listener . GS . $path);
}

sub set_sse_event {
    my ($self, $input_place, $html_event, $path, $should_reconnect_or_output, $reconnect_try_timeout_or_nil, $output_place) = @_;
    my $should_reconnect = 1;
    my $reconnect_try_timeout = 3000;
    my $out_place = "";
    
    if (@_ == 5) {
        $should_reconnect = $should_reconnect_or_output // 1;
        $reconnect_try_timeout = $reconnect_try_timeout_or_nil // 3000;
    } else {
        $should_reconnect = $should_reconnect_or_output // 1;
        $reconnect_try_timeout = $reconnect_try_timeout_or_nil // 3000;
        $out_place = $output_place // "";
    }
    
    if ($out_place eq "") {
        $self->_add("Ee" . $input_place, $html_event . GS . $path . GS . ($should_reconnect ? "1" : "0") . GS . $reconnect_try_timeout);
    } else {
        $self->_add("Ee" . $input_place, $html_event . GS . $path . GS . ($should_reconnect ? "1" : "0") . GS . $reconnect_try_timeout . GS . $out_place);
    }
}

sub set_sse_event_listener {
    my ($self, $input_place, $html_event_listener, $path, $should_reconnect_or_output, $reconnect_try_timeout_or_nil, $output_place) = @_;
    my $should_reconnect = 1;
    my $reconnect_try_timeout = 3000;
    my $out_place = "";
    
    if (@_ == 5) {
        $should_reconnect = $should_reconnect_or_output // 1;
        $reconnect_try_timeout = $reconnect_try_timeout_or_nil // 3000;
    } else {
        $should_reconnect = $should_reconnect_or_output // 1;
        $reconnect_try_timeout = $reconnect_try_timeout_or_nil // 3000;
        $out_place = $output_place // "";
    }
    
    if ($out_place eq "") {
        $self->_add("EE" . $input_place, $html_event_listener . GS . $path . GS . ($should_reconnect ? "1" : "0") . GS . $reconnect_try_timeout);
    } else {
        $self->_add("EE" . $input_place, $html_event_listener . GS . $path . GS . ($should_reconnect ? "1" : "0") . GS . $reconnect_try_timeout . GS . $out_place);
    }
}

sub set_front_event {
    my ($self, $input_place, $html_event, $module_path, $args, $output_place) = @_;
    $output_place = "" if !defined $output_place;
    my $args_join = "";
    if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
        $args_join = GS . "[" . join(US, @$args);
    }
    $self->_add("Ej" . $input_place, $html_event . GS . $module_path . GS . $output_place . $args_join);
}

sub set_front_event_listener {
    my ($self, $input_place, $html_event_listener, $module_path, $args, $output_place) = @_;
    $output_place = "" if !defined $output_place;
    my $args_join = "";
    if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
        $args_join = GS . "[" . join(US, @$args);
    }
    $self->_add("EJ" . $input_place, $html_event_listener . GS . $module_path . GS . $output_place . $args_join);
}

sub set_master_pages_event {
    my ($self, $input_place, $html_event, $output_place) = @_;
    $output_place = "" if !defined $output_place;
    $self->_add("Eu" . $input_place, $html_event . GS . $output_place);
}

sub set_master_pages_event_listener {
    my ($self, $input_place, $html_event_listener, $output_place) = @_;
    $output_place = "" if !defined $output_place;
    $self->_add("EU" . $input_place, $html_event_listener . GS . $output_place);
}

sub set_prevent_default_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Ed" . $input_place, $html_event);
}

sub set_prevent_default_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("ED" . $input_place, $html_event_listener);
}

sub set_stop_propagation_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Es" . $input_place, $html_event);
}

sub set_stop_propagation_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("ES" . $input_place, $html_event_listener);
}

sub set_method_event {
    my ($self, $input_place, $html_event, $method_name, $args) = @_;
    my $args_join = "";
    if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
        $args_join = GS . "[" . join(US, @$args);
    }
    $self->_add("Em" . $input_place, $html_event . GS . $method_name . $args_join);
}

sub set_method_event_listener {
    my ($self, $input_place, $html_event_listener, $method_name, $args) = @_;
    my $args_join = "";
    if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
        $args_join = GS . "[" . join(US, @$args);
    }
    $self->_add("EM" . $input_place, $html_event_listener . GS . $method_name . $args_join);
}

sub set_module_method_event {
    my ($self, $input_place, $html_event, $method_name, $args) = @_;
    my $args_join = "";
    if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
        $args_join = GS . "[" . join(US, @$args);
    }
    $self->_add("Ex" . $input_place, $html_event . GS . $method_name . $args_join);
}

sub set_module_method_event_listener {
    my ($self, $input_place, $html_event_listener, $method_name, $args) = @_;
    my $args_join = "";
    if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
        $args_join = GS . "[" . join(US, @$args);
    }
    $self->_add("EX" . $input_place, $html_event_listener . GS . $method_name . $args_join);
}

sub assign_confirm_event {
    my ($self, $input_place, $html_event, $text, $type, $title, $ok_text, $cancel_text) = @_;
    $text = "Are you sure you want to proceed?" if !defined $text;
    $type = "none" if !defined $type;
    $title = "Confirm" if !defined $title;
    $ok_text = "OK" if !defined $ok_text;
    $cancel_text = "Cancel" if !defined $cancel_text;
    
    my $text_part = ($text eq "Are you sure you want to proceed?" ? "" : $text);
    my $type_part = ($type eq "none" ? "" : $type);
    my $title_part = ($title eq "Confirm" ? "" : $title);
    my $ok_part = ($ok_text eq "OK" ? "" : $ok_text);
    my $cancel_part = ($cancel_text eq "Cancel" ? "" : $cancel_text);
    
    $self->_add("Ef" . $input_place, $html_event . GS . $text_part . GS . $type_part . GS . $title_part . GS . $ok_part . GS . $cancel_part);
}

sub remove_post_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Rp" . $input_place, $html_event);
}

sub remove_post_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RP" . $input_place, $html_event_listener);
}

sub remove_get_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Rg" . $input_place, $html_event);
}

sub remove_get_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RG" . $input_place, $html_event_listener);
}

sub remove_put_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Rt" . $input_place, $html_event);
}

sub remove_put_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RT" . $input_place, $html_event_listener);
}

sub remove_patch_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Ra" . $input_place, $html_event);
}

sub remove_patch_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RA" . $input_place, $html_event_listener);
}

sub remove_delete_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Rl" . $input_place, $html_event);
}

sub remove_delete_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RL" . $input_place, $html_event_listener);
}

sub remove_options_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Ro" . $input_place, $html_event);
}

sub remove_options_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RO" . $input_place, $html_event_listener);
}

sub remove_head_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Rh" . $input_place, $html_event);
}

sub remove_head_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RH" . $input_place, $html_event_listener);
}

sub remove_send_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Rn" . $input_place, $html_event);
}

sub remove_send_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RN" . $input_place, $html_event_listener);
}

sub remove_comment_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Rb" . $input_place, $html_event);
}

sub remove_comment_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RB" . $input_place, $html_event_listener);
}

sub remove_wasm_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Ry" . $input_place, $html_event);
}

sub remove_wasm_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RY" . $input_place, $html_event_listener);
}

sub remove_web_socket_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Rw" . $input_place, $html_event);
}

sub remove_web_socket_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RW" . $input_place, $html_event_listener);
}

sub remove_sse_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Re" . $input_place, $html_event);
}

sub remove_sse_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RE" . $input_place, $html_event_listener);
}

sub remove_front_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Rj" . $input_place, $html_event);
}

sub remove_front_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RJ" . $input_place, $html_event_listener);
}

sub remove_prevent_default_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Rd" . $input_place, $html_event);
}

sub remove_prevent_default_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RD" . $input_place, $html_event_listener);
}

sub remove_master_pages_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Ru" . $input_place, $html_event);
}

sub remove_master_pages_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RU" . $input_place, $html_event_listener);
}

sub remove_stop_propagation_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Rs" . $input_place, $html_event);
}

sub remove_stop_propagation_event_listener {
    my ($self, $input_place, $html_event_listener) = @_;
    $self->_add("RS" . $input_place, $html_event_listener);
}

sub remove_method_event {
    my ($self, $input_place, $html_event, $method_name) = @_;
    $self->_add("Rm" . $input_place, $html_event . GS . $method_name);
}

sub remove_method_event_listener {
    my ($self, $input_place, $html_event_listener, $method_name) = @_;
    $self->_add("RM" . $input_place, $html_event_listener . GS . $method_name);
}

sub remove_module_method_event {
    my ($self, $input_place, $html_event, $method_name) = @_;
    $self->_add("Rx" . $input_place, $html_event . GS . $method_name);
}

sub remove_module_method_event_listener {
    my ($self, $input_place, $html_event_listener, $method_name) = @_;
    $self->_add("RX" . $input_place, $html_event_listener . GS . $method_name);
}

sub remove_confirm_event {
    my ($self, $input_place, $html_event) = @_;
    $self->_add("Rf" . $input_place, $html_event);
}

# Custom Event
# This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
# Watch: attribute, style, text, children, value
# Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
# Range: Only Use For Compare With inrange Value. Split By Comma ","
# Key: Only Use For Watch With attribute And style Value
sub create_custom_dom_event {
	my ($self, $input_place, $event_name, $watch, $key, $compare, $value, $range, $immediate, $delay) = @_;
	$immediate = 0 if !defined $immediate;
	$delay = "0" if !defined $delay;
	$self->_add("eC" . $input_place, $event_name . GS . $watch . GS . $key . GS . $compare . GS . $value . GS . $range . GS . ($immediate ? "1" : "0") . GS . $delay);
}

sub enable_scroll_bottom_event {
	my ($self, $enable) = @_;
	$enable = 1 if !defined $enable;
	$self->_add("eb", $enable ? "1" : "0");
}

sub enable_reached_element_event {
	my ($self, $input_place, $once, $enable) = @_;
	$enable = 1 if !defined $enable;
	$self->_add("er" . $input_place, ($once ? "1" : "0") . GS . ($enable ? "1" : "0"));
}

# Module
sub load_module {
	my ($self, $module_path, $methods) = @_;
	$methods = [] if !defined $methods;
	my $methods_part = (scalar(@$methods) > 0) ? GS . "[" . join(US, @$methods) : "";
	$self->_add("Ml", $module_path . $methods_part);
}

sub unload_module {
	my ($self, $module_path) = @_;
	$self->_add("Mu", $module_path);
}

sub delete_module_method {
	my ($self, $method_name) = @_;
	$self->_add("Md", $method_name);
}

# Unit Testing
# InputPlace Is Actual, Expected Is Tag/OutputPlace
sub assert_equal {
	my ($self, $input_place, $tag) = @_;
	$tag =~ s/\n/\$[ln];/g;
	$self->_add("At" . $input_place, $tag);
}

sub assert_equal_by_output_place {
	my ($self, $input_place, $output_place) = @_;
	$self->_add("Ao" . $input_place, $output_place);
}

# Debug
sub create_debugger {
	my ($self, $pause) = @_;
	$pause = 0 if !defined $pause;
	$self->_add("Dc", $pause ? "1" : "0");
}

# Service Worker
# To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
sub service_worker_register {
	my ($self, $path, $scope_path) = @_;
	$path = "" if !defined $path;
	$scope_path = "" if !defined $scope_path;
	$self->_add("wR", $path . GS . $scope_path);
}

sub service_worker_pre_cache_static {
	my ($self, $path_list) = @_;
	$self->_add("wp", join(GS, @$path_list));
}

sub service_worker_dynamic_cache {
	my ($self, $path, $seconds) = @_;
	$seconds = "" if !defined $seconds;
	$self->_add("wc", $path . ($seconds ne "" ? GS . $seconds : ""));
}

sub service_worker_delete_dynamic_cache {
	my ($self, $path) = @_;
	if (!defined $path) {
		$self->_add("wd");
	} else {
		$self->_add("wd", $path);
	}
}

sub service_worker_dynamic_cache_ttl_update {
	my ($self, $path, $seconds) = @_;
	$seconds = "" if !defined $seconds;
	$self->_add("wt", $path . ($seconds ne "" ? GS . $seconds : ""));
}

# Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
# Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
# CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
sub service_worker_route_set {
	my ($self, $path, $type, $cache_dynamic) = @_;
	$cache_dynamic = 0 if !defined $cache_dynamic;
	$self->_add("wr", $path . GS . $type . ($cache_dynamic ? GS . "1" : ""));
}

sub service_worker_route_alias {
	my ($self, $path, $to) = @_;
	$self->_add("wa", $path . GS . $to);
}

sub service_worker_delete_route_alias {
	my ($self, $path) = @_;
	$path = "" if !defined $path;
	$self->_add("wC", $path);
}

# Delete All Route And Alias
sub service_worker_delete_route {
	my ($self, $path) = @_;
	if (!defined $path) {
		$self->_add("wD");
	} else {
		$self->_add("wD", $path);
	}
}

# SSE
sub disconnect_sse {
	my ($self, $path) = @_;
	if (!defined $path) {
		$self->_add("Ds");
	} else {
		$self->_add("Ds", $path);
	}
}

sub disconnect_all_sse {
	my ($self) = @_;
	$self->_add("Ds");
}

# State
sub add_state {
	my ($self, $path, $title) = @_;
	$path = "" if !defined $path;
	$title = "" if !defined $title;
	$self->_add("AS", $path . GS . $title);
}

sub save_state {
	my ($self, $path, $title) = @_;
	$path = "" if !defined $path;
	$title = "" if !defined $title;
	$self->_add("As", $path . GS . $title);
}

sub load_state {
	my ($self, $path) = @_;
	$self->_add("ls", $path);
}

sub delete_state {
	my ($self, $path) = @_;
	if (!defined $path) {
		$self->_add("DS");
	} elsif ($path eq "*") {
		$self->_add("DS", "*");
	} else {
		$self->_add("DS", $path);
	}
}

sub delete_all_state {
	my ($self) = @_;
	$self->_add("DS", "*");
}

# Cookie
sub set_cookie {
	my ($self, $key, $value, $seconds, $path) = @_;
	$path = "" if !defined $path;
	$self->_add("sC", $key . GS . $value . GS . "$seconds" . ($path ne "" ? GS . $path : ""));
}

# Save (Session Cache)
sub save_id {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gi' . $input_place, $key);
}

sub save_name {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gn' . $input_place, $key);
}

sub save_value {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gv' . $input_place, $key);
}

sub save_value_length {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@ge' . $input_place, $key);
}

sub save_class {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gc' . $input_place, $key);
}

sub save_style {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gs' . $input_place, $key);
}

sub save_title {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gl' . $input_place, $key);
}

sub save_label {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gA' . $input_place, $key);
}

sub save_text {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gt' . $input_place, $key);
}

sub save_outer_text {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@go' . $input_place, $key);
}

sub save_text_length {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gg' . $input_place, $key);
}

sub save_attribute {
	my ($self, $input_place, $attribute, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@ga' . $input_place, $key . GS . $attribute);
}

sub save_width {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gw' . $input_place, $key);
}

sub save_height {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gh' . $input_place, $key);
}

sub save_read_only {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gr' . $input_place, $key);
}

sub save_selected_index {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gx' . $input_place, $key);
}

sub save_text_align {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gT' . $input_place, $key);
}

sub save_node_length {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gL' . $input_place, $key);
}

sub save_visible {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gV' . $input_place, $key);
}

sub save_url {
	my ($self, $url, $fetch_script, $key) = @_;
	$fetch_script = 0 if !defined $fetch_script;
	$key = "." if !defined $key;
	$self->_add('@gu', $key . GS . $url . ($fetch_script ? GS . "1" : ""));
}

sub save_index {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@gI' . $input_place, $key);
}

sub remove_save {
	my ($self, $cache_key) = @_;
	$self->_add("rs", $cache_key);
}

sub remove_all_save {
	my ($self) = @_;
	$self->_add("rs", "*");
}

# Calling the SetSave Method Causes Action Control Requests Triggered by Events Using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send Event, to be Temporarily Saved on the Active Page, so the Request will not be Sent to the Server Again.
sub set_save {
	my ($self) = @_;
	$self->_add("cs", "*");
}

sub add_save_value {
	my ($self, $cache_key, $value) = @_;
	$value =~ s/\n/\$[ln];/g;
	$self->_add("SA", $cache_key . GS . $value);
}

sub insert_save_value {
	my ($self, $cache_key, $value) = @_;
	$value =~ s/\n/\$[ln];/g;
	$self->_add("SI", $cache_key . GS . $value);
}

sub append_save_value {
	my ($self, $cache_key, $value) = @_;
	$value =~ s/\n/\$[ln];/g;
	$self->_add("SP", $cache_key . GS . $value);
}

sub replace_save_value {
	my ($self, $cache_key, $search_value, $value) = @_;
	my $val_clean = $value;
	$val_clean =~ s/\n/\$[ln];/g;
	my $search_clean = $search_value;
	$search_clean =~ s/\n/\$[ln];/g;
	$self->_add("SR", $cache_key . GS . $val_clean . GS . $search_clean);
}

# Cache
sub cache_id {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@ci' . $input_place, $key);
}

sub cache_name {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cn' . $input_place, $key);
}

sub cache_value {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cv' . $input_place, $key);
}

sub cache_value_length {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@ce' . $input_place, $key);
}

sub cache_class {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cc' . $input_place, $key);
}

sub cache_style {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cs' . $input_place, $key);
}

sub cache_title {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cl' . $input_place, $key);
}

sub cache_label {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cA' . $input_place, $key);
}

sub cache_text {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@ct' . $input_place, $key);
}

sub cache_outer_text {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@co' . $input_place, $key);
}

sub cache_text_length {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cg' . $input_place, $key);
}

sub cache_attribute {
	my ($self, $input_place, $attribute, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@ca' . $input_place, $key . GS . $attribute);
}

sub cache_width {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cw' . $input_place, $key);
}

sub cache_height {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@ch' . $input_place, $key);
}

sub cache_read_only {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cr' . $input_place, $key);
}

sub cache_selected_index {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cx' . $input_place, $key);
}

sub cache_text_align {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cT' . $input_place, $key);
}

sub cache_node_length {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cL' . $input_place, $key);
}

sub cache_visible {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cV' . $input_place, $key);
}

sub cache_url {
	my ($self, $url, $fetch_script, $key) = @_;
	$fetch_script = 0 if !defined $fetch_script;
	$key = "." if !defined $key;
	$self->_add('@cu', $key . GS . $url . ($fetch_script ? GS . "1" : ""));
}

sub cache_index {
	my ($self, $input_place, $key) = @_;
	$key = "." if !defined $key;
	$self->_add('@cI' . $input_place, $key);
}

sub remove_cache {
	my ($self, $cache_key) = @_;
	$self->_add("rd", $cache_key);
}

sub remove_all_cache {
	my ($self) = @_;
	$self->_add("rd", "*");
}

# Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
sub set_cache {
	my ($self, $second) = @_;
	if (!defined $second) {
		$self->_add("cd", "*");
	} else {
		$self->_add("cd", "$second");
	}
}

sub add_cache_value {
	my ($self, $cache_key, $value) = @_;
	$value =~ s/\n/\$[ln];/g;
	$self->_add("CA", $cache_key . GS . $value);
}

sub insert_cache_value {
	my ($self, $cache_key, $value) = @_;
	$value =~ s/\n/\$[ln];/g;
	$self->_add("CI", $cache_key . GS . $value);
}

sub append_cache_value {
	my ($self, $cache_key, $value) = @_;
	$value =~ s/\n/\$[ln];/g;
	$self->_add("CP", $cache_key . GS . $value);
}

sub replace_cache_value {
	my ($self, $cache_key, $search_value, $value) = @_;
	my $val_clean = $value;
	$val_clean =~ s/\n/\$[ln];/g;
	my $search_clean = $search_value;
	$search_clean =~ s/\n/\$[ln];/g;
	$self->_add("CR", $cache_key . GS . $val_clean . GS . $search_clean);
}

# Call
sub load_url {
	my ($self, $input_place, $url) = @_;
	$self->_add("lu" . $input_place, $url);
}

sub run_action_controls {
	my ($self, $action_controls, $without_web_forms_section, $index, $use_current_event) = @_;
	$without_web_forms_section = 1 if !defined $without_web_forms_section;
	$index = "" if !defined $index;
	$use_current_event = 1 if !defined $use_current_event;
	$self->_add("lA", ($use_current_event ? "1" : "0") . GS . ($without_web_forms_section ? "1" : "0") . GS . $index . GS . $action_controls);
}

sub call_script {
	my ($self, $script_text) = @_;
	$script_text =~ s/\n/\$[ln];/g;
	$self->_add("_", $script_text);
}

sub call_method {
	my ($self, $method_name, $args) = @_;
	my $args_join = "";
	if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
		$args_join = GS . "[" . join(US, @$args);
	}
	$self->_add("lm", $method_name . $args_join);
}

sub call_module_method {
	my ($self, $method_name, $args) = @_;
	my $args_join = "";
	if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
		$args_join = GS . "[" . join(US, @$args);
	}
	$self->_add("lM", $method_name . $args_join);
}

sub call_post_back {
	my ($self, $form_input_place, $output_place) = @_;
	$output_place = "" if !defined $output_place;
	my $output_part = ($output_place ne "") ? GS . $output_place : "";
	$self->_add("Lp", "1" . GS . $form_input_place . $output_part);
}

sub call_comment_back {
	my ($self, $index, $input_place, $use_current_event) = @_;
	$index = "" if !defined $index;
	$input_place = "" if !defined $input_place;
	$use_current_event = 1 if !defined $use_current_event;
	$self->_add("LC", ($use_current_event ? "1" : "0") . GS . "$index" . GS . $input_place);
}

sub call_wasm_back {
	my ($self, $wasm_language, $wasm_url, $method_name, $args, $output_place, $use_current_event) = @_;
	$output_place = "" if !defined $output_place;
	$use_current_event = 1 if !defined $use_current_event;
	my $args_join = "";
	if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
		$args_join = "[" . join(US, @$args);
	}
	$self->_add("Ly", ($use_current_event ? "1" : "0") . GS . $wasm_language . GS . $wasm_url . GS . $method_name . GS . $args_join . GS . $output_place);
}

sub call_web_socket_back {
	my ($self, $path, $use_current_event) = @_;
	$use_current_event = 1 if !defined $use_current_event;
	$self->_add("Lw", ($use_current_event ? "1" : "0") . GS . $path);
}

sub call_sse_back {
	my ($self, $path, $output_place, $use_current_event, $should_reconnect, $reconnect_try_timeout) = @_;
	$output_place = "" if !defined $output_place;
	$use_current_event = 1 if !defined $use_current_event;
	$should_reconnect = 1 if !defined $should_reconnect;
	$reconnect_try_timeout = "3000" if !defined $reconnect_try_timeout;
	my $output_part = ($output_place ne "") ? GS . $output_place : "";
	$self->_add("Ls", ($use_current_event ? "1" : "0") . GS . $path . GS . ($should_reconnect ? "1" : "0") . GS . "$reconnect_try_timeout" . $output_part);
}

sub call_front {
	my ($self, $module_path, $args, $output_place, $use_current_event) = @_;
	$output_place = "" if !defined $output_place;
	$use_current_event = 1 if !defined $use_current_event;
	my $args_join = "";
	if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
		$args_join = GS . "[" . join(US, @$args);
	}
	$self->_add("Lj", ($use_current_event ? "1" : "0") . GS . $module_path . GS . $output_place . $args_join);
}

sub call_get_back {
	my ($self, $path, $output_place, $use_current_event) = @_;
	$output_place = "" if !defined $output_place;
	$use_current_event = 1 if !defined $use_current_event;
	my $output_part = ($output_place ne "") ? GS . $output_place : "";
	$self->_add("Lg", ($use_current_event ? "1" : "0") . GS . $path . $output_part);
}

sub call_put_back {
	my ($self, $path, $output_place, $use_current_event) = @_;
	$output_place = "" if !defined $output_place;
	$use_current_event = 1 if !defined $use_current_event;
	my $output_part = ($output_place ne "") ? GS . $output_place : "";
	$self->_add("Lt", ($use_current_event ? "1" : "0") . GS . $path . $output_part);
}

sub call_patch_back {
	my ($self, $path, $output_place, $use_current_event) = @_;
	$output_place = "" if !defined $output_place;
	$use_current_event = 1 if !defined $use_current_event;
	my $output_part = ($output_place ne "") ? GS . $output_place : "";
	$self->_add("LP", ($use_current_event ? "1" : "0") . GS . $path . $output_part);
}

sub call_delete_back {
	my ($self, $path, $output_place, $use_current_event) = @_;
	$output_place = "" if !defined $output_place;
	$use_current_event = 1 if !defined $use_current_event;
	my $output_part = ($output_place ne "") ? GS . $output_place : "";
	$self->_add("Ld", ($use_current_event ? "1" : "0") . GS . $path . $output_part);
}

sub call_head_back {
	my ($self, $path, $use_current_event) = @_;
	$use_current_event = 1 if !defined $use_current_event;
	$self->_add("Lh", ($use_current_event ? "1" : "0") . GS . $path);
}

sub call_options_back {
	my ($self, $path, $output_place, $use_current_event) = @_;
	$output_place = "" if !defined $output_place;
	$use_current_event = 1 if !defined $use_current_event;
	my $output_part = ($output_place ne "") ? GS . $output_place : "";
	$self->_add("Lo", ($use_current_event ? "1" : "0") . GS . $path . $output_part);
}

sub call_send_back {
	my ($self, $path, $method, $is_multi_part, $content_type, $data, $output_place, $use_current_event) = @_;
	$output_place = "" if !defined $output_place;
	$use_current_event = 1 if !defined $use_current_event;
	$data =~ s/\n/\$[ln];/g;
	my $output_part = ($output_place ne "") ? GS . $output_place : "";
	$self->_add("LS", ($use_current_event ? "1" : "0") . GS . $path . GS . $method . GS . ($is_multi_part ? "1" : "0") . GS . $content_type . GS . $data . $output_part);
}

# Update
sub increase {
	my ($self, $input_place, $value) = @_;
	$self->_add("gt" . $input_place, "i" . GS . "$value");
}

sub decrease {
	my ($self, $input_place, $value) = @_;
	$self->_add("gt" . $input_place, "i" . GS . ($value * -1));
}

# If You Don't Use Deep Mode, any Tags Inside the Current Tag Will Simply Be Treated as Strings. Deep Mode Does not Remove Inner Elements.
sub replace {
	my ($self, $input_place, $value, $new_value, $also_start_tag, $deep) = @_;
	$also_start_tag = 0 if !defined $also_start_tag;
	$deep = 1 if !defined $deep;
	$self->_add("gt" . $input_place, "r" . GS . $value . GS . $new_value . GS . ($also_start_tag ? "1" : "0") . GS . ($deep ? "1" : "0"));
}

# HTML Converts Attribute Names to Lowercase, so they Need to Be Written in Lowercase.
sub replace_start_tag {
	my ($self, $input_place, $value, $new_value) = @_;
	$self->_add("gt" . $input_place, "s" . GS . $value . GS . $new_value);
}

# Pre Runner
sub assign_delay {
	my ($self, $mili_second, $index) = @_;
	$index = -1 if !defined $index;
	my $current_line = $self->_get_line_by_index($index);
	return if !defined $current_line || $current_line eq "";

	my @parts = split(/=/, $current_line, 2);
	my $new_name = ":" . $mili_second . ")" . $parts[0];
	my $new_value = (scalar(@parts) > 1) ? $parts[1] : "";

	$self->_update_line_by_index($index, $new_name, $new_value);
}

sub assign_delay_change {
	my ($self, $mili_second, $index) = @_;
	$index = -1 if !defined $index;
	my $current_line = $self->_get_line_by_index($index);
	return if !defined $current_line || $current_line eq "";

	my @parts = split(/=/, $current_line, 2);
	my $current_name = $parts[0];

	if ($current_name =~ /^:/ && $current_name =~ /\)/) {
		my $closing_bracket = index($current_name, ')');
		$current_name = substr($current_name, $closing_bracket + 1);
	}

	my $new_name = ":" . $mili_second . ")" . $current_name;
	my $new_value = (scalar(@parts) > 1) ? $parts[1] : "";

	$self->_update_line_by_index($index, $new_name, $new_value);
}

sub assign_interval {
	my ($self, $mili_second, $id, $index) = @_;
	$index = -1 if !defined $index;
	$id = "" if !defined $id;
	my $current_line = $self->_get_line_by_index($index);
	return if !defined $current_line || $current_line eq "";

	my @parts = split(/=/, $current_line, 2);
	my $id_part = ($id ne "") ? "|" . $id : "";
	my $new_name = "(" . $mili_second . $id_part . ")" . $parts[0];
	my $new_value = (scalar(@parts) > 1) ? $parts[1] : "";

	$self->_update_line_by_index($index, $new_name, $new_value);
}

sub assign_interval_change {
	my ($self, $mili_second, $id, $index) = @_;
	$index = -1 if !defined $index;
	$id = "" if !defined $id;
	my $current_line = $self->_get_line_by_index($index);
	return if !defined $current_line || $current_line eq "";

	my @parts = split(/=/, $current_line, 2);
	my $current_name = $parts[0];

	if ($current_name =~ /^\(/ && $current_name =~ /\)/) {
		my $closing_bracket = index($current_name, ')');
		$current_name = substr($current_name, $closing_bracket + 1);
	}

	my $id_part = ($id ne "") ? "|" . $id : "";
	my $new_name = "(" . $mili_second . $id_part . ")" . $current_name;
	my $new_value = (scalar(@parts) > 1) ? $parts[1] : "";

	$self->_update_line_by_index($index, $new_name, $new_value);
}

sub delete_interval {
	my ($self, $id) = @_;
	$self->_add("Di", $id);
}

sub assign_repeat {
	my ($self, $count, $index) = @_;
	$index = -1 if !defined $index;
	my $current_line = $self->_get_line_by_index($index);
	return if !defined $current_line || $current_line eq "";

	my @parts = split(/=/, $current_line, 2);
	my $new_name = "," . $count . ")" . $parts[0];
	my $new_value = (scalar(@parts) > 1) ? $parts[1] : "";

	$self->_update_line_by_index($index, $new_name, $new_value);
}

sub assign_repeat_change {
	my ($self, $count, $index) = @_;
	$index = -1 if !defined $index;
	my $current_line = $self->_get_line_by_index($index);
	return if !defined $current_line || $current_line eq "";

	my @parts = split(/=/, $current_line, 2);
	my $current_name = $parts[0];

	if ($current_name =~ /^,/ && $current_name =~ /\)/) {
		my $closing_bracket = index($current_name, ')');
		$current_name = substr($current_name, $closing_bracket + 1);
	}

	my $new_name = "," . $count . ")" . $current_name;
	my $new_value = (scalar(@parts) > 1) ? $parts[1] : "";

	$self->_update_line_by_index($index, $new_name, $new_value);
}

# Index
sub start_index {
	my ($self, $name) = @_;
	$name = "" if !defined $name;
	$self->_add("#", $name);
}

# This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
sub start_state {
	my ($self) = @_;
	$self->start_index('$');
}

sub go_to {
	my ($self, $line, $repeat) = @_;
	if (ref($line) eq '' && $line =~ /^-?\d+$/ && ref($repeat) eq '' && $repeat =~ /^-?\d+$/) {
		$self->_add("&", "$line" . GS . "$repeat");
	} elsif (ref($repeat) eq '' && $repeat =~ /^-?\d+$/) {
		$self->_add("&", "#" . $line . GS . "$repeat");
	} else {
		$repeat = 1 if !defined $repeat;
		$self->_add("&", "$line" . GS . "$repeat");
	}
}

# Start
sub start_transient_dom {
	my ($self, $input_place) = @_;
	$self->_add("td", $input_place);
}

sub end_transient_dom {
	my ($self) = @_;
	$self->_add("td", ";");
}

# Message
# Type: warning, problem, help, success, none
sub alert {
	my ($self, $text, $type, $title, $ok_text) = @_;
	$type = "none" if !defined $type;
	$title = "Alert" if !defined $title;
	$ok_text = "OK" if !defined $ok_text;
	$self->_add("Al", $text . GS . ($type eq "none" ? "" : $type) . GS . ($title eq "Alert" ? "" : $title) . GS . ($ok_text eq "OK" ? "" : $ok_text));
}

sub message {
	my ($self, $text, $type_or_duration, $duration) = @_;
	if (ref($type_or_duration) eq '' && $type_or_duration =~ /^-?\d+$/) {
		$self->_add("me", $text . GS . "" . GS . "$type_or_duration");
	} elsif (defined $duration && ref($duration) eq '' && $duration =~ /^-?\d+$/) {
		$self->_add("me", $text . GS . ($type_or_duration eq "none" ? "" : $type_or_duration) . GS . "$duration");
	} else {
		$type_or_duration = "none" if !defined $type_or_duration;
		$duration = "0" if !defined $duration;
		$self->_add("me", $text . GS . ($type_or_duration eq "none" ? "" : $type_or_duration) . GS . ($duration eq "0" ? "" : $duration));
	}
}

# Type: log, info, warn, error, debug, trace, group, groupend, table
sub console_message {
	my ($self, $text, $type) = @_;
	$type = "log" if !defined $type;
	$text =~ s/\n/\$[ln];/g;
	$self->_add("mc", $text . ($type eq "log" ? "" : GS . $type));
}

sub console_message_assert {
	my ($self, $text, $condition) = @_;
	$text =~ s/\n/\$[ln];/g;
	$self->_add("ma", $text . GS . $condition);
}

# Enable
# Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
sub enable_web_socket {
	my ($self, $enable) = @_;
	$enable = 1 if !defined $enable;
	$self->_add("ew", $enable ? "1" : "0");
}

sub enable_web_socket_once {
	my ($self) = @_;
	$self->_add("ew", '$');
}

sub add_web_socket {
	my ($self, $path) = @_;
	$self->_add("aw" . $path);
}

# Disconnected WebSocket
sub delete_web_socket {
	my ($self, $path) = @_;
	$self->_add("dw" . $path);
}

# Use
# InputPlace Using Only For form Element
sub use_web_socket {
	my ($self, $input_place) = @_;
	$self->_add("uw" . $input_place);
}

sub use_only_change_update {
	my ($self, $input_place) = @_;
	$self->_add("uo" . $input_place);
}

# Condition And Loop
# Condition And Loop Supports Brackets and Then
# Type: warning, problem, help, success, none
# Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
# Nested Conditions and Nested Loops are Possible.
sub confirm_is_true_accept {
	my ($self, $text, $type, $title, $ok_text, $cancel_text, $interval) = @_;
	$text = "Are you sure you want to proceed?" if !defined $text;
	$type = "none" if !defined $type;
	$title = "Confirm" if !defined $title;
	$ok_text = "OK" if !defined $ok_text;
	$cancel_text = "Cancel" if !defined $cancel_text;
	$interval = 100 if !defined $interval;
	
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	my $text_part = ($text eq "Are you sure you want to proceed?" ? "" : $text);
	my $type_part = ($type eq "none" ? "" : $type);
	my $title_part = ($title eq "Confirm" ? "" : $title);
	my $ok_part = ($ok_text eq "OK" ? "" : $ok_text);
	my $cancel_part = ($cancel_text eq "Cancel" ? "" : $cancel_text);
	
	$self->_add($prefix . "ct", $text_part . GS . $type_part . GS . $title_part . GS . $ok_part . GS . $cancel_part);
	return $self;
}

sub confirm_is_false_accept {
	my ($self, $text, $type, $title, $ok_text, $cancel_text, $interval) = @_;
	$text = "Are you sure you want to proceed?" if !defined $text;
	$type = "none" if !defined $type;
	$title = "Confirm" if !defined $title;
	$ok_text = "OK" if !defined $ok_text;
	$cancel_text = "Cancel" if !defined $cancel_text;
	$interval = 100 if !defined $interval;
	
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	my $text_part = ($text eq "Are you sure you want to proceed?" ? "" : $text);
	my $type_part = ($type eq "none" ? "" : $type);
	my $title_part = ($title eq "Confirm" ? "" : $title);
	my $ok_part = ($ok_text eq "OK" ? "" : $ok_text);
	my $cancel_part = ($cancel_text eq "Cancel" ? "" : $cancel_text);
	
	$self->_add($prefix . "cf", $text_part . GS . $type_part . GS . $title_part . GS . $ok_part . GS . $cancel_part);
	return $self;
}

sub is_greater_than {
	my ($self, $first_value, $second_value, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "gt", $first_value . GS . $second_value);
	return $self;
}

sub is_less_than {
	my ($self, $first_value, $second_value, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "lt", $first_value . GS . $second_value);
	return $self;
}

sub is_equal_to {
	my ($self, $first_value, $second_value, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "et", $first_value . GS . $second_value);
	return $self;
}

sub is_not_equal_to {
	my ($self, $first_value, $second_value, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "Nt", $first_value . GS . $second_value);
	return $self;
}

sub exist {
	my ($self, $value, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "ex", $value);
	return $self;
}

sub not_exist {
	my ($self, $value, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "nx", $value);
	return $self;
}

sub is_true {
	my ($self, $value, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "tr", $value);
	return $self;
}

sub is_false {
	my ($self, $value, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "fa", $value);
	return $self;
}

sub is_match_media {
	my ($self, $value, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "mm", $value);
	return $self;
}

sub is_not_match_media {
	my ($self, $value, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "nm", $value);
	return $self;
}

sub include {
	my ($self, $text, $value, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "In", $value . GS . $text);
	return $self;
}

sub not_include {
	my ($self, $text, $value, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "Nn", $value . GS . $text);
	return $self;
}

sub element_exists {
	my ($self, $input_place, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "eE", $input_place);
	return $self;
}

sub element_not_exists {
	my ($self, $input_place, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "nE", $input_place);
	return $self;
}

sub is_regex_match {
	my ($self, $value, $pattern, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "re", $value . GS . $pattern);
	return $self;
}

sub is_regex_not_match {
	my ($self, $value, $pattern, $interval) = @_;
	$interval = -1 if !defined $interval;
	my $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
	$self->_add($prefix . "rn", $value . GS . $pattern);
	return $self;
}

# In: Everything Becomes A JSON List.
# Key: Creates A Temporary Data In The Browser IndexedDB.
# Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
sub for_each {
	my ($self, $path, $in_val, $key) = @_;
	$key = "." if !defined $key;
	$self->_add("{fe", $path . GS . $in_val . GS . $key);
	return $self;
}

# 'break' is a reserved keyword in Perl, so 'wf_break' is used to preserve API intent without syntax errors.
sub wf_break {
	my ($self) = @_;
	$self->_add(";");
}

# 'else' is a reserved keyword in Perl, so 'wf_else' is used to preserve API intent without syntax errors.
sub wf_else {
	my ($self) = @_;
	$self->_add("}e");
	return $self;
}

sub start_bracket {
	my ($self) = @_;
	$self->_add("{");
}

sub end_bracket {
	my ($self) = @_;
	$self->_add("}");
}

# Used Then In Condition And Loop Methods
sub then_form {
	my ($self, $new_form) = @_;
	return $self if !defined $new_form;
	
	my $data = $new_form->get_web_forms_data();
	
	if (defined $data && $data ne "") {
		if ($data =~ /\n/) {
			$new_form->_add_to_up("{");
			$new_form->_add("}");
		}
	}
	
	$self->append_form($new_form);
	return $self;
}

sub repeat_form {
	my ($self, $new_form, $repeat, $index) = @_;
	return $self if !defined $new_form;

	if (defined $index) {
		$self->go_to($index);
		$self->start_index($index);
	}

	my $body_data = $new_form->get_web_forms_data();
	return $self if !defined $body_data || $body_data eq "";

	if (!defined $index) {
		my @lines = split(/\n/, $body_data, -1);
		my $start_line = scalar(@lines) * -1;
		$self->append_form($new_form);
		$self->go_to("$start_line", $repeat - 1);
	} else {
		$self->append_form($new_form);
		$self->go_to($index, $repeat - 1);
	}

	return $self;
}

# Async
# It Supports Brackets and Then
sub async_action {
	my ($self) = @_;
	$self->_add("{(a)");
	return $self;
}

sub delay {
	my ($self, $mili_second) = @_;
	$self->_add("De", "$mili_second");
}

# Option
sub change_option {
	my ($self, $name, $value) = @_;
	$self->_add("co", $name . GS . $value);
}

sub reset_option {
	my ($self, $name) = @_;
	if (!defined $name) {
		$self->_add("ro");
	} else {
		$self->_add("ro", $name);
	}
}

# Format Storage
sub create_format_storage {
	my ($self, $key, $data) = @_;
	$self->_add(".C", $key . GS . $data);
}

sub delete_format_storage {
	my ($self, $key) = @_;
	$self->_add(".D", $key);
}

sub add_json {
	my ($self, $key, $path, $value) = @_;
	$self->_add(".a", $key . GS . "j" . GS . $value . GS . $path);
}

# Name: For Support Attribute, Set Double At Sign (@@) Before Name.
sub add_xml {
	my ($self, $key, $path, $name, $value) = @_;
	$value = "" if !defined $value;
	$self->_add(".a", $key . GS . "x" . GS . $name . GS . $value . GS . $path);
}

sub add_ini {
	my ($self, $key, $path, $value, $is_ini_like) = @_;
	$is_ini_like = 0 if !defined $is_ini_like;
	$self->_add(".a", $key . GS . "i" . GS . ($is_ini_like ? "1" : "0") . GS . $value . GS . $path);
}

sub add_text_line {
	my ($self, $key, $line, $text) = @_;
	$self->_add(".a", $key . GS . "t" . GS . $text . GS . "$line");
}

sub add_variable {
	my ($self, $key, $value) = @_;
	$self->_add(".a", $key . GS . "v" . GS . $value);
}

sub update_json {
	my ($self, $key, $path, $value) = @_;
	$self->_add(".u", $key . GS . "j" . GS . $value . GS . $path);
}

sub update_xml {
	my ($self, $key, $path, $value) = @_;
	$self->_add(".u", $key . GS . "x" . GS . $value . GS . $path);
}

sub update_ini {
	my ($self, $key, $path, $value, $is_ini_like) = @_;
	$is_ini_like = 0 if !defined $is_ini_like;
	$self->_add(".u", $key . GS . "i" . GS . ($is_ini_like ? "1" : "0") . GS . $value . GS . $path);
}

# Note: C# original has a typo 'UpdateTexLine', mapped to 'update_text_line' for Perl standards while preserving exact logic.
sub update_text_line {
	my ($self, $key, $line, $text) = @_;
	$self->_add(".u", $key . GS . "t" . GS . $text . GS . "$line");
}

sub update_variable {
	my ($self, $key, $value) = @_;
	$self->_add(".u", $key . GS . "v" . GS . $value);
}

sub increase_variable {
	my ($self, $key, $value) = @_;
	$self->_add(".i", $key . GS . "v" . GS . "$value");
}

sub decrease_variable {
	my ($self, $key, $value) = @_;
	$self->increase_variable($key, $value * -1);
}

sub delete_json {
	my ($self, $key, $path) = @_;
	$self->_add(".d", $key . GS . "j" . GS . $path);
}

sub delete_xml {
	my ($self, $key, $path) = @_;
	$self->_add(".d", $key . GS . "x" . GS . $path);
}

sub delete_ini {
	my ($self, $key, $path, $is_ini_like) = @_;
	$is_ini_like = 0 if !defined $is_ini_like;
	$self->_add(".d", $key . GS . "i" . GS . ($is_ini_like ? "1" : "0") . GS . $path);
}

sub delete_text_line {
	my ($self, $key, $line) = @_;
	$self->_add(".d", $key . GS . "t" . GS . "$line");
}

sub delete_variable {
	my ($self, $key) = @_;
	$self->_add(".d", $key . GS . "v");
}

# Template Engine
# Pattern Example: {{value}}, ((value)), *value*, $value;
sub bind_json_to_template {
	my ($self, $input_place, $json_text, $path, $pattern, $also_start_tag) = @_;
	$also_start_tag = 1 if !defined $also_start_tag;
	$self->_add("Tj" . $input_place, $json_text . GS . $path . GS . $pattern . GS . ($also_start_tag ? "1" : "0"));
}

# Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
sub bind_xml_to_template {
	my ($self, $input_place, $xml_text, $path, $pattern, $also_start_tag) = @_;
	$also_start_tag = 1 if !defined $also_start_tag;
	$self->_add("Tx" . $input_place, $xml_text . GS . $path . GS . $pattern . GS . ($also_start_tag ? "1" : "0"));
}

sub bind_ini_to_template {
	my ($self, $input_place, $ini_text, $path, $pattern, $also_start_tag) = @_;
	$also_start_tag = 1 if !defined $also_start_tag;
	$self->_add("Ti" . $input_place, $ini_text . GS . $path . GS . $pattern . GS . ($also_start_tag ? "1" : "0"));
}

# Inject
# Need Add @: to First of String
sub inject {
	my ($self, $value) = @_;
	return "\$[" . $value . "];";
}

# Action Control
sub replace_action_control {
	my ($self, $search_value, $value, $adding_to_up) = @_;
	$adding_to_up = 0 if !defined $adding_to_up;
	if ($adding_to_up) {
		$self->_add_to_up("rE", $search_value . GS . $value);
	} else {
		$self->_add("rE", $search_value . GS . $value);
	}
}

sub assign_replace {
	my ($self, $search_value, $value, $index) = @_;
	$index = -1 if !defined $index;
	my $current_line = $self->_get_line_by_index($index);
	return if !defined $current_line || $current_line eq "";

	my @parts = split(/=/, $current_line, 2);
	my $new_name = ";" . $search_value . GS . $value . GS . $parts[0];
	my $new_value = (scalar(@parts) > 1) ? $parts[1] : "";

	$self->_update_line_by_index($index, $new_name, $new_value);
}

# Hash And Checksum
sub set_hash {
	my ($self) = @_;
	$self->_add("SH");
}

sub set_checksum {
	my ($self) = @_;
	$self->_add("CS");
}

sub checksum_calculation {
	my ($self, $text) = @_;
	my $sum = 0;
	my $mod = 65536;
	my $shift = 5;

	foreach my $c (split(//, $text)) {
		$sum = ((($sum << $shift) | ($sum >> (16 - $shift))) ^ ord($c)) % $mod;
	}

	return "$sum";
}

sub get_checksum {
	my ($self) = @_;
	return $self->checksum_calculation($self->get_web_forms_data());
}

# Get
sub get_forms_action_data {
	my ($self) = @_;
	return "" if length($self->{web_forms_data}) == 0;
	return $self->{web_forms_data};
}

sub response {
	my ($self) = @_;
	return "[web-forms]\n" . $self->get_forms_action_data();
}

sub get_forms_action_data_line_break {
	my ($self) = @_;
	return "" if length($self->{web_forms_data}) == 0;

	my $data = $self->{web_forms_data};
	my $processed_data = $data;
	$processed_data =~ s/"/\$[dq];/g;
	$processed_data =~ s/\n/\$[sln];/g;
	return $processed_data;
}

# Export
sub export_to_html_comment {
	my ($self, $add_line) = @_;
	$add_line = 0 if !defined $add_line;
	my $response_str = $self->response();
	$response_str =~ s/--/\$[dd];/g;
	if (substr($response_str, -1) eq '-') {
		$response_str = substr($response_str, 0, -1) . "\$[da];";
	}

	return ($add_line ? "\n" : "") . "<!--" . $response_str . "-->";
}

# Using it for SSE Response
sub export_to_line_break {
	my ($self, $src) = @_;
	return "[web-forms]\$[sln];" . $self->get_forms_action_data_line_break();
}

sub get_web_forms_data {
	my ($self) = @_;
	return $self->{web_forms_data};
}

sub append_form {
	my ($self, $form) = @_;
	return if !defined $form;

	my $other_data = $form->get_web_forms_data();
	if (defined $other_data && $other_data ne "") {
		if (length($self->{web_forms_data}) > 0) {
			$self->{web_forms_data} .= "\n";
		}
		$self->{web_forms_data} .= $other_data;
	}
}

sub clean {
	my ($self) = @_;
	$self->{web_forms_data} = "";
}

package Security;
use strict;
use warnings;
use v5.36;

sub new {
    my ($class) = @_;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub safe_value {
    my ($self, $value) = @_;
    return $value if length($value) < 1;

    $value = '@' . $value if substr($value, 0, 1) eq '@';

    $value =~ s/\n/\$[ln];/g;
    $value =~ s/,@/\$[co];@/g;
    $value =~ s/\x{1c}/\0/g;
    $value =~ s/\x{1d}/\0/g;
    $value =~ s/\x{1e}/\0/g;
    $value =~ s/\x{1f}/\0/g;

    return $value;
}

# WebForms Place Criteria (WPC) DSL
package InputPlace;
use strict;
use warnings;
use v5.36;

use constant Document => ",";
use constant Window => "`";
# When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
use constant Root => "~";
use constant HTML => ".";
use constant Head => "^";
use constant ScreenOrientation => "%";
use constant All => "*";
use constant Parent => "/";
use constant Current => '$';
use constant Target => "!";
use constant Upper => "-";

sub id {
    my ($id_val) = @_;
    return $id_val;
}

sub name {
    my ($name_val, $index) = @_;
    if (!defined $index) {
        return '(' . $name_val . ')';
    } else {
        return '(' . $name_val . ')' . $index;
    }
}

sub all_names {
    my ($name_val) = @_;
    return "(" . $name_val . ")*";
}

sub tag {
    my ($tag_val, $index) = @_;
    if (!defined $index) {
        return '<' . $tag_val . '>';
    } else {
        return '<' . $tag_val . '>' . $index;
    }
}

sub all_tags {
    my ($tag_val) = @_;
    return "<" . $tag_val . ">*";
}

sub child {
    my ($index) = @_;
    if (!defined $index) {
        return "<>";
    } else {
        return "<>" . $index;
    }
}

sub all_child {
    my ($class) = @_;
    return "<>*";
}

sub class_name {
    my ($class_val, $index) = @_;
    if (!defined $index) {
        return '{' . $class_val . '}';
    } else {
        return '{' . $class_val . '}' . $index;
    }
}

sub all_classes {
    my ($class_val) = @_;
    return "{" . $class_val . "}*";
}

sub attribute {
    my ($name_val, $value_or_index, $operator_or_nil, $index) = @_;
    if (!defined $value_or_index) {
        return '"' . $name_val . '"';
    } elsif (!defined $index && (!defined $operator_or_nil || $operator_or_nil eq "\0")) {
        return '"' . $name_val . '"' . $value_or_index;
    } else {
        my $op = (!defined $operator_or_nil || $operator_or_nil eq "\0") ? "" : $operator_or_nil;
        if (!defined $index) {
            return '"' . $name_val . $op . "'" . $value_or_index . '"';
        } else {
            return '"' . $name_val . $op . "'" . $value_or_index . '"' . $index;
        }
    }
}

sub all_attributes {
    my ($name_val, $value, $operator) = @_;
    if (!defined $value) {
        return "\"" . $name_val . "\"*";
    } else {
        my $op = (!defined $operator || $operator eq "\0") ? "" : $operator;
        return "\"" . $name_val . $op . "'" . $value . "\"*";
    }
}

sub query {
    my ($query_val) = @_;
    my $res = $query_val;
    $res =~ s/=/\$[eq];/g;
    $res =~ s/\|/\$[vb];/g;
    $res =~ s/\?/\$[qu];/g;
    return "*" . $res;
}

sub query_all {
    my ($query_val) = @_;
    my $res = $query_val;
    $res =~ s/=/\$[eq];/g;
    $res =~ s/\|/\$[vb];/g;
    $res =~ s/\?/\$[qu];/g;
    return "[" . $res;
}

package OutputPlace;
use strict;
use warnings;
use v5.36;
use parent -norequire, 'InputPlace';

# Do not Add any Data Before or After it
package Fetch;
use strict;
use warnings;
use v5.36;

use constant RS => chr(30);
use constant US => chr(31);

# Method
sub random {
    my ($max_value, $min_value) = @_;
    if (!defined $min_value) {
        return '@mr' . $max_value;
    } else {
        return '@mr' . $max_value . RS . $min_value;
    }
}

sub space_to_char {
    my ($text, $character) = @_;
    $character = "-" if !defined $character;
    return '@sc' . $character . RS . $text;
}

sub encode_uri {
    my ($text) = @_;
    return '@ue' . $text;
}

sub decode_uri {
    my ($text) = @_;
    return '@ud' . $text;
}

sub method {
    my ($method_name, $args) = @_;
    my $return_value = '@cm' . $method_name;
    if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
        $return_value .= RS . join(US, @$args);
    }
    return $return_value;
}

sub module_method {
    my ($method_name, $args) = @_;
    my $return_value = '@cM' . $method_name;
    if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
        $return_value .= RS . join(US, @$args);
    }
    return $return_value;
}

# MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
sub wasm_method {
    my ($wasm_language, $wasm_url, $method_name, $args, $key) = @_;
    $key = "." if !defined $key;
    my $return_value = '@wA' . $wasm_language . RS . $wasm_url . RS . $method_name;
    if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
        $return_value .= RS . join(US, @$args);
    }
    return $return_value;
}

sub script {
    my ($script_text) = @_;
    $script_text =~ s/\n/\$[ln];/g;
    return '@_' . $script_text;
}

sub load_url {
    my ($url, $fetch_script) = @_;
    $fetch_script = 0 if !defined $fetch_script;
    return '@lu' . $url . ($fetch_script ? RS . "1" : "");
}

sub load_html {
    my ($url, $fetch_input_place, $fetch_script) = @_;
    $fetch_input_place = "" if !defined $fetch_input_place;
    $fetch_script = 0 if !defined $fetch_script;
    my $fetch_input_part = ($fetch_input_place ne "") ? RS . $fetch_input_place : "";
    return '@lh' . $url . RS . ($fetch_script ? "1" : "0") . $fetch_input_part;
}

sub load_line {
    my ($url, $line) = @_;
    return '@ll' . $url . RS . $line;
}

sub load_ini {
    my ($url, $name, $is_ini_like) = @_;
    $is_ini_like = 0 if !defined $is_ini_like;
    return '@li' . $url . RS . $name . ($is_ini_like ? RS . "1" : "");
}

# Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
sub load_json {
    my ($url, $name) = @_;
    return '@lj' . $url . RS . $name;
}

# Name: Name Or XPath; XPath Index Starts At 1
sub load_xml {
    my ($url, $name) = @_;
    return '@lx' . $url . RS . $name;
}

# MethodName: It's Check Function Or Variable
sub has_method {
    my ($method_name) = @_;
    return '@hm' . $method_name;
}

sub has_module_method {
    my ($method_name) = @_;
    return '@hM' . $method_name;
}

# This Method Return True Or False If Key Pressed
# Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
sub get_modifier_state {
    my ($modifier) = @_;
    return '@ms' . $modifier;
}

# Math
sub math {
    my ($method_name, $args) = @_;
    my $return_value = '@M#' . $method_name;
    if (defined $args && ref($args) eq 'ARRAY' && scalar(@$args) > 0) {
        $return_value .= RS . join(US, @$args);
    }
    return $return_value;
}

# Data
use constant DateYear => '@dy';
# Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1 
use constant DateMonth => '@dm';
use constant DateDay => '@dd';
use constant DateDate => '@dD';
use constant DateHours => '@dh';
use constant DateMinutes => '@di';
use constant DateSeconds => '@ds';
use constant DateMilliseconds => '@dl';

# String
use constant Space => '@sp';
use constant AtSign => '@sa';

# Tag
sub get_id {
    my ($input_place) = @_;
    return '@$i' . $input_place;
}

sub get_name {
    my ($input_place) = @_;
    return '@$n' . $input_place;
}

sub get_value {
    my ($input_place) = @_;
    return '@$v' . $input_place;
}

sub get_value_length {
    my ($input_place) = @_;
    return '@$e' . $input_place;
}

sub get_class {
    my ($input_place) = @_;
    return '@$c' . $input_place;
}

sub get_style {
    my ($input_place) = @_;
    return '@$s' . $input_place;
}

sub get_title {
    my ($input_place) = @_;
    return '@$l' . $input_place;
}

sub get_label {
    my ($input_place) = @_;
    return '@$A' . $input_place;
}

sub get_text {
    my ($input_place) = @_;
    return '@$t' . $input_place;
}

sub get_outer_text {
    my ($input_place) = @_;
    return '@$o' . $input_place;
}

sub get_text_length {
    my ($input_place) = @_;
    return '@$g' . $input_place;
}

sub get_attribute {
    my ($input_place, $attribute) = @_;
    return '@$a' . $input_place . RS . $attribute;
}

sub get_width {
    my ($input_place) = @_;
    return '@$w' . $input_place;
}

sub get_height {
    my ($input_place) = @_;
    return '@$h' . $input_place;
}

sub get_is_read_only {
    my ($input_place) = @_;
    return '@$r' . $input_place;
}

sub get_selected_index {
    my ($input_place) = @_;
    return '@$x' . $input_place;
}

sub get_index {
    my ($input_place) = @_;
    return '@$I' . $input_place;
}

sub get_text_align {
    my ($input_place) = @_;
    return '@$T' . $input_place;
}

sub get_node_length {
    my ($input_place) = @_;
    return '@$L' . $input_place;
}

sub get_is_visible {
    my ($input_place) = @_;
    return '@$V' . $input_place;
}

# Save
sub has_hash {
    my ($hash_val) = @_;
    return '@HH' . $hash_val;
}

sub cookie {
    my ($key) = @_;
    return '@co' . $key;
}

sub save {
    my ($key, $replace_value) = @_;
    $key = "." if !defined $key;
    if (!defined $replace_value) {
        return '@cs' . $key;
    } else {
        return '@cs' . $key . RS . $replace_value;
    }
}

sub save_then_remove {
    my ($key) = @_;
    return '@cl' . $key;
}

sub save_length {
    my ($key) = @_;
    $key = "." if !defined $key;
    return '@cg' . $key;
}

sub cache {
    my ($key, $replace_value) = @_;
    $key = "." if !defined $key;
    if (!defined $replace_value) {
        return '@cd' . $key;
    } else {
        return '@cd' . $key . RS . $replace_value;
    }
}

sub cache_then_remove {
    my ($key) = @_;
    return '@ct' . $key;
}

sub cache_length {
    my ($key) = @_;
    $key = "." if !defined $key;
    return '@cG' . $key;
}

sub save_line {
    my ($key, $line) = @_;
    $key = "." if !defined $key;
    $line = 0 if !defined $line;
    return '@lL' . $key . "[" . $line;
}

sub save_line_consume {
    my ($key) = @_;
    $key = "." if !defined $key;
    return '@lL' . $key;
}

# INIKey: Only Direct Key is Supported
sub save_ini {
    my ($key, $ini_key) = @_;
    return '@lI' . $key . "[" . $ini_key;
}

sub cache_line {
    my ($key, $line) = @_;
    $key = "." if !defined $key;
    $line = 0 if !defined $line;
    return '@dL' . $key . "[" . $line;
}

sub cache_line_consume {
    my ($key) = @_;
    $key = "." if !defined $key;
    return '@dL' . $key;
}

# INIKey: Only Direct Key is Supported
sub cache_ini {
    my ($key, $ini_key) = @_;
    return '@dI' . $key . "[" . $ini_key;
}

# Format Storage
sub format_store {
    my ($key) = @_;
    return '@fr' . $key;
}

sub format_store_by_xml_query {
    my ($key, $xpath) = @_;
    return '@fx' . $key . RS . $xpath;
}

sub format_store_by_json_query {
    my ($key, $query) = @_;
    return '@fj' . $key . RS . $query;
}

sub format_store_by_ini {
    my ($key, $name) = @_;
    return '@fi' . $key . RS . $name;
}

sub format_store_by_text {
    my ($key, $line) = @_;
    return '@ft' . $key . RS . $line;
}

sub format_store_by_variable {
    my ($key) = @_;
    return '@fv' . $key;
}

# State
sub has_state {
    my ($path) = @_;
    return '@hs' . $path;
}

# SSE
sub sse_is_connected {
    my ($path) = @_;
    return '@Sc' . $path;
}

# WebSockets
sub web_sockets_is_connected {
    my ($path) = @_;
    $path = "" if !defined $path;
    return '@Wc' . $path;
}

# Document
use constant TabIsActive => '@da';

# Window
use constant Href => '@wf';
use constant PathName => '@wP';

sub query {
    my ($name) = @_;
    $name = "*" if !defined $name;
    return '@wq' . $name;
}

use constant Hash => '@wh';
use constant Host => '@wH';
use constant HostName => '@wn';
use constant Port => '@wT';
use constant Origin => '@wo';
use constant GetSelection => '@ws';
use constant ScrollX => '@wx';
use constant ScrollY => '@wy';

sub segment {
    my ($index) = @_;
    return '@wS' . $index;
}

# It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
sub hash_segment {
    my ($index) = @_;
    return '@wt' . $index;
}

# Navigator
use constant ClipboardText => '@nC';
use constant GeoLatitude => '@nW';
use constant GeoLongitude => '@nO';
use constant Language => '@nL';
use constant IsOnLine => '@no';
use constant UserAgent => '@na';

# Screen
use constant ScreenWidth => '@sw';
use constant ScreenHeight => '@sh';
use constant ScreenOrientationType => '@so';
use constant ScreenOrientationAngle => '@sr';

# Performance
use constant TimeOrigin => '@pt';
use constant PerformanceNow => '@pn';

# Event
use constant Event => '@EV';
use constant EventSerialize => '@Es';
use constant EventKey => '@ek';
use constant EventWhich => '@ew';
use constant EventClientX => '@ex';
use constant EventClientY => '@ey';
use constant EventPageX => '@eX';
use constant EventPageY => '@eY';
use constant EventOffsetX => '@Ex';
use constant EventOffsetY => '@Ey';
use constant EventDeltaY => '@ed';

package WasmLanguage;
use strict;
use warnings;
use v5.36;

# The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
use constant C => "c";
use constant CPP => "c";
use constant Rust => "rust";
use constant CSharp => "csharp";
# .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
use constant CSharpMediator => "csharp-m";
use constant GO => "go";
use constant JAVA => "java";
use constant AssemblyScript => "as";

package HtmlEvent;
use strict;
use warnings;
use v5.36;

use constant OnAbort => "onabort";
use constant OnAfterPrint => "onafterprint";
use constant OnBeforePrint => "onbeforeprint";
use constant OnBeforeUnload => "onbeforeunload";
use constant OnBlur => "onblur";
use constant OnCanPlay => "oncanplay";
use constant OnCanPlayThrough => "oncanplaythrough";
use constant OnChange => "onchange";
use constant OnClick => "onclick";
use constant OnCopy => "oncopy";
use constant OnCut => "oncut";
use constant OnDoubleClick => "ondblclick";
use constant OnDrag => "ondrag";
use constant OnDragEnd => "ondragend";
use constant OnDragEnter => "ondragenter";
use constant OnDragLeave => "ondragleave";
use constant OnDragOver => "ondragover";
use constant OnDragStart => "ondragstart";
use constant OnDrop => "ondrop";
use constant OnDurationChange => "ondurationchange";
use constant OnEnded => "onended";
use constant OnError => "onerror";
use constant OnFocus => "onfocus";
use constant OnFocusin => "onfocusin";
use constant OnFocusOut => "onfocusout";
use constant OnHashChange => "onhashchange";
use constant OnInput => "oninput";
use constant OnInvalid => "oninvalid";
use constant OnKeyDown => "onkeydown";
use constant OnKeyPress => "onkeypress";
use constant OnKeyUp => "onkeyup";
use constant OnLoad => "onload";
use constant OnLoadedData => "onloadeddata";
use constant OnLoadedMetaData => "onloadedmetadata";
use constant OnLoadStart => "onloadstart";
use constant OnMouseDown => "onmousedown";
use constant OnMouseEnter => "onmouseenter";
use constant OnMouseLeave => "onmouseleave";
use constant OnMouseMove => "onmousemove";
use constant OnMouseOver => "onmouseover";
use constant OnMouseOut => "onmouseout";
use constant OnMouseUp => "onmouseup";
use constant OnOffline => "onoffline";
use constant OnOnline => "ononline";
use constant OnPageHide => "onpagehide";
use constant OnPageShow => "onpageshow";
use constant OnPaste => "onpaste";
use constant OnPause => "onpause";
use constant OnPlay => "onplay";
use constant OnPlaying => "onplaying";
use constant OnProgress => "onprogress";
use constant OnRateChange => "onratechange";
use constant OnResize => "onresize";
use constant OnReset => "onreset";
use constant OnScroll => "onscroll";
use constant OnSearch => "onsearch";
use constant OnSeeked => "onseeked";
use constant OnSeeking => "onseeking";
use constant OnSelect => "onselect";
use constant OnStalled => "onstalled";
use constant OnSubmit => "onsubmit";
use constant OnSuspend => "onsuspend";
use constant OnTimeUpdate => "ontimeupdate";
use constant OnToggle => "ontoggle";
use constant OnTouchCancel => "ontouchcancel";
use constant OnTouchend => "ontouchend";
use constant OnTouchMove => "ontouchmove";
use constant OnTouchStart => "ontouchstart";
use constant OnUnload => "onunload";
use constant OnVolumeChange => "onvolumechange";
use constant OnWaiting => "onwaiting";
use constant OnWheel => "onwheel";

package HtmlEventListener;
use strict;
use warnings;
use v5.36;

use constant Abort => "abort";
use constant AfterPrint => "afterprint";
use constant BeforePrint => "beforeprint";
use constant BeforeUnload => "beforeunload";
use constant Blur => "blur";
use constant CanPlay => "canplay";
use constant CanPlayThrough => "canplaythrough";
use constant Change => "change";
use constant Click => "click";
use constant Copy => "copy";
use constant Cut => "cut";
use constant DoubleClick => "dblclick";
use constant Drag => "drag";
use constant DragEnd => "dragend";
use constant DragEnter => "dragenter";
use constant DragLeave => "dragleave";
use constant DragOver => "dragover";
use constant DragStart => "dragstart";
use constant Drop => "drop";
use constant DurationChange => "durationchange";
use constant Ended => "ended";
use constant Error => "error";
use constant Focus => "focus";
use constant Focusin => "focusin";
use constant FocusOut => "focusout";
use constant HashChange => "hashchange";
use constant Input => "input";
use constant Invalid => "invalid";
use constant KeyDown => "keydown";
use constant KeyPress => "keypress";
use constant KeyUp => "keyup";
use constant Load => "load";
use constant LoadedData => "loadeddata";
use constant LoadedMetaData => "loadedmetadata";
use constant LoadStart => "loadstart";
use constant MouseDown => "mousedown";
use constant MouseEnter => "mouseenter";
use constant MouseLeave => "mouseleave";
use constant MouseMove => "mousemove";
use constant MouseOver => "mouseover";
use constant MouseOut => "mouseout";
use constant MouseUp => "mouseup";
use constant Offline => "offline";
use constant Online => "online";
use constant PageHide => "pagehide";
use constant PageShow => "pageshow";
use constant Paste => "paste";
use constant Pause => "pause";
use constant Play => "play";
use constant Playing => "playing";
use constant Progress => "progress";
use constant RateChange => "ratechange";
use constant Resize => "resize";
use constant Reset => "reset";
use constant Scroll => "scroll";
use constant Search => "search";
use constant Seeked => "seeked";
use constant Seeking => "seeking";
use constant Select => "select";
use constant Stalled => "stalled";
use constant Submit => "submit";
use constant Suspend => "suspend";
use constant TimeUpdate => "timeupdate";
use constant Toggle => "toggle";
use constant TouchCancel => "touchcancel";
use constant Touchend => "touchend";
use constant TouchMove => "touchmove";
use constant TouchStart => "touchstart";
use constant Unload => "unload";
use constant VolumeChange => "volumechange";
use constant Waiting => "waiting";
use constant Wheel => "wheel";

use constant AnimationEnd => "animationend";
use constant AnimationIteration => "animationiteration";
use constant AnimationStart => "animationstart";
use constant ContextMenu => "contextmenu";
use constant FullScreenChange => "fullscreenchange";
use constant FullScreenError => "fullscreenerror";
use constant PopState => "popstate";
use constant TransitionEnd => "transitionend";
use constant Storage => "storage";

# Custom
use constant ScrollBottom => "scrollbottom"; # Need Call EnableScrollBottomEvent Method Before
use constant ElementReached => "elementreached"; # Need Call EnableReachedElementEvent Method Before

package Extension;
use strict;
use warnings;
use v5.36;

# Simulates C# Extension Methods for strings in a natural Perl way.
sub child {
    my ($text, $value) = @_;
    return $value if length($text) < 1;
    return $text . "|" . $value;
}

sub parent {
    my ($text) = @_;
    return $text if length($text) < 1;
    if ($text =~ /\|\/$/ || $text =~ /\/\//) {
        return $text . '/';
    }
    return $text . "|/";
}

sub criteria {
    my ($text, $value) = @_;
    return $value if length($text) < 1;
    my $res = $value;
    $res =~ s/\|/\$[vb];/g;
    $res =~ s/\?/\$[qu];/g;
    return $text . "?" . $res;
}

sub append_fetch_replace {
    my ($text, $search_value, $value) = @_;
    my $fs = chr(28);
    my $clean_text = substr($text, 1);
    return '@;' . $search_value . $fs . $value . $fs . $clean_text;
}

sub line_break {
    my ($text, $encode_line) = @_;
    $encode_line = 0 if !defined $encode_line;
    my $encode = $encode_line ? "\$[sln];" : "";
    my $res = $text;
    $res =~ s/\r\n/$encode/g;
    $res =~ s/\n/$encode/g;
    $res =~ s/\r/$encode/g;
    return $res;
}

# Converts Numbers to Strings
sub to_js_string {
    my ($text) = @_;
    return "\"" . $text . "\"";
}

# Get JS Object Momentary 
sub to_js_object {
    my ($text) = @_;
    return "\$" . $text;
}

# Get JS Object Returned Value Once
sub to_js_return_object {
    my ($text) = @_;
    return "\$@" . $text;
}

1;
