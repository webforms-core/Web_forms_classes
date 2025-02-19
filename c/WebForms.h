// Compatible with WebFormsJS version 1.6

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_ENTRIES 1000
#define MAX_KEY_LENGTH 100
#define MAX_VALUE_LENGTH 100

typedef struct {
    char name[MAX_KEY_LENGTH];
    char value[MAX_VALUE_LENGTH];
} NameValue;

typedef struct {
    NameValue entries[MAX_ENTRIES];
    int count;
} NameValueCollection;

void NameValueCollection_Add(NameValueCollection* collection, const char* name, const char* value) {
    if (collection->count < MAX_ENTRIES) {
        strncpy(collection->entries[collection->count].name, name, MAX_KEY_LENGTH);
        strncpy(collection->entries[collection->count].value, value, MAX_VALUE_LENGTH);
        collection->count++;
    }
}

const char* NameValueCollection_GetValue(const NameValueCollection* collection, const char* name) {
    for (int i = 0; i < collection->count; i++) {
        if (strcmp(collection->entries[i].name, name) == 0) {
            return collection->entries[i].value;
        }
    }
    return "";
}

void NameValueCollection_ChangeValue(NameValueCollection* collection, const char* name, const char* value) {
    for (int i = 0; i < collection->count; i++) {
        if (strcmp(collection->entries[i].name, name) == 0) {
            strncpy(collection->entries[i].value, value, MAX_VALUE_LENGTH);
            break;
        }
    }
}

void NameValueCollection_Delete(NameValueCollection* collection, const char* name) {
    for (int i = 0; i < collection->count; i++) {
        if (strcmp(collection->entries[i].name, name) == 0) {
            for (int j = i; j < collection->count - 1; j++) {
                collection->entries[j] = collection->entries[j + 1];
            }
            collection->count--;
            break;
        }
    }
}

typedef struct {
    NameValueCollection WebFormsData;
} WebForms;

// For Extension
void WebForms_AddLine(WebForms* webForms, const char* name, const char* value) {
    NameValueCollection_Add(&webForms->WebFormsData, name, value);
}

// Add
void WebForms_AddId(WebForms* webForms, const char* inputPlace, const char* id) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ai%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, id);
}

void WebForms_AddName(WebForms* webForms, const char* inputPlace, const char* name) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "an%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, name);
}

void WebForms_AddValue(WebForms* webForms, const char* inputPlace, const char* value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "av%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, value);
}

void WebForms_AddClass(WebForms* webForms, const char* inputPlace, const char* className) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ac%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, className);
}

void WebForms_AddStyle(WebForms* webForms, const char* inputPlace, const char* style) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "as%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, style);
}

void WebForms_AddStyleWithNameValue(WebForms* webForms, const char* inputPlace, const char* name, const char* value) {
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s:%s", name, value);
    WebForms_AddStyle(webForms, inputPlace, combined);
}

void WebForms_AddOptionTag(WebForms* webForms, const char* inputPlace, const char* text, const char* value, bool selected) {
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s%s", value, text, selected ? "|1" : "");
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ao%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_AddCheckBoxTag(WebForms* webForms, const char* inputPlace, const char* text, const char* value, bool checked) {
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s%s", value, text, checked ? "|1" : "");
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ak%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_AddTitle(WebForms* webForms, const char* inputPlace, const char* title) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "al%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, title);
}

void WebForms_AddText(WebForms* webForms, const char* inputPlace, const char* text) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "at%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, text);
}

void WebForms_AddTextToUp(WebForms* webForms, const char* inputPlace, const char* text) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "pt%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, text);
}

void WebForms_AddAttribute(WebForms* webForms, const char* inputPlace, const char* attribute, const char* value) {
    char combined[MAX_VALUE_LENGTH];
    if (value != NULL && value[0] != '\0') {
        snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", attribute, value);
    } else {
        snprintf(combined, MAX_VALUE_LENGTH, "%s", attribute);
    }
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "aa%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_AddTag(WebForms* webForms, const char* inputPlace, const char* tagName, const char* id) {
    char combined[MAX_VALUE_LENGTH];
    if (id != NULL && id[0] != '\0') {
        snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", tagName, id);
    } else {
        snprintf(combined, MAX_VALUE_LENGTH, "%s", tagName);
    }
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "nt%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_AddTagToUp(WebForms* webForms, const char* inputPlace, const char* tagName, const char* id) {
    char combined[MAX_VALUE_LENGTH];
    if (id != NULL && id[0] != '\0') {
        snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", tagName, id);
    } else {
        snprintf(combined, MAX_VALUE_LENGTH, "%s", tagName);
    }
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ut%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_AddTagBefore(WebForms* webForms, const char* inputPlace, const char* tagName, const char* id) {
    char combined[MAX_VALUE_LENGTH];
    if (id != NULL && id[0] != '\0') {
        snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", tagName, id);
    } else {
        snprintf(combined, MAX_VALUE_LENGTH, "%s", tagName);
    }
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "bt%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_AddTagAfter(WebForms* webForms, const char* inputPlace, const char* tagName, const char* id) {
    char combined[MAX_VALUE_LENGTH];
    if (id != NULL && id[0] != '\0') {
        snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", tagName, id);
    } else {
        snprintf(combined, MAX_VALUE_LENGTH, "%s", tagName);
    }
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ft%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

// Set
void WebForms_SetId(WebForms* webForms, const char* inputPlace, const char* id) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "si%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, id);
}

void WebForms_SetName(WebForms* webForms, const char* inputPlace, const char* name) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "sn%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, name);
}

void WebForms_SetValue(WebForms* webForms, const char* inputPlace, const char* value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "sv%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, value);
}

void WebForms_SetClass(WebForms* webForms, const char* inputPlace, const char* className) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "sc%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, className);
}

void WebForms_SetStyle(WebForms* webForms, const char* inputPlace, const char* style) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ss%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, style);
}

void WebForms_SetStyleWithNameValue(WebForms* webForms, const char* inputPlace, const char* name, const char* value) {
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s:%s", name, value);
    WebForms_SetStyle(webForms, inputPlace, combined);
}

