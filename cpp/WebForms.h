// Compatible with WebFormsJS version 1.6

#include <iostream>
#include <map>
#include <vector>
#include <string>
#include <algorithm>

class NameValue {
public:
    std::string Name;
    std::string Value;

    NameValue() {}

    NameValue(const std::string& name, const std::string& value) : Name(name), Value(value) {}
};

class NameValueCollection {
private:
    std::vector<NameValue> data;

public:
    void Add(const std::string& name, const std::string& value) {
        data.emplace_back(name, value);
    }

    void Set(const std::string& name, const std::string& value) {
        auto it = std::find_if(data.begin(), data.end(), [&](const NameValue& nv) {
            return nv.Name == name;
        });

        if (it != data.end()) {
            it->Value = value;
        } else {
            Add(name, value);
        }
    }

    void Delete(const std::string& name) {
        data.erase(std::remove_if(data.begin(), data.end(), [&](const NameValue& nv) {
            return nv.Name == name;
        }), data.end());
    }

    void DeleteByIndex(int index) {
        if (index >= 0 && index < data.size()) {
            data.erase(data.begin() + index);
        }
    }

    void Empty() {
        data.clear();
    }

    bool Exist(const std::string& name) {
        return std::any_of(data.begin(), data.end(), [&](const NameValue& nv) {
            return nv.Name == name;
        });
    }

    void ChangeValue(const std::string& name, const std::string& value) {
        auto it = std::find_if(data.begin(), data.end(), [&](const NameValue& nv) {
            return nv.Name == name;
        });

        if (it != data.end()) {
            it->Value = value;
        }
    }

    void ChangeName(const std::string& name, const std::string& newName) {
        auto it = std::find_if(data.begin(), data.end(), [&](const NameValue& nv) {
            return nv.Name == name;
        });

        if (it != data.end()) {
            it->Name = newName;
        }
    }

    // Overload
    void ChangeValue(const std::string& name, const std::string& newName, const std::string& value) {
        ChangeName(name, newName);
        ChangeValue(newName, value);
    }

    void ChangeValueByIndex(int index, const std::string& value) {
        if (index >= 0 && index < data.size()) {
            data[index].Value = value;
        }
    }

    void ChangeNameByIndex(int index, const std::string& newName) {
        if (index >= 0 && index < data.size()) {
            data[index].Name = newName;
        }
    }

    void ChangeNameValueByIndex(int index, const std::string& newName, const std::string& value) {
        if (index >= 0 && index < data.size()) {
            data[index].Name = newName;
            data[index].Value = value;
        }
    }

    void AddList(const std::vector<NameValue>& nameValueList) {
        for (const auto& nv : nameValueList) {
            Add(nv.Name, nv.Value);
        }
    }

    std::string GetValue(const std::string& name) {
        auto it = std::find_if(data.begin(), data.end(), [&](const NameValue& nv) {
            return nv.Name == name;
        });

        if (it != data.end()) {
            return it->Value;
        }
        return "";
    }

    std::string GetNameByIndex(int index) {
        if (index >= 0 && index < data.size()) {
            return data[index].Name;
        }
        return "";
    }

    std::string GetValueByIndex(int index) {
        if (index >= 0 && index < data.size()) {
            return data[index].Value;
        }
        return "";
    }

    std::vector<NameValue> GetList() const {
        return data;
    }
};

class WebForms {
private:
    NameValueCollection WebFormsData;

public:
    // For Extension
    void AddLine(const std::string& name, const std::string& value) {
        WebFormsData.Add(name, value);
    }

    // Add
    void AddId(const std::string& inputPlace, const std::string& id) {
        WebFormsData.Add("ai" + inputPlace, id);
    }

    void AddName(const std::string& inputPlace, const std::string& name) {
        WebFormsData.Add("an" + inputPlace, name);
    }

    void AddValue(const std::string& inputPlace, const std::string& value) {
        WebFormsData.Add("av" + inputPlace, value);
    }

    void AddClass(const std::string& inputPlace, const std::string& className) {
        WebFormsData.Add("ac" + inputPlace, className);
    }

    void AddStyle(const std::string& inputPlace, const std::string& style) {
        WebFormsData.Add("as" + inputPlace, style);
    }

    void AddStyle(const std::string& inputPlace, const std::string& name, const std::string& value) {
        WebFormsData.Add("as" + inputPlace, name + ':' + value);
    }

    void AddOptionTag(const std::string& inputPlace, const std::string& text, const std::string& value, bool selected = false) {
        WebFormsData.Add("ao" + inputPlace, value + '|' + text + (selected ? "|1" : ""));
    }

    void AddCheckBoxTag(const std::string& inputPlace, const std::string& text, const std::string& value, bool checked = false) {
        WebFormsData.Add("ak" + inputPlace, value + '|' + text + (checked ? "|1" : ""));
    }

    void AddTitle(const std::string& inputPlace, const std::string& title) {
        WebFormsData.Add("al" + inputPlace, title);
    }

    void AddText(const std::string& inputPlace, const std::string& text) {
        std::string modifiedText = text;
        std::replace(modifiedText.begin(), modifiedText.end(), '\n', ';');
        WebFormsData.Add("at" + inputPlace, modifiedText);
    }

    void AddTextToUp(const std::string& inputPlace, const std::string& text) {
        std::string modifiedText = text;
        std::replace(modifiedText.begin(), modifiedText.end(), '\n', ';');
        WebFormsData.Add("pt" + inputPlace, modifiedText);
    }

    void AddAttribute(const std::string& inputPlace, const std::string& attribute, const std::string& value = "") {
        WebFormsData.Add("aa" + inputPlace, attribute + '|' + value);
    }

    void AddTag(const std::string& inputPlace, const std::string& tagName, const std::string& id = "") {
        WebFormsData.Add("nt" + inputPlace, tagName + (!id.empty() ? '|' + id : ""));
    }

