// WebForms.h 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.1

#ifndef WEBFORMS_H
#define WEBFORMS_H

#include <stddef.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>

#define WEBFORMS_GS ((char)29)
#define WEBFORMS_US ((char)31)
#define WEBFORMS_RS ((char)30)
#define WEBFORMS_FS ((char)28)

#define WEBFORMS_GS_STR "\x1D"
#define WEBFORMS_US_STR "\x1F"
#define WEBFORMS_RS_STR "\x1E"
#define WEBFORMS_FS_STR "\x1C"

// ============================================================
// Internal String Helpers
// ============================================================

static inline const char *webforms_internal_bool_to_cs(bool b)
{
    return b ? "True" : "False";
}

static inline char *webforms_internal_strdup(const char *s)
{
    if (!s) return NULL;
    size_t len = strlen(s);
    char *r = (char *)malloc(len + 1);
    if (r) memcpy(r, s, len + 1);
    return r;
}

static inline char *webforms_internal_concat2(const char *a, const char *b)
{
    size_t la = a ? strlen(a) : 0;
    size_t lb = b ? strlen(b) : 0;
    char *r = (char *)malloc(la + lb + 1);
    if (la) memcpy(r, a, la);
    if (lb) memcpy(r + la, b, lb);
    r[la + lb] = '\0';
    return r;
}

static inline char *webforms_internal_join(const char *const *parts, size_t n)
{
    size_t total = 0;
    for (size_t i = 0; i < n; i++) total += parts[i] ? strlen(parts[i]) : 0;
    char *r = (char *)malloc(total + 1);
    size_t pos = 0;
    for (size_t i = 0; i < n; i++) {
        if (parts[i]) {
            size_t l = strlen(parts[i]);
            memcpy(r + pos, parts[i], l);
            pos += l;
        }
    }
    r[pos] = '\0';
    return r;
}

static inline char *webforms_internal_str_replace_all(const char *src, const char *old_s, const char *new_s)
{
    if (!src) return NULL;
    if (!old_s || old_s[0] == '\0') return webforms_internal_strdup(src);
    size_t src_len = strlen(src);
    size_t old_len = strlen(old_s);
    size_t new_len = new_s ? strlen(new_s) : 0;
    size_t count = 0;
    const char *p = src;
    const char *q;
    while ((q = strstr(p, old_s)) != NULL) { count++; p = q + old_len; }
    if (count == 0) return webforms_internal_strdup(src);
    size_t out_len = src_len + count * (new_len >= old_len ? (new_len - old_len) : 0) - (new_len < old_len ? count * (old_len - new_len) : 0);
    char *out = (char *)malloc(out_len + 1);
    char *dst = out;
    p = src;
    while ((q = strstr(p, old_s)) != NULL) {
        size_t chunk = (size_t)(q - p);
        memcpy(dst, p, chunk);
        dst += chunk;
        if (new_len) { memcpy(dst, new_s, new_len); dst += new_len; }
        p = q + old_len;
    }
    strcpy(dst, p);
    return out;
}

static inline char *webforms_internal_char_replace_all(const char *src, char c, const char *new_s)
{
    if (!src) return NULL;
    size_t src_len = strlen(src);
    size_t new_len = new_s ? strlen(new_s) : 0;
    size_t count = 0;
    for (size_t i = 0; i < src_len; i++) if (src[i] == c) count++;
    if (count == 0) return webforms_internal_strdup(src);
    size_t out_len = src_len + count * (new_len >= 1 ? (new_len - 1) : 0) - (new_len < 1 ? count : 0);
    char *out = (char *)malloc(out_len + 1);
    char *dst = out;
    for (size_t i = 0; i < src_len; i++) {
        if (src[i] == c) {
            if (new_len) { memcpy(dst, new_s, new_len); dst += new_len; }
        } else {
            *dst++ = src[i];
        }
    }
    *dst = '\0';
    return out;
}

static inline bool webforms_internal_starts_with(const char *s, const char *prefix)
{
    if (!s || !prefix) return false;
    size_t lp = strlen(prefix);
    return strncmp(s, prefix, lp) == 0;
}

static inline char **webforms_internal_split_lines(const char *data, size_t *out_count)
{
    size_t count = 1;
    for (const char *p = data; *p; p++) if (*p == '\n') count++;
    char **lines = (char **)malloc(sizeof(char *) * count);
    size_t idx = 0;
    const char *start = data;
    const char *p = data;
    while (1) {
        if (*p == '\n' || *p == '\0') {
            size_t len = (size_t)(p - start);
            char *line = (char *)malloc(len + 1);
            memcpy(line, start, len);
            line[len] = '\0';
            lines[idx++] = line;
            if (*p == '\0') break;
            start = p + 1;
        }
        p++;
    }
    *out_count = count;
    return lines;
}

static inline void webforms_internal_free_lines(char **lines, size_t count)
{
    if (!lines) return;
    for (size_t i = 0; i < count; i++) free(lines[i]);
    free(lines);
}

// ============================================================
// WebForms struct
// ============================================================

typedef struct WebForms {
    char *data;
    size_t length;
    size_t capacity;
} WebForms;

static inline void webforms_internal_ensure_cap(WebForms *self, size_t needed)
{
    if (self->capacity >= needed) return;
    size_t newcap = self->capacity == 0 ? 64 : self->capacity;
    while (newcap < needed) newcap *= 2;
    self->data = (char *)realloc(self->data, newcap);
    self->capacity = newcap;
}

static inline void webforms_internal_append_str(WebForms *self, const char *s)
{
    if (!s) return;
    size_t slen = strlen(s);
    if (slen == 0) return;
    webforms_internal_ensure_cap(self, self->length + slen + 1);
    memcpy(self->data + self->length, s, slen);
    self->length += slen;
    self->data[self->length] = '\0';
}

static inline void webforms_internal_append_char(WebForms *self, char c)
{
    webforms_internal_ensure_cap(self, self->length + 2);
    self->data[self->length++] = c;
    self->data[self->length] = '\0';
}

static inline void webforms_internal_prepend_str(WebForms *self, const char *s)
{
    if (!s) return;
    size_t slen = strlen(s);
    if (slen == 0) return;
    webforms_internal_ensure_cap(self, self->length + slen + 1);
    memmove(self->data + slen, self->data, self->length);
    memcpy(self->data, s, slen);
    self->length += slen;
    self->data[self->length] = '\0';
}

static inline WebForms *webforms_create(void)
{
    WebForms *self = (WebForms *)calloc(1, sizeof(WebForms));
    return self;
}

static inline void webforms_free(WebForms *self)
{
    if (!self) return;
    if (self->data) free(self->data);
    free(self);
}

static inline void webforms_internal_add_nv(WebForms *self, const char *name, const char *value)
{
    if (self->length > 0)
        webforms_internal_append_char(self, '\n');
    webforms_internal_append_str(self, name);
    webforms_internal_append_char(self, '=');
    webforms_internal_append_str(self, value);
}

static inline void webforms_internal_add_n(WebForms *self, const char *name)
{
    if (self->length > 0)
        webforms_internal_append_char(self, '\n');
    webforms_internal_append_str(self, name);
}

static inline void webforms_internal_add_to_up_nv(WebForms *self, const char *name, const char *value)
{
    size_t nlen = name ? strlen(name) : 0;
    size_t vlen = value ? strlen(value) : 0;
    int add_nl = (self->length > 0) ? 1 : 0;
    size_t line_len = nlen + 1 + vlen + (size_t)add_nl;
    char *line = (char *)malloc(line_len + 1);
    size_t pos = 0;
    if (nlen) { memcpy(line + pos, name, nlen); pos += nlen; }
    line[pos++] = '=';
    if (vlen) { memcpy(line + pos, value, vlen); pos += vlen; }
    if (add_nl) line[pos++] = '\n';
    line[pos] = '\0';
    webforms_internal_prepend_str(self, line);
    free(line);
}

static inline void webforms_internal_add_to_up_n(WebForms *self, const char *name)
{
    size_t nlen = name ? strlen(name) : 0;
    int add_nl = (self->length > 0) ? 1 : 0;
    size_t line_len = nlen + (size_t)add_nl;
    char *line = (char *)malloc(line_len + 1);
    size_t pos = 0;
    if (nlen) { memcpy(line + pos, name, nlen); pos += nlen; }
    if (add_nl) line[pos++] = '\n';
    line[pos] = '\0';
    webforms_internal_prepend_str(self, line);
    free(line);
}

static inline char *webforms_get_line_by_index(WebForms *self, int index)
{
    if (self->length == 0)
        return webforms_internal_strdup("");
    size_t count;
    char **lines = webforms_internal_split_lines(self->data, &count);
    if (index < 0)
        index = (int)count + index;
    char *result;
    if (index < 0 || index >= (int)count)
        result = webforms_internal_strdup("");
    else
        result = webforms_internal_strdup(lines[index]);
    webforms_internal_free_lines(lines, count);
    return result;
}

static inline void webforms_update_line_by_index(WebForms *self, int index, const char *name, const char *value)
{
    if (self->length == 0)
        return;
    size_t count;
    char **lines = webforms_internal_split_lines(self->data, &count);
    if (index < 0)
        index = (int)count + index;
    if (index < 0 || index >= (int)count) {
        webforms_internal_free_lines(lines, count);
        return;
    }
    free(lines[index]);
    size_t nlen = name ? strlen(name) : 0;
    size_t vlen = value ? strlen(value) : 0;
    if (vlen == 0) {
        lines[index] = (char *)malloc(nlen + 1);
        if (nlen) memcpy(lines[index], name, nlen);
        lines[index][nlen] = '\0';
    } else {
        lines[index] = (char *)malloc(nlen + 1 + vlen + 1);
        if (nlen) memcpy(lines[index], name, nlen);
        lines[index][nlen] = '=';
        memcpy(lines[index] + nlen + 1, value, vlen);
        lines[index][nlen + 1 + vlen] = '\0';
    }
    self->length = 0;
    if (self->data) self->data[0] = '\0';
    for (size_t i = 0; i < count; i++) {
        if (i > 0) webforms_internal_append_char(self, '\n');
        webforms_internal_append_str(self, lines[i]);
    }
    webforms_internal_free_lines(lines, count);
}

// Forward declarations for functions used before their definition
static inline char *webforms_get_web_forms_data(WebForms *self);
static inline void webforms_append_form(WebForms *self, WebForms *form);

// Helper: add value with a prefix key
static inline void webforms_internal_add_prefixed(WebForms *self, const char *prefix, const char *ip, const char *val)
{
    char *k = webforms_internal_concat2(prefix, ip);
    webforms_internal_add_nv(self, k, val);
    free(k);
}

static inline void webforms_internal_add_prefixed_noval(WebForms *self, const char *prefix, const char *ip)
{
    char *k = webforms_internal_concat2(prefix, ip);
    webforms_internal_add_n(self, k);
    free(k);
}

// For Extension
static inline void webforms_add_line(WebForms *self, const char *name, const char *value)
{
    webforms_internal_add_nv(self, name, value);
}

// ============================================================
// Add
// Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.
// ============================================================

static inline void webforms_add_id(WebForms *self, const char *input_place, const char *id)
{
    webforms_internal_add_prefixed(self, "ai", input_place, id);
}

static inline void webforms_add_name(WebForms *self, const char *input_place, const char *name)
{
    webforms_internal_add_prefixed(self, "an", input_place, name);
}

static inline void webforms_add_value(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "av", input_place, value);
}

static inline void webforms_add_class(WebForms *self, const char *input_place, const char *cls)
{
    webforms_internal_add_prefixed(self, "ac", input_place, cls);
}

static inline void webforms_add_style(WebForms *self, const char *input_place, const char *style)
{
    webforms_internal_add_prefixed(self, "as", input_place, style);
}

static inline void webforms_add_style_kv(WebForms *self, const char *input_place, const char *name, const char *value)
{
    const char *parts[3] = { name, ":", value };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "as", input_place, v);
    free(v);
}

static inline void webforms_add_option_tag(WebForms *self, const char *input_place, const char *text, const char *value, bool selected)
{
    const char *parts[5] = { value, WEBFORMS_GS_STR, text, selected ? WEBFORMS_GS_STR : NULL, selected ? "1" : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "ao", input_place, v);
    free(v);
}

static inline void webforms_add_check_box_tag(WebForms *self, const char *input_place, const char *text, const char *value, bool checked)
{
    const char *parts[5] = { value, WEBFORMS_GS_STR, text, checked ? WEBFORMS_GS_STR : NULL, checked ? "1" : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "ak", input_place, v);
    free(v);
}

static inline void webforms_add_title(WebForms *self, const char *input_place, const char *title)
{
    webforms_internal_add_prefixed(self, "al", input_place, title);
}

static inline void webforms_add_label(WebForms *self, const char *input_place, const char *label)
{
    webforms_internal_add_prefixed(self, "aA", input_place, label);
}

static inline void webforms_add_text(WebForms *self, const char *input_place, const char *text)
{
    char *v = webforms_internal_str_replace_all(text, "\n", "$[ln];");
    webforms_internal_add_prefixed(self, "at", input_place, v);
    free(v);
}

static inline void webforms_add_text_to_up(WebForms *self, const char *input_place, const char *text)
{
    char *v = webforms_internal_str_replace_all(text, "\n", "$[ln];");
    webforms_internal_add_prefixed(self, "pt", input_place, v);
    free(v);
}

static inline void webforms_add_attribute(WebForms *self, const char *input_place, const char *attribute, const char *value, char splitter)
{
    char splitter_str[2] = { splitter, '\0' };
    const char *split_part = (splitter != '\0') ? splitter_str : NULL;
    bool has_value = (value && value[0] != '\0');
    const char *parts[5] = { attribute, WEBFORMS_GS_STR, split_part, has_value ? WEBFORMS_GS_STR : NULL, has_value ? value : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "aa", input_place, v);
    free(v);
}

static inline void webforms_add_tag(WebForms *self, const char *input_place, const char *tag_name, const char *id)
{
    bool has_id = (id && id[0] != '\0');
    const char *parts[3] = { tag_name, has_id ? WEBFORMS_GS_STR : NULL, has_id ? id : NULL };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "nt", input_place, v);
    free(v);
}

static inline void webforms_add_tag_to_up(WebForms *self, const char *input_place, const char *tag_name, const char *id)
{
    bool has_id = (id && id[0] != '\0');
    const char *parts[3] = { tag_name, has_id ? WEBFORMS_GS_STR : NULL, has_id ? id : NULL };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "ut", input_place, v);
    free(v);
}

static inline void webforms_add_tag_before(WebForms *self, const char *input_place, const char *tag_name, const char *id)
{
    bool has_id = (id && id[0] != '\0');
    const char *parts[3] = { tag_name, has_id ? WEBFORMS_GS_STR : NULL, has_id ? id : NULL };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "bt", input_place, v);
    free(v);
}

static inline void webforms_add_tag_after(WebForms *self, const char *input_place, const char *tag_name, const char *id)
{
    bool has_id = (id && id[0] != '\0');
    const char *parts[3] = { tag_name, has_id ? WEBFORMS_GS_STR : NULL, has_id ? id : NULL };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "ft", input_place, v);
    free(v);
}

static inline void webforms_add_hidden(WebForms *self, const char *input_place, const char *name, const char *value, const char *id)
{
    bool has_id = (id && id[0] != '\0');
    const char *parts[5] = { name, WEBFORMS_GS_STR, value, has_id ? WEBFORMS_GS_STR : NULL, has_id ? id : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "ah", input_place, v);
    free(v);
}

// ============================================================
// Set
// Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.
// ============================================================

static inline void webforms_set_id(WebForms *self, const char *input_place, const char *id)
{
    webforms_internal_add_prefixed(self, "si", input_place, id);
}

static inline void webforms_set_name(WebForms *self, const char *input_place, const char *name)
{
    webforms_internal_add_prefixed(self, "sn", input_place, name);
}

static inline void webforms_set_value(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "sv", input_place, value);
}

static inline void webforms_set_class(WebForms *self, const char *input_place, const char *cls)
{
    webforms_internal_add_prefixed(self, "sc", input_place, cls);
}

static inline void webforms_set_style(WebForms *self, const char *input_place, const char *style)
{
    webforms_internal_add_prefixed(self, "ss", input_place, style);
}

static inline void webforms_set_style_kv(WebForms *self, const char *input_place, const char *name, const char *value)
{
    const char *parts[3] = { name, ":", value };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "ss", input_place, v);
    free(v);
}

static inline void webforms_set_option_tag(WebForms *self, const char *input_place, const char *text, const char *value, bool selected)
{
    const char *parts[5] = { value, WEBFORMS_GS_STR, text, selected ? WEBFORMS_GS_STR : NULL, selected ? "1" : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "so", input_place, v);
    free(v);
}

static inline void webforms_set_checked(WebForms *self, const char *input_place, bool checked)
{
    webforms_internal_add_prefixed(self, "sk", input_place, checked ? "1" : "0");
}

static inline void webforms_set_check_box_tag(WebForms *self, const char *input_place, const char *text, const char *value, bool checked)
{
    const char *parts[5] = { value, WEBFORMS_GS_STR, text, checked ? WEBFORMS_GS_STR : NULL, checked ? "1" : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "sk", input_place, v);
    free(v);
}

static inline void webforms_set_title(WebForms *self, const char *input_place, const char *title)
{
    webforms_internal_add_prefixed(self, "sl", input_place, title);
}

static inline void webforms_set_label(WebForms *self, const char *input_place, const char *label)
{
    webforms_internal_add_prefixed(self, "sA", input_place, label);
}

static inline void webforms_set_text(WebForms *self, const char *input_place, const char *text)
{
    char *v = webforms_internal_str_replace_all(text, "\n", "$[ln];");
    webforms_internal_add_prefixed(self, "st", input_place, v);
    free(v);
}

static inline void webforms_set_attribute(WebForms *self, const char *input_place, const char *attribute, const char *value)
{
    bool has_value = (value && value[0] != '\0');
    const char *parts[4] = { attribute, WEBFORMS_GS_STR, has_value ? WEBFORMS_GS_STR : NULL, has_value ? value : NULL };
    char *v = webforms_internal_join(parts, 4);
    webforms_internal_add_prefixed(self, "sa", input_place, v);
    free(v);
}

static inline void webforms_set_width_str(WebForms *self, const char *input_place, const char *width)
{
    webforms_internal_add_prefixed(self, "sw", input_place, width);
}

static inline void webforms_set_width_int(WebForms *self, const char *input_place, int width)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%dpx", width);
    webforms_internal_add_prefixed(self, "sw", input_place, buf);
}

static inline void webforms_set_height_str(WebForms *self, const char *input_place, const char *height)
{
    webforms_internal_add_prefixed(self, "sh", input_place, height);
}

static inline void webforms_set_height_int(WebForms *self, const char *input_place, int height)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%dpx", height);
    webforms_internal_add_prefixed(self, "sh", input_place, buf);
}

static inline void webforms_set_background_color(WebForms *self, const char *input_place, const char *color)
{
    webforms_internal_add_prefixed(self, "bc", input_place, color);
}

static inline void webforms_set_text_color(WebForms *self, const char *input_place, const char *color)
{
    webforms_internal_add_prefixed(self, "tc", input_place, color);
}

static inline void webforms_set_font_name(WebForms *self, const char *input_place, const char *name)
{
    webforms_internal_add_prefixed(self, "fn", input_place, name);
}

static inline void webforms_set_font_size_str(WebForms *self, const char *input_place, const char *size)
{
    webforms_internal_add_prefixed(self, "fs", input_place, size);
}

static inline void webforms_set_font_size_int(WebForms *self, const char *input_place, int size)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%dpx", size);
    webforms_internal_add_prefixed(self, "fs", input_place, buf);
}

static inline void webforms_set_font_bold(WebForms *self, const char *input_place, bool bold)
{
    webforms_internal_add_prefixed(self, "fb", input_place, bold ? "1" : "0");
}

static inline void webforms_set_visible(WebForms *self, const char *input_place, bool visible)
{
    webforms_internal_add_prefixed(self, "vi", input_place, visible ? "1" : "0");
}

static inline void webforms_set_text_align(WebForms *self, const char *input_place, const char *align)
{
    webforms_internal_add_prefixed(self, "ta", input_place, align);
}

static inline void webforms_set_read_only(WebForms *self, const char *input_place, bool read_only)
{
    webforms_internal_add_prefixed(self, "sr", input_place, read_only ? "1" : "0");
}

static inline void webforms_set_disabled(WebForms *self, const char *input_place, bool disabled)
{
    webforms_internal_add_prefixed(self, "sd", input_place, disabled ? "1" : "0");
}

static inline void webforms_set_focus(WebForms *self, const char *input_place, bool focus)
{
    webforms_internal_add_prefixed(self, "sf", input_place, focus ? "1" : "0");
}

