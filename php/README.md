## How to work with WebForms Core in PHP

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

```php
<?php
include 'WebForms.php';

if (!empty($_POST['btn_SetBodyValue']))
{
    $Name = $_POST['txt_Name'];
    $BackgroundColor = $_POST['txt_BackgroundColor'];
    $FontSize = (int) $_POST['txt_FontSize'];

    $form = new WebForms();

    $form->setFontSize(InputPlace::tag('form'), $FontSize . 'px');
    $form->setBackgroundColor(InputPlace::tag('form'), $BackgroundColor);
    $form->setDisabled(InputPlace::name('btn_SetBodyValue'), true);

    $form->addTag(InputPlace::tag('form'), 'h3');
    $form->setText(InputPlace::tag('h3'), "Welcome " . $Name . "!");

    echo $form->response();
    exit();
}
?>
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

> Note: A small fraction of methods (less than the number of fingers on one hand) have been renamed due to reserved words.
Example:
- include → includeText
- break → breakIt
- goTo → goToLine

There may be several other methods.