    void AddTagToUp(const std::string& inputPlace, const std::string& tagName, const std::string& id = "") {
        WebFormsData.Add("ut" + inputPlace, tagName + (!id.empty() ? '|' + id : ""));
    }

    void AddTagBefore(const std::string& inputPlace, const std::string& tagName, const std::string& id = "") {
        WebFormsData.Add("bt" + inputPlace, tagName + (!id.empty() ? '|' + id : ""));
    }

    void AddTagAfter(const std::string& inputPlace, const std::string& tagName, const std::string& id = "") {
        WebFormsData.Add("ft" + inputPlace, tagName + (!id.empty() ? '|' + id : ""));
    }

    // Set
    void SetId(const std::string& inputPlace, const std::string& id) {
        WebFormsData.Add("si" + inputPlace, id);
    }

    void SetName(const std::string& inputPlace, const std::string& name) {
        WebFormsData.Add("sn" + inputPlace, name);
    }

    void SetValue(const std::string& inputPlace, const std::string& value) {
        WebFormsData.Add("sv" + inputPlace, value);
    }

    void SetClass(const std::string& inputPlace, const std::string& className) {
        WebFormsData.Add("sc" + inputPlace, className);
    }

    void SetStyle(const std::string& inputPlace, const std::string& style) {
        WebFormsData.Add("ss" + inputPlace, style);
    }

    void SetStyle(const std::string& inputPlace, const std::string& name, const std::string& value) {
        WebFormsData.Add("ss" + inputPlace, name + ':' + value);
    }

    void SetOptionTag(const std::string& inputPlace, const std::string& text, const std::string& value, bool selected = false) {
        WebFormsData.Add("so" + inputPlace, value + '|' + text + (selected ? "|1" : ""));
    }

    void SetChecked(const std::string& inputPlace, bool checked = false) {
        WebFormsData.Add("sk" + inputPlace, checked ? "1" : "0");
    }

    void SetCheckBoxTagToList(const std::string& inputPlace, const std::string& text, const std::string& value, bool checked = false) {
        WebFormsData.Add("sk" + inputPlace, value + '|' + text + (checked ? "|1" : ""));
    }

    void SetTitle(const std::string& inputPlace, const std::string& title) {
        WebFormsData.Add("sl" + inputPlace, title);
    }

    void SetText(const std::string& inputPlace, const std::string& text) {
        std::string modifiedText = text;
        std::replace(modifiedText.begin(), modifiedText.end(), '\n', ';');
        WebFormsData.Add("st" + inputPlace, modifiedText);
    }

    void SetAttribute(const std::string& inputPlace, const std::string& attribute, const std::string& value = "") {
        WebFormsData.Add("sa" + inputPlace, attribute + (!value.empty() ? '|' + value : ""));
    }

    void SetWidth(const std::string& inputPlace, const std::string& width) {
        WebFormsData.Add("sw" + inputPlace, width);
    }

    void SetWidth(const std::string& inputPlace, int width) {
        SetWidth(inputPlace, std::to_string(width) + "px");
    }

    void SetHeight(const std::string& inputPlace, const std::string& height) {
        WebFormsData.Add("sh" + inputPlace, height);
    }

    void SetHeight(const std::string& inputPlace, int height) {
        SetHeight(inputPlace, std::to_string(height) + "px");
    }

    // Insert
    void InsertId(const std::string& inputPlace, const std::string& id) {
        WebFormsData.Add("ii" + inputPlace, id);
    }

    void InsertName(const std::string& inputPlace, const std::string& name) {
        WebFormsData.Add("in" + inputPlace, name);
    }

    void InsertValue(const std::string& inputPlace, const std::string& value) {
        WebFormsData.Add("iv" + inputPlace, value);
    }

    void InsertClass(const std::string& inputPlace, const std::string& className) {
        WebFormsData.Add("ic" + inputPlace, className);
    }

    void InsertStyle(const std::string& inputPlace, const std::string& style) {
        WebFormsData.Add("is" + inputPlace, style);
    }

    void InsertStyle(const std::string& inputPlace, const std::string& name, const std::string& value) {
        WebFormsData.Add("is" + inputPlace, name + ':' + value);
    }

    void InsertOptionTag(const std::string& inputPlace, const std::string& text, const std::string& value, bool selected = false) {
        WebFormsData.Add("io" + inputPlace, value + '|' + text + (selected ? "|1" : ""));
    }

    void InsertCheckBoxTag(const std::string& inputPlace, const std::string& text, const std::string& value, bool checked = false) {
        WebFormsData.Add("ik" + inputPlace, value + '|' + text + (checked ? "|1" : ""));
    }

    void InsertTitle(const std::string& inputPlace, const std::string& title) {
        WebFormsData.Add("il" + inputPlace, title);
    }

    void InsertText(const std::string& inputPlace, const std::string& text) {
        std::string modifiedText = text;
        std::replace(modifiedText.begin(), modifiedText.end(), '\n', ';');
        WebFormsData.Add("it" + inputPlace, modifiedText);
    }

    void InsertAttribute(const std::string& inputPlace, const std::string& attribute, const std::string& value = "") {
        WebFormsData.Add("ia" + inputPlace, attribute + (!value.empty() ? '|' + value : ""));
    }

    // Delete
    void DeleteId(const std::string& inputPlace) {
        WebFormsData.Add("di" + inputPlace, "1");
    }

    void DeleteName(const std::string& inputPlace) {
        WebFormsData.Add("dn" + inputPlace, "1");
    }

    void DeleteValue(const std::string& inputPlace) {
        WebFormsData.Add("dv" + inputPlace, "1");
    }

    void DeleteClass(const std::string& inputPlace, const std::string& className) {
        WebFormsData.Add("dc" + inputPlace, className);
    }