void WebForms_SetOptionTag(WebForms* webForms, const char* inputPlace, const char* text, const char* value, bool selected) {
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s%s", value, text, selected ? "|1" : "");
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "so%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetChecked(WebForms* webForms, const char* inputPlace, bool checked) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "sk%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, checked ? "1" : "0");
}

void WebForms_SetCheckBoxTagToList(WebForms* webForms, const char* inputPlace, const char* text, const char* value, bool checked) {
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s%s", value, text, checked ? "|1" : "");
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "sk%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetTitle(WebForms* webForms, const char* inputPlace, const char* title) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "sl%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, title);
}

void WebForms_SetText(WebForms* webForms, const char* inputPlace, const char* text) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "st%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, text);
}

void WebForms_SetAttribute(WebForms* webForms, const char* inputPlace, const char* attribute, const char* value) {
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", attribute, value);
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "sa%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetWidthString(WebForms* webForms, const char* inputPlace, const char* width) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "sw%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, width);
}

void WebForms_SetHeightString(WebForms* webForms, const char* inputPlace, const char* height) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "sh%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, height);
}

void WebForms_SetWidth(WebForms* webForms, const char* inputPlace, int width) {
    char widthStr[20];
    snprintf(widthStr, sizeof(widthStr), "%dpx", width);
    WebForms_SetWidthString(webForms, inputPlace, widthStr);
}

void WebForms_SetHeight(WebForms* webForms, const char* inputPlace, int height) {
    char heightStr[20];
    snprintf(heightStr, sizeof(heightStr), "%dpx", height);
    WebForms_SetHeightString(webForms, inputPlace, heightStr);
}

// Insert
void WebForms_InsertId(WebForms* webForms, const char* inputPlace, const char* id) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ii%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, id);
}

void WebForms_InsertName(WebForms* webForms, const char* inputPlace, const char* name) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "in%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, name);
}

void WebForms_InsertValue(WebForms* webForms, const char* inputPlace, const char* value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "iv%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, value);
}

void WebForms_InsertClass(WebForms* webForms, const char* inputPlace, const char* className) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ic%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, className);
}

void WebForms_InsertStyle(WebForms* webForms, const char* inputPlace, const char* style) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "is%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, style);
}

void WebForms_InsertStyleWithNameValue(WebForms* webForms, const char* inputPlace, const char* name, const char* value) {
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s:%s", name, value);
    WebForms_InsertStyle(webForms, inputPlace, combined);
}

void WebForms_InsertOptionTag(WebForms* webForms, const char* inputPlace, const char* text, const char* value, bool selected) {
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s%s", value, text, selected ? "|1" : "");
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "io%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_InsertCheckBoxTag(WebForms* webForms, const char* inputPlace, const char* text, const char* value, bool checked) {
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s%s", value, text, checked ? "|1" : "");
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ik%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_InsertTitle(WebForms* webForms, const char* inputPlace, const char* title) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "il%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, title);
}

void WebForms_InsertText(WebForms* webForms, const char* inputPlace, const char* text) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "it%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, text);
}

void WebForms_InsertAttribute(WebForms* webForms, const char* inputPlace, const char* attribute, const char* value) {
    char combined[MAX_VALUE_LENGTH];
    if (value != NULL && value[0] != '\0') {
        snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", attribute, value);
    } else {
        snprintf(combined, MAX_VALUE_LENGTH, "%s", attribute);
    }
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ia%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

// Delete
void WebForms_DeleteId(WebForms* webForms, const char* inputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "di%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, "1");
}

void WebForms_DeleteName(WebForms* webForms, const char* inputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "dn%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, "1");
}

void WebForms_DeleteValue(WebForms* webForms, const char* inputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "dv%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, "1");
}

void WebForms_DeleteClass(WebForms* webForms, const char* inputPlace, const char* className) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "dc%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, className);
}

void WebForms_DeleteStyle(WebForms* webForms, const char* inputPlace, const char* styleName) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ds%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, styleName);
}

void WebForms_DeleteOptionTag(WebForms* webForms, const char* inputPlace, const char* value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "do%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, value);
}

void WebForms_DeleteAllOptionTag(WebForms* webForms, const char* inputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "do%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, "*");
}

void WebForms_DeleteCheckBoxTag(WebForms* webForms, const char* inputPlace, const char* value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "dk%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, value);
}

void WebForms_DeleteAllCheckBoxTag(WebForms* webForms, const char* inputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "dk%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, "*");
}

void WebForms_DeleteTitle(WebForms* webForms, const char* inputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "dl%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, "1");
}

void WebForms_DeleteText(WebForms* webForms, const char* inputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "dt%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, "1");
}

void WebForms_DeleteAttribute(WebForms* webForms, const char* inputPlace, const char* attribute) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "da%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, attribute);
}

void WebForms_Delete(WebForms* webForms, const char* inputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "de%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, "1");
}

void WebForms_DeleteParent(WebForms* webForms, const char* inputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "dp%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, "1");
}

// Other
void WebForms_SetBackgroundColor(WebForms* webForms, const char* inputPlace, const char* color) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "bc%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, color);
}

void WebForms_SetTextColor(WebForms* webForms, const char* inputPlace, const char* color) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "tc%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, color);
}

void WebForms_SetFontName(WebForms* webForms, const char* inputPlace, const char* name) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "fn%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, name);
}

void WebForms_SetFontSizeString(WebForms* webForms, const char* inputPlace, const char* size) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "fs%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, size);
}

void WebForms_SetFontSize(WebForms* webForms, const char* inputPlace, int size) {
    char sizeStr[20];
    snprintf(sizeStr, sizeof(sizeStr), "%dpx", size);
    WebForms_SetFontSizeString(webForms, inputPlace, sizeStr);
}

void WebForms_SetFontBold(WebForms* webForms, const char* inputPlace, bool bold) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "fb%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, bold ? "1" : "0");
}

void WebForms_SetVisible(WebForms* webForms, const char* inputPlace, bool visible) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "vi%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, visible ? "1" : "0");
}

