## How to work with WebForms Core in NodeJS (Express framework)

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

```javascript
const express = require('express');
const bodyParser = require('body-parser');
const { WebForms, InputPlace } = require('./WebForms');

const app = express();
const PORT = 3000;

app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.send(`
        <!DOCTYPE html>
        <html>
        <head>
          <title>Using WebForms Core</title>
          <script type="text/javascript" src="/static/script/web-forms.js"></script>
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
        const Name = req.body.txt_Name;
        const BackgroundColor = req.body.txt_BackgroundColor;
        const FontSize = parseInt(req.body.txt_FontSize, 10);

        const form = new WebForms();

        form.setFontSize(InputPlace.tag('form'), FontSize);
        form.setBackgroundColor(InputPlace.tag('form'), BackgroundColor);
        form.setDisabled(InputPlace.name('btn_SetBodyValue'), true);

        form.addTag(InputPlace.tag('form'), 'h3');
        form.setText(InputPlace.tag('h3'), `Welcome ${Name}!`);

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
