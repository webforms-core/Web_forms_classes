## How to work with WebForms Core in Dart (Shelf framework)

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

```dart
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import 'WebForms.dart';

void main() async {
  // Create a Shelf router
  var router = Router();

  // Handle POST requests to the root path
  router.post('/', (Request request) async {
    var body = await request.readAsString();
    var formData = Uri.splitQueryString(body);

    // Check if the button was clicked
    if (formData['btn_SetBodyValue'] != null) {
      var name = formData['txt_Name'] ?? '';
      var backgroundColor = formData['txt_BackgroundColor'] ?? '';
      var fontSize = int.tryParse(formData['txt_FontSize'] ?? '16') ?? 16;

      var form = WebForms();

      form.setFontSize(InputPlace.tag('form'), '${fontSize}px');
      form.setBackgroundColor(InputPlace.tag('form'), backgroundColor);
      form.setDisabled(InputPlace.name('btn_SetBodyValue'), true);

      form.addTag(InputPlace.tag('form'), 'h3');
      form.setText(InputPlace.tag('h3'), 'Welcome $name!');

      return Response.ok(form.response(), headers: {'Content-Type': 'text/plain'});
    }

    return Response.ok(_htmlForm(), headers: {'Content-Type': 'text/html'});
  });

  var server = await io.serve(router, 'localhost', 8080);
  print('Server running on http://${server.address.host}:${server.port}');
}

String _htmlForm() {
  return '''
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
  ''';
}
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js
