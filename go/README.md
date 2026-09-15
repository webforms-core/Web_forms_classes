## How to work with WebForms Core in GO

To use WebForms Core, first copy the WebForms class file ("webforms.go") in this directory to "webforms" directory in your project. Then create a new View file ("main.go") similar to the one below.
> Please make sure to replace "{your-project-name}" with project name in the import section.

```go
package main

import (
	"fmt"
	"net/http"
	"{your-project-name}/webformscore"
)

func main() {
	http.Handle("/script/", http.StripPrefix("/script/", http.FileServer(http.Dir("script"))))
	http.HandleFunc("/", handleForm)
	http.ListenAndServe(":8080", nil)
}

func handleForm(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodPost {
		name := r.FormValue("txt_Name")
		backgroundColor := r.FormValue("txt_BackgroundColor")
		fontSize := r.FormValue("txt_FontSize")

		form := WebFormsCore.New()
		var InputPlace = WebFormsCore.InputPlace

		form.SetFontSize(InputPlace.Tag("form"), fontSize+"px")
		form.SetBackgroundColor(InputPlace.Tag("form"), backgroundColor)
		form.SetDisabled(InputPlace.Name("btn_SetBodyValue"), true)

		form.AddTag(InputPlace.Tag("form"), "h3", "p")
		form.SetText(InputPlace.Tag("h3"), "Welcome "+name+"!")

		fmt.Fprint(w, form.Response())
		return
	}

	fmt.Fprint(w, `<!DOCTYPE html>
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
</html>`)
}
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js

## How to work with WebForms Core in GO WebAssembly

WebForms Core can be used with Go to create WebAssembly modules that execute methods and generate WebForms Core commands.

The Go `WebForms` class acts as a Commander inside the WebAssembly module. It can generate WebForms Core responses that are executed by the WebFormsJS Executor in the browser.

Go WebAssembly uses the Go WebAssembly runtime provided by `wasm_exec.js`. The Go module can expose methods to JavaScript through the `syscall/js` package.

### Creating a Go WebAssembly Project

First, create a Go project and add the WebForms Core Go classes to your project.

The project can have the following structure:

```text
your-project-name/
├── webformscore/
│   └── webforms.go
├── main.go
└── go.mod
```

The `go.mod` file can be configured as follows:

```go
module your-project-name

go 1.25.5
```

The Go WebAssembly module can then use the local WebForms Core package:

```go
import (
    "syscall/js"

    WebFormsCore "your-project-name/webformscore"
)
```

### Go WebAssembly Methods

The following example exports several Go methods to JavaScript.

The `add` method performs a simple calculation, while the `setData` method creates a `WebForms` instance and generates commands that modify the HTML page.

```go
package main

import (
    "syscall/js"

    WebFormsCore "your-project-name/webformscore"
)

func add(this js.Value, args []js.Value) interface{} {
    a := int32(args[0].Int())
    b := int32(args[1].Int())

    return a + b
}

func setData(this js.Value, args []js.Value) interface{} {
    inputPlace := args[0].String()
    text := args[1].String()
    backgroundColor := args[2].String()
    fontSize := args[3].String()

    form := WebFormsCore.New()

    form.SetText(inputPlace, text)
    form.SetBackgroundColor("-", backgroundColor)
    form.SetFontSize("-", fontSize)

    return form.Response()
}

func getHtml(this js.Value, args []js.Value) interface{} {
    return "<marquee>Tag From Wasm!</marquee>"
}

func main() {
    js.Global().Set("add", js.FuncOf(add))
    js.Global().Set("setData", js.FuncOf(setData))
    js.Global().Set("getHtml", js.FuncOf(getHtml))

    select {}
}
```

The methods that should be called by WebForms Core must be registered in the JavaScript global scope using `js.Global().Set`.

For example:

```go
js.Global().Set("add", js.FuncOf(add))
```

makes the Go method available as the JavaScript function `add`.

The `main` function remains running while the WebAssembly module is active. The `select {}` statement prevents the Go runtime from exiting after the functions have been registered.

### Building the Go WebAssembly Module

Go provides WebAssembly support through the `GOOS=js` and `GOARCH=wasm` build targets.

The following command builds the Go WebAssembly module:

```text
GOOS=js GOARCH=wasm go build -o webforms-go.wasm
```

On Windows, the following `build.bat` file can be used:

```bat
@echo off

