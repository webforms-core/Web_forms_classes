## How to work with WebForms Core in C++ (cpp-httplib framework)

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

```c
#include <iostream>
#include <string>

#include "httplib.h"
#include "WebForms.h"

using namespace std;
using namespace WebFormsCore;

string backEndRender(const string& viewName) {
    if (viewName == "view") {
        return R"(<!DOCTYPE html>
<html>
<head>
  <title>Using WebForms Core</title>
  <script type="module" src="/script/web-forms.js"></script>
</head>
<body>
    <form method="post" action="/">

        <label for="txt_Name">Your Name</label>
        <input name="txt_Name" id="txt_Name" type="text" />
        <br>
        <label for="txt_FontSize">Set Font Size</label>
        <input name="txt_FontSize" id="txt_FontSize" type="number" value="16" min="10" max="36" />
        <br>
        <label for="txt_BackgroundColor">Set Background Color</label>
        <input name="txt_BackgroundColor" id="txt_BackgroundColor" type="text" />
        <br>
        <input name="btn_SetBodyValue" type="submit" value="Click to send data" />

    </form>
</body>
</html>)";
    }
    return "<h1>View not found</h1>";
}

int main() {
    httplib::Server svr;

    svr.set_mount_point("/script", "./script");

    svr.Post("/", [](const httplib::Request& req, httplib::Response& res) {
        if (req.has_param("btn_SetBodyValue")) {
            int fontSize = std::stoi(req.get_param_value("txt_FontSize"));
            std::string backgroundColor = req.get_param_value("txt_BackgroundColor");
            std::string name = req.get_param_value("txt_Name");

            WebForms form;
            form.SetFontSize(InputPlace::Tag("form"), fontSize);
            form.SetBackgroundColor(InputPlace::Tag("form"), backgroundColor);
            form.SetDisabled(InputPlace::Tag("btn_SetBodyValue"), true);

            form.AddTag(InputPlace::Tag("form"), "h3");
            form.SetText(InputPlace::Tag("h3"), "Welcome " + name + "!");

            res.set_content(form.Response(), "text/plain");
        } else {
            res.set_content(backEndRender("view"), "text/html");
        }
    });

    svr.Get("/", [](const httplib::Request&, httplib::Response& res) {
        res.set_content(backEndRender("view"), "text/html");
    });

    std::cout << "========================================\n";
    std::cout << "WebForms Core C++ Test Server\n";
    std::cout << "========================================\n";
    std::cout << "sizeof(void*) = " << sizeof(void*) << " bytes\n";
    std::cout << "Server running on http://127.0.0.1:8080\n";
    std::cout << "Open browser and visit:\n";
    std::cout << "  http://127.0.0.1:8080/\n";
    std::cout << "Press Ctrl+C to stop\n";
    std::cout << "========================================\n";

    svr.listen("127.0.0.1", 8080);
    return 0;
}
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js
