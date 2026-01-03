## How to work with WebForms Core in GO

To use WebForms Core, first copy the WebForms class file ("webforms.go") in this directory to "webforms" directory in your project. Then create a new View file ("main.go") similar to the one below.
> Please make sure to replace "{your-project-name}" with project name in the import section.

```go
package main

import (
	"fmt"
	"{your-project-name}/webforms"
	"net/http"
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

		form := new(webforms.WebForms)
		ip := &webforms.InputPlace{}

		form.SetFontSize(ip.Tag("form"), fontSize+"px")
		form.SetBackgroundColor(ip.Tag("form"), backgroundColor)
		form.SetDisabled(ip.Name("btn_SetBodyValue"), true)

		form.AddTag(ip.Tag("form"), "h3", "p")
		form.SetText(ip.Tag("h3"), "Welcome "+name+"!")

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