    void DeleteStyle(const std::string& inputPlace, const std::string& styleName) {
        WebFormsData.Add("ds" + inputPlace, styleName);
    }

    void DeleteOptionTag(const std::string& inputPlace, const std::string& value) {
        WebFormsData.Add("do" + inputPlace, value);
    }

    void DeleteAllOptionTag(const std::string& inputPlace) {
        WebFormsData.Add("do" + inputPlace, "*");
    }

    void DeleteCheckBoxTag(const std::string& inputPlace, const std::string& value) {
        WebFormsData.Add("dk" + inputPlace, value);
    }

    void DeleteAllCheckBoxTag(const std::string& inputPlace) {
        WebFormsData.Add("dk" + inputPlace, "*");
    }

    void DeleteTitle(const std::string& inputPlace) {
        WebFormsData.Add("dl" + inputPlace, "1");
    }

    void DeleteText(const std::string& inputPlace) {
        WebFormsData.Add("dt" + inputPlace, "1");
    }

    void DeleteAttribute(const std::string& inputPlace, const std::string& attribute) {
        WebFormsData.Add("da" + inputPlace, attribute);
    }

    void Delete(const std::string& inputPlace) {
        WebFormsData.Add("de" + inputPlace, "1");
    }

    void DeleteParent(const std::string& inputPlace) {
        WebFormsData.Add("dp" + inputPlace, "1");
    }

    // Other
    void SetBackgroundColor(const std::string& inputPlace, const std::string& color) {
        WebFormsData.Add("bc" + inputPlace, color);
    }

    void SetTextColor(const std::string& inputPlace, const std::string& color) {
        WebFormsData.Add("tc" + inputPlace, color);
    }

    void SetFontName(const std::string& inputPlace, const std::string& name) {
        WebFormsData.Add("fn" + inputPlace, name);
    }

    void SetFontSize(const std::string& inputPlace, const std::string& size) {
        WebFormsData.Add("fs" + inputPlace, size);
    }

    void SetFontSize(const std::string& inputPlace, int size) {
        SetFontSize(inputPlace, std::to_string(size) + "px");
    }

    void SetFontBold(const std::string& inputPlace, bool bold) {
        WebFormsData.Add("fb" + inputPlace, bold ? "1" : "0");
    }

    void SetVisible(const std::string& inputPlace, bool visible) {
        WebFormsData.Add("vi" + inputPlace, visible ? "1" : "0");
    }

    void SetTextAlign(const std::string& inputPlace, const std::string& align) {
        WebFormsData.Add("ta" + inputPlace, align);
    }

    void SetReadOnly(const std::string& inputPlace, bool readOnly) {
        WebFormsData.Add("sr" + inputPlace, readOnly ? "1" : "0");
    }

    void SetDisabled(const std::string& inputPlace, bool disabled) {
        WebFormsData.Add("sd" + inputPlace, disabled ? "1" : "0");
    }

    void SetFocus(const std::string& inputPlace, bool focus) {
        WebFormsData.Add("sf" + inputPlace, focus ? "1" : "0");
    }

    void SetMinLength(const std::string& inputPlace, int length) {
        WebFormsData.Add("mn" + inputPlace, std::to_string(length));
    }

    void SetMaxLength(const std::string& inputPlace, int length) {
        WebFormsData.Add("mx" + inputPlace, std::to_string(length));
    }

    void SetSelectedValue(const std::string& inputPlace, const std::string& value) {
        WebFormsData.Add("ts" + inputPlace, value);
    }

    void SetSelectedIndex(const std::string& inputPlace, int index) {
        WebFormsData.Add("ti" + inputPlace, std::to_string(index));
    }

    void SetCheckedValue(const std::string& inputPlace, const std::string& value, bool selected) {
        WebFormsData.Add("ks" + inputPlace, value + "|" + (selected ? "1" : "0"));
    }

    void SetCheckedIndex(const std::string& inputPlace, int index, bool selected) {
        WebFormsData.Add("ki" + inputPlace, std::to_string(index) + "|" + (selected ? "1" : "0"));
    }

    void CallScript(const std::string& scriptText) {
        std::string modifiedText = scriptText;
        std::replace(modifiedText.begin(), modifiedText.end(), '\n', ';');
        WebFormsData.Add("_", modifiedText);
    }

    void LoadUrl(const std::string& inputPlace, const std::string& url) {
        WebFormsData.Add("lu" + inputPlace, url);
    }

    void ChangeUrl(const std::string& url) {
        WebFormsData.Add("cu", url);
    }

    void RemoveSessionCache(const std::string& cacheKey) {
        WebFormsData.Add("rs", cacheKey);
    }

    void RemoveAllSessionCache() {
        WebFormsData.Add("rs", "*");
    }

    void RemoveCache(const std::string& cacheKey) {
        WebFormsData.Add("rd", cacheKey);
    }

    void RemoveAllCache() {
        WebFormsData.Add("rd", "*");
    }

    void SetSessionCache() {
        WebFormsData.Add("cs", "1");
    }

    void SetCache(int second) {
        WebFormsData.Add("cd", std::to_string(second));
    }

    void SetCache() {
        WebFormsData.Add("cd", "*");
    }

    // Increase
    void IncreaseMinLength(const std::string& inputPlace, int value) {
        WebFormsData.Add("+n" + inputPlace, std::to_string(value));
    }

    void IncreaseMaxLength(const std::string& inputPlace, int value) {
        WebFormsData.Add("+x" + inputPlace, std::to_string(value));
    }

    void IncreaseFontSize(const std::string& inputPlace, int value) {
        WebFormsData.Add("+f" + inputPlace, std::to_string(value));
    }

    void IncreaseWidth(const std::string& inputPlace, int value) {
        WebFormsData.Add("+w" + inputPlace, std::to_string(value));
    }

