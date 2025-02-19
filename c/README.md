## How to work with WebForms Core in C (A hypothetical framework)

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

> Please note that this is a hypothetical framework. The codes below are close to pseudocode, but the WebForms class codes work correctly.

```c
#include <stdio.h>
#include <stdlib.h>

#include "backendframework.h" // A hypothetical framework

#include "WebForms.h"

int main() {
	// If is post method by submit form
	if (responseForm.hasKey("btn_SetBodyValue")) {
		char name[20] = responseForm.getValue("txt_Name");
		char backgroundColor[20] = responseForm.getValue("txt_BackgroundColor");
		int fontSize = atoi(responseForm.getValue("txt_BackgroundColor"));
		char message[28];

		WebForms webForms;
		webForms.WebFormsData.count = 0;

		WebForms_SetFontSize(&webForms, InputPlace_Tag("form"), fontSize);
		WebForms_SetBackgroundColor(&webForms, InputPlace_Tag("form"), backgroundColor);
		WebForms_SetDisabled(&webForms, InputPlace_Name("btn_SetBodyValue"), true);

		WebForms_AddTag(&webForms, InputPlace_Tag("form"), "h3", "");
		WebForms_SetText(&webForms, InputPlace_Tag("h3"), (snprintf(message, sizeof(message), "Welcome %s", name), message));

		printf("%s\n", WebForms_Response(&webForms));

		WebForms_Clean(&webForms);
		
		return 0;
	}
	
	// If is get method
	printf("%s\n", backEndRender("view"));

    return 0;
}

##End

@@view
<!DOCTYPE html>
<html>
<head>
  <title>Using WebForms Core</title>
  <script type="text/javascript" src="/script/web-forms.js"></script>
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