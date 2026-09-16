## How to work with WebForms Core in Dart (Shelf framework)

To use WebForms Core, first copy the WebForms class file in this directory to your project. Then create a new View file similar to the one below.

```dart
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import 'webforms.dart';

void main() async {
  var router = Router();

  router.get('/script/web-forms.js', (Request request) {
    final file = File('web/script/web-forms.js');
    if (!file.existsSync()) {
      return Response.notFound('web-forms.js not found');
    }
    return Response.ok(
      file.readAsStringSync(),
      headers: {'Content-Type': 'application/javascript; charset=utf-8'},
    );
  });

  router.post('/', (Request request) async {
    var body = await request.readAsString();
    var formData = Uri.splitQueryString(body);

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

      return Response.ok(
        form.response(),
        headers: {'Content-Type': 'text/plain; charset=utf-8'},
      );
    }

    return Response.ok(
      _htmlForm(),
      headers: {'Content-Type': 'text/html; charset=utf-8'},
    );
  });

  router.get('/', (Request request) {
    return Response.ok(
      _htmlForm(),
      headers: {'Content-Type': 'text/html; charset=utf-8'},
    );
  });

  var server = await io.serve(router, InternetAddress.loopbackIPv4, 8080);
  print('Server running on http://${server.address.host}:${server.port}');
}

String _htmlForm() {
  return '''
<!DOCTYPE html>
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
</html>
  ''';
}
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js
