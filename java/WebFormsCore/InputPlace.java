package WebFormsCore;

// WebForms.java 2.0 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.0

public class InputPlace {
    public static final String Window = "`";
    public static final String Root = "~";
    public static final String Current = "$";
    public static final String Target = "!";
    public static final String Upper = "-";
    public static final String Head = "^";
    public static final String ScreenOrientation = "%";

    public static String id(String id) {
        return id;
    }

    public static String name(String name) {
        return '(' + name + ')';
    }

    public static String name(String name, int index) {
        return '(' + name + ')' + index;
    }

    public static String allNames(String name) {
        return "(" + name + ")*";
    }

    public static String tag(String tag) {
        return '<' + tag + '>';
    }

    public static String tag(String tag, int index) {
        return '<' + tag + '>' + index;
    }

    public static String allTags(String tag) {
        return "<" + tag + ">*";
    }

    public static String cssClass(String className) {
        return '{' + className + '}';
    }

    public static String cssClass(String className, int index) {
        return '{' + className + '}' + index;
    }

    public static String allCssClasses(String className) {
        return "{" + className + "}*";
    }

    public static String query(String query) {
        return "*" + query.replace("=", "$[eq];");
    }

    public static String queryAll(String query) {
        return "[" + query.replace("=", "$[eq];");
    }
}
