// WebForms.h 2.0 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.0

#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <algorithm>
#include <ctime>
#include <cstdlib>

class WebForms {
private:
    std::stringstream WebFormsData;

    void Add(const std::string& Name, const std::string& Value) {
        if (WebFormsData.tellp() > 0)
            WebFormsData << '\n';
        
        WebFormsData << Name << '=' << Value;
    }

    void Add(const std::string& Name) {
        if (WebFormsData.tellp() > 0)
            WebFormsData << '\n';
        
        WebFormsData << Name;
    }

    std::string GetLineByIndex(int Index) {
        std::string data = WebFormsData.str();
        if (data.empty())
            return "";
        
        std::vector<std::string> lines;
        std::stringstream ss(data);
        std::string line;
        
        while (std::getline(ss, line, '\n')) {
            lines.push_back(line);
        }
        
        if (Index < 0)
            Index = lines.size() + Index;
        
        if (Index < 0 || Index >= (int)lines.size())
            return "";
        
        return lines[Index];
    }

    void UpdateLineByIndex(int Index, const std::string& Name, const std::string& Value) {
        std::string data = WebFormsData.str();
        if (data.empty())
            return;
        
        std::vector<std::string> lines;
        std::stringstream ss(data);
        std::string line;
        
        while (std::getline(ss, line, '\n')) {
            lines.push_back(line);
        }
        
        if (Index < 0)
            Index = lines.size() + Index;
        
        if (Index < 0 || Index >= (int)lines.size())
            return;
        
        lines[Index] = Name + (Value.empty() ? "" : "=" + Value);
        
        WebFormsData.str("");
        WebFormsData.clear();
        for (size_t i = 0; i < lines.size(); ++i) {
            if (i > 0) WebFormsData << '\n';
            WebFormsData << lines[i];
        }
    }

public:
    static std::string ReplaceAll(const std::string& str, const std::string& from, const std::string& to) {
        std::string result = str;
        size_t pos = 0;
        while ((pos = result.find(from, pos)) != std::string::npos) {
            result.replace(pos, from.length(), to);
            pos += to.length();
        }
        return result;
    }

    // For Extension
    void AddLine(const std::string& Name, const std::string& Value) { Add(Name, Value); }

    // Add
    void AddId(const std::string& InputPlace, const std::string& Id) { Add("ai" + InputPlace, Id); }
    void AddName(const std::string& InputPlace, const std::string& Name) { Add("an" + InputPlace, Name); }
    void AddValue(const std::string& InputPlace, const std::string& Value) { Add("av" + InputPlace, Value); }
    void AddClass(const std::string& InputPlace, const std::string& Class) { Add("ac" + InputPlace, Class); }
    void AddStyle(const std::string& InputPlace, const std::string& Style) { Add("as" + InputPlace, Style); }
    void AddStyle(const std::string& InputPlace, const std::string& Name, const std::string& Value) { Add("as" + InputPlace, Name + ':' + Value); }
    void AddOptionTag(const std::string& InputPlace, const std::string& Text, const std::string& Value, bool Selected = false) { Add("ao" + InputPlace, Value + '|' + Text + (Selected ? "|1" : "")); }
    void AddCheckBoxTag(const std::string& InputPlace, const std::string& Text, const std::string& Value, bool Checked = false) { Add("ak" + InputPlace, Value + '|' + Text + (Checked ? "|1" : "")); }
    void AddTitle(const std::string& InputPlace, const std::string& Title) { Add("al" + InputPlace, Title); }
    void AddLabel(const std::string& InputPlace, const std::string& Label) { Add("aA" + InputPlace, Label); }
    void AddText(const std::string& InputPlace, const std::string& Text) { Add("at" + InputPlace, ReplaceAll(Text, "\n", "$[ln];")); }
    void AddTextToUp(const std::string& InputPlace, const std::string& Text) { Add("pt" + InputPlace, ReplaceAll(Text, "\n", "$[ln];")); }
    void AddAttribute(const std::string& InputPlace, const std::string& Attribute, const std::string& Value = "", char Splitter = '\0') { 
        std::string splitterStr = (Splitter != '\0') ? std::string(1, Splitter) : "";
        Add("aa" + InputPlace, Attribute + '|' + splitterStr + (!Value.empty() ? '|' + Value : "")); 
    }
    void AddTag(const std::string& InputPlace, const std::string& TagName, const std::string& Id = "") { Add("nt" + InputPlace, TagName + (!Id.empty() ? '|' + Id : "")); }
    void AddTagToUp(const std::string& InputPlace, const std::string& TagName, const std::string& Id = "") { Add("ut" + InputPlace, TagName + (!Id.empty() ? '|' + Id : "")); }
    void AddTagBefore(const std::string& InputPlace, const std::string& TagName, const std::string& Id = "") { Add("bt" + InputPlace, TagName + (!Id.empty() ? '|' + Id : "")); }
    void AddTagAfter(const std::string& InputPlace, const std::string& TagName, const std::string& Id = "") { Add("ft" + InputPlace, TagName + (!Id.empty() ? '|' + Id : "")); }
    void AddHidden(const std::string& InputPlace, const std::string& Value, const std::string& Id = "") { Add("ah" + InputPlace, Value + (!Id.empty() ? '|' + Id : "")); }

    // Set
    void SetId(const std::string& InputPlace, const std::string& Id) { Add("si" + InputPlace, Id); }
    void SetName(const std::string& InputPlace, const std::string& Name) { Add("sn" + InputPlace, Name); }
    void SetValue(const std::string& InputPlace, const std::string& Value) { Add("sv" + InputPlace, Value); }
    void SetClass(const std::string& InputPlace, const std::string& Class) { Add("sc" + InputPlace, Class); }
    void SetStyle(const std::string& InputPlace, const std::string& Style) { Add("ss" + InputPlace, Style); }
    void SetStyle(const std::string& InputPlace, const std::string& Name, const std::string& Value) { Add("ss" + InputPlace, Name + ':' + Value); }
    void SetOptionTag(const std::string& InputPlace, const std::string& Text, const std::string& Value, bool Selected = false) { Add("so" + InputPlace, Value + '|' + Text + (Selected ? "|1" : "")); }
    void SetChecked(const std::string& InputPlace, bool Checked = false) { Add("sk" + InputPlace, Checked ? "1" : "0"); }
    void SetCheckBoxTag(const std::string& InputPlace, const std::string& Text, const std::string& Value, bool Checked = false) { Add("sk" + InputPlace, Value + '|' + Text + (Checked ? "|1" : "")); }
    void SetTitle(const std::string& InputPlace, const std::string& Title) { Add("sl" + InputPlace, Title); }
    void SetLabel(const std::string& InputPlace, const std::string& Label) { Add("sA" + InputPlace, Label); }
    void SetText(const std::string& InputPlace, const std::string& Text) { Add("st" + InputPlace, ReplaceAll(Text, "\n", "$[ln];")); }
    void SetAttribute(const std::string& InputPlace, const std::string& Attribute, const std::string& Value = "") { Add("sa" + InputPlace, Attribute + '|' + (!Value.empty() ? '|' + Value : "")); }
    void SetWidth(const std::string& InputPlace, const std::string& Width) { Add("sw" + InputPlace, Width); }
    void SetWidth(const std::string& InputPlace, int Width) { SetWidth(InputPlace, std::to_string(Width) + "px"); }
    void SetHeight(const std::string& InputPlace, const std::string& Height) { Add("sh" + InputPlace, Height); }
    void SetHeight(const std::string& InputPlace, int Height) { SetHeight(InputPlace, std::to_string(Height) + "px"); }
    void SetBackgroundColor(const std::string& InputPlace, const std::string& Color) { Add("bc" + InputPlace, Color); }
    void SetTextColor(const std::string& InputPlace, const std::string& Color) { Add("tc" + InputPlace, Color); }
    void SetFontName(const std::string& InputPlace, const std::string& Name) { Add("fn" + InputPlace, Name); }
    void SetFontSize(const std::string& InputPlace, const std::string& Size) { Add("fs" + InputPlace, Size); }
    void SetFontSize(const std::string& InputPlace, int Size) { Add("fs" + InputPlace, std::to_string(Size) + "px"); }
    void SetFontBold(const std::string& InputPlace, bool Bold) { Add("fb" + InputPlace, Bold ? "1" : "0"); }
    void SetVisible(const std::string& InputPlace, bool Visible) { Add("vi" + InputPlace, Visible ? "1" : "0"); }
    void SetTextAlign(const std::string& InputPlace, const std::string& Align) { Add("ta" + InputPlace, Align); }
    void SetReadOnly(const std::string& InputPlace, bool ReadOnly) { Add("sr" + InputPlace, ReadOnly ? "1" : "0"); }
    void SetDisabled(const std::string& InputPlace, bool Disabled) { Add("sd" + InputPlace, Disabled ? "1" : "0"); }
    void SetFocus(const std::string& InputPlace, bool Focus) { Add("sf" + InputPlace, Focus ? "1" : "0"); }
    void SetMinLength(const std::string& InputPlace, int Length) { Add("mn" + InputPlace, std::to_string(Length)); }
    void SetMaxLength(const std::string& InputPlace, int Length) { Add("mx" + InputPlace, std::to_string(Length)); }
    void SetSelectedValue(const std::string& InputPlace, const std::string& Value) { Add("ts" + InputPlace, Value); }
    void SetSelectedIndex(const std::string& InputPlace, int Index) { Add("ti" + InputPlace, std::to_string(Index)); }
    void SetCheckedValue(const std::string& InputPlace, const std::string& Value, bool Selected) { Add("ks" + InputPlace, Value + "|" + (Selected ? "1" : "0")); }
    void SetCheckedIndex(const std::string& InputPlace, int Index, bool Selected) { Add("ki" + InputPlace, std::to_string(Index) + "|" + (Selected ? "1" : "0")); }