    void IncreaseHeight(const std::string& inputPlace, int value) {
        WebFormsData.Add("+h" + inputPlace, std::to_string(value));
    }

    void IncreaseValue(const std::string& inputPlace, int value) {
        WebFormsData.Add("+v" + inputPlace, std::to_string(value));
    }

    // Descrease
    void DescreaseMinLength(const std::string& inputPlace, int value) {
        WebFormsData.Add("-n" + inputPlace, std::to_string(value));
    }

    void DescreaseMaxLength(const std::string& inputPlace, int value) {
        WebFormsData.Add("-x" + inputPlace, std::to_string(value));
    }

    void DescreaseFontSize(const std::string& inputPlace, int value) {
        WebFormsData.Add("-f" + inputPlace, std::to_string(value));
    }

    void DescreaseWidth(const std::string& inputPlace, int value) {
        WebFormsData.Add("-w" + inputPlace, std::to_string(value));
    }

    void DescreaseHeight(const std::string& inputPlace, int value) {
        WebFormsData.Add("-h" + inputPlace, std::to_string(value));
    }

    void DescreaseValue(const std::string& inputPlace, int value) {
        WebFormsData.Add("-v" + inputPlace, std::to_string(value));
    }

    // Event
    void SetPostEvent(const std::string& inputPlace, const std::string& htmlEvent) {
        WebFormsData.Add("Ep" + inputPlace, htmlEvent);
    }

    void SetPostEventAdding(const std::string& inputPlace, const std::string& htmlEvent) {
        WebFormsData.Add("Ep" + inputPlace, htmlEvent + "|+");
    }

    void SetPostEventTo(const std::string& inputPlace, const std::string& htmlEvent, const std::string& outputPlace) {
        WebFormsData.Add("Ep" + inputPlace, htmlEvent + "|" + outputPlace);
    }

    void SetPostEventListener(const std::string& inputPlace, const std::string& htmlEventListener) {
        WebFormsData.Add("EP" + inputPlace, htmlEventListener);
    }

    void SetPostEventListenerAdding(const std::string& inputPlace, const std::string& htmlEventListener) {
        WebFormsData.Add("EP" + inputPlace, htmlEventListener + "|+");
    }

    void SetPostEventListenerTo(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& outputPlace) {
        WebFormsData.Add("EP" + inputPlace, htmlEventListener + "|" + outputPlace);
    }

