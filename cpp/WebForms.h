// WebForms.h 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.1

#pragma once

#include <string>
#include <vector>
#include <functional>
#include <utility>
#include <cstddef>

namespace WebFormsCore
{

namespace detail
{

inline std::vector<std::string> split(const std::string& str, char delim)
{
    std::vector<std::string> result;
    std::string current;
    for (char c : str)
    {
        if (c == delim)
        {
            result.push_back(current);
            current.clear();
        }
        else
        {
            current += c;
        }
    }
    result.push_back(current);
    return result;
}

template <typename Container>
inline std::string join(const Container& parts, const std::string& delim)
{
    std::string result;
    bool first = true;
    for (const auto& p : parts)
    {
        if (!first)
            result += delim;
        result += p;
        first = false;
    }
    return result;
}

inline std::pair<std::string, std::string> splitFirst(const std::string& str, char delim)
{
    auto pos = str.find(delim);
    if (pos == std::string::npos)
        return { str, "" };
    return { str.substr(0, pos), str.substr(pos + 1) };
}

inline std::string replaceAll(std::string str, const std::string& from, const std::string& to)
{
    if (from.empty())
        return str;
    std::size_t pos = 0;
    while ((pos = str.find(from, pos)) != std::string::npos)
    {
        str.replace(pos, from.size(), to);
        pos += to.size();
    }
    return str;
}

inline std::string replaceChar(std::string str, char from, char to)
{
    for (auto& c : str)
        if (c == from)
            c = to;
    return str;
}

inline bool startsWith(const std::string& str, const std::string& prefix)
{
    return str.size() >= prefix.size() && str.compare(0, prefix.size(), prefix) == 0;
}

inline bool endsWith(const std::string& str, const std::string& suffix)
{
    return str.size() >= suffix.size() && str.compare(str.size() - suffix.size(), suffix.size(), suffix) == 0;
}

} // namespace detail

class WebForms
{
private:
    static constexpr char GS = '\x1D';
    static constexpr char US = '\x1F';

    std::string webFormsData_;

    void Add(const std::string& name, const std::string& value)
    {
        if (!webFormsData_.empty())
            webFormsData_.push_back('\n');

        webFormsData_.append(name);
        webFormsData_.push_back('=');
        webFormsData_.append(value);
    }

    void Add(const std::string& name)
    {
        if (!webFormsData_.empty())
            webFormsData_.push_back('\n');

        webFormsData_.append(name);
    }

    void AddToUp(const std::string& name, const std::string& value)
    {
        std::string line = name + "=" + value;

        if (!webFormsData_.empty())
            line += "\n";

        webFormsData_.insert(0, line);
    }

    void AddToUp(const std::string& name)
    {
        std::string line = name;

        if (!webFormsData_.empty())
            line += "\n";

        webFormsData_.insert(0, line);
    }

    std::string GetLineByIndex(int index) const
    {
        if (webFormsData_.empty())
            return "";

        auto lines = detail::split(webFormsData_, '\n');

        if (index < 0)
            index = static_cast<int>(lines.size()) + index;

        if (index < 0 || index >= static_cast<int>(lines.size()))
            return "";

        return lines[index];
    }

    void UpdateLineByIndex(int index, const std::string& name, const std::string& value)
    {
        if (webFormsData_.empty())
            return;

        auto lines = detail::split(webFormsData_, '\n');

        if (index < 0)
            index = static_cast<int>(lines.size()) + index;

        if (index < 0 || index >= static_cast<int>(lines.size()))
            return;

        lines[index] = name + (value.empty() ? "" : "=" + value);

        webFormsData_.clear();
        webFormsData_ = detail::join(lines, "\n");
    }

public:
    // For Extension
    void AddLine(const std::string& name, const std::string& value) { Add(name, value); }

    // Add
    // Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.
    void AddId(const std::string& inputPlace, const std::string& id) { Add("ai" + inputPlace, id); }
    void AddName(const std::string& inputPlace, const std::string& name) { Add("an" + inputPlace, name); }
    void AddValue(const std::string& inputPlace, const std::string& value) { Add("av" + inputPlace, value); }
    void AddClass(const std::string& inputPlace, const std::string& cls) { Add("ac" + inputPlace, cls); }
    void AddStyle(const std::string& inputPlace, const std::string& style) { Add("as" + inputPlace, style); }
    void AddStyle(const std::string& inputPlace, const std::string& name, const std::string& value) { Add("as" + inputPlace, name + ':' + value); }
    void AddOptionTag(const std::string& inputPlace, const std::string& text, const std::string& value, bool selected = false)
    {
        Add("ao" + inputPlace, value + GS + text + (selected ? std::string(1, GS) + "1" : ""));
    }
    void AddCheckBoxTag(const std::string& inputPlace, const std::string& text, const std::string& value, bool checked = false)
    {
        Add("ak" + inputPlace, value + GS + text + (checked ? std::string(1, GS) + "1" : ""));
    }
    void AddTitle(const std::string& inputPlace, const std::string& title) { Add("al" + inputPlace, title); }
    void AddLabel(const std::string& inputPlace, const std::string& label) { Add("aA" + inputPlace, label); }
    void AddText(const std::string& inputPlace, const std::string& text) { Add("at" + inputPlace, detail::replaceAll(text, "\n", "$[ln];")); }
    void AddTextToUp(const std::string& inputPlace, const std::string& text) { Add("pt" + inputPlace, detail::replaceAll(text, "\n", "$[ln];")); }
    void AddAttribute(const std::string& inputPlace, const std::string& attribute, const std::string& value = "", char splitter = '\0')
    {
        Add("aa" + inputPlace, attribute + GS + (splitter != '\0' ? std::string(1, splitter) : "") + (!value.empty() ? std::string(1, GS) + value : ""));
    }
    void AddTag(const std::string& inputPlace, const std::string& tagName, const std::string& id = "")
    {
        Add("nt" + inputPlace, tagName + (!id.empty() ? std::string(1, GS) + id : ""));
    }
    void AddTagToUp(const std::string& inputPlace, const std::string& tagName, const std::string& id = "")
    {
        Add("ut" + inputPlace, tagName + (!id.empty() ? std::string(1, GS) + id : ""));
    }
    void AddTagBefore(const std::string& inputPlace, const std::string& tagName, const std::string& id = "")
    {
        Add("bt" + inputPlace, tagName + (!id.empty() ? std::string(1, GS) + id : ""));
    }
    void AddTagAfter(const std::string& inputPlace, const std::string& tagName, const std::string& id = "")
    {
        Add("ft" + inputPlace, tagName + (!id.empty() ? std::string(1, GS) + id : ""));
    }
    void AddHidden(const std::string& inputPlace, const std::string& name, const std::string& value, const std::string& id = "")
    {
        Add("ah" + inputPlace, name + GS + value + (!id.empty() ? std::string(1, GS) + id : ""));
    }

    // Set
    // Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.
    void SetId(const std::string& inputPlace, const std::string& id) { Add("si" + inputPlace, id); }
    void SetName(const std::string& inputPlace, const std::string& name) { Add("sn" + inputPlace, name); }
    void SetValue(const std::string& inputPlace, const std::string& value) { Add("sv" + inputPlace, value); }
    void SetClass(const std::string& inputPlace, const std::string& cls) { Add("sc" + inputPlace, cls); }
    void SetStyle(const std::string& inputPlace, const std::string& style) { Add("ss" + inputPlace, style); }
    void SetStyle(const std::string& inputPlace, const std::string& name, const std::string& value) { Add("ss" + inputPlace, name + ':' + value); }
    void SetOptionTag(const std::string& inputPlace, const std::string& text, const std::string& value, bool selected = false)
    {
        Add("so" + inputPlace, value + GS + text + (selected ? std::string(1, GS) + "1" : ""));
    }
    void SetChecked(const std::string& inputPlace, bool checked = false) { Add("sk" + inputPlace, checked ? "1" : "0"); }
    void SetCheckBoxTag(const std::string& inputPlace, const std::string& text, const std::string& value, bool checked = false)
    {
        Add("sk" + inputPlace, value + GS + text + (checked ? std::string(1, GS) + "1" : ""));
    }
    void SetTitle(const std::string& inputPlace, const std::string& title) { Add("sl" + inputPlace, title); }
    void SetLabel(const std::string& inputPlace, const std::string& label) { Add("sA" + inputPlace, label); }
    void SetText(const std::string& inputPlace, const std::string& text) { Add("st" + inputPlace, detail::replaceAll(text, "\n", "$[ln];")); }
    void SetAttribute(const std::string& inputPlace, const std::string& attribute, const std::string& value = "")
    {
        Add("sa" + inputPlace, attribute + GS + (!value.empty() ? std::string(1, GS) + value : ""));
    }
    void SetWidth(const std::string& inputPlace, const std::string& width) { Add("sw" + inputPlace, width); }
    void SetWidth(const std::string& inputPlace, int width) { SetWidth(inputPlace, std::to_string(width) + "px"); }
    void SetHeight(const std::string& inputPlace, const std::string& height) { Add("sh" + inputPlace, height); }
    void SetHeight(const std::string& inputPlace, int height) { SetHeight(inputPlace, std::to_string(height) + "px"); }
    void SetBackgroundColor(const std::string& inputPlace, const std::string& color) { Add("bc" + inputPlace, color); }
    void SetTextColor(const std::string& inputPlace, const std::string& color) { Add("tc" + inputPlace, color); }
    void SetFontName(const std::string& inputPlace, const std::string& name) { Add("fn" + inputPlace, name); }
    void SetFontSize(const std::string& inputPlace, const std::string& size) { Add("fs" + inputPlace, size); }
    void SetFontSize(const std::string& inputPlace, int size) { Add("fs" + inputPlace, std::to_string(size) + "px"); }
    void SetFontBold(const std::string& inputPlace, bool bold) { Add("fb" + inputPlace, bold ? "1" : "0"); }
    void SetVisible(const std::string& inputPlace, bool visible) { Add("vi" + inputPlace, visible ? "1" : "0"); }
    void SetTextAlign(const std::string& inputPlace, const std::string& align) { Add("ta" + inputPlace, align); }
    void SetReadOnly(const std::string& inputPlace, bool readOnly) { Add("sr" + inputPlace, readOnly ? "1" : "0"); }
    void SetDisabled(const std::string& inputPlace, bool disabled) { Add("sd" + inputPlace, disabled ? "1" : "0"); }
    void SetFocus(const std::string& inputPlace, bool focus) { Add("sf" + inputPlace, focus ? "1" : "0"); }
    void SetMinLength(const std::string& inputPlace, const std::string& length) { Add("mn" + inputPlace, length); }
    void SetMinLength(const std::string& inputPlace, int length) { SetMinLength(inputPlace, std::to_string(length)); }
    void SetMaxLength(const std::string& inputPlace, const std::string& length) { Add("mx" + inputPlace, length); }
    void SetMaxLength(const std::string& inputPlace, int length) { SetMaxLength(inputPlace, std::to_string(length)); }
    void SetSelectedValue(const std::string& inputPlace, const std::string& value) { Add("ts" + inputPlace, value); }
    void SetSelectedIndex(const std::string& inputPlace, const std::string& index) { Add("ti" + inputPlace, index); }
    void SetSelectedIndex(const std::string& inputPlace, int index) { SetSelectedIndex(inputPlace, std::to_string(index)); }
    void SetCheckedValue(const std::string& inputPlace, const std::string& value, bool checked) { Add("ks" + inputPlace, value + GS + (checked ? "1" : "0")); }
    void SetCheckedIndex(const std::string& inputPlace, const std::string& index, bool checked) { Add("ki" + inputPlace, index + GS + (checked ? "1" : "0")); }
    void SetCheckedIndex(const std::string& inputPlace, int index, bool checked) { SetCheckedIndex(inputPlace, std::to_string(index), checked); }

