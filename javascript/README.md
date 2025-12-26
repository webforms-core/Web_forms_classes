## How to work with WebForms Core in Front

This WebForms class is written in JavaScript and is used on the front-end, unlike other WebForms classes that are used on the server or Web Assembly.

> Note: Please note that the WebForms Core technology consists of two parts. One is the Commander and the other is the Executor. Commanders are WebForms classes for all programming languages; Executor is a front-end library called WebFormsJS (with the physical name "web-forms.js"). WebFormsJS is placed only in the head section of the HTML and you will not do anything with it other than the initial configuration and your focus is solely on working with the WebForms class functions. Also, note that this class should not be confused with the WebForms.js class in NodeJS; the WebForms.js class in NodeJS is used on the server side.

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

The following file is a simple HTML page with a load event assigned to the page in the script tag. The reason for this is so that we can control the page in front-end.

> Note: Usually, to control the initial page in server, we use the HTML page with the output of the "exportToHtmlComment" method and WebFormsJS automatically extracts the Action Controls in the page and then executes them. Here, since the page is static, we have to assign the FrontBack method directly to the page load event.

```html
<!DOCTYPE html>
<html>
<head>
  <title>Using WebForms Core</title>
  <script type="module" src="/script/web-forms.js"></script>
</head>
<body>
    <button id="Button1">Click me!</button>
    <script>
        window.addEventListener("load", (event) => {
            FrontBack(event, "/script/module/main.js");
        });
    </script>
</body>
</html>
```

After the page loads, the following module ("main.js") is executed by the "FrontBack" method. Modules that are executed under the "FrontBack" method must have a main method called "PageLoad" with an evt argument.

> Note: You can call the "FrontBack" method with an unlimited number of arguments, in which case the arguments are added and called after the evt argument.

When this module is executed, a "FrontBack" method is added to the "Button1" button event using the "setFrontEvent" method.

JavaScript module ("/script/module/main.js")
```js
import { WebForms, HtmlEvent } from "./WebForms.js";

export function PageLoad(evt)
{
    const form = new WebForms();

    form.setFrontEvent("Button1", HtmlEvent.OnClick, "/script/module/change-color.js");

    return form.response();
}
```

If the user clicks on the button, the following module will be executed. After executing this module, several changes will be made to the HTML page using the methods of the WebForms.js class. First, an h2 tag is added to the body tag, then the text "New H2 Tag" is written inside this tag, and the next command changes the text color to orange. Finally, the background color will change to green after two seconds.

JavaScript module ("/script/module/change-color.js")
```js
import { WebForms, InputPlace } from "./WebForms.js";

export function PageLoad(evt)
{
    const form = new WebForms();

    form.addTag("<body>", "h2");
    form.setText("<h2>", "New H2 Tag");
    form.setTextColor("<h2>", "orange");

    form.setBackgroundColor(InputPlace.tag("body"), "lightgreen");
    form.assignDelay(2000);

    return form.response();
}
```

After learning this simple example, you can take advantage of the powerful capabilities of WebForms Core technology.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js