void WebForms_SetTextAlign(WebForms* webForms, const char* inputPlace, const char* align) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ta%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, align);
}

void WebForms_SetReadOnly(WebForms* webForms, const char* inputPlace, bool readOnly) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "sr%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, readOnly ? "1" : "0");
}

void WebForms_SetDisabled(WebForms* webForms, const char* inputPlace, bool disabled) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "sd%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, disabled ? "1" : "0");
}

void WebForms_SetFocus(WebForms* webForms, const char* inputPlace, bool focus) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "sf%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, focus ? "1" : "0");
}

void WebForms_SetMinLength(WebForms* webForms, const char* inputPlace, int length) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "mn%s", inputPlace);
    char value[MAX_VALUE_LENGTH];
    snprintf(value, MAX_VALUE_LENGTH, "%d", length);
    NameValueCollection_Add(&webForms->WebFormsData, key, value);
}

void WebForms_SetMaxLength(WebForms* webForms, const char* inputPlace, int length) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "mx%s", inputPlace);
    char value[MAX_VALUE_LENGTH];
    snprintf(value, MAX_VALUE_LENGTH, "%d", length);
    NameValueCollection_Add(&webForms->WebFormsData, key, value);
}

void WebForms_SetSelectedValue(WebForms* webForms, const char* inputPlace, const char* value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ts%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, value);
}

void WebForms_SetSelectedIndex(WebForms* webForms, const char* inputPlace, int index) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ti%s", inputPlace);
    char value[MAX_VALUE_LENGTH];
    snprintf(value, MAX_VALUE_LENGTH, "%d", index);
    NameValueCollection_Add(&webForms->WebFormsData, key, value);
}

void WebForms_SetCheckedValue(WebForms* webForms, const char* inputPlace, const char* value, bool selected) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ks%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", value, selected ? "1" : "0");
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetCheckedIndex(WebForms* webForms, const char* inputPlace, int index, bool selected) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ki%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%d|%s", index, selected ? "1" : "0");
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_CallScript(WebForms* webForms, const char* scriptText) {
    NameValueCollection_Add(&webForms->WebFormsData, "_", scriptText);
}

void WebForms_LoadUrl(WebForms* webForms, const char* inputPlace, const char* url) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "lu%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, url);
}

void WebForms_ChangeUrl(WebForms* webForms, const char* url) {
    NameValueCollection_Add(&webForms->WebFormsData, "cu", url);
}

void WebForms_RemoveSessionCache(WebForms* webForms, const char* cacheKey) {
    NameValueCollection_Add(&webForms->WebFormsData, "rs", cacheKey);
}

void WebForms_RemoveAllSessionCache(WebForms* webForms) {
    NameValueCollection_Add(&webForms->WebFormsData, "rs", "*");
}

void WebForms_RemoveCache(WebForms* webForms, const char* cacheKey) {
    NameValueCollection_Add(&webForms->WebFormsData, "rd", cacheKey);
}

void WebForms_RemoveAllCache(WebForms* webForms) {
    NameValueCollection_Add(&webForms->WebFormsData, "rd", "*");
}

void WebForms_SetSessionCache(WebForms* webForms) {
    NameValueCollection_Add(&webForms->WebFormsData, "cs", "1");
}

void WebForms_SetCache(WebForms* webForms, int second) {
    char value[MAX_VALUE_LENGTH];
    snprintf(value, MAX_VALUE_LENGTH, "%d", second);
    NameValueCollection_Add(&webForms->WebFormsData, "cd", value);
}

void WebForms_SetCacheNoTime(WebForms* webForms) {
    NameValueCollection_Add(&webForms->WebFormsData, "cd", "*");
}

// Increase
void WebForms_IncreaseMinLength(WebForms* webForms, const char* inputPlace, int value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "+n%s", inputPlace);
    char valueStr[MAX_VALUE_LENGTH];
    snprintf(valueStr, MAX_VALUE_LENGTH, "%d", value);
    NameValueCollection_Add(&webForms->WebFormsData, key, valueStr);
}

void WebForms_IncreaseMaxLength(WebForms* webForms, const char* inputPlace, int value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "+x%s", inputPlace);
    char valueStr[MAX_VALUE_LENGTH];
    snprintf(valueStr, MAX_VALUE_LENGTH, "%d", value);
    NameValueCollection_Add(&webForms->WebFormsData, key, valueStr);
}

void WebForms_IncreaseFontSize(WebForms* webForms, const char* inputPlace, int value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "+f%s", inputPlace);
    char valueStr[MAX_VALUE_LENGTH];
    snprintf(valueStr, MAX_VALUE_LENGTH, "%d", value);
    NameValueCollection_Add(&webForms->WebFormsData, key, valueStr);
}

void WebForms_IncreaseWidth(WebForms* webForms, const char* inputPlace, int value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "+w%s", inputPlace);
    char valueStr[MAX_VALUE_LENGTH];
    snprintf(valueStr, MAX_VALUE_LENGTH, "%d", value);
    NameValueCollection_Add(&webForms->WebFormsData, key, valueStr);
}

void WebForms_IncreaseHeight(WebForms* webForms, const char* inputPlace, int value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "+h%s", inputPlace);
    char valueStr[MAX_VALUE_LENGTH];
    snprintf(valueStr, MAX_VALUE_LENGTH, "%d", value);
    NameValueCollection_Add(&webForms->WebFormsData, key, valueStr);
}

void WebForms_IncreaseValue(WebForms* webForms, const char* inputPlace, int value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "+v%s", inputPlace);
    char valueStr[MAX_VALUE_LENGTH];
    snprintf(valueStr, MAX_VALUE_LENGTH, "%d", value);
    NameValueCollection_Add(&webForms->WebFormsData, key, valueStr);
}

// Descrease
void WebForms_DecreaseMinLength(WebForms* webForms, const char* inputPlace, int value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "-n%s", inputPlace);
    char valueStr[MAX_VALUE_LENGTH];
    snprintf(valueStr, MAX_VALUE_LENGTH, "%d", value);
    NameValueCollection_Add(&webForms->WebFormsData, key, valueStr);
}

