## How to work with WebForms Core in Java (Spring Boot framework)

To use WebForms Core, first copy the WebFormsCore directory (with class files) in this directory to path: "{YourProjectName}\src\main\java" in your project. Then create a new View file similar to the one below.

View file (default.html)
```html
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

Also, create a Controller class file as follows.

Controller class
```csharp
package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import WebFormsCore.WebForms;
import WebFormsCore.InputPlace;

@Controller
public class MyController {

    @GetMapping("/")
    public String PageLoad(Model model) {
        return "default"; // This will map to default.html
    }

    @PostMapping("/")
    @ResponseBody
    public String handleSubmit(@RequestParam("txt_Name") String name,
                               @RequestParam("txt_BackgroundColor") String backgroundColor,
                               @RequestParam("txt_FontSize") int fontSize,
                               @RequestParam("btn_SetBodyValue") String button) {
                
        if (button != null){
            WebForms form = new WebForms();
            
            form.setFontSize(InputPlace.tag("form"), fontSize);
            form.setBackgroundColor(InputPlace.tag("form"), backgroundColor);
            form.setDisabled(InputPlace.name("btn_SetBodyValue"), true);
            
            form.addTag(InputPlace.tag("form"), "h3", null);
            form.setText(InputPlace.tag("h3"), "Welcome " + name + "!");

            return form.response(); 
        }

        return "";
    }
}
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js

In addition to the Java programming language, you can use the WebForms classes located in the WebFormsCore directory directly or after compilation in the following programming languages (or implementations):
- Kotlin
- Scala
- Groovy
- Clojure
- JRuby
- Jython
- Fantom
- Mirah
- Ceylon
- Fantom
- JPHP
