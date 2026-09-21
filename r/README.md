## How to work with WebForms Core in R (httpuv library)

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

```r
library(httpuv)

# Load the webforms.R script
source("webforms.R")

# Define the server logic
app <- list(
  call = function(req) {
    tryCatch({

      # Serve WebFormsJS
      if (req$REQUEST_METHOD == "GET" &&
          req$PATH_INFO == "/script/web-forms.js") {
        return(list(
          status = 200L,
          headers = list("Content-Type" = "application/javascript"),
          body = paste(
            readLines("script/web-forms.js", warn = FALSE),
            collapse = "\n"
          )
        ))
      }

      if (req$REQUEST_METHOD == "POST") {
        form_data <- rawToChar(req$rook.input$read())
        form_data <- strsplit(form_data, "&")[[1]]
        form_data <- setNames(
          lapply(
            form_data,
            function(x) URLdecode(strsplit(x, "=")[[1]][2])
          ),
          sapply(
            form_data,
            function(x) strsplit(x, "=")[[1]][1]
          )
        )

        if (!is.null(form_data$btn_SetBodyValue)) {
          name <- form_data$txt_Name
          font_size <- as.numeric(form_data$txt_FontSize)
          bg_color <- form_data$txt_BackgroundColor

          form <- WebForms$new()

          # Set form properties using WebForms methods
          form$set_font_size("<form>", font_size)
          form$set_background_color("<form>", bg_color)
          form$set_disabled("(btn_SetBodyValue)", TRUE)

          # Add a new tag and set its text
          form$add_tag("<form>", "h3")
          form$set_text("<h3>", paste0("Welcome ", name, "!"))

          # Return a response to the client
          return(list(
            status = 200L,
            headers = list("Content-Type" = "text/plain"),
            body = form$response()
          ))
        }
      }

      # If the request is not a POST or the button was not clicked,
      # return the HTML form
      return(list(
        status = 200L,
        headers = list("Content-Type" = "text/html"),
        body = '<!DOCTYPE html>
<html>
<head>
  <title>Using WebForms Core</title>
  <script type="module" src="/script/web-forms.js"></script>
</head>
<body>
    <form method="POST" action="/">
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
</html>'
      ))

    }, error = function(e) {
      message("An error occurred: ", e$message)
      traceback()

      return(list(
        status = 500L,
        headers = list("Content-Type" = "text/plain"),
        body = paste0("WebForms Core Error: ", e$message)
      ))
    })
  }
)

# Start the server
server <- startServer("127.0.0.1", 8080, app)
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js