    void SetGetEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& path = "#") {
        WebFormsData.Add("Eg" + inputPlace, htmlEvent + "|" + path);
    }

    void SetGetEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& outputPlace, const std::string& path = "#") {
        WebFormsData.Add("Eg" + inputPlace, htmlEvent + "|" + path + "|" + outputPlace);
    }

    void SetGetEventInForm(const std::string& inputPlace, const std::string& htmlEvent) {
        WebFormsData.Add("Eg" + inputPlace, htmlEvent);
    }

    void SetGetEventInForm(const std::string& inputPlace, const std::string& htmlEvent, const std::string& outputPlace) {
        WebFormsData.Add("Eg" + inputPlace, htmlEvent + "|" + outputPlace);
    }

    void SetGetEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& path = "#") {
        WebFormsData.Add("EG" + inputPlace, htmlEventListener + "|" + path);
    }

    void SetGetEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& outputPlace, const std::string& path = "#") {
        WebFormsData.Add("EG" + inputPlace, htmlEventListener + "|" + path + "|" + outputPlace);
    }

    void SetGetEventInFormListener(const std::string& inputPlace, const std::string& htmlEventListener) {
        WebFormsData.Add("EG" + inputPlace, htmlEventListener);
    }

    void SetGetEventInFormListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& outputPlace) {
        WebFormsData.Add("EG" + inputPlace, htmlEventListener + "|" + outputPlace);
    }

    void SetTagEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& outputPlace) {
        WebFormsData.Add("Et" + inputPlace, htmlEvent + "|" + outputPlace);
    }

    void SetTagEventListener(const std::string& inputPlace, const std::string& htmlEvent, const std::string& outputPlace) {
        WebFormsData.Add("ET" + inputPlace, htmlEvent + "|" + outputPlace);
    }

    void RemovePostEvent(const std::string& inputPlace, const std::string& htmlEvent) {
        WebFormsData.Add("Rp" + inputPlace, htmlEvent);
    }

    void RemoveGetEvent(const std::string& inputPlace, const std::string& htmlEvent) {
        WebFormsData.Add("Rg" + inputPlace, htmlEvent);
    }

    void RemoveTagEvent(const std::string& inputPlace, const std::string& htmlEvent) {
        WebFormsData.Add("Rt" + inputPlace, htmlEvent);
    }

    void RemovePostEventListener(const std::string& inputPlace, const std::string& htmlEventListener) {
        WebFormsData.Add("RP" + inputPlace, htmlEventListener);
    }

    void RemoveGetEventListener(const std::string& inputPlace, const std::string& htmlEventListener) {
        WebFormsData.Add("RG" + inputPlace, htmlEventListener);
    }

    void RemoveTagEventListener(const std::string& inputPlace, const std::string& htmlEventListener) {
        WebFormsData.Add("RT" + inputPlace, htmlEventListener);
    }

    // Save
    void SaveId(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@gi" + inputPlace, key);
    }

    void SaveName(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@gn" + inputPlace, key);
    }

    void SaveValue(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@gv" + inputPlace, key);
    }

    void SaveValueLength(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@ge" + inputPlace, key);
    }

    void SaveClass(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@gc" + inputPlace, key);
    }

    void SaveStyle(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@gs" + inputPlace, key);
    }

    void SaveTitle(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@gl" + inputPlace, key);
    }

    void SaveText(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@gt" + inputPlace, key);
    }

    void SaveTextLength(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@gg" + inputPlace, key);
    }

    void SaveAttribute(const std::string& inputPlace, const std::string& attribute, const std::string& key = ".") {
        WebFormsData.Add("@ga" + inputPlace, key + '|' + attribute);
    }

    void SaveWidth(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@gw" + inputPlace, key);
    }

    void SaveHeight(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@gh" + inputPlace, key);
    }

    void SaveReadOnly(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@gr" + inputPlace, key);
    }

    void SaveSelectedIndex(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@gx" + inputPlace, key);
    }

    void SaveTextAlign(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@ta" + inputPlace, key);
    }

    void SaveNodeLength(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@nl" + inputPlace, key);
    }

    void SaveVisible(const std::string& inputPlace, const std::string& key = ".") {
        WebFormsData.Add("@vi" + inputPlace, key);
    }

    // Pre Runner
    void AssignDelay(float second, int index = -1) {
        std::string currentName = WebFormsData.GetNameByIndex(index);
        if (currentName.empty()) return;
        WebFormsData.ChangeNameByIndex(index, ":" + std::to_string(second) + ")" + currentName);
    }

    void AssignDelayChange(float second, int index = -1) {
        std::string currentName = WebFormsData.GetNameByIndex(index);
        if (currentName.empty()) return;
        currentName = currentName.substr(currentName.find(")") + 1);
        WebFormsData.ChangeNameByIndex(index, ":" + std::to_string(second) + ")" + currentName);
    }

    void AssignInterval(float second, int index = -1) {
        std::string currentName = WebFormsData.GetNameByIndex(index);
        if (currentName.empty()) return;
        WebFormsData.ChangeNameByIndex(index, "(" + std::to_string(second) + ")" + currentName);
    }

    void AssignIntervalChange(float second, int index = -1) {
        std::string currentName = WebFormsData.GetNameByIndex(index);
        if (currentName.empty()) return;
        currentName = currentName.substr(currentName.find(")") + 1);
        WebFormsData.ChangeNameByIndex(index, "(" + std::to_string(second) + ")" + currentName);
    }

    // Index
    void StartIndex(const std::string& name) {
        WebFormsData.Add("#", name);
    }

    void StartIndex() {
        StartIndex("");
    }

    // Get
    std::string GetFormsActionData() {
        std::string returnValue;
        for (const auto& nv : WebFormsData.GetList()) {
            returnValue += nv.Name;
            if (!nv.Value.empty()) {
                returnValue += "=" + nv.Value;
            }
            returnValue += "\n";
        }
        return returnValue;
    }

    std::string Response() {
        return "[web-forms]\n" + GetFormsActionData();
    }

    std::string GetFormsActionDataLineBreak() {
        std::string returnValue;
        auto webFormsDataList = WebFormsData.GetList();
        int i = webFormsDataList.size();
        for (const auto& nv : webFormsDataList) {
            returnValue += nv.Name;
            if (!nv.Value.empty()) {
                returnValue += "=" + nv.Value;
            }
            if (i-- > 1) {
                returnValue += "$[sln];";
            }
        }
        return returnValue;
    }

    // Export
    std::string ExportToWebFormsTag(const std::string& src = "") {
        return "<web-forms ac=\"" + GetFormsActionDataLineBreak() + "\"" + (!src.empty() ? " src=\"" + src + "\"" : "") + "></web-forms>";
    }

    // Overload
    std::string ExportToWebFormsTag(const std::string& width, const std::string& height, const std::string& src = "") {
        return "<web-forms ac=\"" + GetFormsActionDataLineBreak() + "\" width=\"" + width + "\" height=\"" + height + "\"" + (!src.empty() ? " src=\"" + src + "\"" : "") + "></web-forms>";
    }

    // Overload
    std::string ExportToWebFormsTag(int width, int height, const std::string& src = "") {
        return ExportToWebFormsTag(std::to_string(width) + "px", std::to_string(height) + "px", src);
    }

    std::string DoneToWebFormsTag(const std::string& id = "") {
        return "<web-forms ac=\"" + GetFormsActionDataLineBreak() + "\"" + (!id.empty() ? " id=\"" + id + "\" done=\"true\"" : "") + "></web-forms>";
    }

    NameValueCollection ExportToNameValue() {
        return WebFormsData;
    }

    void AppendForm(WebForms& form) {
        WebFormsData.AddList(form.ExportToNameValue().GetList());
    }

    void Clean() {
        WebFormsData.Empty();
    }
};

class InputPlace {
public:
    static std::string Id(const std::string& id) {
        return id;
    }

    static std::string Name(const std::string& name) {
        return "(" + name + ")";
    }

    static std::string Name(const std::string& name, int index) {
        return "(" + name + ")" + std::to_string(index);
    }

    static std::string Tag(const std::string& tag) {
        return "<" + tag + ">";
    }

    static std::string Tag(const std::string& tag, int index) {
        return "<" + tag + ">" + std::to_string(index);
    }

    static std::string Class(const std::string& className) {
        return "{" + className + "}";
    }

    static std::string Class(const std::string& className, int index) {
        return "{" + className + "}" + std::to_string(index);
    }

    static std::string Query(const std::string& query) {
        return "*" + query;
    }

    static std::string QueryAll(const std::string& query) {
        return "[" + query;
    }
};

class OutputPlace : public InputPlace {};

/// <summary>
/// Do Not Add Any Data Before Or After It
/// </summary>
class Fetch {
public:
    static std::string Random(int maxValue) {
        return "@mr" + std::to_string(maxValue);
    }

    static std::string Random(int minValue, int maxValue) {
        return "@mr" + std::to_string(maxValue) + "," + std::to_string(minValue);
    }

    static const std::string DateYear;
    static const std::string DateMonth;
    static const std::string DateDay;
    static const std::string DateHours;
    static const std::string DateMinutes;
    static const std::string DateSeconds;
    static const std::string DateMilliseconds;

    static std::string Cookie(const std::string& key) {
        return "@co" + key;
    }

