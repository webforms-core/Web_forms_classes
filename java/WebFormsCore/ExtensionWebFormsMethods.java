package WebFormsCore;

// Compatible with WebFormsJS version 1.6

public class ExtensionWebFormsMethods {
    /// <summary>
    /// This Method Does Not Support QueryAll
    /// </summary>
    public static String appendPlace(String text, String value) {
        if (text.length() < 1)
            return value;

        return text + "|" + value;
    }

    public static String appendParent(String text) {
        return "/" + text;
    }

    public static String exportToWebFormsTag(String src) {
        return "<web-forms src=\"" + src + "\"></web-forms>";
    }

    // Overload
    public static String exportToWebFormsTag(String src, int width, int height) {
        return "<web-forms src=\"" + src + "\" width=\"" + width + "\" height=\"" + height + "\"></web-forms>";
    }

    public static String exportActionControlsToWebFormsTag(String actionControls) {
        return "<web-forms ac=\"" + actionControls + "\"></web-forms>";
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
}