static inline void webforms_set_min_length_str(WebForms *self, const char *input_place, const char *length)
{
    webforms_internal_add_prefixed(self, "mn", input_place, length);
}

static inline void webforms_set_min_length_int(WebForms *self, const char *input_place, int length)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", length);
    webforms_internal_add_prefixed(self, "mn", input_place, buf);
}

static inline void webforms_set_max_length_str(WebForms *self, const char *input_place, const char *length)
{
    webforms_internal_add_prefixed(self, "mx", input_place, length);
}

static inline void webforms_set_max_length_int(WebForms *self, const char *input_place, int length)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", length);
    webforms_internal_add_prefixed(self, "mx", input_place, buf);
}

static inline void webforms_set_selected_value(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "ts", input_place, value);
}

static inline void webforms_set_selected_index_str(WebForms *self, const char *input_place, const char *index)
{
    webforms_internal_add_prefixed(self, "ti", input_place, index);
}

static inline void webforms_set_selected_index_int(WebForms *self, const char *input_place, int index)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", index);
    webforms_internal_add_prefixed(self, "ti", input_place, buf);
}

static inline void webforms_set_checked_value(WebForms *self, const char *input_place, const char *value, bool checked)
{
    const char *parts[3] = { value, WEBFORMS_GS_STR, checked ? "1" : "0" };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "ks", input_place, v);
    free(v);
}

static inline void webforms_set_checked_index_str(WebForms *self, const char *input_place, const char *index, bool checked)
{
    const char *parts[3] = { index, WEBFORMS_GS_STR, checked ? "1" : "0" };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "ki", input_place, v);
    free(v);
}

static inline void webforms_set_checked_index_int(WebForms *self, const char *input_place, int index, bool checked)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", index);
    webforms_set_checked_index_str(self, input_place, buf, checked);
}

// ============================================================
// Insert
// Creates the Data only if it does not exist; otherwise, does nothing.
// ============================================================

static inline void webforms_insert_id(WebForms *self, const char *input_place, const char *id)
{
    webforms_internal_add_prefixed(self, "ii", input_place, id);
}

static inline void webforms_insert_name(WebForms *self, const char *input_place, const char *name)
{
    webforms_internal_add_prefixed(self, "in", input_place, name);
}

static inline void webforms_insert_value(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "iv", input_place, value);
}

static inline void webforms_insert_class(WebForms *self, const char *input_place, const char *cls)
{
    webforms_internal_add_prefixed(self, "ic", input_place, cls);
}

static inline void webforms_insert_style(WebForms *self, const char *input_place, const char *style)
{
    webforms_internal_add_prefixed(self, "is", input_place, style);
}

static inline void webforms_insert_style_kv(WebForms *self, const char *input_place, const char *name, const char *value)
{
    const char *parts[3] = { name, ":", value };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "is", input_place, v);
    free(v);
}

static inline void webforms_insert_option_tag(WebForms *self, const char *input_place, const char *text, const char *value, bool selected)
{
    const char *parts[5] = { value, WEBFORMS_GS_STR, text, selected ? WEBFORMS_GS_STR : NULL, selected ? "1" : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "io", input_place, v);
    free(v);
}

static inline void webforms_insert_check_box_tag(WebForms *self, const char *input_place, const char *text, const char *value, bool checked)
{
    const char *parts[5] = { value, WEBFORMS_GS_STR, text, checked ? WEBFORMS_GS_STR : NULL, checked ? "1" : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "ik", input_place, v);
    free(v);
}

static inline void webforms_insert_title(WebForms *self, const char *input_place, const char *title)
{
    webforms_internal_add_prefixed(self, "il", input_place, title);
}

static inline void webforms_insert_label(WebForms *self, const char *input_place, const char *label)
{
    webforms_internal_add_prefixed(self, "iA", input_place, label);
}

static inline void webforms_insert_text(WebForms *self, const char *input_place, const char *text)
{
    char *v = webforms_internal_str_replace_all(text, "\n", "$[ln];");
    webforms_internal_add_prefixed(self, "it", input_place, v);
    free(v);
}

static inline void webforms_insert_attribute(WebForms *self, const char *input_place, const char *attribute, const char *value, char splitter)
{
    char splitter_str[2] = { splitter, '\0' };
    const char *split_part = (splitter != '\0') ? splitter_str : NULL;
    bool has_value = (value && value[0] != '\0');
    const char *parts[5] = { attribute, WEBFORMS_GS_STR, split_part, has_value ? WEBFORMS_GS_STR : NULL, has_value ? value : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "ia", input_place, v);
    free(v);
}

// ============================================================
// Delete
// ============================================================

static inline void webforms_delete_id(WebForms *self, const char *input_place)
{
    webforms_internal_add_prefixed_noval(self, "di", input_place);
}

static inline void webforms_delete_name(WebForms *self, const char *input_place)
{
    webforms_internal_add_prefixed_noval(self, "dn", input_place);
}

static inline void webforms_delete_value(WebForms *self, const char *input_place)
{
    webforms_internal_add_prefixed_noval(self, "dv", input_place);
}

static inline void webforms_delete_class(WebForms *self, const char *input_place, const char *class_name)
{
    webforms_internal_add_prefixed(self, "dc", input_place, class_name);
}

static inline void webforms_delete_style(WebForms *self, const char *input_place, const char *style_name)
{
    webforms_internal_add_prefixed(self, "ds", input_place, style_name);
}

static inline void webforms_delete_option_tag(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "do", input_place, value);
}

static inline void webforms_delete_all_option_tag(WebForms *self, const char *input_place)
{
    webforms_internal_add_prefixed(self, "do", input_place, "*");
}

static inline void webforms_delete_check_box_tag(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "dk", input_place, value);
}

static inline void webforms_delete_all_check_box_tag(WebForms *self, const char *input_place)
{
    webforms_internal_add_prefixed(self, "dk", input_place, "*");
}

static inline void webforms_delete_title(WebForms *self, const char *input_place)
{
    webforms_internal_add_prefixed_noval(self, "dl", input_place);
}

static inline void webforms_delete_label(WebForms *self, const char *input_place)
{
    webforms_internal_add_prefixed_noval(self, "dA", input_place);
}

static inline void webforms_delete_text(WebForms *self, const char *input_place)
{
    webforms_internal_add_prefixed_noval(self, "dt", input_place);
}

static inline void webforms_delete_attribute(WebForms *self, const char *input_place, const char *attribute)
{
    webforms_internal_add_prefixed(self, "da", input_place, attribute);
}

static inline void webforms_delete(WebForms *self, const char *input_place)
{
    webforms_internal_add_prefixed_noval(self, "de", input_place);
}

static inline void webforms_delete_parent(WebForms *self, const char *input_place)
{
    webforms_internal_add_prefixed_noval(self, "dp", input_place);
}

// ============================================================
// Tag
// ============================================================

static inline void webforms_swap_tag(WebForms *self, const char *input_place, const char *output_place)
{
    webforms_internal_add_prefixed(self, "sp", input_place, output_place);
}

static inline void webforms_set_reflection(WebForms *self, const char *input_place, const char *tag)
{
    webforms_internal_add_prefixed(self, "sR", input_place, tag);
}

static inline void webforms_set_reflection_by_output_place(WebForms *self, const char *input_place, const char *output_place)
{
    webforms_internal_add_prefixed(self, "iR", input_place, output_place);
}

static inline void webforms_set_morph(WebForms *self, const char *input_place, const char *tag)
{
    webforms_internal_add_prefixed(self, "sM", input_place, tag);
}

static inline void webforms_set_morph_by_output_place(WebForms *self, const char *input_place, const char *output_place)
{
    webforms_internal_add_prefixed(self, "iM", input_place, output_place);
}

// ============================================================
// Browser
// ============================================================

static inline void webforms_change_url(WebForms *self, const char *url)
{
    webforms_internal_add_nv(self, "cu", url);
}

static inline void webforms_set_head_title(WebForms *self, const char *title)
{
    webforms_internal_add_nv(self, "ht", title);
}

static inline void webforms_clipboard_write_text(WebForms *self, const char *text)
{
    webforms_internal_add_nv(self, "nw", text);
}

static inline void webforms_scroll_to_str(WebForms *self, const char *x, const char *y)
{
    const char *parts[3] = { x, WEBFORMS_GS_STR, y };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "ws", v);
    free(v);
}

static inline void webforms_scroll_to_int(WebForms *self, int x, int y)
{
    char buf[64];
    snprintf(buf, sizeof(buf), "%d%c%d", x, WEBFORMS_GS, y);
    webforms_internal_add_nv(self, "ws", buf);
}

static inline void webforms_history_go_str(WebForms *self, const char *steps)
{
    webforms_internal_add_nv(self, "wg", steps);
}

static inline void webforms_history_go_int(WebForms *self, int steps)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", steps);
    webforms_internal_add_nv(self, "wg", buf);
}

static inline void webforms_reload_page(WebForms *self)
{
    webforms_internal_add_n(self, "lr");
}

static inline void webforms_redirect(WebForms *self, const char *path)
{
    webforms_internal_add_nv(self, "lh", path);
}

// ============================================================
// Increase
// ============================================================

static inline void webforms_increase_min_length_str(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "+n", input_place, value);
}

static inline void webforms_increase_min_length_int(WebForms *self, const char *input_place, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_internal_add_prefixed(self, "+n", input_place, buf);
}

static inline void webforms_increase_max_length_str(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "+x", input_place, value);
}

static inline void webforms_increase_max_length_int(WebForms *self, const char *input_place, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_internal_add_prefixed(self, "+x", input_place, buf);
}

static inline void webforms_increase_font_size_str(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "+f", input_place, value);
}

static inline void webforms_increase_font_size_int(WebForms *self, const char *input_place, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_internal_add_prefixed(self, "+f", input_place, buf);
}

static inline void webforms_increase_width_str(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "+w", input_place, value);
}

static inline void webforms_increase_width_int(WebForms *self, const char *input_place, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_internal_add_prefixed(self, "+w", input_place, buf);
}

static inline void webforms_increase_height_str(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "+h", input_place, value);
}

static inline void webforms_increase_height_int(WebForms *self, const char *input_place, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_internal_add_prefixed(self, "+h", input_place, buf);
}

static inline void webforms_increase_value_str(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "+v", input_place, value);
}

static inline void webforms_increase_value_int(WebForms *self, const char *input_place, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_internal_add_prefixed(self, "+v", input_place, buf);
}

// ============================================================
// Decrease
// ============================================================

static inline void webforms_decrease_min_length_str(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "-n", input_place, value);
}

static inline void webforms_decrease_min_length_int(WebForms *self, const char *input_place, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_internal_add_prefixed(self, "-n", input_place, buf);
}

static inline void webforms_decrease_max_length_str(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "-x", input_place, value);
}

static inline void webforms_decrease_max_length_int(WebForms *self, const char *input_place, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_internal_add_prefixed(self, "-x", input_place, buf);
}

static inline void webforms_decrease_font_size_str(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "-f", input_place, value);
}

static inline void webforms_decrease_font_size_int(WebForms *self, const char *input_place, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_internal_add_prefixed(self, "-f", input_place, buf);
}

static inline void webforms_decrease_width_str(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "-w", input_place, value);
}

static inline void webforms_decrease_width_int(WebForms *self, const char *input_place, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_internal_add_prefixed(self, "-w", input_place, buf);
}

static inline void webforms_decrease_height_str(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "-h", input_place, value);
}

static inline void webforms_decrease_height_int(WebForms *self, const char *input_place, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_internal_add_prefixed(self, "-h", input_place, buf);
}

static inline void webforms_decrease_value_str(WebForms *self, const char *input_place, const char *value)
{
    webforms_internal_add_prefixed(self, "-v", input_place, value);
}

static inline void webforms_decrease_value_int(WebForms *self, const char *input_place, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_internal_add_prefixed(self, "-v", input_place, buf);
}

// ============================================================
// Event
// ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
// All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.
// ============================================================

static inline void webforms_trigger_event(WebForms *self, const char *input_place, const char *html_event_listener, const char *constructor_name)
{
    bool has_cn = (constructor_name && constructor_name[0] != '\0');
    const char *parts[3] = { html_event_listener, has_cn ? WEBFORMS_GS_STR : NULL, has_cn ? constructor_name : NULL };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "TE", input_place, v);
    free(v);
}

static inline void webforms_set_post_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Ep", input_place, html_event);
}

static inline void webforms_set_post_event_out(WebForms *self, const char *input_place, const char *html_event, const char *output_place)
{
    const char *parts[3] = { html_event, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "Ep", input_place, v);
    free(v);
}

static inline void webforms_set_post_event_add_view(WebForms *self, const char *input_place, const char *html_event)
{
    const char *parts[3] = { html_event, WEBFORMS_GS_STR, "+" };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "Ep", input_place, v);
    free(v);
}

static inline void webforms_set_post_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "EP", input_place, html_event_listener);
}

static inline void webforms_set_post_event_listener_out(WebForms *self, const char *input_place, const char *html_event_listener, const char *output_place)
{
    const char *parts[3] = { html_event_listener, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "EP", input_place, v);
    free(v);
}

static inline void webforms_set_post_event_listener_add_view(WebForms *self, const char *input_place, const char *html_event_listener)
{
    const char *parts[3] = { html_event_listener, WEBFORMS_GS_STR, "+" };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "EP", input_place, v);
    free(v);
}

static inline void webforms_set_get_event(WebForms *self, const char *input_place, const char *html_event, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[3] = { html_event, WEBFORMS_GS_STR, p };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "Eg", input_place, v);
    free(v);
}

static inline void webforms_set_get_event_out(WebForms *self, const char *input_place, const char *html_event, const char *output_place, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[5] = { html_event, WEBFORMS_GS_STR, p, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "Eg", input_place, v);
    free(v);
}

static inline void webforms_set_get_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[3] = { html_event_listener, WEBFORMS_GS_STR, p };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "EG", input_place, v);
    free(v);
}

static inline void webforms_set_get_event_listener_out(WebForms *self, const char *input_place, const char *html_event_listener, const char *output_place, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[5] = { html_event_listener, WEBFORMS_GS_STR, p, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "EG", input_place, v);
    free(v);
}

static inline void webforms_set_put_event(WebForms *self, const char *input_place, const char *html_event, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[3] = { html_event, WEBFORMS_GS_STR, p };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "Et", input_place, v);
    free(v);
}

static inline void webforms_set_put_event_out(WebForms *self, const char *input_place, const char *html_event, const char *output_place, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[5] = { html_event, WEBFORMS_GS_STR, p, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "Et", input_place, v);
    free(v);
}

static inline void webforms_set_put_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[3] = { html_event_listener, WEBFORMS_GS_STR, p };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "ET", input_place, v);
    free(v);
}

static inline void webforms_set_put_event_listener_out(WebForms *self, const char *input_place, const char *html_event_listener, const char *output_place, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[5] = { html_event_listener, WEBFORMS_GS_STR, p, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "ET", input_place, v);
    free(v);
}

static inline void webforms_set_patch_event(WebForms *self, const char *input_place, const char *html_event, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[3] = { html_event, WEBFORMS_GS_STR, p };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "Ea", input_place, v);
    free(v);
}

static inline void webforms_set_patch_event_out(WebForms *self, const char *input_place, const char *html_event, const char *output_place, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[5] = { html_event, WEBFORMS_GS_STR, p, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "Ea", input_place, v);
    free(v);
}

static inline void webforms_set_patch_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[3] = { html_event_listener, WEBFORMS_GS_STR, p };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "EA", input_place, v);
    free(v);
}

static inline void webforms_set_patch_event_listener_out(WebForms *self, const char *input_place, const char *html_event_listener, const char *output_place, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[5] = { html_event_listener, WEBFORMS_GS_STR, p, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "EA", input_place, v);
    free(v);
}

static inline void webforms_set_delete_event(WebForms *self, const char *input_place, const char *html_event, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[3] = { html_event, WEBFORMS_GS_STR, p };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "El", input_place, v);
    free(v);
}

static inline void webforms_set_delete_event_out(WebForms *self, const char *input_place, const char *html_event, const char *output_place, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[5] = { html_event, WEBFORMS_GS_STR, p, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "El", input_place, v);
    free(v);
}

static inline void webforms_set_delete_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[3] = { html_event_listener, WEBFORMS_GS_STR, p };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "EL", input_place, v);
    free(v);
}

static inline void webforms_set_delete_event_listener_out(WebForms *self, const char *input_place, const char *html_event_listener, const char *output_place, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[5] = { html_event_listener, WEBFORMS_GS_STR, p, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "EL", input_place, v);
    free(v);
}

static inline void webforms_set_options_event(WebForms *self, const char *input_place, const char *html_event, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[3] = { html_event, WEBFORMS_GS_STR, p };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "Eo", input_place, v);
    free(v);
}

static inline void webforms_set_options_event_out(WebForms *self, const char *input_place, const char *html_event, const char *output_place, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[5] = { html_event, WEBFORMS_GS_STR, p, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "Eo", input_place, v);
    free(v);
}

static inline void webforms_set_options_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[3] = { html_event_listener, WEBFORMS_GS_STR, p };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "EO", input_place, v);
    free(v);
}

static inline void webforms_set_options_event_listener_out(WebForms *self, const char *input_place, const char *html_event_listener, const char *output_place, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[5] = { html_event_listener, WEBFORMS_GS_STR, p, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "EO", input_place, v);
    free(v);
}

static inline void webforms_set_head_event(WebForms *self, const char *input_place, const char *html_event, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[3] = { html_event, WEBFORMS_GS_STR, p };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "Eh", input_place, v);
    free(v);
}

static inline void webforms_set_head_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *path)
{
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *parts[3] = { html_event_listener, WEBFORMS_GS_STR, p };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "EH", input_place, v);
    free(v);
}

// IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
static inline void webforms_set_send_event(WebForms *self, const char *input_place, const char *html_event, const char *data, const char *path, const char *method, bool is_multi_part, const char *content_type, const char *output_place)
{
    char *d1 = webforms_internal_str_replace_all(data, "\n", "$[ln];");
    char *d2 = webforms_internal_str_replace_all(d1, "\"", "$[dq];");
    char *d3 = webforms_internal_str_replace_all(d2, "'", "$[sq];");
    free(d1); free(d2);
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *mp = is_multi_part ? "1" : "0";
    const char *parts[13] = { html_event, WEBFORMS_GS_STR, d3, WEBFORMS_GS_STR, p, WEBFORMS_GS_STR, method, WEBFORMS_GS_STR, mp, WEBFORMS_GS_STR, content_type, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 13);
    webforms_internal_add_prefixed(self, "En", input_place, v);
    free(v);
    free(d3);
}

static inline void webforms_set_send_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *data, const char *path, const char *method, bool is_multi_part, const char *content_type, const char *output_place)
{
    char *d1 = webforms_internal_str_replace_all(data, "\n", "$[ln];");
    const char *p = (path && path[0] != '\0') ? path : "#";
    const char *mp = is_multi_part ? "1" : "0";
    const char *parts[13] = { html_event_listener, WEBFORMS_GS_STR, d1, WEBFORMS_GS_STR, p, WEBFORMS_GS_STR, method, WEBFORMS_GS_STR, mp, WEBFORMS_GS_STR, content_type, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 13);
    webforms_internal_add_prefixed(self, "EN", input_place, v);
    free(v);
    free(d1);
}

static inline void webforms_set_comment_event(WebForms *self, const char *input_place, const char *html_event, const char *index, const char *output_place)
{
    const char *parts[5] = { html_event, WEBFORMS_GS_STR, index, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "Eb", input_place, v);
    free(v);
}

static inline void webforms_set_comment_event_int(WebForms *self, const char *input_place, const char *html_event, int index, const char *output_place)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", index);
    webforms_set_comment_event(self, input_place, html_event, buf, output_place);
}

static inline void webforms_set_comment_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *index, const char *output_place)
{
    const char *parts[5] = { html_event_listener, WEBFORMS_GS_STR, index, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "EB", input_place, v);
    free(v);
}

static inline void webforms_set_comment_event_listener_int(WebForms *self, const char *input_place, const char *html_event_listener, int index, const char *output_place)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", index);
    webforms_set_comment_event_listener(self, input_place, html_event_listener, buf, output_place);
}

static inline char *webforms_internal_join_args_bracket(const char **args, size_t args_count)
{
    if (!args || args_count == 0)
        return webforms_internal_strdup("");
    size_t total = 1;
    for (size_t i = 0; i < args_count; i++) total += args[i] ? strlen(args[i]) : 0;
    total += (args_count > 0) ? (args_count - 1) : 0;
    char *r = (char *)malloc(total + 1);
    size_t pos = 0;
    r[pos++] = '[';
    for (size_t i = 0; i < args_count; i++) {
        if (i > 0) r[pos++] = WEBFORMS_US;
        if (args[i]) {
            size_t l = strlen(args[i]);
            memcpy(r + pos, args[i], l);
            pos += l;
        }
    }
    r[pos] = '\0';
    return r;
}