    // Insert
    // Creates the Data only if it does not exist; otherwise, does nothing.
    void InsertId(const std::string& inputPlace, const std::string& id) { Add("ii" + inputPlace, id); }
    void InsertName(const std::string& inputPlace, const std::string& name) { Add("in" + inputPlace, name); }
    void InsertValue(const std::string& inputPlace, const std::string& value) { Add("iv" + inputPlace, value); }
    void InsertClass(const std::string& inputPlace, const std::string& cls) { Add("ic" + inputPlace, cls); }
    void InsertStyle(const std::string& inputPlace, const std::string& style) { Add("is" + inputPlace, style); }
    void InsertStyle(const std::string& inputPlace, const std::string& name, const std::string& value) { Add("is" + inputPlace, name + ':' + value); }
    void InsertOptionTag(const std::string& inputPlace, const std::string& text, const std::string& value, bool selected = false)
    {
        Add("io" + inputPlace, value + GS + text + (selected ? std::string(1, GS) + "1" : ""));
    }
    void InsertCheckBoxTag(const std::string& inputPlace, const std::string& text, const std::string& value, bool checked = false)
    {
        Add("ik" + inputPlace, value + GS + text + (checked ? std::string(1, GS) + "1" : ""));
    }
    void InsertTitle(const std::string& inputPlace, const std::string& title) { Add("il" + inputPlace, title); }
    void InsertLabel(const std::string& inputPlace, const std::string& label) { Add("iA" + inputPlace, label); }
    void InsertText(const std::string& inputPlace, const std::string& text) { Add("it" + inputPlace, detail::replaceAll(text, "\n", "$[ln];")); }
    void InsertAttribute(const std::string& inputPlace, const std::string& attribute, const std::string& value = "", char splitter = '\0')
    {
        Add("ia" + inputPlace, attribute + GS + (splitter != '\0' ? std::string(1, splitter) : "") + (!value.empty() ? std::string(1, GS) + value : ""));
    }

    // Delete
    void DeleteId(const std::string& inputPlace) { Add("di" + inputPlace); }
    void DeleteName(const std::string& inputPlace) { Add("dn" + inputPlace); }
    void DeleteValue(const std::string& inputPlace) { Add("dv" + inputPlace); }
    void DeleteClass(const std::string& inputPlace, const std::string& className) { Add("dc" + inputPlace, className); }
    void DeleteStyle(const std::string& inputPlace, const std::string& styleName) { Add("ds" + inputPlace, styleName); }
    void DeleteOptionTag(const std::string& inputPlace, const std::string& value) { Add("do" + inputPlace, value); }
    void DeleteAllOptionTag(const std::string& inputPlace) { Add("do" + inputPlace, "*"); }
    void DeleteCheckBoxTag(const std::string& inputPlace, const std::string& value) { Add("dk" + inputPlace, value); }
    void DeleteAllCheckBoxTag(const std::string& inputPlace) { Add("dk" + inputPlace, "*"); }
    void DeleteTitle(const std::string& inputPlace) { Add("dl" + inputPlace); }
    void DeleteLabel(const std::string& inputPlace) { Add("dA" + inputPlace); }
    void DeleteText(const std::string& inputPlace) { Add("dt" + inputPlace); }
    void DeleteAttribute(const std::string& inputPlace, const std::string& attribute) { Add("da" + inputPlace, attribute); }
    void Delete(const std::string& inputPlace) { Add("de" + inputPlace); }
    void DeleteParent(const std::string& inputPlace) { Add("dp" + inputPlace); }

    // Tag
    void SwapTag(const std::string& inputPlace, const std::string& outputPlace) { Add("sp" + inputPlace, outputPlace); }
    void SetReflection(const std::string& inputPlace, const std::string& tag) { Add("sR" + inputPlace, tag); }
    void SetReflectionByOutputPlace(const std::string& inputPlace, const std::string& outputPlace) { Add("iR" + inputPlace, outputPlace); }
    void SetMorph(const std::string& inputPlace, const std::string& tag) { Add("sM" + inputPlace, tag); }
    void SetMorphByOutputPlace(const std::string& inputPlace, const std::string& outputPlace) { Add("iM" + inputPlace, outputPlace); }

    // Browser
    void ChangeUrl(const std::string& url) { Add("cu", url); }
    void SetHeadTitle(const std::string& title) { Add("ht", title); }
    void ClipboardWriteText(const std::string& text) { Add("nw", text); }
    void ScrollTo(const std::string& x, const std::string& y) { Add("ws", x + GS + y); }
    void ScrollTo(int x, int y) { ScrollTo(std::to_string(x), std::to_string(y)); }
    void HistoryGo(const std::string& steps) { Add("wg", steps); }
    void HistoryGo(int steps) { HistoryGo(std::to_string(steps)); }
    void ReloadPage() { Add("lr"); }
    void Redirect(const std::string& path) { Add("lh", path); }

    // Increase
    void IncreaseMinLength(const std::string& inputPlace, const std::string& value) { Add("+n" + inputPlace, value); }
    void IncreaseMinLength(const std::string& inputPlace, int value) { IncreaseMinLength(inputPlace, std::to_string(value)); }
    void IncreaseMaxLength(const std::string& inputPlace, const std::string& value) { Add("+x" + inputPlace, value); }
    void IncreaseMaxLength(const std::string& inputPlace, int value) { IncreaseMaxLength(inputPlace, std::to_string(value)); }
    void IncreaseFontSize(const std::string& inputPlace, const std::string& value) { Add("+f" + inputPlace, value); }
    void IncreaseFontSize(const std::string& inputPlace, int value) { IncreaseFontSize(inputPlace, std::to_string(value)); }
    void IncreaseWidth(const std::string& inputPlace, const std::string& value) { Add("+w" + inputPlace, value); }
    void IncreaseWidth(const std::string& inputPlace, int value) { IncreaseWidth(inputPlace, std::to_string(value)); }
    void IncreaseHeight(const std::string& inputPlace, const std::string& value) { Add("+h" + inputPlace, value); }
    void IncreaseHeight(const std::string& inputPlace, int value) { IncreaseHeight(inputPlace, std::to_string(value)); }
    void IncreaseValue(const std::string& inputPlace, const std::string& value) { Add("+v" + inputPlace, value); }
    void IncreaseValue(const std::string& inputPlace, int value) { IncreaseValue(inputPlace, std::to_string(value)); }

    // Decrease
    void DecreaseMinLength(const std::string& inputPlace, const std::string& value) { Add("-n" + inputPlace, value); }
    void DecreaseMinLength(const std::string& inputPlace, int value) { DecreaseMinLength(inputPlace, std::to_string(value)); }
    void DecreaseMaxLength(const std::string& inputPlace, const std::string& value) { Add("-x" + inputPlace, value); }
    void DecreaseMaxLength(const std::string& inputPlace, int value) { DecreaseMaxLength(inputPlace, std::to_string(value)); }
    void DecreaseFontSize(const std::string& inputPlace, const std::string& value) { Add("-f" + inputPlace, value); }
    void DecreaseFontSize(const std::string& inputPlace, int value) { DecreaseFontSize(inputPlace, std::to_string(value)); }
    void DecreaseWidth(const std::string& inputPlace, const std::string& value) { Add("-w" + inputPlace, value); }
    void DecreaseWidth(const std::string& inputPlace, int value) { DecreaseWidth(inputPlace, std::to_string(value)); }
    void DecreaseHeight(const std::string& inputPlace, const std::string& value) { Add("-h" + inputPlace, value); }
    void DecreaseHeight(const std::string& inputPlace, int value) { DecreaseHeight(inputPlace, std::to_string(value)); }
    void DecreaseValue(const std::string& inputPlace, const std::string& value) { Add("-v" + inputPlace, value); }
    void DecreaseValue(const std::string& inputPlace, int value) { DecreaseValue(inputPlace, std::to_string(value)); }

