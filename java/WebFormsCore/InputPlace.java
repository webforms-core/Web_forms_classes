package WebFormsCore;

// Compatible with WebFormsJS version 1.6

public class InputPlace {
    public static String id(String id) {
        return id;
    }

    public static String name(String name) {
        return '(' + name + ')';
    }

    public static String name(String name, int index) {
        return '(' + name + ')' + index;
    }

    public static String tag(String tag) {
        return '<' + tag + '>';
    }

    public static String tag(String tag, int index) {
        return '<' + tag + '>' + index;
    }

    public static String classString(String classStr) {
        return '{' + classStr + '}';
    }

    public static String classString(String classStr, int index) {
        return '{' + classStr + '}' + index;
    }

    public static String query(String query) {
        return "*" + query.replace("=", "$[eq];");
    }

    public static String queryAll(String query) {
        return "[" + query.replace("=", "$[eq];");
    }
}
