package WebFormsCore;

// WebForms.java 2.0 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.0

public class ExtensionWebFormsMethods {
    /// <summary>
    /// This Method Does Not Support QueryAll
    /// </summary>
    public static String appendPlace(String text, String value) {
        if (text == null || text.length() < 1)
            return value;

        return text + "|" + value;
    }

    public static String appendParent(String text) {
        return "/" + text;
    }

    public static String exportActionControlsToWebFormsTag(String actionControls, boolean addLine) {
        return (addLine ? "\n" : "") + "<web-forms ac=\"" + actionControls + "\"></web-forms>";
    }

    public static String exportActionControlsToWebFormsTag(String actionControls) {
        return exportActionControlsToWebFormsTag(actionControls, false);
    }

    public static String exportActionControlsToHtmlComment(String actionControls, boolean addLine) {
        return (addLine ? "\n" : "") + "<!--[web-forms]\n" + actionControls + "-->";
    }

    public static String exportActionControlsToHtmlComment(String actionControls) {
        return exportActionControlsToHtmlComment(actionControls, false);
    }

    public static String exportActionControlsToResponse(String actionControls) {
        return "[web-forms]\n" + actionControls;
    }

    public static String removeOuter(String text, String startString, String endString) {
        int start = text.indexOf(startString);
        if (start == -1)
            return text;

        int end = text.indexOf(endString, start);
        if (end == -1)
            return text;

        int lengthToRemove = (end - start) + endString.length();

        return text.substring(0, start) + text.substring(start + lengthToRemove);
    }

    public static String lineBreak(String text) {
        return text.replace("\n", "$[sln]");
    }
}