static inline void webforms_set_wasm_event(WebForms *self, const char *input_place, const char *html_event, const char *wasm_language, const char *wasm_url, const char *method_name, const char **args, size_t args_count, const char *output_place)
{
    char *args_join = webforms_internal_join_args_bracket(args, args_count);
    const char *parts[11] = { html_event, WEBFORMS_GS_STR, wasm_language, WEBFORMS_GS_STR, wasm_url, WEBFORMS_GS_STR, method_name, WEBFORMS_GS_STR, args_join, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 11);
    webforms_internal_add_prefixed(self, "Ey", input_place, v);
    free(v);
    free(args_join);
}

static inline void webforms_set_wasm_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *wasm_language, const char *wasm_url, const char *method_name, const char **args, size_t args_count, const char *output_place)
{
    char *args_join = webforms_internal_join_args_bracket(args, args_count);
    const char *parts[11] = { html_event_listener, WEBFORMS_GS_STR, wasm_language, WEBFORMS_GS_STR, wasm_url, WEBFORMS_GS_STR, method_name, WEBFORMS_GS_STR, args_join, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 11);
    webforms_internal_add_prefixed(self, "EY", input_place, v);
    free(v);
    free(args_join);
}

static inline void webforms_set_web_socket_event(WebForms *self, const char *input_place, const char *html_event, const char *path)
{
    const char *parts[3] = { html_event, WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "Ew", input_place, v);
    free(v);
}

static inline void webforms_set_web_socket_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *path)
{
    const char *parts[3] = { html_event_listener, WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "EW", input_place, v);
    free(v);
}

static inline void webforms_set_sse_event(WebForms *self, const char *input_place, const char *html_event, const char *path, bool should_reconnect, int reconnect_try_timeout)
{
    char timeout_buf[32];
    snprintf(timeout_buf, sizeof(timeout_buf), "%d", reconnect_try_timeout);
    const char *parts[7] = { html_event, WEBFORMS_GS_STR, path, WEBFORMS_GS_STR, should_reconnect ? "1" : "0", WEBFORMS_GS_STR, timeout_buf };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_prefixed(self, "Ee", input_place, v);
    free(v);
}

static inline void webforms_set_sse_event_out(WebForms *self, const char *input_place, const char *html_event, const char *path, const char *output_place, bool should_reconnect, int reconnect_try_timeout)
{
    char timeout_buf[32];
    snprintf(timeout_buf, sizeof(timeout_buf), "%d", reconnect_try_timeout);
    const char *parts[9] = { html_event, WEBFORMS_GS_STR, path, WEBFORMS_GS_STR, should_reconnect ? "1" : "0", WEBFORMS_GS_STR, timeout_buf, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 9);
    webforms_internal_add_prefixed(self, "Ee", input_place, v);
    free(v);
}

static inline void webforms_set_sse_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *path, bool should_reconnect, int reconnect_try_timeout)
{
    char timeout_buf[32];
    snprintf(timeout_buf, sizeof(timeout_buf), "%d", reconnect_try_timeout);
    const char *parts[7] = { html_event_listener, WEBFORMS_GS_STR, path, WEBFORMS_GS_STR, should_reconnect ? "1" : "0", WEBFORMS_GS_STR, timeout_buf };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_prefixed(self, "EE", input_place, v);
    free(v);
}

static inline void webforms_set_sse_event_listener_out(WebForms *self, const char *input_place, const char *html_event_listener, const char *path, const char *output_place, bool should_reconnect, int reconnect_try_timeout)
{
    char timeout_buf[32];
    snprintf(timeout_buf, sizeof(timeout_buf), "%d", reconnect_try_timeout);
    const char *parts[9] = { html_event_listener, WEBFORMS_GS_STR, path, WEBFORMS_GS_STR, should_reconnect ? "1" : "0", WEBFORMS_GS_STR, timeout_buf, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 9);
    webforms_internal_add_prefixed(self, "EE", input_place, v);
    free(v);
}

static inline void webforms_set_front_event(WebForms *self, const char *input_place, const char *html_event, const char *module_path, const char **args, size_t args_count, const char *output_place)
{
    char *args_join = webforms_internal_join_args_bracket(args, args_count);
    char *with_gs = NULL;
    if (args_join[0] == '[') {
        with_gs = webforms_internal_concat2(WEBFORMS_GS_STR, args_join);
    } else {
        with_gs = webforms_internal_strdup("");
    }
    const char *parts[7] = { html_event, WEBFORMS_GS_STR, module_path, WEBFORMS_GS_STR, output_place, with_gs, "" };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_prefixed(self, "Ej", input_place, v);
    free(v);
    free(args_join);
    free(with_gs);
}

static inline void webforms_set_front_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *module_path, const char **args, size_t args_count, const char *output_place)
{
    char *args_join = webforms_internal_join_args_bracket(args, args_count);
    char *with_gs = NULL;
    if (args_join[0] == '[') {
        with_gs = webforms_internal_concat2(WEBFORMS_GS_STR, args_join);
    } else {
        with_gs = webforms_internal_strdup("");
    }
    const char *parts[7] = { html_event_listener, WEBFORMS_GS_STR, module_path, WEBFORMS_GS_STR, output_place, with_gs, "" };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_prefixed(self, "EJ", input_place, v);
    free(v);
    free(args_join);
    free(with_gs);
}

static inline void webforms_set_master_pages_event(WebForms *self, const char *input_place, const char *html_event, const char *output_place)
{
    const char *parts[3] = { html_event, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "Eu", input_place, v);
    free(v);
}

static inline void webforms_set_master_pages_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *output_place)
{
    const char *parts[3] = { html_event_listener, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "EU", input_place, v);
    free(v);
}

static inline void webforms_set_prevent_default_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Ed", input_place, html_event);
}

static inline void webforms_set_prevent_default_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "ED", input_place, html_event_listener);
}

static inline void webforms_set_stop_propagation_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Es", input_place, html_event);
}

static inline void webforms_set_stop_propagation_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "ES", input_place, html_event_listener);
}

static inline void webforms_set_method_event(WebForms *self, const char *input_place, const char *html_event, const char *method_name, const char **args, size_t args_count)
{
    char *args_join = webforms_internal_join_args_bracket(args, args_count);
    char *with_gs = NULL;
    if (args_join[0] == '[') {
        with_gs = webforms_internal_concat2(WEBFORMS_GS_STR, args_join);
    } else {
        with_gs = webforms_internal_strdup("");
    }
    const char *parts[5] = { html_event, WEBFORMS_GS_STR, method_name, with_gs, "" };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "Em", input_place, v);
    free(v);
    free(args_join);
    free(with_gs);
}

static inline void webforms_set_method_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *method_name, const char **args, size_t args_count)
{
    char *args_join = webforms_internal_join_args_bracket(args, args_count);
    char *with_gs = NULL;
    if (args_join[0] == '[') {
        with_gs = webforms_internal_concat2(WEBFORMS_GS_STR, args_join);
    } else {
        with_gs = webforms_internal_strdup("");
    }
    const char *parts[5] = { html_event_listener, WEBFORMS_GS_STR, method_name, with_gs, "" };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "EM", input_place, v);
    free(v);
    free(args_join);
    free(with_gs);
}

static inline void webforms_set_module_method_event(WebForms *self, const char *input_place, const char *html_event, const char *method_name, const char **args, size_t args_count)
{
    char *args_join = webforms_internal_join_args_bracket(args, args_count);
    char *with_gs = NULL;
    if (args_join[0] == '[') {
        with_gs = webforms_internal_concat2(WEBFORMS_GS_STR, args_join);
    } else {
        with_gs = webforms_internal_strdup("");
    }
    const char *parts[5] = { html_event, WEBFORMS_GS_STR, method_name, with_gs, "" };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "Ex", input_place, v);
    free(v);
    free(args_join);
    free(with_gs);
}

static inline void webforms_set_module_method_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *method_name, const char **args, size_t args_count)
{
    char *args_join = webforms_internal_join_args_bracket(args, args_count);
    char *with_gs = NULL;
    if (args_join[0] == '[') {
        with_gs = webforms_internal_concat2(WEBFORMS_GS_STR, args_join);
    } else {
        with_gs = webforms_internal_strdup("");
    }
    const char *parts[5] = { html_event_listener, WEBFORMS_GS_STR, method_name, with_gs, "" };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "EX", input_place, v);
    free(v);
    free(args_join);
    free(with_gs);
}

static inline void webforms_assign_confirm_event(WebForms *self, const char *input_place, const char *html_event, const char *text, const char *type, const char *title, const char *ok_text, const char *cancel_text)
{
    const char *t = (text && strcmp(text, "Are you sure you want to proceed?") == 0) ? "" : (text ? text : "");
    const char *tp = (type && strcmp(type, "none") == 0) ? "" : (type ? type : "");
    const char *ti = (title && strcmp(title, "Confirm") == 0) ? "" : (title ? title : "");
    const char *ot = (ok_text && strcmp(ok_text, "OK") == 0) ? "" : (ok_text ? ok_text : "");
    const char *ct = (cancel_text && strcmp(cancel_text, "Cancel") == 0) ? "" : (cancel_text ? cancel_text : "");
    const char *parts[11] = { html_event, WEBFORMS_GS_STR, t, WEBFORMS_GS_STR, tp, WEBFORMS_GS_STR, ti, WEBFORMS_GS_STR, ot, WEBFORMS_GS_STR, ct };
    char *v = webforms_internal_join(parts, 11);
    webforms_internal_add_prefixed(self, "Ef", input_place, v);
    free(v);
}

static inline void webforms_remove_post_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Rp", input_place, html_event);
}

static inline void webforms_remove_post_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RP", input_place, html_event_listener);
}

static inline void webforms_remove_get_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Rg", input_place, html_event);
}

static inline void webforms_remove_get_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RG", input_place, html_event_listener);
}

static inline void webforms_remove_put_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Rt", input_place, html_event);
}

static inline void webforms_remove_put_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RT", input_place, html_event_listener);
}

static inline void webforms_remove_patch_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Ra", input_place, html_event);
}

static inline void webforms_remove_patch_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RA", input_place, html_event_listener);
}

static inline void webforms_remove_delete_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Rl", input_place, html_event);
}

static inline void webforms_remove_delete_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RL", input_place, html_event_listener);
}

static inline void webforms_remove_options_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Ro", input_place, html_event);
}

static inline void webforms_remove_options_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RO", input_place, html_event_listener);
}

static inline void webforms_remove_head_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Rh", input_place, html_event);
}

static inline void webforms_remove_head_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RH", input_place, html_event_listener);
}

static inline void webforms_remove_send_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Rn", input_place, html_event);
}

static inline void webforms_remove_send_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RN", input_place, html_event_listener);
}

static inline void webforms_remove_comment_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Rb", input_place, html_event);
}

static inline void webforms_remove_comment_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RB", input_place, html_event_listener);
}

static inline void webforms_remove_wasm_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Ry", input_place, html_event);
}

static inline void webforms_remove_wasm_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RY", input_place, html_event_listener);
}

static inline void webforms_remove_web_socket_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Rw", input_place, html_event);
}

static inline void webforms_remove_web_socket_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RW", input_place, html_event_listener);
}

static inline void webforms_remove_sse_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Re", input_place, html_event);
}

static inline void webforms_remove_sse_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RE", input_place, html_event_listener);
}

static inline void webforms_remove_front_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Rj", input_place, html_event);
}

static inline void webforms_remove_front_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RJ", input_place, html_event_listener);
}

static inline void webforms_remove_prevent_default_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Rd", input_place, html_event);
}

static inline void webforms_remove_prevent_default_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RD", input_place, html_event_listener);
}

static inline void webforms_remove_master_pages_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Ru", input_place, html_event);
}

static inline void webforms_remove_master_pages_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RU", input_place, html_event_listener);
}

static inline void webforms_remove_stop_propagation_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Rs", input_place, html_event);
}

static inline void webforms_remove_stop_propagation_event_listener(WebForms *self, const char *input_place, const char *html_event_listener)
{
    webforms_internal_add_prefixed(self, "RS", input_place, html_event_listener);
}

static inline void webforms_remove_method_event(WebForms *self, const char *input_place, const char *html_event, const char *method_name)
{
    const char *parts[3] = { html_event, WEBFORMS_GS_STR, method_name };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "Rm", input_place, v);
    free(v);
}

static inline void webforms_remove_method_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *method_name)
{
    const char *parts[3] = { html_event_listener, WEBFORMS_GS_STR, method_name };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "RM", input_place, v);
    free(v);
}

static inline void webforms_remove_module_method_event(WebForms *self, const char *input_place, const char *html_event, const char *method_name)
{
    const char *parts[3] = { html_event, WEBFORMS_GS_STR, method_name };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "Rx", input_place, v);
    free(v);
}

static inline void webforms_remove_module_method_event_listener(WebForms *self, const char *input_place, const char *html_event_listener, const char *method_name)
{
    const char *parts[3] = { html_event_listener, WEBFORMS_GS_STR, method_name };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "RX", input_place, v);
    free(v);
}

static inline void webforms_remove_confirm_event(WebForms *self, const char *input_place, const char *html_event)
{
    webforms_internal_add_prefixed(self, "Rf", input_place, html_event);
}

// ============================================================
// Custom Event
// This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
// Watch: attribute, style, text, children, value
// Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
// Range: Only Use For Compare With inrange Value. Split By Comma ","
// Key: Only Use For Watch With attribute And style Value
// ============================================================

static inline void webforms_create_custom_dom_event(WebForms *self, const char *input_place, const char *event_name, const char *watch, const char *key, const char *compare, const char *value, const char *range, bool immediate, const char *delay)
{
    const char *parts[15] = { event_name, WEBFORMS_GS_STR, watch, WEBFORMS_GS_STR, key, WEBFORMS_GS_STR, compare, WEBFORMS_GS_STR, value, WEBFORMS_GS_STR, range, WEBFORMS_GS_STR, immediate ? "1" : "0", WEBFORMS_GS_STR, delay };
    char *v = webforms_internal_join(parts, 15);
    webforms_internal_add_prefixed(self, "eC", input_place, v);
    free(v);
}

static inline void webforms_create_custom_dom_event_int(WebForms *self, const char *input_place, const char *event_name, const char *watch, const char *key, const char *compare, const char *value, const char *range, bool immediate, int delay)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", delay);
    webforms_create_custom_dom_event(self, input_place, event_name, watch, key, compare, value, range, immediate, buf);
}

static inline void webforms_enable_scroll_bottom_event(WebForms *self, bool enable)
{
    webforms_internal_add_nv(self, "eb", enable ? "1" : "0");
}

static inline void webforms_enable_reached_element_event(WebForms *self, const char *input_place, bool once, bool enable)
{
    const char *parts[3] = { once ? "1" : "0", WEBFORMS_GS_STR, enable ? "1" : "0" };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "er", input_place, v);
    free(v);
}

// ============================================================
// Module
// ============================================================

static inline void webforms_load_module(WebForms *self, const char *module_path, const char **methods, size_t methods_count)
{
    char *methods_join = NULL;
    if (methods && methods_count > 0) {
        size_t total = 1;
        for (size_t i = 0; i < methods_count; i++) total += methods[i] ? strlen(methods[i]) : 0;
        total += (methods_count - 1);
        methods_join = (char *)malloc(total + 1);
        size_t pos = 0;
        methods_join[pos++] = '[';
        for (size_t i = 0; i < methods_count; i++) {
            if (i > 0) methods_join[pos++] = WEBFORMS_US;
            if (methods[i]) {
                size_t l = strlen(methods[i]);
                memcpy(methods_join + pos, methods[i], l);
                pos += l;
            }
        }
        methods_join[pos] = '\0';
    } else {
        methods_join = webforms_internal_strdup("");
    }
    char *v;
    if (methods_join[0] == '[') {
        const char *parts[3] = { module_path, WEBFORMS_GS_STR, methods_join };
        v = webforms_internal_join(parts, 3);
    } else {
        v = webforms_internal_strdup(module_path);
    }
    webforms_internal_add_nv(self, "Ml", v);
    free(v);
    free(methods_join);
}

static inline void webforms_unload_module(WebForms *self, const char *module_path)
{
    webforms_internal_add_nv(self, "Mu", module_path);
}

static inline void webforms_delete_module_method(WebForms *self, const char *method_name)
{
    webforms_internal_add_nv(self, "Md", method_name);
}

// ============================================================
// Unit Testing
// InputPlace Is Actual, Expected Is Tag/OutputPlace
// ============================================================

static inline void webforms_assert_equal(WebForms *self, const char *input_place, const char *tag)
{
    char *v = webforms_internal_str_replace_all(tag, "\n", "$[ln];");
    webforms_internal_add_prefixed(self, "At", input_place, v);
    free(v);
}

static inline void webforms_assert_equal_by_output_place(WebForms *self, const char *input_place, const char *output_place)
{
    webforms_internal_add_prefixed(self, "Ao", input_place, output_place);
}

// ============================================================
// Debug
// ============================================================

static inline void webforms_create_debugger(WebForms *self, bool pause)
{
    webforms_internal_add_nv(self, "Dc", pause ? "1" : "0");
}

// ============================================================
// Service Worker
// To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
// ============================================================

static inline void webforms_service_worker_register(WebForms *self, const char *path, const char *scope_path)
{
    const char *parts[3] = { path, WEBFORMS_GS_STR, scope_path };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "wR", v);
    free(v);
}

static inline void webforms_service_worker_pre_cache_static(WebForms *self, const char **path_list, size_t path_list_count)
{
    if (!path_list || path_list_count == 0) {
        webforms_internal_add_nv(self, "wp", "");
        return;
    }
    size_t total = 0;
    for (size_t i = 0; i < path_list_count; i++) total += path_list[i] ? strlen(path_list[i]) : 0;
    total += (path_list_count - 1);
    char *v = (char *)malloc(total + 1);
    size_t pos = 0;
    for (size_t i = 0; i < path_list_count; i++) {
        if (i > 0) v[pos++] = WEBFORMS_GS;
        if (path_list[i]) {
            size_t l = strlen(path_list[i]);
            memcpy(v + pos, path_list[i], l);
            pos += l;
        }
    }
    v[pos] = '\0';
    webforms_internal_add_nv(self, "wp", v);
    free(v);
}

static inline void webforms_service_worker_dynamic_cache_str(WebForms *self, const char *path, const char *seconds)
{
    if (seconds && seconds[0] != '\0') {
        const char *parts[3] = { path, WEBFORMS_GS_STR, seconds };
        char *v = webforms_internal_join(parts, 3);
        webforms_internal_add_nv(self, "wc", v);
        free(v);
    } else {
        webforms_internal_add_nv(self, "wc", path);
    }
}

static inline void webforms_service_worker_dynamic_cache_int(WebForms *self, const char *path, int seconds)
{
    if (seconds > 0) {
        char buf[32];
        snprintf(buf, sizeof(buf), "%d", seconds);
        webforms_service_worker_dynamic_cache_str(self, path, buf);
    } else {
        webforms_service_worker_dynamic_cache_str(self, path, "");
    }
}

static inline void webforms_service_worker_delete_dynamic_cache(WebForms *self)
{
    webforms_internal_add_n(self, "wd");
}

static inline void webforms_service_worker_delete_dynamic_cache_path(WebForms *self, const char *path)
{
    webforms_internal_add_nv(self, "wd", path);
}

static inline void webforms_service_worker_dynamic_cache_ttl_update_str(WebForms *self, const char *path, const char *seconds)
{
    if (seconds && seconds[0] != '\0') {
        const char *parts[3] = { path, WEBFORMS_GS_STR, seconds };
        char *v = webforms_internal_join(parts, 3);
        webforms_internal_add_nv(self, "wt", v);
        free(v);
    } else {
        webforms_internal_add_nv(self, "wt", path);
    }
}

static inline void webforms_service_worker_dynamic_cache_ttl_update_int(WebForms *self, const char *path, int seconds)
{
    if (seconds > 0) {
        char buf[32];
        snprintf(buf, sizeof(buf), "%d", seconds);
        webforms_service_worker_dynamic_cache_ttl_update_str(self, path, buf);
    } else {
        webforms_service_worker_dynamic_cache_ttl_update_str(self, path, "");
    }
}

// Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
// Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
// CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
static inline void webforms_service_worker_route_set(WebForms *self, const char *path, const char *type, bool cache_dynamic)
{
    if (cache_dynamic) {
        const char *parts[5] = { path, WEBFORMS_GS_STR, type, WEBFORMS_GS_STR, "1" };
        char *v = webforms_internal_join(parts, 5);
        webforms_internal_add_nv(self, "wr", v);
        free(v);
    } else {
        const char *parts[3] = { path, WEBFORMS_GS_STR, type };
        char *v = webforms_internal_join(parts, 3);
        webforms_internal_add_nv(self, "wr", v);
        free(v);
    }
}