    static std::string Session(const std::string& key) {
        return "@cs" + key;
    }

    static std::string Session(const std::string& key, const std::string& replaceValue) {
        return "@cs" + key + "," + replaceValue;
    }

    static std::string SessionAndRemove(const std::string& key) {
        return "@cl" + key;
    }

    static std::string SessionAndRemove(const std::string& key, const std::string& replaceValue) {
        return "@cl" + key + "," + replaceValue;
    }

    static std::string Saved(const std::string& key = ".") {
        return "@cl" + key;
    }

    static std::string Cache(const std::string& key) {
        return "@cd" + key;
    }

    static std::string Cache(const std::string& key, const std::string& replaceValue) {
        return "@cd" + key + "," + replaceValue;
    }

    static std::string CacheAndRemove(const std::string& key) {
        return "@ct" + key;
    }

    static std::string CacheAndRemove(const std::string& key, const std::string& replaceValue) {
        return "@ct" + key + "," + replaceValue;
    }

    static std::string Script(const std::string& scriptText) {
        std::string modifiedText = scriptText;
        std::replace(modifiedText.begin(), modifiedText.end(), '\n', ';');
        return "@_" + modifiedText;
    }
};

const std::string Fetch::DateYear = "@dy";
const std::string Fetch::DateMonth = "@dm";
const std::string Fetch::DateDay = "@dd";
const std::string Fetch::DateHours = "@dh";
const std::string Fetch::DateMinutes = "@di";
const std::string Fetch::DateSeconds = "@ds";
const std::string Fetch::DateMilliseconds = "@dl";

class HtmlEvent {
public:
    static const std::string OnAbort;
    static const std::string OnAfterPrint;
    static const std::string OnBeforePrint;
    static const std::string OnBeforeUnload;
    static const std::string OnBlur;
    static const std::string OnCanPlay;
    static const std::string OnCanPlayThrough;
    static const std::string OnChange;
    static const std::string OnClick;
    static const std::string OnCopy;
    static const std::string OnCut;
    static const std::string OnDoubleClick;
    static const std::string OnDrag;
    static const std::string OnDragEnd;
    static const std::string OnDragEnter;
    static const std::string OnDragLeave;
    static const std::string OnDragOver;
    static const std::string OnDragStart;
    static const std::string OnDrop;
    static const std::string OnDurationChange;
    static const std::string OnEnded;
    static const std::string OnError;
    static const std::string OnFocus;
    static const std::string OnFocusin;
    static const std::string OnFocusOut;
    static const std::string OnHashChange;
    static const std::string OnInput;
    static const std::string OnInvalid;
    static const std::string OnKeyDown;
    static const std::string OnKeyPress;
    static const std::string OnKeyUp;
    static const std::string OnLoad;
    static const std::string OnLoadedData;
    static const std::string OnLoadedMetaData;
    static const std::string OnLoadStart;
    static const std::string OnMouseDown;
    static const std::string OnMouseEnter;
    static const std::string OnMouseLeave;
    static const std::string OnMouseMove;
    static const std::string OnMouseOver;
    static const std::string OnMouseOut;
    static const std::string OnMouseUp;
    static const std::string OnOffline;
    static const std::string OnOnline;
    static const std::string OnPageHide;
    static const std::string OnPageShow;
    static const std::string OnPaste;
    static const std::string OnPause;
    static const std::string OnPlay;
    static const std::string OnPlaying;
    static const std::string OnProgress;
    static const std::string OnRateChange;
    static const std::string OnResize;
    static const std::string OnReset;
    static const std::string OnScroll;
    static const std::string OnSearch;
    static const std::string OnSeeked;
    static const std::string OnSeeking;
    static const std::string OnSelect;
    static const std::string OnStalled;
    static const std::string OnSubmit;
    static const std::string OnSuspend;
    static const std::string OnTimeUpdate;
    static const std::string OnToggle;
    static const std::string OnTouchCancel;
    static const std::string OnTouchend;
    static const std::string OnTouchMove;
    static const std::string OnTouchStart;
    static const std::string OnUnload;
    static const std::string OnVolumeChange;
    static const std::string OnWaiting;
};