    // Insert
    void InsertId(const std::string& InputPlace, const std::string& Id) { Add("ii" + InputPlace, Id); }
    void InsertName(const std::string& InputPlace, const std::string& Name) { Add("in" + InputPlace, Name); }
    void InsertValue(const std::string& InputPlace, const std::string& Value) { Add("iv" + InputPlace, Value); }
    void InsertClass(const std::string& InputPlace, const std::string& Class) { Add("ic" + InputPlace, Class); }
    void InsertStyle(const std::string& InputPlace, const std::string& Style) { Add("is" + InputPlace, Style); }
    void InsertStyle(const std::string& InputPlace, const std::string& Name, const std::string& Value) { Add("is" + InputPlace, Name + ':' + Value); }
    void InsertOptionTag(const std::string& InputPlace, const std::string& Text, const std::string& Value, bool Selected = false) { Add("io" + InputPlace, Value + '|' + Text + (Selected ? "|1" : "")); }
    void InsertCheckBoxTag(const std::string& InputPlace, const std::string& Text, const std::string& Value, bool Checked = false) { Add("ik" + InputPlace, Value + '|' + Text + (Checked ? "|1" : "")); }
    void InsertTitle(const std::string& InputPlace, const std::string& Title) { Add("il" + InputPlace, Title); }
    void InsertLabel(const std::string& InputPlace, const std::string& Label) { Add("iA" + InputPlace, Label); }
    void InsertText(const std::string& InputPlace, const std::string& Text) { Add("it" + InputPlace, ReplaceAll(Text, "\n", "$[ln];")); }
    void InsertAttribute(const std::string& InputPlace, const std::string& Attribute, const std::string& Value = "", char Splitter = '\0') { 
        std::string splitterStr = (Splitter != '\0') ? std::string(1, Splitter) : "";
        Add("ia" + InputPlace, Attribute + '|' + splitterStr + (!Value.empty() ? '|' + Value : "")); 
    }

    // Delete
    void DeleteId(const std::string& InputPlace) { Add("di" + InputPlace); }
    void DeleteName(const std::string& InputPlace) { Add("dn" + InputPlace); }
    void DeleteValue(const std::string& InputPlace) { Add("dv" + InputPlace); }
    void DeleteClass(const std::string& InputPlace, const std::string& ClassName) { Add("dc" + InputPlace, ClassName); }
    void DeleteStyle(const std::string& InputPlace, const std::string& StyleName) { Add("ds" + InputPlace, StyleName); }
    void DeleteOptionTag(const std::string& InputPlace, const std::string& Value) { Add("do" + InputPlace, Value); }
    void DeleteAllOptionTag(const std::string& InputPlace) { Add("do" + InputPlace, "*"); }
    void DeleteCheckBoxTag(const std::string& InputPlace, const std::string& Value) { Add("dk" + InputPlace, Value); }
    void DeleteAllCheckBoxTag(const std::string& InputPlace) { Add("dk" + InputPlace, "*"); }
    void DeleteTitle(const std::string& InputPlace) { Add("dl" + InputPlace); }
    void DeleteLabel(const std::string& InputPlace) { Add("dA" + InputPlace); }
    void DeleteText(const std::string& InputPlace) { Add("dt" + InputPlace); }
    void DeleteAttribute(const std::string& InputPlace, const std::string& Attribute) { Add("da" + InputPlace, Attribute); }
    void Delete(const std::string& InputPlace) { Add("de" + InputPlace); }
    void DeleteParent(const std::string& InputPlace) { Add("dp" + InputPlace); }

    // Tag
    void SwapTag(const std::string& InputPlace, const std::string& OutputPlace) { Add("sp" + InputPlace, OutputPlace); }
    void SetReflection(const std::string& InputPlace, const std::string& Tag) { Add("sR" + InputPlace, Tag); }
    void SetReflectionByOutputPlace(const std::string& InputPlace, const std::string& OutputPlace) { Add("iR" + InputPlace, OutputPlace); }

    // Browser
    void ChangeUrl(const std::string& Url) { Add("cu", Url); }
    void SetHeadTitle(const std::string& Title) { Add("ht", Title); }
    void ClipboardWriteText(const std::string& Text) { Add("nw", Text); }
    void ScrollTo(int X, int Y) { Add("ws", std::to_string(X) + "|" + std::to_string(Y)); }
    void HistoryGo(int Steps) { Add("wg", std::to_string(Steps)); }
    void ReloadPage() { Add("lr"); }
    void Redirect(const std::string& Path) { Add("lh", Path); }

    // Increase
    void IncreaseMinLength(const std::string& InputPlace, int Value) { Add("+n" + InputPlace, std::to_string(Value)); }
    void IncreaseMaxLength(const std::string& InputPlace, int Value) { Add("+x" + InputPlace, std::to_string(Value)); }
    void IncreaseFontSize(const std::string& InputPlace, int Value) { Add("+f" + InputPlace, std::to_string(Value)); }
    void IncreaseWidth(const std::string& InputPlace, int Value) { Add("+w" + InputPlace, std::to_string(Value)); }
    void IncreaseHeight(const std::string& InputPlace, int Value) { Add("+h" + InputPlace, std::to_string(Value)); }
    void IncreaseValue(const std::string& InputPlace, int Value) { Add("+v" + InputPlace, std::to_string(Value)); }

    // Decrease
    void DecreaseMinLength(const std::string& InputPlace, int Value) { Add("-n" + InputPlace, std::to_string(Value)); }
    void DecreaseMaxLength(const std::string& InputPlace, int Value) { Add("-x" + InputPlace, std::to_string(Value)); }
    void DecreaseFontSize(const std::string& InputPlace, int Value) { Add("-f" + InputPlace, std::to_string(Value)); }
    void DecreaseWidth(const std::string& InputPlace, int Value) { Add("-w" + InputPlace, std::to_string(Value)); }
    void DecreaseHeight(const std::string& InputPlace, int Value) { Add("-h" + InputPlace, std::to_string(Value)); }
    void DecreaseValue(const std::string& InputPlace, int Value) { Add("-v" + InputPlace, std::to_string(Value)); }

