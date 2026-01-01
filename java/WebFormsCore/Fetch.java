package WebFormsCore;

// WebForms.java 2.0 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.0

import java.util.Arrays;

/// <summary>
/// Do Not Add Any Data Before Or After It
/// </summary>
public class Fetch {
    // Method
    public static String random(int maxValue) {
        return "@mr" + maxValue;
    }

    public static String random(int minValue, int maxValue) {
        return "@mr" + maxValue + "," + minValue;
    }

    public static String spaceToChar(String text, String character) {
        return "@sc" + character + "," + text;
    }

    public static String spaceToChar(String text) {
        return spaceToChar(text, "-");
    }

    public static String encodeURI(String text) {
        return "@ue" + text;
    }

    public static String decodeURI(String text) {
        return "@ud" + text;
    }

    public static String method(String methodName, String[] args) {
        StringBuilder returnValue = new StringBuilder("@cm" + methodName);

        if (args != null && args.length > 0)
            returnValue.append(",").append(String.join(",", args));

        return returnValue.toString();
    }

    public static String method(String methodName) {
        return method(methodName, null);
    }

    public static String moduleMethod(String methodName, String[] args) {
        StringBuilder returnValue = new StringBuilder("@cM" + methodName);

        if (args != null && args.length > 0)
            returnValue.append(",").append(String.join(",", args));

        return returnValue.toString();
    }

    public static String moduleMethod(String methodName) {
        return moduleMethod(methodName, null);
    }

    public static String wasmMethod(String wasmLanguage, String wasmUrl, String methodName, 
                                  String[] args, String key) {
        StringBuilder returnValue = new StringBuilder("@wA" + wasmLanguage + "," + wasmUrl + "," + methodName);

        if (args != null && args.length > 0)
            returnValue.append(",").append(String.join(",", args));

        return returnValue.toString();
    }

    public static String wasmMethod(String wasmLanguage, String wasmUrl, String methodName, String[] args) {
        return wasmMethod(wasmLanguage, wasmUrl, methodName, args, ".");
    }

    public static String script(String scriptText) {
        return "@_" + scriptText.replace("\n", "$[ln];");
    }

    public static String loadUrl(String url, boolean fetchScript) {
        return "@lu" + url + (fetchScript ? ",1" : "");
    }

    public static String loadUrl(String url) {
        return loadUrl(url, false);
    }

    public static String loadHtml(String url, String fetchInputPlace, boolean fetchScript) {
        return "@lh" + url + "," + (fetchScript ? "1" : "0") + 
               (fetchInputPlace != null && !fetchInputPlace.isEmpty() ? "," + fetchInputPlace : "");
    }

    public static String loadHtml(String url, String fetchInputPlace) {
        return loadHtml(url, fetchInputPlace, false);
    }

    public static String loadLine(String url, int line) {
        return "@ll" + url + "," + line;
    }

    public static String loadINI(String url, String name, boolean isINILike) {
        return "@li" + url + "," + name + (isINILike ? ",1" : "");
    }

    public static String loadINI(String url, String name) {
        return loadINI(url, name, false);
    }

    public static String loadJSON(String url, String name) {
        return "@lj" + url + "," + name;
    }

    public static String loadXML(String url, String name) {
        return "@lx" + url + "," + name;
    }

    public static String hasMethod(String methodName) {
        return "@hm" + methodName;
    }

    public static String hasModuleMethod(String methodName) {
        return "@hM" + methodName;
    }

    public static String getModifierState(String modifier) {
        return "@ms" + modifier;
    }

    // Math
    public static String math(String methodName, String[] args) {
        StringBuilder returnValue = new StringBuilder("@M#" + methodName);

        if (args != null && args.length > 0)
            returnValue.append(",").append(String.join(",", args));

        return returnValue.toString();
    }

    public static String math(String methodName) {
        return math(methodName, null);
    }

    // Data
    public static final String DateYear = "@dy";
    public static final String DateMonth = "@dm";
    public static final String DateDay = "@dd";
    public static final String DateHours = "@dh";
    public static final String DateMinutes = "@di";
    public static final String DateSeconds = "@ds";
    public static final String DateMilliseconds = "@dl";

    // String
    public static final String Space = "@sp";
    public static final String AtSign = "@sa";

    // Tag
    public static String getId(String inputPlace) {
        return "@$i" + inputPlace;
    }

    public static String getName(String inputPlace) {
        return "@$n" + inputPlace;
    }

    public static String getValue(String inputPlace) {
        return "@$v" + inputPlace;
    }

    public static String getValueLength(String inputPlace) {
        return "@$e" + inputPlace;
    }

    public static String getClass(String inputPlace) {
        return "@$c" + inputPlace;
    }

    public static String getStyle(String inputPlace) {
        return "@$s" + inputPlace;
    }

    public static String getTitle(String inputPlace) {
        return "@$l" + inputPlace;
    }