void WebForms_DecreaseMaxLength(WebForms* webForms, const char* inputPlace, int value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "-x%s", inputPlace);
    char valueStr[MAX_VALUE_LENGTH];
    snprintf(valueStr, MAX_VALUE_LENGTH, "%d", value);
    NameValueCollection_Add(&webForms->WebFormsData, key, valueStr);
}

void WebForms_DecreaseFontSize(WebForms* webForms, const char* inputPlace, int value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "-f%s", inputPlace);
    char valueStr[MAX_VALUE_LENGTH];
    snprintf(valueStr, MAX_VALUE_LENGTH, "%d", value);
    NameValueCollection_Add(&webForms->WebFormsData, key, valueStr);
}

void WebForms_DecreaseWidth(WebForms* webForms, const char* inputPlace, int value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "-w%s", inputPlace);
    char valueStr[MAX_VALUE_LENGTH];
    snprintf(valueStr, MAX_VALUE_LENGTH, "%d", value);
    NameValueCollection_Add(&webForms->WebFormsData, key, valueStr);
}

void WebForms_DecreaseHeight(WebForms* webForms, const char* inputPlace, int value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "-h%s", inputPlace);
    char valueStr[MAX_VALUE_LENGTH];
    snprintf(valueStr, MAX_VALUE_LENGTH, "%d", value);
    NameValueCollection_Add(&webForms->WebFormsData, key, valueStr);
}

void WebForms_DecreaseValue(WebForms* webForms, const char* inputPlace, int value) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "-v%s", inputPlace);
    char valueStr[MAX_VALUE_LENGTH];
    snprintf(valueStr, MAX_VALUE_LENGTH, "%d", value);
    NameValueCollection_Add(&webForms->WebFormsData, key, valueStr);
}

// Event
void WebForms_SetPostEvent(WebForms* webForms, const char* inputPlace, const char* htmlEvent) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "Ep%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, htmlEvent);
}

void WebForms_SetPostEventAdding(WebForms* webForms, const char* inputPlace, const char* htmlEvent) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "Ep%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|+", htmlEvent);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetPostEventTo(WebForms* webForms, const char* inputPlace, const char* htmlEvent, const char* outputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "Ep%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", htmlEvent, outputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetPostEventListener(WebForms* webForms, const char* inputPlace, const char* htmlEventListener) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "EP%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, htmlEventListener);
}

void WebForms_SetPostEventListenerAdding(WebForms* webForms, const char* inputPlace, const char* htmlEventListener) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "EP%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|+", htmlEventListener);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetPostEventListenerTo(WebForms* webForms, const char* inputPlace, const char* htmlEventListener, const char* outputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "EP%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", htmlEventListener, outputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetGetEvent(WebForms* webForms, const char* inputPlace, const char* htmlEvent, const char* path) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "Eg%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", htmlEvent, path ? path : "#");
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetGetEventWithOutput(WebForms* webForms, const char* inputPlace, const char* htmlEvent, const char* outputPlace, const char* path) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "Eg%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s|%s", htmlEvent, path ? path : "#", outputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetGetEventInForm(WebForms* webForms, const char* inputPlace, const char* htmlEvent) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "Eg%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, htmlEvent);
}

void WebForms_SetGetEventInFormWithOutput(WebForms* webForms, const char* inputPlace, const char* htmlEvent, const char* outputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "Eg%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", htmlEvent, outputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetGetEventListener(WebForms* webForms, const char* inputPlace, const char* htmlEventListener, const char* path) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "EG%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", htmlEventListener, path ? path : "#");
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetGetEventListenerWithOutput(WebForms* webForms, const char* inputPlace, const char* htmlEventListener, const char* outputPlace, const char* path) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "EG%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s|%s", htmlEventListener, path ? path : "#", outputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetGetEventInFormListener(WebForms* webForms, const char* inputPlace, const char* htmlEventListener) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "EG%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, htmlEventListener);
}

void WebForms_SetGetEventInFormListenerWithOutput(WebForms* webForms, const char* inputPlace, const char* htmlEventListener, const char* outputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "EG%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", htmlEventListener, outputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetTagEvent(WebForms* webForms, const char* inputPlace, const char* htmlEvent, const char* outputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "Et%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", htmlEvent, outputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_SetTagEventListener(WebForms* webForms, const char* inputPlace, const char* htmlEvent, const char* outputPlace) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "ET%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", htmlEvent, outputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, combined);
}

void WebForms_RemovePostEvent(WebForms* webForms, const char* inputPlace, const char* htmlEvent) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "Rp%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, htmlEvent);
}

void WebForms_RemoveGetEvent(WebForms* webForms, const char* inputPlace, const char* htmlEvent) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "Rg%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, htmlEvent);
}

void WebForms_RemoveTagEvent(WebForms* webForms, const char* inputPlace, const char* htmlEvent) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "Rt%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, htmlEvent);
}

void WebForms_RemovePostEventListener(WebForms* webForms, const char* inputPlace, const char* htmlEventListener) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "RP%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, htmlEventListener);
}

void WebForms_RemoveGetEventListener(WebForms* webForms, const char* inputPlace, const char* htmlEventListener) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "RG%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, htmlEventListener);
}