    // Event
    void TriggerEvent(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& ConstructorName = "") { 
        Add("TE" + InputPlace, HtmlEventListener + (!ConstructorName.empty() ? "|" + ConstructorName : "")); 
    }
    void SetPostEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Ep" + InputPlace, HtmlEvent); }
    void SetPostEventView(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Ep" + InputPlace, HtmlEvent + "|+"); }
    void SetPostEventTo(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& OutputPlace) { Add("Ep" + InputPlace, HtmlEvent + "|" + OutputPlace); }
    void SetPostEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("EP" + InputPlace, HtmlEventListener); }
    void SetPostEventListenerView(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("EP" + InputPlace, HtmlEventListener + "|+"); }
    void SetPostEventListenerTo(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& OutputPlace) { Add("EP" + InputPlace, HtmlEventListener + "|" + OutputPlace); }
    void SetGetEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Path = "") { Add("Eg" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#")); }
    void SetGetEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& OutputPlace, const std::string& Path = "") { Add("Eg" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#") + "|" + OutputPlace); }
    void SetGetEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& Path = "") { Add("EG" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#")); }
    void SetGetEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& OutputPlace, const std::string& Path = "") { Add("EG" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#") + "|" + OutputPlace); }
    void SetPatchEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Path = "") { Add("Ea" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#")); }
    void SetPatchEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& OutputPlace, const std::string& Path = "") { Add("Ea" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#") + "|" + OutputPlace); }
    void SetPatchEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& Path = "") { Add("EA" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#")); }
    void SetPatchEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& OutputPlace, const std::string& Path = "") { Add("EA" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#") + "|" + OutputPlace); }
    void SetDeleteEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Path = "") { Add("El" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#")); }
    void SetDeleteEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& OutputPlace, const std::string& Path = "") { Add("El" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#") + "|" + OutputPlace); }
    void SetDeleteEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& Path = "") { Add("EL" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#")); }
    void SetDeleteEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& OutputPlace, const std::string& Path = "") { Add("EL" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#") + "|" + OutputPlace); }
    void SetOptionsEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Path = "") { Add("Eo" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#")); }
    void SetOptionsEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& OutputPlace, const std::string& Path = "") { Add("Eo" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#") + "|" + OutputPlace); }
    void SetOptionsEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& Path = "") { Add("EO" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#")); }
    void SetOptionsEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& OutputPlace, const std::string& Path = "") { Add("EO" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#") + "|" + OutputPlace); }
    void SetTraceEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Path = "") { Add("Er" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#")); }
    void SetTraceEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& OutputPlace, const std::string& Path = "") { Add("Er" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#") + "|" + OutputPlace); }
    void SetTraceEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& Path = "") { Add("ER" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#")); }
    void SetTraceEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& OutputPlace, const std::string& Path = "") { Add("ER" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#") + "|" + OutputPlace); }
    void SetConnectEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Path = "") { Add("Ec" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#")); }
    void SetConnectEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& OutputPlace, const std::string& Path = "") { Add("Ec" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#") + "|" + OutputPlace); }
    void SetConnectEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& Path = "") { Add("EC" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#")); }
    void SetConnectEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& OutputPlace, const std::string& Path = "") { Add("EC" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#") + "|" + OutputPlace); }
    void SetHeadEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Path = "") { Add("Eh" + InputPlace, HtmlEvent + "|" + (!Path.empty() ? Path : "#")); }
    void SetHeadEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& Path = "") { Add("EH" + InputPlace, HtmlEventListener + "|" + (!Path.empty() ? Path : "#")); }
    void SetTagEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& OutputPlace) { Add("Et" + InputPlace, HtmlEvent + "|" + OutputPlace); }
    void SetTagEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& OutputPlace) { Add("ET" + InputPlace, HtmlEventListener + "|" + OutputPlace); }
    void SetCommentEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Index = "", const std::string& OutputPlace = "") { Add("Eb" + InputPlace, HtmlEvent + "|" + Index + "|" + OutputPlace); }
    void SetCommentEvent(const std::string& InputPlace, const std::string& HtmlEvent, int Index, const std::string& OutputPlace = "") { SetCommentEvent(InputPlace, HtmlEvent, std::to_string(Index), OutputPlace); }
    void SetCommentEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& Index = "", const std::string& OutputPlace = "") { Add("EB" + InputPlace, HtmlEventListener + "|" + Index + "|" + OutputPlace); }
    void SetCommentEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, int Index, const std::string& OutputPlace = "") { SetCommentEventListener(InputPlace, HtmlEventListener, std::to_string(Index), OutputPlace); }
    
    void SetWasmEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& WasmLanguage, const std::string& WasmUrl, const std::string& MethodName, const std::vector<std::string>& Args = {}, const std::string& OutputPlace = "") {
        std::string ArgsJoin = "";
        if (!Args.empty()) {
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ArgsJoin += ",";
                ArgsJoin += Args[i];
            }
        }
        Add("Ey" + InputPlace, HtmlEvent + "|" + WasmLanguage + "|" + WasmUrl + "|" + MethodName + "|" + ArgsJoin + "|" + OutputPlace);
    }
    
    void SetWasmEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& WasmLanguage, const std::string& WasmUrl, const std::string& MethodName, const std::vector<std::string>& Args = {}, const std::string& OutputPlace = "") {
        std::string ArgsJoin = "";
        if (!Args.empty()) {
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ArgsJoin += ",";
                ArgsJoin += Args[i];
            }
        }
        Add("EY" + InputPlace, HtmlEventListener + "|" + WasmLanguage + "|" + WasmUrl + "|" + MethodName + "|" + ArgsJoin + "|" + OutputPlace);
    }
    
    void SetWebSocketEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Path) { Add("Ew" + InputPlace, HtmlEvent + "|" + Path); }
    void SetWebSocketEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& Path) { Add("EW" + InputPlace, HtmlEventListener + "|" + Path); }
    void SetSSEEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Path, bool ShouldReconnect = true, int ReconnectTryTimeout = 3000) { Add("Ee" + InputPlace, HtmlEvent + "|" + Path + "|" + (ShouldReconnect ? "1" : "0") + "|" + std::to_string(ReconnectTryTimeout)); }
    void SetSSEEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Path, const std::string& OutputPlace, bool ShouldReconnect = true, int ReconnectTryTimeout = 3000) { Add("Ee" + InputPlace, HtmlEvent + "|" + Path + "|" + (ShouldReconnect ? "1" : "0") + "|" + std::to_string(ReconnectTryTimeout) + "|" + OutputPlace); }
    void SetSSEEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& Path, bool ShouldReconnect = true, int ReconnectTryTimeout = 3000) { Add("EE" + InputPlace, HtmlEventListener + "|" + Path + "|" + (ShouldReconnect ? "1" : "0") + "|" + std::to_string(ReconnectTryTimeout)); }
    void SetSSEEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& Path, const std::string& OutputPlace, bool ShouldReconnect = true, int ReconnectTryTimeout = 3000) { Add("EE" + InputPlace, HtmlEventListener + "|" + Path + "|" + (ShouldReconnect ? "1" : "0") + "|" + std::to_string(ReconnectTryTimeout) + "|" + OutputPlace); }
    
    void SetFrontEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& ModulePath, const std::vector<std::string>& Args = {}, const std::string& OutputPlace = "") {
        std::string ArgsJoin = "";
        if (!Args.empty()) {
            ArgsJoin = "|";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ArgsJoin += "|";
                ArgsJoin += Args[i];
            }
        }
        Add("Ej" + InputPlace, HtmlEvent + "|" + ModulePath + "|" + OutputPlace + ArgsJoin);
    }
    
    void SetFrontEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& ModulePath, const std::vector<std::string>& Args = {}, const std::string& OutputPlace = "") {
        std::string ArgsJoin = "";
        if (!Args.empty()) {
            ArgsJoin = "|";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ArgsJoin += "|";
                ArgsJoin += Args[i];
            }
        }
        Add("EJ" + InputPlace, HtmlEventListener + "|" + ModulePath + "|" + OutputPlace + ArgsJoin);
    }
    
    void SetSendEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Data, const std::string& Path = "", const std::string& Method = "POST", bool IsMultiPart = false, const std::string& ContentType = "text/plain", const std::string& OutputPlace = "") {
        std::string processedData = ReplaceAll(ReplaceAll(ReplaceAll(Data, "\n", "$[ln];"), "\"", "$[dq];"), "'", "$[sq];");
        Add("En" + InputPlace, HtmlEvent + "|" + processedData + "|" + (!Path.empty() ? Path : "#") + "|" + Method + "|" + (IsMultiPart ? "1" : "0") + "|" + ContentType + "|" + OutputPlace);
    }
    
    void SetSendEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& Data, const std::string& Path = "", const std::string& Method = "POST", bool IsMultiPart = false, const std::string& ContentType = "text/plain", const std::string& OutputPlace = "") {
        Add("EN" + InputPlace, HtmlEventListener + "|" + ReplaceAll(Data, "\n", "$[ln];") + "|" + (!Path.empty() ? Path : "#") + "|" + Method + "|" + (IsMultiPart ? "1" : "0") + "|" + ContentType + "|" + OutputPlace);
    }
    
    void SetMasterPagesEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& OutputPlace = "") { Add("Eu" + InputPlace, HtmlEvent + "|" + OutputPlace); }
    void SetMasterPagesEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& OutputPlace = "") { Add("EU" + InputPlace, HtmlEventListener + "|" + OutputPlace); }
    void SetPreventDefaultEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Ed" + InputPlace, HtmlEvent); }
    void SetPreventDefaultEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("ED" + InputPlace, HtmlEventListener); }
    void SetStopPropagationEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Es" + InputPlace, HtmlEvent); }
    void SetStopPropagationEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("ES" + InputPlace, HtmlEventListener); }
    
    void SetMethodEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& MethodName, const std::vector<std::string>& Args = {}) {
        std::string ArgsJoin = "";
        if (!Args.empty()) {
            ArgsJoin = "|";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ArgsJoin += "|";
                ArgsJoin += Args[i];
            }
        }
        Add("Em" + InputPlace, HtmlEvent + "|" + MethodName + ArgsJoin);
    }
    
    void SetMethodEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& MethodName, const std::vector<std::string>& Args = {}) {
        std::string ArgsJoin = "";
        if (!Args.empty()) {
            ArgsJoin = "|";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ArgsJoin += "|";
                ArgsJoin += Args[i];
            }
        }
        Add("EM" + InputPlace, HtmlEventListener + "|" + MethodName + ArgsJoin);
    }
    
    void SetModuleMethodEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& MethodName, const std::vector<std::string>& Args = {}) {
        std::string ArgsJoin = "";
        if (!Args.empty()) {
            ArgsJoin = "|";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ArgsJoin += "|";
                ArgsJoin += Args[i];
            }
        }
        Add("Ex" + InputPlace, HtmlEvent + "|" + MethodName + ArgsJoin);
    }
    
    void SetModuleMethodEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& MethodName, const std::vector<std::string>& Args = {}) {
        std::string ArgsJoin = "";
        if (!Args.empty()) {
            ArgsJoin = "|";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ArgsJoin += "|";
                ArgsJoin += Args[i];
            }
        }
        Add("EX" + InputPlace, HtmlEventListener + "|" + MethodName + ArgsJoin);
    }
    
    void AssignConfirmEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& Text = "Are you sure you want to proceed?", const std::string& Type = "none", const std::string& Title = "Confirm", const std::string& OkText = "OK", const std::string& CancelText = "Cancel") {
        Add("Ef" + InputPlace, HtmlEvent + "|" + (Text == "Are you sure you want to proceed?" ? "" : Text) + "|" + (Type == "none" ? "" : Type) + "|" + (Title == "Confirm" ? "" : Title) + "|" + (OkText == "OK" ? "" : OkText) + "|" + (CancelText == "Cancel" ? "" : CancelText));
    }
    
    void RemovePostEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rp" + InputPlace, HtmlEvent); }
    void RemovePostEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RP" + InputPlace, HtmlEventListener); }
    void RemoveGetEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rg" + InputPlace, HtmlEvent); }
    void RemoveGetEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RG" + InputPlace, HtmlEventListener); }
    void RemovePatchEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Ra" + InputPlace, HtmlEvent); }
    void RemovePatchEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RA" + InputPlace, HtmlEventListener); }
    void RemoveDeleteEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rl" + InputPlace, HtmlEvent); }
    void RemoveDeleteEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RL" + InputPlace, HtmlEventListener); }
    void RemoveHeadEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rh" + InputPlace, HtmlEvent); }
    void RemoveHeadEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RH" + InputPlace, HtmlEventListener); }
    void RemoveOptionsEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Ro" + InputPlace, HtmlEvent); }
    void RemoveOptionsEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RO" + InputPlace, HtmlEventListener); }
    void RemoveTraceEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rr" + InputPlace, HtmlEvent); }
    void RemoveTraceEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RR" + InputPlace, HtmlEventListener); }
    void RemoveConnectEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rc" + InputPlace, HtmlEvent); }
    void RemoveConnectEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RC" + InputPlace, HtmlEventListener); }
    void RemoveTagEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rt" + InputPlace, HtmlEvent); }
    void RemoveTagEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RT" + InputPlace, HtmlEventListener); }
    void RemoveCommentEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rb" + InputPlace, HtmlEvent); }
    void RemoveCommentEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RB" + InputPlace, HtmlEventListener); }
    void RemoveWasmEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Ry" + InputPlace, HtmlEvent); }
    void RemoveWasmEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RY" + InputPlace, HtmlEventListener); }
    void RemoveWebSocketEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rw" + InputPlace, HtmlEvent); }
    void RemoveWebSocketEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RW" + InputPlace, HtmlEventListener); }
    void RemoveSSEEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Re" + InputPlace, HtmlEvent); }
    void RemoveSSEEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RE" + InputPlace, HtmlEventListener); }
    void RemoveFrontEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rj" + InputPlace, HtmlEvent); }
    void RemoveFrontEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RJ" + InputPlace, HtmlEventListener); }
    void RemoveSendEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rn" + InputPlace, HtmlEvent); }
    void RemoveSendEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RN" + InputPlace, HtmlEventListener); }
    void RemovePreventDefaultEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rd" + InputPlace, HtmlEvent); }
    void RemovePreventDefaultEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RD" + InputPlace, HtmlEventListener); }
    void RemoveMasterPagesEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Ru" + InputPlace, HtmlEvent); }
    void RemoveMasterPagesEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RU" + InputPlace, HtmlEventListener); }
    void RemoveStopPropagationEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rs" + InputPlace, HtmlEvent); }
    void RemoveStopPropagationEventListener(const std::string& InputPlace, const std::string& HtmlEventListener) { Add("RS" + InputPlace, HtmlEventListener); }
    void RemoveMethodEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& MethodName) { Add("Rm" + InputPlace, HtmlEvent + "|" + MethodName); }
    void RemoveMethodEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& MethodName) { Add("RM" + InputPlace, HtmlEventListener + "|" + MethodName); }
    void RemoveModuleMethodEvent(const std::string& InputPlace, const std::string& HtmlEvent, const std::string& MethodName) { Add("Rx" + InputPlace, HtmlEvent + "|" + MethodName); }
    void RemoveModuleMethodEventListener(const std::string& InputPlace, const std::string& HtmlEventListener, const std::string& MethodName) { Add("RX" + InputPlace, HtmlEventListener + "|" + MethodName); }
    void RemoveConfirmEvent(const std::string& InputPlace, const std::string& HtmlEvent) { Add("Rf" + InputPlace, HtmlEvent); }

    // Custom Event
    void CreateCustomDOMEvent(const std::string& InputPlace, const std::string& EventName, const std::string& Watch, const std::string& Key, const std::string& Compare, const std::string& Value, const std::string& Range, bool Immediate = false, int Delay = 0) {
        Add("eC" + InputPlace, EventName + "|" + Watch + "|" + Key + "|" + Compare + "|" + Value + "|" + Range + "|" + (Immediate ? "1" : "0") + "|" + std::to_string(Delay));
    }
    
    void EnableReachedElementEvent(const std::string& InputPlace, bool Once, bool Enable = true) { 
        std::string value = std::string(Once ? "1" : "0") + "|" + (Enable ? "1" : "0");
        Add("er" + InputPlace, value); 
    }

    // Module
    void LoadModule(const std::string& ModulePath, const std::vector<std::string>& Methods) {
        std::string methodsStr = "";
        if (!Methods.empty()) {
            methodsStr = "|";
            for (size_t i = 0; i < Methods.size(); ++i) {
                if (i > 0) methodsStr += "|";
                methodsStr += Methods[i];
            }
        }
        Add("Ml", ModulePath + methodsStr);
    }
    void UnloadModule(const std::string& ModulePath) { Add("Mu", ModulePath); }
    void DeleteModuleMethod(const std::string& MethodName) { Add("Md", MethodName); }

    // Unit Testing
    void AssertEqual(const std::string& InputPlace, const std::string& Tag) { Add("At" + InputPlace, ReplaceAll(Tag, "\n", "$[ln];")); }
    void AssertEqualByOutputPlace(const std::string& InputPlace, const std::string& OutputPlace) { Add("Ao" + InputPlace, OutputPlace); }

    // Service Worker
    void ServiceWorkerRegister(const std::string& Path = "", const std::string& ScopePath = "") { Add("wR", Path + "|" + ScopePath); }
    void ServiceWorkerPreCacheStatic(const std::vector<std::string>& PathList) {
        std::string paths = "";
        for (size_t i = 0; i < PathList.size(); ++i) {
            if (i > 0) paths += "|";
            paths += PathList[i];
        }
        Add("wp", paths);
    }
    void ServiceWorkerDynamicCache(const std::string& Path, int Seconds = 0) { Add("wc", Path + (Seconds > 0 ? "|" + std::to_string(Seconds) : "")); }
    void ServiceWorkerDeleteDynamicCache() { Add("wd"); }
    void ServiceWorkerDeleteDynamicCache(const std::string& Path) { Add("wd", Path); }
    void ServiceWorkerDynamicCacheTTLUpdate(const std::string& Path, int Seconds = 0) { Add("wt", Path + (Seconds > 0 ? "|" + std::to_string(Seconds) : "")); }
    void ServiceWorkerRouteSet(const std::string& Path, const std::string& Type, bool CacheDynamic = false) { Add("wr", Path + "|" + Type + (CacheDynamic ? "|1" : "")); }
    void ServiceWorkerRouteAlias(const std::string& Path, const std::string& To) { Add("wa", Path + "|" + To); }
    void ServiceWorkerDeleteRouteAlias(const std::string& Path = "") { Add("wC", Path); }
    void ServiceWorkerDeleteRoute() { Add("wD"); }
    void ServiceWorkerDeleteRoute(const std::string& Path) { Add("wD", Path); }

    // SSE
    void DisconnectSSE(const std::string& Path) { Add("Ds", Path); }
    void DisconnectAllSSE() { Add("Ds"); }

    // State
    void AddState(const std::string& Path = "", const std::string& Title = "") { Add("AS", Path + "|" + Title); }
    void DeleteState(const std::string& Path = "") { Add("DS", Path); }
    void DeleteAllState() { Add("DS", "*"); }

    // Cookie
    void SetCookie(const std::string& Key, const std::string& Value, int Seconds, const std::string& Path = "") { 
        Add("sC", Key + "|" + Value + "|" + std::to_string(Seconds) + (!Path.empty() ? "|" + Path : "")); 
    }

    // Save/Session Cache
    void SaveId(const std::string& InputPlace, const std::string& Key = ".") { Add("@gi" + InputPlace, Key); }
    void SaveName(const std::string& InputPlace, const std::string& Key = ".") { Add("@gn" + InputPlace, Key); }
    void SaveValue(const std::string& InputPlace, const std::string& Key = ".") { Add("@gv" + InputPlace, Key); }
    void SaveValueLength(const std::string& InputPlace, const std::string& Key = ".") { Add("@ge" + InputPlace, Key); }
    void SaveClass(const std::string& InputPlace, const std::string& Key = ".") { Add("@gc" + InputPlace, Key); }
    void SaveStyle(const std::string& InputPlace, const std::string& Key = ".") { Add("@gs" + InputPlace, Key); }
    void SaveTitle(const std::string& InputPlace, const std::string& Key = ".") { Add("@gl" + InputPlace, Key); }
    void SaveLabel(const std::string& InputPlace, const std::string& Key = ".") { Add("@gA" + InputPlace, Key); }
    void SaveText(const std::string& InputPlace, const std::string& Key = ".") { Add("@gt" + InputPlace, Key); }
    void SaveOuterText(const std::string& InputPlace, const std::string& Key = ".") { Add("@go" + InputPlace, Key); }
    void SaveTextLength(const std::string& InputPlace, const std::string& Key = ".") { Add("@gg" + InputPlace, Key); }
    void SaveAttribute(const std::string& InputPlace, const std::string& Attribute, const std::string& Key = ".") { Add("@ga" + InputPlace, Key + '|' + Attribute); }
    void SaveWidth(const std::string& InputPlace, const std::string& Key = ".") { Add("@gw" + InputPlace, Key); }
    void SaveHeight(const std::string& InputPlace, const std::string& Key = ".") { Add("@gh" + InputPlace, Key); }
    void SaveReadOnly(const std::string& InputPlace, const std::string& Key = ".") { Add("@gr" + InputPlace, Key); }
    void SaveSelectedIndex(const std::string& InputPlace, const std::string& Key = ".") { Add("@gx" + InputPlace, Key); }
    void SaveTextAlign(const std::string& InputPlace, const std::string& Key = ".") { Add("@gT" + InputPlace, Key); }
    void SaveNodeLength(const std::string& InputPlace, const std::string& Key = ".") { Add("@gL" + InputPlace, Key); }
    void SaveVisible(const std::string& InputPlace, const std::string& Key = ".") { Add("@gV" + InputPlace, Key); }
    void SaveUrl(const std::string& Url, bool FetchScript = false, const std::string& Key = ".") { Add("@gu", Key + "|" + Url + (FetchScript ? "|1" : "")); }
    void SaveIndex(const std::string& InputPlace, const std::string& Key = ".") { Add("@gI" + InputPlace, Key); }
    void RemoveSessionCache(const std::string& CacheKey) { Add("rs", CacheKey); }
    void RemoveAllSessionCache() { Add("rs", "*"); }
    void SetSessionCache() { Add("cs", "*"); }
    void AddSessionCacheValue(const std::string& CacheKey, const std::string& Value) { Add("SA", CacheKey + "|" + ReplaceAll(Value, "\n", "$[ln];")); }
    void InsertSessionCacheValue(const std::string& CacheKey, const std::string& Value) { Add("SI", CacheKey + "|" + ReplaceAll(Value, "\n", "$[ln];")); }

    // Cache
    void CacheId(const std::string& InputPlace, const std::string& Key = ".") { Add("@ci" + InputPlace, Key); }
    void CacheName(const std::string& InputPlace, const std::string& Key = ".") { Add("@cn" + InputPlace, Key); }
    void CacheValue(const std::string& InputPlace, const std::string& Key = ".") { Add("@cv" + InputPlace, Key); }
    void CacheValueLength(const std::string& InputPlace, const std::string& Key = ".") { Add("@ce" + InputPlace, Key); }
    void CacheClass(const std::string& InputPlace, const std::string& Key = ".") { Add("@cc" + InputPlace, Key); }
    void CacheStyle(const std::string& InputPlace, const std::string& Key = ".") { Add("@cs" + InputPlace, Key); }
    void CacheTitle(const std::string& InputPlace, const std::string& Key = ".") { Add("@cl" + InputPlace, Key); }
    void CacheLabel(const std::string& InputPlace, const std::string& Key = ".") { Add("@cA" + InputPlace, Key); }
    void CacheText(const std::string& InputPlace, const std::string& Key = ".") { Add("@ct" + InputPlace, Key); }
    void CacheOuterText(const std::string& InputPlace, const std::string& Key = ".") { Add("@co" + InputPlace, Key); }
    void CacheTextLength(const std::string& InputPlace, const std::string& Key = ".") { Add("@cg" + InputPlace, Key); }
    void CacheAttribute(const std::string& InputPlace, const std::string& Attribute, const std::string& Key = ".") { Add("@ca" + InputPlace, Key + '|' + Attribute); }
    void CacheWidth(const std::string& InputPlace, const std::string& Key = ".") { Add("@cw" + InputPlace, Key); }
    void CacheHeight(const std::string& InputPlace, const std::string& Key = ".") { Add("@ch" + InputPlace, Key); }
    void CacheReadOnly(const std::string& InputPlace, const std::string& Key = ".") { Add("@cr" + InputPlace, Key); }
    void CacheSelectedIndex(const std::string& InputPlace, const std::string& Key = ".") { Add("@cx" + InputPlace, Key); }
    void CacheTextAlign(const std::string& InputPlace, const std::string& Key = ".") { Add("@cT" + InputPlace, Key); }
    void CacheNodeLength(const std::string& InputPlace, const std::string& Key = ".") { Add("@cL" + InputPlace, Key); }
    void CacheVisible(const std::string& InputPlace, const std::string& Key = ".") { Add("@cV" + InputPlace, Key); }
    void CacheUrl(const std::string& Url, bool FetchScript = false, const std::string& Key = ".") { Add("@cu", Key + "|" + Url + (FetchScript ? "|1" : "")); }
    void CacheIndex(const std::string& InputPlace, const std::string& Key = ".") { Add("@cI" + InputPlace, Key); }
    void RemoveCache(const std::string& CacheKey) { Add("rd", CacheKey); }
    void RemoveAllCache() { Add("rd", "*"); }
    void SetCache(int Second) { Add("cd", std::to_string(Second)); }
    void SetCache() { Add("cd", "*"); }
    void AddCacheValue(const std::string& CacheKey, const std::string& Value) { Add("CA", CacheKey + "|" + ReplaceAll(Value, "\n", "$[ln];")); }
    void InsertCacheValue(const std::string& CacheKey, const std::string& Value) { Add("CI", CacheKey + "|" + ReplaceAll(Value, "\n", "$[ln];")); }

    // Call
    void LoadUrl(const std::string& InputPlace, const std::string& Url) { Add("lu" + InputPlace, Url); }
    
    void RunActionControls(const std::string& ActionControls, const std::string& Index = "", bool WithoutWebFormsSection = false, bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + (WithoutWebFormsSection ? "1" : "0") + "|" + Index + "|" + ActionControls;
        Add("lA", value); 
    }
    
    void RunActionControls(const std::string& ActionControls, int Index, bool WithoutWebFormsSection = false, bool UseCurrentEvent = true) { 
        RunActionControls(ActionControls, std::to_string(Index), WithoutWebFormsSection, UseCurrentEvent); 
    }
    
    void CallScript(const std::string& ScriptText) { Add("_", ReplaceAll(ScriptText, "\n", "$[ln];")); }
    
    void CallMethod(const std::string& MethodName, const std::vector<std::string>& Args = {}) {
        std::string ArgsJoin = "";
        if (!Args.empty()) {
            ArgsJoin = "|";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ArgsJoin += "|";
                ArgsJoin += Args[i];
            }
        }
        Add("lm", MethodName + ArgsJoin);
    }
    
    void CallModuleMethod(const std::string& MethodName, const std::vector<std::string>& Args = {}) {
        std::string ArgsJoin = "";
        if (!Args.empty()) {
            ArgsJoin = "|";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ArgsJoin += "|";
                ArgsJoin += Args[i];
            }
        }
        Add("lM", MethodName + ArgsJoin);
    }
    
    void CallPostBack(const std::string& FormInputPlace, const std::string& OutputPlace = "") { 
        std::string value = std::string("1") + "|" + FormInputPlace + (!OutputPlace.empty() ? "|" + OutputPlace : "");
        Add("Lp", value); 
    }
    
    void CallTagBack(const std::string& OutputPlace = "", bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + (!OutputPlace.empty() ? "|" + OutputPlace : "");
        Add("Lt", value); 
    }
    
    void CallCommentBack(const std::string& Index = "", const std::string& OutputPlace = "", bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + Index + "|" + OutputPlace;
        Add("LC", value); 
    }
    
    void CallCommentBack(int Index, const std::string& OutputPlace = "", bool UseCurrentEvent = true) { 
        CallCommentBack(std::to_string(Index), OutputPlace, UseCurrentEvent); 
    }
    
    void CallWasmBack(const std::string& WasmLanguage, const std::string& WasmUrl, const std::string& MethodName, const std::vector<std::string>& Args = {}, const std::string& OutputPlace = "", bool UseCurrentEvent = true) {
        std::string ArgsJoin = "";
        if (!Args.empty()) {
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ArgsJoin += ",";
                ArgsJoin += Args[i];
            }
        }
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + WasmLanguage + "|" + WasmUrl + "|" + MethodName + "|" + ArgsJoin + "|" + OutputPlace;
        Add("Ly", value);
    }
    
    void CallWebSocketBack(const std::string& Path, bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + Path;
        Add("Lw", value); 
    }
    
    void CallSSEBack(const std::string& Path, const std::string& OutputPlace = "", bool UseCurrentEvent = true, bool ShouldReconnect = true, int ReconnectTryTimeout = 3000) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + Path + "|" + (ShouldReconnect ? "1" : "0") + "|" + std::to_string(ReconnectTryTimeout) + (!OutputPlace.empty() ? "|" + OutputPlace : "");
        Add("Ls", value); 
    }
    
    void CallFront(const std::string& ModulePath, const std::vector<std::string>& Args = {}, const std::string& OutputPlace = "", bool UseCurrentEvent = true) {
        std::string ArgsJoin = "";
        if (!Args.empty()) {
            ArgsJoin = "|";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ArgsJoin += "|";
                ArgsJoin += Args[i];
            }
        }
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + ModulePath + "|" + OutputPlace + ArgsJoin;
        Add("Lj", value);
    }
    
    void CallGetBack(const std::string& Path, const std::string& OutputPlace = "", bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + Path + (!OutputPlace.empty() ? "|" + OutputPlace : "");
        Add("Lg", value); 
    }
    
    void CallPutBack(const std::string& Path, const std::string& OutputPlace = "", bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + Path + (!OutputPlace.empty() ? "|" + OutputPlace : "");
        Add("Lu", value); 
    }
    
    void CallPatchBack(const std::string& Path, const std::string& OutputPlace = "", bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + Path + (!OutputPlace.empty() ? "|" + OutputPlace : "");
        Add("LP", value); 
    }
    
    void CallDeleteBack(const std::string& Path, const std::string& OutputPlace = "", bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + Path + (!OutputPlace.empty() ? "|" + OutputPlace : "");
        Add("Ld", value); 
    }
    
    void CallHeadBack(const std::string& Path, const std::string& OutputPlace = "", bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + Path + (!OutputPlace.empty() ? "|" + OutputPlace : "");
        Add("Lh", value); 
    }
    
    void CallOptionsBack(const std::string& Path, const std::string& OutputPlace = "", bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + Path + (!OutputPlace.empty() ? "|" + OutputPlace : "");
        Add("Lo", value); 
    }
    
    void CallTraceBack(const std::string& Path, const std::string& OutputPlace = "", bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + Path + (!OutputPlace.empty() ? "|" + OutputPlace : "");
        Add("LT", value); 
    }
    
    void CallConnectBack(const std::string& Path, const std::string& OutputPlace = "", bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + Path + (!OutputPlace.empty() ? "|" + OutputPlace : "");
        Add("Lc", value); 
    }
    
    void CallSendBack(const std::string& Path, const std::string& Method, bool IsMultiPart, const std::string& ContentType, const std::string& Data, const std::string& OutputPlace = "", bool UseCurrentEvent = true) { 
        std::string value = std::string(UseCurrentEvent ? "1" : "0") + "|" + Path + "|" + Method + "|" + (IsMultiPart ? "1" : "0") + "|" + ContentType + "|" + ReplaceAll(ReplaceAll(Data, "\n", "$[ln];"), "|", "$[vb];") + (!OutputPlace.empty() ? "|" + OutputPlace : "");
        Add("LS", value); 
    }

    // Update
    void Increase(const std::string& InputPlace, float Value) { Add("gt" + InputPlace, "i|" + std::to_string(Value)); }
    void Decrease(const std::string& InputPlace, float Value) { Increase(InputPlace, Value * -1); }
    
    void Replace(const std::string& InputPlace, const std::string& Value, const std::string& NewValue, bool AlsoStartTag = false, bool Deep = false) {
        std::string processedValue = Value;
        std::string processedNewValue = NewValue;
        
        if (!processedValue.empty() && processedValue[0] == '@') {
            processedValue = processedValue.substr(1);
            processedValue = "$[at];" + processedValue;
        }
        
        if (!processedNewValue.empty() && processedNewValue[0] == '@') {
            processedNewValue = processedNewValue.substr(1);
            processedNewValue = "$[at];" + processedNewValue;
        }
        
        Add("gt" + InputPlace, "r|" + processedValue + "|" + processedNewValue + "|" + (AlsoStartTag ? "1" : "0") + "|" + (Deep ? "1" : "0"));
    }
    
    void ReplaceStartTag(const std::string& InputPlace, const std::string& Value, const std::string& NewValue) {
        std::string processedValue = Value;
        std::string processedNewValue = NewValue;
        
        if (!processedValue.empty() && processedValue[0] == '@') {
            processedValue = processedValue.substr(1);
            processedValue = "$[at];" + processedValue;
        }
        
        if (!processedNewValue.empty() && processedNewValue[0] == '@') {
            processedNewValue = processedNewValue.substr(1);
            processedNewValue = "$[at];" + processedNewValue;
        }
        
        Add("gt" + InputPlace, "s|" + processedValue + "|" + processedNewValue);
    }

    // Pre Runner
    void AssignDelay(int MiliSecond, int Index = -1) {
        std::string currentLine = GetLineByIndex(Index);
        if (currentLine.empty())
            return;
        
        size_t eqPos = currentLine.find('=');
        std::string name = (eqPos == std::string::npos) ? currentLine : currentLine.substr(0, eqPos);
        std::string value = (eqPos == std::string::npos) ? "" : currentLine.substr(eqPos + 1);
        
        std::string newName = ":" + std::to_string(MiliSecond) + ")" + name;
        UpdateLineByIndex(Index, newName, value);
    }
    
    void AssignDelayChange(int MiliSecond, int Index = -1) {
        std::string currentLine = GetLineByIndex(Index);
        if (currentLine.empty())
            return;
        
        size_t eqPos = currentLine.find('=');
        std::string name = (eqPos == std::string::npos) ? currentLine : currentLine.substr(0, eqPos);
        std::string value = (eqPos == std::string::npos) ? "" : currentLine.substr(eqPos + 1);
        
        if (name.find(":") == 0 && name.find(")") != std::string::npos) {
            size_t closingBracket = name.find(")");
            name = name.substr(closingBracket + 1);
        }
        
        std::string newName = ":" + std::to_string(MiliSecond) + ")" + name;
        UpdateLineByIndex(Index, newName, value);
    }
    
    void AssignInterval(int MiliSecond, const std::string& Id = "", int Index = -1) {
        std::string currentLine = GetLineByIndex(Index);
        if (currentLine.empty())
            return;
        
        size_t eqPos = currentLine.find('=');
        std::string name = (eqPos == std::string::npos) ? currentLine : currentLine.substr(0, eqPos);
        std::string value = (eqPos == std::string::npos) ? "" : currentLine.substr(eqPos + 1);
        
        std::string newName = "(" + std::to_string(MiliSecond) + (!Id.empty() ? "|" + Id : "") + ")" + name;
        UpdateLineByIndex(Index, newName, value);
    }
    
    void AssignIntervalChange(int MiliSecond, const std::string& Id = "", int Index = -1) {
        std::string currentLine = GetLineByIndex(Index);
        if (currentLine.empty())
            return;
        
        size_t eqPos = currentLine.find('=');
        std::string name = (eqPos == std::string::npos) ? currentLine : currentLine.substr(0, eqPos);
        std::string value = (eqPos == std::string::npos) ? "" : currentLine.substr(eqPos + 1);
        
        if (name.find("(") == 0 && name.find(")") != std::string::npos) {
            size_t closingBracket = name.find(")");
            name = name.substr(closingBracket + 1);
        }
        
        std::string newName = "(" + std::to_string(MiliSecond) + (!Id.empty() ? "|" + Id : "") + ")" + name;
        UpdateLineByIndex(Index, newName, value);
    }
    
    void DeleteInterval(const std::string& Id) { Add("Di", Id); }
    
    void AssignRepeat(int Count, int Index = -1) {
        std::string currentLine = GetLineByIndex(Index);
        if (currentLine.empty())
            return;
        
        size_t eqPos = currentLine.find('=');
        std::string name = (eqPos == std::string::npos) ? currentLine : currentLine.substr(0, eqPos);
        std::string value = (eqPos == std::string::npos) ? "" : currentLine.substr(eqPos + 1);
        
        std::string newName = "," + std::to_string(Count) + ")" + name;
        UpdateLineByIndex(Index, newName, value);
    }
    
    void AssignRepeatChange(int Count, int Index = -1) {
        std::string currentLine = GetLineByIndex(Index);
        if (currentLine.empty())
            return;
        
        size_t eqPos = currentLine.find('=');
        std::string name = (eqPos == std::string::npos) ? currentLine : currentLine.substr(0, eqPos);
        std::string value = (eqPos == std::string::npos) ? "" : currentLine.substr(eqPos + 1);
        
        if (name.find(",") == 0 && name.find(")") != std::string::npos) {
            size_t closingBracket = name.find(")");
            name = name.substr(closingBracket + 1);
        }
        
        std::string newName = "," + std::to_string(Count) + ")" + name;
        UpdateLineByIndex(Index, newName, value);
    }

    // Index
    void StartIndex(const std::string& Name) { Add("#", Name); }
    void StartIndex() { StartIndex(""); }
    void GoTo(int Line, int Repeat = 1) { Add("&", std::to_string(Line) + "|" + std::to_string(Repeat)); }
    void GoTo(const std::string& Index, int Repeat = 1) { Add("&", "#" + Index + "|" + std::to_string(Repeat)); }
    
    // Start
    void StartTransientDOM(const std::string& InputPlace) { Add("td", InputPlace); }
    void EndTransientDOM() { Add("td", ";"); }

    // Message
    void Alert(const std::string& Text, const std::string& Type = "none", const std::string& Title = "Alert", const std::string& OkText = "OK") { 
        Add("Al", Text + "|" + (Type == "none" ? "" : Type) + "|" + (Title == "Alert" ? "" : Title) + "|" + (OkText == "OK" ? "" : OkText)); 
    }
    void Message(const std::string& Text, const std::string& Type = "none", int Duration = 0) { 
        Add("me", Text + "|" + (Type == "none" ? "" : Type) + "|" + (Duration == 0 ? "" : std::to_string(Duration))); 
    }
    void ConsoleMessage(const std::string& Text, const std::string& Type = "log") { 
        Add("mc", ReplaceAll(Text, "\n", "$[ln];") + (Type == "log" ? "" : "|" + Type)); 
    }
    void ConsoleMessageAssert(const std::string& Text, const std::string& Condition) { 
        Add("ma", ReplaceAll(Text, "\n", "$[ln];") + "|" + Condition); 
    }

    // Enable
    void EnableWebSocket(bool Enable = true) { Add("ew", Enable ? "1" : "0"); }
    void EnableWebSocketOnce() { Add("ew", "$"); }
    void AddWebSocket(const std::string& Path) { Add("aw" + Path); }

    // Use
    void UseWebSocket(const std::string& InputPlace) { Add("uw" + InputPlace); }
    void UseOnlyChangeUpdate(const std::string& InputPlace) { Add("uo" + InputPlace); }

    // Condition
    void ConfirmIsTrueAccept(const std::string& Text = "Are you sure you want to proceed?", const std::string& Type = "none", const std::string& Title = "Confirm", const std::string& OkText = "OK", const std::string& CancelText = "Cancel", float Interval = 100) { 
        Add(((Interval >= 0) ? "{(" + std::to_string((int)Interval) + ")" : "{") + "ct", (Text == "Are you sure you want to proceed?" ? "" : Text) + "|" + (Type == "none" ? "" : Type) + "|" + (Title == "Confirm" ? "" : Title) + "|" + (OkText == "OK" ? "" : OkText) + "|" + (CancelText == "Cancel" ? "" : CancelText)); 
    }
    void ConfirmIsFalseAccept(const std::string& Text = "Are you sure you want to proceed?", const std::string& Type = "none", const std::string& Title = "Confirm", const std::string& OkText = "OK", const std::string& CancelText = "Cancel", float Interval = 100) { 
        Add(((Interval >= 0) ? "{(" + std::to_string((int)Interval) + ")" : "{") + "cf", (Text == "Are you sure you want to proceed?" ? "" : Text) + "|" + (Type == "none" ? "" : Type) + "|" + (Title == "Confirm" ? "" : Title) + "|" + (OkText == "OK" ? "" : OkText) + "|" + (CancelText == "Cancel" ? "" : CancelText)); 
    }
    void IsGreaterThan(const std::string& FirstValue, const std::string& SecondValue, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "gt", FirstValue + "|" + SecondValue); 
    }
    void IsLessThan(const std::string& FirstValue, const std::string& SecondValue, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "lt", FirstValue + "|" + SecondValue); 
    }
    void IsEqualTo(const std::string& FirstValue, const std::string& SecondValue, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "et", FirstValue + "|" + SecondValue); 
    }
    void IsNotEqualTo(const std::string& FirstValue, const std::string& SecondValue, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "Nt", FirstValue + "|" + SecondValue); 
    }
    void Exist(const std::string& Value, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "ex", Value); 
    }
    void NotExist(const std::string& Value, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "nx", Value); 
    }
    void IsTrue(const std::string& Value, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "tr", Value); 
    }
    void IsFalse(const std::string& Value, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "fa", Value); 
    }
    void IsMatchMedia(const std::string& Value, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "mm", Value); 
    }
    void IsNotMatchMedia(const std::string& Value, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "nm", Value); 
    }
    void Include(const std::string& Text, const std::string& Value, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "In", Value + "|" + Text); 
    }
    void NotInclude(const std::string& Text, const std::string& Value, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "Nn", Value + "|" + Text); 
    }
    void ElementExists(const std::string& InputPlace, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "eE", InputPlace); 
    }
    void ElementNotExists(const std::string& InputPlace, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "nE", InputPlace); 
    }
    void IsRegexMatch(const std::string& Value, const std::string& Pattern, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "re", Value + "|" + Pattern); 
    }
    void IsRegexNotMatch(const std::string& Value, const std::string& Pattern, int Interval = -1) { 
        Add(((Interval >= 0) ? "{(" + std::to_string(Interval) + ")" : "{") + "rn", Value + "|" + Pattern); 
    }
    void Break() { Add(";"); }
    void StartBracket() { Add("{"); }
    void EndBracket() { Add("}"); }

    // Async
    void Async() { Add("{(a)"); }
    void Delay(int MiliSecond) { Add("De", std::to_string(MiliSecond)); }

    // Format Storage
    void CreateFormatStorage(const std::string& Key, const std::string& Data) { Add(".C", Key + "|" + Data); }
    void DeleteFormatStorage(const std::string& Key) { Add(".D", Key); }
    void AddJSON(const std::string& Key, const std::string& Path, const std::string& Value) { Add(".a", Key + "|j|" + Value + "|" + Path); }
    
    void AddXML(const std::string& Key, const std::string& Path, const std::string& Name, const std::string& Value = "") {
        std::string processedName = Name;
        if (!processedName.empty() && processedName[0] == '@') {
            processedName = processedName.substr(1);
            processedName = "$[at];" + processedName;
        }
        processedName = ReplaceAll(processedName, "@", "$[at];");
        Add(".a", Key + "|x|" + processedName + "|" + Value + "|" + Path);
    }
    
    void AddINI(const std::string& Key, const std::string& Path, const std::string& Value, bool IsINILike = false) { 
        Add(".a", Key + "|i|" + (IsINILike ? "1" : "0") + "|" + Value + "|" + Path); 
    }
    void AddTextLine(const std::string& Key, int Line, const std::string& Text) { Add(".a", Key + "|t|" + Text + "|" + std::to_string(Line)); }
    void AddVariable(const std::string& Key, const std::string& Value) { Add(".a", Key + "|v|" + Value); }
    void UpdateJSON(const std::string& Key, const std::string& Path, const std::string& Value) { Add(".u", Key + "|j|" + Value + "|" + Path); }
    void UpdateXML(const std::string& Key, const std::string& Path, const std::string& Value) { Add(".u", Key + "|x|" + Value + "|" + Path); }
    void UpdateINI(const std::string& Key, const std::string& Path, const std::string& Value, bool IsINILike = false) { 
        Add(".u", Key + "|i|" + (IsINILike ? "1" : "0") + "|" + Value + "|" + Path); 
    }
    void UpdateTextLine(const std::string& Key, int Line, const std::string& Text) { Add(".u", Key + "|t|" + Text + "|" + std::to_string(Line)); }
    void UpdateVariable(const std::string& Key, const std::string& Value) { Add(".u", Key + "|v|" + Value); }
    void IncreaseVariable(const std::string& Key, int Value) { Add(".i", Key + "|v|" + std::to_string(Value)); }
    void DecreaseVariable(const std::string& Key, int Value) { IncreaseVariable(Key, Value * -1); }
    void DeleteJSON(const std::string& Key, const std::string& Path) { Add(".d", Key + "|j|" + Path); }
    void DeleteXML(const std::string& Key, const std::string& Path) { Add(".d", Key + "|x|" + Path); }
    void DeleteINI(const std::string& Key, const std::string& Path, bool IsINILike = false) { 
        Add(".d", Key + "|i|" + (IsINILike ? "1" : "0") + "|" + Path); 
    }
    void DeleteTextLine(const std::string& Key, int Line) { Add(".d", Key + "|t|" + std::to_string(Line)); }
    void DeleteVariable(const std::string& Key) { Add(".d", Key + "|v"); }

    // Inject
    std::string Inject(const std::string& Value) { return "$[" + Value + "];"; }

    // Hash And Checksum
    void SetHash() { Add("SH"); }
    void SetChecksum() { Add("CS"); }

    static std::string ChecksumCalculation(const std::string& Text) {
        int sum = 0;
        int mod = 65536;
        int shift = 5;
        
        for (char c : Text) {
            sum = ((sum << shift) | (sum >> (16 - shift))) ^ (int)c;
            sum %= mod;
        }
        
        return std::to_string(sum);
    }

    std::string GetChecksum() { return ChecksumCalculation(GetWebFormsData()); }

    // Get
    std::string GetFormsActionData() {
        return WebFormsData.str();
    }

    std::string Response() {
        return "[web-forms]\n" + GetFormsActionData();
    }

    std::string GetFormsActionDataLineBreak() {
        std::string data = WebFormsData.str();
        if (data.empty())
            return "";
        
        std::string processedData = ReplaceAll(data, "\"", "$[dq];");
        return ReplaceAll(processedData, "\n", "$[sln];");
    }

    // Export
    std::string ExportToWebFormsTag(const std::string& src = "") {
        return "<web-forms ac=\"" + GetFormsActionDataLineBreak() + "\"" + (!src.empty() ? " src=\"" + src + "\"" : "") + "></web-forms>";
    }

    std::string ExportToLineBreak(const std::string& src = "") {
        return "[web-forms]$[sln];" + GetFormsActionDataLineBreak();
    }

    std::string ExportToWebFormsTag(const std::string& Width, const std::string& Height, const std::string& src = "") {
        return "<web-forms ac=\"" + GetFormsActionDataLineBreak() + "\" width=\"" + Width + "\" height=\"" + Height + "\"" + (!src.empty() ? " src=\"" + src + "\"" : "") + "></web-forms>";
    }

    std::string ExportToWebFormsTag(int Width, int Height, const std::string& src = "") {
        return ExportToWebFormsTag(std::to_string(Width) + "px", std::to_string(Height) + "px", src);
    }

    std::string DoneToWebFormsTag(const std::string& Id = "") {
        return "<web-forms ac=\"" + GetFormsActionDataLineBreak() + "\"" + (!Id.empty() ? " id=\"" + Id + "\" done=\"true\"" : "") + "></web-forms>";
    }
    
    std::string ExportToHtmlComment(bool AddLine = false) {
        std::string result = (AddLine ? "\n" : std::string("")) + std::string("<!--") + Response() + "-->";
        return result;
    }

    std::string GetWebFormsData() {
        return WebFormsData.str();
    }

    void AppendForm(WebForms* form) {
        if (form == nullptr) return;
        
        std::string otherData = form->GetWebFormsData();
        if (!otherData.empty()) {
            if (!WebFormsData.str().empty())
                WebFormsData << '\n';
            WebFormsData << otherData;
        }
    }

    void Clean() {
        WebFormsData.str("");
        WebFormsData.clear();
    }
};

