## How to work with WebForms Core in Rust (Actix-web framework)

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

Place the following view in the "templates" directory in the project path.

View file (index.html)
```html
<!DOCTYPE html>
<html>
<head>
    <title>Using WebForms Core</title>
    <script type="module" src="/static/script/web-forms.js"></script>
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

Also, create a Rust class file as follows.

Rust code
```rust
use actix_files as fs;
use actix_web::{web, App, HttpServer, HttpResponse, Responder};
use std::sync::Arc;
use tera::Tera;

mod web_forms;
use crate::web_forms::web_forms_core::{input_place, WebForms};

#[derive(Clone)]
struct AppState {
    tera: Arc<Tera>,
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let tera = Tera::new("templates/**/*").unwrap();
    let state = AppState {
        tera: Arc::new(tera),
    };

    HttpServer::new(move || {
        let state = state.clone();
        App::new()
            .app_data(web::Data::new(state))
            .route("/", web::get().to(index))
            .route("/", web::post().to(handle_post))
            .service(fs::Files::new("/static", "./static").show_files_listing())
    })
    .bind("127.0.0.1:8080")?
    .run()
    .await
}

async fn index(state: web::Data<AppState>) -> impl Responder {
    let rendered = state
        .tera
        .render("index.html", &tera::Context::new())
        .unwrap();
    HttpResponse::Ok().content_type("text/html").body(rendered)
}

async fn handle_post(params: web::Form<Params>, _state: web::Data<AppState>) -> impl Responder {
    let name = &params.txt_Name;
    let background_color = &params.txt_BackgroundColor;
    let font_size: i32 = params.txt_FontSize.parse().unwrap_or(16);

    let mut form = WebForms::new();

    let form_place = input_place::tag("form");
    form.set_font_size_px(&form_place, font_size);
    form.set_background_color(&form_place, background_color);
    form.set_disabled(&input_place::name("btn_SetBodyValue"), true);

    form.add_tag(&form_place, "h3", Some("ID"));
    form.set_text(&input_place::tag("h3"), &format!("Welcome {}!", name));

    HttpResponse::Ok().body(form.response())
}

#[derive(serde::Deserialize)]
struct Params {
    txt_Name: String,
    txt_FontSize: String,
    txt_BackgroundColor: String,
}
```

The settings of the "Cargo.toml" file are as follows.
```toml
[package]
name = "actix_example"
version = "0.1.0"
edition = "2021"

[dependencies]
actix-web = "=4.3.1"
actix-files = "=0.6.2"
serde = { version = "=1.0.188", features = ["derive"] }
tera = "=1.19.1"
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js

## How to work with WebForms Core in Rust WebAssembly

WebForms Core can be used with Rust to create WebAssembly modules that execute methods and generate WebForms Core commands.

The Rust `WebForms` class acts as a Commander inside the WebAssembly module. It can generate WebForms Core responses that are executed by the WebFormsJS Executor in the browser.

Rust WebAssembly can be used with WebForms Core through two execution approaches: `wasm-bindgen` and Raw WebAssembly.

### Rust with wasm-bindgen

First, create a Rust WebAssembly project and add the WebForms Core Rust classes to your project.

The following example exports several WebAssembly methods. The `add` method performs a simple calculation, while the `set_data` method creates a `WebForms` instance and generates commands that modify the HTML page.

```rust
use wasm_bindgen::prelude::*;
use webformscore::WebForms;

#[wasm_bindgen]
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

#[wasm_bindgen]
pub fn set_data(
    input_place: String,
    text: String,
    background_color: String,
    font_size: String,
) -> String {
    let mut form = WebForms::new();

    form.set_text(&input_place, &text);
    form.set_background_color("-", &background_color);
    form.set_font_size("-", &font_size);

    form.response()
}

#[wasm_bindgen]
pub fn get_html() -> String {
    "<marquee>Tag From Wasm!</marquee>".to_string()
}
```

The methods that should be called from the host application must be exported from the Rust WebAssembly module.

The Rust project can then be compiled and processed with `wasm-bindgen` to generate the WebAssembly module and its JavaScript interface.

The generated JavaScript module can be called through the WebForms Core Rust JavaScript execution path.

### Rust with Raw WebAssembly

Rust can also be compiled directly to WebAssembly without using `wasm-bindgen`.

In this approach, the exported methods use the WebAssembly-compatible `extern "C"` interface.

For example:

```rust
use std::ffi::CStr;
use webformscore::WebForms;

#[no_mangle]
pub extern "C" fn add(a: i32, b: i32) -> i32 {
    a + b
}

#[no_mangle]
pub extern "C" fn alloc(size: usize) -> *mut u8 {
    let mut buffer = Vec::with_capacity(size);
    let ptr = buffer.as_mut_ptr();

    std::mem::forget(buffer);

    ptr
}

#[no_mangle]
pub extern "C" fn set_data(
    input_place: *const u8,
    text: *const u8,
    background_color: *const u8,
    font_size: *const u8,
) -> *const u8 {
    let input_place = unsafe {
        CStr::from_ptr(input_place as *const i8)
            .to_str()
            .unwrap()
    };

    let text = unsafe {
        CStr::from_ptr(text as *const i8)
            .to_str()
            .unwrap()
    };

    let background_color = unsafe {
        CStr::from_ptr(background_color as *const i8)
            .to_str()
            .unwrap()
    };

    let font_size = unsafe {
        CStr::from_ptr(font_size as *const i8)
            .to_str()
            .unwrap()
    };

    let mut form = WebForms::new();

    form.set_text(input_place, text);
    form.set_background_color("-", background_color);
    form.set_font_size("-", font_size);

    let response = form.response();

    let mut output = response.into_bytes();
    output.push(0);

    Box::into_raw(output.into_boxed_slice()) as *const u8
}

#[no_mangle]
pub extern "C" fn get_html() -> *const u8 {
    b"<marquee>Tag From Wasm!</marquee>\0".as_ptr()
}
```

