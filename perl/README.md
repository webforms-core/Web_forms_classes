## How to work with WebForms Core in Perl

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

```perl
#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use lib '.'; # Add the current directory to @INC
use WebForms;

my $cgi = CGI->new;

# Check if the form is submitted
if ($cgi->param('btn_SetBodyValue')) {
    my $name = $cgi->param('txt_Name');
    my $backgroundColor = $cgi->param('txt_BackgroundColor');
    my $fontSize = $cgi->param('txt_FontSize');

    my $form = WebForms->new;

    $form->SetFontSize(InputPlace::Tag('form'), "$fontSize" . "px");
    $form->SetBackgroundColor(InputPlace::Tag('form'), $backgroundColor);
    $form->SetDisabled(InputPlace::Name('btn_SetBodyValue'), 1);

    $form->AddTag(InputPlace::Tag('form'), 'h3');
    $form->SetText(InputPlace::Tag('h3'), "Welcome $name!");

    print $cgi->header('text/plain');
    print $form->Response();
    exit;
}

# Render the form if not submitted
print $cgi->header('text/html');
print <<"HTML";
<!DOCTYPE html>
<html>
<head>
  <title>Using WebForms Core in Perl</title>
  <script type="text/javascript" src="/script/web-forms.js"></script>
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
</html>
HTML
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js