static inline void webforms_service_worker_route_alias(WebForms *self, const char *path, const char *to)
{
    const char *parts[3] = { path, WEBFORMS_GS_STR, to };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "wa", v);
    free(v);
}

static inline void webforms_service_worker_delete_route_alias(WebForms *self, const char *path)
{
    webforms_internal_add_nv(self, "wC", path);
}

// Delete All Route And Alias
static inline void webforms_service_worker_delete_route(WebForms *self)
{
    webforms_internal_add_n(self, "wD");
}

static inline void webforms_service_worker_delete_route_path(WebForms *self, const char *path)
{
    webforms_internal_add_nv(self, "wD", path);
}

// ============================================================
// SSE
// ============================================================

static inline void webforms_disconnect_sse(WebForms *self, const char *path)
{
    webforms_internal_add_nv(self, "Ds", path);
}

static inline void webforms_disconnect_all_sse(WebForms *self)
{
    webforms_internal_add_n(self, "Ds");
}

// ============================================================
// State
// ============================================================

static inline void webforms_add_state(WebForms *self, const char *path, const char *title)
{
    const char *parts[3] = { path, WEBFORMS_GS_STR, title };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "AS", v);
    free(v);
}

static inline void webforms_save_state(WebForms *self, const char *path, const char *title)
{
    const char *parts[3] = { path, WEBFORMS_GS_STR, title };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "As", v);
    free(v);
}

static inline void webforms_load_state(WebForms *self, const char *path)
{
    webforms_internal_add_nv(self, "ls", path);
}

static inline void webforms_delete_state(WebForms *self, const char *path)
{
    webforms_internal_add_nv(self, "DS", path);
}

static inline void webforms_delete_all_state(WebForms *self)
{
    webforms_internal_add_nv(self, "DS", "*");
}

// ============================================================
// Cookie
// ============================================================

static inline void webforms_set_cookie_str(WebForms *self, const char *key, const char *value, const char *seconds, const char *path)
{
    bool has_path = (path && path[0] != '\0');
    const char *parts[7] = { key, WEBFORMS_GS_STR, value, WEBFORMS_GS_STR, seconds, has_path ? WEBFORMS_GS_STR : NULL, has_path ? path : NULL };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_nv(self, "sC", v);
    free(v);
}

static inline void webforms_set_cookie_int(WebForms *self, const char *key, const char *value, int seconds, const char *path)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", seconds);
    webforms_set_cookie_str(self, key, value, buf, path);
}

// ============================================================
// Save (Session Cache)
// ============================================================

static inline void webforms_save_id(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gi", input_place, key);
}

static inline void webforms_save_name(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gn", input_place, key);
}

static inline void webforms_save_value(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gv", input_place, key);
}

static inline void webforms_save_value_length(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@ge", input_place, key);
}

static inline void webforms_save_class(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gc", input_place, key);
}

static inline void webforms_save_style(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gs", input_place, key);
}

static inline void webforms_save_title(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gl", input_place, key);
}

static inline void webforms_save_label(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gA", input_place, key);
}

static inline void webforms_save_text(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gt", input_place, key);
}

static inline void webforms_save_outer_text(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@go", input_place, key);
}

static inline void webforms_save_text_length(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gg", input_place, key);
}

static inline void webforms_save_attribute(WebForms *self, const char *input_place, const char *attribute, const char *key)
{
    const char *parts[3] = { key, WEBFORMS_GS_STR, attribute };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "@ga", input_place, v);
    free(v);
}

static inline void webforms_save_width(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gw", input_place, key);
}

static inline void webforms_save_height(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gh", input_place, key);
}

static inline void webforms_save_read_only(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gr", input_place, key);
}

static inline void webforms_save_selected_index(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gx", input_place, key);
}

static inline void webforms_save_text_align(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gT", input_place, key);
}

static inline void webforms_save_node_length(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gL", input_place, key);
}

static inline void webforms_save_visible(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gV", input_place, key);
}

static inline void webforms_save_url(WebForms *self, const char *url, bool fetch_script, const char *key)
{
    bool has_fs = fetch_script;
    const char *parts[5] = { key, WEBFORMS_GS_STR, url, has_fs ? WEBFORMS_GS_STR : NULL, has_fs ? "1" : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, "@gu", v);
    free(v);
}

static inline void webforms_save_index(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@gI", input_place, key);
}

static inline void webforms_remove_save(WebForms *self, const char *cache_key)
{
    webforms_internal_add_nv(self, "rs", cache_key);
}

static inline void webforms_remove_all_save(WebForms *self)
{
    webforms_internal_add_nv(self, "rs", "*");
}

// Calling the SetSave Method Causes Action Control Requests Triggered by Events Using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send Event, to be Temporarily Saved on the Active Page, so the Request will not be Sent to the Server Again.
static inline void webforms_set_save(WebForms *self)
{
    webforms_internal_add_nv(self, "cs", "*");
}

static inline void webforms_add_save_value(WebForms *self, const char *cache_key, const char *value)
{
    char *v = webforms_internal_str_replace_all(value, "\n", "$[ln];");
    const char *parts[3] = { cache_key, WEBFORMS_GS_STR, v };
    char *joined = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "SA", joined);
    free(joined);
    free(v);
}

static inline void webforms_insert_save_value(WebForms *self, const char *cache_key, const char *value)
{
    char *v = webforms_internal_str_replace_all(value, "\n", "$[ln];");
    const char *parts[3] = { cache_key, WEBFORMS_GS_STR, v };
    char *joined = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "SI", joined);
    free(joined);
    free(v);
}

static inline void webforms_append_save_value(WebForms *self, const char *cache_key, const char *value)
{
    char *v = webforms_internal_str_replace_all(value, "\n", "$[ln];");
    const char *parts[3] = { cache_key, WEBFORMS_GS_STR, v };
    char *joined = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "SP", joined);
    free(joined);
    free(v);
}

static inline void webforms_replace_save_value(WebForms *self, const char *cache_key, const char *search_value, const char *value)
{
    char *v = webforms_internal_str_replace_all(value, "\n", "$[ln];");
    char *sv = webforms_internal_str_replace_all(search_value, "\n", "$[ln];");
    const char *parts[5] = { cache_key, WEBFORMS_GS_STR, v, WEBFORMS_GS_STR, sv };
    char *joined = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, "SR", joined);
    free(joined);
    free(v);
    free(sv);
}

// ============================================================
// Cache
// ============================================================

static inline void webforms_cache_id(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@ci", input_place, key);
}

static inline void webforms_cache_name(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cn", input_place, key);
}

static inline void webforms_cache_value(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cv", input_place, key);
}

static inline void webforms_cache_value_length(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@ce", input_place, key);
}

static inline void webforms_cache_class(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cc", input_place, key);
}

static inline void webforms_cache_style(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cs", input_place, key);
}

static inline void webforms_cache_title(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cl", input_place, key);
}

static inline void webforms_cache_label(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cA", input_place, key);
}

static inline void webforms_cache_text(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@ct", input_place, key);
}

static inline void webforms_cache_outer_text(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@co", input_place, key);
}

static inline void webforms_cache_text_length(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cg", input_place, key);
}

static inline void webforms_cache_attribute(WebForms *self, const char *input_place, const char *attribute, const char *key)
{
    const char *parts[3] = { key, WEBFORMS_GS_STR, attribute };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "@ca", input_place, v);
    free(v);
}

static inline void webforms_cache_width(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cw", input_place, key);
}

static inline void webforms_cache_height(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@ch", input_place, key);
}

static inline void webforms_cache_read_only(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cr", input_place, key);
}

static inline void webforms_cache_selected_index(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cx", input_place, key);
}

static inline void webforms_cache_text_align(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cT", input_place, key);
}

static inline void webforms_cache_node_length(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cL", input_place, key);
}

static inline void webforms_cache_visible(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cV", input_place, key);
}

static inline void webforms_cache_url(WebForms *self, const char *url, bool fetch_script, const char *key)
{
    bool has_fs = fetch_script;
    const char *parts[5] = { key, WEBFORMS_GS_STR, url, has_fs ? WEBFORMS_GS_STR : NULL, has_fs ? "1" : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, "@cu", v);
    free(v);
}

static inline void webforms_cache_index(WebForms *self, const char *input_place, const char *key)
{
    webforms_internal_add_prefixed(self, "@cI", input_place, key);
}

static inline void webforms_remove_cache(WebForms *self, const char *cache_key)
{
    webforms_internal_add_nv(self, "rd", cache_key);
}

static inline void webforms_remove_all_cache(WebForms *self)
{
    webforms_internal_add_nv(self, "rd", "*");
}

// Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
static inline void webforms_set_cache_str(WebForms *self, const char *second)
{
    webforms_internal_add_nv(self, "cd", second);
}

static inline void webforms_set_cache_int(WebForms *self, int second)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", second);
    webforms_set_cache_str(self, buf);
}

static inline void webforms_set_cache(WebForms *self)
{
    webforms_internal_add_nv(self, "cd", "*");
}

static inline void webforms_add_cache_value(WebForms *self, const char *cache_key, const char *value)
{
    char *v = webforms_internal_str_replace_all(value, "\n", "$[ln];");
    const char *parts[3] = { cache_key, WEBFORMS_GS_STR, v };
    char *joined = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "CA", joined);
    free(joined);
    free(v);
}

static inline void webforms_insert_cache_value(WebForms *self, const char *cache_key, const char *value)
{
    char *v = webforms_internal_str_replace_all(value, "\n", "$[ln];");
    const char *parts[3] = { cache_key, WEBFORMS_GS_STR, v };
    char *joined = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "CI", joined);
    free(joined);
    free(v);
}

static inline void webforms_append_cache_value(WebForms *self, const char *cache_key, const char *value)
{
    char *v = webforms_internal_str_replace_all(value, "\n", "$[ln];");
    const char *parts[3] = { cache_key, WEBFORMS_GS_STR, v };
    char *joined = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "CP", joined);
    free(joined);
    free(v);
}

static inline void webforms_replace_cache_value(WebForms *self, const char *cache_key, const char *search_value, const char *value)
{
    char *v = webforms_internal_str_replace_all(value, "\n", "$[ln];");
    char *sv = webforms_internal_str_replace_all(search_value, "\n", "$[ln];");
    const char *parts[5] = { cache_key, WEBFORMS_GS_STR, v, WEBFORMS_GS_STR, sv };
    char *joined = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, "CR", joined);
    free(joined);
    free(v);
    free(sv);
}

// ============================================================
// Call
// ============================================================

static inline void webforms_load_url(WebForms *self, const char *input_place, const char *url)
{
    webforms_internal_add_prefixed(self, "lu", input_place, url);
}

static inline void webforms_run_action_controls(WebForms *self, const char *action_controls, bool without_web_forms_section, const char *index, bool use_current_event)
{
    const char *parts[7] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, without_web_forms_section ? "1" : "0", WEBFORMS_GS_STR, index, WEBFORMS_GS_STR, action_controls };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_nv(self, "lA", v);
    free(v);
}

static inline void webforms_call_script(WebForms *self, const char *script_text)
{
    char *v = webforms_internal_str_replace_all(script_text, "\n", "$[ln];");
    webforms_internal_add_nv(self, "_", v);
    free(v);
}

static inline void webforms_call_method(WebForms *self, const char *method_name, const char **args, size_t args_count)
{
    char *args_join = webforms_internal_join_args_bracket(args, args_count);
    char *with_gs = NULL;
    if (args_join[0] == '[') {
        with_gs = webforms_internal_concat2(WEBFORMS_GS_STR, args_join);
    } else {
        with_gs = webforms_internal_strdup("");
    }
    const char *parts[3] = { method_name, with_gs, "" };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "lm", v);
    free(v);
    free(args_join);
    free(with_gs);
}

static inline void webforms_call_module_method(WebForms *self, const char *method_name, const char **args, size_t args_count)
{
    char *args_join = webforms_internal_join_args_bracket(args, args_count);
    char *with_gs = NULL;
    if (args_join[0] == '[') {
        with_gs = webforms_internal_concat2(WEBFORMS_GS_STR, args_join);
    } else {
        with_gs = webforms_internal_strdup("");
    }
    const char *parts[3] = { method_name, with_gs, "" };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "lM", v);
    free(v);
    free(args_join);
    free(with_gs);
}

static inline void webforms_call_post_back(WebForms *self, const char *form_input_place, const char *output_place)
{
    if (output_place && output_place[0] != '\0') {
        const char *parts[5] = { "1", WEBFORMS_GS_STR, form_input_place, WEBFORMS_GS_STR, output_place };
        char *v = webforms_internal_join(parts, 5);
        webforms_internal_add_nv(self, "Lp", v);
        free(v);
    } else {
        const char *parts[3] = { "1", WEBFORMS_GS_STR, form_input_place };
        char *v = webforms_internal_join(parts, 3);
        webforms_internal_add_nv(self, "Lp", v);
        free(v);
    }
}

static inline void webforms_call_comment_back(WebForms *self, const char *index, const char *input_place, bool use_current_event)
{
    const char *parts[5] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, index, WEBFORMS_GS_STR, input_place };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, "LC", v);
    free(v);
}

static inline void webforms_call_comment_back_int(WebForms *self, int index, const char *input_place, bool use_current_event)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", index);
    webforms_call_comment_back(self, buf, input_place, use_current_event);
}

static inline void webforms_call_wasm_back(WebForms *self, const char *wasm_language, const char *wasm_url, const char *method_name, const char **args, size_t args_count, const char *output_place, bool use_current_event)
{
    char *args_join = webforms_internal_join_args_bracket(args, args_count);
    const char *parts[11] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, wasm_language, WEBFORMS_GS_STR, wasm_url, WEBFORMS_GS_STR, method_name, WEBFORMS_GS_STR, args_join, WEBFORMS_GS_STR, output_place };
    char *v = webforms_internal_join(parts, 11);
    webforms_internal_add_nv(self, "Ly", v);
    free(v);
    free(args_join);
}

static inline void webforms_call_web_socket_back(WebForms *self, const char *path, bool use_current_event)
{
    const char *parts[3] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "Lw", v);
    free(v);
}

static inline void webforms_call_sse_back_str(WebForms *self, const char *path, const char *output_place, bool use_current_event, bool should_reconnect, const char *reconnect_try_timeout)
{
    bool has_out = (output_place && output_place[0] != '\0');
    const char *parts[7] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, path, WEBFORMS_GS_STR, should_reconnect ? "1" : "0", WEBFORMS_GS_STR, reconnect_try_timeout };
    char *base = webforms_internal_join(parts, 7);
    char *v;
    if (has_out) {
        const char *p2[3] = { base, WEBFORMS_GS_STR, output_place };
        v = webforms_internal_join(p2, 3);
    } else {
        v = webforms_internal_strdup(base);
    }
    webforms_internal_add_nv(self, "Ls", v);
    free(v);
    free(base);
}

static inline void webforms_call_sse_back_int(WebForms *self, const char *path, const char *output_place, bool use_current_event, bool should_reconnect, int reconnect_try_timeout)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", reconnect_try_timeout);
    webforms_call_sse_back_str(self, path, output_place, use_current_event, should_reconnect, buf);
}

static inline void webforms_call_front(WebForms *self, const char *module_path, const char **args, size_t args_count, const char *output_place, bool use_current_event)
{
    char *args_join = webforms_internal_join_args_bracket(args, args_count);
    char *with_gs = NULL;
    if (args_join[0] == '[') {
        with_gs = webforms_internal_concat2(WEBFORMS_GS_STR, args_join);
    } else {
        with_gs = webforms_internal_strdup("");
    }
    const char *parts[7] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, module_path, WEBFORMS_GS_STR, output_place, with_gs, "" };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_nv(self, "Lj", v);
    free(v);
    free(args_join);
    free(with_gs);
}

static inline void webforms_call_get_back(WebForms *self, const char *path, const char *output_place, bool use_current_event)
{
    bool has_out = (output_place && output_place[0] != '\0');
    const char *parts[5] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, path, has_out ? WEBFORMS_GS_STR : NULL, has_out ? output_place : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, "Lg", v);
    free(v);
}

static inline void webforms_call_put_back(WebForms *self, const char *path, const char *output_place, bool use_current_event)
{
    bool has_out = (output_place && output_place[0] != '\0');
    const char *parts[5] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, path, has_out ? WEBFORMS_GS_STR : NULL, has_out ? output_place : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, "Lt", v);
    free(v);
}

static inline void webforms_call_patch_back(WebForms *self, const char *path, const char *output_place, bool use_current_event)
{
    bool has_out = (output_place && output_place[0] != '\0');
    const char *parts[5] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, path, has_out ? WEBFORMS_GS_STR : NULL, has_out ? output_place : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, "LP", v);
    free(v);
}

static inline void webforms_call_delete_back(WebForms *self, const char *path, const char *output_place, bool use_current_event)
{
    bool has_out = (output_place && output_place[0] != '\0');
    const char *parts[5] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, path, has_out ? WEBFORMS_GS_STR : NULL, has_out ? output_place : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, "Ld", v);
    free(v);
}

static inline void webforms_call_head_back(WebForms *self, const char *path, bool use_current_event)
{
    const char *parts[3] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "Lh", v);
    free(v);
}

static inline void webforms_call_options_back(WebForms *self, const char *path, const char *output_place, bool use_current_event)
{
    bool has_out = (output_place && output_place[0] != '\0');
    const char *parts[5] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, path, has_out ? WEBFORMS_GS_STR : NULL, has_out ? output_place : NULL };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, "Lo", v);
    free(v);
}

static inline void webforms_call_send_back(WebForms *self, const char *path, const char *method, bool is_multi_part, const char *content_type, const char *data, const char *output_place, bool use_current_event)
{
    char *d = webforms_internal_str_replace_all(data, "\n", "$[ln];");
    bool has_out = (output_place && output_place[0] != '\0');
    const char *parts[11] = { use_current_event ? "1" : "0", WEBFORMS_GS_STR, path, WEBFORMS_GS_STR, method, WEBFORMS_GS_STR, is_multi_part ? "1" : "0", WEBFORMS_GS_STR, content_type, WEBFORMS_GS_STR, d };
    char *base = webforms_internal_join(parts, 11);
    char *v;
    if (has_out) {
        const char *p2[3] = { base, WEBFORMS_GS_STR, output_place };
        v = webforms_internal_join(p2, 3);
    } else {
        v = webforms_internal_strdup(base);
    }
    webforms_internal_add_nv(self, "LS", v);
    free(v);
    free(base);
    free(d);
}

// ============================================================
// Update
// ============================================================

static inline void webforms_increase(WebForms *self, const char *input_place, float value)
{
    char buf[64];
    snprintf(buf, sizeof(buf), "%f", value);
    const char *parts[3] = { "i", WEBFORMS_GS_STR, buf };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "gt", input_place, v);
    free(v);
}

static inline void webforms_decrease(WebForms *self, const char *input_place, float value)
{
    char buf[64];
    snprintf(buf, sizeof(buf), "%f", value * -1);
    const char *parts[3] = { "i", WEBFORMS_GS_STR, buf };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_prefixed(self, "gt", input_place, v);
    free(v);
}

// If You Don't Use Deep Mode, any Tags Inside the Current Tag Will Simply Be Treated as Strings. Deep Mode Does not Remove Inner Elements.
static inline void webforms_replace(WebForms *self, const char *input_place, const char *value, const char *new_value, bool also_start_tag, bool deep)
{
    const char *parts[9] = { "r", WEBFORMS_GS_STR, value, WEBFORMS_GS_STR, new_value, WEBFORMS_GS_STR, also_start_tag ? "1" : "0", WEBFORMS_GS_STR, deep ? "1" : "0" };
    char *v = webforms_internal_join(parts, 9);
    webforms_internal_add_prefixed(self, "gt", input_place, v);
    free(v);
}

// HTML Converts Attribute Names to Lowercase, so they Need to Be Written in Lowercase.
static inline void webforms_replace_start_tag(WebForms *self, const char *input_place, const char *value, const char *new_value)
{
    const char *parts[5] = { "s", WEBFORMS_GS_STR, value, WEBFORMS_GS_STR, new_value };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_prefixed(self, "gt", input_place, v);
    free(v);
}

// ============================================================
// Pre Runner
// ============================================================

static inline void webforms_assign_delay(WebForms *self, int mili_second, int index)
{
    char *current_line = webforms_get_line_by_index(self, index);
    if (!current_line || current_line[0] == '\0') {
        free(current_line);
        return;
    }
    char *eq = strchr(current_line, '=');
    char *name_part;
    char *value_part;
    if (eq) {
        size_t nlen = (size_t)(eq - current_line);
        name_part = (char *)malloc(nlen + 1);
        memcpy(name_part, current_line, nlen);
        name_part[nlen] = '\0';
        value_part = webforms_internal_strdup(eq + 1);
    } else {
        name_part = webforms_internal_strdup(current_line);
        value_part = webforms_internal_strdup("");
    }
    char prefix[32];
    snprintf(prefix, sizeof(prefix), ":%d)", mili_second);
    const char *parts[3] = { prefix, name_part, "" };
    char *new_name = webforms_internal_join(parts, 3);
    webforms_update_line_by_index(self, index, new_name, value_part);
    free(current_line);
    free(name_part);
    free(value_part);
    free(new_name);
}

