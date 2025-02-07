package WebFormsCore;

// Compatible with WebFormsJS version 1.6

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;

public class WebForms {
    private NameValueCollection webFormsData = new NameValueCollection();

    // For Extension
    public void addLine(String name, String value) {
        webFormsData.add(name, value);
    }

    // Add
    public void addId(String inputPlace, String id) {
        webFormsData.add("ai" + inputPlace, id);
    }

    public void addName(String inputPlace, String name) {
        webFormsData.add("an" + inputPlace, name);
    }

    public void addValue(String inputPlace, String value) {
        webFormsData.add("av" + inputPlace, value);
    }

    public void addClass(String inputPlace, String className) {
        webFormsData.add("ac" + inputPlace, className);
    }

    public void addStyle(String inputPlace, String style) {
        webFormsData.add("as" + inputPlace, style);
    }

    public void addStyle(String inputPlace, String name, String value) {
        webFormsData.add("as" + inputPlace, name + ':' + value);
    }

    public void addOptionTag(String inputPlace, String text, String value, boolean selected) {
        webFormsData.add("ao" + inputPlace, value + '|' + text + (selected ? "|1" : ""));
    }

    public void addCheckBoxTag(String inputPlace, String text, String value, boolean checked) {
        webFormsData.add("ak" + inputPlace, value + '|' + text + (checked ? "|1" : ""));
    }

    public void addTitle(String inputPlace, String title) {
        webFormsData.add("al" + inputPlace, title);
    }

    public void addText(String inputPlace, String text) {
        webFormsData.add("at" + inputPlace, text.replace("\n", "$[ln];"));
    }

    public void addTextToUp(String inputPlace, String text) {
        webFormsData.add("pt" + inputPlace, text.replace("\n", "$[ln];"));
    }

    public void addAttribute(String inputPlace, String attribute, String value) {
        webFormsData.add("aa" + inputPlace, attribute + '|' + value);
    }

    public void addTag(String inputPlace, String tagName, String id) {
        webFormsData.add("nt" + inputPlace, tagName + (id != null && !id.isEmpty() ? '|' + id : ""));
    }

    public void addTagToUp(String inputPlace, String tagName, String id) {
        webFormsData.add("ut" + inputPlace, tagName + (id != null && !id.isEmpty() ? '|' + id : ""));
    }

    public void addTagBefore(String inputPlace, String tagName, String id) {
        webFormsData.add("bt" + inputPlace, tagName + (id != null && !id.isEmpty() ? '|' + id : ""));
    }

    public void addTagAfter(String inputPlace, String tagName, String id) {
        webFormsData.add("ft" + inputPlace, tagName + (id != null && !id.isEmpty() ? '|' + id : ""));
    }

    // Set
    public void setId(String inputPlace, String id) {
        webFormsData.add("si" + inputPlace, id);
    }

    public void setName(String inputPlace, String name) {
        webFormsData.add("sn" + inputPlace, name);
    }

    public void setValue(String inputPlace, String value) {
        webFormsData.add("sv" + inputPlace, value);
    }

    public void setClass(String inputPlace, String className) {
        webFormsData.add("sc" + inputPlace, className);
    }

    public void setStyle(String inputPlace, String style) {
        webFormsData.add("ss" + inputPlace, style);
    }

    public void setStyle(String inputPlace, String name, String value) {
        webFormsData.add("ss" + inputPlace, name + ':' + value);
    }

    public void setOptionTag(String inputPlace, String text, String value, boolean selected) {
        webFormsData.add("so" + inputPlace, value + '|' + text + (selected ? "|1" : ""));
    }

    public void setChecked(String inputPlace, boolean checked) {
        webFormsData.add("sk" + inputPlace, checked ? "1" : "0");
    }

    public void setCheckBoxTagToList(String inputPlace, String text, String value, boolean checked) {
        webFormsData.add("sk" + inputPlace, value + '|' + text + (checked ? "|1" : ""));
    }