const std::string HtmlEvent::OnAbort = "onabort";
const std::string HtmlEvent::OnAfterPrint = "onafterprint";
const std::string HtmlEvent::OnBeforePrint = "onbeforeprint";
const std::string HtmlEvent::OnBeforeUnload = "onbeforeunload";
const std::string HtmlEvent::OnBlur = "onblur";
const std::string HtmlEvent::OnCanPlay = "oncanplay";
const std::string HtmlEvent::OnCanPlayThrough = "oncanplaythrough";
const std::string HtmlEvent::OnChange = "onchange";
const std::string HtmlEvent::OnClick = "onclick";
const std::string HtmlEvent::OnCopy = "oncopy";
const std::string HtmlEvent::OnCut = "oncut";
const std::string HtmlEvent::OnDoubleClick = "ondblclick";
const std::string HtmlEvent::OnDrag = "ondrag";
const std::string HtmlEvent::OnDragEnd = "ondragend";
const std::string HtmlEvent::OnDragEnter = "ondragenter";
const std::string HtmlEvent::OnDragLeave = "ondragleave";
const std::string HtmlEvent::OnDragOver = "ondragover";
const std::string HtmlEvent::OnDragStart = "ondragstart";
const std::string HtmlEvent::OnDrop = "ondrop";
const std::string HtmlEvent::OnDurationChange = "ondurationchange";
const std::string HtmlEvent::OnEnded = "onended";
const std::string HtmlEvent::OnError = "onerror";
const std::string HtmlEvent::OnFocus = "onfocus";
const std::string HtmlEvent::OnFocusin = "onfocusin";
const std::string HtmlEvent::OnFocusOut = "onfocusout";
const std::string HtmlEvent::OnHashChange = "onhashchange";
const std::string HtmlEvent::OnInput = "oninput";
const std::string HtmlEvent::OnInvalid = "oninvalid";
const std::string HtmlEvent::OnKeyDown = "onkeydown";
const std::string HtmlEvent::OnKeyPress = "onkeypress";
const std::string HtmlEvent::OnKeyUp = "onkeyup";
const std::string HtmlEvent::OnLoad = "onload";
const std::string HtmlEvent::OnLoadedData = "onloadeddata";
const std::string HtmlEvent::OnLoadedMetaData = "onloadedmetadata";
const std::string HtmlEvent::OnLoadStart = "onloadstart";
const std::string HtmlEvent::OnMouseDown = "onmousedown";
const std::string HtmlEvent::OnMouseEnter = "onmouseenter";
const std::string HtmlEvent::OnMouseLeave = "onmouseleave";
const std::string HtmlEvent::OnMouseMove = "onmousemove";
const std::string HtmlEvent::OnMouseOver = "onmouseover";
const std::string HtmlEvent::OnMouseOut = "onmouseout";
const std::string HtmlEvent::OnMouseUp = "onmouseup";
const std::string HtmlEvent::OnOffline = "onoffline";
const std::string HtmlEvent::OnOnline = "ononline";
const std::string HtmlEvent::OnPageHide = "onpagehide";
const std::string HtmlEvent::OnPageShow = "onpageshow";
const std::string HtmlEvent::OnPaste = "onpaste";
const std::string HtmlEvent::OnPause = "onpause";
const std::string HtmlEvent::OnPlay = "onplay";
const std::string HtmlEvent::OnPlaying = "onplaying";
const std::string HtmlEvent::OnProgress = "onprogress";
const std::string HtmlEvent::OnRateChange = "onratechange";
const std::string HtmlEvent::OnResize = "onresize";
const std::string HtmlEvent::OnReset = "onreset";
const std::string HtmlEvent::OnScroll = "onscroll";
const std::string HtmlEvent::OnSearch = "onsearch";
const std::string HtmlEvent::OnSeeked = "onseeked";
const std::string HtmlEvent::OnSeeking = "onseeking";
const std::string HtmlEvent::OnSelect = "onselect";
const std::string HtmlEvent::OnStalled = "onstalled";
const std::string HtmlEvent::OnSubmit = "onsubmit";
const std::string HtmlEvent::OnSuspend = "onsuspend";
const std::string HtmlEvent::OnTimeUpdate = "ontimeupdate";
const std::string HtmlEvent::OnToggle = "ontoggle";
const std::string HtmlEvent::OnTouchCancel = "ontouchcancel";
const std::string HtmlEvent::OnTouchend = "ontouchend";
const std::string HtmlEvent::OnTouchMove = "ontouchmove";
const std::string HtmlEvent::OnTouchStart = "ontouchstart";
const std::string HtmlEvent::OnUnload = "onunload";
const std::string HtmlEvent::OnVolumeChange = "onvolumechange";
const std::string HtmlEvent::OnWaiting = "onwaiting";

class HtmlEventListener {
public:
    static const std::string Abort;
    static const std::string AfterPrint;
    static const std::string BeforePrint;
    static const std::string BeforeUnload;
    static const std::string Blur;
    static const std::string CanPlay;
    static const std::string CanPlayThrough;
    static const std::string Change;
    static const std::string Click;
    static const std::string Copy;
    static const std::string Cut;
    static const std::string DoubleClick;
    static const std::string Drag;
    static const std::string DragEnd;
    static const std::string DragEnter;
    static const std::string DragLeave;
    static const std::string DragOver;
    static const std::string DragStart;
    static const std::string Drop;
    static const std::string DurationChange;
    static const std::string Ended;
    static const std::string Error;
    static const std::string Focus;
    static const std::string Focusin;
    static const std::string FocusOut;
    static const std::string HashChange;
    static const std::string Input;
    static const std::string Invalid;
    static const std::string KeyDown;
    static const std::string KeyPress;
    static const std::string KeyUp;
    static const std::string Load;
    static const std::string LoadedData;
    static const std::string LoadedMetaData;
    static const std::string LoadStart;
    static const std::string MouseDown;
    static const std::string MouseEnter;
    static const std::string MouseLeave;
    static const std::string MouseMove;
    static const std::string MouseOver;
    static const std::string MouseOut;
    static const std::string MouseUp;
    static const std::string Offline;
    static const std::string Online;
    static const std::string PageHide;
    static const std::string PageShow;
    static const std::string Paste;
    static const std::string Pause;
    static const std::string Play;
    static const std::string Playing;
    static const std::string Progress;
    static const std::string RateChange;
    static const std::string Resize;
    static const std::string Reset;
    static const std::string Scroll;
    static const std::string Search;
    static const std::string Seeked;
    static const std::string Seeking;
    static const std::string Select;
    static const std::string Stalled;
    static const std::string Submit;
    static const std::string Suspend;
    static const std::string TimeUpdate;
    static const std::string Toggle;
    static const std::string TouchCancel;
    static const std::string Touchend;
    static const std::string TouchMove;
    static const std::string TouchStart;
    static const std::string Unload;
    static const std::string VolumeChange;
    static const std::string Waiting;

    static const std::string AnimationEnd;
    static const std::string AnimationIteration;
    static const std::string AnimationStart;
    static const std::string ContextMenu;
    static const std::string FullScreenChange;
    static const std::string FullScreenError;
    static const std::string PopState;
    static const std::string TransitionEnd;
    static const std::string Storage;
    static const std::string Wheel;
};