class Security {
public:
    static std::string SafeValue(const std::string& Value) {
        if (Value.empty())
            return Value;
        
        std::string result = Value;
        if (result[0] == '@') {
            result = result.substr(1);
            result = "$[at];" + result;
        }
        
        result = WebForms::ReplaceAll(result, "\n", "$[ln];");
        result = WebForms::ReplaceAll(result, "|", "$[vb];");
        result = WebForms::ReplaceAll(result, ",@", "$[co];@");
        
        return result;
    }
};

class InputPlace {
public:
    static const std::string Window;
    static const std::string Root;
    static const std::string Current;
    static const std::string Target;
    static const std::string Upper;
    static const std::string Head;
    static const std::string ScreenOrientation;

    static std::string Id(const std::string& id) { return id; }
    static std::string Name(const std::string& name) { return "(" + name + ")"; }
    static std::string Name(const std::string& name, int index) { return "(" + name + ")" + std::to_string(index); }
    static std::string AllNames(const std::string& name) { return "(" + name + ")*"; }
    static std::string Tag(const std::string& tag) { return "<" + tag + ">"; }
    static std::string Tag(const std::string& tag, int index) { return "<" + tag + ">" + std::to_string(index); }
    static std::string AllTags(const std::string& tag) { return "<" + tag + ">*"; }
    static std::string Class(const std::string& className) { return "{" + className + "}"; }
    static std::string Class(const std::string& className, int index) { return "{" + className + "}" + std::to_string(index); }
    static std::string AllClasses(const std::string& className) { return "{" + className + "}*"; }
    static std::string Query(const std::string& query) { return "*" + WebForms::ReplaceAll(query, "=", "$[eq];"); }
    static std::string QueryAll(const std::string& query) { return "[" + WebForms::ReplaceAll(query, "=", "$[eq];"); }
};

