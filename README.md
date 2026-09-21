![ ](https://github.com/user-attachments/assets/164a7efc-66a2-494a-bc26-614c2c53ce00)

# WebForms Classes

**WebForms Classes are the server-side component of WebForms Core technology.**

A WebForms class allows server-side code to create, update, remove, and manipulate HTML elements by generating **Action Control commands** for [**WebFormsJS**](https://github.com/elanatframework/Web_forms), the client-side runtime.

In the WebForms Core architecture, the WebForms class acts as the **Commander**, while WebFormsJS acts as the **Executor**:

**Client → Server → WebForms → Commands → WebFormsJS → HTML DOM**

[**WebForms Core**](https://github.com/webforms-core) is a server-driven web technology created by [**Elanat**](https://elanat.net). It allows developers to manage interactive HTML interfaces from server-side code without requiring a separate front-end layer.

**What Exactly Is WebForms Class?**

* Commander
* Logic Engine
* Workflow Engine
* Controller
* Command Pipeline
* UI Orchestrator
* UI Behavior Engine
* Action Builder
* Response Composer
* DOM Operation Planner
* Event Coordinator

## WebForms Core Example

To use WebForms Core technology, you need to get the [**WebFormsJS**](https://github.com/elanatframework/Web_forms) library and add it to the `<head>` section of your HTML page.

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

On the server side, you also need to get the [WebForms class](https://github.com/elanatframework/Web_forms_classes) for the server programming language and implement it in your system.

**C# example in CodeBehind framework**

```csharp
using CodeBehind;

public partial class ContactController : CodeBehindController
{
    public void PageLoad(HttpContext context)
    {
        if (context.Request.IfForm["button"].Has())
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
        form.AssignDelay(3000);
        form.SetDisabled("(button)", true);

        Write(form.Response());

        IgnoreViewAndModel = true;
    }
}
```

The GIF image below shows how the above code works.

![WebForms Core example in web forms classes](https://github.com/user-attachments/assets/a4bc19eb-578b-42d0-b725-2ec28d16e3e5)

In this example, after clicking the button, an instance of the WebForms class is created first. Then, a new `h3` tag is created, the success message is added to it and displayed to the user for 3 seconds, and then the tag is removed. The submit button is also disabled. Finally, the response is sent to the client using the `Response` method.

**What is sent from the client to the server?**

In WebForms Core technology, data is sent as an HTML form submission.

```
message=Please send your product price list to my email account.&email=Adriano@gmail.com&name=Adriano&button=Submit
```

**What does the server respond to the client?**

The server response is based on the INI pattern.

```
[web-forms]
sd(button)=1
nt<form>=h3
bc<h3>=green
st<h3>=Adriano! Your message was sent successfully.
:3000)de<h3>=1
```

**Parent class:** WebForms classes in all programming languages are based on the C# WebForms class. The C# class is the parent implementation of all WebForms classes.

> Note: WebForms Core technology was initially developed as a feature of the [CodeBehind framework](https://github.com/elanatframework/Code_behind). At Elanat, we provide WebForms Core implementations for multiple programming languages.

## Installation via Package

---

**AssemblyScript in npm** (https://www.npmjs.com/package/webformscore-wasm)

CLI
```bash
npm install webformscore-wasm
```

---

**C in GitHub** (https://github.com/webforms-core/Web_forms_classes/tree/elanat_framework/c)

Copy file
```text
Get the WebForms.h file directly from the c directory.
```

---

**C# (.NET) in NuGet** (https://www.nuget.org/packages/WFC)

CLI
```bash
dotnet add package WFC
```

Project settings
```
<PackageReference Include="WFC" />
```

---

**C++ in GitHub** (https://github.com/webforms-core/Web_forms_classes/tree/elanat_framework/cpp)

Copy file
```text
Get the WebForms.h file directly from the cpp directory.
```

---

**Dart in Pub.dev** (https://pub.dev/packages/webforms)

CLI

```bash
dart pub add webforms
```

Project settings

```yaml
dependencies:
  webforms: ^2.1.0
```

---

**Elixir in Hex.pm** (https://hex.pm/packages/wfc)

Project settings

```elixir
defp deps do
  [
    {:wfc, "~> 2.1"}
  ]
end
```

CLI

```bash
mix deps.get
```

---

**GO module repository** (https://github.com/webforms-core/go)

CLI
```bash
go get github.com/webforms-core/go
```

---

**Java in Maven Central** (https://central.sonatype.com/artifact/net.elanat/WFC)

Project settings for Maven
```
<dependency>
    <groupId>net.elanat</groupId>
    <artifactId>WFC</artifactId>
    <version>#.#.#</version>
</dependency>
```

Project settings for Gradle
```
dependencies {
    implementation "net.elanat:WFC:#.#.#"
}
```

---

**JavaScript in npm** (https://www.npmjs.com/package/webformscore)

CLI
```bash
npm install webformscore
```

---

**Perl in CPAN** (https://metacpan.org/dist/WFC)

CLI

```bash
cpanm WFC
```

or

```bash
cpan WFC
```

---

**PHP in Packagist** (https://packagist.org/packages/webforms-core/php)

CLI
```bash
composer require webforms-core/php
```

---

**Python in PyPi** (https://pypi.org/project/WFC/)

CLI
```bash
pip install WFC
```

---

**Ruby in RubyGems** (https://rubygems.org/gems/wfc)

CLI
```bash
gem install wfc
```

---

**Rust in Crates.io** (https://crates.io/crates/webformscore)

CLI
```bash
cargo add webformscore
```

Project settings
```
[dependencies]
webformscore = "#.#.#"
```

---

## Other programming languages 
- **TypeScript:** You can easily use the JavaScript [WebForms.js](https://github.com/elanatframework/Web_forms_classes/blob/elanat_framework/nodejs/WebForms.js) NodeJS class for TypeScript programming language.
- **Scala, Kotlin, Groovy, Clojure and ColdFusion:** By configuring the build tools (such as Gradle, Maven, or SBT), you can use the [Java WebForms classes](https://github.com/elanatframework/Web_forms_classes/tree/elanat_framework/java/WebFormsCore) for Scala, Kotlin, Groovy, Clojure and ColdFusion programming languages.
- **Objective-C:** C calls are allowed in Objective-C, so you can easily use the C WebForms.h class.
- **Visual Basic:** You can easily use the C# [WebForms.cs](https://github.com/elanatframework/Code_behind/blob/elanat_framework/class/WebForms.cs) class for Visual Basic programming language.
- **F#:** To use WebForms Core technology in F#, you can build the [WebForms.cs](https://github.com/elanatframework/Code_behind/blob/elanat_framework/class/WebForms.cs) class in C# and use the DLL created in F#.
- **Erlang:** The WebForms class in the Elixir programming language can be used. 
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