void WebForms_RemoveTagEventListener(WebForms* webForms, const char* inputPlace, const char* htmlEventListener) {
    char key[MAX_KEY_LENGTH];
    snprintf(key, MAX_KEY_LENGTH, "RT%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, key, htmlEventListener);
}

// Save
void WebForms_SaveId(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@gi%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveName(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@gn%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveValue(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@gv%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveValueLength(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@ge%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveClass(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@gc%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveStyle(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@gs%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveTitle(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@gl%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveText(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@gt%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveTextLength(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@gg%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveAttribute(WebForms* webForms, const char* inputPlace, const char* attribute, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@ga%s", inputPlace);
    char combined[MAX_VALUE_LENGTH];
    snprintf(combined, MAX_VALUE_LENGTH, "%s|%s", key ? key : ".", attribute);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, combined);
}

void WebForms_SaveWidth(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@gw%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveHeight(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@gh%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveReadOnly(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@gr%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveSelectedIndex(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@gx%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveTextAlign(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@ta%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveNodeLength(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@nl%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

void WebForms_SaveVisible(WebForms* webForms, const char* inputPlace, const char* key) {
    char fullKey[MAX_KEY_LENGTH];
    snprintf(fullKey, MAX_KEY_LENGTH, "@vi%s", inputPlace);
    NameValueCollection_Add(&webForms->WebFormsData, fullKey, key ? key : ".");
}

// Pre Runner
void WebForms_AssignDelay(WebForms* webForms, float second, int index) {
    if (index < 0 || index >= webForms->WebFormsData.count) return;

    char newName[MAX_KEY_LENGTH];
    snprintf(newName, MAX_KEY_LENGTH, ":%f)%s", second, webForms->WebFormsData.entries[index].name);
    strncpy(webForms->WebFormsData.entries[index].name, newName, MAX_KEY_LENGTH);
}

void WebForms_AssignDelayChange(WebForms* webForms, float second, int index) {
    if (index < 0 || index >= webForms->WebFormsData.count) return;

    char* currentName = webForms->WebFormsData.entries[index].name;
    char* start = strstr(currentName, ":");
    char* end = strstr(currentName, ")");

    if (start && end) {
        char newName[MAX_KEY_LENGTH];
        snprintf(newName, MAX_KEY_LENGTH, ":%f)%s", second, end + 1);
        strncpy(webForms->WebFormsData.entries[index].name, newName, MAX_KEY_LENGTH);
    }
}

void WebForms_AssignInterval(WebForms* webForms, float second, int index) {
    if (index < 0 || index >= webForms->WebFormsData.count) return;

    char newName[MAX_KEY_LENGTH];
    snprintf(newName, MAX_KEY_LENGTH, "(%f)%s", second, webForms->WebFormsData.entries[index].name);
    strncpy(webForms->WebFormsData.entries[index].name, newName, MAX_KEY_LENGTH);
}

void WebForms_AssignIntervalChange(WebForms* webForms, float second, int index) {
    if (index < 0 || index >= webForms->WebFormsData.count) return;

    char* currentName = webForms->WebFormsData.entries[index].name;
    char* start = strstr(currentName, "(");
    char* end = strstr(currentName, ")");

    if (start && end) {
        char newName[MAX_KEY_LENGTH];
        snprintf(newName, MAX_KEY_LENGTH, "(%f)%s", second, end + 1);
        strncpy(webForms->WebFormsData.entries[index].name, newName, MAX_KEY_LENGTH);
    }
}

// Index
void WebForms_StartIndex(WebForms* webForms, const char* name) {
    NameValueCollection_Add(&webForms->WebFormsData, "#", name ? name : "");
}

void WebForms_StartIndexDefault(WebForms* webForms) {
    WebForms_StartIndex(webForms, "");
}

// Get
char* WebForms_GetFormsActionData(WebForms* webForms) {
    static char result[10000]; // Adjust size as needed
    result[0] = '\0';

    for (int i = 0; i < webForms->WebFormsData.count; i++) {
        strcat(result, webForms->WebFormsData.entries[i].name);
        if (strlen(webForms->WebFormsData.entries[i].value) > 0) {
            strcat(result, "=");
            strcat(result, webForms->WebFormsData.entries[i].value);
        }
        strcat(result, "\n");
    }

    return result;
}

char* WebForms_Response(WebForms* webForms) {
    static char result[10000]; // Adjust size as needed
    snprintf(result, sizeof(result), "[web-forms]\n%s", WebForms_GetFormsActionData(webForms));
    return result;
}

void WebForms_Clean(WebForms* webForms) {
    webForms->WebFormsData.count = 0;
}
//
void WebForms_SetHeaders(void* context) {
    // Assuming context is defined as needed for your application
    // Set headers as required (this is a placeholder)
    //printf("Content-Type: text/plain");
}

char* WebForms_GetFormsActionDataLineBreak(WebForms* webForms) {
    static char result[10000]; // Adjust size as needed
    result[0] = '\0';

    for (int i = 0; i < webForms->WebFormsData.count; i++) {
        strcat(result, webForms->WebFormsData.entries[i].name);
        if (strlen(webForms->WebFormsData.entries[i].value) > 0) {
            strcat(result, "=");
            strcat(result, webForms->WebFormsData.entries[i].value);
        }
        if (i < webForms->WebFormsData.count - 1) {
            strcat(result, "$[sln];");
        }
    }

    return result;
}

char* WebForms_ExportToWebFormsTagWithSrc(WebForms* webForms, const char* src) {
    static char result[10000]; // Adjust size as needed
    snprintf(result, sizeof(result), "<web-forms ac=\"%s\"%s%s%s></web-forms>",
             WebForms_GetFormsActionDataLineBreak(webForms),
             (src && strlen(src) > 0) ? " src=\"" : "",
             (src && strlen(src) > 0) ? src : "",
             (src && strlen(src) > 0) ? "\"" : "");
    return result;
}

char* WebForms_ExportToWebFormsTag(WebForms* webForms) {
    return WebForms_ExportToWebFormsTagWithSrc(webForms, "");
}

// Overload with width and height as strings
char* WebForms_ExportToWebFormsTagWithDimensions(WebForms* webForms, const char* width, const char* height, const char* src) {
    static char result[10000]; // Adjust size as needed
    snprintf(result, sizeof(result), "<web-forms ac=\"%s\" width=\"%s\" height=\"%s\"%s%s%s></web-forms>",
             WebForms_GetFormsActionDataLineBreak(webForms),
             width, height,
             (src && strlen(src) > 0) ? " src=\"" : "",
             (src && strlen(src) > 0) ? src : "",
             (src && strlen(src) > 0) ? "\"" : "");
    return result;
}

// Overload with width and height as integers
char* WebForms_ExportToWebFormsTagWithDimensionsInt(WebForms* webForms, int width, int height, const char* src) {
    char widthStr[10], heightStr[10];
    snprintf(widthStr, sizeof(widthStr), "%dpx", width);
    snprintf(heightStr, sizeof(heightStr), "%dpx", height);
    return WebForms_ExportToWebFormsTagWithDimensions(webForms, widthStr, heightStr, src);
}

char* WebForms_DoneToWebFormsTagById(WebForms* webForms, const char* id) {
    static char result[10000]; // Adjust size as needed
    snprintf(result, sizeof(result), "<web-forms ac=\"%s\"%s done=\"true\"></web-forms>",
             WebForms_GetFormsActionDataLineBreak(webForms),
             (id && strlen(id) > 0) ? " id=\"" : "");
    return result;
}

char* WebForms_DoneToWebFormsTag(WebForms* webForms) {
    return WebForms_DoneToWebFormsTagById(webForms, "");
}

NameValueCollection WebForms_ExportToNameValue(WebForms* webForms) {
    return webForms->WebFormsData;
}

void WebForms_AppendForm(WebForms* webForms, WebForms* form) {
    for (int i = 0; i < form->WebFormsData.count; i++) {
        NameValueCollection_Add(&webForms->WebFormsData, form->WebFormsData.entries[i].name, form->WebFormsData.entries[i].value);
    }
}

#define MAX_STRING_LENGTH 256

// Function declarations
char* InputPlace_Id(const char* Id);
char* InputPlace_Name(const char* Name);
char* InputPlace_NameWithIndex(const char* Name, int Index);
char* InputPlace_Tag(const char* Tag);
char* InputPlace_TagWithIndex(const char* Tag, int Index);
char* InputPlace_ClassString(const char* Class);
char* InputPlace_ClassWithIndex(const char* Class, int Index);
char* InputPlace_Query(const char* Query);
char* InputPlace_QueryAll(const char* Query);

// Function definitions
char* InputPlace_Id(const char* Id) {
    return strdup(Id);
}

char* InputPlace_Name(const char* Name) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "(%s)", Name);
    return result;
}

char* InputPlace_NameWithIndex(const char* Name, int Index) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "(%s)%d", Name, Index);
    return result;
}

char* InputPlace_Tag(const char* Tag) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "<%s>", Tag);
    return result;
}

char* InputPlace_TagWithIndex(const char* Tag, int Index) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "<%s>%d", Tag, Index);
    return result;
}

char* InputPlace_Class(const char* Class) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "{%s}", Class);
    return result;
}

char* InputPlace_ClassWithIndex(const char* Class, int Index) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "{%s}%d", Class, Index);
    return result;
}

char* InputPlace_Query(const char* Query) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "*%s", Query);
    // Replace '=' with '$[eq];' (simple implementation)
    char* equal_sign_position = strstr(result, "=");
    if (equal_sign_position) {
        strcpy(equal_sign_position + strlen("$[eq];"), equal_sign_position + 1); // Shift after '='
        strncpy(equal_sign_position, "$[eq];", strlen("$[eq];")); // Replace '='
    }
    return result;
}

char* InputPlace_QueryAll(const char* Query) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "[%s", Query);

    return result;
}