    public void setTitle(String inputPlace, String title) {
        webFormsData.add("sl" + inputPlace, title);
    }

    public void setText(String inputPlace, String text) {
        webFormsData.add("st" + inputPlace, text.replace("\n", "$[ln];"));
    }

    public void setAttribute(String inputPlace, String attribute, String value) {
        webFormsData.add("sa" + inputPlace, attribute + (value != null && !value.isEmpty() ? '|' + value : ""));
    }

    public void setWidth(String inputPlace, String width) {
        webFormsData.add("sw" + inputPlace, width);
    }

    public void setWidth(String inputPlace, int width) {
        setWidth(inputPlace, width + "px");
    }

    public void setHeight(String inputPlace, String height) {
        webFormsData.add("sh" + inputPlace, height);
    }

    public void setHeight(String inputPlace, int height) {
        setHeight(inputPlace, height + "px");
    }

    // Insert
    public void insertId(String inputPlace, String id) {
        webFormsData.add("ii" + inputPlace, id);
    }

    public void insertName(String inputPlace, String name) {
        webFormsData.add("in" + inputPlace, name);
    }

    public void insertValue(String inputPlace, String value) {
        webFormsData.add("iv" + inputPlace, value);
    }

    public void insertClass(String inputPlace, String className) {
        webFormsData.add("ic" + inputPlace, className);
    }

    public void insertStyle(String inputPlace, String style) {
        webFormsData.add("is" + inputPlace, style);
    }

    public void insertStyle(String inputPlace, String name, String value) {
        webFormsData.add("is" + inputPlace, name + ':' + value);
    }

    public void insertOptionTag(String inputPlace, String text, String value, boolean selected) {
        webFormsData.add("io" + inputPlace, value + '|' + text + (selected ? "|1" : ""));
    }

    public void insertCheckBoxTag(String inputPlace, String text, String value, boolean checked) {
        webFormsData.add("ik" + inputPlace, value + '|' + text + (checked ? "|1" : ""));
    }

    public void insertTitle(String inputPlace, String title) {
        webFormsData.add("il" + inputPlace, title);
    }

    public void insertText(String inputPlace, String text) {
        webFormsData.add("it" + inputPlace, text.replace("\n", "$[ln];"));
    }

    public void insertAttribute(String inputPlace, String attribute, String value) {
        webFormsData.add("ia" + inputPlace, attribute + (value != null && !value.isEmpty() ? '|' + value : ""));
    }

    // Delete
    public void deleteId(String inputPlace) {
        webFormsData.add("di" + inputPlace, "1");
    }

    public void deleteName(String inputPlace) {
        webFormsData.add("dn" + inputPlace, "1");
    }

    public void deleteValue(String inputPlace) {
        webFormsData.add("dv" + inputPlace, "1");
    }

    public void deleteClass(String inputPlace, String className) {
        webFormsData.add("dc" + inputPlace, className);
    }

    public void deleteStyle(String inputPlace, String styleName) {
        webFormsData.add("ds" + inputPlace, styleName);
    }

    public void deleteOptionTag(String inputPlace, String value) {
        webFormsData.add("do" + inputPlace, value);
    }

    public void deleteAllOptionTag(String inputPlace) {
        webFormsData.add("do" + inputPlace, "*");
    }

    public void deleteCheckBoxTag(String inputPlace, String value) {
        webFormsData.add("dk" + inputPlace, value);
    }

    public void deleteAllCheckBoxTag(String inputPlace) {
        webFormsData.add("dk" + inputPlace, "*");
    }

    public void deleteTitle(String inputPlace) {
        webFormsData.add("dl" + inputPlace, "1");
    }

    public void deleteText(String inputPlace) {
        webFormsData.add("dt" + inputPlace, "1");
    }

    public void deleteAttribute(String inputPlace, String attribute) {
        webFormsData.add("da" + inputPlace, attribute);
    }