static inline void webforms_assign_delay_change(WebForms *self, int mili_second, int index)
{
    char *current_line = webforms_get_line_by_index(self, index);
    if (!current_line || current_line[0] == '\0') {
        free(current_line);
        return;
    }
    char *eq = strchr(current_line, '=');
    char *name_part;
    char *value_part;
    if (eq) {
        size_t nlen = (size_t)(eq - current_line);
        name_part = (char *)malloc(nlen + 1);
        memcpy(name_part, current_line, nlen);
        name_part[nlen] = '\0';
        value_part = webforms_internal_strdup(eq + 1);
    } else {
        name_part = webforms_internal_strdup(current_line);
        value_part = webforms_internal_strdup("");
    }
    if (name_part[0] == ':' && strchr(name_part, ')')) {
        char *close = strchr(name_part, ')');
        char *trimmed = webforms_internal_strdup(close + 1);
        free(name_part);
        name_part = trimmed;
    }
    char prefix[32];
    snprintf(prefix, sizeof(prefix), ":%d)", mili_second);
    const char *parts[3] = { prefix, name_part, "" };
    char *new_name = webforms_internal_join(parts, 3);
    webforms_update_line_by_index(self, index, new_name, value_part);
    free(current_line);
    free(name_part);
    free(value_part);
    free(new_name);
}

static inline void webforms_assign_interval(WebForms *self, int mili_second, const char *id, int index)
{
    char *current_line = webforms_get_line_by_index(self, index);
    if (!current_line || current_line[0] == '\0') {
        free(current_line);
        return;
    }
    char *eq = strchr(current_line, '=');
    char *name_part;
    char *value_part;
    if (eq) {
        size_t nlen = (size_t)(eq - current_line);
        name_part = (char *)malloc(nlen + 1);
        memcpy(name_part, current_line, nlen);
        name_part[nlen] = '\0';
        value_part = webforms_internal_strdup(eq + 1);
    } else {
        name_part = webforms_internal_strdup(current_line);
        value_part = webforms_internal_strdup("");
    }
    char buf[64];
    if (id && id[0] != '\0') {
        snprintf(buf, sizeof(buf), "(%d|%s)", mili_second, id);
    } else {
        snprintf(buf, sizeof(buf), "(%d)", mili_second);
    }
    const char *parts[3] = { buf, name_part, "" };
    char *new_name = webforms_internal_join(parts, 3);
    webforms_update_line_by_index(self, index, new_name, value_part);
    free(current_line);
    free(name_part);
    free(value_part);
    free(new_name);
}

static inline void webforms_assign_interval_change(WebForms *self, int mili_second, const char *id, int index)
{
    char *current_line = webforms_get_line_by_index(self, index);
    if (!current_line || current_line[0] == '\0') {
        free(current_line);
        return;
    }
    char *eq = strchr(current_line, '=');
    char *name_part;
    char *value_part;
    if (eq) {
        size_t nlen = (size_t)(eq - current_line);
        name_part = (char *)malloc(nlen + 1);
        memcpy(name_part, current_line, nlen);
        name_part[nlen] = '\0';
        value_part = webforms_internal_strdup(eq + 1);
    } else {
        name_part = webforms_internal_strdup(current_line);
        value_part = webforms_internal_strdup("");
    }
    if (name_part[0] == '(' && strchr(name_part, ')')) {
        char *close = strchr(name_part, ')');
        char *trimmed = webforms_internal_strdup(close + 1);
        free(name_part);
        name_part = trimmed;
    }
    char buf[64];
    if (id && id[0] != '\0') {
        snprintf(buf, sizeof(buf), "(%d|%s)", mili_second, id);
    } else {
        snprintf(buf, sizeof(buf), "(%d)", mili_second);
    }
    const char *parts[3] = { buf, name_part, "" };
    char *new_name = webforms_internal_join(parts, 3);
    webforms_update_line_by_index(self, index, new_name, value_part);
    free(current_line);
    free(name_part);
    free(value_part);
    free(new_name);
}

static inline void webforms_delete_interval(WebForms *self, const char *id)
{
    webforms_internal_add_nv(self, "Di", id);
}

static inline void webforms_assign_repeat(WebForms *self, int count, int index)
{
    char *current_line = webforms_get_line_by_index(self, index);
    if (!current_line || current_line[0] == '\0') {
        free(current_line);
        return;
    }
    char *eq = strchr(current_line, '=');
    char *name_part;
    char *value_part;
    if (eq) {
        size_t nlen = (size_t)(eq - current_line);
        name_part = (char *)malloc(nlen + 1);
        memcpy(name_part, current_line, nlen);
        name_part[nlen] = '\0';
        value_part = webforms_internal_strdup(eq + 1);
    } else {
        name_part = webforms_internal_strdup(current_line);
        value_part = webforms_internal_strdup("");
    }
    char prefix[32];
    snprintf(prefix, sizeof(prefix), ",%d)", count);
    const char *parts[3] = { prefix, name_part, "" };
    char *new_name = webforms_internal_join(parts, 3);
    webforms_update_line_by_index(self, index, new_name, value_part);
    free(current_line);
    free(name_part);
    free(value_part);
    free(new_name);
}

static inline void webforms_assign_repeat_change(WebForms *self, int count, int index)
{
    char *current_line = webforms_get_line_by_index(self, index);
    if (!current_line || current_line[0] == '\0') {
        free(current_line);
        return;
    }
    char *eq = strchr(current_line, '=');
    char *name_part;
    char *value_part;
    if (eq) {
        size_t nlen = (size_t)(eq - current_line);
        name_part = (char *)malloc(nlen + 1);
        memcpy(name_part, current_line, nlen);
        name_part[nlen] = '\0';
        value_part = webforms_internal_strdup(eq + 1);
    } else {
        name_part = webforms_internal_strdup(current_line);
        value_part = webforms_internal_strdup("");
    }
    if (name_part[0] == ',' && strchr(name_part, ')')) {
        char *close = strchr(name_part, ')');
        char *trimmed = webforms_internal_strdup(close + 1);
        free(name_part);
        name_part = trimmed;
    }
    char prefix[32];
    snprintf(prefix, sizeof(prefix), ",%d)", count);
    const char *parts[3] = { prefix, name_part, "" };
    char *new_name = webforms_internal_join(parts, 3);
    webforms_update_line_by_index(self, index, new_name, value_part);
    free(current_line);
    free(name_part);
    free(value_part);
    free(new_name);
}

// ============================================================
// Index
// ============================================================

static inline void webforms_start_index(WebForms *self, const char *name)
{
    webforms_internal_add_nv(self, "#", name);
}

static inline void webforms_start_index_default(WebForms *self)
{
    webforms_start_index(self, "");
}

// This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
static inline void webforms_start_state(WebForms *self)
{
    webforms_start_index(self, "$");
}

static inline void webforms_go_to_str(WebForms *self, const char *line, const char *repeat)
{
    const char *parts[3] = { line, WEBFORMS_GS_STR, repeat };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "&", v);
    free(v);
}

static inline void webforms_go_to_int(WebForms *self, int line, int repeat)
{
    char lb[32], rb[32];
    snprintf(lb, sizeof(lb), "%d", line);
    snprintf(rb, sizeof(rb), "%d", repeat);
    webforms_go_to_str(self, lb, rb);
}

static inline void webforms_go_to_index_str(WebForms *self, const char *index, int repeat)
{
    char lb[512];
    snprintf(lb, sizeof(lb), "#%s", index);
    char rb[32];
    snprintf(rb, sizeof(rb), "%d", repeat);
    webforms_go_to_str(self, lb, rb);
}

// ============================================================
// Start
// ============================================================

static inline void webforms_start_transient_dom(WebForms *self, const char *input_place)
{
    webforms_internal_add_nv(self, "td", input_place);
}

static inline void webforms_end_transient_dom(WebForms *self)
{
    webforms_internal_add_nv(self, "td", ";");
}

// ============================================================
// Message
// Type: warning, problem, help, success, none
// ============================================================

static inline void webforms_alert(WebForms *self, const char *text, const char *type, const char *title, const char *ok_text)
{
    const char *tp = (type && strcmp(type, "none") == 0) ? "" : (type ? type : "");
    const char *ti = (title && strcmp(title, "Alert") == 0) ? "" : (title ? title : "");
    const char *ot = (ok_text && strcmp(ok_text, "OK") == 0) ? "" : (ok_text ? ok_text : "");
    const char *parts[7] = { text, WEBFORMS_GS_STR, tp, WEBFORMS_GS_STR, ti, WEBFORMS_GS_STR, ot };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_nv(self, "Al", v);
    free(v);
}

static inline void webforms_message(WebForms *self, const char *text, const char *type, const char *duration)
{
    const char *tp = (type && strcmp(type, "none") == 0) ? "" : (type ? type : "");
    const char *d = (duration && strcmp(duration, "0") == 0) ? "" : (duration ? duration : "");
    const char *parts[5] = { text, WEBFORMS_GS_STR, tp, WEBFORMS_GS_STR, d };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, "me", v);
    free(v);
}

static inline void webforms_message_type_duration_int(WebForms *self, const char *text, const char *type, int duration)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", duration);
    webforms_message(self, text, type, buf);
}

static inline void webforms_message_duration_int(WebForms *self, const char *text, int duration)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", duration);
    webforms_message(self, text, "", buf);
}

// Type: log, info, warn, error, debug, trace, group, groupend, table
static inline void webforms_console_message(WebForms *self, const char *text, const char *type)
{
    char *v1 = webforms_internal_str_replace_all(text, "\n", "$[ln];");
    bool has_type = (type && strcmp(type, "log") != 0);
    const char *parts[3] = { v1, has_type ? WEBFORMS_GS_STR : NULL, has_type ? type : NULL };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "mc", v);
    free(v);
    free(v1);
}

static inline void webforms_console_message_assert(WebForms *self, const char *text, const char *condition)
{
    char *v1 = webforms_internal_str_replace_all(text, "\n", "$[ln];");
    const char *parts[3] = { v1, WEBFORMS_GS_STR, condition };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "ma", v);
    free(v);
    free(v1);
}

// ============================================================
// Enable
// Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
// ============================================================

static inline void webforms_enable_web_socket(WebForms *self, bool enable)
{
    webforms_internal_add_nv(self, "ew", enable ? "1" : "0");
}

static inline void webforms_enable_web_socket_once(WebForms *self)
{
    webforms_internal_add_nv(self, "ew", "$");
}

static inline void webforms_add_web_socket(WebForms *self, const char *path)
{
    char *k = webforms_internal_concat2("aw", path);
    webforms_internal_add_n(self, k);
    free(k);
}

// Disconnected WebSocket
static inline void webforms_delete_web_socket(WebForms *self, const char *path)
{
    char *k = webforms_internal_concat2("dw", path);
    webforms_internal_add_n(self, k);
    free(k);
}

// ============================================================
// Use
// InputPlace Using Only For form Element
// ============================================================

static inline void webforms_use_web_socket(WebForms *self, const char *input_place)
{
    webforms_internal_add_prefixed_noval(self, "uw", input_place);
}

static inline void webforms_use_only_change_update(WebForms *self, const char *input_place)
{
    webforms_internal_add_prefixed_noval(self, "uo", input_place);
}

// ============================================================
// Condition And Loop
// Condition And Loop Supports Brackets and Then
// Type: warning, problem, help, success, none
// Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
// Nested Conditions and Nested Loops are Possible.
// ============================================================

static inline WebForms *webforms_confirm_is_true_accept(WebForms *self, const char *text, const char *type, const char *title, const char *ok_text, const char *cancel_text, int interval)
{
    const char *t = (text && strcmp(text, "Are you sure you want to proceed?") == 0) ? "" : (text ? text : "");
    const char *tp = (type && strcmp(type, "none") == 0) ? "" : (type ? type : "");
    const char *ti = (title && strcmp(title, "Confirm") == 0) ? "" : (title ? title : "");
    const char *ot = (ok_text && strcmp(ok_text, "OK") == 0) ? "" : (ok_text ? ok_text : "");
    const char *ct = (cancel_text && strcmp(cancel_text, "Cancel") == 0) ? "" : (cancel_text ? cancel_text : "");
    const char *parts[11] = { t, WEBFORMS_GS_STR, tp, WEBFORMS_GS_STR, ti, WEBFORMS_GS_STR, ot, WEBFORMS_GS_STR, ct, "", "" };
    char *v = webforms_internal_join(parts, 9);
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)ct", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{ct");
    }
    webforms_internal_add_nv(self, name_buf, v);
    free(v);
    return self;
}

static inline WebForms *webforms_confirm_is_false_accept(WebForms *self, const char *text, const char *type, const char *title, const char *ok_text, const char *cancel_text, int interval)
{
    const char *t = (text && strcmp(text, "Are you sure you want to proceed?") == 0) ? "" : (text ? text : "");
    const char *tp = (type && strcmp(type, "none") == 0) ? "" : (type ? type : "");
    const char *ti = (title && strcmp(title, "Confirm") == 0) ? "" : (title ? title : "");
    const char *ot = (ok_text && strcmp(ok_text, "OK") == 0) ? "" : (ok_text ? ok_text : "");
    const char *ct = (cancel_text && strcmp(cancel_text, "Cancel") == 0) ? "" : (cancel_text ? cancel_text : "");
    const char *parts[11] = { t, WEBFORMS_GS_STR, tp, WEBFORMS_GS_STR, ti, WEBFORMS_GS_STR, ot, WEBFORMS_GS_STR, ct, "", "" };
    char *v = webforms_internal_join(parts, 9);
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)cf", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{cf");
    }
    webforms_internal_add_nv(self, name_buf, v);
    free(v);
    return self;
}

static inline WebForms *webforms_is_greater_than(WebForms *self, const char *first_value, const char *second_value, int interval)
{
    const char *parts[3] = { first_value, WEBFORMS_GS_STR, second_value };
    char *v = webforms_internal_join(parts, 3);
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)gt", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{gt");
    }
    webforms_internal_add_nv(self, name_buf, v);
    free(v);
    return self;
}

static inline WebForms *webforms_is_less_than(WebForms *self, const char *first_value, const char *second_value, int interval)
{
    const char *parts[3] = { first_value, WEBFORMS_GS_STR, second_value };
    char *v = webforms_internal_join(parts, 3);
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)lt", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{lt");
    }
    webforms_internal_add_nv(self, name_buf, v);
    free(v);
    return self;
}

static inline WebForms *webforms_is_equal_to(WebForms *self, const char *first_value, const char *second_value, int interval)
{
    const char *parts[3] = { first_value, WEBFORMS_GS_STR, second_value };
    char *v = webforms_internal_join(parts, 3);
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)et", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{et");
    }
    webforms_internal_add_nv(self, name_buf, v);
    free(v);
    return self;
}

static inline WebForms *webforms_is_not_equal_to(WebForms *self, const char *first_value, const char *second_value, int interval)
{
    const char *parts[3] = { first_value, WEBFORMS_GS_STR, second_value };
    char *v = webforms_internal_join(parts, 3);
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)Nt", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{Nt");
    }
    webforms_internal_add_nv(self, name_buf, v);
    free(v);
    return self;
}

static inline WebForms *webforms_exist(WebForms *self, const char *value, int interval)
{
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)ex", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{ex");
    }
    webforms_internal_add_nv(self, name_buf, value);
    return self;
}

static inline WebForms *webforms_not_exist(WebForms *self, const char *value, int interval)
{
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)nx", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{nx");
    }
    webforms_internal_add_nv(self, name_buf, value);
    return self;
}

static inline WebForms *webforms_is_true(WebForms *self, const char *value, int interval)
{
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)tr", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{tr");
    }
    webforms_internal_add_nv(self, name_buf, value);
    return self;
}

static inline WebForms *webforms_is_false(WebForms *self, const char *value, int interval)
{
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)fa", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{fa");
    }
    webforms_internal_add_nv(self, name_buf, value);
    return self;
}

static inline WebForms *webforms_is_match_media(WebForms *self, const char *value, int interval)
{
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)mm", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{mm");
    }
    webforms_internal_add_nv(self, name_buf, value);
    return self;
}

static inline WebForms *webforms_is_not_match_media(WebForms *self, const char *value, int interval)
{
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)nm", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{nm");
    }
    webforms_internal_add_nv(self, name_buf, value);
    return self;
}

static inline WebForms *webforms_include(WebForms *self, const char *text, const char *value, int interval)
{
    const char *parts[3] = { value, WEBFORMS_GS_STR, text };
    char *v = webforms_internal_join(parts, 3);
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)In", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{In");
    }
    webforms_internal_add_nv(self, name_buf, v);
    free(v);
    return self;
}

static inline WebForms *webforms_not_include(WebForms *self, const char *text, const char *value, int interval)
{
    const char *parts[3] = { value, WEBFORMS_GS_STR, text };
    char *v = webforms_internal_join(parts, 3);
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)Nn", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{Nn");
    }
    webforms_internal_add_nv(self, name_buf, v);
    free(v);
    return self;
}

static inline WebForms *webforms_element_exists(WebForms *self, const char *input_place, int interval)
{
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)eE", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{eE");
    }
    webforms_internal_add_nv(self, name_buf, input_place);
    return self;
}

static inline WebForms *webforms_element_not_exists(WebForms *self, const char *input_place, int interval)
{
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)nE", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{nE");
    }
    webforms_internal_add_nv(self, name_buf, input_place);
    return self;
}

static inline WebForms *webforms_is_regex_match(WebForms *self, const char *value, const char *pattern, int interval)
{
    const char *parts[3] = { value, WEBFORMS_GS_STR, pattern };
    char *v = webforms_internal_join(parts, 3);
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)re", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{re");
    }
    webforms_internal_add_nv(self, name_buf, v);
    free(v);
    return self;
}

static inline WebForms *webforms_is_regex_not_match(WebForms *self, const char *value, const char *pattern, int interval)
{
    const char *parts[3] = { value, WEBFORMS_GS_STR, pattern };
    char *v = webforms_internal_join(parts, 3);
    char name_buf[64];
    if (interval >= 0) {
        snprintf(name_buf, sizeof(name_buf), "{(%d)rn", interval);
    } else {
        snprintf(name_buf, sizeof(name_buf), "{rn");
    }
    webforms_internal_add_nv(self, name_buf, v);
    free(v);
    return self;
}

// In: Everything Becomes A JSON List.
// Key: Creates A Temporary Data In The Browser IndexedDB.
// Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
static inline WebForms *webforms_for_each(WebForms *self, const char *path, const char *in, const char *key)
{
    const char *parts[5] = { path, WEBFORMS_GS_STR, in, WEBFORMS_GS_STR, key };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, "{fe", v);
    free(v);
    return self;
}

static inline void webforms_break(WebForms *self)
{
    webforms_internal_add_n(self, ";");
}

static inline WebForms *webforms_else(WebForms *self)
{
    webforms_internal_add_n(self, "}e");
    return self;
}

static inline void webforms_start_bracket(WebForms *self)
{
    webforms_internal_add_n(self, "{");
}

static inline void webforms_end_bracket(WebForms *self)
{
    webforms_internal_add_n(self, "}");
}

// Used Then In Condition And Loop Methods
static inline WebForms *webforms_then(WebForms *self, WebForms *new_form)
{
    char *data = new_form ? webforms_get_web_forms_data(new_form) : NULL;
    if (data && data[0] != '\0') {
        if (strchr(data, '\n')) {
            webforms_internal_add_to_up_n(new_form, "{");
            webforms_internal_add_n(new_form, "}");
        }
    }
    webforms_append_form(self, new_form);
    if (data) free(data);
    return self;
}

static inline WebForms *webforms_repeat(WebForms *self, WebForms *new_form, int repeat)
{
    if (!new_form)
        return self;
    char *body_data = webforms_get_web_forms_data(new_form);
    if (!body_data || body_data[0] == '\0') {
        if (body_data) free(body_data);
        return self;
    }
    size_t line_count = 1;
    for (char *p = body_data; *p; p++) if (*p == '\n') line_count++;
    int start_line = -(int)line_count;
    free(body_data);
    webforms_append_form(self, new_form);
    webforms_go_to_int(self, start_line, repeat - 1);
    return self;
}

