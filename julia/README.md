## How to work with WebForms Core in Julia

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

```julia
using HTTP

include("WebForms.jl")

function handle_request(req::HTTP.Request)
    if HTTP.hasheader(req, "Content-Type") && occursin("application/x-www-form-urlencoded", req.headers["Content-Type"])
        body = String(req.body)
        params = HTTP.queryparams(body)

        if haskey(params, "btn_SetBodyValue")
            name = get(params, "txt_Name", "")
            background_color = get(params, "txt_BackgroundColor", "")
            font_size = parse(Int, get(params, "txt_FontSize", "16"))

            form = WebForms.WebForms()

            WebForms.set_font_size!(form, InputPlace.tag("form"), "$font_size" * "px")
            WebForms.set_background_color!(form, InputPlace.tag("form"), background_color)
            WebForms.set_disabled!(form, InputPlace.name("btn_SetBodyValue"), true)

            WebForms.add_tag!(form, InputPlace.tag("form"), "h3")
            WebForms.set_text!(form, InputPlace.tag("h3"), "Welcome $name!")

            return HTTP.Response(200, WebForms.response(form))
        end
    end

    html = """
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
    """

    return HTTP.Response(200, html)
end

HTTP.serve(handle_request, "127.0.0.1", 8080)
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js