const std::string InputPlace::Window = "`";
const std::string InputPlace::Root = "~";
const std::string InputPlace::Current = "$";
const std::string InputPlace::Target = "!";
const std::string InputPlace::Upper = "-";
const std::string InputPlace::Head = "^";
const std::string InputPlace::ScreenOrientation = "%";

class OutputPlace : public InputPlace {};

class Fetch {
public:
    // Method
    static std::string Random(int MaxValue) { return "@mr" + std::to_string(MaxValue); }
    static std::string Random(int MinValue, int MaxValue) { return "@mr" + std::to_string(MaxValue) + "," + std::to_string(MinValue); }
    static std::string SpaceToChar(const std::string& Text, const std::string& Character = "-") { return "@sc" + Character + "," + Text; }
    static std::string EncodeURI(const std::string& Text) { return "@ue" + Text; }
    static std::string DecodeURI(const std::string& Text) { return "@ud" + Text; }

    static std::string Method(const std::string& MethodName, const std::vector<std::string>& Args = {}) {
        std::string ReturnValue = "@cm" + MethodName;
        if (!Args.empty()) {
            ReturnValue += ",";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ReturnValue += ",";
                ReturnValue += Args[i];
            }
        }
        return ReturnValue;
    }

    static std::string ModuleMethod(const std::string& MethodName, const std::vector<std::string>& Args = {}) {
        std::string ReturnValue = "@cM" + MethodName;
        if (!Args.empty()) {
            ReturnValue += ",";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ReturnValue += ",";
                ReturnValue += Args[i];
            }
        }
        return ReturnValue;
    }

    static std::string WasmMethod(const std::string& WasmLanguage, const std::string& WasmUrl, const std::string& MethodName, const std::vector<std::string>& Args = {}, const std::string& Key = ".") {
        std::string ReturnValue = "@wA" + WasmLanguage + "," + WasmUrl + "," + MethodName;
        if (!Args.empty()) {
            ReturnValue += ",";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ReturnValue += ",";
                ReturnValue += Args[i];
            }
        }
        return ReturnValue;
    }

    static std::string Script(const std::string& ScriptText) { return "@_" + WebForms::ReplaceAll(ScriptText, "\n", "$[ln];"); }
    static std::string LoadUrl(const std::string& Url, bool FetchScript = false) { return "@lu" + Url + (FetchScript ? ",1" : ""); }
    static std::string LoadHtml(const std::string& Url, const std::string& FetchInputPlace, bool FetchScript = false) { return "@lh" + Url + "," + (FetchScript ? "1" : "0") + (!FetchInputPlace.empty() ? "," + FetchInputPlace : ""); }
    static std::string LoadLine(const std::string& Url, int Line) { return "@ll" + Url + "," + std::to_string(Line); }
    static std::string LoadINI(const std::string& Url, const std::string& Name, bool IsINILike = false) { return "@li" + Url + "," + Name + (IsINILike ? ",1" : ""); }
    static std::string LoadJSON(const std::string& Url, const std::string& Name) { return "@lj" + Url + "," + Name; }
    static std::string LoadXML(const std::string& Url, const std::string& Name) { return "@lx" + Url + "," + Name; }
    static std::string HasMethod(const std::string& MethodName) { return "@hm" + MethodName; }
    static std::string HasModuleMethod(const std::string& MethodName) { return "@hM" + MethodName; }
    static std::string GetModifierState(const std::string& Modifier) { return "@ms" + Modifier; }

    static std::string Math(const std::string& MethodName, const std::vector<std::string>& Args = {}) {
        std::string ReturnValue = "@M#" + MethodName;
        if (!Args.empty()) {
            ReturnValue += ",";
            for (size_t i = 0; i < Args.size(); ++i) {
                if (i > 0) ReturnValue += ",";
                ReturnValue += Args[i];
            }
        }
        return ReturnValue;
    }

    // Data
    static const std::string DateYear;
    static const std::string DateMonth;
    static const std::string DateDay;
    static const std::string DateHours;
    static const std::string DateMinutes;
    static const std::string DateSeconds;
    static const std::string DateMilliseconds;

    // String
    static const std::string Space;
    static const std::string AtSign;

    // Tag
    static std::string GetId(const std::string& InputPlace) { return "@$i" + InputPlace; }
    static std::string GetName(const std::string& InputPlace) { return "@$n" + InputPlace; }
    static std::string GetValue(const std::string& InputPlace) { return "@$v" + InputPlace; }
    static std::string GetValueLength(const std::string& InputPlace) { return "@$e" + InputPlace; }
    static std::string GetClass(const std::string& InputPlace) { return "@$c" + InputPlace; }
    static std::string GetStyle(const std::string& InputPlace) { return "@$s" + InputPlace; }
    static std::string GetTitle(const std::string& InputPlace) { return "@$l" + InputPlace; }
    static std::string GetLabel(const std::string& InputPlace) { return "@$A" + InputPlace; }
    static std::string GetText(const std::string& InputPlace) { return "@$t" + InputPlace; }
    static std::string GetOuterText(const std::string& InputPlace) { return "@$o" + InputPlace; }
    static std::string GetTextLength(const std::string& InputPlace) { return "@$g" + InputPlace; }
    static std::string GetAttribute(const std::string& InputPlace, const std::string& Attribute) { return "@$a" + InputPlace + "," + Attribute; }
    static std::string GetWidth(const std::string& InputPlace) { return "@$w" + InputPlace; }
    static std::string GetHeight(const std::string& InputPlace) { return "@$h" + InputPlace; }
    static std::string GetIsReadOnly(const std::string& InputPlace) { return "@$r" + InputPlace; }
    static std::string GetSelectedIndex(const std::string& InputPlace) { return "@$x" + InputPlace; }
    static std::string GetIndex(const std::string& InputPlace) { return "@$I" + InputPlace; }
    static std::string GetTextAlign(const std::string& InputPlace) { return "@$T" + InputPlace; }
    static std::string GetNodeLength(const std::string& InputPlace) { return "@$L" + InputPlace; }
    static std::string GetIsVisible(const std::string& InputPlace) { return "@$V" + InputPlace; }

    // Save
    static std::string HasHash(const std::string& Hash) { return "@HH" + Hash; }
    static std::string Cookie(const std::string& Key) { return "@co" + Key; }
    static std::string Session(const std::string& Key) { return "@cs" + Key; }
    static std::string Session(const std::string& Key, const std::string& ReplaceValue) { return "@cs" + Key + "," + ReplaceValue; }
    static std::string SessionAndRemove(const std::string& Key) { return "@cl" + Key; }
    static std::string Saved(const std::string& Key = ".") { return Session(Key); }
    static std::string Cache(const std::string& Key = ".") { return "@cd" + Key; }
    static std::string Cache(const std::string& Key, const std::string& ReplaceValue) { return "@cd" + Key + "," + ReplaceValue; }
    static std::string CacheAndRemove(const std::string& Key) { return "@ct" + Key; }
    static std::string SavedLine(const std::string& Key = ".", int Line = 0) { return "@lL" + Key + "[" + std::to_string(Line); }
    static std::string SavedLineConsume(const std::string& Key = ".") { return "@lL" + Key; }
    static std::string SavedINI(const std::string& Key, const std::string& INIKey) { return "@lI" + Key + "[" + INIKey; }
    static std::string CacheLine(const std::string& Key = ".", int Line = 0) { return "@dL" + Key + "[" + std::to_string(Line); }
    static std::string CacheLineConsume(const std::string& Key = ".") { return "@dL" + Key; }
    static std::string CacheINI(const std::string& Key, const std::string& INIKey) { return "@dI" + Key + "[" + INIKey; }

    // Format Storage
    static std::string FormatStore(const std::string& Key) { return "@fr" + Key; }
    static std::string FormatStoreByXMLQuery(const std::string& Key, const std::string& XPath) { return "@fx" + Key + "," + XPath; }
    static std::string FormatStoreByJSONQuery(const std::string& Key, const std::string& Query) { return "@fj" + Key + "," + Query; }
    static std::string FormatStoreByINI(const std::string& Key, const std::string& Name) { return "@fi" + Key + "," + Name; }
    static std::string FormatStoreByText(const std::string& Key, int Line) { return "@ft" + Key + "," + std::to_string(Line); }
    static std::string FormatStoreByVariable(const std::string& Key) { return "@fv" + Key; }

    // Document
    static const std::string TabIsActive;

    // Window
    static const std::string Href;
    static const std::string PathName;
    static const std::string Query;
    static const std::string Hash;
    static const std::string Host;
    static const std::string HostName;
    static const std::string Port;
    static const std::string Origin;
    static const std::string GetSelection;
    static const std::string ScrollX;
    static const std::string ScrollY;

    // Navigator
    static const std::string ClipboardText;
    static const std::string GeoLatitude;
    static const std::string GeoLongitude;
    static const std::string Language;
    static const std::string IsOnLine;
    static const std::string UserAgent;

    // Screen
    static const std::string ScreenWidth;
    static const std::string ScreenHeight;
    static const std::string ScreenOrientationType;
    static const std::string ScreenOrientationAngle;

    // Performance
    static const std::string TimeOrigin;
    static const std::string PerformanceNow;

    // Event
    static const std::string Event;
    static const std::string EventSerialize;
    static const std::string EventKey;
    static const std::string EventWhich;
    static const std::string EventClientX;
    static const std::string EventClientY;
    static const std::string EventPageX;
    static const std::string EventPageY;
    static const std::string EventOffsetX;
    static const std::string EventOffsetY;
    static const std::string EventDeltaY;
};