In Raw WebAssembly mode, string parameters are passed through pointers to null-terminated UTF-8 strings. A returned string is also represented by a pointer to a null-terminated UTF-8 string.

The resulting `.wasm` file can be executed directly by the WebForms Core Rust WebAssembly execution path.

## Calling Rust WebAssembly from CodeBehind

The following CodeBehind controller uses the Rust WebAssembly module.

```csharp
using CodeBehind;

public partial class WasmRustController : CodeBehindController
{
    public void PageLoad(HttpContext context)
    {
        string WasmPath = "/web-assembly/rust/webformscore_wasm_test_bg.wasm"; // Using Bindgen
        //string WasmPath = "/web-assembly/rust/webformscore_wasm_test.js"; // Using Bindgen
        //string WasmPath = "/web-assembly/rust/alone/webformscore_wasm_test.wasm"; // Direct/Raw WebAssembly extern C

        WebForms form = new WebForms();

        form.AddText("<b>", Fetch.WasmMethod(WasmLanguage.Rust, WasmPath, "add", [10000, 3]));

        form.SetWasmEvent("WasmEvent", HtmlEvent.OnClick, WasmLanguage.Rust, WasmPath, "setData", ["h3Tag", "Text From Wasm", "lightgreen", "30px"]);
        form.SetWasmEvent("WasmEventWithOutput", HtmlEvent.OnClick, WasmLanguage.Rust, WasmPath, "getHtml", [], "WasmHtmlOutput");

        Write(form.ExportToHtmlComment());
    }
}
```

The `Fetch.WasmMethod` method calls a Rust WebAssembly method and returns its result.

In this example:

```csharp
Fetch.WasmMethod(
    WasmLanguage.Rust,
    WasmPath,
    "add",
    [10000, 3]
)
```

the `add` method inside the Rust WebAssembly module is executed with the values `10000` and `3`. Its result is then added to the WebForms Core response.

The `SetWasmEvent` method assigns a Rust WebAssembly method to a browser event.

For example:

```csharp
form.SetWasmEvent(
    "WasmEvent",
    HtmlEvent.OnClick,
    WasmLanguage.Rust,
    WasmPath,
    "setData",
    ["h3Tag", "Text From Wasm", "lightgreen", "30px"]
);
```

When the `WasmEvent` button is clicked, the `set_data` method in the Rust WebAssembly module is executed.

The method creates a `WebForms` instance and generates WebForms Core commands that modify the `h3Tag` element.

The second `SetWasmEvent` call executes the `get_html` method and places its returned HTML into the `WasmHtmlOutput` element.

## View

The CodeBehind controller can be used with the following view:

```aspx
@page
@controller WasmRustController
@layout "/layout.aspx"
@{
  ViewData.Add("title","Rust Wasm");
}
<h3>Rust Wasm</h3>
<b>Rust WASM Result: </b>
<br>
<button id="WasmEvent">Wasm Event</button>
<br>
<h3 id="h3Tag">Wasm Tag Changing!</h3>
<button id="WasmEventWithOutput">Wasm Event With Output</button>
<p id="WasmHtmlOutput">Wasm Html Output</p>
```

The page contains two buttons.

The first button executes the `set_data` method from the Rust WebAssembly module. The method generates WebForms Core commands that change the text, background color, and font size of the `h3Tag` element.

The second button executes the `get_html` method. The returned HTML is placed inside the `WasmHtmlOutput` element.

## Rust WebAssembly and WebForms Core

In this model, Rust WebAssembly does not directly manipulate the browser DOM.

The Rust module generates either a value or a WebForms Core response. WebFormsJS receives the generated commands and executes them against the HTML DOM.

The execution flow is:

```text
CodeBehind
    ↓
WebForms
    ↓
Rust WebAssembly
    ↓
WebForms Core Response
    ↓
WebFormsJS Executor
    ↓
HTML DOM
```

With `wasm-bindgen`, Rust can use a generated JavaScript interface for WebAssembly execution.

With Raw WebAssembly, the `.wasm` module can be executed directly through the WebForms Core Rust WebAssembly execution path.

Both approaches can use the WebForms Core `WebForms` class to generate UI commands.

This allows Rust WebAssembly modules to participate in WebForms Core applications without requiring the Rust module to implement browser DOM manipulation.

After learning this example, you can use the WebForms Core `WebForms` class inside Rust WebAssembly modules to perform calculations, generate WebForms Core responses, and create more advanced server and browser interactions.