const std::string HtmlEventListener::Abort = "abort";
const std::string HtmlEventListener::AfterPrint = "afterprint";
const std::string HtmlEventListener::BeforePrint = "beforeprint";
const std::string HtmlEventListener::BeforeUnload = "beforeunload";
const std::string HtmlEventListener::Blur = "blur";
const std::string HtmlEventListener::CanPlay = "canplay";
const std::string HtmlEventListener::CanPlayThrough = "canplaythrough";
const std::string HtmlEventListener::Change = "change";
const std::string HtmlEventListener::Click = "click";
const std::string HtmlEventListener::Copy = "copy";
const std::string HtmlEventListener::Cut = "cut";
const std::string HtmlEventListener::DoubleClick = "dblclick";
const std::string HtmlEventListener::Drag = "drag";
const std::string HtmlEventListener::DragEnd = "dragend";
const std::string HtmlEventListener::DragEnter = "dragenter";
const std::string HtmlEventListener::DragLeave = "dragleave";
const std::string HtmlEventListener::DragOver = "dragover";
const std::string HtmlEventListener::DragStart = "dragstart";
const std::string HtmlEventListener::Drop = "drop";
const std::string HtmlEventListener::DurationChange = "durationchange";
const std::string HtmlEventListener::Ended = "ended";
const std::string HtmlEventListener::Error = "error";
const std::string HtmlEventListener::Focus = "focus";
const std::string HtmlEventListener::Focusin = "focusin";
const std::string HtmlEventListener::FocusOut = "focusout";
const std::string HtmlEventListener::HashChange = "hashchange";
const std::string HtmlEventListener::Input = "input";
const std::string HtmlEventListener::Invalid = "invalid";
const std::string HtmlEventListener::KeyDown = "keydown";
const std::string HtmlEventListener::KeyPress = "keypress";
const std::string HtmlEventListener::KeyUp = "keyup";
const std::string HtmlEventListener::Load = "load";
const std::string HtmlEventListener::LoadedData = "loadeddata";
const std::string HtmlEventListener::LoadedMetaData = "loadedmetadata";
const std::string HtmlEventListener::LoadStart = "loadstart";
const std::string HtmlEventListener::MouseDown = "mousedown";
const std::string HtmlEventListener::MouseEnter = "mouseenter";
const std::string HtmlEventListener::MouseLeave = "mouseleave";
const std::string HtmlEventListener::MouseMove = "mousemove";
const std::string HtmlEventListener::MouseOver = "mouseover";
const std::string HtmlEventListener::MouseOut = "mouseout";
const std::string HtmlEventListener::MouseUp = "mouseup";
const std::string HtmlEventListener::Offline = "offline";
const std::string HtmlEventListener::Online = "online";
const std::string HtmlEventListener::PageHide = "pagehide";
const std::string HtmlEventListener::PageShow = "pageshow";
const std::string HtmlEventListener::Paste = "paste";
const std::string HtmlEventListener::Pause = "pause";
const std::string HtmlEventListener::Play = "play";
const std::string HtmlEventListener::Playing = "playing";
const std::string HtmlEventListener::Progress = "progress";
const std::string HtmlEventListener::RateChange = "ratechange";
const std::string HtmlEventListener::Resize = "resize";
const std::string HtmlEventListener::Reset = "reset";
const std::string HtmlEventListener::Scroll = "scroll";
const std::string HtmlEventListener::Search = "search";
const std::string HtmlEventListener::Seeked = "seeked";
const std::string HtmlEventListener::Seeking = "seeking";
const std::string HtmlEventListener::Select = "select";
const std::string HtmlEventListener::Stalled = "stalled";
const std::string HtmlEventListener::Submit = "submit";
const std::string HtmlEventListener::Suspend = "suspend";
const std::string HtmlEventListener::TimeUpdate = "timeupdate";
const std::string HtmlEventListener::Toggle = "toggle";
const std::string HtmlEventListener::TouchCancel = "touchcancel";
const std::string HtmlEventListener::Touchend = "touchend";
const std::string HtmlEventListener::TouchMove = "touchmove";
const std::string HtmlEventListener::TouchStart = "touchstart";
const std::string HtmlEventListener::Unload = "unload";
const std::string HtmlEventListener::VolumeChange = "volumechange";
const std::string HtmlEventListener::Waiting = "waiting";

const std::string HtmlEventListener::AnimationEnd = "animationend";
const std::string HtmlEventListener::AnimationIteration = "animationiteration";
const std::string HtmlEventListener::AnimationStart = "animationstart";
const std::string HtmlEventListener::ContextMenu = "contextmenu";
const std::string HtmlEventListener::FullScreenChange = "fullscreenchange";
const std::string HtmlEventListener::FullScreenError = "fullscreenerror";
const std::string HtmlEventListener::PopState = "popstate";
const std::string HtmlEventListener::TransitionEnd = "transitionend";
const std::string HtmlEventListener::Storage = "storage";
const std::string HtmlEventListener::Wheel = "wheel";

class ExtensionWebFormsMethods {
public:
    static std::string AppendPlace(const std::string& text, const std::string& value) {
        if (text.empty()) return value;
        return text + "|" + value;
    }

    static std::string AppendParrent(const std::string& text) {
        return "/" + text;
    }

    static std::string ExportToWebFormsTag(const std::string& src) {
        return "<web-forms src=\"" + src + "\"></web-forms>";
    }

    static std::string ExportToWebFormsTag(const std::string& src, int width, int height) {
        return "<web-forms src=\"" + src + "\" width=\"" + std::to_string(width) + "\" height=\"" + std::to_string(height) + "\"></web-forms>";
    }

    static std::string ExportActionControlsToWebFormsTag(const std::string& actionControls) {
        return "<web-forms ac=\"" + actionControls + "\"></web-forms>";
    }

    static std::string RemoveOuter(std::string text, const std::string& startString, const std::string& endString) {
        size_t start = text.find(startString);
        if (start == std::string::npos) return text;
        size_t end = text.find(endString, start);
        if (end == std::string::npos) return text;
        return text.erase(start, end - start + endString.length());
    }
};