// Fetch function declarations
char* Fetch_Random(int MaxValue);
char* Fetch_RandomWithMin(int MinValue, int MaxValue);
const char* Fetch_DateYear();
const char* Fetch_DateMonth();
const char* Fetch_DateDay();
const char* Fetch_DateHours();
const char* Fetch_DateMinutes();
const char* Fetch_DateSeconds();
const char* Fetch_DateMilliseconds();
char* Fetch_Cookie(const char* Key);
char* Fetch_session(const char* Key);
char* Fetch_sessionWithReplace(const char* Key, const char* ReplaceValue);
char* Fetch_sessionAndRemove(const char* Key);
char* Fetch_sessionAndRemoveWithReplace(const char* Key, const char* ReplaceValue);
char* Fetch_saved(const char* Key);
char* Fetch_Cache(const char* Key);
char* Fetch_CacheWithReplace(const char* Key, const char* ReplaceValue);
char* Fetch_CacheAndRemove(const char* Key);
char* Fetch_CacheAndRemoveWithReplace(const char* Key, const char* ReplaceValue);
char* Fetch_script(const char* ScriptText);

// Fetch function definitions
char* Fetch_Random(int MaxValue) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@mr%d", MaxValue);
    return result;
}

char* Fetch_RandomWithMin(int MinValue, int MaxValue) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@mr%d,%d", MaxValue, MinValue);
    return result;
}

const char* Fetch_DateYear() { return "@dy"; }
const char* Fetch_DateMonth() { return "@dm"; }
const char* Fetch_DateDay() { return "@dd"; }
const char* Fetch_DateHours() { return "@dh"; }
const char* Fetch_DateMinutes() { return "@di"; }
const char* Fetch_DateSeconds() { return "@ds"; }
const char* Fetch_DateMilliseconds() { return "@dl"; }

char* Fetch_Cookie(const char* Key) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@co%s", Key);
    return result;
}

char* Fetch_Session(const char* Key) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@cs%s", Key);
    return result;
}

char* Fetch_SessionWithReplace(const char* Key, const char* ReplaceValue) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@cs%s,%s", Key, ReplaceValue);
    return result;
}

char* Fetch_SessionAndRemove(const char* Key) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@cl%s", Key);
    return result;
}

char* Fetch_SessionAndRemoveWithReplace(const char* Key, const char* ReplaceValue) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@cl%s,%s", Key, ReplaceValue);
    return result;
}

char* Fetch_Saved(const char* Key) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@cl%s", Key);
    return result;
}

char* Fetch_Cache(const char* Key) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@cd%s", Key);
    return result;
}

char* Fetch_CacheWithReplace(const char* Key, const char* ReplaceValue) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@cd%s,%s", Key, ReplaceValue);
    return result;
}

char* Fetch_CacheAndRemove(const char* Key) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@ct%s", Key);
    return result;
}

char* Fetch_CacheAndRemoveWithReplace(const char* Key, const char* ReplaceValue) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@ct%s,%s", Key, ReplaceValue);
    return result;
}