const std::string Fetch::DateYear = "@dy";
const std::string Fetch::DateMonth = "@dm";
const std::string Fetch::DateDay = "@dd";
const std::string Fetch::DateHours = "@dh";
const std::string Fetch::DateMinutes = "@di";
const std::string Fetch::DateSeconds = "@ds";
const std::string Fetch::DateMilliseconds = "@dl";
const std::string Fetch::Space = "@sp";
const std::string Fetch::AtSign = "@sa";
const std::string Fetch::TabIsActive = "@da";
const std::string Fetch::Href = "@wf";
const std::string Fetch::PathName = "@wP";
const std::string Fetch::Query = "@wq";
const std::string Fetch::Hash = "@wh";
const std::string Fetch::Host = "@wH";
const std::string Fetch::HostName = "@wn";
const std::string Fetch::Port = "@wT";
const std::string Fetch::Origin = "@wo";
const std::string Fetch::GetSelection = "@ws";
const std::string Fetch::ScrollX = "@wx";
const std::string Fetch::ScrollY = "@wy";
const std::string Fetch::ClipboardText = "@nC";
const std::string Fetch::GeoLatitude = "@nW";
const std::string Fetch::GeoLongitude = "@nO";
const std::string Fetch::Language = "@nL";
const std::string Fetch::IsOnLine = "@no";
const std::string Fetch::UserAgent = "@na";
const std::string Fetch::ScreenWidth = "@sw";
const std::string Fetch::ScreenHeight = "@sh";
const std::string Fetch::ScreenOrientationType = "@so";
const std::string Fetch::ScreenOrientationAngle = "@sr";
const std::string Fetch::TimeOrigin = "@pt";
const std::string Fetch::PerformanceNow = "@pn";
const std::string Fetch::Event = "@EV";
const std::string Fetch::EventSerialize = "@Es";
const std::string Fetch::EventKey = "@ek";
const std::string Fetch::EventWhich = "@ew";
const std::string Fetch::EventClientX = "@ex";
const std::string Fetch::EventClientY = "@ey";
const std::string Fetch::EventPageX = "@eX";
const std::string Fetch::EventPageY = "@eY";
const std::string Fetch::EventOffsetX = "@Ex";
const std::string Fetch::EventOffsetY = "@Ey";
const std::string Fetch::EventDeltaY = "@ed";