    public static String getLabel(String inputPlace) {
        return "@$A" + inputPlace;
    }

    public static String getText(String inputPlace) {
        return "@$t" + inputPlace;
    }

    public static String getOuterText(String inputPlace) {
        return "@$o" + inputPlace;
    }

    public static String getTextLength(String inputPlace) {
        return "@$g" + inputPlace;
    }

    public static String getAttribute(String inputPlace, String attribute) {
        return "@$a" + inputPlace + "," + attribute;
    }

    public static String getWidth(String inputPlace) {
        return "@$w" + inputPlace;
    }

    public static String getHeight(String inputPlace) {
        return "@$h" + inputPlace;
    }

    public static String getIsReadOnly(String inputPlace) {
        return "@$r" + inputPlace;
    }

    public static String getSelectedIndex(String inputPlace) {
        return "@$x" + inputPlace;
    }

    public static String getIndex(String inputPlace) {
        return "@$I" + inputPlace;
    }

    public static String getTextAlign(String inputPlace) {
        return "@$T" + inputPlace;
    }

    public static String getNodeLength(String inputPlace) {
        return "@$L" + inputPlace;
    }

    public static String getIsVisible(String inputPlace) {
        return "@$V" + inputPlace;
    }

    // Save
    public static String hasHash(String hash) {
        return "@HH" + hash;
    }

    public static String cookie(String key) {
        return "@co" + key;
    }

    public static String session(String key) {
        return "@cs" + key;
    }

    public static String session(String key, String replaceValue) {
        return "@cs" + key + "," + replaceValue;
    }

    public static String sessionAndRemove(String key) {
        return "@cl" + key;
    }

    public static String saved(String key) {
        return session(key);
    }

    public static String saved() {
        return session(".");
    }

    public static String cache(String key) {
        return "@cd" + key;
    }

    public static String cache(String key, String replaceValue) {
        return "@cd" + key + "," + replaceValue;
    }

    public static String cacheAndRemove(String key) {
        return "@ct" + key;
    }

    public static String savedLine(String key, int line) {
        return "@lL" + key + "[" + line;
    }

    public static String savedLine(String key) {
        return savedLine(key, 0);
    }

    public static String savedLineConsume(String key) {
        return "@lL" + key;
    }

    public static String savedINI(String key, String iniKey) {
        return "@lI" + key + "[" + iniKey;
    }

    public static String cacheLine(String key, int line) {
        return "@dL" + key + "[" + line;
    }

    public static String cacheLine(String key) {
        return cacheLine(key, 0);
    }

    public static String cacheLineConsume(String key) {
        return "@dL" + key;
    }

    public static String cacheINI(String key, String iniKey) {
        return "@dI" + key + "[" + iniKey;
    }

    // Format Storage
    public static String formatStore(String key) {
        return "@fr" + key;
    }

    public static String formatStoreByXMLQuery(String key, String xPath) {
        return "@fx" + key + "," + xPath;
    }

    public static String formatStoreByJSONQuery(String key, String query) {
        return "@fj" + key + "," + query;
    }

    public static String formatStoreByINI(String key, String name) {
        return "@fi" + key + "," + name;
    }

    public static String formatStoreByText(String key, int line) {
        return "@ft" + key + "," + line;
    }

    public static String formatStoreByVariable(String key) {
        return "@fv" + key;
    }

    // Document
    public static final String TabIsActive = "@da";

    // Window
    public static final String Href = "@wf";
    public static final String PathName = "@wP";
    public static final String Query = "@wq";
    public static final String Hash = "@wh";
    public static final String Host = "@wH";
    public static final String HostName = "@wn";
    public static final String Port = "@wT";
    public static final String Origin = "@wo";
    public static final String GetSelection = "@ws";
    public static final String ScrollX = "@wx";
    public static final String ScrollY = "@wy";

    // Navigator
    public static final String ClipboardText = "@nC";
    public static final String GeoLatitude = "@nW";
    public static final String GeoLongitude = "@nO";
    public static final String Language = "@nL";
    public static final String IsOnLine = "@no";
    public static final String UserAgent = "@na";

    // Screen
    public static final String ScreenWidth = "@sw";
    public static final String ScreenHeight = "@sh";
    public static final String ScreenOrientationType = "@so";
    public static final String ScreenOrientationAngle = "@sr";

    // Performance
    public static final String TimeOrigin = "@pt";
    public static final String PerformanceNow = "@pn";

    // Event
    public static final String Event = "@EV";
    public static final String EventSerialize = "@Es";
    public static final String EventKey = "@ek";
    public static final String EventWhich = "@ew";
    public static final String EventClientX = "@ex";
    public static final String EventClientY = "@ey";
    public static final String EventPageX = "@eX";
    public static final String EventPageY = "@eY";
    public static final String EventOffsetX = "@Ex";
    public static final String EventOffsetY = "@Ey";
    public static final String EventDeltaY = "@ed";
}
