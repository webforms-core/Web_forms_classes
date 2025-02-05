package WebFormsCore;

/// <summary>
/// Do Not Add Any Data Before Or After It
/// </summary>
public class Fetch {
    public static String random(int maxValue) {
        return "@mr" + maxValue;
    }

    public static String random(int minValue, int maxValue) {
        return "@mr" + maxValue + "," + minValue;
    }

    public static String dateYear = "@dy";
    public static String dateMonth = "@dm";
    public static String dateDay = "@dd";
    public static String dateHours = "@dh";
    public static String dateMinutes = "@di";
    public static String dateSeconds = "@ds";
    public static String dateMilliseconds = "@dl";

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

    public static String sessionAndRemove(String key, String replaceValue) {
        return "@cl" + key + "," + replaceValue;
    }

    public static String saved(String key) {
        return "@cl" + (key != null ? key : ".");
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

    public static String cacheAndRemove(String key, String replaceValue) {
        return "@ct" + key + "," + replaceValue;
    }

    public static String script(String scriptText) {
        return "@_" + scriptText.replace("\n", "$[ln];");
    }
}