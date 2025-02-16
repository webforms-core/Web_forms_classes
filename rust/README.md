## How to work with WebForms Core in Rust (Actix-web framework)

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

Place the following view in the "templates" directory in the project path.

View file (index.html)
```html
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
```

Also, create a Rust class file as follows.

Rust code
```rust
use actix_web::{web, App, HttpServer, HttpResponse, Responder};
use tera::Tera;
use std::sync::Arc;
use actix_files as fs;

mod web_forms;
use crate::web_forms::{WebForms, InputPlace};

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
    let rendered = state.tera.render("index.html", &tera::Context::new()).unwrap();
    HttpResponse::Ok().content_type("text/html").body(rendered)
}

async fn handle_post(params: web::Form<Params>, state: web::Data<AppState>) -> impl Responder {
    let name = &params.txt_Name;
    let background_color = &params.txt_BackgroundColor;
    let font_size: i32 = params.txt_FontSize.parse().unwrap_or(16);

    let mut form = WebForms::new();
    
    form.set_font_size(InputPlace::tag("form").as_str(), font_size);
    form.set_background_color(InputPlace::tag("form").as_str(), background_color.clone());
    form.set_disabled(InputPlace::name("btn_SetBodyValue").as_str(), true);

    form.add_tag(InputPlace::tag("form").as_str(), "h3".to_string(), "ID".to_string());
    form.set_text(InputPlace::tag("h3").as_str(), format!("Welcome {}!", name.to_string()));

    return HttpResponse::Ok().body(form.response());
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
name = "web_forms_core"
version = "0.1.0"
edition = "2025"

[dependencies]
actix-web = "4"
actix-rt = "2"
tera = "1.14"
serde = { version = "1.0", features = ["derive"] }
actix-files = "0.6"
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js
