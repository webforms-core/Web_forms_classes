![ ](https://github.com/user-attachments/assets/164a7efc-66a2-494a-bc26-614c2c53ce00)
# WebForms Classes

WebForms Core technology was created by [Elanat](https://elanat.net). It is a two-way protocol between the WebForms class on the server side and the [web-forms.js](https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js) library on the client side, where processing is done on the client side and the server sends Action Control commands to [WebFormsJS](https://github.com/elanatframework/Web_forms).

By using WebForms Core technology, HTML tags are managed server-side, eliminating the need for front-end development.

## WebForms Core Example

To use WebForms Core technology, you need to get the [WebFormsJS](https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js) library and add it to the head section of your HTML page.

**HTML page**
```diff
<!DOCTYPE html>
<html>
<head>
    <title>WebForms Core Example</title>
+   <script type="module" src="/script/web-forms.js"></script>
</head>
<body>
    <h1>Contact Us</h1>
    <form action="/contact" method="post">
        Name:<input type="text" name="name" required><br>
        Email:<input type="email" name="email" required><br>
        Message:<br><textarea name="message" rows="4" cols="50" required></textarea><br>        
        <input type="submit" name="button" value="Submit">
    </form>
</body>
</html>
```

On the server side, you also need to get the [WebForms class](https://github.com/elanatframework/Web_forms_classes) for the server programming language and implement it on your system.

**C# example in CodeBehind framework**
```csharp
using CodeBehind;

public partial class ContactController : CodeBehindController
{
    public void PageLoad(HttpContext context)
    {
        if (context.Request.Form["button"].Has())
            Button_Click(context);
    }

    private void Button_Click(HttpContext context)
    {
        // Code for add contact to database
        // ...

        WebForms form = new WebForms();

        string name = context.Request.Form["name"];

        form.AddTag("<form>", "h3");
        form.SetBackgroundColor("<h3>", "green");
        form.SetText("<h3>", name + "! Your message was sent successfully.");
        form.Delete("<h3>");
        form.AssignDelay(3);
        form.SetDisabled("(button)", true);

        Write(form.Response());

        IgnoreViewAndModel = true;
    }
}
```

The GIF image below shows how the above code works.
![WebForms Core example in web forms classes](https://github.com/user-attachments/assets/a4bc19eb-578b-42d0-b725-2ec28d16e3e5)

In this example, after clicking the button, first an instance of the WebForms class is created. Then a new h3 tag is created and the submit text is successfully added in it and shown to the user for 3 seconds and then removed. The submit button will also be disabled and finally the response is sent to the client using the `Response` method.

**What is sent from the client to the server?**

In WebForms Core technology, data is sent as if it were an HTML page form submission.
```
message=Please send your product price list to my email account.&email=Adriano@gmail.com&name=Adriano&button=Submit
```

**What does the server respond to the client?**

The server response is also based on the INI pattern.
```
[web-forms]
sd(button)=1
nt<form>=h3
bc<h3>=green
st<h3>=Adriano! Your message was sent successfully.
:3)de<h3>=1
```

## Other programming languages 

- **C#:** WebForms classes in all programming languages ​​are built from the C# class in [this link](https://github.com/elanatframework/Code_behind/blob/elanat_framework/class/WebForms.cs). This class is the parent class of all WebForms classes.
> Note: WebForms Core technology is a feature of the [CodeBehind framework](https://github.com/elanatframework/Code_behind), but at Elanat we provide WebForms Core for all programming languages.
- **TypeScript:** You can easily use the JavaScript [WebForms.js](https://github.com/elanatframework/Web_forms_classes/blob/elanat_framework/nodejs/WebForms.js) NodeJS class for TypeScript programming language.
- **Scala, Kotlin, Groovy, Clojure and ColdFusion:** By configuring the build tools (such as Gradle, Maven, or SBT), you can use the [Java WebForms classes](https://github.com/elanatframework/Web_forms_classes/tree/elanat_framework/java/WebFormsCore) for Scala, Kotlin, Groovy, Clojure and ColdFusion programming languages.
- **Objective-C:** C calls are allowed in Objective-C, so you can easily use the C WebForms.h class.
- **Visual Basic:** You can easily use the C# [WebForms.cs](https://github.com/elanatframework/Code_behind/blob/elanat_framework/class/WebForms.cs) class for Visual Basic programming language.
- **F#:** To use WebForms Core technology in F#, you can build the [WebForms.cs](https://github.com/elanatframework/Code_behind/blob/elanat_framework/class/WebForms.cs) class in C# and use the DLL created in F#.
- **Less popular programming languages:** We strive to provide the WebForms class on the server for 99% of web development cases; if you would like to use WebForms Core technology in a less popular programming language (on the web), ask senior developers to convert the [WebForms.cs](https://github.com/elanatframework/Code_behind/blob/elanat_framework/class/WebForms.cs) class to your preferred programming language and submit a pull request to this repository.
- **Deprecated programming languages:** The likelihood of using these programming languages ​​is low, but we respect the developers of these programming languages, so you can still ask senior developers to convert the [WebForms.cs](https://github.com/elanatframework/Code_behind/blob/elanat_framework/class/WebForms.cs) class to your preferred programming language and submit a pull request to this repository.

## Feel free to create pull requests
In this repository, you convert the WebForms class in the CodeBehind framework (written in C# programming language) into a WebForms class in your desired programming language.

The WebForms class is available in the CodeBehind framework at the following link:

https://github.com/elanatframework/Code_behind/blob/elanat_framework/class/WebForms.cs

The pull request should include a directory with the same name as the programming language, and in this directory a class called WebForms with the corresponding postcode should be created. The WebForms class must be based on the WebForms class in the CodeBehind framework.

We encourage web professionals to module the WebForms Core technology so that it is easily available in web frameworks. The contents of the module must be added in a directory with the same name as the corresponding framework in the framework's programming language.

> Note: You do not need to use the CodeBehind namespace to create a WebForms class for programming languages. If you are creating a new module to be used in web frameworks, you must add the namespace for the relevant web framework.

Please do not pull request to add new feature. The new features require a coordination between the WebFormsJS library and the WebForms class. So first, new features are added in the CodeBehind framework, and then you can pull requests for these new features in WebForms classes or WebForms modules.