class WasmLanguage {
public:
    static const std::string C;
    static const std::string CPP;
    static const std::string Rust;
    static const std::string CSharp;
    static const std::string GO;
    static const std::string JAVA;
    static const std::string AssemblyScript;
};

const std::string WasmLanguage::C = "c";
const std::string WasmLanguage::CPP = "c";
const std::string WasmLanguage::Rust = "rust";
const std::string WasmLanguage::CSharp = "csharp";
const std::string WasmLanguage::GO = "go";
const std::string WasmLanguage::JAVA = "java";
const std::string WasmLanguage::AssemblyScript = "as";

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
    static const std::string OnWheel;
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
const std::string HtmlEvent::OnWheel = "onwheel";

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
    static const std::string Wheel;

    static const std::string AnimationEnd;
    static const std::string AnimationIteration;
    static const std::string AnimationStart;
    static const std::string ContextMenu;
    static const std::string FullScreenChange;
    static const std::string FullScreenError;
    static const std::string PopState;
    static const std::string TransitionEnd;
    static const std::string Storage;

    // Custom
    static const std::string ScrollBottom;
    static const std::string ElementReached;
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
const std::string HtmlEventListener::Wheel = "wheel";
const std::string HtmlEventListener::AnimationEnd = "animationend";
const std::string HtmlEventListener::AnimationIteration = "animationiteration";
const std::string HtmlEventListener::AnimationStart = "animationstart";
const std::string HtmlEventListener::ContextMenu = "contextmenu";
const std::string HtmlEventListener::FullScreenChange = "fullscreenchange";
const std::string HtmlEventListener::FullScreenError = "fullscreenerror";
const std::string HtmlEventListener::PopState = "popstate";
const std::string HtmlEventListener::TransitionEnd = "transitionend";
const std::string HtmlEventListener::Storage = "storage";
const std::string HtmlEventListener::ScrollBottom = "scrollbottom";
const std::string HtmlEventListener::ElementReached = "elementreached";