    public void delete(String inputPlace) {
        webFormsData.add("de" + inputPlace, "1");
    }

    public void deleteParent(String inputPlace) {
        webFormsData.add("dp" + inputPlace, "1");
    }

    // Other
    public void setBackgroundColor(String inputPlace, String color) {
        webFormsData.add("bc" + inputPlace, color);
    }

    public void setTextColor(String inputPlace, String color) {
        webFormsData.add("tc" + inputPlace, color);
    }

    public void setFontName(String inputPlace, String name) {
        webFormsData.add("fn" + inputPlace, name);
    }

    public void setFontSize(String inputPlace, String size) {
        webFormsData.add("fs" + inputPlace, size);
    }

    public void setFontSize(String inputPlace, int size) {
        webFormsData.add("fs" + inputPlace, size + "px");
    }

    public void setFontBold(String inputPlace, boolean bold) {
        webFormsData.add("fb" + inputPlace, bold ? "1" : "0");
    }

    public void setVisible(String inputPlace, boolean visible) {
        webFormsData.add("vi" + inputPlace, visible ? "1" : "0");
    }

    public void setTextAlign(String inputPlace, String align) {
        webFormsData.add("ta" + inputPlace, align);
    }

    public void setReadOnly(String inputPlace, boolean readOnly) {
        webFormsData.add("sr" + inputPlace, readOnly ? "1" : "0");
    }

    public void setDisabled(String inputPlace, boolean disabled) {
        webFormsData.add("sd" + inputPlace, disabled ? "1" : "0");
    }

    public void setFocus(String inputPlace, boolean focus) {
        webFormsData.add("sf" + inputPlace, focus ? "1" : "0");
    }

    public void setMinLength(String inputPlace, int length) {
        webFormsData.add("mn" + inputPlace, Integer.toString(length));
    }

    public void setMaxLength(String inputPlace, int length) {
        webFormsData.add("mx" + inputPlace, Integer.toString(length));
    }

    public void setSelectedValue(String inputPlace, String value) {
        webFormsData.add("ts" + inputPlace, value);
    }

    public void setSelectedIndex(String inputPlace, int index) {
        webFormsData.add("ti" + inputPlace, Integer.toString(index));
    }

    public void setCheckedValue(String inputPlace, String value, boolean selected) {
        webFormsData.add("ks" + inputPlace, value + "|" + (selected ? "1" : "0"));
    }

    public void setCheckedIndex(String inputPlace, int index, boolean selected) {
        webFormsData.add("ki" + inputPlace, index + "|" + (selected ? "1" : "0"));
    }

    public void callScript(String scriptText) {
        webFormsData.add("_", scriptText.replace("\n", "$[ln];"));
    }

    public void loadUrl(String inputPlace, String url) {
        webFormsData.add("lu" + inputPlace, url);
    }

    public void changeUrl(String url) {
        webFormsData.add("cu", url);
    }

    public void removeSessionCache(String cacheKey) {
        webFormsData.add("rs", cacheKey);
    }

    public void removeAllSessionCache() {
        webFormsData.add("rs", "*");
    }

    public void removeCache(String cacheKey) {
        webFormsData.add("rd", cacheKey);
    }

    public void removeAllCache() {
        webFormsData.add("rd", "*");
    }

    public void setSessionCache() {
        webFormsData.add("cs", "1");
    }

    public void setCache(int second) {
        webFormsData.add("cd", Integer.toString(second));
    }

    public void setCache() {
        webFormsData.add("cd", "*");
    }

    // Increase
    public void increaseMinLength(String inputPlace, int value) {
        webFormsData.add("+n" + inputPlace, Integer.toString(value));
    }

    public void increaseMaxLength(String inputPlace, int value) {
        webFormsData.add("+x" + inputPlace, Integer.toString(value));
    }

    public void increaseFontSize(String inputPlace, int value) {
        webFormsData.add("+f" + inputPlace, Integer.toString(value));
    }