set GOOS=js
set GOARCH=wasm
go build -o webforms-go.wasm

pause
```

The resulting files can be placed in the WebForms Core application as follows:

```text
/web-assembly/go/
    webforms-go.wasm
    wasm_exec.js
```

The `wasm_exec.js` file is the Go WebAssembly runtime. It is required to initialize and execute Go WebAssembly modules in the browser.

WebForms Core can automatically load `wasm_exec.js` from the same directory when a Go WebAssembly module is executed.

### Calling Go WebAssembly from CodeBehind

The following CodeBehind controller uses the Go WebAssembly module.

```csharp
using CodeBehind;

public partial class WasmGOController : CodeBehindController
{
    public void PageLoad(HttpContext context)
    {
        string WasmPath = "/web-assembly/go/webforms-go.wasm"; // or wasm_exec.js

        WebForms form = new WebForms();

        form.AddText("<b>", Fetch.WasmMethod(WasmLanguage.GO, WasmPath, "add", [10000, 3]));

        form.SetWasmEvent("WasmEvent", HtmlEvent.OnClick, WasmLanguage.GO, WasmPath, "setData", ["h3Tag", "Text From Wasm", "lightgreen", "30px"]);
        form.SetWasmEvent("WasmEventWithOutput", HtmlEvent.OnClick, WasmLanguage.GO, WasmPath, "getHtml", [], "WasmHtmlOutput");

        Write(form.ExportToHtmlComment());
    }
}
```

The `Fetch.WasmMethod` method calls a Go WebAssembly method and returns its result.

In this example:

```csharp
Fetch.WasmMethod(
    WasmLanguage.GO,
    WasmPath,
    "add",
    [10000, 3]
)
```

the `add` method inside the Go WebAssembly module is executed with the values `10000` and `3`. Its result is then added to the WebForms Core response.

The `SetWasmEvent` method assigns a Go WebAssembly method to a browser event.

For example:

```csharp
form.SetWasmEvent(
    "WasmEvent",
    HtmlEvent.OnClick,
    WasmLanguage.GO,
    WasmPath,
    "setData",
    ["h3Tag", "Text From Wasm", "lightgreen", "30px"]
);
```

When the `WasmEvent` button is clicked, the `setData` method in the Go WebAssembly module is executed.

The method creates a `WebForms` instance and generates WebForms Core commands that modify the `h3Tag` element.

The second `SetWasmEvent` call executes the `getHtml` method and places its returned HTML into the `WasmHtmlOutput` element.

### View

The CodeBehind controller can be used with the following view:

```aspx
@page
@controller WasmGOController
@layout "/layout.aspx"
@{
  ViewData.Add("title","GO Wasm");
}
<h3>GO Wasm</h3>
<b>GO WASM Result: </b>
<br>
<button id="WasmEvent">Wasm Event</button>
<br>
<h3 id="h3Tag">Wasm Tag Changing!</h3>
<button id="WasmEventWithOutput">Wasm Event With Output</button>
<p id="WasmHtmlOutput">Wasm Html Output</p>
```

The page contains two buttons.

The first button executes the `setData` method from the Go WebAssembly module. The method generates WebForms Core commands that change the text, background color, and font size of the `h3Tag` element.

The second button executes the `getHtml` method. The returned HTML is placed inside the `WasmHtmlOutput` element.

### Go WebAssembly and WebForms Core

In this model, Go WebAssembly does not directly manipulate the browser DOM.

The Go module generates either a value or a WebForms Core response. WebFormsJS receives the generated commands and executes them against the HTML DOM.

The execution flow is:

```text
CodeBehind
    ↓
WebForms
    ↓
Go WebAssembly
    ↓
WebForms Core Response
    ↓
WebFormsJS Executor
    ↓
HTML DOM
```

The Go WebAssembly runtime is initialized through `wasm_exec.js`.

The Go methods are exposed to the browser through the `syscall/js` package, while the WebForms Core `WebForms` class is used to generate UI commands.

This allows Go WebAssembly modules to participate in WebForms Core applications without requiring the Go module to implement browser DOM manipulation.

After learning this example, you can use the WebForms Core `WebForms` class inside Go WebAssembly modules to perform calculations, generate WebForms Core responses, and create more advanced server and browser interactions.