    // Event
    // ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
    // All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.
    void TriggerEvent(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& constructorName = "")
    {
        Add("TE" + inputPlace, htmlEventListener + (!constructorName.empty() ? std::string(1, GS) + constructorName : ""));
    }
    void SetPostEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Ep" + inputPlace, htmlEvent); }
    void SetPostEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& outputPlace)
    {
        Add("Ep" + inputPlace, htmlEvent + GS + outputPlace);
    }
    void SetPostEventAddView(const std::string& inputPlace, const std::string& htmlEvent) { Add("Ep" + inputPlace, htmlEvent + GS + "+"); }
    void SetPostEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("EP" + inputPlace, htmlEventListener); }
    void SetPostEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& outputPlace)
    {
        Add("EP" + inputPlace, htmlEventListener + GS + outputPlace);
    }
    void SetPostEventListenerAddView(const std::string& inputPlace, const std::string& htmlEventListener) { Add("EP" + inputPlace, htmlEventListener + GS + "+"); }
    void SetGetEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& path = "")
    {
        Add("Eg" + inputPlace, htmlEvent + GS + (!path.empty() ? path : "#"));
    }
    void SetGetEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& outputPlace, const std::string& path)
    {
        Add("Eg" + inputPlace, htmlEvent + GS + (!path.empty() ? path : "#") + GS + outputPlace);
    }
    void SetGetEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& path = "")
    {
        Add("EG" + inputPlace, htmlEventListener + GS + (!path.empty() ? path : "#"));
    }
    void SetGetEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& outputPlace, const std::string& path)
    {
        Add("EG" + inputPlace, htmlEventListener + GS + (!path.empty() ? path : "#") + GS + outputPlace);
    }
    void SetPutEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& path = "")
    {
        Add("Et" + inputPlace, htmlEvent + GS + (!path.empty() ? path : "#"));
    }
    void SetPutEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& outputPlace, const std::string& path)
    {
        Add("Et" + inputPlace, htmlEvent + GS + (!path.empty() ? path : "#") + GS + outputPlace);
    }
    void SetPutEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& path = "")
    {
        Add("ET" + inputPlace, htmlEventListener + GS + (!path.empty() ? path : "#"));
    }
    void SetPutEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& outputPlace, const std::string& path)
    {
        Add("ET" + inputPlace, htmlEventListener + GS + (!path.empty() ? path : "#") + GS + outputPlace);
    }
    void SetPatchEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& path = "")
    {
        Add("Ea" + inputPlace, htmlEvent + GS + (!path.empty() ? path : "#"));
    }
    void SetPatchEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& outputPlace, const std::string& path)
    {
        Add("Ea" + inputPlace, htmlEvent + GS + (!path.empty() ? path : "#") + GS + outputPlace);
    }
    void SetPatchEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& path = "")
    {
        Add("EA" + inputPlace, htmlEventListener + GS + (!path.empty() ? path : "#"));
    }
    void SetPatchEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& outputPlace, const std::string& path)
    {
        Add("EA" + inputPlace, htmlEventListener + GS + (!path.empty() ? path : "#") + GS + outputPlace);
    }
    void SetDeleteEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& path = "")
    {
        Add("El" + inputPlace, htmlEvent + GS + (!path.empty() ? path : "#"));
    }
    void SetDeleteEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& outputPlace, const std::string& path)
    {
        Add("El" + inputPlace, htmlEvent + GS + (!path.empty() ? path : "#") + GS + outputPlace);
    }
    void SetDeleteEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& path = "")
    {
        Add("EL" + inputPlace, htmlEventListener + GS + (!path.empty() ? path : "#"));
    }
    void SetDeleteEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& outputPlace, const std::string& path)
    {
        Add("EL" + inputPlace, htmlEventListener + GS + (!path.empty() ? path : "#") + GS + outputPlace);
    }
    void SetOptionsEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& path = "")
    {
        Add("Eo" + inputPlace, htmlEvent + GS + (!path.empty() ? path : "#"));
    }
    void SetOptionsEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& outputPlace, const std::string& path)
    {
        Add("Eo" + inputPlace, htmlEvent + GS + (!path.empty() ? path : "#") + GS + outputPlace);
    }
    void SetOptionsEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& path = "")
    {
        Add("EO" + inputPlace, htmlEventListener + GS + (!path.empty() ? path : "#"));
    }
    void SetOptionsEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& outputPlace, const std::string& path)
    {
        Add("EO" + inputPlace, htmlEventListener + GS + (!path.empty() ? path : "#") + GS + outputPlace);
    }
    void SetHeadEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& path = "")
    {
        Add("Eh" + inputPlace, htmlEvent + GS + (!path.empty() ? path : "#"));
    }
    void SetHeadEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& path = "")
    {
        Add("EH" + inputPlace, htmlEventListener + GS + (!path.empty() ? path : "#"));
    }
    // IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
    void SetSendEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& data,
                      const std::string& path = "", const std::string& method = "POST",
                      bool isMultiPart = false, const std::string& contentType = "text/plain",
                      const std::string& outputPlace = "")
    {
        std::string transformed = detail::replaceAll(data, "\n", "$[ln];");
        transformed = detail::replaceAll(transformed, "\"", "$[dq];");
        transformed = detail::replaceAll(transformed, "'", "$[sq];");
        Add("En" + inputPlace, htmlEvent + GS + transformed + GS + (!path.empty() ? path : "#") + GS + method + GS + (isMultiPart ? "1" : "0") + GS + contentType + GS + outputPlace);
    }
    void SetSendEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& data,
                              const std::string& path = "", const std::string& method = "POST",
                              bool isMultiPart = false, const std::string& contentType = "text/plain",
                              const std::string& outputPlace = "")
    {
        std::string transformed = detail::replaceAll(data, "\n", "$[ln];");
        Add("EN" + inputPlace, htmlEventListener + GS + transformed + GS + (!path.empty() ? path : "#") + GS + method + GS + (isMultiPart ? "1" : "0") + GS + contentType + GS + outputPlace);
    }
    void SetCommentEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& index = "", const std::string& outputPlace = "")
    {
        Add("Eb" + inputPlace, htmlEvent + GS + index + GS + outputPlace);
    }
    void SetCommentEvent(const std::string& inputPlace, const std::string& htmlEvent, int index, const std::string& outputPlace = "")
    {
        SetCommentEvent(inputPlace, htmlEvent, std::to_string(index), outputPlace);
    }
    void SetCommentEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& index = "", const std::string& outputPlace = "")
    {
        Add("EB" + inputPlace, htmlEventListener + GS + index + GS + outputPlace);
    }
    void SetCommentEventListener(const std::string& inputPlace, const std::string& htmlEventListener, int index, const std::string& outputPlace = "")
    {
        SetCommentEventListener(inputPlace, htmlEventListener, std::to_string(index), outputPlace);
    }
    void SetWasmEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& wasmLanguage,
                      const std::string& wasmUrl, const std::string& methodName,
                      const std::vector<std::string>& args = {}, const std::string& outputPlace = "")
    {
        std::string argsJoin = "";

        if (!args.empty())
            argsJoin = "[" + detail::join(args, std::string(1, US));

        Add("Ey" + inputPlace, htmlEvent + GS + wasmLanguage + GS + wasmUrl + GS + methodName + GS + argsJoin + GS + outputPlace);
    }
    void SetWasmEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& wasmLanguage,
                              const std::string& wasmUrl, const std::string& methodName,
                              const std::vector<std::string>& args = {}, const std::string& outputPlace = "")
    {
        std::string argsJoin = "";

        if (!args.empty())
            argsJoin = "[" + detail::join(args, std::string(1, US));

        Add("EY" + inputPlace, htmlEventListener + GS + wasmLanguage + GS + wasmUrl + GS + methodName + GS + argsJoin + GS + outputPlace);
    }
    void SetWebSocketEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& path)
    {
        Add("Ew" + inputPlace, htmlEvent + GS + path);
    }
    void SetWebSocketEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& path)
    {
        Add("EW" + inputPlace, htmlEventListener + GS + path);
    }
    void SetSSEEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& path,
                     bool shouldReconnect = true, int reconnectTryTimeout = 3000)
    {
        Add("Ee" + inputPlace, htmlEvent + GS + path + GS + (shouldReconnect ? "1" : "0") + GS + std::to_string(reconnectTryTimeout));
    }
    void SetSSEEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& path,
                     const std::string& outputPlace, bool shouldReconnect = true, int reconnectTryTimeout = 3000)
    {
        Add("Ee" + inputPlace, htmlEvent + GS + path + GS + (shouldReconnect ? "1" : "0") + GS + std::to_string(reconnectTryTimeout) + GS + outputPlace);
    }
    void SetSSEEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& path,
                             bool shouldReconnect = true, int reconnectTryTimeout = 3000)
    {
        Add("EE" + inputPlace, htmlEventListener + GS + path + GS + (shouldReconnect ? "1" : "0") + GS + std::to_string(reconnectTryTimeout));
    }
    void SetSSEEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& path,
                             const std::string& outputPlace, bool shouldReconnect = true, int reconnectTryTimeout = 3000)
    {
        Add("EE" + inputPlace, htmlEventListener + GS + path + GS + (shouldReconnect ? "1" : "0") + GS + std::to_string(reconnectTryTimeout) + GS + outputPlace);
    }
    void SetFrontEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& modulePath,
                       const std::vector<std::string>& args = {}, const std::string& outputPlace = "")
    {
        std::string argsJoin = "";

        if (!args.empty())
            argsJoin = std::string(1, GS) + "[" + detail::join(args, std::string(1, US));

        Add("Ej" + inputPlace, htmlEvent + GS + modulePath + GS + outputPlace + argsJoin);
    }
    void SetFrontEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& modulePath,
                               const std::vector<std::string>& args = {}, const std::string& outputPlace = "")
    {
        std::string argsJoin = "";

        if (!args.empty())
            argsJoin = std::string(1, GS) + "[" + detail::join(args, std::string(1, US));

        Add("EJ" + inputPlace, htmlEventListener + GS + modulePath + GS + outputPlace + argsJoin);
    }
    void SetMasterPagesEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& outputPlace = "")
    {
        Add("Eu" + inputPlace, htmlEvent + GS + outputPlace);
    }
    void SetMasterPagesEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& outputPlace = "")
    {
        Add("EU" + inputPlace, htmlEventListener + GS + outputPlace);
    }
    void SetPreventDefaultEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Ed" + inputPlace, htmlEvent); }
    void SetPreventDefaultEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("ED" + inputPlace, htmlEventListener); }
    void SetStopPropagationEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Es" + inputPlace, htmlEvent); }
    void SetStopPropagationEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("ES" + inputPlace, htmlEventListener); }
    void SetMethodEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& methodName,
                        const std::vector<std::string>& args = {})
    {
        std::string argsJoin = "";

        if (!args.empty())
            argsJoin = std::string(1, GS) + "[" + detail::join(args, std::string(1, US));

        Add("Em" + inputPlace, htmlEvent + GS + methodName + argsJoin);
    }
    void SetMethodEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& methodName,
                                const std::vector<std::string>& args = {})
    {
        std::string argsJoin = "";

        if (!args.empty())
            argsJoin = std::string(1, GS) + "[" + detail::join(args, std::string(1, US));

        Add("EM" + inputPlace, htmlEventListener + GS + methodName + argsJoin);
    }
    void SetModuleMethodEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& methodName,
                              const std::vector<std::string>& args = {})
    {
        std::string argsJoin = "";

        if (!args.empty())
            argsJoin = std::string(1, GS) + "[" + detail::join(args, std::string(1, US));

        Add("Ex" + inputPlace, htmlEvent + GS + methodName + argsJoin);
    }
    void SetModuleMethodEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& methodName,
                                      const std::vector<std::string>& args = {})
    {
        std::string argsJoin = "";

        if (!args.empty())
            argsJoin = std::string(1, GS) + "[" + detail::join(args, std::string(1, US));

        Add("EX" + inputPlace, htmlEventListener + GS + methodName + argsJoin);
    }
    void AssignConfirmEvent(const std::string& inputPlace, const std::string& htmlEvent,
                            const std::string& text = "Are you sure you want to proceed?",
                            const std::string& type = "none",
                            const std::string& title = "Confirm",
                            const std::string& okText = "OK",
                            const std::string& cancelText = "Cancel")
    {
        Add("Ef" + inputPlace, htmlEvent + GS
            + (text == "Are you sure you want to proceed?" ? "" : text) + GS
            + (type == "none" ? "" : type) + GS
            + (title == "Confirm" ? "" : title) + GS
            + (okText == "OK" ? "" : okText) + GS
            + (cancelText == "Cancel" ? "" : cancelText));
    }
    void RemovePostEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Rp" + inputPlace, htmlEvent); }
    void RemovePostEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RP" + inputPlace, htmlEventListener); }
    void RemoveGetEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Rg" + inputPlace, htmlEvent); }
    void RemoveGetEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RG" + inputPlace, htmlEventListener); }
    void RemovePutEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Rt" + inputPlace, htmlEvent); }
    void RemovePutEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RT" + inputPlace, htmlEventListener); }
    void RemovePatchEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Ra" + inputPlace, htmlEvent); }
    void RemovePatchEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RA" + inputPlace, htmlEventListener); }
    void RemoveDeleteEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Rl" + inputPlace, htmlEvent); }
    void RemoveDeleteEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RL" + inputPlace, htmlEventListener); }
    void RemoveOptionsEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Ro" + inputPlace, htmlEvent); }
    void RemoveOptionsEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RO" + inputPlace, htmlEventListener); }
    void RemoveHeadEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Rh" + inputPlace, htmlEvent); }
    void RemoveHeadEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RH" + inputPlace, htmlEventListener); }
    void RemoveSendEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Rn" + inputPlace, htmlEvent); }
    void RemoveSendEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RN" + inputPlace, htmlEventListener); }
    void RemoveCommentEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Rb" + inputPlace, htmlEvent); }
    void RemoveCommentEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RB" + inputPlace, htmlEventListener); }
    void RemoveWasmEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Ry" + inputPlace, htmlEvent); }
    void RemoveWasmEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RY" + inputPlace, htmlEventListener); }
    void RemoveWebSocketEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Rw" + inputPlace, htmlEvent); }
    void RemoveWebSocketEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RW" + inputPlace, htmlEventListener); }
    void RemoveSSEEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Re" + inputPlace, htmlEvent); }
    void RemoveSSEEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RE" + inputPlace, htmlEventListener); }
    void RemoveFrontEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Rj" + inputPlace, htmlEvent); }
    void RemoveFrontEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RJ" + inputPlace, htmlEventListener); }
    void RemovePreventDefaultEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Rd" + inputPlace, htmlEvent); }
    void RemovePreventDefaultEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RD" + inputPlace, htmlEventListener); }
    void RemoveMasterPagesEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Ru" + inputPlace, htmlEvent); }
    void RemoveMasterPagesEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RU" + inputPlace, htmlEventListener); }
    void RemoveStopPropagationEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Rs" + inputPlace, htmlEvent); }
    void RemoveStopPropagationEventListener(const std::string& inputPlace, const std::string& htmlEventListener) { Add("RS" + inputPlace, htmlEventListener); }
    void RemoveMethodEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& methodName)
    {
        Add("Rm" + inputPlace, htmlEvent + GS + methodName);
    }
    void RemoveMethodEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& methodName)
    {
        Add("RM" + inputPlace, htmlEventListener + GS + methodName);
    }
    void RemoveModuleMethodEvent(const std::string& inputPlace, const std::string& htmlEvent, const std::string& methodName)
    {
        Add("Rx" + inputPlace, htmlEvent + GS + methodName);
    }
    void RemoveModuleMethodEventListener(const std::string& inputPlace, const std::string& htmlEventListener, const std::string& methodName)
    {
        Add("RX" + inputPlace, htmlEventListener + GS + methodName);
    }
    void RemoveConfirmEvent(const std::string& inputPlace, const std::string& htmlEvent) { Add("Rf" + inputPlace, htmlEvent); }

    // Custom Event
    // This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
    // Watch: attribute, style, text, children, value
    // Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
    // Range: Only Use For Compare With inrange Value. Split By Comma ","
    // Key: Only Use For Watch With attribute And style Value
    void CreateCustomDOMEvent(const std::string& inputPlace, const std::string& eventName,
                              const std::string& watch, const std::string& key,
                              const std::string& compare, const std::string& value,
                              const std::string& range, bool immediate = false, const std::string& delay = "0")
    {
        Add("eC" + inputPlace, eventName + GS + watch + GS + key + GS + compare + GS + value + GS + range + GS + (immediate ? "1" : "0") + GS + delay);
    }
    void CreateCustomDOMEvent(const std::string& inputPlace, const std::string& eventName,
                              const std::string& watch, const std::string& key,
                              const std::string& compare, const std::string& value,
                              const std::string& range, bool immediate, int delay)
    {
        CreateCustomDOMEvent(inputPlace, eventName, watch, key, compare, value, range, immediate, std::to_string(delay));
    }
    void EnableScrollBottomEvent(bool enable = true) { Add("eb", enable ? "1" : "0"); }
    void EnableReachedElementEvent(const std::string& inputPlace, bool once, bool enable = true)
    {
        Add("er" + inputPlace, std::string(once ? "1" : "0") + GS + (enable ? "1" : "0"));
    }

    // Module
    void LoadModule(const std::string& modulePath, const std::vector<std::string>& methods = {})
    {
        Add("Ml", modulePath + (!methods.empty() ? std::string(1, GS) + "[" + detail::join(methods, std::string(1, US)) : ""));
    }
    void UnloadModule(const std::string& modulePath) { Add("Mu", modulePath); }
    void DeleteModuleMethod(const std::string& methodName) { Add("Md", methodName); }

    // Unit Testing
    // InputPlace Is Actual, Expected Is Tag/OutputPlace
    void AssertEqual(const std::string& inputPlace, const std::string& tag)
    {
        Add("At" + inputPlace, detail::replaceAll(tag, "\n", "$[ln];"));
    }
    void AssertEqualByOutputPlace(const std::string& inputPlace, const std::string& outputPlace)
    {
        Add("Ao" + inputPlace, outputPlace);
    }

    // Debug
    void CreateDebugger(bool pause = false) { Add("Dc", pause ? "1" : "0"); }

    // Service Worker
    // To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
    void ServiceWorkerRegister(const std::string& path = "", const std::string& scopePath = "") { Add("wR", path + GS + scopePath); }
    void ServiceWorkerPreCacheStatic(const std::vector<std::string>& pathList) { Add("wp", detail::join(pathList, std::string(1, GS))); }
    void ServiceWorkerDynamicCache(const std::string& path, const std::string& seconds = "")
    {
        Add("wc", path + (!seconds.empty() ? std::string(1, GS) + seconds : ""));
    }
    void ServiceWorkerDynamicCache(const std::string& path, int seconds)
    {
        ServiceWorkerDynamicCache(path, seconds > 0 ? std::to_string(seconds) : "");
    }
    void ServiceWorkerDeleteDynamicCache() { Add("wd"); }
    void ServiceWorkerDeleteDynamicCache(const std::string& path) { Add("wd", path); }
    void ServiceWorkerDynamicCacheTTLUpdate(const std::string& path, const std::string& seconds = "")
    {
        Add("wt", path + (!seconds.empty() ? std::string(1, GS) + seconds : ""));
    }
    void ServiceWorkerDynamicCacheTTLUpdate(const std::string& path, int seconds)
    {
        ServiceWorkerDynamicCacheTTLUpdate(path, seconds > 0 ? std::to_string(seconds) : "");
    }
    // Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
    // Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
    // CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
    void ServiceWorkerRouteSet(const std::string& path, const std::string& type, bool cacheDynamic = false)
    {
        Add("wr", path + GS + type + (cacheDynamic ? std::string(1, GS) + "1" : ""));
    }
    void ServiceWorkerRouteAlias(const std::string& path, const std::string& to) { Add("wa", path + GS + to); }
    void ServiceWorkerDeleteRouteAlias(const std::string& path = "") { Add("wC", path); }
    // Delete All Route And Alias
    void ServiceWorkerDeleteRoute() { Add("wD"); }
    void ServiceWorkerDeleteRoute(const std::string& path) { Add("wD", path); }

    // SSE
    void DisconnectSSE(const std::string& path) { Add("Ds", path); }
    void DisconnectAllSSE() { Add("Ds"); }

    // State
    void AddState(const std::string& path = "", const std::string& title = "") { Add("AS", path + GS + title); }
    void SaveState(const std::string& path = "", const std::string& title = "") { Add("As", path + GS + title); }
    void LoadState(const std::string& path) { Add("ls", path); }
    void DeleteState(const std::string& path = "") { Add("DS", path); }
    void DeleteAllState() { Add("DS", "*"); }

    // Cookie
    void SetCookie(const std::string& key, const std::string& value, const std::string& seconds, const std::string& path = "")
    {
        Add("sC", key + GS + value + GS + seconds + (!path.empty() ? std::string(1, GS) + path : ""));
    }
    void SetCookie(const std::string& key, const std::string& value, int seconds, const std::string& path = "")
    {
        SetCookie(key, value, std::to_string(seconds), path);
    }

    // Save (Session Cache)
    void SaveId(const std::string& inputPlace, const std::string& key = ".") { Add("@gi" + inputPlace, key); }
    void SaveName(const std::string& inputPlace, const std::string& key = ".") { Add("@gn" + inputPlace, key); }
    void SaveValue(const std::string& inputPlace, const std::string& key = ".") { Add("@gv" + inputPlace, key); }
    void SaveValueLength(const std::string& inputPlace, const std::string& key = ".") { Add("@ge" + inputPlace, key); }
    void SaveClass(const std::string& inputPlace, const std::string& key = ".") { Add("@gc" + inputPlace, key); }
    void SaveStyle(const std::string& inputPlace, const std::string& key = ".") { Add("@gs" + inputPlace, key); }
    void SaveTitle(const std::string& inputPlace, const std::string& key = ".") { Add("@gl" + inputPlace, key); }
    void SaveLabel(const std::string& inputPlace, const std::string& key = ".") { Add("@gA" + inputPlace, key); }
    void SaveText(const std::string& inputPlace, const std::string& key = ".") { Add("@gt" + inputPlace, key); }
    void SaveOuterText(const std::string& inputPlace, const std::string& key = ".") { Add("@go" + inputPlace, key); }
    void SaveTextLength(const std::string& inputPlace, const std::string& key = ".") { Add("@gg" + inputPlace, key); }
    void SaveAttribute(const std::string& inputPlace, const std::string& attribute, const std::string& key = ".")
    {
        Add("@ga" + inputPlace, key + GS + attribute);
    }
    void SaveWidth(const std::string& inputPlace, const std::string& key = ".") { Add("@gw" + inputPlace, key); }
    void SaveHeight(const std::string& inputPlace, const std::string& key = ".") { Add("@gh" + inputPlace, key); }
    void SaveReadOnly(const std::string& inputPlace, const std::string& key = ".") { Add("@gr" + inputPlace, key); }
    void SaveSelectedIndex(const std::string& inputPlace, const std::string& key = ".") { Add("@gx" + inputPlace, key); }
    void SaveTextAlign(const std::string& inputPlace, const std::string& key = ".") { Add("@gT" + inputPlace, key); }
    void SaveNodeLength(const std::string& inputPlace, const std::string& key = ".") { Add("@gL" + inputPlace, key); }
    void SaveVisible(const std::string& inputPlace, const std::string& key = ".") { Add("@gV" + inputPlace, key); }
    void SaveUrl(const std::string& url, bool fetchScript = false, const std::string& key = ".")
    {
        Add("@gu", key + GS + url + (fetchScript ? std::string(1, GS) + "1" : ""));
    }
    void SaveIndex(const std::string& inputPlace, const std::string& key = ".") { Add("@gI" + inputPlace, key); }
    void RemoveSave(const std::string& cacheKey) { Add("rs", cacheKey); }
    void RemoveAllSave() { Add("rs", "*"); }
    // Calling the SetSave Method Causes Action Control Requests Triggered by Events Using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send Event, to be Temporarily Saved on the Active Page, so the Request will not be Sent to the Server Again.
    void SetSave() { Add("cs", "*"); }
    void AddSaveValue(const std::string& cacheKey, const std::string& value)
    {
        Add("SA", cacheKey + GS + detail::replaceAll(value, "\n", "$[ln];"));
    }
    void InsertSaveValue(const std::string& cacheKey, const std::string& value)
    {
        Add("SI", cacheKey + GS + detail::replaceAll(value, "\n", "$[ln];"));
    }
    void AppendSaveValue(const std::string& cacheKey, const std::string& value)
    {
        Add("SP", cacheKey + GS + detail::replaceAll(value, "\n", "$[ln];"));
    }
    void ReplaceSaveValue(const std::string& cacheKey, const std::string& searchValue, const std::string& value)
    {
        Add("SR", cacheKey + GS + detail::replaceAll(value, "\n", "$[ln];") + GS + detail::replaceAll(searchValue, "\n", "$[ln];"));
    }

    // Cache
    void CacheId(const std::string& inputPlace, const std::string& key = ".") { Add("@ci" + inputPlace, key); }
    void CacheName(const std::string& inputPlace, const std::string& key = ".") { Add("@cn" + inputPlace, key); }
    void CacheValue(const std::string& inputPlace, const std::string& key = ".") { Add("@cv" + inputPlace, key); }
    void CacheValueLength(const std::string& inputPlace, const std::string& key = ".") { Add("@ce" + inputPlace, key); }
    void CacheClass(const std::string& inputPlace, const std::string& key = ".") { Add("@cc" + inputPlace, key); }
    void CacheStyle(const std::string& inputPlace, const std::string& key = ".") { Add("@cs" + inputPlace, key); }
    void CacheTitle(const std::string& inputPlace, const std::string& key = ".") { Add("@cl" + inputPlace, key); }
    void CacheLabel(const std::string& inputPlace, const std::string& key = ".") { Add("@cA" + inputPlace, key); }
    void CacheText(const std::string& inputPlace, const std::string& key = ".") { Add("@ct" + inputPlace, key); }
    void CacheOuterText(const std::string& inputPlace, const std::string& key = ".") { Add("@co" + inputPlace, key); }
    void CacheTextLength(const std::string& inputPlace, const std::string& key = ".") { Add("@cg" + inputPlace, key); }
    void CacheAttribute(const std::string& inputPlace, const std::string& attribute, const std::string& key = ".")
    {
        Add("@ca" + inputPlace, key + GS + attribute);
    }
    void CacheWidth(const std::string& inputPlace, const std::string& key = ".") { Add("@cw" + inputPlace, key); }
    void CacheHeight(const std::string& inputPlace, const std::string& key = ".") { Add("@ch" + inputPlace, key); }
    void CacheReadOnly(const std::string& inputPlace, const std::string& key = ".") { Add("@cr" + inputPlace, key); }
    void CacheSelectedIndex(const std::string& inputPlace, const std::string& key = ".") { Add("@cx" + inputPlace, key); }
    void CacheTextAlign(const std::string& inputPlace, const std::string& key = ".") { Add("@cT" + inputPlace, key); }
    void CacheNodeLength(const std::string& inputPlace, const std::string& key = ".") { Add("@cL" + inputPlace, key); }
    void CacheVisible(const std::string& inputPlace, const std::string& key = ".") { Add("@cV" + inputPlace, key); }
    void CacheUrl(const std::string& url, bool fetchScript = false, const std::string& key = ".")
    {
        Add("@cu", key + GS + url + (fetchScript ? std::string(1, GS) + "1" : ""));
    }
    void CacheIndex(const std::string& inputPlace, const std::string& key = ".") { Add("@cI" + inputPlace, key); }
    void RemoveCache(const std::string& cacheKey) { Add("rd", cacheKey); }
    void RemoveAllCache() { Add("rd", "*"); }
    // Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
    void SetCache(const std::string& second) { Add("cd", second); }
    void SetCache(int second) { SetCache(std::to_string(second)); }
    void SetCache() { Add("cd", "*"); }
    void AddCacheValue(const std::string& cacheKey, const std::string& value)
    {
        Add("CA", cacheKey + GS + detail::replaceAll(value, "\n", "$[ln];"));
    }
    void InsertCacheValue(const std::string& cacheKey, const std::string& value)
    {
        Add("CI", cacheKey + GS + detail::replaceAll(value, "\n", "$[ln];"));
    }
    void AppendCacheValue(const std::string& cacheKey, const std::string& value)
    {
        Add("CP", cacheKey + GS + detail::replaceAll(value, "\n", "$[ln];"));
    }
    void ReplaceCacheValue(const std::string& cacheKey, const std::string& searchValue, const std::string& value)
    {
        Add("CR", cacheKey + GS + detail::replaceAll(value, "\n", "$[ln];") + GS + detail::replaceAll(searchValue, "\n", "$[ln];"));
    }

    // Call
    void LoadUrl(const std::string& inputPlace, const std::string& url) { Add("lu" + inputPlace, url); }
    void RunActionControls(const std::string& actionControls, bool withoutWebFormsSection = true, const std::string& index = "", bool useCurrentEvent = true)
    {
        Add("lA", std::string(useCurrentEvent ? "1" : "0") + GS + (withoutWebFormsSection ? "1" : "0") + GS + index + GS + actionControls);
    }
    void CallScript(const std::string& scriptText) { Add("_", detail::replaceAll(scriptText, "\n", "$[ln];")); }
    void CallMethod(const std::string& methodName, const std::vector<std::string>& args = {})
    {
        std::string argsJoin = "";

        if (!args.empty())
            argsJoin = std::string(1, GS) + "[" + detail::join(args, std::string(1, US));

        Add("lm", methodName + argsJoin);
    }
    void CallModuleMethod(const std::string& methodName, const std::vector<std::string>& args = {})
    {
        std::string argsJoin = "";

        if (!args.empty())
            argsJoin = std::string(1, GS) + "[" + detail::join(args, std::string(1, US));

        Add("lM", methodName + argsJoin);
    }
    void CallPostBack(const std::string& formInputPlace, const std::string& outputPlace = "")
    {
        Add("Lp", "1" + std::string(1, GS) + formInputPlace + (!outputPlace.empty() ? std::string(1, GS) + outputPlace : ""));
    }
    void CallCommentBack(const std::string& index = "", const std::string& inputPlace = "", bool useCurrentEvent = true)
    {
        Add("LC", std::string(useCurrentEvent ? "1" : "0") + GS + index + GS + inputPlace);
    }
    void CallCommentBack(int index, const std::string& inputPlace = "", bool useCurrentEvent = true)
    {
        CallCommentBack(std::to_string(index), inputPlace, useCurrentEvent);
    }
    void CallWasmBack(const std::string& wasmLanguage, const std::string& wasmUrl, const std::string& methodName,
                      const std::vector<std::string>& args = {}, const std::string& outputPlace = "", bool useCurrentEvent = true)
    {
        std::string argsJoin = "";

        if (!args.empty())
            argsJoin = "[" + detail::join(args, std::string(1, US));

        Add("Ly", std::string(useCurrentEvent ? "1" : "0") + GS + wasmLanguage + GS + wasmUrl + GS + methodName + GS + argsJoin + GS + outputPlace);
    }
    void CallWebSocketBack(const std::string& path, bool useCurrentEvent = true)
    {
        Add("Lw", std::string(useCurrentEvent ? "1" : "0") + GS + path);
    }
    void CallSSEBack(const std::string& path, const std::string& outputPlace = "", bool useCurrentEvent = true,
                     bool shouldReconnect = true, const std::string& reconnectTryTimeout = "3000")
    {
        Add("Ls", std::string(useCurrentEvent ? "1" : "0") + GS + path + GS + (shouldReconnect ? "1" : "0") + GS + reconnectTryTimeout + (!outputPlace.empty() ? std::string(1, GS) + outputPlace : ""));
    }
    void CallSSEBack(const std::string& path, const std::string& outputPlace, bool useCurrentEvent, bool shouldReconnect, int reconnectTryTimeout)
    {
        CallSSEBack(path, outputPlace, useCurrentEvent, shouldReconnect, std::to_string(reconnectTryTimeout));
    }
    void CallFront(const std::string& modulePath, const std::vector<std::string>& args = {},
                   const std::string& outputPlace = "", bool useCurrentEvent = true)
    {
        std::string argsJoin = "";

        if (!args.empty())
            argsJoin = std::string(1, GS) + "[" + detail::join(args, std::string(1, US));

        Add("Lj", std::string(useCurrentEvent ? "1" : "0") + GS + modulePath + GS + outputPlace + argsJoin);
    }
    void CallGetBack(const std::string& path, const std::string& outputPlace = "", bool useCurrentEvent = true)
    {
        Add("Lg", std::string(useCurrentEvent ? "1" : "0") + GS + path + (!outputPlace.empty() ? std::string(1, GS) + outputPlace : ""));
    }
    void CallPutBack(const std::string& path, const std::string& outputPlace = "", bool useCurrentEvent = true)
    {
        Add("Lt", std::string(useCurrentEvent ? "1" : "0") + GS + path + (!outputPlace.empty() ? std::string(1, GS) + outputPlace : ""));
    }
    void CallPatchBack(const std::string& path, const std::string& outputPlace = "", bool useCurrentEvent = true)
    {
        Add("LP", std::string(useCurrentEvent ? "1" : "0") + GS + path + (!outputPlace.empty() ? std::string(1, GS) + outputPlace : ""));
    }
    void CallDeleteBack(const std::string& path, const std::string& outputPlace = "", bool useCurrentEvent = true)
    {
        Add("Ld", std::string(useCurrentEvent ? "1" : "0") + GS + path + (!outputPlace.empty() ? std::string(1, GS) + outputPlace : ""));
    }
    void CallHeadBack(const std::string& path, bool useCurrentEvent = true)
    {
        Add("Lh", std::string(useCurrentEvent ? "1" : "0") + GS + path);
    }
    void CallOptionsBack(const std::string& path, const std::string& outputPlace = "", bool useCurrentEvent = true)
    {
        Add("Lo", std::string(useCurrentEvent ? "1" : "0") + GS + path + (!outputPlace.empty() ? std::string(1, GS) + outputPlace : ""));
    }
    void CallSendBack(const std::string& path, const std::string& method, bool isMultiPart, const std::string& contentType,
                      const std::string& data, const std::string& outputPlace = "", bool useCurrentEvent = true)
    {
        Add("LS", std::string(useCurrentEvent ? "1" : "0") + GS + path + GS + method + GS + (isMultiPart ? "1" : "0") + GS + contentType + GS + detail::replaceAll(data, "\n", "$[ln];") + (!outputPlace.empty() ? std::string(1, GS) + outputPlace : ""));
    }

    // Update
    void Increase(const std::string& inputPlace, float value)
    {
        Add("gt" + inputPlace, "i" + std::string(1, GS) + std::to_string(value));
    }
    void Decrease(const std::string& inputPlace, float value)
    {
        Add("gt" + inputPlace, "i" + std::string(1, GS) + std::to_string(value * -1));
    }
    // If You Don't Use Deep Mode, any Tags Inside the Current Tag Will Simply Be Treated as Strings. Deep Mode Does not Remove Inner Elements.
    void Replace(const std::string& inputPlace, const std::string& value, const std::string& newValue, bool alsoStartTag = false, bool deep = true)
    {
        Add("gt" + inputPlace, "r" + std::string(1, GS) + value + GS + newValue + GS + (alsoStartTag ? "1" : "0") + GS + (deep ? "1" : "0"));
    }
    // HTML Converts Attribute Names to Lowercase, so they Need to Be Written in Lowercase.
    void ReplaceStartTag(const std::string& inputPlace, const std::string& value, const std::string& newValue)
    {
        Add("gt" + inputPlace, "s" + std::string(1, GS) + value + GS + newValue);
    }

    // Pre Runner
    void AssignDelay(int miliSecond, int index = -1)
    {
        std::string currentLine = GetLineByIndex(index);
        if (currentLine.empty())
            return;

        auto parts = detail::splitFirst(currentLine, '=');
        std::string newName = ":" + std::to_string(miliSecond) + ")" + parts.first;
        std::string newValue = parts.second;

        UpdateLineByIndex(index, newName, newValue);
    }

    void AssignDelayChange(int miliSecond, int index = -1)
    {
        std::string currentLine = GetLineByIndex(index);
        if (currentLine.empty())
            return;

        auto parts = detail::splitFirst(currentLine, '=');
        std::string currentName = parts.first;

        if (detail::startsWith(currentName, ":") && currentName.find(')') != std::string::npos)
        {
            std::size_t closingBracket = currentName.find(')');
            currentName = currentName.substr(closingBracket + 1);
        }

        std::string newName = ":" + std::to_string(miliSecond) + ")" + currentName;
        std::string newValue = parts.second;

        UpdateLineByIndex(index, newName, newValue);
    }

    void AssignInterval(int miliSecond, const std::string& id = "", int index = -1)
    {
        std::string currentLine = GetLineByIndex(index);
        if (currentLine.empty())
            return;

        auto parts = detail::splitFirst(currentLine, '=');
        std::string newName = "(" + std::to_string(miliSecond) + (!id.empty() ? "|" + id : "") + ")" + parts.first;
        std::string newValue = parts.second;

        UpdateLineByIndex(index, newName, newValue);
    }

    void AssignIntervalChange(int miliSecond, const std::string& id = "", int index = -1)
    {
        std::string currentLine = GetLineByIndex(index);
        if (currentLine.empty())
            return;

        auto parts = detail::splitFirst(currentLine, '=');
        std::string currentName = parts.first;

        if (detail::startsWith(currentName, "(") && currentName.find(')') != std::string::npos)
        {
            std::size_t closingBracket = currentName.find(')');
            currentName = currentName.substr(closingBracket + 1);
        }

        std::string newName = "(" + std::to_string(miliSecond) + (!id.empty() ? "|" + id : "") + ")" + currentName;
        std::string newValue = parts.second;

        UpdateLineByIndex(index, newName, newValue);
    }

    void DeleteInterval(const std::string& id) { Add("Di", id); }

    void AssignRepeat(int count, int index = -1)
    {
        std::string currentLine = GetLineByIndex(index);
        if (currentLine.empty())
            return;

        auto parts = detail::splitFirst(currentLine, '=');
        std::string newName = "," + std::to_string(count) + ")" + parts.first;
        std::string newValue = parts.second;

        UpdateLineByIndex(index, newName, newValue);
    }

    void AssignRepeatChange(int count, int index = -1)
    {
        std::string currentLine = GetLineByIndex(index);
        if (currentLine.empty())
            return;

        auto parts = detail::splitFirst(currentLine, '=');
        std::string currentName = parts.first;

        if (detail::startsWith(currentName, ",") && currentName.find(')') != std::string::npos)
        {
            std::size_t closingBracket = currentName.find(')');
            currentName = currentName.substr(closingBracket + 1);
        }

        std::string newName = "," + std::to_string(count) + ")" + currentName;
        std::string newValue = parts.second;

        UpdateLineByIndex(index, newName, newValue);
    }

    // Index
    void StartIndex(const std::string& name) { Add("#", name); }
    void StartIndex() { StartIndex(""); }
    // This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
    void StartState() { StartIndex("$"); }
    void GoTo(const std::string& line, const std::string& repeat) { Add("&", line + GS + repeat); }
    void GoTo(int line, int repeat = 1) { GoTo(std::to_string(line), std::to_string(repeat)); }
    void GoTo(const std::string& index, int repeat = 1) { Add("&", "#" + index + GS + std::to_string(repeat)); }

    // Start
    void StartTransientDOM(const std::string& inputPlace) { Add("td", inputPlace); }
    void EndTransientDOM() { Add("td", ";"); }

    // Message
    // Type: warning, problem, help, success, none
    void Alert(const std::string& text, const std::string& type = "none", const std::string& title = "Alert", const std::string& okText = "OK")
    {
        Add("Al", text + GS + (type == "none" ? "" : type) + GS + (title == "Alert" ? "" : title) + GS + (okText == "OK" ? "" : okText));
    }
    void Message(const std::string& text, const std::string& type = "none", const std::string& duration = "0")
    {
        Add("me", text + GS + (type == "none" ? "" : type) + GS + (duration == "0" ? "" : duration));
    }
    void Message(const std::string& text, const std::string& type, int duration)
    {
        Message(text, type, std::to_string(duration));
    }
    void Message(const std::string& text, int duration)
    {
        Message(text, "", std::to_string(duration));
    }

    // Type: log, info, warn, error, debug, trace, group, groupend, table
    void ConsoleMessage(const std::string& text, const std::string& type = "log")
    {
        Add("mc", detail::replaceAll(text, "\n", "$[ln];") + (type == "log" ? "" : std::string(1, GS) + type));
    }
    void ConsoleMessageAssert(const std::string& text, const std::string& condition)
    {
        Add("ma", detail::replaceAll(text, "\n", "$[ln];") + GS + condition);
    }

    // Enable
    //Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
    void EnableWebSocket(bool enable = true) { Add("ew", enable ? "1" : "0"); }
    void EnableWebSocketOnce() { Add("ew", "$"); }
    void AddWebSocket(const std::string& path) { Add("aw" + path); }
    // Disconnected WebSocket
    void DeleteWebSocket(const std::string& path) { Add("dw" + path); }

    // Use
    // InputPlace Using Only For form Element
    void UseWebSocket(const std::string& inputPlace) { Add("uw" + inputPlace); }
    void UseOnlyChangeUpdate(const std::string& inputPlace) { Add("uo" + inputPlace); }

    // Condition And Loop
    // Condition And Loop Supports Brackets and Then
    // Type: warning, problem, help, success, none
    // Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
    // Nested Conditions and Nested Loops are Possible.
    WebForms& ConfirmIsTrueAccept(const std::string& text = "Are you sure you want to proceed?",
                                  const std::string& type = "none",
                                  const std::string& title = "Confirm",
                                  const std::string& okText = "OK",
                                  const std::string& cancelText = "Cancel",
                                  int interval = 100)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "ct",
            (text == "Are you sure you want to proceed?" ? "" : text) + GS
            + (type == "none" ? "" : type) + GS
            + (title == "Confirm" ? "" : title) + GS
            + (okText == "OK" ? "" : okText) + GS
            + (cancelText == "Cancel" ? "" : cancelText));
        return *this;
    }
    WebForms& ConfirmIsFalseAccept(const std::string& text = "Are you sure you want to proceed?",
                                   const std::string& type = "none",
                                   const std::string& title = "Confirm",
                                   const std::string& okText = "OK",
                                   const std::string& cancelText = "Cancel",
                                   int interval = 100)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "cf",
            (text == "Are you sure you want to proceed?" ? "" : text) + GS
            + (type == "none" ? "" : type) + GS
            + (title == "Confirm" ? "" : title) + GS
            + (okText == "OK" ? "" : okText) + GS
            + (cancelText == "Cancel" ? "" : cancelText));
        return *this;
    }
    WebForms& IsGreaterThan(const std::string& firstValue, const std::string& secondValue, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "gt", firstValue + GS + secondValue);
        return *this;
    }
    WebForms& IsLessThan(const std::string& firstValue, const std::string& secondValue, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "lt", firstValue + GS + secondValue);
        return *this;
    }
    WebForms& IsEqualTo(const std::string& firstValue, const std::string& secondValue, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "et", firstValue + GS + secondValue);
        return *this;
    }
    WebForms& IsNotEqualTo(const std::string& firstValue, const std::string& secondValue, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "Nt", firstValue + GS + secondValue);
        return *this;
    }
    WebForms& Exist(const std::string& value, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "ex", value);
        return *this;
    }
    WebForms& NotExist(const std::string& value, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "nx", value);
        return *this;
    }
    WebForms& IsTrue(const std::string& value, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "tr", value);
        return *this;
    }
    WebForms& IsFalse(const std::string& value, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "fa", value);
        return *this;
    }
    WebForms& IsMatchMedia(const std::string& value, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "mm", value);
        return *this;
    }
    WebForms& IsNotMatchMedia(const std::string& value, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "nm", value);
        return *this;
    }
    WebForms& Include(const std::string& text, const std::string& value, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "In", value + GS + text);
        return *this;
    }
    WebForms& NotInclude(const std::string& text, const std::string& value, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "Nn", value + GS + text);
        return *this;
    }
    WebForms& ElementExists(const std::string& inputPlace, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "eE", inputPlace);
        return *this;
    }
    WebForms& ElementNotExists(const std::string& inputPlace, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "nE", inputPlace);
        return *this;
    }
    WebForms& IsRegexMatch(const std::string& value, const std::string& pattern, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "re", value + GS + pattern);
        return *this;
    }
    WebForms& IsRegexNotMatch(const std::string& value, const std::string& pattern, int interval = -1)
    {
        Add((interval >= 0 ? "{(" + std::to_string(interval) + ")" : "{") + "rn", value + GS + pattern);
        return *this;
    }
    // In: Everything Becomes A JSON List.
    // Key: Creates A Temporary Data In The Browser IndexedDB.
    // Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
    WebForms& ForEach(const std::string& path, const std::string& in, const std::string& key = ".")
    {
        Add("{fe", path + GS + in + GS + key);
        return *this;
    }
    void Break() { Add(";"); }
    WebForms& Else()
    {
        Add("}e");
        return *this;
    }
    void StartBracket() { Add("{"); }
    void EndBracket() { Add("}"); }
    // Used Then In Condition And Loop Methods
    WebForms& Then(WebForms newForm)
    {
        std::string data = newForm.GetWebFormsData();

        if (!data.empty())
        {
            if (data.find('\n') != std::string::npos)
            {
                newForm.AddToUp("{");
                newForm.Add("}");
            }
        }

        AppendForm(newForm);
        return *this;
    }

    WebForms& Then(std::function<void(WebForms&)> configure)
    {
        WebForms newForm;
        configure(newForm);

        std::string data = newForm.GetWebFormsData();

        if (!data.empty())
        {
            if (data.find('\n') != std::string::npos)
            {
                newForm.AddToUp("{");
                newForm.Add("}");
            }
        }

        AppendForm(newForm);
        return *this;
    }

    WebForms& Repeat(WebForms newForm, int repeat)
    {
        std::string bodyData = newForm.GetWebFormsData();

        if (bodyData.empty())
            return *this;

        int startLine = static_cast<int>(detail::split(bodyData, '\n').size()) * -1;

        AppendForm(newForm);
        GoTo(startLine, repeat - 1);

        return *this;
    }

    WebForms& Repeat(WebForms newForm, int repeat, const std::string& index)
    {
        GoTo(index);
        StartIndex(index);

        std::string bodyData = newForm.GetWebFormsData();

        if (bodyData.empty())
            return *this;

        AppendForm(newForm);

        if (index.empty())
        {
            int indexNumber = -1;

            for (const std::string& x : detail::split(GetWebFormsData(), '\n'))
            {
                if (detail::startsWith(x, "#"))
                    indexNumber++;
            }

            GoTo(indexNumber, repeat - 1);
        }
        else
            GoTo(index, repeat - 1);

        return *this;
    }

    WebForms& Repeat(std::function<void(WebForms&)> configure, int repeat)
    {
        WebForms newForm;
        configure(newForm);
        return Repeat(newForm, repeat);
    }

    WebForms& Repeat(std::function<void(WebForms&)> configure, int repeat, const std::string& index)
    {
        WebForms newForm;
        configure(newForm);
        return Repeat(newForm, repeat, index);
    }

    // Async
    // It Supports Brackets and Then
    WebForms& Async()
    {
        Add("{(a)");
        return *this;
    }
    void Delay(const std::string& miliSecond) { Add("De", miliSecond); }
    void Delay(int miliSecond) { Delay(std::to_string(miliSecond)); }

    // Option
    void ChangeOption(const std::string& name, const std::string& value) { Add("co", name + GS + value); }
    void ResetOption() { Add("ro"); }
    void ResetOption(const std::string& name) { Add("ro", name); }

    // Format Storage
    void CreateFormatStorage(const std::string& key, const std::string& data) { Add(".C", key + GS + data); }
    void DeleteFormatStorage(const std::string& key) { Add(".D", key); }
    void AddJSON(const std::string& key, const std::string& path, const std::string& value)
    {
        Add(".a", key + GS + "j" + GS + value + GS + path);
    }
    // Name: For Support Attribute, Set Double At Sign (@@) Before Name.
    void AddXML(const std::string& key, const std::string& path, const std::string& name, const std::string& value = "")
    {
        Add(".a", key + GS + "x" + GS + name + GS + value + GS + path);
    }
    void AddINI(const std::string& key, const std::string& path, const std::string& value, bool isINILike = false)
    {
        Add(".a", key + GS + "i" + GS + (isINILike ? "1" : "0") + GS + value + GS + path);
    }
    void AddTextLine(const std::string& key, const std::string& line, const std::string& text)
    {
        Add(".a", key + GS + "t" + GS + text + GS + line);
    }
    void AddTextLine(const std::string& key, int line, const std::string& text)
    {
        AddTextLine(key, std::to_string(line), text);
    }
    void AddVariable(const std::string& key, const std::string& value) { Add(".a", key + GS + "v" + GS + value); }
    void UpdateJSON(const std::string& key, const std::string& path, const std::string& value)
    {
        Add(".u", key + GS + "j" + GS + value + GS + path);
    }
    void UpdateXML(const std::string& key, const std::string& path, const std::string& value)
    {
        Add(".u", key + GS + "x" + GS + value + GS + path);
    }
    void UpdateINI(const std::string& key, const std::string& path, const std::string& value, bool isINILike = false)
    {
        Add(".u", key + GS + "i" + GS + (isINILike ? "1" : "0") + GS + value + GS + path);
    }
    void UpdateTexLine(const std::string& key, const std::string& line, const std::string& text)
    {
        Add(".u", key + GS + "t" + GS + text + GS + line);
    }
    void UpdateTexLine(const std::string& key, int line, const std::string& text)
    {
        UpdateTexLine(key, std::to_string(line), text);
    }
    void UpdateVariable(const std::string& key, const std::string& value) { Add(".u", key + GS + "v" + GS + value); }
    void IncreaseVariable(const std::string& key, const std::string& value) { Add(".i", key + GS + "v" + GS + value); }
    void IncreaseVariable(const std::string& key, int value) { IncreaseVariable(key, std::to_string(value)); }
    void DecreaseVariable(const std::string& key, int value) { IncreaseVariable(key, value * -1); }
    void DeleteJSON(const std::string& key, const std::string& path) { Add(".d", key + GS + "j" + GS + path); }
    void DeleteXML(const std::string& key, const std::string& path) { Add(".d", key + GS + "x" + GS + path); }
    void DeleteINI(const std::string& key, const std::string& path, bool isINILike = false)
    {
        Add(".d", key + GS + "i" + GS + (isINILike ? "1" : "0") + GS + path);
    }
    void DeleteTextLine(const std::string& key, const std::string& line) { Add(".d", key + GS + "t" + GS + line); }
    void DeleteTextLine(const std::string& key, int line) { DeleteTextLine(key, std::to_string(line)); }
    void DeleteVariable(const std::string& key) { Add(".d", key + GS + "v"); }

    // Template Engine
    // Pattern Example: {{value}}, ((value)), *value*, $value;
    void BindJSONToTemplate(const std::string& inputPlace, const std::string& jsonText, const std::string& path,
                            const std::string& pattern, bool alsoStartTag = true)
    {
        Add("Tj" + inputPlace, jsonText + GS + path + GS + pattern + GS + (alsoStartTag ? "1" : "0"));
    }
    // Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
    void BindXMLToTemplate(const std::string& inputPlace, const std::string& xmlText, const std::string& path,
                           const std::string& pattern, bool alsoStartTag = true)
    {
        Add("Tx" + inputPlace, xmlText + GS + path + GS + pattern + GS + (alsoStartTag ? "1" : "0"));
    }
    void BindINIToTemplate(const std::string& inputPlace, const std::string& iniText, const std::string& path,
                           const std::string& pattern, bool alsoStartTag = true)
    {
        Add("Ti" + inputPlace, iniText + GS + path + GS + pattern + GS + (alsoStartTag ? "1" : "0"));
    }

    // Inject
    // Need Add @: to First of String
    std::string Inject(const std::string& value) { return "$[" + value + "];"; }

    // Action Control
    void ReplaceActionControl(const std::string& searchValue, const std::string& value, bool addingToUp = false)
    {
        if (addingToUp)
            AddToUp("rE", searchValue + GS + value);
        else
            Add("rE", searchValue + GS + value);
    }

    void AssignReplace(const std::string& searchValue, const std::string& value, int index = -1)
    {
        std::string currentLine = GetLineByIndex(index);
        if (currentLine.empty())
            return;

        auto parts = detail::splitFirst(currentLine, '=');
        std::string newName = ";" + searchValue + GS + value + GS + parts.first;
        std::string newValue = parts.second;

        UpdateLineByIndex(index, newName, newValue);
    }

    // Hash And Checksum
    void SetHash() { Add("SH"); }
    void SetChecksum() { Add("CS"); }

    std::string ChecksumCalculation(const std::string& text)
    {
        int sum = 0;
        int mod = 65536;
        int shift = 5;

        for (char c : text)
        {
            sum = ((sum << shift) | (sum >> (16 - shift))) ^ static_cast<unsigned char>(c);
            sum %= mod;
        }

        return std::to_string(sum);
    }

    std::string GetChecksum() { return ChecksumCalculation(GetWebFormsData()); }

    // Get
    std::string GetFormsActionData() const
    {
        if (webFormsData_.empty())
            return "";

        return webFormsData_;
    }

    std::string Response() const
    {
        return "[web-forms]\n" + GetFormsActionData();
    }

    std::string GetFormsActionDataLineBreak() const
    {
        if (webFormsData_.empty())
            return "";

        std::string data = detail::replaceAll(webFormsData_, "\"", "$[dq];");
        return detail::replaceAll(data, "\n", "$[sln];");
    }

    // Export
    std::string ExportToHtmlComment(bool addLine = false) const
    {
        std::string response = detail::replaceAll(Response(), "--", "$[dd];");
        if (response.back() == '-')
            response = response.substr(0, response.size() - 1) + "$[da];";

        return std::string(addLine ? "\n" : "") + "<!--" + response + "-->";
    }

    // Using it for SSE Response
    std::string ExportToLineBreak(const std::string& src = "") const
    {
        return "[web-forms]$[sln];" + GetFormsActionDataLineBreak();
    }

    std::string GetWebFormsData() const
    {
        return webFormsData_;
    }

    void AppendForm(const WebForms& form)
    {
        std::string otherData = form.GetWebFormsData();
        if (!otherData.empty())
        {
            if (!webFormsData_.empty())
                webFormsData_.push_back('\n');
            webFormsData_.append(otherData);
        }
    }

    void Clean()
    {
        webFormsData_.clear();
    }
};

    class Security
    {
    public:
        std::string SafeValue(std::string value)
        {
            if (value.size() < 1)
                return value;

            if (value[0] == '@')
                value = "@" + value;

            value = detail::replaceAll(value, "\n", "$[ln];");
            value = detail::replaceAll(value, ",@", "$[co];@");
            value = detail::replaceChar(value, '\x1C', '\0');
            value = detail::replaceChar(value, '\x1D', '\0');
            value = detail::replaceChar(value, '\x1E', '\0');
            value = detail::replaceChar(value, '\x1F', '\0');

            return value;
        }
    };

    // WebForms Place Criteria (WPC) DSL
    class InputPlace
    {
    public:
        static constexpr const char* Document = ",";
        static constexpr const char* Window = "`";
        // When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
        static constexpr const char* Root = "~";
        static constexpr const char* HTML = ".";
        static constexpr const char* Head = "^";
        static constexpr const char* ScreenOrientation = "%";
        static constexpr const char* All = "*";
        static constexpr const char* Parent = "/";
        static constexpr const char* Current = "$";
        static constexpr const char* Target = "!";
        static constexpr const char* Upper = "-";

        static std::string Id(const std::string& id) { return id; }
        static std::string Name(const std::string& name) { return "(" + name + ")"; }
        static std::string Name(const std::string& name, int index) { return "(" + name + ")" + std::to_string(index); }
        static std::string AllNames(const std::string& name) { return "(" + name + ")*"; }
        static std::string Tag(const std::string& tag) { return "<" + tag + ">"; }
        static std::string Tag(const std::string& tag, int index) { return "<" + tag + ">" + std::to_string(index); }
        static std::string AllTags(const std::string& tag) { return "<" + tag + ">*"; }
        static std::string Child() { return "<>"; }
        static std::string Child(int index) { return "<>" + std::to_string(index); }
        static std::string AllChild() { return "<>*"; }
        static std::string Class(const std::string& cls) { return "{" + cls + "}"; }
        static std::string Class(const std::string& cls, int index) { return "{" + cls + "}" + std::to_string(index); }
        static std::string AllClasses(const std::string& cls) { return "{" + cls + "}*"; }
        static std::string Attribute(const std::string& name) { return "\"" + name + "\""; }
        static std::string Attribute(const std::string& name, int index) { return "\"" + name + "\"" + std::to_string(index); }
        static std::string AllAttributes(const std::string& name) { return "\"" + name + "\"*"; }
        // Operator: '^', '$', '*', '~'
        static std::string Attribute(const std::string& name, const std::string& value, char op = '\0')
        {
            return "\"" + name + (op != '\0' ? std::string(1, op) : "") + "'" + value + "\"";
        }
        static std::string Attribute(const std::string& name, const std::string& value, int index, char op = '\0')
        {
            return "\"" + name + (op != '\0' ? std::string(1, op) : "") + "'" + value + "\"" + std::to_string(index);
        }
        static std::string AllAttributes(const std::string& name, const std::string& value, char op = '\0')
        {
            return "\"" + name + (op != '\0' ? std::string(1, op) : "") + "'" + value + "\"*";
        }
        static std::string Query(const std::string& query)
        {
            std::string s = query;
            s = detail::replaceAll(s, "=", "$[eq];");
            s = detail::replaceAll(s, "|", "$[vb];");
            s = detail::replaceAll(s, "?", "$[qu];");
            return "*" + s;
        }
        static std::string QueryAll(const std::string& query)
        {
            std::string s = query;
            s = detail::replaceAll(s, "=", "$[eq];");
            s = detail::replaceAll(s, "|", "$[vb];");
            s = detail::replaceAll(s, "?", "$[qu];");
            return "[" + s;
        }
    };

    class OutputPlace : public InputPlace { };

    // Do not Add any Data Before or After it
    class Fetch
    {
    private:
        static constexpr char RS = '\x1E';
        static constexpr char US = '\x1F';

    public:
        // Method
        static std::string Random(int maxValue) { return "@mr" + std::to_string(maxValue); }
        static std::string Random(int minValue, int maxValue)
        {
            return "@mr" + std::to_string(maxValue) + std::string(1, RS) + std::to_string(minValue);
        }
        static std::string SpaceToChar(const std::string& text, const std::string& character = "-")
        {
            return "@sc" + character + std::string(1, RS) + text;
        }
        static std::string EncodeURI(const std::string& text) { return "@ue" + text; }
        static std::string DecodeURI(const std::string& text) { return "@ud" + text; }

        static std::string Method(const std::string& methodName, const std::vector<std::string>& args = {})
        {
            std::string returnValue = "@cm" + methodName;

            if (!args.empty())
                returnValue += std::string(1, RS) + detail::join(args, std::string(1, US));

            return returnValue;
        }

        static std::string ModuleMethod(const std::string& methodName, const std::vector<std::string>& args = {})
        {
            std::string returnValue = "@cM" + methodName;

            if (!args.empty())
                returnValue += std::string(1, RS) + detail::join(args, std::string(1, US));

            return returnValue;
        }

        // MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
        static std::string WasmMethod(const std::string& wasmLanguage, const std::string& wasmUrl, const std::string& methodName,
                                      const std::vector<std::string>& args = {}, const std::string& key = ".")
        {
            (void)key;
            std::string returnValue = "@wA" + wasmLanguage + std::string(1, RS) + wasmUrl + std::string(1, RS) + methodName;

            if (!args.empty())
                returnValue += std::string(1, RS) + detail::join(args, std::string(1, US));

            return returnValue;
        }

        static std::string Script(const std::string& scriptText)
        {
            return "@_" + detail::replaceAll(scriptText, "\n", "$[ln];");
        }
        static std::string LoadUrl(const std::string& url, bool fetchScript = false)
        {
            return "@lu" + url + (fetchScript ? std::string(1, RS) + "1" : "");
        }
        static std::string LoadHtml(const std::string& url, const std::string& fetchInputPlace = "", bool fetchScript = false)
        {
            return "@lh" + url + std::string(1, RS) + (fetchScript ? "1" : "0") + (!fetchInputPlace.empty() ? std::string(1, RS) + fetchInputPlace : "");
        }
        static std::string LoadLine(const std::string& url, int line)
        {
            return "@ll" + url + std::string(1, RS) + std::to_string(line);
        }
        static std::string LoadINI(const std::string& url, const std::string& name, bool isINILike = false)
        {
            return "@li" + url + std::string(1, RS) + name + (isINILike ? std::string(1, RS) + "1" : "");
        }
        // Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
        static std::string LoadJSON(const std::string& url, const std::string& name)
        {
            return "@lj" + url + std::string(1, RS) + name;
        }
        // Name: Name Or XPath; XPath Index Starts At 1
        static std::string LoadXML(const std::string& url, const std::string& name)
        {
            return "@lx" + url + std::string(1, RS) + name;
        }
        // MethodName: It's Check Function Or Variable
        static std::string HasMethod(const std::string& methodName) { return "@hm" + methodName; }
        static std::string HasModuleMethod(const std::string& methodName) { return "@hM" + methodName; }
        // This Method Return True Or False If Key Pressed
        // Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
        static std::string GetModifierState(const std::string& modifier) { return "@ms" + modifier; }

        // Math
        static std::string Math(const std::string& methodName, const std::vector<std::string>& args = {})
        {
            std::string returnValue = "@M#" + methodName;

            if (!args.empty())
                returnValue += std::string(1, RS) + detail::join(args, std::string(1, US));

            return returnValue;
        }

        // Data
        static constexpr const char* DateYear = "@dy";
        // Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1 
        static constexpr const char* DateMonth = "@dm";
        static constexpr const char* DateDay = "@dd";
        static constexpr const char* DateDate = "@dD";
        static constexpr const char* DateHours = "@dh";
        static constexpr const char* DateMinutes = "@di";
        static constexpr const char* DateSeconds = "@ds";
        static constexpr const char* DateMilliseconds = "@dl";

        // String
        static constexpr const char* Space = "@sp";
        static constexpr const char* AtSign = "@sa";

        // Tag
        static std::string GetId(const std::string& inputPlace) { return "@$i" + inputPlace; }
        static std::string GetName(const std::string& inputPlace) { return "@$n" + inputPlace; }
        static std::string GetValue(const std::string& inputPlace) { return "@$v" + inputPlace; }
        static std::string GetValueLength(const std::string& inputPlace) { return "@$e" + inputPlace; }
        static std::string GetClass(const std::string& inputPlace) { return "@$c" + inputPlace; }
        static std::string GetStyle(const std::string& inputPlace) { return "@$s" + inputPlace; }
        static std::string GetTitle(const std::string& inputPlace) { return "@$l" + inputPlace; }
        static std::string GetLabel(const std::string& inputPlace) { return "@$A" + inputPlace; }
        static std::string GetText(const std::string& inputPlace) { return "@$t" + inputPlace; }
        static std::string GetOuterText(const std::string& inputPlace) { return "@$o" + inputPlace; }
        static std::string GetTextLength(const std::string& inputPlace) { return "@$g" + inputPlace; }
        static std::string GetAttribute(const std::string& inputPlace, const std::string& attribute)
        {
            return "@$a" + inputPlace + std::string(1, RS) + attribute;
        }
        static std::string GetWidth(const std::string& inputPlace) { return "@$w" + inputPlace; }
        static std::string GetHeight(const std::string& inputPlace) { return "@$h" + inputPlace; }
        static std::string GetIsReadOnly(const std::string& inputPlace) { return "@$r" + inputPlace; }
        static std::string GetSelectedIndex(const std::string& inputPlace) { return "@$x" + inputPlace; }
        static std::string GetIndex(const std::string& inputPlace) { return "@$I" + inputPlace; }
        static std::string GetTextAlign(const std::string& inputPlace) { return "@$T" + inputPlace; }
        static std::string GetNodeLength(const std::string& inputPlace) { return "@$L" + inputPlace; }
        static std::string GetIsVisible(const std::string& inputPlace) { return "@$V" + inputPlace; }

        // Save
        static std::string HasHash(const std::string& hash) { return "@HH" + hash; }
        static std::string Cookie(const std::string& key) { return "@co" + key; }
        static std::string Save(const std::string& key = ".") { return "@cs" + key; }
        static std::string Save(const std::string& key, const std::string& replaceValue)
        {
            return "@cs" + key + std::string(1, RS) + replaceValue;
        }
        static std::string SaveThenRemove(const std::string& key) { return "@cl" + key; }
        static std::string SaveLength(const std::string& key = ".") { return "@cg" + key; }
        static std::string Cache(const std::string& key = ".") { return "@cd" + key; }
        static std::string Cache(const std::string& key, const std::string& replaceValue)
        {
            return "@cd" + key + std::string(1, RS) + replaceValue;
        }
        static std::string CacheThenRemove(const std::string& key) { return "@ct" + key; }
        static std::string CacheLength(const std::string& key = ".") { return "@cG" + key; }
        static std::string SaveLine(const std::string& key = ".", int line = 0)
        {
            return "@lL" + key + "[" + std::to_string(line);
        }
        static std::string SaveLineConsume(const std::string& key = ".") { return "@lL" + key; }
        // INIKey: Only Direct Key is Supported
        static std::string SaveINI(const std::string& key, const std::string& iniKey)
        {
            return "@lI" + key + "[" + iniKey;
        }
        static std::string CacheLine(const std::string& key = ".", int line = 0)
        {
            return "@dL" + key + "[" + std::to_string(line);
        }
        static std::string CacheLineConsume(const std::string& key = ".") { return "@dL" + key; }
        // INIKey: Only Direct Key is Supported
        static std::string CacheINI(const std::string& key, const std::string& iniKey)
        {
            return "@dI" + key + "[" + iniKey;
        }

        // Format Storage
        static std::string FormatStore(const std::string& key) { return "@fr" + key; }
        static std::string FormatStoreByXMLQuery(const std::string& key, const std::string& xpath)
        {
            return "@fx" + key + std::string(1, RS) + xpath;
        }
        static std::string FormatStoreByJSONQuery(const std::string& key, const std::string& query)
        {
            return "@fj" + key + std::string(1, RS) + query;
        }
        static std::string FormatStoreByINI(const std::string& key, const std::string& name)
        {
            return "@fi" + key + std::string(1, RS) + name;
        }
        static std::string FormatStoreByText(const std::string& key, int line)
        {
            return "@ft" + key + std::string(1, RS) + std::to_string(line);
        }
        static std::string FormatStoreByVariable(const std::string& key) { return "@fv" + key; }

        // State
        static std::string HasState(const std::string& path) { return "@hs" + path; }

        // SSE
        static std::string SSEIsConnected(const std::string& path) { return "@Sc" + path; }

        // WebSockets
        static std::string WebSocketsIsConnected(const std::string& path = "") { return "@Wc" + path; }

        // Document
        static constexpr const char* TabIsActive = "@da";

        // Window
        static constexpr const char* Href = "@wf";
        static constexpr const char* PathName = "@wP";
        static std::string Query(const std::string& name = "*") { return "@wq" + name; }
        static constexpr const char* Hash = "@wh";
        static constexpr const char* Host = "@wH";
        static constexpr const char* HostName = "@wn";
        static constexpr const char* Port = "@wT";
        static constexpr const char* Origin = "@wo";
        static constexpr const char* GetSelection = "@ws";
        static constexpr const char* ScrollX = "@wx";
        static constexpr const char* ScrollY = "@wy";
        static std::string Segment(int index) { return "@wS" + std::to_string(index); }
        // It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
        static std::string HashSegment(int index) { return "@wt" + std::to_string(index); }

        // Navigator
        static constexpr const char* ClipboardText = "@nC";
        static constexpr const char* GeoLatitude = "@nW";
        static constexpr const char* GeoLongitude = "@nO";
        static constexpr const char* Language = "@nL";
        static constexpr const char* IsOnLine = "@no";
        static constexpr const char* UserAgent = "@na";

        // Screen
        static constexpr const char* ScreenWidth = "@sw";
        static constexpr const char* ScreenHeight = "@sh";
        static constexpr const char* ScreenOrientationType = "@so";
        static constexpr const char* ScreenOrientationAngle = "@sr";

        // Performance
        static constexpr const char* TimeOrigin = "@pt";
        static constexpr const char* PerformanceNow = "@pn";

        // Event
        static constexpr const char* Event = "@EV";
        static constexpr const char* EventSerialize = "@Es";
        static constexpr const char* EventKey = "@ek";
        static constexpr const char* EventWhich = "@ew";
        static constexpr const char* EventClientX = "@ex";
        static constexpr const char* EventClientY = "@ey";
        static constexpr const char* EventPageX = "@eX";
        static constexpr const char* EventPageY = "@eY";
        static constexpr const char* EventOffsetX = "@Ex";
        static constexpr const char* EventOffsetY = "@Ey";
        static constexpr const char* EventDeltaY = "@ed";
    };

    class WasmLanguage
    {
    public:
        // The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
        static constexpr const char* C = "c";
        static constexpr const char* CPP = "c";
        static constexpr const char* Rust = "rust";
        static constexpr const char* CSharp = "csharp";
        // .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
        static constexpr const char* CSharpMediator = "csharp-m";
        static constexpr const char* GO = "go";
        static constexpr const char* JAVA = "java";
        static constexpr const char* AssemblyScript = "as";
    };

    class HtmlEvent
    {
    public:
        static constexpr const char* OnAbort = "onabort";
        static constexpr const char* OnAfterPrint = "onafterprint";
        static constexpr const char* OnBeforePrint = "onbeforeprint";
        static constexpr const char* OnBeforeUnload = "onbeforeunload";
        static constexpr const char* OnBlur = "onblur";
        static constexpr const char* OnCanPlay = "oncanplay";
        static constexpr const char* OnCanPlayThrough = "oncanplaythrough";
        static constexpr const char* OnChange = "onchange";
        static constexpr const char* OnClick = "onclick";
        static constexpr const char* OnCopy = "oncopy";
        static constexpr const char* OnCut = "oncut";
        static constexpr const char* OnDoubleClick = "ondblclick";
        static constexpr const char* OnDrag = "ondrag";
        static constexpr const char* OnDragEnd = "ondragend";
        static constexpr const char* OnDragEnter = "ondragenter";
        static constexpr const char* OnDragLeave = "ondragleave";
        static constexpr const char* OnDragOver = "ondragover";
        static constexpr const char* OnDragStart = "ondragstart";
        static constexpr const char* OnDrop = "ondrop";
        static constexpr const char* OnDurationChange = "ondurationchange";
        static constexpr const char* OnEnded = "onended";
        static constexpr const char* OnError = "onerror";
        static constexpr const char* OnFocus = "onfocus";
        static constexpr const char* OnFocusin = "onfocusin";
        static constexpr const char* OnFocusOut = "onfocusout";
        static constexpr const char* OnHashChange = "onhashchange";
        static constexpr const char* OnInput = "oninput";
        static constexpr const char* OnInvalid = "oninvalid";
        static constexpr const char* OnKeyDown = "onkeydown";
        static constexpr const char* OnKeyPress = "onkeypress";
        static constexpr const char* OnKeyUp = "onkeyup";
        static constexpr const char* OnLoad = "onload";
        static constexpr const char* OnLoadedData = "onloadeddata";
        static constexpr const char* OnLoadedMetaData = "onloadedmetadata";
        static constexpr const char* OnLoadStart = "onloadstart";
        static constexpr const char* OnMouseDown = "onmousedown";
        static constexpr const char* OnMouseEnter = "onmouseenter";
        static constexpr const char* OnMouseLeave = "onmouseleave";
        static constexpr const char* OnMouseMove = "onmousemove";
        static constexpr const char* OnMouseOver = "onmouseover";
        static constexpr const char* OnMouseOut = "onmouseout";
        static constexpr const char* OnMouseUp = "onmouseup";
        static constexpr const char* OnOffline = "onoffline";
        static constexpr const char* OnOnline = "ononline";
        static constexpr const char* OnPageHide = "onpagehide";
        static constexpr const char* OnPageShow = "onpageshow";
        static constexpr const char* OnPaste = "onpaste";
        static constexpr const char* OnPause = "onpause";
        static constexpr const char* OnPlay = "onplay";
        static constexpr const char* OnPlaying = "onplaying";
        static constexpr const char* OnProgress = "onprogress";
        static constexpr const char* OnRateChange = "onratechange";
        static constexpr const char* OnResize = "onresize";
        static constexpr const char* OnReset = "onreset";
        static constexpr const char* OnScroll = "onscroll";
        static constexpr const char* OnSearch = "onsearch";
        static constexpr const char* OnSeeked = "onseeked";
        static constexpr const char* OnSeeking = "onseeking";
        static constexpr const char* OnSelect = "onselect";
        static constexpr const char* OnStalled = "onstalled";
        static constexpr const char* OnSubmit = "onsubmit";
        static constexpr const char* OnSuspend = "onsuspend";
        static constexpr const char* OnTimeUpdate = "ontimeupdate";
        static constexpr const char* OnToggle = "ontoggle";
        static constexpr const char* OnTouchCancel = "ontouchcancel";
        static constexpr const char* OnTouchend = "ontouchend";
        static constexpr const char* OnTouchMove = "ontouchmove";
        static constexpr const char* OnTouchStart = "ontouchstart";
        static constexpr const char* OnUnload = "onunload";
        static constexpr const char* OnVolumeChange = "onvolumechange";
        static constexpr const char* OnWaiting = "onwaiting";
        static constexpr const char* OnWheel = "onwheel";
    };

    class HtmlEventListener
    {
    public:
        static constexpr const char* Abort = "abort";
        static constexpr const char* AfterPrint = "afterprint";
        static constexpr const char* BeforePrint = "beforeprint";
        static constexpr const char* BeforeUnload = "beforeunload";
        static constexpr const char* Blur = "blur";
        static constexpr const char* CanPlay = "canplay";
        static constexpr const char* CanPlayThrough = "canplaythrough";
        static constexpr const char* Change = "change";
        static constexpr const char* Click = "click";
        static constexpr const char* Copy = "copy";
        static constexpr const char* Cut = "cut";
        static constexpr const char* DoubleClick = "dblclick";
        static constexpr const char* Drag = "drag";
        static constexpr const char* DragEnd = "dragend";
        static constexpr const char* DragEnter = "dragenter";
        static constexpr const char* DragLeave = "dragleave";
        static constexpr const char* DragOver = "dragover";
        static constexpr const char* DragStart = "dragstart";
        static constexpr const char* Drop = "drop";
        static constexpr const char* DurationChange = "durationchange";
        static constexpr const char* Ended = "ended";
        static constexpr const char* Error = "error";
        static constexpr const char* Focus = "focus";
        static constexpr const char* Focusin = "focusin";
        static constexpr const char* FocusOut = "focusout";
        static constexpr const char* HashChange = "hashchange";
        static constexpr const char* Input = "input";
        static constexpr const char* Invalid = "invalid";
        static constexpr const char* KeyDown = "keydown";
        static constexpr const char* KeyPress = "keypress";
        static constexpr const char* KeyUp = "keyup";
        static constexpr const char* Load = "load";
        static constexpr const char* LoadedData = "loadeddata";
        static constexpr const char* LoadedMetaData = "loadedmetadata";
        static constexpr const char* LoadStart = "loadstart";
        static constexpr const char* MouseDown = "mousedown";
        static constexpr const char* MouseEnter = "mouseenter";
        static constexpr const char* MouseLeave = "mouseleave";
        static constexpr const char* MouseMove = "mousemove";
        static constexpr const char* MouseOver = "mouseover";
        static constexpr const char* MouseOut = "mouseout";
        static constexpr const char* MouseUp = "mouseup";
        static constexpr const char* Offline = "offline";
        static constexpr const char* Online = "online";
        static constexpr const char* PageHide = "pagehide";
        static constexpr const char* PageShow = "pageshow";
        static constexpr const char* Paste = "paste";
        static constexpr const char* Pause = "pause";
        static constexpr const char* Play = "play";
        static constexpr const char* Playing = "playing";
        static constexpr const char* Progress = "progress";
        static constexpr const char* RateChange = "ratechange";
        static constexpr const char* Resize = "resize";
        static constexpr const char* Reset = "reset";
        static constexpr const char* Scroll = "scroll";
        static constexpr const char* Search = "search";
        static constexpr const char* Seeked = "seeked";
        static constexpr const char* Seeking = "seeking";
        static constexpr const char* Select = "select";
        static constexpr const char* Stalled = "stalled";
        static constexpr const char* Submit = "submit";
        static constexpr const char* Suspend = "suspend";
        static constexpr const char* TimeUpdate = "timeupdate";
        static constexpr const char* Toggle = "toggle";
        static constexpr const char* TouchCancel = "touchcancel";
        static constexpr const char* Touchend = "touchend";
        static constexpr const char* TouchMove = "touchmove";
        static constexpr const char* TouchStart = "touchstart";
        static constexpr const char* Unload = "unload";
        static constexpr const char* VolumeChange = "volumechange";
        static constexpr const char* Waiting = "waiting";
        static constexpr const char* Wheel = "wheel";

        static constexpr const char* AnimationEnd = "animationend";
        static constexpr const char* AnimationIteration = "animationiteration";
        static constexpr const char* AnimationStart = "animationstart";
        static constexpr const char* ContextMenu = "contextmenu";
        static constexpr const char* FullScreenChange = "fullscreenchange";
        static constexpr const char* FullScreenError = "fullscreenerror";
        static constexpr const char* PopState = "popstate";
        static constexpr const char* TransitionEnd = "transitionend";
        static constexpr const char* Storage = "storage";

        // Custom
        static constexpr const char* ScrollBottom = "scrollbottom"; // Need Call EnableScrollBottomEvent Method Before
        static constexpr const char* ElementReached = "elementreached"; // Need Call EnableReachedElementEvent Method Before
    };

    namespace ext
    {
        inline std::string Child(const std::string& text, const std::string& value)
        {
            if (text.size() < 1)
                return value;

            return text + "|" + value;
        }

        inline std::string Parent(const std::string& text)
        {
            std::string result = text;

            if (result.size() < 1)
                return result;

            if (detail::endsWith(result, "|/") || detail::endsWith(result, "//"))
                return result + '/';

            return result + "|/";
        }

        inline std::string Criteria(const std::string& text, const std::string& value)
        {
            if (text.size() < 1)
                return value;

            std::string v = detail::replaceAll(value, "|", "$[vb];");
            v = detail::replaceAll(v, "?", "$[qu];");
            return text + "?" + v;
        }

        inline std::string AppendFetchReplace(const std::string& text, const std::string& searchValue, const std::string& value)
        {
            constexpr char FS = '\x1C';

            std::string result = text.substr(1);
            return "@;" + searchValue + std::string(1, FS) + value + std::string(1, FS) + result;
        }

        inline std::string LineBreak(const std::string& text, bool encodeLine = false)
        {
            std::string encode = encodeLine ? "$[sln];" : "";
            std::string result = detail::replaceAll(text, "\r\n", encode);
            result = detail::replaceAll(result, "\n", encode);
            result = detail::replaceAll(result, "\r", encode);
            return result;
        }

        // Converts Numbers to Strings
        inline std::string ToJSString(const std::string& text)
        {
            return "\"" + text + "\"";
        }

        // Get JS Object Momentary 
        inline std::string ToJSObject(const std::string& text)
        {
            return "$" + text;
        }

        // Get JS Object Returned Value Once
        inline std::string ToJSReturnObject(const std::string& text)
        {
            return "$@" + text;
        }
    }

} // namespace WebFormsCore