    public void increaseWidth(String inputPlace, int value) {
        webFormsData.add("+w" + inputPlace, Integer.toString(value));
    }

    public void increaseHeight(String inputPlace, int value) {
        webFormsData.add("+h" + inputPlace, Integer.toString(value));
    }

    public void increaseValue(String inputPlace, int value) {
        webFormsData.add("+v" + inputPlace, Integer.toString(value));
    }

    // Decrease
    public void decreaseMinLength(String inputPlace, int value) {
        webFormsData.add("-n" + inputPlace, Integer.toString(value));
    }

    public void decreaseMaxLength(String inputPlace, int value) {
        webFormsData.add("-x" + inputPlace, Integer.toString(value));
    }

    public void decreaseFontSize(String inputPlace, int value) {
        webFormsData.add("-f" + inputPlace, Integer.toString(value));
    }

    public void decreaseWidth(String inputPlace, int value) {
        webFormsData.add("-w" + inputPlace, Integer.toString(value));
    }

    public void decreaseHeight(String inputPlace, int value) {
        webFormsData.add("-h" + inputPlace, Integer.toString(value));
    }

    public void decreaseValue(String inputPlace, int value) {
        webFormsData.add("-v" + inputPlace, Integer.toString(value));
    }

    // Event
    public void setPostEvent(String inputPlace, String htmlEvent) {
        webFormsData.add("Ep" + inputPlace, htmlEvent);
    }

    public void setPostEventAdding(String inputPlace, String htmlEvent) {
        webFormsData.add("Ep" + inputPlace, htmlEvent + "|+");
    }

    public void setPostEventTo(String inputPlace, String htmlEvent, String outputPlace) {
        webFormsData.add("Ep" + inputPlace, htmlEvent + "|" + outputPlace);
    }

    public void setPostEventListener(String inputPlace, String htmlEventListener) {
        webFormsData.add("EP" + inputPlace, htmlEventListener);
    }

    public void setPostEventListenerAdding(String inputPlace, String htmlEventListener) {
        webFormsData.add("EP" + inputPlace, htmlEventListener + "|+");
    }

    public void setPostEventListenerTo(String inputPlace, String htmlEventListener, String outputPlace) {
        webFormsData.add("EP" + inputPlace, htmlEventListener + "|" + outputPlace);
    }

    public void setGetEvent(String inputPlace, String htmlEvent, String path) {
        webFormsData.add("Eg" + inputPlace, htmlEvent + "|" + (path != null ? path : "#"));
    }

    public void setGetEvent(String inputPlace, String htmlEvent, String outputPlace, String path) {
        webFormsData.add("Eg" + inputPlace, htmlEvent + "|" + (path != null ? path : "#") + "|" + outputPlace);
    }

    public void setGetEventInForm(String inputPlace, String htmlEvent) {
        webFormsData.add("Eg" + inputPlace, htmlEvent);
    }

    public void setGetEventInForm(String inputPlace, String htmlEvent, String outputPlace) {
        webFormsData.add("Eg" + inputPlace, htmlEvent + "|" + outputPlace);
    }

    public void setGetEventListener(String inputPlace, String htmlEventListener, String path) {
        webFormsData.add("EG" + inputPlace, htmlEventListener + "|" + (path != null ? path : "#"));
    }

    public void setGetEventListener(String inputPlace, String htmlEventListener, String outputPlace, String path) {
        webFormsData.add("EG" + inputPlace, htmlEventListener + "|" + (path != null ? path : "#") + "|" + outputPlace);
    }

    public void setGetEventInFormListener(String inputPlace, String htmlEventListener) {
        webFormsData.add("EG" + inputPlace, htmlEventListener);
    }

    public void setGetEventInFormListener(String inputPlace, String htmlEventListener, String outputPlace) {
        webFormsData.add("EG" + inputPlace, htmlEventListener + "|" + outputPlace);
    }

