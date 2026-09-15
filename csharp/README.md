## How to work with WebForms Core in C# (Razor Pages (ASP.NET Core))

To use WebForms Core, first install WFC package or copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

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

## How to work with WebForms Core in C# Mediator

WebForms Core can be used with C# WebAssembly through the .NET WebCIL Container. In this model, C# methods are compiled into WebAssembly and can be called from WebForms Core through the C# Mediator execution layer.

The WebForms Core `WebForms` class can also be used inside the C# WebAssembly module to generate WebForms Core responses. These responses are then executed by the WebFormsJS Executor in the browser.

First, create and publish a .NET WebCIL project containing the required C# methods.

The following example contains three methods:

```csharp
using System.Runtime.InteropServices.JavaScript;
using WebFormsCore;

public partial class MyClass
{
    [JSExport]
    public static int Add(int a, int b)
    {
        return a + b;
    }

    [JSExport]
    public static string SetData(string inputPlace, string text, string backgroundColor, string fontSize)
    {
        WebForms form = new WebForms();

        form.SetText(inputPlace, text);
        form.SetBackgroundColor("-", backgroundColor);
        form.SetFontSize("-", fontSize);

        return form.Response();
    }

    [JSExport]
    public static string GetHtml()
    {
        return "<marquee>Tag From Wasm!</marquee>";
    }
}

public class Program
{
    public static void Main()
    {
    }
}
```

The methods that should be called from the host application must be publicly accessible from the WebCIL module.

After publishing the .NET WebCIL project, the generated WebAssembly files and runtime files can be used by WebForms Core.

## Calling C# WebAssembly from CodeBehind

The following CodeBehind controller uses the C# Mediator execution model to call methods from the .NET WebCIL Container.

```csharp
using CodeBehind;

public partial class WasmCsharpMediatorController : CodeBehindController
{
    public void PageLoad(HttpContext context)
    {
        string WasmPath = "/web-assembly/csharp-publish/_framework/dotnet.js";
        //string WasmPath = "/web-assembly/csharp-publish/_framework/NativeWasmModule.wasm";
        WebForms form = new WebForms();

        form.AddText("<b>", Fetch.WasmMethod(WasmLanguage.CSharpMediator, WasmPath, "MyClass.Add", [10000, 3]));

        form.SetWasmEvent("WasmEvent", HtmlEvent.OnClick, WasmLanguage.CSharpMediator, WasmPath, "MyClass.SetData", ["h3Tag", "Text From Wasm", "lightgreen", "30px"]);
        form.SetWasmEvent("WasmEventWithOutput", HtmlEvent.OnClick, WasmLanguage.CSharpMediator, WasmPath, "MyClass.GetHtml", [], "WasmHtmlOutput");

        Write(form.ExportToHtmlComment());
    }
}
```

The `Fetch.WasmMethod` method calls an exported C# method through the C# Mediator execution layer and returns its result.

In this example:

```csharp
Fetch.WasmMethod(
    WasmLanguage.CSharpMediator,
    WasmPath,
    "MyClass.Add",
    [10000, 3]
)
```

the `MyClass.Add` method is executed with the values `10000` and `3`. Its result is then added to the WebForms Core response.

The `SetWasmEvent` method can also associate a C# WebAssembly method with a browser event.

For example:

```csharp
form.SetWasmEvent(
    "WasmEvent",
    HtmlEvent.OnClick,
    WasmLanguage.CSharpMediator,
    WasmPath,
    "MyClass.SetData",
    ["h3Tag", "Text From Wasm", "lightgreen", "30px"]
);
```

When the `WasmEvent` button is clicked, the `MyClass.SetData` method is executed inside the C# WebAssembly environment.

The method creates a `WebForms` instance and generates WebForms Core commands that modify the `h3Tag` element.

The second `SetWasmEvent` call executes the `MyClass.GetHtml` method and places its returned HTML into the `WasmHtmlOutput` element.

## View

The CodeBehind controller can be used with the following view:

```aspx
@page
@controller WasmCsharpMediatorController
@layout "/layout.aspx"
@{
  ViewData.Add("title","C# Mediator Wasm");
}
<h3>.NET WebCIL Container</h3>
<b>C# Mediator WASM Result: </b>
<br>
<button id="WasmEvent">Wasm Event</button>
<br>
<h3 id="h3Tag">Wasm Tag Changing!</h3>
<button id="WasmEventWithOutput">Wasm Event With Output</button>
<p id="WasmHtmlOutput">Wasm Html Output</p>
```

The page contains two buttons.

The first button executes the `MyClass.SetData` method from the C# WebAssembly module. The method generates WebForms Core commands that change the text, background color, and font size of the `h3Tag` element.

The second button executes the `MyClass.GetHtml` method. The returned HTML is placed inside the `WasmHtmlOutput` element.

## C# WebAssembly and WebForms Core

In this model, C# WebAssembly does not directly manipulate the browser DOM.

The C# method can return a value or a WebForms Core response. When a WebForms Core response is returned, WebFormsJS receives the generated commands and executes them against the HTML DOM.

The execution flow is:

```text
CodeBehind
    ↓
WebForms
    ↓
C# Mediator
    ↓
.NET WebCIL / WebAssembly
    ↓
WebForms Response
    ↓
WebFormsJS Executor
    ↓
HTML DOM
```

This allows C# WebAssembly methods to participate in WebForms Core applications while keeping browser-side DOM execution inside the WebFormsJS runtime.

The same WebForms Core `WebForms` programming model can therefore be used inside the C# WebAssembly environment.

After learning this example, you can use C# methods inside the .NET WebCIL Container to perform computations, generate WebForms Core commands, and participate in browser events.

The WebFormsJS runtime can be obtained from the official WebForms Core repository:

[WebForms Core web-forms.js](https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js?utm_source=chatgpt.com)

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js
