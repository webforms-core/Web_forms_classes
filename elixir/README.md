## How to work with WebForms Core in Elixir (Phoenix framework)

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

Create a template file "default.html.eex" in the "templates/my" directory.

View file
```html
<!DOCTYPE html>
<html>
<head>
  <title>Using WebForms Core</title>
  <script type="text/javascript" src="/script/web-forms.js"></script>
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

Also, create a Controller class file as follows.

Controller class
```elixir
defmodule MyAppWeb.MyController do
  use MyAppWeb, :controller

  # GET request handler
  def index(conn, _params) do
    render(conn, "default.html")
  end

  # POST request handler
  def submit(conn, %{
        "txt_Name" => name,
        "txt_BackgroundColor" => background_color,
        "txt_FontSize" => font_size,
        "btn_SetBodyValue" => _button
      }) do

    form = WebForms.new()
    form = WebForms.set_font_size(form, InputPlace.tag("form"), font_size)
    form = WebForms.set_background_color(form, InputPlace.tag("form"), background_color)
    form = WebForms.set_disabled(form, InputPlace.name("btn_SetBodyValue"), true)
    form = WebForms.add_tag(form, InputPlace.tag("form"), "h3", nil)
    form = WebForms.set_text(form, InputPlace.tag("h3"), "Welcome #{name}!")

    response = WebForms.response(form)
    text(conn, response)
  end
end
```

Add routes for the controller in the Phoenix router.

Router (router.ex)
```elixir
defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  scope "/", MyAppWeb do
    get "/", MyController, :index
    post "/", MyController, :submit
  end
end
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js
