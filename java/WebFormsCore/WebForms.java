package WebFormsCore;

// WebForms.java 2.0 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.0

import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import jakarta.servlet.http.HttpServletResponse;

public class WebForms {
    private StringBuilder webFormsData = new StringBuilder();

    private void add(String name, String value) {
        if (webFormsData.length() > 0)
            webFormsData.append('\n');

        webFormsData.append(name);
        webFormsData.append('=');
        webFormsData.append(value);
    }

    private void add(String name) {
        if (webFormsData.length() > 0)
            webFormsData.append('\n');

        webFormsData.append(name);
    }

    private String getLineByIndex(int index) {
        if (webFormsData.length() == 0)
            return "";

        String data = webFormsData.toString();
        String[] lines = data.split("\n");

        if (index < 0)
            index = lines.length + index;

        if (index < 0 || index >= lines.length)
            return "";

        return lines[index];
    }

    private void updateLineByIndex(int index, String name, String value) {
        if (webFormsData.length() == 0)
            return;

        String data = webFormsData.toString();
        String[] lines = data.split("\n");

        if (index < 0)
            index = lines.length + index;

        if (index < 0 || index >= lines.length)
            return;

        lines[index] = name + ((value != null && !value.isEmpty()) ? "=" + value : "");

        webFormsData = new StringBuilder();
        for (int i = 0; i < lines.length; i++) {
            if (i > 0) webFormsData.append('\n');
            webFormsData.append(lines[i]);
        }
    }

    // For Extension
    public void addLine(String name, String value) {
        add(name, value);
    }

    // Add
    public void addId(String inputPlace, String id) {
        add("ai" + inputPlace, id);
    }

    public void addName(String inputPlace, String name) {
        add("an" + inputPlace, name);
    }

    public void addValue(String inputPlace, String value) {
        add("av" + inputPlace, value);
    }

    public void addClass(String inputPlace, String className) {
        add("ac" + inputPlace, className);
    }

    public void addStyle(String inputPlace, String style) {
        add("as" + inputPlace, style);
    }

    public void addStyle(String inputPlace, String name, String value) {
        add("as" + inputPlace, name + ':' + value);
    }

    public void addOptionTag(String inputPlace, String text, String value, boolean selected) {
        add("ao" + inputPlace, value + '|' + text + (selected ? "|1" : ""));
    }

    public void addOptionTag(String inputPlace, String text, String value) {
        addOptionTag(inputPlace, text, value, false);
    }

    public void addCheckBoxTag(String inputPlace, String text, String value, boolean checked) {
        add("ak" + inputPlace, value + '|' + text + (checked ? "|1" : ""));
    }

    public void addCheckBoxTag(String inputPlace, String text, String value) {
        addCheckBoxTag(inputPlace, text, value, false);
    }

    public void addTitle(String inputPlace, String title) {
        add("al" + inputPlace, title);
    }

    public void addLabel(String inputPlace, String label) {
        add("aA" + inputPlace, label);
    }

    public void addText(String inputPlace, String text) {
        add("at" + inputPlace, text.replace("\n", "$[ln];"));
    }

    public void addTextToUp(String inputPlace, String text) {
        add("pt" + inputPlace, text.replace("\n", "$[ln];"));
    }

    public void addAttribute(String inputPlace, String attribute, String value, char splitter) {
        add("aa" + inputPlace, attribute + '|' + ((splitter != '\0') ? splitter : "") + 
            (value != null && !value.isEmpty() ? '|' + value : ""));
    }

    public void addAttribute(String inputPlace, String attribute, String value) {
        addAttribute(inputPlace, attribute, value, '\0');
    }

    public void addAttribute(String inputPlace, String attribute) {
        addAttribute(inputPlace, attribute, "", '\0');
    }

    public void addTag(String inputPlace, String tagName, String id) {
        add("nt" + inputPlace, tagName + (id != null && !id.isEmpty() ? '|' + id : ""));
    }

    public void addTag(String inputPlace, String tagName) {
        addTag(inputPlace, tagName, "");
    }

    public void addTagToUp(String inputPlace, String tagName, String id) {
        add("ut" + inputPlace, tagName + (id != null && !id.isEmpty() ? '|' + id : ""));
    }

    public void addTagToUp(String inputPlace, String tagName) {
        addTagToUp(inputPlace, tagName, "");
    }

    public void addTagBefore(String inputPlace, String tagName, String id) {
        add("bt" + inputPlace, tagName + (id != null && !id.isEmpty() ? '|' + id : ""));
    }

    public void addTagBefore(String inputPlace, String tagName) {
        addTagBefore(inputPlace, tagName, "");
    }

    public void addTagAfter(String inputPlace, String tagName, String id) {
        add("ft" + inputPlace, tagName + (id != null && !id.isEmpty() ? '|' + id : ""));
    }

    public void addTagAfter(String inputPlace, String tagName) {
        addTagAfter(inputPlace, tagName, "");
    }

    public void addHidden(String inputPlace, String value, String id) {
        add("ah" + inputPlace, value + (id != null && !id.isEmpty() ? '|' + id : ""));
    }

    public void addHidden(String inputPlace, String value) {
        addHidden(inputPlace, value, "");
    }

    // Set
    public void setId(String inputPlace, String id) {
        add("si" + inputPlace, id);
    }

    public void setName(String inputPlace, String name) {
        add("sn" + inputPlace, name);
    }

    public void setValue(String inputPlace, String value) {
        add("sv" + inputPlace, value);
    }

    public void setClass(String inputPlace, String className) {
        add("sc" + inputPlace, className);
    }

    public void setStyle(String inputPlace, String style) {
        add("ss" + inputPlace, style);
    }

    public void setStyle(String inputPlace, String name, String value) {
        add("ss" + inputPlace, name + ':' + value);
    }

    public void setOptionTag(String inputPlace, String text, String value, boolean selected) {
        add("so" + inputPlace, value + '|' + text + (selected ? "|1" : ""));
    }

    public void setOptionTag(String inputPlace, String text, String value) {
        setOptionTag(inputPlace, text, value, false);
    }

    public void setChecked(String inputPlace, boolean checked) {
        add("sk" + inputPlace, checked ? "1" : "0");
    }

    public void setCheckBoxTag(String inputPlace, String text, String value, boolean checked) {
        add("sk" + inputPlace, value + '|' + text + (checked ? "|1" : ""));
    }

    public void setCheckBoxTag(String inputPlace, String text, String value) {
        setCheckBoxTag(inputPlace, text, value, false);
    }

    public void setTitle(String inputPlace, String title) {
        add("sl" + inputPlace, title);
    }

    public void setLabel(String inputPlace, String label) {
        add("sA" + inputPlace, label);
    }

    public void setText(String inputPlace, String text) {
        add("st" + inputPlace, text.replace("\n", "$[ln];"));
    }

    public void setAttribute(String inputPlace, String attribute, String value) {
        add("sa" + inputPlace, attribute + '|' + (value != null && !value.isEmpty() ? '|' + value : ""));
    }

    public void setAttribute(String inputPlace, String attribute) {
        setAttribute(inputPlace, attribute, "");
    }

    public void setWidth(String inputPlace, String width) {
        add("sw" + inputPlace, width);
    }

    public void setWidth(String inputPlace, int width) {
        setWidth(inputPlace, width + "px");
    }

    public void setHeight(String inputPlace, String height) {
        add("sh" + inputPlace, height);
    }

    public void setHeight(String inputPlace, int height) {
        setHeight(inputPlace, height + "px");
    }

    public void setBackgroundColor(String inputPlace, String color) {
        add("bc" + inputPlace, color);
    }

    public void setTextColor(String inputPlace, String color) {
        add("tc" + inputPlace, color);
    }

    public void setFontName(String inputPlace, String name) {
        add("fn" + inputPlace, name);
    }

    public void setFontSize(String inputPlace, String size) {
        add("fs" + inputPlace, size);
    }

    public void setFontSize(String inputPlace, int size) {
        add("fs" + inputPlace, size + "px");
    }

    public void setFontBold(String inputPlace, boolean bold) {
        add("fb" + inputPlace, bold ? "1" : "0");
    }

    public void setVisible(String inputPlace, boolean visible) {
        add("vi" + inputPlace, visible ? "1" : "0");
    }

    public void setTextAlign(String inputPlace, String align) {
        add("ta" + inputPlace, align);
    }

    public void setReadOnly(String inputPlace, boolean readOnly) {
        add("sr" + inputPlace, readOnly ? "1" : "0");
    }

    public void setDisabled(String inputPlace, boolean disabled) {
        add("sd" + inputPlace, disabled ? "1" : "0");
    }

    public void setFocus(String inputPlace, boolean focus) {
        add("sf" + inputPlace, focus ? "1" : "0");
    }

    public void setMinLength(String inputPlace, int length) {
        add("mn" + inputPlace, Integer.toString(length));
    }

    public void setMaxLength(String inputPlace, int length) {
        add("mx" + inputPlace, Integer.toString(length));
    }

    public void setSelectedValue(String inputPlace, String value) {
        add("ts" + inputPlace, value);
    }

    public void setSelectedIndex(String inputPlace, int index) {
        add("ti" + inputPlace, Integer.toString(index));
    }

    public void setCheckedValue(String inputPlace, String value, boolean selected) {
        add("ks" + inputPlace, value + "|" + (selected ? "1" : "0"));
    }

    public void setCheckedIndex(String inputPlace, int index, boolean selected) {
        add("ki" + inputPlace, index + "|" + (selected ? "1" : "0"));
    }

    // Insert
    public void insertId(String inputPlace, String id) {
        add("ii" + inputPlace, id);
    }

