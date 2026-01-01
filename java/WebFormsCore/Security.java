package WebFormsCore;

// WebForms.java 2.0 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.0

public class Security {
    public String safeValue(String value) {
        if (value == null || value.length() < 1)
            return value;

        if (value.charAt(0) == '@') {
            value = value.substring(1);
            value = "$[at];" + value;
        }

        value = value.replace("\n", "$[ln];");
        value = value.replace("|", "$[vb];");
        value = value.replace(",@", "$[co];@");

        return value;
    }
}