static inline WebForms *webforms_repeat_index(WebForms *self, WebForms *new_form, int repeat, const char *index)
{
    if (!new_form)
        return self;
    webforms_go_to_index_str(self, index, 1);
    webforms_start_index(self, index);
    char *body_data = webforms_get_web_forms_data(new_form);
    if (!body_data || body_data[0] == '\0') {
        if (body_data) free(body_data);
        return self;
    }
    free(body_data);
    webforms_append_form(self, new_form);
    if (!index || index[0] == '\0') {
        int index_number = -1;
        char *self_data = webforms_get_web_forms_data(self);
        if (self_data) {
            size_t count;
            char **lines = webforms_internal_split_lines(self_data, &count);
            for (size_t i = 0; i < count; i++) {
                if (lines[i][0] == '#') index_number++;
            }
            webforms_internal_free_lines(lines, count);
            free(self_data);
        }
        char buf[32];
        snprintf(buf, sizeof(buf), "%d", index_number);
        webforms_go_to_str(self, buf, "0");
        char rb[32];
        snprintf(rb, sizeof(rb), "%d", repeat - 1);
        int idx = (int)self->length;
        (void)idx;
        webforms_go_to_int(self, index_number, repeat - 1);
    } else {
        webforms_go_to_index_str(self, index, repeat - 1);
    }
    return self;
}

// ============================================================
// Async
// It Supports Brackets and Then
// ============================================================

static inline WebForms *webforms_async(WebForms *self)
{
    webforms_internal_add_n(self, "{(a)");
    return self;
}

static inline void webforms_delay_str(WebForms *self, const char *mili_second)
{
    webforms_internal_add_nv(self, "De", mili_second);
}

static inline void webforms_delay_int(WebForms *self, int mili_second)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", mili_second);
    webforms_delay_str(self, buf);
}

// ============================================================
// Option
// ============================================================

static inline void webforms_change_option(WebForms *self, const char *name, const char *value)
{
    const char *parts[3] = { name, WEBFORMS_GS_STR, value };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, "co", v);
    free(v);
}

static inline void webforms_reset_option(WebForms *self)
{
    webforms_internal_add_n(self, "ro");
}

static inline void webforms_reset_option_name(WebForms *self, const char *name)
{
    webforms_internal_add_nv(self, "ro", name);
}

// ============================================================
// Format Storage
// ============================================================

static inline void webforms_create_format_storage(WebForms *self, const char *key, const char *data)
{
    const char *parts[3] = { key, WEBFORMS_GS_STR, data };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, ".C", v);
    free(v);
}

static inline void webforms_delete_format_storage(WebForms *self, const char *key)
{
    webforms_internal_add_nv(self, ".D", key);
}

static inline void webforms_add_json(WebForms *self, const char *key, const char *path, const char *value)
{
    const char *parts[7] = { key, WEBFORMS_GS_STR, "j", WEBFORMS_GS_STR, value, WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_nv(self, ".a", v);
    free(v);
}

// Name: For Support Attribute, Set Double At Sign (@@) Before Name.
static inline void webforms_add_xml(WebForms *self, const char *key, const char *path, const char *name, const char *value)
{
    const char *parts[9] = { key, WEBFORMS_GS_STR, "x", WEBFORMS_GS_STR, name, WEBFORMS_GS_STR, value, WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 9);
    webforms_internal_add_nv(self, ".a", v);
    free(v);
}

static inline void webforms_add_ini(WebForms *self, const char *key, const char *path, const char *value, bool is_ini_like)
{
    const char *il = webforms_internal_bool_to_cs(is_ini_like);
    const char *parts[9] = { key, WEBFORMS_GS_STR, "i", WEBFORMS_GS_STR, il, WEBFORMS_GS_STR, value, WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 9);
    webforms_internal_add_nv(self, ".a", v);
    free(v);
}

static inline void webforms_add_text_line_str(WebForms *self, const char *key, const char *line, const char *text)
{
    const char *parts[7] = { key, WEBFORMS_GS_STR, "t", WEBFORMS_GS_STR, text, WEBFORMS_GS_STR, line };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_nv(self, ".a", v);
    free(v);
}

static inline void webforms_add_text_line_int(WebForms *self, const char *key, int line, const char *text)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", line);
    webforms_add_text_line_str(self, key, buf, text);
}

static inline void webforms_add_variable(WebForms *self, const char *key, const char *value)
{
    const char *parts[5] = { key, WEBFORMS_GS_STR, "v", WEBFORMS_GS_STR, value };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, ".a", v);
    free(v);
}

static inline void webforms_update_json(WebForms *self, const char *key, const char *path, const char *value)
{
    const char *parts[7] = { key, WEBFORMS_GS_STR, "j", WEBFORMS_GS_STR, value, WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_nv(self, ".u", v);
    free(v);
}

static inline void webforms_update_xml(WebForms *self, const char *key, const char *path, const char *value)
{
    const char *parts[7] = { key, WEBFORMS_GS_STR, "x", WEBFORMS_GS_STR, value, WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_nv(self, ".u", v);
    free(v);
}

static inline void webforms_update_ini(WebForms *self, const char *key, const char *path, const char *value, bool is_ini_like)
{
    const char *il = webforms_internal_bool_to_cs(is_ini_like);
    const char *parts[9] = { key, WEBFORMS_GS_STR, "i", WEBFORMS_GS_STR, il, WEBFORMS_GS_STR, value, WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 9);
    webforms_internal_add_nv(self, ".u", v);
    free(v);
}

static inline void webforms_update_tex_line_str(WebForms *self, const char *key, const char *line, const char *text)
{
    const char *parts[7] = { key, WEBFORMS_GS_STR, "t", WEBFORMS_GS_STR, text, WEBFORMS_GS_STR, line };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_nv(self, ".u", v);
    free(v);
}

static inline void webforms_update_tex_line_int(WebForms *self, const char *key, int line, const char *text)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", line);
    webforms_update_tex_line_str(self, key, buf, text);
}

static inline void webforms_update_variable(WebForms *self, const char *key, const char *value)
{
    const char *parts[5] = { key, WEBFORMS_GS_STR, "v", WEBFORMS_GS_STR, value };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, ".u", v);
    free(v);
}

static inline void webforms_increase_variable_str(WebForms *self, const char *key, const char *value)
{
    const char *parts[5] = { key, WEBFORMS_GS_STR, "v", WEBFORMS_GS_STR, value };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, ".i", v);
    free(v);
}

static inline void webforms_increase_variable_int(WebForms *self, const char *key, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value);
    webforms_increase_variable_str(self, key, buf);
}

static inline void webforms_decrease_variable(WebForms *self, const char *key, int value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", value * -1);
    webforms_increase_variable_str(self, key, buf);
}

static inline void webforms_delete_json(WebForms *self, const char *key, const char *path)
{
    const char *parts[5] = { key, WEBFORMS_GS_STR, "j", WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, ".d", v);
    free(v);
}

static inline void webforms_delete_xml(WebForms *self, const char *key, const char *path)
{
    const char *parts[5] = { key, WEBFORMS_GS_STR, "x", WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, ".d", v);
    free(v);
}

static inline void webforms_delete_ini(WebForms *self, const char *key, const char *path, bool is_ini_like)
{
    const char *il = webforms_internal_bool_to_cs(is_ini_like);
    const char *parts[7] = { key, WEBFORMS_GS_STR, "i", WEBFORMS_GS_STR, il, WEBFORMS_GS_STR, path };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_nv(self, ".d", v);
    free(v);
}

static inline void webforms_delete_text_line_str(WebForms *self, const char *key, const char *line)
{
    const char *parts[5] = { key, WEBFORMS_GS_STR, "t", WEBFORMS_GS_STR, line };
    char *v = webforms_internal_join(parts, 5);
    webforms_internal_add_nv(self, ".d", v);
    free(v);
}

static inline void webforms_delete_text_line_int(WebForms *self, const char *key, int line)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", line);
    webforms_delete_text_line_str(self, key, buf);
}

static inline void webforms_delete_variable(WebForms *self, const char *key)
{
    const char *parts[3] = { key, WEBFORMS_GS_STR, "v" };
    char *v = webforms_internal_join(parts, 3);
    webforms_internal_add_nv(self, ".d", v);
    free(v);
}

// ============================================================
// Template Engine
// Pattern Example: {{value}}, ((value)), *value*, $value;
// ============================================================

static inline void webforms_bind_json_to_template(WebForms *self, const char *input_place, const char *json_text, const char *path, const char *pattern, bool also_start_tag)
{
    const char *parts[9] = { json_text, WEBFORMS_GS_STR, path, WEBFORMS_GS_STR, pattern, WEBFORMS_GS_STR, also_start_tag ? "1" : "0", "", "" };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_prefixed(self, "Tj", input_place, v);
    free(v);
}

// Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
static inline void webforms_bind_xml_to_template(WebForms *self, const char *input_place, const char *xml_text, const char *path, const char *pattern, bool also_start_tag)
{
    const char *parts[9] = { xml_text, WEBFORMS_GS_STR, path, WEBFORMS_GS_STR, pattern, WEBFORMS_GS_STR, also_start_tag ? "1" : "0", "", "" };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_prefixed(self, "Tx", input_place, v);
    free(v);
}

static inline void webforms_bind_ini_to_template(WebForms *self, const char *input_place, const char *ini_text, const char *path, const char *pattern, bool also_start_tag)
{
    const char *parts[9] = { ini_text, WEBFORMS_GS_STR, path, WEBFORMS_GS_STR, pattern, WEBFORMS_GS_STR, also_start_tag ? "1" : "0", "", "" };
    char *v = webforms_internal_join(parts, 7);
    webforms_internal_add_prefixed(self, "Ti", input_place, v);
    free(v);
}

// ============================================================
// Inject
// Need Add @: to First of String
// ============================================================

static inline char *webforms_inject(const char *value)
{
    const char *parts[3] = { "$[", value, "];" };
    return webforms_internal_join(parts, 3);
}

// ============================================================
// Action Control
// ============================================================

static inline void webforms_replace_action_control(WebForms *self, const char *search_value, const char *value, bool adding_to_up)
{
    const char *parts[3] = { search_value, WEBFORMS_GS_STR, value };
    char *v = webforms_internal_join(parts, 3);
    if (adding_to_up)
        webforms_internal_add_to_up_nv(self, "rE", v);
    else
        webforms_internal_add_nv(self, "rE", v);
    free(v);
}

static inline void webforms_assign_replace(WebForms *self, const char *search_value, const char *value, int index)
{
    char *current_line = webforms_get_line_by_index(self, index);
    if (!current_line || current_line[0] == '\0') {
        free(current_line);
        return;
    }
    char *eq = strchr(current_line, '=');
    char *name_part;
    char *value_part;
    if (eq) {
        size_t nlen = (size_t)(eq - current_line);
        name_part = (char *)malloc(nlen + 1);
        memcpy(name_part, current_line, nlen);
        name_part[nlen] = '\0';
        value_part = webforms_internal_strdup(eq + 1);
    } else {
        name_part = webforms_internal_strdup(current_line);
        value_part = webforms_internal_strdup("");
    }
    char sep[2] = { WEBFORMS_GS, '\0' };
    const char *parts[6] = { ";", search_value, sep, value, sep, name_part };
    char *new_name = webforms_internal_join(parts, 6);
    webforms_update_line_by_index(self, index, new_name, value_part);
    free(current_line);
    free(name_part);
    free(value_part);
    free(new_name);
}

// ============================================================
// Hash And Checksum
// ============================================================

static inline void webforms_set_hash(WebForms *self)
{
    webforms_internal_add_n(self, "SH");
}

static inline void webforms_set_checksum(WebForms *self)
{
    webforms_internal_add_n(self, "CS");
}

static inline char *webforms_checksum_calculation(const char *text)
{
    int sum = 0;
    int mod = 65536;
    int shift = 5;
    if (text) {
        for (const char *p = text; *p; p++) {
            sum = ((sum << shift) | (sum >> (16 - shift))) ^ (unsigned char)(*p);
            sum %= mod;
        }
    }
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", sum);
    return webforms_internal_strdup(buf);
}

static inline char *webforms_get_checksum(WebForms *self)
{
    char *data = webforms_get_web_forms_data(self);
    char *r = webforms_checksum_calculation(data);
    if (data) free(data);
    return r;
}

// ============================================================
// Get
// ============================================================

static inline char *webforms_get_forms_action_data(WebForms *self)
{
    if (self->length == 0)
        return webforms_internal_strdup("");
    return webforms_internal_strdup(self->data);
}

static inline char *webforms_response(WebForms *self)
{
    char *d = webforms_get_forms_action_data(self);
    const char *parts[2] = { "[web-forms]\n", d };
    char *r = webforms_internal_join(parts, 2);
    free(d);
    return r;
}

static inline char *webforms_get_forms_action_data_line_break(WebForms *self)
{
    if (self->length == 0)
        return webforms_internal_strdup("");
    char *step1 = webforms_internal_str_replace_all(self->data, "\"", "$[dq];");
    char *step2 = webforms_internal_str_replace_all(step1, "\n", "$[sln];");
    free(step1);
    return step2;
}

// ============================================================
// Export
// ============================================================

static inline char *webforms_export_to_html_comment(WebForms *self, bool add_line)
{
    char *resp = webforms_response(self);
    char *replaced = webforms_internal_str_replace_all(resp, "--", "$[dd];");
    free(resp);
    size_t rlen = strlen(replaced);
    if (rlen > 0 && replaced[rlen - 1] == '-') {
        char *tmp = (char *)malloc(rlen + 8 + 1);
        memcpy(tmp, replaced, rlen - 1);
        strcpy(tmp + rlen - 1, "$[da];");
        free(replaced);
        replaced = tmp;
    }
    const char *parts[5] = { add_line ? "\n" : "", "<!--", replaced, "-->", "" };
    char *r = webforms_internal_join(parts, 4);
    free(replaced);
    return r;
}

static inline char *webforms_export_to_line_break(WebForms *self, const char *src)
{
    (void)src;
    char *d = webforms_get_forms_action_data_line_break(self);
    const char *parts[2] = { "[web-forms]$[sln];", d };
    char *r = webforms_internal_join(parts, 2);
    free(d);
    return r;
}

static inline char *webforms_get_web_forms_data(WebForms *self)
{
    return webforms_internal_strdup(self->data ? self->data : "");
}

static inline void webforms_append_form(WebForms *self, WebForms *form)
{
    if (!form)
        return;
    char *other = webforms_get_web_forms_data(form);
    if (other && other[0] != '\0') {
        if (self->length > 0)
            webforms_internal_append_char(self, '\n');
        webforms_internal_append_str(self, other);
    }
    if (other) free(other);
}

static inline void webforms_clean(WebForms *self)
{
    self->length = 0;
    if (self->data) self->data[0] = '\0';
}

// ============================================================
// Security
// ============================================================

typedef struct Security {
    char _unused;
} Security;

static inline char *webforms_security_safe_value(Security *self, const char *value)
{
    (void)self;
    if (!value || value[0] == '\0')
        return webforms_internal_strdup(value ? value : "");
    char *step = NULL;
    if (value[0] == '@') {
        const char *parts[2] = { "@", value };
        step = webforms_internal_join(parts, 2);
    } else {
        step = webforms_internal_strdup(value);
    }
    char *s1 = webforms_internal_str_replace_all(step, "\n", "$[ln];");
    free(step);
    char *s2 = webforms_internal_str_replace_all(s1, ",@", "$[co];@");
    free(s1);
    char *s3 = webforms_internal_char_replace_all(s2, (char)28, "\0");
    free(s2);
    char *s4 = webforms_internal_char_replace_all(s3, (char)29, "\0");
    free(s3);
    char *s5 = webforms_internal_char_replace_all(s4, (char)30, "\0");
    free(s4);
    char *s6 = webforms_internal_char_replace_all(s5, (char)31, "\0");
    free(s5);
    return s6;
}

// ============================================================
// InputPlace / OutputPlace
// WebForms Place Criteria (WPC) DSL
// ============================================================

typedef struct InputPlace {
    char _unused;
} InputPlace;

typedef struct OutputPlace {
    char _unused;
} OutputPlace;

#define WEBFORMS_IP_DOCUMENT ","
#define WEBFORMS_IP_WINDOW "`"
// When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
#define WEBFORMS_IP_ROOT "~"
#define WEBFORMS_IP_HTML "."
#define WEBFORMS_IP_HEAD "^"
#define WEBFORMS_IP_SCREEN_ORIENTATION "%"
#define WEBFORMS_IP_ALL "*"
#define WEBFORMS_IP_PARENT "/"
#define WEBFORMS_IP_CURRENT "$"
#define WEBFORMS_IP_TARGET "!"
#define WEBFORMS_IP_UPPER "-"

static inline char *webforms_ip_id(const char *id)
{
    return webforms_internal_strdup(id);
}

static inline char *webforms_ip_name(const char *name)
{
    const char *parts[3] = { "(", name, ")" };
    return webforms_internal_join(parts, 3);
}

static inline char *webforms_ip_name_index(const char *name, int index)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "(%s)%d", name, index);
    return webforms_internal_strdup(buf);
}

static inline char *webforms_ip_all_names(const char *name)
{
    const char *parts[4] = { "(", name, ")*", "" };
    return webforms_internal_join(parts, 3);
}

static inline char *webforms_ip_tag(const char *tag)
{
    const char *parts[3] = { "<", tag, ">" };
    return webforms_internal_join(parts, 3);
}

static inline char *webforms_ip_tag_index(const char *tag, int index)
{
    char buf[256];
    snprintf(buf, sizeof(buf), "<%s>%d", tag, index);
    return webforms_internal_strdup(buf);
}

static inline char *webforms_ip_all_tags(const char *tag)
{
    const char *parts[4] = { "<", tag, ">*", "" };
    return webforms_internal_join(parts, 3);
}

static inline char *webforms_ip_child(void)
{
    return webforms_internal_strdup("<>");
}

static inline char *webforms_ip_child_index(int index)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "<>%d", index);
    return webforms_internal_strdup(buf);
}

static inline char *webforms_ip_all_child(void)
{
    return webforms_internal_strdup("< >*");
}

static inline char *webforms_ip_class(const char *cls)
{
    const char *parts[3] = { "{", cls, "}" };
    return webforms_internal_join(parts, 3);
}

static inline char *webforms_ip_class_index(const char *cls, int index)
{
    char buf[256];
    snprintf(buf, sizeof(buf), "{%s}%d", cls, index);
    return webforms_internal_strdup(buf);
}

static inline char *webforms_ip_all_classes(const char *cls)
{
    const char *parts[4] = { "{", cls, "}*", "" };
    return webforms_internal_join(parts, 3);
}

static inline char *webforms_ip_attribute(const char *name)
{
    const char *parts[3] = { "\"", name, "\"" };
    return webforms_internal_join(parts, 3);
}

static inline char *webforms_ip_attribute_index(const char *name, int index)
{
    char buf[256];
    snprintf(buf, sizeof(buf), "\"%s\"%d", name, index);
    return webforms_internal_strdup(buf);
}

static inline char *webforms_ip_all_attributes(const char *name)
{
    const char *parts[4] = { "\"", name, "\"*", "" };
    return webforms_internal_join(parts, 3);
}

// Operator: '^', '$', '*', '~'
static inline char *webforms_ip_attribute_op(const char *name, const char *value, char op)
{
    char opbuf[2] = { op, '\0' };
    const char *opstr = (op != '\0') ? opbuf : "";
    const char *parts[6] = { "\"", name, opstr, "'", value, "\"" };
    return webforms_internal_join(parts, 6);
}

static inline char *webforms_ip_attribute_op_index(const char *name, const char *value, int index, char op)
{
    char opbuf[2] = { op, '\0' };
    const char *opstr = (op != '\0') ? opbuf : "";
    char idx[32];
    snprintf(idx, sizeof(idx), "%d", index);
    const char *parts[7] = { "\"", name, opstr, "'", value, "\"", idx };
    return webforms_internal_join(parts, 7);
}

static inline char *webforms_ip_all_attributes_op(const char *name, const char *value, char op)
{
    char opbuf[2] = { op, '\0' };
    const char *opstr = (op != '\0') ? opbuf : "";
    const char *parts[7] = { "\"", name, opstr, "'", value, "\"*", "" };
    return webforms_internal_join(parts, 6);
}

static inline char *webforms_ip_query(const char *query)
{
    char *s1 = webforms_internal_str_replace_all(query, "=", "$[eq];");
    char *s2 = webforms_internal_str_replace_all(s1, "|", "$[vb];");
    char *s3 = webforms_internal_str_replace_all(s2, "?", "$[qu];");
    free(s1); free(s2);
    const char *parts[2] = { "*", s3 };
    char *r = webforms_internal_join(parts, 2);
    free(s3);
    return r;
}

static inline char *webforms_ip_query_all(const char *query)
{
    char *s1 = webforms_internal_str_replace_all(query, "=", "$[eq];");
    char *s2 = webforms_internal_str_replace_all(s1, "|", "$[vb];");
    char *s3 = webforms_internal_str_replace_all(s2, "?", "$[qu];");
    free(s1); free(s2);
    const char *parts[2] = { "[", s3 };
    char *r = webforms_internal_join(parts, 2);
    free(s3);
    return r;
}