    public void insertName(String inputPlace, String name) {
        add("in" + inputPlace, name);
    }

    public void insertValue(String inputPlace, String value) {
        add("iv" + inputPlace, value);
    }

    public void insertClass(String inputPlace, String className) {
        add("ic" + inputPlace, className);
    }

    public void insertStyle(String inputPlace, String style) {
        add("is" + inputPlace, style);
    }

    public void insertStyle(String inputPlace, String name, String value) {
        add("is" + inputPlace, name + ':' + value);
    }

    public void insertOptionTag(String inputPlace, String text, String value, boolean selected) {
        add("io" + inputPlace, value + '|' + text + (selected ? "|1" : ""));
    }

    public void insertOptionTag(String inputPlace, String text, String value) {
        insertOptionTag(inputPlace, text, value, false);
    }

    public void insertCheckBoxTag(String inputPlace, String text, String value, boolean checked) {
        add("ik" + inputPlace, value + '|' + text + (checked ? "|1" : ""));
    }

    public void insertCheckBoxTag(String inputPlace, String text, String value) {
        insertCheckBoxTag(inputPlace, text, value, false);
    }

    public void insertTitle(String inputPlace, String title) {
        add("il" + inputPlace, title);
    }

    public void insertLabel(String inputPlace, String label) {
        add("iA" + inputPlace, label);
    }

    public void insertText(String inputPlace, String text) {
        add("it" + inputPlace, text.replace("\n", "$[ln];"));
    }

    public void insertAttribute(String inputPlace, String attribute, String value, char splitter) {
        add("ia" + inputPlace, attribute + '|' + ((splitter != '\0') ? splitter : "") + 
            (value != null && !value.isEmpty() ? '|' + value : ""));
    }

    public void insertAttribute(String inputPlace, String attribute, String value) {
        insertAttribute(inputPlace, attribute, value, '\0');
    }

    public void insertAttribute(String inputPlace, String attribute) {
        insertAttribute(inputPlace, attribute, "", '\0');
    }

    // Delete
    public void deleteId(String inputPlace) {
        add("di" + inputPlace);
    }

    public void deleteName(String inputPlace) {
        add("dn" + inputPlace);
    }

    public void deleteValue(String inputPlace) {
        add("dv" + inputPlace);
    }

    public void deleteClass(String inputPlace, String className) {
        add("dc" + inputPlace, className);
    }

    public void deleteStyle(String inputPlace, String styleName) {
        add("ds" + inputPlace, styleName);
    }

    public void deleteOptionTag(String inputPlace, String value) {
        add("do" + inputPlace, value);
    }

    public void deleteAllOptionTag(String inputPlace) {
        add("do" + inputPlace, "*");
    }

    public void deleteCheckBoxTag(String inputPlace, String value) {
        add("dk" + inputPlace, value);
    }

    public void deleteAllCheckBoxTag(String inputPlace) {
        add("dk" + inputPlace, "*");
    }

    public void deleteTitle(String inputPlace) {
        add("dl" + inputPlace);
    }

    public void deleteLabel(String inputPlace) {
        add("dA" + inputPlace);
    }

    public void deleteText(String inputPlace) {
        add("dt" + inputPlace);
    }

    public void deleteAttribute(String inputPlace, String attribute) {
        add("da" + inputPlace, attribute);
    }

    public void delete(String inputPlace) {
        add("de" + inputPlace);
    }

    public void deleteParent(String inputPlace) {
        add("dp" + inputPlace);
    }

    // Tag
    public void swapTag(String inputPlace, String outputPlace) {
        add("sp" + inputPlace, outputPlace);
    }

    public void setReflection(String inputPlace, String tag) {
        add("sR" + inputPlace, tag);
    }

    public void setReflectionByOutputPlace(String inputPlace, String outputPlace) {
        add("iR" + inputPlace, outputPlace);
    }

    // Browser
    public void changeUrl(String url) {
        add("cu", url);
    }

    public void setHeadTitle(String title) {
        add("ht", title);
    }

    public void clipboardWriteText(String text) {
        add("nw", text);
    }

    public void scrollTo(int x, int y) {
        add("ws", x + "|" + y);
    }

    public void historyGo(int steps) {
        add("wg", Integer.toString(steps));
    }

    public void reloadPage() {
        add("lr");
    }

    public void redirect(String path) {
        add("lh", path);
    }

    // Increase
    public void increaseMinLength(String inputPlace, int value) {
        add("+n" + inputPlace, Integer.toString(value));
    }

    public void increaseMaxLength(String inputPlace, int value) {
        add("+x" + inputPlace, Integer.toString(value));
    }

    public void increaseFontSize(String inputPlace, int value) {
        add("+f" + inputPlace, Integer.toString(value));
    }

    public void increaseWidth(String inputPlace, int value) {
        add("+w" + inputPlace, Integer.toString(value));
    }

    public void increaseHeight(String inputPlace, int value) {
        add("+h" + inputPlace, Integer.toString(value));
    }

    public void increaseValue(String inputPlace, int value) {
        add("+v" + inputPlace, Integer.toString(value));
    }

    // Decrease
    public void decreaseMinLength(String inputPlace, int value) {
        add("-n" + inputPlace, Integer.toString(value));
    }

    public void decreaseMaxLength(String inputPlace, int value) {
        add("-x" + inputPlace, Integer.toString(value));
    }

    public void decreaseFontSize(String inputPlace, int value) {
        add("-f" + inputPlace, Integer.toString(value));
    }

    public void decreaseWidth(String inputPlace, int value) {
        add("-w" + inputPlace, Integer.toString(value));
    }

    public void decreaseHeight(String inputPlace, int value) {
        add("-h" + inputPlace, Integer.toString(value));
    }

    public void decreaseValue(String inputPlace, int value) {
        add("-v" + inputPlace, Integer.toString(value));
    }

    // Event
    // All Method In Event Section Only Support Dynamic Args Once
    public void triggerEvent(String inputPlace, String htmlEventListener, String constructorName) {
        add("TE" + inputPlace, htmlEventListener + 
            (constructorName != null && !constructorName.isEmpty() ? "|" + constructorName : ""));
    }

    public void triggerEvent(String inputPlace, String htmlEventListener) {
        triggerEvent(inputPlace, htmlEventListener, null);
    }

    public void setPostEvent(String inputPlace, String htmlEvent) {
        add("Ep" + inputPlace, htmlEvent);
    }

    public void setPostEventView(String inputPlace, String htmlEvent) {
        add("Ep" + inputPlace, htmlEvent + "|+");
    }

    public void setPostEventTo(String inputPlace, String htmlEvent, String outputPlace) {
        add("Ep" + inputPlace, htmlEvent + "|" + outputPlace);
    }

    public void setPostEventListener(String inputPlace, String htmlEventListener) {
        add("EP" + inputPlace, htmlEventListener);
    }

    public void setPostEventListenerView(String inputPlace, String htmlEventListener) {
        add("EP" + inputPlace, htmlEventListener + "|+");
    }

    public void setPostEventListenerTo(String inputPlace, String htmlEventListener, String outputPlace) {
        add("EP" + inputPlace, htmlEventListener + "|" + outputPlace);
    }