    public void setTagEvent(String inputPlace, String htmlEvent, String outputPlace) {
        webFormsData.add("Et" + inputPlace, htmlEvent + "|" + outputPlace);
    }

    public void setTagEventListener(String inputPlace, String htmlEvent, String outputPlace) {
        webFormsData.add("ET" + inputPlace, htmlEvent + "|" + outputPlace);
    }

    public void removePostEvent(String inputPlace, String htmlEvent) {
        webFormsData.add("Rp" + inputPlace, htmlEvent);
    }

    public void removeGetEvent(String inputPlace, String htmlEvent) {
        webFormsData.add("Rg" + inputPlace, htmlEvent);
    }

    public void removeTagEvent(String inputPlace, String htmlEvent) {
        webFormsData.add("Rt" + inputPlace, htmlEvent);
    }

    public void removePostEventListener(String inputPlace, String htmlEventListener) {
        webFormsData.add("RP" + inputPlace, htmlEventListener);
    }

    public void removeGetEventListener(String inputPlace, String htmlEventListener) {
        webFormsData.add("RG" + inputPlace, htmlEventListener);
    }

    public void removeTagEventListener(String inputPlace, String htmlEventListener) {
        webFormsData.add("RT" + inputPlace, htmlEventListener);
    }

    // Save
    public void saveId(String inputPlace, String key) {
        webFormsData.add("@gi" + inputPlace, key != null ? key : ".");
    }

    public void saveName(String inputPlace, String key) {
        webFormsData.add("@gn" + inputPlace, key != null ? key : ".");
    }

    public void saveValue(String inputPlace, String key) {
        webFormsData.add("@gv" + inputPlace, key != null ? key : ".");
    }

    public void saveValueLength(String inputPlace, String key) {
        webFormsData.add("@ge" + inputPlace, key != null ? key : ".");
    }

    public void saveClass(String inputPlace, String key) {
        webFormsData.add("@gc" + inputPlace, key != null ? key : ".");
    }

    public void saveStyle(String inputPlace, String key) {
        webFormsData.add("@gs" + inputPlace, key != null ? key : ".");
    }

    public void saveTitle(String inputPlace, String key) {
        webFormsData.add("@gl" + inputPlace, key != null ? key : ".");
    }

    public void saveText(String inputPlace, String key) {
        webFormsData.add("@gt" + inputPlace, key != null ? key : ".");
    }

    public void saveTextLength(String inputPlace, String key) {
        webFormsData.add("@gg" + inputPlace, key != null ? key : ".");
    }

    public void saveAttribute(String inputPlace, String attribute, String key) {
        webFormsData.add("@ga" + inputPlace, (key != null ? key : ".") + '|' + attribute);
    }

    public void saveWidth(String inputPlace, String key) {
        webFormsData.add("@gw" + inputPlace, key != null ? key : ".");
    }

    public void saveHeight(String inputPlace, String key) {
        webFormsData.add("@gh" + inputPlace, key != null ? key : ".");
    }

    public void saveReadOnly(String inputPlace, String key) {
        webFormsData.add("@gr" + inputPlace, key != null ? key : ".");
    }

    public void saveSelectedIndex(String inputPlace, String key) {
        webFormsData.add("@gx" + inputPlace, key != null ? key : ".");
    }

    public void saveTextAlign(String inputPlace, String key) {
        webFormsData.add("@ta" + inputPlace, key != null ? key : ".");
    }

    public void saveNodeLength(String inputPlace, String key) {
        webFormsData.add("@nl" + inputPlace, key != null ? key : ".");
    }

    public void saveVisible(String inputPlace, String key) {
        webFormsData.add("@vi" + inputPlace, key != null ? key : ".");
    }

    // Pre Runner
    public void assignDelay(float second, int index) {
        String currentName = webFormsData.getNameByIndex(index);

        if (currentName == null || currentName.isEmpty())
            return;

        webFormsData.changeNameByIndex(index, ":" + second + ")" + currentName);
    }