// ============================================================
// Fetch
// ============================================================

typedef struct Fetch {
    char _unused;
} Fetch;

static inline char *webforms_internal_fetch_join_rs(const char *prefix, const char *const *parts, size_t n)
{
    size_t total = strlen(prefix);
    for (size_t i = 0; i < n; i++) total += parts[i] ? strlen(parts[i]) : 0;
    if (n > 0) total += (n - 1);
    char *r = (char *)malloc(total + 1);
    size_t pos = 0;
    size_t plen = strlen(prefix);
    memcpy(r, prefix, plen);
    pos += plen;
    for (size_t i = 0; i < n; i++) {
        if (i > 0) r[pos++] = WEBFORMS_RS;
        if (parts[i]) {
            size_t l = strlen(parts[i]);
            memcpy(r + pos, parts[i], l);
            pos += l;
        }
    }
    r[pos] = '\0';
    return r;
}

static inline char *webforms_fetch_random(int max_value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", max_value);
    const char *parts[2] = { "@mr", buf };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_random_range(int min_value, int max_value)
{
    char mbuf[32], nbuf[32];
    snprintf(mbuf, sizeof(mbuf), "%d", max_value);
    snprintf(nbuf, sizeof(nbuf), "%d", min_value);
    const char *parts[4] = { "@mr", mbuf, WEBFORMS_RS_STR, nbuf };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_space_to_char(const char *text, const char *character)
{
    const char *parts[4] = { "@sc", character, WEBFORMS_RS_STR, text };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_encode_uri(const char *text)
{
    const char *parts[2] = { "@ue", text };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_decode_uri(const char *text)
{
    const char *parts[2] = { "@ud", text };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_method(const char *method_name, const char **args, size_t args_count)
{
    char *base = webforms_internal_concat2("@cm", method_name);
    if (args && args_count > 0) {
        size_t total = strlen(base) + 1;
        for (size_t i = 0; i < args_count; i++) total += args[i] ? strlen(args[i]) : 0;
        total += (args_count - 1);
        char *r = (char *)realloc(base, total + 1);
        base = r;
        size_t pos = strlen(base);
        base[pos++] = WEBFORMS_RS;
        for (size_t i = 0; i < args_count; i++) {
            if (i > 0) base[pos++] = WEBFORMS_US;
            if (args[i]) {
                size_t l = strlen(args[i]);
                memcpy(base + pos, args[i], l);
                pos += l;
            }
        }
        base[pos] = '\0';
    }
    return base;
}

static inline char *webforms_fetch_module_method(const char *method_name, const char **args, size_t args_count)
{
    char *base = webforms_internal_concat2("@cM", method_name);
    if (args && args_count > 0) {
        size_t total = strlen(base) + 1;
        for (size_t i = 0; i < args_count; i++) total += args[i] ? strlen(args[i]) : 0;
        total += (args_count - 1);
        base = (char *)realloc(base, total + 1);
        size_t pos = strlen(base);
        base[pos++] = WEBFORMS_RS;
        for (size_t i = 0; i < args_count; i++) {
            if (i > 0) base[pos++] = WEBFORMS_US;
            if (args[i]) {
                size_t l = strlen(args[i]);
                memcpy(base + pos, args[i], l);
                pos += l;
            }
        }
        base[pos] = '\0';
    }
    return base;
}

// MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
static inline char *webforms_fetch_wasm_method(const char *wasm_language, const char *wasm_url, const char *method_name, const char **args, size_t args_count, const char *key)
{
    (void)key;
    const char *base_parts[6] = { "@wA", wasm_language, WEBFORMS_RS_STR, wasm_url, WEBFORMS_RS_STR, method_name };
    char *base = webforms_internal_join(base_parts, 6);
    if (args && args_count > 0) {
        size_t total = strlen(base) + 1;
        for (size_t i = 0; i < args_count; i++) total += args[i] ? strlen(args[i]) : 0;
        total += (args_count - 1);
        base = (char *)realloc(base, total + 1);
        size_t pos = strlen(base);
        base[pos++] = WEBFORMS_RS;
        for (size_t i = 0; i < args_count; i++) {
            if (i > 0) base[pos++] = WEBFORMS_US;
            if (args[i]) {
                size_t l = strlen(args[i]);
                memcpy(base + pos, args[i], l);
                pos += l;
            }
        }
        base[pos] = '\0';
    }
    return base;
}

static inline char *webforms_fetch_script(const char *script_text)
{
    char *v = webforms_internal_str_replace_all(script_text, "\n", "$[ln];");
    const char *parts[2] = { "@_", v };
    char *r = webforms_internal_join(parts, 2);
    free(v);
    return r;
}

static inline char *webforms_fetch_load_url(const char *url, bool fetch_script)
{
    if (fetch_script) {
        const char *parts[4] = { "@lu", url, WEBFORMS_RS_STR, "1" };
        return webforms_internal_join(parts, 4);
    }
    const char *parts[2] = { "@lu", url };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_load_html(const char *url, const char *fetch_input_place, bool fetch_script)
{
    bool has_ip = (fetch_input_place && fetch_input_place[0] != '\0');
    const char *parts[6] = { "@lh", url, WEBFORMS_RS_STR, fetch_script ? "1" : "0", has_ip ? WEBFORMS_RS_STR : NULL, has_ip ? fetch_input_place : NULL };
    return webforms_internal_join(parts, 6);
}

static inline char *webforms_fetch_load_line(const char *url, int line)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", line);
    const char *parts[4] = { "@ll", url, WEBFORMS_RS_STR, buf };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_load_ini(const char *url, const char *name, bool is_ini_like)
{
    if (is_ini_like) {
        const char *parts[6] = { "@li", url, WEBFORMS_RS_STR, name, WEBFORMS_RS_STR, "1" };
        return webforms_internal_join(parts, 6);
    }
    const char *parts[4] = { "@li", url, WEBFORMS_RS_STR, name };
    return webforms_internal_join(parts, 4);
}

// Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
static inline char *webforms_fetch_load_json(const char *url, const char *name)
{
    const char *parts[4] = { "@lj", url, WEBFORMS_RS_STR, name };
    return webforms_internal_join(parts, 4);
}

// Name: Name Or XPath; XPath Index Starts At 1
static inline char *webforms_fetch_load_xml(const char *url, const char *name)
{
    const char *parts[4] = { "@lx", url, WEBFORMS_RS_STR, name };
    return webforms_internal_join(parts, 4);
}

// MethodName: It's Check Function Or Variable
static inline char *webforms_fetch_has_method(const char *method_name)
{
    const char *parts[2] = { "@hm", method_name };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_has_module_method(const char *method_name)
{
    const char *parts[2] = { "@hM", method_name };
    return webforms_internal_join(parts, 2);
}

// This Method Return True Or False If Key Pressed
// Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
static inline char *webforms_fetch_get_modifier_state(const char *modifier)
{
    const char *parts[2] = { "@ms", modifier };
    return webforms_internal_join(parts, 2);
}

// Math
static inline char *webforms_fetch_math(const char *method_name, const char **args, size_t args_count)
{
    char *base = webforms_internal_concat2("@M#", method_name);
    if (args && args_count > 0) {
        size_t total = strlen(base) + 1;
        for (size_t i = 0; i < args_count; i++) total += args[i] ? strlen(args[i]) : 0;
        total += (args_count - 1);
        base = (char *)realloc(base, total + 1);
        size_t pos = strlen(base);
        base[pos++] = WEBFORMS_RS;
        for (size_t i = 0; i < args_count; i++) {
            if (i > 0) base[pos++] = WEBFORMS_US;
            if (args[i]) {
                size_t l = strlen(args[i]);
                memcpy(base + pos, args[i], l);
                pos += l;
            }
        }
        base[pos] = '\0';
    }
    return base;
}

// Data
#define WEBFORMS_FETCH_DATE_YEAR "@dy"
// Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1
#define WEBFORMS_FETCH_DATE_MONTH "@dm"
#define WEBFORMS_FETCH_DATE_DAY "@dd"
#define WEBFORMS_FETCH_DATE_DATE "@dD"
#define WEBFORMS_FETCH_DATE_HOURS "@dh"
#define WEBFORMS_FETCH_DATE_MINUTES "@di"
#define WEBFORMS_FETCH_DATE_SECONDS "@ds"
#define WEBFORMS_FETCH_DATE_MILLISECONDS "@dl"

// String
#define WEBFORMS_FETCH_SPACE "@sp"
#define WEBFORMS_FETCH_AT_SIGN "@sa"

// Tag
static inline char *webforms_fetch_get_id(const char *input_place)
{
    const char *parts[2] = { "@$i", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_name(const char *input_place)
{
    const char *parts[2] = { "@$n", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_value(const char *input_place)
{
    const char *parts[2] = { "@$v", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_value_length(const char *input_place)
{
    const char *parts[2] = { "@$e", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_class(const char *input_place)
{
    const char *parts[2] = { "@$c", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_style(const char *input_place)
{
    const char *parts[2] = { "@$s", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_title(const char *input_place)
{
    const char *parts[2] = { "@$l", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_label(const char *input_place)
{
    const char *parts[2] = { "@$A", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_text(const char *input_place)
{
    const char *parts[2] = { "@$t", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_outer_text(const char *input_place)
{
    const char *parts[2] = { "@$o", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_text_length(const char *input_place)
{
    const char *parts[2] = { "@$g", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_attribute(const char *input_place, const char *attribute)
{
    const char *parts[4] = { "@$a", input_place, WEBFORMS_RS_STR, attribute };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_get_width(const char *input_place)
{
    const char *parts[2] = { "@$w", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_height(const char *input_place)
{
    const char *parts[2] = { "@$h", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_is_read_only(const char *input_place)
{
    const char *parts[2] = { "@$r", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_selected_index(const char *input_place)
{
    const char *parts[2] = { "@$x", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_index(const char *input_place)
{
    const char *parts[2] = { "@$I", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_text_align(const char *input_place)
{
    const char *parts[2] = { "@$T", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_node_length(const char *input_place)
{
    const char *parts[2] = { "@$L", input_place };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_get_is_visible(const char *input_place)
{
    const char *parts[2] = { "@$V", input_place };
    return webforms_internal_join(parts, 2);
}

// Save
static inline char *webforms_fetch_has_hash(const char *hash)
{
    const char *parts[2] = { "@HH", hash };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_cookie(const char *key)
{
    const char *parts[2] = { "@co", key };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_save(const char *key)
{
    const char *parts[2] = { "@cs", key };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_save_replace(const char *key, const char *replace_value)
{
    const char *parts[4] = { "@cs", key, WEBFORMS_RS_STR, replace_value };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_save_then_remove(const char *key)
{
    const char *parts[2] = { "@cl", key };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_save_length(const char *key)
{
    const char *parts[2] = { "@cg", key };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_cache(const char *key)
{
    const char *parts[2] = { "@cd", key };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_cache_replace(const char *key, const char *replace_value)
{
    const char *parts[4] = { "@cd", key, WEBFORMS_RS_STR, replace_value };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_cache_then_remove(const char *key)
{
    const char *parts[2] = { "@ct", key };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_cache_length(const char *key)
{
    const char *parts[2] = { "@cG", key };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_save_line(const char *key, int line)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", line);
    const char *parts[5] = { "@lL", key, "[", buf, "" };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_save_line_consume(const char *key)
{
    const char *parts[2] = { "@lL", key };
    return webforms_internal_join(parts, 2);
}

// INIKey: Only Direct Key is Supported
static inline char *webforms_fetch_save_ini(const char *key, const char *ini_key)
{
    const char *parts[4] = { "@lI", key, "[", ini_key };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_cache_line(const char *key, int line)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", line);
    const char *parts[5] = { "@dL", key, "[", buf, "" };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_cache_line_consume(const char *key)
{
    const char *parts[2] = { "@dL", key };
    return webforms_internal_join(parts, 2);
}

// INIKey: Only Direct Key is Supported
static inline char *webforms_fetch_cache_ini(const char *key, const char *ini_key)
{
    const char *parts[4] = { "@dI", key, "[", ini_key };
    return webforms_internal_join(parts, 4);
}

// Format Storage
static inline char *webforms_fetch_format_store(const char *key)
{
    const char *parts[2] = { "@fr", key };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_format_store_by_xml_query(const char *key, const char *xpath)
{
    const char *parts[4] = { "@fx", key, WEBFORMS_RS_STR, xpath };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_format_store_by_json_query(const char *key, const char *query)
{
    const char *parts[4] = { "@fj", key, WEBFORMS_RS_STR, query };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_format_store_by_ini(const char *key, const char *name)
{
    const char *parts[4] = { "@fi", key, WEBFORMS_RS_STR, name };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_format_store_by_text(const char *key, int line)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", line);
    const char *parts[4] = { "@ft", key, WEBFORMS_RS_STR, buf };
    return webforms_internal_join(parts, 4);
}

static inline char *webforms_fetch_format_store_by_variable(const char *key)
{
    const char *parts[2] = { "@fv", key };
    return webforms_internal_join(parts, 2);
}

// State
static inline char *webforms_fetch_has_state(const char *path)
{
    const char *parts[2] = { "@hs", path };
    return webforms_internal_join(parts, 2);
}

// SSE
static inline char *webforms_fetch_sse_is_connected(const char *path)
{
    const char *parts[2] = { "@Sc", path };
    return webforms_internal_join(parts, 2);
}

// WebSockets
static inline char *webforms_fetch_web_sockets_is_connected(const char *path)
{
    const char *parts[2] = { "@Wc", path };
    return webforms_internal_join(parts, 2);
}

// Document
#define WEBFORMS_FETCH_TAB_IS_ACTIVE "@da"

// Window
#define WEBFORMS_FETCH_HREF "@wf"
#define WEBFORMS_FETCH_PATH_NAME "@wP"
#define WEBFORMS_FETCH_HASH "@wh"
#define WEBFORMS_FETCH_HOST "@wH"
#define WEBFORMS_FETCH_HOST_NAME "@wn"
#define WEBFORMS_FETCH_PORT "@wT"
#define WEBFORMS_FETCH_ORIGIN "@wo"
#define WEBFORMS_FETCH_GET_SELECTION "@ws"
#define WEBFORMS_FETCH_SCROLL_X "@wx"
#define WEBFORMS_FETCH_SCROLL_Y "@wy"

static inline char *webforms_fetch_query(const char *name)
{
    const char *n = (name && name[0] != '\0') ? name : "*";
    const char *parts[2] = { "@wq", n };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_fetch_segment(int index)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", index);
    const char *parts[2] = { "@wS", buf };
    return webforms_internal_join(parts, 2);
}

// It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
static inline char *webforms_fetch_hash_segment(int index)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%d", index);
    const char *parts[2] = { "@wt", buf };
    return webforms_internal_join(parts, 2);
}

// Navigator
#define WEBFORMS_FETCH_CLIPBOARD_TEXT "@nC"
#define WEBFORMS_FETCH_GEO_LATITUDE "@nW"
#define WEBFORMS_FETCH_GEO_LONGITUDE "@nO"
#define WEBFORMS_FETCH_LANGUAGE "@nL"
#define WEBFORMS_FETCH_IS_ON_LINE "@no"
#define WEBFORMS_FETCH_USER_AGENT "@na"

// Screen
#define WEBFORMS_FETCH_SCREEN_WIDTH "@sw"
#define WEBFORMS_FETCH_SCREEN_HEIGHT "@sh"
#define WEBFORMS_FETCH_SCREEN_ORIENTATION_TYPE "@so"
#define WEBFORMS_FETCH_SCREEN_ORIENTATION_ANGLE "@sr"

// Performance
#define WEBFORMS_FETCH_TIME_ORIGIN "@pt"
#define WEBFORMS_FETCH_PERFORMANCE_NOW "@pn"

// Event
#define WEBFORMS_FETCH_EVENT "@EV"
#define WEBFORMS_FETCH_EVENT_SERIALIZE "@Es"
#define WEBFORMS_FETCH_EVENT_KEY "@ek"
#define WEBFORMS_FETCH_EVENT_WHICH "@ew"
#define WEBFORMS_FETCH_EVENT_CLIENT_X "@ex"
#define WEBFORMS_FETCH_EVENT_CLIENT_Y "@ey"
#define WEBFORMS_FETCH_EVENT_PAGE_X "@eX"
#define WEBFORMS_FETCH_EVENT_PAGE_Y "@eY"
#define WEBFORMS_FETCH_EVENT_OFFSET_X "@Ex"
#define WEBFORMS_FETCH_EVENT_OFFSET_Y "@Ey"
#define WEBFORMS_FETCH_EVENT_DELTA_Y "@ed"

// ============================================================
// WasmLanguage
// The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
// ============================================================

#define WEBFORMS_WASM_LANGUAGE_C "c"
#define WEBFORMS_WASM_LANGUAGE_CPP "c"
#define WEBFORMS_WASM_LANGUAGE_RUST "rust"
#define WEBFORMS_WASM_LANGUAGE_CSHARP "csharp"
// .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
#define WEBFORMS_WASM_LANGUAGE_CSHARP_MEDIATOR "csharp-m"
#define WEBFORMS_WASM_LANGUAGE_GO "go"
#define WEBFORMS_WASM_LANGUAGE_JAVA "java"
#define WEBFORMS_WASM_LANGUAGE_ASSEMBLY_SCRIPT "as"

// ============================================================
// HtmlEvent
// ============================================================

#define WEBFORMS_HTML_EVENT_ON_ABORT "onabort"
#define WEBFORMS_HTML_EVENT_ON_AFTER_PRINT "onafterprint"
#define WEBFORMS_HTML_EVENT_ON_BEFORE_PRINT "onbeforeprint"
#define WEBFORMS_HTML_EVENT_ON_BEFORE_UNLOAD "onbeforeunload"
#define WEBFORMS_HTML_EVENT_ON_BLUR "onblur"
#define WEBFORMS_HTML_EVENT_ON_CAN_PLAY "oncanplay"
#define WEBFORMS_HTML_EVENT_ON_CAN_PLAY_THROUGH "oncanplaythrough"
#define WEBFORMS_HTML_EVENT_ON_CHANGE "onchange"
#define WEBFORMS_HTML_EVENT_ON_CLICK "onclick"
#define WEBFORMS_HTML_EVENT_ON_COPY "oncopy"
#define WEBFORMS_HTML_EVENT_ON_CUT "oncut"
#define WEBFORMS_HTML_EVENT_ON_DOUBLE_CLICK "ondblclick"
#define WEBFORMS_HTML_EVENT_ON_DRAG "ondrag"
#define WEBFORMS_HTML_EVENT_ON_DRAG_END "ondragend"
#define WEBFORMS_HTML_EVENT_ON_DRAG_ENTER "ondragenter"
#define WEBFORMS_HTML_EVENT_ON_DRAG_LEAVE "ondragleave"
#define WEBFORMS_HTML_EVENT_ON_DRAG_OVER "ondragover"
#define WEBFORMS_HTML_EVENT_ON_DRAG_START "ondragstart"
#define WEBFORMS_HTML_EVENT_ON_DROP "ondrop"
#define WEBFORMS_HTML_EVENT_ON_DURATION_CHANGE "ondurationchange"
#define WEBFORMS_HTML_EVENT_ON_ENDED "onended"
#define WEBFORMS_HTML_EVENT_ON_ERROR "onerror"
#define WEBFORMS_HTML_EVENT_ON_FOCUS "onfocus"
#define WEBFORMS_HTML_EVENT_ON_FOCUSIN "onfocusin"
#define WEBFORMS_HTML_EVENT_ON_FOCUS_OUT "onfocusout"
#define WEBFORMS_HTML_EVENT_ON_HASH_CHANGE "onhashchange"
#define WEBFORMS_HTML_EVENT_ON_INPUT "oninput"
#define WEBFORMS_HTML_EVENT_ON_INVALID "oninvalid"
#define WEBFORMS_HTML_EVENT_ON_KEY_DOWN "onkeydown"
#define WEBFORMS_HTML_EVENT_ON_KEY_PRESS "onkeypress"
#define WEBFORMS_HTML_EVENT_ON_KEY_UP "onkeyup"
#define WEBFORMS_HTML_EVENT_ON_LOAD "onload"
#define WEBFORMS_HTML_EVENT_ON_LOADED_DATA "onloadeddata"
#define WEBFORMS_HTML_EVENT_ON_LOADED_META_DATA "onloadedmetadata"
#define WEBFORMS_HTML_EVENT_ON_LOAD_START "onloadstart"
#define WEBFORMS_HTML_EVENT_ON_MOUSE_DOWN "onmousedown"
#define WEBFORMS_HTML_EVENT_ON_MOUSE_ENTER "onmouseenter"
#define WEBFORMS_HTML_EVENT_ON_MOUSE_LEAVE "onmouseleave"
#define WEBFORMS_HTML_EVENT_ON_MOUSE_MOVE "onmousemove"
#define WEBFORMS_HTML_EVENT_ON_MOUSE_OVER "onmouseover"
#define WEBFORMS_HTML_EVENT_ON_MOUSE_OUT "onmouseout"
#define WEBFORMS_HTML_EVENT_ON_MOUSE_UP "onmouseup"
#define WEBFORMS_HTML_EVENT_ON_OFFLINE "onoffline"
#define WEBFORMS_HTML_EVENT_ON_ONLINE "ononline"
#define WEBFORMS_HTML_EVENT_ON_PAGE_HIDE "onpagehide"
#define WEBFORMS_HTML_EVENT_ON_PAGE_SHOW "onpageshow"
#define WEBFORMS_HTML_EVENT_ON_PASTE "onpaste"
#define WEBFORMS_HTML_EVENT_ON_PAUSE "onpause"
#define WEBFORMS_HTML_EVENT_ON_PLAY "onplay"
#define WEBFORMS_HTML_EVENT_ON_PLAYING "onplaying"
#define WEBFORMS_HTML_EVENT_ON_PROGRESS "onprogress"
#define WEBFORMS_HTML_EVENT_ON_RATE_CHANGE "onratechange"
#define WEBFORMS_HTML_EVENT_ON_RESIZE "onresize"
#define WEBFORMS_HTML_EVENT_ON_RESET "onreset"
#define WEBFORMS_HTML_EVENT_ON_SCROLL "onscroll"
#define WEBFORMS_HTML_EVENT_ON_SEARCH "onsearch"
#define WEBFORMS_HTML_EVENT_ON_SEEKED "onseeked"
#define WEBFORMS_HTML_EVENT_ON_SEEKING "onseeking"
#define WEBFORMS_HTML_EVENT_ON_SELECT "onselect"
#define WEBFORMS_HTML_EVENT_ON_STALLED "onstalled"
#define WEBFORMS_HTML_EVENT_ON_SUBMIT "onsubmit"
#define WEBFORMS_HTML_EVENT_ON_SUSPEND "onsuspend"
#define WEBFORMS_HTML_EVENT_ON_TIME_UPDATE "ontimeupdate"
#define WEBFORMS_HTML_EVENT_ON_TOGGLE "ontoggle"
#define WEBFORMS_HTML_EVENT_ON_TOUCH_CANCEL "ontouchcancel"
#define WEBFORMS_HTML_EVENT_ON_TOUCHEND "ontouchend"
#define WEBFORMS_HTML_EVENT_ON_TOUCH_MOVE "ontouchmove"
#define WEBFORMS_HTML_EVENT_ON_TOUCH_START "ontouchstart"
#define WEBFORMS_HTML_EVENT_ON_UNLOAD "onunload"
#define WEBFORMS_HTML_EVENT_ON_VOLUME_CHANGE "onvolumechange"
#define WEBFORMS_HTML_EVENT_ON_WAITING "onwaiting"
#define WEBFORMS_HTML_EVENT_ON_WHEEL "onwheel"

// ============================================================
// HtmlEventListener
// ============================================================

#define WEBFORMS_HTML_EVENT_LISTENER_ABORT "abort"
#define WEBFORMS_HTML_EVENT_LISTENER_AFTER_PRINT "afterprint"
#define WEBFORMS_HTML_EVENT_LISTENER_BEFORE_PRINT "beforeprint"
#define WEBFORMS_HTML_EVENT_LISTENER_BEFORE_UNLOAD "beforeunload"
#define WEBFORMS_HTML_EVENT_LISTENER_BLUR "blur"
#define WEBFORMS_HTML_EVENT_LISTENER_CAN_PLAY "canplay"
#define WEBFORMS_HTML_EVENT_LISTENER_CAN_PLAY_THROUGH "canplaythrough"
#define WEBFORMS_HTML_EVENT_LISTENER_CHANGE "change"
#define WEBFORMS_HTML_EVENT_LISTENER_CLICK "click"
#define WEBFORMS_HTML_EVENT_LISTENER_COPY "copy"
#define WEBFORMS_HTML_EVENT_LISTENER_CUT "cut"
#define WEBFORMS_HTML_EVENT_LISTENER_DOUBLE_CLICK "dblclick"
#define WEBFORMS_HTML_EVENT_LISTENER_DRAG "drag"
#define WEBFORMS_HTML_EVENT_LISTENER_DRAG_END "dragend"
#define WEBFORMS_HTML_EVENT_LISTENER_DRAG_ENTER "dragenter"
#define WEBFORMS_HTML_EVENT_LISTENER_DRAG_LEAVE "dragleave"
#define WEBFORMS_HTML_EVENT_LISTENER_DRAG_OVER "dragover"
#define WEBFORMS_HTML_EVENT_LISTENER_DRAG_START "dragstart"
#define WEBFORMS_HTML_EVENT_LISTENER_DROP "drop"
#define WEBFORMS_HTML_EVENT_LISTENER_DURATION_CHANGE "durationchange"
#define WEBFORMS_HTML_EVENT_LISTENER_ENDED "ended"
#define WEBFORMS_HTML_EVENT_LISTENER_ERROR "error"
#define WEBFORMS_HTML_EVENT_LISTENER_FOCUS "focus"
#define WEBFORMS_HTML_EVENT_LISTENER_FOCUSIN "focusin"
#define WEBFORMS_HTML_EVENT_LISTENER_FOCUS_OUT "focusout"
#define WEBFORMS_HTML_EVENT_LISTENER_HASH_CHANGE "hashchange"
#define WEBFORMS_HTML_EVENT_LISTENER_INPUT "input"
#define WEBFORMS_HTML_EVENT_LISTENER_INVALID "invalid"
#define WEBFORMS_HTML_EVENT_LISTENER_KEY_DOWN "keydown"
#define WEBFORMS_HTML_EVENT_LISTENER_KEY_PRESS "keypress"
#define WEBFORMS_HTML_EVENT_LISTENER_KEY_UP "keyup"
#define WEBFORMS_HTML_EVENT_LISTENER_LOAD "load"
#define WEBFORMS_HTML_EVENT_LISTENER_LOADED_DATA "loadeddata"
#define WEBFORMS_HTML_EVENT_LISTENER_LOADED_META_DATA "loadedmetadata"
#define WEBFORMS_HTML_EVENT_LISTENER_LOAD_START "loadstart"
#define WEBFORMS_HTML_EVENT_LISTENER_MOUSE_DOWN "mousedown"
#define WEBFORMS_HTML_EVENT_LISTENER_MOUSE_ENTER "mouseenter"
#define WEBFORMS_HTML_EVENT_LISTENER_MOUSE_LEAVE "mouseleave"
#define WEBFORMS_HTML_EVENT_LISTENER_MOUSE_MOVE "mousemove"
#define WEBFORMS_HTML_EVENT_LISTENER_MOUSE_OVER "mouseover"
#define WEBFORMS_HTML_EVENT_LISTENER_MOUSE_OUT "mouseout"
#define WEBFORMS_HTML_EVENT_LISTENER_MOUSE_UP "mouseup"
#define WEBFORMS_HTML_EVENT_LISTENER_OFFLINE "offline"
#define WEBFORMS_HTML_EVENT_LISTENER_ONLINE "online"
#define WEBFORMS_HTML_EVENT_LISTENER_PAGE_HIDE "pagehide"
#define WEBFORMS_HTML_EVENT_LISTENER_PAGE_SHOW "pageshow"
#define WEBFORMS_HTML_EVENT_LISTENER_PASTE "paste"
#define WEBFORMS_HTML_EVENT_LISTENER_PAUSE "pause"
#define WEBFORMS_HTML_EVENT_LISTENER_PLAY "play"
#define WEBFORMS_HTML_EVENT_LISTENER_PLAYING "playing"
#define WEBFORMS_HTML_EVENT_LISTENER_PROGRESS "progress"
#define WEBFORMS_HTML_EVENT_LISTENER_RATE_CHANGE "ratechange"
#define WEBFORMS_HTML_EVENT_LISTENER_RESIZE "resize"
#define WEBFORMS_HTML_EVENT_LISTENER_RESET "reset"
#define WEBFORMS_HTML_EVENT_LISTENER_SCROLL "scroll"
#define WEBFORMS_HTML_EVENT_LISTENER_SEARCH "search"
#define WEBFORMS_HTML_EVENT_LISTENER_SEEKED "seeked"
#define WEBFORMS_HTML_EVENT_LISTENER_SEEKING "seeking"
#define WEBFORMS_HTML_EVENT_LISTENER_SELECT "select"
#define WEBFORMS_HTML_EVENT_LISTENER_STALLED "stalled"
#define WEBFORMS_HTML_EVENT_LISTENER_SUBMIT "submit"
#define WEBFORMS_HTML_EVENT_LISTENER_SUSPEND "suspend"
#define WEBFORMS_HTML_EVENT_LISTENER_TIME_UPDATE "timeupdate"
#define WEBFORMS_HTML_EVENT_LISTENER_TOGGLE "toggle"
#define WEBFORMS_HTML_EVENT_LISTENER_TOUCH_CANCEL "touchcancel"
#define WEBFORMS_HTML_EVENT_LISTENER_TOUCHEND "touchend"
#define WEBFORMS_HTML_EVENT_LISTENER_TOUCH_MOVE "touchmove"
#define WEBFORMS_HTML_EVENT_LISTENER_TOUCH_START "touchstart"
#define WEBFORMS_HTML_EVENT_LISTENER_UNLOAD "unload"
#define WEBFORMS_HTML_EVENT_LISTENER_VOLUME_CHANGE "volumechange"
#define WEBFORMS_HTML_EVENT_LISTENER_WAITING "waiting"
#define WEBFORMS_HTML_EVENT_LISTENER_WHEEL "wheel"

#define WEBFORMS_HTML_EVENT_LISTENER_ANIMATION_END "animationend"
#define WEBFORMS_HTML_EVENT_LISTENER_ANIMATION_ITERATION "animationiteration"
#define WEBFORMS_HTML_EVENT_LISTENER_ANIMATION_START "animationstart"
#define WEBFORMS_HTML_EVENT_LISTENER_CONTEXT_MENU "contextmenu"
#define WEBFORMS_HTML_EVENT_LISTENER_FULL_SCREEN_CHANGE "fullscreenchange"
#define WEBFORMS_HTML_EVENT_LISTENER_FULL_SCREEN_ERROR "fullscreenerror"
#define WEBFORMS_HTML_EVENT_LISTENER_POP_STATE "popstate"
#define WEBFORMS_HTML_EVENT_LISTENER_TRANSITION_END "transitionend"
#define WEBFORMS_HTML_EVENT_LISTENER_STORAGE "storage"

// Custom
#define WEBFORMS_HTML_EVENT_LISTENER_SCROLL_BOTTOM "scrollbottom" // Need Call EnableScrollBottomEvent Method Before
#define WEBFORMS_HTML_EVENT_LISTENER_ELEMENT_REACHED "elementreached" // Need Call EnableReachedElementEvent Method Before

// ============================================================
// ExtensionWebFormsMethods
// ============================================================

static inline char *webforms_ext_child(const char *text, const char *value)
{
    if (!text || text[0] == '\0')
        return webforms_internal_strdup(value);
    const char *parts[3] = { text, "|", value };
    return webforms_internal_join(parts, 3);
}

static inline char *webforms_ext_parent(const char *text)
{
    if (!text || text[0] == '\0')
        return webforms_internal_strdup(text ? text : "");
    size_t len = strlen(text);
    if (len >= 2 && (strcmp(text + len - 2, "|/") == 0 || strcmp(text + len - 2, "//") == 0)) {
        const char *parts[2] = { text, "/" };
        return webforms_internal_join(parts, 2);
    }
    const char *parts[2] = { text, "|/" };
    return webforms_internal_join(parts, 2);
}

static inline char *webforms_ext_criteria(const char *text, const char *value)
{
    if (!text || text[0] == '\0')
        return webforms_internal_strdup(value);
    char *v1 = webforms_internal_str_replace_all(value, "|", "$[vb];");
    char *v2 = webforms_internal_str_replace_all(v1, "?", "$[qu];");
    free(v1);
    const char *parts[3] = { text, "?", v2 };
    char *r = webforms_internal_join(parts, 3);
    free(v2);
    return r;
}

static inline char *webforms_ext_append_fetch_replace(const char *text, const char *search_value, const char *value)
{
    size_t len = strlen(text);
    const char *tail = text;
    if (len > 0) tail = text + 1;
    const char *parts[7] = { "@;", search_value, WEBFORMS_FS_STR, value, WEBFORMS_FS_STR, tail, "" };
    return webforms_internal_join(parts, 6);
}

static inline char *webforms_ext_line_break(const char *text, bool encode_line)
{
    if (!text) return webforms_internal_strdup("");
    const char *encode = encode_line ? "$[sln];" : "";
    char *s1 = webforms_internal_str_replace_all(text, "\r\n", encode);
    char *s2 = webforms_internal_str_replace_all(s1, "\n", encode);
    char *s3 = webforms_internal_str_replace_all(s2, "\r", encode);
    free(s1); free(s2);
    return s3;
}

// Converts Numbers to Strings
static inline char *webforms_ext_to_js_string(const char *text)
{
    const char *parts[3] = { "\"", text, "\"" };
    return webforms_internal_join(parts, 3);
}

// Get JS Object Momentary
static inline char *webforms_ext_to_js_object(const char *text)
{
    const char *parts[2] = { "$", text };
    return webforms_internal_join(parts, 2);
}

// Get JS Object Returned Value Once
static inline char *webforms_ext_to_js_return_object(const char *text)
{
    const char *parts[2] = { "$@", text };
    return webforms_internal_join(parts, 2);
}

// ============================================================
// _Generic dispatch macros for type overloading
// ============================================================

#define webforms_set_width(self, ip, w) _Generic((w), \
    int: webforms_set_width_int, \
    default: webforms_set_width_str \
)(self, ip, w)

#define webforms_set_height(self, ip, h) _Generic((h), \
    int: webforms_set_height_int, \
    default: webforms_set_height_str \
)(self, ip, h)

#define webforms_set_font_size(self, ip, s) _Generic((s), \
    int: webforms_set_font_size_int, \
    default: webforms_set_font_size_str \
)(self, ip, s)

#define webforms_set_min_length(self, ip, l) _Generic((l), \
    int: webforms_set_min_length_int, \
    default: webforms_set_min_length_str \
)(self, ip, l)

#define webforms_set_max_length(self, ip, l) _Generic((l), \
    int: webforms_set_max_length_int, \
    default: webforms_set_max_length_str \
)(self, ip, l)

#define webforms_set_selected_index(self, ip, i) _Generic((i), \
    int: webforms_set_selected_index_int, \
    default: webforms_set_selected_index_str \
)(self, ip, i)

#define webforms_set_checked_index(self, ip, i, c) _Generic((i), \
    int: webforms_set_checked_index_int, \
    default: webforms_set_checked_index_str \
)(self, ip, i, c)

#define webforms_scroll_to(self, x, y) _Generic((x), \
    int: webforms_scroll_to_int, \
    default: webforms_scroll_to_str \
)(self, x, y)

#define webforms_history_go(self, s) _Generic((s), \
    int: webforms_history_go_int, \
    default: webforms_history_go_str \
)(self, s)

#define webforms_increase_min_length(self, ip, v) _Generic((v), \
    int: webforms_increase_min_length_int, \
    default: webforms_increase_min_length_str \
)(self, ip, v)

#define webforms_increase_max_length(self, ip, v) _Generic((v), \
    int: webforms_increase_max_length_int, \
    default: webforms_increase_max_length_str \
)(self, ip, v)

#define webforms_increase_font_size(self, ip, v) _Generic((v), \
    int: webforms_increase_font_size_int, \
    default: webforms_increase_font_size_str \
)(self, ip, v)

#define webforms_increase_width(self, ip, v) _Generic((v), \
    int: webforms_increase_width_int, \
    default: webforms_increase_width_str \
)(self, ip, v)

#define webforms_increase_height(self, ip, v) _Generic((v), \
    int: webforms_increase_height_int, \
    default: webforms_increase_height_str \
)(self, ip, v)

#define webforms_increase_value(self, ip, v) _Generic((v), \
    int: webforms_increase_value_int, \
    default: webforms_increase_value_str \
)(self, ip, v)

#define webforms_decrease_min_length(self, ip, v) _Generic((v), \
    int: webforms_decrease_min_length_int, \
    default: webforms_decrease_min_length_str \
)(self, ip, v)

#define webforms_decrease_max_length(self, ip, v) _Generic((v), \
    int: webforms_decrease_max_length_int, \
    default: webforms_decrease_max_length_str \
)(self, ip, v)

#define webforms_decrease_font_size(self, ip, v) _Generic((v), \
    int: webforms_decrease_font_size_int, \
    default: webforms_decrease_font_size_str \
)(self, ip, v)

#define webforms_decrease_width(self, ip, v) _Generic((v), \
    int: webforms_decrease_width_int, \
    default: webforms_decrease_width_str \
)(self, ip, v)

#define webforms_decrease_height(self, ip, v) _Generic((v), \
    int: webforms_decrease_height_int, \
    default: webforms_decrease_height_str \
)(self, ip, v)

#define webforms_decrease_value(self, ip, v) _Generic((v), \
    int: webforms_decrease_value_int, \
    default: webforms_decrease_value_str \
)(self, ip, v)

#define webforms_set_cookie(self, k, v, s, p) _Generic((s), \
    int: webforms_set_cookie_int, \
    default: webforms_set_cookie_str \
)(self, k, v, s, p)

#define webforms_service_worker_dynamic_cache(self, p, s) _Generic((s), \
    int: webforms_service_worker_dynamic_cache_int, \
    default: webforms_service_worker_dynamic_cache_str \
)(self, p, s)

#define webforms_service_worker_dynamic_cache_ttl_update(self, p, s) _Generic((s), \
    int: webforms_service_worker_dynamic_cache_ttl_update_int, \
    default: webforms_service_worker_dynamic_cache_ttl_update_str \
)(self, p, s)

#define webforms_set_cache(self, s) _Generic((s), \
    int: webforms_set_cache_int, \
    default: webforms_set_cache_str \
)(self, s)

#define webforms_call_sse_back(self, p, o, u, r, t) _Generic((t), \
    int: webforms_call_sse_back_int, \
    default: webforms_call_sse_back_str \
)(self, p, o, u, r, t)

#define webforms_add_text_line(self, k, l, t) _Generic((l), \
    int: webforms_add_text_line_int, \
    default: webforms_add_text_line_str \
)(self, k, l, t)

#define webforms_update_tex_line(self, k, l, t) _Generic((l), \
    int: webforms_update_tex_line_int, \
    default: webforms_update_tex_line_str \
)(self, k, l, t)

#define webforms_delete_text_line(self, k, l) _Generic((l), \
    int: webforms_delete_text_line_int, \
    default: webforms_delete_text_line_str \
)(self, k, l)

#define webforms_increase_variable(self, k, v) _Generic((v), \
    int: webforms_increase_variable_int, \
    default: webforms_increase_variable_str \
)(self, k, v)

#define webforms_delay(self, m) _Generic((m), \
    int: webforms_delay_int, \
    default: webforms_delay_str \
)(self, m)

#define webforms_set_comment_event(self, ip, e, i, o) _Generic((i), \
    int: webforms_set_comment_event_int, \
    default: webforms_set_comment_event \
)(self, ip, e, i, o)

#define webforms_set_comment_event_listener(self, ip, e, i, o) _Generic((i), \
    int: webforms_set_comment_event_listener_int, \
    default: webforms_set_comment_event_listener \
)(self, ip, e, i, o)

#define webforms_create_custom_dom_event(self, ip, e, w, k, c, v, r, im, d) _Generic((d), \
    int: webforms_create_custom_dom_event_int, \
    default: webforms_create_custom_dom_event \
)(self, ip, e, w, k, c, v, r, im, d)

#define webforms_call_comment_back(self, i, ip, u) _Generic((i), \
    int: webforms_call_comment_back_int, \
    default: webforms_call_comment_back \
)(self, i, ip, u)

#define webforms_message(self, t, ...) \
    WEBFORMS_MESSAGE_DISPATCH(self, t, __VA_ARGS__)

#define WEBFORMS_MESSAGE_ARG3(_1, _2, _3, NAME, ...) NAME

#define WEBFORMS_MESSAGE_DISPATCH(self, t, ...) \
    WEBFORMS_MESSAGE_ARG3(__VA_ARGS__, webforms_message_type_duration_int, webforms_message_duration_int, webforms_message)(self, t, __VA_ARGS__)

#endif // WEBFORMS_H
