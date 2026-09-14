# WebForms Core for AssemblyScript

WebForms Core can be used with AssemblyScript to create WebAssembly modules that generate WebForms Core commands.

The AssemblyScript `WebForms` class acts as a Commander inside the WebAssembly module. It can generate WebForms Core responses that are executed by the WebFormsJS Executor in the browser.

## How to work with WebForms Core in AssemblyScript

First, create an AssemblyScript project and add the WebForms Core AssemblyScript classes to your project.

The following example contains several exported WebAssembly methods. The `add` method performs a simple calculation, while the `setData` method creates a `WebForms` instance and generates commands that modify the HTML page.

```typescript
import { WebForms } from "./webforms";

export function add(a: i32, b: i32): i32 {
    return a + b;
}

export function setData(
    inputPlace: string,
    text: string,
    backgroundColor: string,
    fontSize: string
): string {
    const form = new WebForms();
    form.setText(inputPlace, text);
    form.setBackgroundColor("-", backgroundColor);
    form.setFontSize("-", fontSize);
    return form.response();
}

export function getHtml(): string {
    return "<marquee>Tag From Wasm!</marquee>";
}

export function createWebForms(): WebForms {
    return new WebForms();
}
```

The methods that should be called from the host application must be exported from the AssemblyScript module.

After compiling the AssemblyScript project, the resulting `.wasm` file can be called from a server application through WebForms Core.

## Calling AssemblyScript WebAssembly from CodeBehind

The following CodeBehind controller uses the AssemblyScript WebAssembly module.

```csharp
using CodeBehind;

public partial class WasmAssemblyScriptController : CodeBehindController
{
    public void PageLoad(HttpContext context)
    {
        string WasmPath = "/web-assembly/assembly-script/release.wasm"; // or release.js, support both.
        WebForms form = new WebForms();

        form.AddText("<b>", Fetch.WasmMethod(WasmLanguage.AssemblyScript, WasmPath, "add", [10000, 3]));

        form.SetWasmEvent("WasmEvent", HtmlEvent.OnClick, WasmLanguage.AssemblyScript, WasmPath, "setData", ["h3Tag", "Text From Wasm", "lightgreen", "30px"]);
        form.SetWasmEvent("WasmEventWithOutput", HtmlEvent.OnClick, WasmLanguage.AssemblyScript, WasmPath, "getHtml", [], "WasmHtmlOutput");

        Write(form.ExportToHtmlComment());
    }
}
```

The `Fetch.WasmMethod` method calls an exported AssemblyScript method and returns its result.

In this example:

```csharp
Fetch.WasmMethod(WasmLanguage.AssemblyScript, WasmPath, "add", [10000, 3])
```

the `add` method inside the WebAssembly module is executed with the values `10000` and `3`. Its result is then added to the WebForms Core response.

The `SetWasmEvent` method assigns a WebAssembly method to a browser event. When the user clicks the `WasmEvent` button, the `setData` method in the AssemblyScript WebAssembly module is executed.

The `setData` method returns a WebForms Core response containing commands that change the HTML element with the `h3Tag` ID.

The second `SetWasmEvent` call executes the `getHtml` method and places its returned HTML into the `WasmHtmlOutput` element.

## View

The CodeBehind controller can be used with the following view:

```aspx
@page
@controller WasmAssemblyScriptController
@layout "/layout.aspx"
@{
  ViewData.Add("title","AssemblyScript Wasm");
}
<h3>AssemblyScript Wasm</h3>
<b>AssemblyScript WASM Result: </b>
<br>
<button id="WasmEvent">Wasm Event</button>
<br>
<h3 id="h3Tag">Wasm Tag Changing!</h3>
<button id="WasmEventWithOutput">Wasm Event With Output</button>
<p id="WasmHtmlOutput">Wasm Html Output</p>
```

The page contains two buttons.

The first button executes the `setData` method from the AssemblyScript WebAssembly module. The method generates WebForms Core commands that change the text, background color, and font size of the `h3Tag` element.

The second button executes the `getHtml` method. The returned HTML is placed inside the `WasmHtmlOutput` element.

## WebForms Core and WebAssembly

In this model, AssemblyScript does not directly manipulate the browser DOM.

The AssemblyScript module generates either a value or a WebForms Core response. WebForms Core then passes the generated commands to the WebFormsJS Executor, which executes them against the HTML DOM.

This allows AssemblyScript WebAssembly modules to participate in WebForms Core applications while keeping DOM execution in the browser runtime.

After learning this simple example, you can use the WebForms Core `WebForms` class inside AssemblyScript modules to generate more advanced server and browser interactions.