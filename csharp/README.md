## How to work with WebForms Core in C# (Razor Pages (ASP.NET Core))

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

Place the following view in the "Pages" directory in the project path.

View file (Index.cshtml)
```html
@page
@model IndexModel
@{
    Layout = null;
}
<!DOCTYPE html>
<html>
<head>
    <title>Using WebForms Core</title>
    <script type="module" src="/script/web-forms.js"></script>
</head>
<body>
    <form method="post" asp-page-handler="Submit">

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

    @Html.Raw(ViewData["WebForms"] ?? "")

</body>
</html>
```

Also, create a C# class file as follows.

C# code (Index.cshtml.cs)
```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebFormsCore;

public class IndexModel : PageModel
{
    [BindProperty]
    public string txt_Name { get; set; }

    [BindProperty]
    public int txt_FontSize { get; set; } = 16;

    [BindProperty]
    public string txt_BackgroundColor { get; set; }

    [BindProperty]
    public string btn_SetBodyValue { get; set; }

    public IActionResult OnGet()
    {
        return Page();
    }

    public IActionResult OnPostSubmit()
    {
        if (!string.IsNullOrEmpty(btn_SetBodyValue))
        {
            WebForms form = new WebForms();

            form.SetFontSize("<form>", txt_FontSize);
            form.SetBackgroundColor("<form>", txt_BackgroundColor);
            form.SetDisabled("(btn_SetBodyValue)", true);

            form.AddTag("<form>", "h3");
            form.SetText("<h3>", "Welcome " + txt_Name + "!");

            return Content(form.Response(), "text/html");
        }

        return Page();
    }
}
```

In the PageModel, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js


