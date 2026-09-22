**webforms.ts** is an isomorphic class that can be executed on both the server and client side.

This is the commander class and should not be confused with the client-only WebFormsJS Executor library.

## How to work with WebForms Core in Front

This WebForms class is written in TypeScript and is used on the front-end, unlike other WebForms classes that are used on the server or Web Assembly.

> Note: Please note that the WebForms Core technology consists of two parts. One is the Commander and the other is the Executor. Commanders are WebForms classes for all programming languages; Executor is a front-end library called WebFormsJS (with the physical name "web-forms.js"). WebFormsJS is placed only in the head section of the HTML and you will not do anything with it other than the initial configuration and your focus is solely on working with the WebForms class functions.

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
    <button id="Button1">Set Dynamic Random Color</button>
    <script>
        window.addEventListener("load", (event) => {
            FrontBack(event, "/script/module/main.ts");
        });
    </script>
</body>
</html>
```

After the page loads, the following module ("main.ts") is executed by the "FrontBack" method. Modules that are executed under the "FrontBack" method must have a main method called "PageLoad" with an evt argument.

> Note: You can call the "FrontBack" method with an unlimited number of arguments, in which case the arguments are added and called after the evt argument.

When this module is executed, a "FrontBack" method is added to the "Button1" button event using the "setCommentEvent" method.

TypeScript module ("/script/module/main.ts")

```ts
import { WebForms, HtmlEvent, Fetch } from "./WebForms.ts";

export function PageLoad(evt)
{
    const form = new WebForms();

    form.setCommentEvent("Button1", HtmlEvent.OnClick, "random-color");

    form.startIndex("random-color");
    form.removeCommentEvent("Button1", HtmlEvent.OnClick);

    form.repeat((f) => {
        f.addSaveValue("color", "rgb({{R}}, {{G}}, {{B}})");
        f.replaceSaveValue("color", "{{R}}", Fetch.random(256));
        f.replaceSaveValue("color", "{{G}}", Fetch.random(256));
        f.replaceSaveValue("color", "{{B}}", Fetch.random(256));
        f.setBackgroundColor("<body>", Fetch.save("color"));
        f.delay(500);
    }, 31536000);

    return form.response();
}
```

If the user clicks on the button, the following commands will be executed. After executing these commands, the background color of the page will be changed to a random RGB color every 500 milliseconds.

After learning this simple example, you can take advantage of the powerful capabilities of WebForms Core technology.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js

## How to work with WebForms Core in NodeJS (Express framework)

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

```javascript
import express from 'express';
import bodyParser from 'body-parser';
import { WebForms, InputPlace } from './webforms';

const app = express();
const PORT = 3000;

app.use(express.static('public'));

app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.send(`
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
    `);
});

app.post('/', (req, res) => {
    if (req.body.btn_SetBodyValue) {
        const name = req.body.txt_Name;
        const backgroundColor = req.body.txt_BackgroundColor;
        const fontSize = parseInt(req.body.txt_FontSize, 10);

        const form = new WebForms();

        form.setFontSize(InputPlace.tag('form'), fontSize);
        form.setBackgroundColor(InputPlace.tag('form'), backgroundColor);
        form.setDisabled(InputPlace.name('btn_SetBodyValue'), true);

        form.addTag(InputPlace.tag('form'), 'h3');
        form.setText(InputPlace.tag('h3'), `Welcome ${name}!`);

        res.send(form.response());
    }
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js