char* Fetch_Script(const char* ScriptText) {
    char* result = (char*)malloc(MAX_STRING_LENGTH);
    snprintf(result, MAX_STRING_LENGTH, "@_%s", ScriptText);
    // Replace '\n' with '$[ln];' (simple implementation)
    char* new_line_position = strstr(result, "\n");
    if (new_line_position) {
        strcpy(new_line_position + strlen("$[ln];"), new_line_position + 1); // Shift after '\n'
        strncpy(new_line_position, "$[ln];", strlen("$[ln];")); // Replace '\n'
    }
    return result;
}

typedef struct {
    const char *OnAbort;
    const char *OnAfterPrint;
    const char *OnBeforePrint;
    const char *OnBeforeUnload;
    const char *OnBlur;
    const char *OnCanPlay;
    const char *OnCanPlayThrough;
    const char *OnChange;
    const char *OnClick;
    const char *OnCopy;
    const char *OnCut;
    const char *OnDoubleClick;
    const char *OnDrag;
    const char *OnDragEnd;
    const char *OnDragEnter;
    const char *OnDragLeave;
    const char *OnDragOver;
    const char *OnDragStart;
    const char *OnDrop;
    const char *OnDurationChange;
    const char *OnEnded;
    const char *OnError;
    const char *OnFocus;
    const char *OnFocusin;
    const char *OnFocusOut;
    const char *OnHashChange;
    const char *OnInput;
    const char *OnInvalid;
    const char *OnKeyDown;
    const char *OnKeyPress;
    const char *OnKeyUp;
    const char *OnLoad;
    const char *OnLoadedData;
    const char *OnLoadedMetaData;
    const char *OnLoadStart;
    const char *OnMouseDown;
    const char *OnMouseEnter;
    const char *OnMouseLeave;
    const char *OnMouseMove;
    const char *OnMouseOver;
    const char *OnMouseOut;
    const char *OnMouseUp;
    const char *OnOffline;
    const char *OnOnline;
    const char *OnPageHide;
    const char *OnPageShow;
    const char *OnPaste;
    const char *OnPause;
    const char *OnPlay;
    const char *OnPlaying;
    const char *OnProgress;
    const char *OnRateChange;
    const char *OnResize;
    const char *OnReset;
    const char *OnScroll;
    const char *OnSearch;
    const char *OnSeeked;
    const char *OnSeeking;
    const char *OnSelect;
    const char *OnStalled;
    const char *OnSubmit;
    const char *OnSuspend;
    const char *OnTimeUpdate;
    const char *OnToggle;
    const char *OnTouchCancel;
    const char *OnTouchEnd;
    const char *OnTouchMove;
    const char *OnTouchStart;
    const char *OnUnload;
    const char *OnVolumeChange;
    const char *OnWaiting;
} HtmlEvent;

HtmlEvent createHtmlEvent() {
    HtmlEvent event = {
        .OnAbort = "onabort",
        .OnAfterPrint = "onafterprint",
        .OnBeforePrint = "onbeforeprint",
        .OnBeforeUnload = "onbeforeunload",
        .OnBlur = "onblur",
        .OnCanPlay = "oncanplay",
        .OnCanPlayThrough = "oncanplaythrough",
        .OnChange = "onchange",
        .OnClick = "onclick",
        .OnCopy = "oncopy",
        .OnCut = "oncut",
        .OnDoubleClick = "ondblclick",
        .OnDrag = "ondrag",
        .OnDragEnd = "ondragend",
        .OnDragEnter = "ondragenter",
        .OnDragLeave = "ondragleave",
        .OnDragOver = "ondragover",
        .OnDragStart = "ondragstart",
        .OnDrop = "ondrop",
        .OnDurationChange = "ondurationchange",
        .OnEnded = "onended",
        .OnError = "onerror",
        .OnFocus = "onfocus",
        .OnFocusin = "onfocusin",
        .OnFocusOut = "onfocusout",
        .OnHashChange = "onhashchange",
        .OnInput = "oninput",
        .OnInvalid = "oninvalid",
        .OnKeyDown = "onkeydown",
        .OnKeyPress = "onkeypress",
        .OnKeyUp = "onkeyup",
        .OnLoad = "onload",
        .OnLoadedData = "onloadeddata",
        .OnLoadedMetaData = "onloadedmetadata",
        .OnLoadStart = "onloadstart",
        .OnMouseDown = "onmousedown",
        .OnMouseEnter = "onmouseenter",
        .OnMouseLeave = "onmouseleave",
        .OnMouseMove = "onmousemove",
        .OnMouseOver = "onmouseover",
        .OnMouseOut = "onmouseout",
        .OnMouseUp = "onmouseup",
        .OnOffline = "onoffline",
        .OnOnline = "ononline",
        .OnPageHide = "onpagehide",
        .OnPageShow = "onpageshow",
        .OnPaste = "onpaste",
        .OnPause = "onpause",
        .OnPlay = "onplay",
        .OnPlaying = "onplaying",
        .OnProgress = "onprogress",
        .OnRateChange = "onratechange",
        .OnResize = "onresize",
        .OnReset = "onreset",
        .OnScroll = "onscroll",
        .OnSearch = "onsearch",
        .OnSeeked = "onseeked",
        .OnSeeking = "onseeking",
        .OnSelect = "onselect",
        .OnStalled = "onstalled",
        .OnSubmit = "onsubmit",
        .OnSuspend = "onsuspend",
        .OnTimeUpdate = "ontimeupdate",
        .OnToggle = "ontoggle",
        .OnTouchCancel = "ontouchcancel",
        .OnTouchEnd = "ontouchend",
        .OnTouchMove = "ontouchmove",
        .OnTouchStart = "ontouchstart",
        .OnUnload = "onunload",
        .OnVolumeChange = "onvolumechange",
        .OnWaiting = "onwaiting"
    };
    return event;
}