    public void assignDelayChange(float second, int index) {
        String currentName = webFormsData.getNameByIndex(index);

        if (currentName == null || currentName.isEmpty())
            return;

        currentName = removeOuter(currentName, ":", ")");
        webFormsData.changeNameByIndex(index, ":" + second + ")" + currentName);
    }

    public void assignInterval(float second, int index) {
        String currentName = webFormsData.getNameByIndex(index);

        if (currentName == null || currentName.isEmpty())
            return;

        webFormsData.changeNameByIndex(index, "(" + second + ")" + currentName);
    }

    public void assignIntervalChange(float second, int index) {
        String currentName = webFormsData.getNameByIndex(index);

        if (currentName == null || currentName.isEmpty())
            return;

        currentName = removeOuter(currentName, "(", ")");
        webFormsData.changeNameByIndex(index, "(" + second + ")" + currentName);
    }

    // Index
    public void startIndex(String name) {
        webFormsData.add("#", name);
    }

    public void startIndex() {
        startIndex("");
    }

    // Get
    public String getFormsActionData() {
        StringBuilder returnValue = new StringBuilder();

        for (NameValue nv : webFormsData.getList()) {
            returnValue.append(System.lineSeparator()).append(nv.getName());

            if (nv.getValue() != null && !nv.getValue().isEmpty())
                returnValue.append("=").append(nv.getValue());
        }

        return returnValue.toString();
    }

    public String response() {
        return "[web-forms]" + getFormsActionData();
    }

    // Overload
    public String response(HttpServletResponse response) {
        setHeaders(response);
        return response();
    }

    public String getFormsActionDataLineBreak() {
        StringBuilder returnValue = new StringBuilder();
        List<NameValue> webFormsDataList = webFormsData.getList();

        int i = webFormsDataList.size();
        for (NameValue nv : webFormsData.getList()) {
            returnValue.append(nv.getName());

            if (nv.getValue() != null && !nv.getValue().isEmpty())
                returnValue.append("=").append(nv.getValue().replace("\"", "$[dq];"));

            if (i-- > 1)
                returnValue.append("$[sln];");
        }

        return returnValue.toString();
    }

    // Export
    public String exportToWebFormsTag(String src) {
        return "<web-forms ac=\"" + getFormsActionDataLineBreak() + "\"" + 
               (src != null && !src.isEmpty() ? " src=\"" + src + "\"" : "") + 
               "></web-forms>";
    }

    // Overload
    public String exportToWebFormsTag(String width, String height, String src) {
        return "<web-forms ac=\"" + getFormsActionDataLineBreak() + "\" width=\"" + width + 
               "\" height=\"" + height + "\"" + 
               (src != null && !src.isEmpty() ? " src=\"" + src + "\"" : "") + 
               "></web-forms>";
    }

    // Overload
    public String exportToWebFormsTag(int width, int height, String src) {
        return exportToWebFormsTag(width + "px", height + "px", src);
    }

    public String doneToWebFormsTag(String id) {
        return "<web-forms ac=\"" + getFormsActionDataLineBreak() + "\"" + 
               (id != null && !id.isEmpty() ? " id=\"" + id + "\" done=\"true\"" : "") + 
               "></web-forms>";
    }

    public NameValueCollection exportToNameValue() {
        return webFormsData;
    }

    public void appendForm(WebForms form) {
        webFormsData.addList(form.exportToNameValue().getList());
    }

    public void setHeaders(HttpServletResponse response) {
        response.setHeader("Content-Type", "text/plain");
    }

    public void clean() {
        webFormsData = new NameValueCollection();
    }

    private String removeOuter(String value, String start, String end) {
        if (value.startsWith(start) && value.endsWith(end)) {
            return value.substring(start.length(), value.length() - end.length());
        }
        return value;
    }
}