    public void setGetEvent(String inputPlace, String htmlEvent, String path) {
        add("Eg" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setGetEvent(String inputPlace, String htmlEvent, String outputPlace, String path) {
        add("Eg" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#") + "|" + outputPlace);
    }

    public void setGetEvent(String inputPlace, String htmlEvent) {
        setGetEvent(inputPlace, htmlEvent, null);
    }

    public void setGetEventListener(String inputPlace, String htmlEventListener, String path) {
        add("EG" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setGetEventListener(String inputPlace, String htmlEventListener, String outputPlace, String path) {
        add("EG" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#") + "|" + outputPlace);
    }

    public void setGetEventListener(String inputPlace, String htmlEventListener) {
        setGetEventListener(inputPlace, htmlEventListener, null);
    }

    public void setPatchEvent(String inputPlace, String htmlEvent, String path) {
        add("Ea" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setPatchEvent(String inputPlace, String htmlEvent, String outputPlace, String path) {
        add("Ea" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#") + "|" + outputPlace);
    }

    public void setPatchEvent(String inputPlace, String htmlEvent) {
        setPatchEvent(inputPlace, htmlEvent, null);
    }

    public void setPatchEventListener(String inputPlace, String htmlEventListener, String path) {
        add("EA" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setPatchEventListener(String inputPlace, String htmlEventListener, String outputPlace, String path) {
        add("EA" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#") + "|" + outputPlace);
    }

    public void setPatchEventListener(String inputPlace, String htmlEventListener) {
        setPatchEventListener(inputPlace, htmlEventListener, null);
    }

    public void setDeleteEvent(String inputPlace, String htmlEvent, String path) {
        add("El" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setDeleteEvent(String inputPlace, String htmlEvent, String outputPlace, String path) {
        add("El" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#") + "|" + outputPlace);
    }

    public void setDeleteEvent(String inputPlace, String htmlEvent) {
        setDeleteEvent(inputPlace, htmlEvent, null);
    }

    public void setDeleteEventListener(String inputPlace, String htmlEventListener, String path) {
        add("EL" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setDeleteEventListener(String inputPlace, String htmlEventListener, String outputPlace, String path) {
        add("EL" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#") + "|" + outputPlace);
    }

    public void setDeleteEventListener(String inputPlace, String htmlEventListener) {
        setDeleteEventListener(inputPlace, htmlEventListener, null);
    }

    public void setOptionsEvent(String inputPlace, String htmlEvent, String path) {
        add("Eo" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setOptionsEvent(String inputPlace, String htmlEvent, String outputPlace, String path) {
        add("Eo" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#") + "|" + outputPlace);
    }

    public void setOptionsEvent(String inputPlace, String htmlEvent) {
        setOptionsEvent(inputPlace, htmlEvent, null);
    }

    public void setOptionsEventListener(String inputPlace, String htmlEventListener, String path) {
        add("EO" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setOptionsEventListener(String inputPlace, String htmlEventListener, String outputPlace, String path) {
        add("EO" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#") + "|" + outputPlace);
    }

    public void setOptionsEventListener(String inputPlace, String htmlEventListener) {
        setOptionsEventListener(inputPlace, htmlEventListener, null);
    }

    public void setTraceEvent(String inputPlace, String htmlEvent, String path) {
        add("Er" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setTraceEvent(String inputPlace, String htmlEvent, String outputPlace, String path) {
        add("Er" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#") + "|" + outputPlace);
    }

    public void setTraceEvent(String inputPlace, String htmlEvent) {
        setTraceEvent(inputPlace, htmlEvent, null);
    }

    public void setTraceEventListener(String inputPlace, String htmlEventListener, String path) {
        add("ER" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setTraceEventListener(String inputPlace, String htmlEventListener, String outputPlace, String path) {
        add("ER" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#") + "|" + outputPlace);
    }

    public void setTraceEventListener(String inputPlace, String htmlEventListener) {
        setTraceEventListener(inputPlace, htmlEventListener, null);
    }

    public void setConnectEvent(String inputPlace, String htmlEvent, String path) {
        add("Ec" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setConnectEvent(String inputPlace, String htmlEvent, String outputPlace, String path) {
        add("Ec" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#") + "|" + outputPlace);
    }

    public void setConnectEvent(String inputPlace, String htmlEvent) {
        setConnectEvent(inputPlace, htmlEvent, null);
    }

    public void setConnectEventListener(String inputPlace, String htmlEventListener, String path) {
        add("EC" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setConnectEventListener(String inputPlace, String htmlEventListener, String outputPlace, String path) {
        add("EC" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#") + "|" + outputPlace);
    }

    public void setConnectEventListener(String inputPlace, String htmlEventListener) {
        setConnectEventListener(inputPlace, htmlEventListener, null);
    }

    public void setHeadEvent(String inputPlace, String htmlEvent, String path) {
        add("Eh" + inputPlace, htmlEvent + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setHeadEventListener(String inputPlace, String htmlEventListener, String path) {
        add("EH" + inputPlace, htmlEventListener + "|" + (path != null && !path.isEmpty() ? path : "#"));
    }

    public void setHeadEvent(String inputPlace, String htmlEvent) {
        setHeadEvent(inputPlace, htmlEvent, null);
    }

    public void setHeadEventListener(String inputPlace, String htmlEventListener) {
        setHeadEventListener(inputPlace, htmlEventListener, null);
    }

    public void setTagEvent(String inputPlace, String htmlEvent, String outputPlace) {
        add("Et" + inputPlace, htmlEvent + "|" + outputPlace);
    }

    public void setTagEventListener(String inputPlace, String htmlEventListener, String outputPlace) {
        add("ET" + inputPlace, htmlEventListener + "|" + outputPlace);
    }

    public void setCommentEvent(String inputPlace, String htmlEvent, String index, String outputPlace) {
        add("Eb" + inputPlace, htmlEvent + "|" + index + "|" + outputPlace);
    }

    public void setCommentEvent(String inputPlace, String htmlEvent, int index, String outputPlace) {
        setCommentEvent(inputPlace, htmlEvent, Integer.toString(index), outputPlace);
    }

    public void setCommentEventListener(String inputPlace, String htmlEventListener, String index, String outputPlace) {
        add("EB" + inputPlace, htmlEventListener + "|" + index + "|" + outputPlace);
    }

    public void setCommentEventListener(String inputPlace, String htmlEventListener, int index, String outputPlace) {
        setCommentEventListener(inputPlace, htmlEventListener, Integer.toString(index), outputPlace);
    }

    public void setWasmEvent(String inputPlace, String htmlEvent, String wasmLanguage, 
                           String wasmUrl, String methodName, String[] args, String outputPlace) {
        String argsJoin = "";

        if (args != null && args.length > 0)
            argsJoin = String.join(",", args);

        add("Ey" + inputPlace, htmlEvent + "|" + wasmLanguage + "|" + wasmUrl + "|" + 
            methodName + "|" + argsJoin + "|" + outputPlace);
    }

    public void setWasmEventListener(String inputPlace, String htmlEventListener, String wasmLanguage, 
                                   String wasmUrl, String methodName, String[] args, String outputPlace) {
        String argsJoin = "";

        if (args != null && args.length > 0)
            argsJoin = String.join(",", args);

        add("EY" + inputPlace, htmlEventListener + "|" + wasmLanguage + "|" + wasmUrl + "|" + 
            methodName + "|" + argsJoin + "|" + outputPlace);
    }

    public void setWebSocketEvent(String inputPlace, String htmlEvent, String path) {
        add("Ew" + inputPlace, htmlEvent + "|" + path);
    }

    public void setWebSocketEventListener(String inputPlace, String htmlEventListener, String path) {
        add("EW" + inputPlace, htmlEventListener + "|" + path);
    }

    public void setSSEEvent(String inputPlace, String htmlEvent, String path, boolean shouldReconnect, int reconnectTryTimeout) {
        add("Ee" + inputPlace, htmlEvent + "|" + path + "|" + (shouldReconnect ? "1" : "0") + "|" + reconnectTryTimeout);
    }

    public void setSSEEvent(String inputPlace, String htmlEvent, String path, String outputPlace, 
                          boolean shouldReconnect, int reconnectTryTimeout) {
        add("Ee" + inputPlace, htmlEvent + "|" + path + "|" + (shouldReconnect ? "1" : "0") + 
            "|" + reconnectTryTimeout + "|" + outputPlace);
    }

    public void setSSEEventListener(String inputPlace, String htmlEventListener, String path, 
                                  boolean shouldReconnect, int reconnectTryTimeout) {
        add("EE" + inputPlace, htmlEventListener + "|" + path + "|" + (shouldReconnect ? "1" : "0") + "|" + reconnectTryTimeout);
    }

    public void setSSEEventListener(String inputPlace, String htmlEventListener, String path, String outputPlace, 
                                  boolean shouldReconnect, int reconnectTryTimeout) {
        add("EE" + inputPlace, htmlEventListener + "|" + path + "|" + (shouldReconnect ? "1" : "0") + 
            "|" + reconnectTryTimeout + "|" + outputPlace);
    }

    public void setFrontEvent(String inputPlace, String htmlEvent, String modulePath, 
                            String[] args, String outputPlace) {
        String argsJoin = "";

        if (args != null && args.length > 0)
            argsJoin = "|" + String.join("|", args);

        add("Ej" + inputPlace, htmlEvent + "|" + modulePath + "|" + outputPlace + argsJoin);
    }

    public void setFrontEventListener(String inputPlace, String htmlEventListener, String modulePath, 
                                    String[] args, String outputPlace) {
        String argsJoin = "";

        if (args != null && args.length > 0)
            argsJoin = "|" + String.join("|", args);

        add("EJ" + inputPlace, htmlEventListener + "|" + modulePath + "|" + outputPlace + argsJoin);
    }

    public void setSendEvent(String inputPlace, String htmlEvent, String data, String path, 
                           String method, boolean isMultiPart, String contentType, String outputPlace) {
        String safeData = data.replace("\n", "$[ln];").replace("\"", "$[dq];").replace("'", "$[sq];");
        add("En" + inputPlace, htmlEvent + "|" + safeData + "|" + 
            (path != null && !path.isEmpty() ? path : "#") + "|" + method + "|" + 
            (isMultiPart ? "1" : "0") + "|" + contentType + "|" + outputPlace);
    }

    public void setSendEventListener(String inputPlace, String htmlEventListener, String data, String path, 
                                   String method, boolean isMultiPart, String contentType, String outputPlace) {
        add("EN" + inputPlace, htmlEventListener + "|" + data.replace("\n", "$[ln];") + "|" + 
            (path != null && !path.isEmpty() ? path : "#") + "|" + method + "|" + 
            (isMultiPart ? "1" : "0") + "|" + contentType + "|" + outputPlace);
    }

    public void setMasterPagesEvent(String inputPlace, String htmlEvent, String outputPlace) {
        add("Eu" + inputPlace, htmlEvent + "|" + outputPlace);
    }

    public void setMasterPagesEventListener(String inputPlace, String htmlEventListener, String outputPlace) {
        add("EU" + inputPlace, htmlEventListener + "|" + outputPlace);
    }

    public void setPreventDefaultEvent(String inputPlace, String htmlEvent) {
        add("Ed" + inputPlace, htmlEvent);
    }

    public void setPreventDefaultEventListener(String inputPlace, String htmlEventListener) {
        add("ED" + inputPlace, htmlEventListener);
    }

    public void setStopPropagationEvent(String inputPlace, String htmlEvent) {
        add("Es" + inputPlace, htmlEvent);
    }

    public void setStopPropagationEventListener(String inputPlace, String htmlEventListener) {
        add("ES" + inputPlace, htmlEventListener);
    }

    public void setMethodEvent(String inputPlace, String htmlEvent, String methodName, String[] args) {
        String argsJoin = "";

        if (args != null && args.length > 0)
            argsJoin = "|" + String.join("|", args);

        add("Em" + inputPlace, htmlEvent + "|" + methodName + argsJoin);
    }

    public void setMethodEventListener(String inputPlace, String htmlEventListener, String methodName, String[] args) {
        String argsJoin = "";

        if (args != null && args.length > 0)
            argsJoin = "|" + String.join("|", args);

        add("EM" + inputPlace, htmlEventListener + "|" + methodName + argsJoin);
    }

    public void setModuleMethodEvent(String inputPlace, String htmlEvent, String methodName, String[] args) {
        String argsJoin = "";

        if (args != null && args.length > 0)
            argsJoin = "|" + String.join("|", args);

        add("Ex" + inputPlace, htmlEvent + "|" + methodName + argsJoin);
    }

    public void setModuleMethodEventListener(String inputPlace, String htmlEventListener, String methodName, String[] args) {
        String argsJoin = "";

        if (args != null && args.length > 0)
            argsJoin = "|" + String.join("|", args);

        add("EX" + inputPlace, htmlEventListener + "|" + methodName + argsJoin);
    }

    public void assignConfirmEvent(String inputPlace, String htmlEvent, String text, 
                                 String type, String title, String okText, String cancelText) {
        String safeText = text.equals("Are you sure you want to proceed?") ? "" : text;
        String safeType = type.equals("none") ? "" : type;
        String safeTitle = title.equals("Confirm") ? "" : title;
        String safeOkText = okText.equals("OK") ? "" : okText;
        String safeCancelText = cancelText.equals("Cancel") ? "" : cancelText;
        
        add("Ef" + inputPlace, htmlEvent + "|" + safeText + "|" + safeType + "|" + 
            safeTitle + "|" + safeOkText + "|" + safeCancelText);
    }

    // Remove Events
    public void removePostEvent(String inputPlace, String htmlEvent) {
        add("Rp" + inputPlace, htmlEvent);
    }

    public void removePostEventListener(String inputPlace, String htmlEventListener) {
        add("RP" + inputPlace, htmlEventListener);
    }

    public void removeGetEvent(String inputPlace, String htmlEvent) {
        add("Rg" + inputPlace, htmlEvent);
    }

    public void removeGetEventListener(String inputPlace, String htmlEventListener) {
        add("RG" + inputPlace, htmlEventListener);
    }

    public void removePatchEvent(String inputPlace, String htmlEvent) {
        add("Ra" + inputPlace, htmlEvent);
    }

    public void removePatchEventListener(String inputPlace, String htmlEventListener) {
        add("RA" + inputPlace, htmlEventListener);
    }

    public void removeDeleteEvent(String inputPlace, String htmlEvent) {
        add("Rl" + inputPlace, htmlEvent);
    }

    public void removeDeleteEventListener(String inputPlace, String htmlEventListener) {
        add("RL" + inputPlace, htmlEventListener);
    }

    public void removeHeadEvent(String inputPlace, String htmlEvent) {
        add("Rh" + inputPlace, htmlEvent);
    }

    public void removeHeadEventListener(String inputPlace, String htmlEventListener) {
        add("RH" + inputPlace, htmlEventListener);
    }

    public void removeOptionsEvent(String inputPlace, String htmlEvent) {
        add("Ro" + inputPlace, htmlEvent);
    }

    public void removeOptionsEventListener(String inputPlace, String htmlEventListener) {
        add("RO" + inputPlace, htmlEventListener);
    }

    public void removeTraceEvent(String inputPlace, String htmlEvent) {
        add("Rr" + inputPlace, htmlEvent);
    }

    public void removeTraceEventListener(String inputPlace, String htmlEventListener) {
        add("RR" + inputPlace, htmlEventListener);
    }

    public void removeConnectEvent(String inputPlace, String htmlEvent) {
        add("Rc" + inputPlace, htmlEvent);
    }

    public void removeConnectEventListener(String inputPlace, String htmlEventListener) {
        add("RC" + inputPlace, htmlEventListener);
    }

    public void removeTagEvent(String inputPlace, String htmlEvent) {
        add("Rt" + inputPlace, htmlEvent);
    }

    public void removeTagEventListener(String inputPlace, String htmlEventListener) {
        add("RT" + inputPlace, htmlEventListener);
    }

    public void removeCommentEvent(String inputPlace, String htmlEvent) {
        add("Rb" + inputPlace, htmlEvent);
    }

    public void removeCommentEventListener(String inputPlace, String htmlEventListener) {
        add("RB" + inputPlace, htmlEventListener);
    }

    public void removeWasmEvent(String inputPlace, String htmlEvent) {
        add("Ry" + inputPlace, htmlEvent);
    }

    public void removeWasmEventListener(String inputPlace, String htmlEventListener) {
        add("RY" + inputPlace, htmlEventListener);
    }

    public void removeWebSocketEvent(String inputPlace, String htmlEvent) {
        add("Rw" + inputPlace, htmlEvent);
    }

    public void removeWebSocketEventListener(String inputPlace, String htmlEventListener) {
        add("RW" + inputPlace, htmlEventListener);
    }

    public void removeSSEEvent(String inputPlace, String htmlEvent) {
        add("Re" + inputPlace, htmlEvent);
    }

    public void removeSSEEventListener(String inputPlace, String htmlEventListener) {
        add("RE" + inputPlace, htmlEventListener);
    }

    public void removeFrontEvent(String inputPlace, String htmlEvent) {
        add("Rj" + inputPlace, htmlEvent);
    }

    public void removeFrontEventListener(String inputPlace, String htmlEventListener) {
        add("RJ" + inputPlace, htmlEventListener);
    }

    public void removeSendEvent(String inputPlace, String htmlEvent) {
        add("Rn" + inputPlace, htmlEvent);
    }

    public void removeSendEventListener(String inputPlace, String htmlEventListener) {
        add("RN" + inputPlace, htmlEventListener);
    }

    public void removePreventDefaultEvent(String inputPlace, String htmlEvent) {
        add("Rd" + inputPlace, htmlEvent);
    }

    public void removePreventDefaultEventListener(String inputPlace, String htmlEventListener) {
        add("RD" + inputPlace, htmlEventListener);
    }

    public void removeMasterPagesEvent(String inputPlace, String htmlEvent) {
        add("Ru" + inputPlace, htmlEvent);
    }

    public void removeMasterPagesEventListener(String inputPlace, String htmlEventListener) {
        add("RU" + inputPlace, htmlEventListener);
    }

    public void removeStopPropagationEvent(String inputPlace, String htmlEvent) {
        add("Rs" + inputPlace, htmlEvent);
    }

    public void removeStopPropagationEventListener(String inputPlace, String htmlEventListener) {
        add("RS" + inputPlace, htmlEventListener);
    }

    public void removeMethodEvent(String inputPlace, String htmlEvent, String methodName) {
        add("Rm" + inputPlace, htmlEvent + "|" + methodName);
    }

    public void removeMethodEventListener(String inputPlace, String htmlEventListener, String methodName) {
        add("RM" + inputPlace, htmlEventListener + "|" + methodName);
    }

    public void removeModuleMethodEvent(String inputPlace, String htmlEvent, String methodName) {
        add("Rx" + inputPlace, htmlEvent + "|" + methodName);
    }

    public void removeModuleMethodEventListener(String inputPlace, String htmlEventListener, String methodName) {
        add("RX" + inputPlace, htmlEventListener + "|" + methodName);
    }

    public void removeConfirmEvent(String inputPlace, String htmlEvent) {
        add("Rf" + inputPlace, htmlEvent);
    }

    // Custom Event
    public void createCustomDOMEvent(String inputPlace, String eventName, String watch, String key, 
                                   String compare, String value, String range, boolean immediate, int delay) {
        add("eC" + inputPlace, eventName + "|" + watch + "|" + key + "|" + compare + "|" + 
            value + "|" + range + "|" + (immediate ? "1" : "0") + "|" + delay);
    }

    public void enableScrollBottomEvent(boolean enable) {
        add("eb", enable ? "1" : "0");
    }

    public void enableReachedElementEvent(String inputPlace, boolean once, boolean enable) {
        add("er" + inputPlace, (once ? "1" : "0") + "|" + (enable ? "1" : "0"));
    }

    // Module
    public void loadModule(String modulePath, String[] methods) {
        add("Ml", modulePath + ((methods != null && methods.length > 0) ? "|" + String.join("|", methods) : ""));
    }

    public void unloadModule(String modulePath) {
        add("Mu", modulePath);
    }

    public void deleteModuleMethod(String methodName) {
        add("Md", methodName);
    }

    // Unit Testing
    public void assertEqual(String inputPlace, String tag) {
        add("At" + inputPlace, tag.replace("\n", "$[ln];"));
    }

    public void assertEqualByOutputPlace(String inputPlace, String outputPlace) {
        add("Ao" + inputPlace, outputPlace);
    }

    // Service Worker
    public void serviceWorkerRegister(String path, String scopePath) {
        add("wR", path + "|" + scopePath);
    }

    public void serviceWorkerRegister(String path) {
        serviceWorkerRegister(path, null);
    }

    public void serviceWorkerPreCacheStatic(String[] pathList) {
        add("wp", String.join("|", pathList));
    }

    public void serviceWorkerDynamicCache(String path, int seconds) {
        add("wc", path + (seconds > 0 ? "|" + seconds : ""));
    }

    public void serviceWorkerDynamicCache(String path) {
        serviceWorkerDynamicCache(path, 0);
    }

    public void serviceWorkerDeleteDynamicCache() {
        add("wd");
    }

    public void serviceWorkerDeleteDynamicCache(String path) {
        add("wd", path);
    }

    public void serviceWorkerDynamicCacheTTLUpdate(String path, int seconds) {
        add("wt", path + (seconds > 0 ? "|" + seconds : ""));
    }

    public void serviceWorkerRouteSet(String path, String type, boolean cacheDynamic) {
        add("wr", path + "|" + type + (cacheDynamic ? "|1" : ""));
    }

    public void serviceWorkerRouteSet(String path, String type) {
        serviceWorkerRouteSet(path, type, false);
    }

    public void serviceWorkerRouteAlias(String path, String to) {
        add("wa", path + "|" + to);
    }

    public void serviceWorkerDeleteRouteAlias(String path) {
        add("wC", path);
    }

    public void serviceWorkerDeleteRouteAlias() {
        serviceWorkerDeleteRouteAlias(null);
    }

    public void serviceWorkerDeleteRoute() {
        add("wD");
    }

    public void serviceWorkerDeleteRoute(String path) {
        add("wD", path);
    }

    // SSE
    public void disconnectSSE(String path) {
        add("Ds", path);
    }

    public void disconnectAllSSE() {
        add("Ds");
    }

    // State
    public void addState(String path, String title) {
        add("AS", path + "|" + title);
    }

    public void addState(String path) {
        addState(path, null);
    }

    public void deleteState(String path) {
        add("DS", path);
    }

    public void deleteAllState() {
        add("DS", "*");
    }

    // Cookie
    public void setCookie(String key, String value, int seconds, String path) {
        add("sC", key + "|" + value + "|" + seconds + (path != null && !path.isEmpty() ? "|" + path : ""));
    }

    public void setCookie(String key, String value, int seconds) {
        setCookie(key, value, seconds, null);
    }

    // Save/Session Cache
    public void saveId(String inputPlace, String key) {
        add("@gi" + inputPlace, key != null ? key : ".");
    }

    public void saveId(String inputPlace) {
        saveId(inputPlace, ".");
    }

    public void saveName(String inputPlace, String key) {
        add("@gn" + inputPlace, key != null ? key : ".");
    }

    public void saveName(String inputPlace) {
        saveName(inputPlace, ".");
    }

    public void saveValue(String inputPlace, String key) {
        add("@gv" + inputPlace, key != null ? key : ".");
    }

    public void saveValue(String inputPlace) {
        saveValue(inputPlace, ".");
    }

    public void saveValueLength(String inputPlace, String key) {
        add("@ge" + inputPlace, key != null ? key : ".");
    }

    public void saveValueLength(String inputPlace) {
        saveValueLength(inputPlace, ".");
    }

    public void saveClass(String inputPlace, String key) {
        add("@gc" + inputPlace, key != null ? key : ".");
    }

    public void saveClass(String inputPlace) {
        saveClass(inputPlace, ".");
    }

    public void saveStyle(String inputPlace, String key) {
        add("@gs" + inputPlace, key != null ? key : ".");
    }

    public void saveStyle(String inputPlace) {
        saveStyle(inputPlace, ".");
    }

    public void saveTitle(String inputPlace, String key) {
        add("@gl" + inputPlace, key != null ? key : ".");
    }

    public void saveTitle(String inputPlace) {
        saveTitle(inputPlace, ".");
    }

    public void saveLabel(String inputPlace, String key) {
        add("@gA" + inputPlace, key != null ? key : ".");
    }

    public void saveLabel(String inputPlace) {
        saveLabel(inputPlace, ".");
    }

    public void saveText(String inputPlace, String key) {
        add("@gt" + inputPlace, key != null ? key : ".");
    }

    public void saveText(String inputPlace) {
        saveText(inputPlace, ".");
    }

    public void saveOuterText(String inputPlace, String key) {
        add("@go" + inputPlace, key != null ? key : ".");
    }

    public void saveOuterText(String inputPlace) {
        saveOuterText(inputPlace, ".");
    }

    public void saveTextLength(String inputPlace, String key) {
        add("@gg" + inputPlace, key != null ? key : ".");
    }

    public void saveTextLength(String inputPlace) {
        saveTextLength(inputPlace, ".");
    }

    public void saveAttribute(String inputPlace, String attribute, String key) {
        add("@ga" + inputPlace, (key != null ? key : ".") + '|' + attribute);
    }

    public void saveAttribute(String inputPlace, String attribute) {
        saveAttribute(inputPlace, attribute, ".");
    }

    public void saveWidth(String inputPlace, String key) {
        add("@gw" + inputPlace, key != null ? key : ".");
    }

    public void saveWidth(String inputPlace) {
        saveWidth(inputPlace, ".");
    }

    public void saveHeight(String inputPlace, String key) {
        add("@gh" + inputPlace, key != null ? key : ".");
    }

    public void saveHeight(String inputPlace) {
        saveHeight(inputPlace, ".");
    }

    public void saveReadOnly(String inputPlace, String key) {
        add("@gr" + inputPlace, key != null ? key : ".");
    }

    public void saveReadOnly(String inputPlace) {
        saveReadOnly(inputPlace, ".");
    }

    public void saveSelectedIndex(String inputPlace, String key) {
        add("@gx" + inputPlace, key != null ? key : ".");
    }

    public void saveSelectedIndex(String inputPlace) {
        saveSelectedIndex(inputPlace, ".");
    }

    public void saveTextAlign(String inputPlace, String key) {
        add("@gT" + inputPlace, key != null ? key : ".");
    }

    public void saveTextAlign(String inputPlace) {
        saveTextAlign(inputPlace, ".");
    }

    public void saveNodeLength(String inputPlace, String key) {
        add("@gL" + inputPlace, key != null ? key : ".");
    }

    public void saveNodeLength(String inputPlace) {
        saveNodeLength(inputPlace, ".");
    }

    public void saveVisible(String inputPlace, String key) {
        add("@gV" + inputPlace, key != null ? key : ".");
    }

    public void saveVisible(String inputPlace) {
        saveVisible(inputPlace, ".");
    }

    public void saveUrl(String url, boolean fetchScript, String key) {
        add("@gu", (key != null ? key : ".") + "|" + url + (fetchScript ? "|1" : ""));
    }

    public void saveUrl(String url, boolean fetchScript) {
        saveUrl(url, fetchScript, ".");
    }

    public void saveIndex(String inputPlace, String key) {
        add("@gI" + inputPlace, key != null ? key : ".");
    }

    public void saveIndex(String inputPlace) {
        saveIndex(inputPlace, ".");
    }

    public void removeSessionCache(String cacheKey) {
        add("rs", cacheKey);
    }

    public void removeAllSessionCache() {
        add("rs", "*");
    }

    public void setSessionCache() {
        add("cs", "*");
    }

    public void addSessionCacheValue(String cacheKey, String value) {
        add("SA", cacheKey + "|" + value.replace("\n", "$[ln];"));
    }

    public void insertSessionCacheValue(String cacheKey, String value) {
        add("SI", cacheKey + "|" + value.replace("\n", "$[ln];"));
    }

    // Cache
    public void cacheId(String inputPlace, String key) {
        add("@ci" + inputPlace, key != null ? key : ".");
    }

    public void cacheId(String inputPlace) {
        cacheId(inputPlace, ".");
    }

    public void cacheName(String inputPlace, String key) {
        add("@cn" + inputPlace, key != null ? key : ".");
    }

    public void cacheName(String inputPlace) {
        cacheName(inputPlace, ".");
    }

    public void cacheValue(String inputPlace, String key) {
        add("@cv" + inputPlace, key != null ? key : ".");
    }

    public void cacheValue(String inputPlace) {
        cacheValue(inputPlace, ".");
    }

    public void cacheValueLength(String inputPlace, String key) {
        add("@ce" + inputPlace, key != null ? key : ".");
    }

    public void cacheValueLength(String inputPlace) {
        cacheValueLength(inputPlace, ".");
    }

    public void cacheClass(String inputPlace, String key) {
        add("@cc" + inputPlace, key != null ? key : ".");
    }

    public void cacheClass(String inputPlace) {
        cacheClass(inputPlace, ".");
    }

    public void cacheStyle(String inputPlace, String key) {
        add("@cs" + inputPlace, key != null ? key : ".");
    }

    public void cacheStyle(String inputPlace) {
        cacheStyle(inputPlace, ".");
    }

    public void cacheTitle(String inputPlace, String key) {
        add("@cl" + inputPlace, key != null ? key : ".");
    }

    public void cacheTitle(String inputPlace) {
        cacheTitle(inputPlace, ".");
    }

    public void cacheLabel(String inputPlace, String key) {
        add("@cA" + inputPlace, key != null ? key : ".");
    }

    public void cacheLabel(String inputPlace) {
        cacheLabel(inputPlace, ".");
    }

    public void cacheText(String inputPlace, String key) {
        add("@ct" + inputPlace, key != null ? key : ".");
    }

    public void cacheText(String inputPlace) {
        cacheText(inputPlace, ".");
    }

    public void cacheOuterText(String inputPlace, String key) {
        add("@co" + inputPlace, key != null ? key : ".");
    }

    public void cacheOuterText(String inputPlace) {
        cacheOuterText(inputPlace, ".");
    }

    public void cacheTextLength(String inputPlace, String key) {
        add("@cg" + inputPlace, key != null ? key : ".");
    }

    public void cacheTextLength(String inputPlace) {
        cacheTextLength(inputPlace, ".");
    }

    public void cacheAttribute(String inputPlace, String attribute, String key) {
        add("@ca" + inputPlace, (key != null ? key : ".") + '|' + attribute);
    }

    public void cacheAttribute(String inputPlace, String attribute) {
        cacheAttribute(inputPlace, attribute, ".");
    }

    public void cacheWidth(String inputPlace, String key) {
        add("@cw" + inputPlace, key != null ? key : ".");
    }

    public void cacheWidth(String inputPlace) {
        cacheWidth(inputPlace, ".");
    }

    public void cacheHeight(String inputPlace, String key) {
        add("@ch" + inputPlace, key != null ? key : ".");
    }

    public void cacheHeight(String inputPlace) {
        cacheHeight(inputPlace, ".");
    }

    public void cacheReadOnly(String inputPlace, String key) {
        add("@cr" + inputPlace, key != null ? key : ".");
    }

    public void cacheReadOnly(String inputPlace) {
        cacheReadOnly(inputPlace, ".");
    }

    public void cacheSelectedIndex(String inputPlace, String key) {
        add("@cx" + inputPlace, key != null ? key : ".");
    }

    public void cacheSelectedIndex(String inputPlace) {
        cacheSelectedIndex(inputPlace, ".");
    }

    public void cacheTextAlign(String inputPlace, String key) {
        add("@cT" + inputPlace, key != null ? key : ".");
    }

    public void cacheTextAlign(String inputPlace) {
        cacheTextAlign(inputPlace, ".");
    }

    public void cacheNodeLength(String inputPlace, String key) {
        add("@cL" + inputPlace, key != null ? key : ".");
    }

    public void cacheNodeLength(String inputPlace) {
        cacheNodeLength(inputPlace, ".");
    }

    public void cacheVisible(String inputPlace, String key) {
        add("@cV" + inputPlace, key != null ? key : ".");
    }

    public void cacheVisible(String inputPlace) {
        cacheVisible(inputPlace, ".");
    }

    public void cacheUrl(String url, boolean fetchScript, String key) {
        add("@cu", (key != null ? key : ".") + "|" + url + (fetchScript ? "|1" : ""));
    }

    public void cacheUrl(String url, boolean fetchScript) {
        cacheUrl(url, fetchScript, ".");
    }

    public void cacheIndex(String inputPlace, String key) {
        add("@cI" + inputPlace, key != null ? key : ".");
    }

    public void cacheIndex(String inputPlace) {
        cacheIndex(inputPlace, ".");
    }

    public void removeCache(String cacheKey) {
        add("rd", cacheKey);
    }

    public void removeAllCache() {
        add("rd", "*");
    }

    public void setCache(int second) {
        add("cd", Integer.toString(second));
    }

    public void setCache() {
        add("cd", "*");
    }

    public void addCacheValue(String cacheKey, String value) {
        add("CA", cacheKey + "|" + value.replace("\n", "$[ln];"));
    }

    public void insertCacheValue(String cacheKey, String value) {
        add("CI", cacheKey + "|" + value.replace("\n", "$[ln];"));
    }

    // Call
    public void loadUrl(String inputPlace, String url) {
        add("lu" + inputPlace, url);
    }

    public void runActionControls(String actionControls, String index, boolean withoutWebFormsSection, boolean useCurrentEvent) {
        add("lA", (useCurrentEvent ? "1" : "0") + "|" + (withoutWebFormsSection ? "1" : "0") + 
            "|" + index + "|" + actionControls);
    }

    public void runActionControls(String actionControls, int index, boolean withoutWebFormsSection, boolean useCurrentEvent) {
        runActionControls(actionControls, Integer.toString(index), withoutWebFormsSection, useCurrentEvent);
    }

    public void runActionControls(String actionControls, String index) {
        runActionControls(actionControls, index, false, true);
    }

    public void runActionControls(String actionControls, int index) {
        runActionControls(actionControls, index, false, true);
    }

    public void callScript(String scriptText) {
        add("_", scriptText.replace("\n", "$[ln];"));
    }

    public void callMethod(String methodName, String[] args) {
        String argsJoin = "";

        if (args != null && args.length > 0)
            argsJoin = "|" + String.join("|", args);

        add("lm", methodName + argsJoin);
    }

    public void callMethod(String methodName) {
        callMethod(methodName, null);
    }

    public void callModuleMethod(String methodName, String[] args) {
        String argsJoin = "";

        if (args != null && args.length > 0)
            argsJoin = "|" + String.join("|", args);

        add("lM", methodName + argsJoin);
    }

    public void callModuleMethod(String methodName) {
        callModuleMethod(methodName, null);
    }

    public void callPostBack(String formInputPlace, String outputPlace) {
        add("Lp", "1" + "|" + formInputPlace + 
            (outputPlace != null && !outputPlace.isEmpty() ? "|" + outputPlace : ""));
    }

    public void callPostBack(String formInputPlace) {
        callPostBack(formInputPlace, null);
    }

    public void callTagBack(String outputPlace, boolean useCurrentEvent) {
        add("Lt", (useCurrentEvent ? "1" : "0") + 
            (outputPlace != null && !outputPlace.isEmpty() ? "|" + outputPlace : ""));
    }

    public void callTagBack(String outputPlace) {
        callTagBack(outputPlace, true);
    }

    public void callTagBack() {
        callTagBack(null, true);
    }

    public void callCommentBack(String index, String outputPlace, boolean useCurrentEvent) {
        add("LC", (useCurrentEvent ? "1" : "0") + "|" + index + "|" + outputPlace);
    }

    public void callCommentBack(int index, String outputPlace, boolean useCurrentEvent) {
        callCommentBack(Integer.toString(index), outputPlace, useCurrentEvent);
    }

    public void callCommentBack(String index, String outputPlace) {
        callCommentBack(index, outputPlace, true);
    }

    public void callWasmBack(String wasmLanguage, String wasmUrl, String methodName, 
                           String[] args, String outputPlace, boolean useCurrentEvent) {
        String argsJoin = "";

        if (args != null && args.length > 0)
            argsJoin = String.join(",", args);

        add("Ly", (useCurrentEvent ? "1" : "0") + "|" + wasmLanguage + "|" + wasmUrl + "|" + 
            methodName + "|" + argsJoin + "|" + outputPlace);
    }

    public void callWebSocketBack(String path, boolean useCurrentEvent) {
        add("Lw", (useCurrentEvent ? "1" : "0") + "|" + path);
    }

    public void callWebSocketBack(String path) {
        callWebSocketBack(path, true);
    }

    public void callSSEBack(String path, String outputPlace, boolean useCurrentEvent, 
                          boolean shouldReconnect, int reconnectTryTimeout) {
        add("Ls", (useCurrentEvent ? "1" : "0") + "|" + path + "|" + 
            (shouldReconnect ? "1" : "0") + "|" + reconnectTryTimeout + 
            (outputPlace != null && !outputPlace.isEmpty() ? "|" + outputPlace : ""));
    }

    public void callSSEBack(String path, String outputPlace) {
        callSSEBack(path, outputPlace, true, true, 3000);
    }

    public void callFront(String modulePath, String[] args, String outputPlace, boolean useCurrentEvent) {
        String argsJoin = "";

        if (args != null && args.length > 0)
            argsJoin = "|" + String.join("|", args);

        add("Lj", (useCurrentEvent ? "1" : "0") + "|" + modulePath + "|" + outputPlace + argsJoin);
    }

    public void callFront(String modulePath, String[] args, String outputPlace) {
        callFront(modulePath, args, outputPlace, true);
    }

    public void callGetBack(String path, String outputPlace, boolean useCurrentEvent) {
        add("Lg", (useCurrentEvent ? "1" : "0") + "|" + path + 
            (outputPlace != null && !outputPlace.isEmpty() ? "|" + outputPlace : ""));
    }

    public void callGetBack(String path, String outputPlace) {
        callGetBack(path, outputPlace, true);
    }

    public void callPutBack(String path, String outputPlace, boolean useCurrentEvent) {
        add("Lu", (useCurrentEvent ? "1" : "0") + "|" + path + 
            (outputPlace != null && !outputPlace.isEmpty() ? "|" + outputPlace : ""));
    }

    public void callPutBack(String path, String outputPlace) {
        callPutBack(path, outputPlace, true);
    }

    public void callPatchBack(String path, String outputPlace, boolean useCurrentEvent) {
        add("LP", (useCurrentEvent ? "1" : "0") + "|" + path + 
            (outputPlace != null && !outputPlace.isEmpty() ? "|" + outputPlace : ""));
    }

    public void callPatchBack(String path, String outputPlace) {
        callPatchBack(path, outputPlace, true);
    }

    public void callDeleteBack(String path, String outputPlace, boolean useCurrentEvent) {
        add("Ld", (useCurrentEvent ? "1" : "0") + "|" + path + 
            (outputPlace != null && !outputPlace.isEmpty() ? "|" + outputPlace : ""));
    }

    public void callDeleteBack(String path, String outputPlace) {
        callDeleteBack(path, outputPlace, true);
    }

    public void callHeadBack(String path, String outputPlace, boolean useCurrentEvent) {
        add("Lh", (useCurrentEvent ? "1" : "0") + "|" + path + 
            (outputPlace != null && !outputPlace.isEmpty() ? "|" + outputPlace : ""));
    }

    public void callHeadBack(String path, String outputPlace) {
        callHeadBack(path, outputPlace, true);
    }

    public void callOptionsBack(String path, String outputPlace, boolean useCurrentEvent) {
        add("Lo", (useCurrentEvent ? "1" : "0") + "|" + path + 
            (outputPlace != null && !outputPlace.isEmpty() ? "|" + outputPlace : ""));
    }

    public void callOptionsBack(String path, String outputPlace) {
        callOptionsBack(path, outputPlace, true);
    }

    public void callTraceBack(String path, String outputPlace, boolean useCurrentEvent) {
        add("LT", (useCurrentEvent ? "1" : "0") + "|" + path + 
            (outputPlace != null && !outputPlace.isEmpty() ? "|" + outputPlace : ""));
    }

    public void callTraceBack(String path, String outputPlace) {
        callTraceBack(path, outputPlace, true);
    }

    public void callConnectBack(String path, String outputPlace, boolean useCurrentEvent) {
        add("Lc", (useCurrentEvent ? "1" : "0") + "|" + path + 
            (outputPlace != null && !outputPlace.isEmpty() ? "|" + outputPlace : ""));
    }

    public void callConnectBack(String path, String outputPlace) {
        callConnectBack(path, outputPlace, true);
    }

    public void callSendBack(String path, String method, boolean isMultiPart, String contentType, 
                           String data, String outputPlace, boolean useCurrentEvent) {
        String safeData = data.replace("\n", "$[ln];").replace("|", "$[vb];");
        add("LS", (useCurrentEvent ? "1" : "0") + "|" + path + "|" + method + "|" + 
            (isMultiPart ? "1" : "0") + "|" + contentType + "|" + safeData + 
            (outputPlace != null && !outputPlace.isEmpty() ? "|" + outputPlace : ""));
    }

    // Update
    public void increase(String inputPlace, float value) {
        add("gt" + inputPlace, "i|" + Float.toString(value));
    }

    public void decrease(String inputPlace, float value) {
        add("gt" + inputPlace, "i|" + Float.toString(value * -1));
    }

    public void replace(String inputPlace, String value, String newValue, boolean alsoStartTag, boolean deep) {
        String safeValue = value;
        String safeNewValue = newValue;

        if (safeValue != null && !safeValue.isEmpty() && safeValue.charAt(0) == '@') {
            safeValue = safeValue.substring(1);
            safeValue = "$[at];" + safeValue;
        }

        if (safeNewValue != null && !safeNewValue.isEmpty() && safeNewValue.charAt(0) == '@') {
            safeNewValue = safeNewValue.substring(1);
            safeNewValue = "$[at];" + safeNewValue;
        }

        add("gt" + inputPlace, "r|" + safeValue + "|" + safeNewValue + "|" + 
            (alsoStartTag ? "1" : "0") + "|" + (deep ? "1" : "0"));
    }

    public void replaceStartTag(String inputPlace, String value, String newValue) {
        String safeValue = value;
        String safeNewValue = newValue;

        if (safeValue != null && !safeValue.isEmpty() && safeValue.charAt(0) == '@') {
            safeValue = safeValue.substring(1);
            safeValue = "$[at];" + safeValue;
        }

        if (safeNewValue != null && !safeNewValue.isEmpty() && safeNewValue.charAt(0) == '@') {
            safeNewValue = safeNewValue.substring(1);
            safeNewValue = "$[at];" + safeNewValue;
        }

        add("gt" + inputPlace, "s|" + safeValue + "|" + safeNewValue);
    }

    // Pre Runner
    public void assignDelay(int miliSecond, int index) {
        String currentLine = getLineByIndex(index);
        if (currentLine == null || currentLine.isEmpty())
            return;

        String[] parts = currentLine.split("=", 2);
        String newName = ":" + miliSecond + ")" + parts[0];
        String newValue = parts.length > 1 ? parts[1] : "";

        updateLineByIndex(index, newName, newValue);
    }

    public void assignDelay(int miliSecond) {
        assignDelay(miliSecond, -1);
    }

    public void assignDelayChange(int miliSecond, int index) {
        String currentLine = getLineByIndex(index);
        if (currentLine == null || currentLine.isEmpty())
            return;

        String[] parts = currentLine.split("=", 2);
        String currentName = parts[0];

        if (currentName.startsWith(":") && currentName.contains(")")) {
            int closingBracket = currentName.indexOf(')');
            currentName = currentName.substring(closingBracket + 1);
        }

        String newName = ":" + miliSecond + ")" + currentName;
        String newValue = parts.length > 1 ? parts[1] : "";

        updateLineByIndex(index, newName, newValue);
    }

    public void assignDelayChange(int miliSecond) {
        assignDelayChange(miliSecond, -1);
    }

    public void assignInterval(int miliSecond, String id, int index) {
        String currentLine = getLineByIndex(index);
        if (currentLine == null || currentLine.isEmpty())
            return;

        String[] parts = currentLine.split("=", 2);
        String newName = "(" + miliSecond + (id != null && !id.isEmpty() ? "|" + id : "") + ")" + parts[0];
        String newValue = parts.length > 1 ? parts[1] : "";

        updateLineByIndex(index, newName, newValue);
    }

    public void assignInterval(int miliSecond, int index) {
        assignInterval(miliSecond, null, index);
    }

    public void assignInterval(int miliSecond) {
        assignInterval(miliSecond, null, -1);
    }

    public void assignIntervalChange(int miliSecond, String id, int index) {
        String currentLine = getLineByIndex(index);
        if (currentLine == null || currentLine.isEmpty())
            return;

        String[] parts = currentLine.split("=", 2);
        String currentName = parts[0];

        if (currentName.startsWith("(") && currentName.contains(")")) {
            int closingBracket = currentName.indexOf(')');
            currentName = currentName.substring(closingBracket + 1);
        }

        String newName = "(" + miliSecond + (id != null && !id.isEmpty() ? "|" + id : "") + ")" + currentName;
        String newValue = parts.length > 1 ? parts[1] : "";

        updateLineByIndex(index, newName, newValue);
    }

    public void assignIntervalChange(int miliSecond, int index) {
        assignIntervalChange(miliSecond, null, index);
    }

    public void deleteInterval(String id) {
        add("Di", id);
    }

    public void assignRepeat(int count, int index) {
        String currentLine = getLineByIndex(index);
        if (currentLine == null || currentLine.isEmpty())
            return;

        String[] parts = currentLine.split("=", 2);
        String newName = "," + count + ")" + parts[0];
        String newValue = parts.length > 1 ? parts[1] : "";

        updateLineByIndex(index, newName, newValue);
    }

    public void assignRepeat(int count) {
        assignRepeat(count, -1);
    }

    public void assignRepeatChange(int count, int index) {
        String currentLine = getLineByIndex(index);
        if (currentLine == null || currentLine.isEmpty())
            return;

        String[] parts = currentLine.split("=", 2);
        String currentName = parts[0];

        if (currentName.startsWith(",") && currentName.contains(")")) {
            int closingBracket = currentName.indexOf(')');
            currentName = currentName.substring(closingBracket + 1);
        }

        String newName = "," + count + ")" + currentName;
        String newValue = parts.length > 1 ? parts[1] : "";

        updateLineByIndex(index, newName, newValue);
    }

    public void assignRepeatChange(int count) {
        assignRepeatChange(count, -1);
    }

    // Index
    public void startIndex(String name) {
        add("#", name);
    }

    public void startIndex() {
        startIndex("");
    }

    public void goTo(int line, int repeat) {
        add("&", line + "|" + repeat);
    }

    public void goTo(int line) {
        goTo(line, 1);
    }

    public void goTo(String index, int repeat) {
        add("&", "#" + index + "|" + repeat);
    }

    public void goTo(String index) {
        goTo(index, 1);
    }

    // Start
    public void startTransientDOM(String inputPlace) {
        add("td", inputPlace);
    }

    public void endTransientDOM() {
        add("td", ";");
    }

    // Message
    public void alert(String text, String type, String title, String okText) {
        String safeType = type.equals("none") ? "" : type;
        String safeTitle = title.equals("Alert") ? "" : title;
        String safeOkText = okText.equals("OK") ? "" : okText;
        
        add("Al", text + "|" + safeType + "|" + safeTitle + "|" + safeOkText);
    }

    public void alert(String text) {
        alert(text, "none", "Alert", "OK");
    }

    public void message(String text, String type, int duration) {
        String safeType = type.equals("none") ? "" : type;
        add("me", text + "|" + safeType + "|" + (duration == 0 ? "" : Integer.toString(duration)));
    }

    public void message(String text) {
        message(text, "none", 0);
    }

    public void consoleMessage(String text, String type) {
        add("mc", text.replace("\n", "$[ln];") + (type.equals("log") ? "" : "|" + type));
    }

    public void consoleMessage(String text) {
        consoleMessage(text, "log");
    }

    public void consoleMessageAssert(String text, String condition) {
        add("ma", text.replace("\n", "$[ln];") + "|" + condition);
    }

    // Enable
    public void enableWebSocket(boolean enable) {
        add("ew", enable ? "1" : "0");
    }

    public void enableWebSocket() {
        enableWebSocket(true);
    }

    public void enableWebSocketOnce() {
        add("ew", "$");
    }

    public void addWebSocket(String path) {
        add("aw" + path);
    }

    // Use
    public void useWebSocket(String inputPlace) {
        add("uw" + inputPlace);
    }

    public void useOnlyChangeUpdate(String inputPlace) {
        add("uo" + inputPlace);
    }

    // Condition
    public void confirmIsTrueAccept(String text, String type, String title, String okText, String cancelText, float interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        String safeText = text.equals("Are you sure you want to proceed?") ? "" : text;
        String safeType = type.equals("none") ? "" : type;
        String safeTitle = title.equals("Confirm") ? "" : title;
        String safeOkText = okText.equals("OK") ? "" : okText;
        String safeCancelText = cancelText.equals("Cancel") ? "" : cancelText;
        
        add(prefix + "ct", safeText + "|" + safeType + "|" + safeTitle + "|" + safeOkText + "|" + safeCancelText);
    }

    public void confirmIsTrueAccept(String text) {
        confirmIsTrueAccept(text, "none", "Confirm", "OK", "Cancel", 100);
    }

    public void confirmIsFalseAccept(String text, String type, String title, String okText, String cancelText, float interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        String safeText = text.equals("Are you sure you want to proceed?") ? "" : text;
        String safeType = type.equals("none") ? "" : type;
        String safeTitle = title.equals("Confirm") ? "" : title;
        String safeOkText = okText.equals("OK") ? "" : okText;
        String safeCancelText = cancelText.equals("Cancel") ? "" : cancelText;
        
        add(prefix + "cf", safeText + "|" + safeType + "|" + safeTitle + "|" + safeOkText + "|" + safeCancelText);
    }

    public void confirmIsFalseAccept(String text) {
        confirmIsFalseAccept(text, "none", "Confirm", "OK", "Cancel", 100);
    }

    public void isGreaterThan(String firstValue, String secondValue, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "gt", firstValue + "|" + secondValue);
    }

    public void isGreaterThan(String firstValue, String secondValue) {
        isGreaterThan(firstValue, secondValue, -1);
    }

    public void isLessThan(String firstValue, String secondValue, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "lt", firstValue + "|" + secondValue);
    }

    public void isLessThan(String firstValue, String secondValue) {
        isLessThan(firstValue, secondValue, -1);
    }

    public void isEqualTo(String firstValue, String secondValue, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "et", firstValue + "|" + secondValue);
    }

    public void isEqualTo(String firstValue, String secondValue) {
        isEqualTo(firstValue, secondValue, -1);
    }

    public void isNotEqualTo(String firstValue, String secondValue, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "Nt", firstValue + "|" + secondValue);
    }

    public void isNotEqualTo(String firstValue, String secondValue) {
        isNotEqualTo(firstValue, secondValue, -1);
    }

    public void exist(String value, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "ex", value);
    }

    public void exist(String value) {
        exist(value, -1);
    }

    public void notExist(String value, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "nx", value);
    }

    public void notExist(String value) {
        notExist(value, -1);
    }

    public void isTrue(String value, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "tr", value);
    }

    public void isTrue(String value) {
        isTrue(value, -1);
    }

    public void isFalse(String value, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "fa", value);
    }

    public void isFalse(String value) {
        isFalse(value, -1);
    }

    public void isMatchMedia(String value, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "mm", value);
    }

    public void isMatchMedia(String value) {
        isMatchMedia(value, -1);
    }

    public void isNotMatchMedia(String value, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "nm", value);
    }

    public void isNotMatchMedia(String value) {
        isNotMatchMedia(value, -1);
    }

    public void include(String text, String value, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "In", value + "|" + text);
    }

    public void include(String text, String value) {
        include(text, value, -1);
    }

    public void notInclude(String text, String value, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "Nn", value + "|" + text);
    }

    public void notInclude(String text, String value) {
        notInclude(text, value, -1);
    }

    public void elementExists(String inputPlace, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "eE", inputPlace);
    }

    public void elementExists(String inputPlace) {
        elementExists(inputPlace, -1);
    }

    public void elementNotExists(String inputPlace, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "nE", inputPlace);
    }

    public void elementNotExists(String inputPlace) {
        elementNotExists(inputPlace, -1);
    }

    public void isRegexMatch(String value, String pattern, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "re", value + "|" + pattern);
    }

    public void isRegexMatch(String value, String pattern) {
        isRegexMatch(value, pattern, -1);
    }

    public void isRegexNotMatch(String value, String pattern, int interval) {
        String prefix = (interval >= 0) ? "{(" + interval + ")" : "{";
        add(prefix + "rn", value + "|" + pattern);
    }

    public void isRegexNotMatch(String value, String pattern) {
        isRegexNotMatch(value, pattern, -1);
    }

    public void breakCondition() {
        add(";");
    }

    public void startBracket() {
        add("{");
    }

    public void endBracket() {
        add("}");
    }

    // Async
    public void async() {
        add("{(a)");
    }

    public void delay(int miliSecond) {
        add("De", Integer.toString(miliSecond));
    }

    // Format Storage
    public void createFormatStorage(String key, String data) {
        add(".C", key + "|" + data);
    }

    public void deleteFormatStorage(String key) {
        add(".D", key);
    }

    public void addJSON(String key, String path, String value) {
        add(".a", key + "|j|" + value + "|" + path);
    }

    public void addXML(String key, String path, String name, String value) {
        String safeName = name;
        if (safeName != null && !safeName.isEmpty() && safeName.charAt(0) == '@') {
            safeName = safeName.substring(1);
            safeName = "$[at];" + safeName;
        }
        safeName = safeName.replace("@", "$[at];");
        
        add(".a", key + "|x|" + safeName + "|" + value + "|" + path);
    }

    public void addXML(String key, String path, String name) {
        addXML(key, path, name, null);
    }

    public void addINI(String key, String path, String value, boolean isINILike) {
        add(".a", key + "|i|" + (isINILike ? "1" : "0") + "|" + value + "|" + path);
    }

    public void addINI(String key, String path, String value) {
        addINI(key, path, value, false);
    }

    public void addTextLine(String key, int line, String text) {
        add(".a", key + "|t|" + text + "|" + line);
    }

    public void addVariable(String key, String value) {
        add(".a", key + "|v|" + value);
    }

    public void updateJSON(String key, String path, String value) {
        add(".u", key + "|j|" + value + "|" + path);
    }

    public void updateXML(String key, String path, String value) {
        add(".u", key + "|x|" + value + "|" + path);
    }

    public void updateINI(String key, String path, String value, boolean isINILike) {
        add(".u", key + "|i|" + (isINILike ? "1" : "0") + "|" + value + "|" + path);
    }

    public void updateINI(String key, String path, String value) {
        updateINI(key, path, value, false);
    }

    public void updateTextLine(String key, int line, String text) {
        add(".u", key + "|t|" + text + "|" + line);
    }

    public void updateVariable(String key, String value) {
        add(".u", key + "|v|" + value);
    }

    public void increaseVariable(String key, int value) {
        add(".i", key + "|v|" + value);
    }

    public void decreaseVariable(String key, int value) {
        increaseVariable(key, value * -1);
    }

    public void deleteJSON(String key, String path) {
        add(".d", key + "|j|" + path);
    }

    public void deleteXML(String key, String path) {
        add(".d", key + "|x|" + path);
    }

    public void deleteINI(String key, String path, boolean isINILike) {
        add(".d", key + "|i|" + (isINILike ? "1" : "0") + "|" + path);
    }

    public void deleteINI(String key, String path) {
        deleteINI(key, path, false);
    }

    public void deleteTextLine(String key, int line) {
        add(".d", key + "|t|" + line);
    }

    public void deleteVariable(String key) {
        add(".d", key + "|v");
    }

    // Inject
    public String inject(String value) {
        return "$[" + value + "];";
    }

    // Hash And Checksum
    public void setHash() {
        add("SH");
    }

    public void setChecksum() {
        add("CS");
    }

    public String checksumCalculation(String text) {
        int sum = 0;
        int mod = 65536;
        int shift = 5;

        for (char c : text.toCharArray()) {
            sum = ((sum << shift) | (sum >> (16 - shift))) ^ c;
            sum %= mod;
        }

        return Integer.toString(sum);
    }

    public String getChecksum() {
        return checksumCalculation(getWebFormsData());
    }

    // Get
    public String getFormsActionData() {
        if (webFormsData.length() == 0)
            return "";

        return webFormsData.toString();
    }

    public String response() {
        return "[web-forms]\n" + getFormsActionData();
    }

    // Overload
    public String response(HttpServletResponse response) {
        setHeaders(response);
        return response();
    }

    public String getFormsActionDataLineBreak() {
        if (webFormsData.length() == 0)
            return "";

        String data = webFormsData.toString();
        String processedData = data.replace("\"", "$[dq];");
        return processedData.replace("\n", "$[sln];");
    }

    // Export
    public String exportToWebFormsTag(String src) {
        return "<web-forms ac=\"" + getFormsActionDataLineBreak() + "\"" + 
               (src != null && !src.isEmpty() ? " src=\"" + src + "\"" : "") + "></web-forms>";
    }

    public String exportToWebFormsTag() {
        return exportToWebFormsTag(null);
    }

    public String exportToLineBreak(String src) {
        return "[web-forms]$[sln];" + getFormsActionDataLineBreak();
    }

    public String exportToLineBreak() {
        return exportToLineBreak(null);
    }

    // Overload
    public String exportToWebFormsTag(String width, String height, String src) {
        return "<web-forms ac=\"" + getFormsActionDataLineBreak() + "\" width=\"" + width + 
               "\" height=\"" + height + "\"" + 
               (src != null && !src.isEmpty() ? " src=\"" + src + "\"" : "") + "></web-forms>";
    }

    // Overload
    public String exportToWebFormsTag(int width, int height, String src) {
        return exportToWebFormsTag(width + "px", height + "px", src);
    }

    public String exportToWebFormsTag(int width, int height) {
        return exportToWebFormsTag(width, height, null);
    }

    public String doneToWebFormsTag(String id) {
        return "<web-forms ac=\"" + getFormsActionDataLineBreak() + "\"" + 
               (id != null && !id.isEmpty() ? " id=\"" + id + "\" done=\"true\"" : "") + "></web-forms>";
    }

    public String doneToWebFormsTag() {
        return doneToWebFormsTag(null);
    }

    public String exportToHtmlComment(boolean addLine) {
        return (addLine ? "\n" : "") + "<!--" + response() + "-->";
    }

    public String exportToHtmlComment() {
        return exportToHtmlComment(false);
    }

    public String getWebFormsData() {
        return webFormsData.toString();
    }

    public void appendForm(WebForms form) {
        if (form == null) return;

        String otherData = form.getWebFormsData();
        if (otherData != null && !otherData.isEmpty()) {
            if (webFormsData.length() > 0)
                webFormsData.append('\n');
            webFormsData.append(otherData);
        }
    }

    public void setHeaders(HttpServletResponse response) {
        response.setHeader("Content-Type", "text/plain");
    }

    public void clean() {
        webFormsData = new StringBuilder();
    }
}