class ExtensionWebFormsMethods {
public:
    static std::string AppendPlace(const std::string& Text, const std::string& Value) {
        if (Text.empty()) return Value;
        return Text + "|" + Value;
    }

    static std::string AppendParent(const std::string& Text) {
        return "/" + Text;
    }

    static std::string ExportActionControlsToWebFormsTag(const std::string& ActionControls, bool AddLine = false) {
        std::string result = (AddLine ? "\n" : std::string("")) + std::string("<web-forms ac=\"") + ActionControls + "\"></web-forms>";
        return result;
    }

    static std::string ExportActionControlsToHtmlComment(const std::string& ActionControls, bool AddLine = false) {
        std::string result = (AddLine ? "\n" : std::string("")) + std::string("<!--[web-forms]\n") + ActionControls + "-->";
        return result;
    }

    static std::string ExportActionControlsToResponse(const std::string& ActionControls) {
        return "[web-forms]\n" + ActionControls;
    }

    static std::string RemoveOuter(std::string Text, const std::string& StartString, const std::string& EndString) {
        size_t Start = Text.find(StartString);
        if (Start == std::string::npos)
            return Text;
        
        size_t End = Text.find(EndString, Start);
        if (End == std::string::npos)
            return Text;
        
        size_t lengthToRemove = (End - Start) + EndString.length();
        return Text.erase(Start, lengthToRemove);
    }

    static std::string LineBreak(const std::string& Text) {
        return WebForms::ReplaceAll(Text, "\n", "$[sln]");
    }
};