typedef struct {
    const char *Abort;
    const char *AfterPrint;
    const char *BeforePrint;
    const char *BeforeUnload;
    const char *Blur;
    const char *CanPlay;
    const char *CanPlayThrough;
    const char *Change;
    const char *Click;
    const char *Copy;
    const char *Cut;
    const char *DoubleClick;
    const char *Drag;
    const char *DragEnd;
    const char *DragEnter;
    const char *DragLeave;
    const char *DragOver;
    const char *DragStart;
    const char *Drop;
    const char *DurationChange;
    const char *Ended;
    const char *Error;
    const char *Focus;
    const char *Focusin;
    const char *FocusOut;
    const char *HashChange;
    const char *Input;
    const char *Invalid;
    const char *KeyDown;
    const char *KeyPress;
    const char *KeyUp;
    const char *Load;
    const char *LoadedData;
    const char *LoadedMetaData;
    const char *LoadStart;
    const char *MouseDown;
    const char *MouseEnter;
    const char *MouseLeave;
    const char *MouseMove;
    const char *MouseOver;
    const char *MouseOut;
    const char *MouseUp;
    const char *Offline;
    const char *Online;
    const char *PageHide;
    const char *PageShow;
    const char *Paste;
    const char *Pause;
    const char *Play;
    const char *Playing;
    const char *Progress;
    const char *RateChange;
    const char *Resize;
    const char *Reset;
    const char *Scroll;
    const char *Search;
    const char *Seeked;
    const char *Seeking;
    const char *Select;
    const char *Stalled;
    const char *Submit;
    const char *Suspend;
    const char *TimeUpdate;
    const char *Toggle;
    const char *TouchCancel;
    const char *TouchEnd;
    const char *TouchMove;
    const char *TouchStart;
    const char *Unload;
    const char *VolumeChange;
    const char *Waiting;
    const char *AnimationEnd;
    const char *AnimationIteration;
    const char *AnimationStart;
    const char *ContextMenu;
    const char *FullScreenChange;
    const char *FullScreenError;
    const char *PopState;
    const char *TransitionEnd;
    const char *Storage;
    const char *Wheel;
} HtmlEventListener;

HtmlEventListener createHtmlEventListener() {
    HtmlEventListener listener = {
        .Abort = "abort",
        .AfterPrint = "afterprint",
        .BeforePrint = "beforeprint",
        .BeforeUnload = "beforeunload",
        .Blur = "blur",
        .CanPlay = "canplay",
        .CanPlayThrough = "canplaythrough",
        .Change = "change",
        .Click = "click",
        .Copy = "copy",
        .Cut = "cut",
        .DoubleClick = "dblclick",
        .Drag = "drag",
        .DragEnd = "dragend",
        .DragEnter = "dragenter",
        .DragLeave = "dragleave",
        .DragOver = "dragover",
        .DragStart = "dragstart",
        .Drop = "drop",
        .DurationChange = "durationchange",
        .Ended = "ended",
        .Error = "error",
        .Focus = "focus",
        .Focusin = "focusin",
        .FocusOut = "focusout",
        .HashChange = "hashchange",
        .Input = "input",
        .Invalid = "invalid",
        .KeyDown = "keydown",
        .KeyPress = "keypress",
        .KeyUp = "keyup",
        .Load = "load",
        .LoadedData = "loadeddata",
        .LoadedMetaData = "loadedmetadata",
        .LoadStart = "loadstart",
        .MouseDown = "mousedown",
        .MouseEnter = "mouseenter",
        .MouseLeave = "mouseleave",
        .MouseMove = "mousemove",
        .MouseOver = "mouseover",
        .MouseOut = "mouseout",
        .MouseUp = "mouseup",
        .Offline = "offline",
        .Online = "online",
        .PageHide = "pagehide",
        .PageShow = "pageshow",
        .Paste = "paste",
        .Pause = "pause",
        .Play = "play",
        .Playing = "playing",
        .Progress = "progress",
        .RateChange = "ratechange",
        .Resize = "resize",
        .Reset = "reset",
        .Scroll = "scroll",
        .Search = "search",
        .Seeked = "seeked",
        .Seeking = "seeking",
        .Select = "select",
        .Stalled = "stalled",
        .Submit = "submit",
        .Suspend = "suspend",
        .TimeUpdate = "timeupdate",
        .Toggle = "toggle",
        .TouchCancel = "touchcancel",
        .TouchEnd = "touchend",
        .TouchMove = "touchmove",
        .TouchStart = "touchstart",
        .Unload = "unload",
        .VolumeChange = "volumechange",
        .Waiting = "waiting",
        .AnimationEnd = "animationend",
        .AnimationIteration = "animationiteration",
        .AnimationStart = "animationstart",
        .ContextMenu = "contextmenu",
        .FullScreenChange = "fullscreenchange",
        .FullScreenError = "fullscreenerror",
        .PopState = "popstate",
        .TransitionEnd = "transitionend",
        .Storage = "storage",
        .Wheel = "wheel"
    };
    return listener;
}

// This method does not support QueryAll
char* appendPlace(const char *text, const char *value) {
    if (strlen(text) < 1) {
        return strdup(value);
    }

    char *result = (char *)malloc(strlen(text) + strlen(value) + 2);
    strcpy(result, text);
    strcat(result, "|");
    strcat(result, value);

    return result;
}

char* appendParrent(const char *text) {
    char *result = (char *)malloc(strlen(text) + 2);
    strcpy(result, "/");
    strcat(result, text);

    return result;
}

char* exportToWebFormsTag(const char *src) {
    char *result = (char *)malloc(strlen(src) + 30);
    sprintf(result, "<web-forms src=\"%s\"></web-forms>", src);

    return result;
}

// Overload
char* exportToWebFormsTagWithDimensions(const char *src, int width, int height) {
    char *result = (char *)malloc(strlen(src) + 50);
    sprintf(result, "<web-forms src=\"%s\" width=\"%d\" height=\"%d\"></web-forms>", src, width, height);

    return result;
}

char* exportActionControlsToWebFormsTag(const char *actionControls) {
    char *result = (char *)malloc(strlen(actionControls) + 30);
    sprintf(result, "<web-forms ac=\"%s\"></web-forms>", actionControls);

    return result;
}
