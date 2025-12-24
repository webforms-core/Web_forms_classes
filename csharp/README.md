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
    <title>WebForms Core with Razor</title>
    <script type="module" src="/static/script/web-forms.js"></script>
</head>
<body>

<h3>State Test (Razor + WebForms Core)</h3>

<button id="Button1">Add State 1</button>
<button id="Button2">Add State 2</button>

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
    public IActionResult OnGet()
    {
        if (Request.Query.ContainsKey("add_state_1"))
        {
            return Button1_Click();
        }

        if (Request.Query.ContainsKey("add_state_2"))
        {
            return Button2_Click();
        }

        WebForms form = new WebForms();

        form.SetGetEvent("Button1", HtmlEvent.OnClick, "?add_state_1");
        form.SetGetEvent("Button2", HtmlEvent.OnClick, "?add_state_2");

        ViewData["WebForms"] = form.ExportToHtmlComment();

        return Page();
    }

    private IActionResult Button1_Click()
    {
        WebForms form = new WebForms();

        form.AddState("#state1");
        form.AddText("<h3>", "- New text after click 1");

        return Content(form.Response(), "text/html");
    }

    private IActionResult Button2_Click()
    {
        WebForms form = new WebForms();

        form.AddState("#state2");
        form.AddText("<h3>", "- New text after click 2");

        return Content(form.Response(), "text/html");
    }
}
```

The above code is a simple example of a state management system. By executing the route, the click event is first given to the buttons with the query route. If the buttons are clicked, we detect it in the Razor Page handler by checking the query and the methods associated with the click are executed. Each of the methods adds a state to the page; this makes the back and forward buttons in the browser, consistent with the new state.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js