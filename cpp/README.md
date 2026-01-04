## How to work with WebForms Core in C++ (A hypothetical framework)

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

> Please note that this is a hypothetical framework. The codes below are close to pseudocode, but the WebForms class codes work correctly.

```c
#include <iostream>
#include <string>

#include "backendframework.h" // A hypothetical framework
#include "WebForms.h"

using namespace std;

int main() {
// If is post method by submit form
	if (responseForm.hasKey("btn_SetBodyValue")) {
		int fontSize = std::stoi(responseForm.getValue("txt_BackgroundColor"));
		std::string backgroundColor = responseForm.getValue("txt_BackgroundColor");
		std::string name = responseForm.getValue("txt_Name");

		WebForms form;

		form.SetFontSize(InputPlace::Tag("form"), fontSize);
		form.SetBackgroundColor(InputPlace::Tag("form"), backgroundColor);
		form.SetDisabled(InputPlace::Tag("btn_SetBodyValue"), true);

		form.AddTag(InputPlace::Tag("form"), "h3");
		form.SetText(InputPlace::Tag("h3"), "Welcome " + name + "!");

		std::cout << form.Response() << std::endl;
		return 0;
	}

	// If is get method
	std::cout << backEndRender("view")) << std::endl;

	return 0;
}

##End

@@view
<!DOCTYPE html>
<html>
<head>
  <title>Using WebForms Core</title>
  <script type="module" src="/script/web-forms.js"></script>
</head>
<body>
    <form method="post" action="/" >

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
</html>
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js
