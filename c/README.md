## How to work with WebForms Core in C (Mongoose framework)

To use WebForms Core, first copy the WebForms header file in this directory to your project. Then create a new View file similar to the one below.

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "mongoose.h"
#include "WebForms.h"

static const char *view_html =
"<!DOCTYPE html>\n"
"<html>\n"
"<head>\n"
"  <title>Using WebForms Core</title>\n"
"  <script type=\"module\" src=\"/script/web-forms.js\"></script>\n"
"</head>\n"
"<body>\n"
"    <form method=\"post\" action=\"/\">\n"
"\n"
"        <label for=\"txt_Name\">Your Name</label>\n"
"        <input name=\"txt_Name\" id=\"txt_Name\" type=\"text\" />\n"
"        <br>\n"
"        <label for=\"txt_FontSize\">Set Font Size</label>\n"
"        <input name=\"txt_FontSize\" id=\"txt_FontSize\" type=\"number\" value=\"16\" min=\"10\" max=\"36\" />\n"
"        <br>\n"
"        <label for=\"txt_BackgroundColor\">Set Background Color</label>\n"
"        <input name=\"txt_BackgroundColor\" id=\"txt_BackgroundColor\" type=\"text\" />\n"
"        <br>\n"
"        <input name=\"btn_SetBodyValue\" type=\"submit\" value=\"Click to send data\" />\n"
"\n"
"    </form>\n"
"</body>\n"
"</html>";

static const char *backEndRender(const char *viewName)
{
    if (strcmp(viewName, "view") == 0) {
        return view_html;
    }
    return "<h1>View not found</h1>";
}

static void handle_form(struct mg_connection *c, struct mg_http_message *hm)
{
    // Check whether btn_SetBodyValue is present in POST body
    char val[64];
    long n = mg_http_get_var(&hm->body, "btn_SetBodyValue", val, sizeof(val));
    if (n <= 0) {
        mg_http_reply(c, 200, "Content-Type: text/html\r\n", "%s", backEndRender("view"));
        return;
    }

    char fontSize_str[32]  = {0};
    char background_color[128] = {0};
    char name[128] = {0};

    mg_http_get_var(&hm->body, "txt_FontSize", fontSize_str, sizeof(fontSize_str));
    mg_http_get_var(&hm->body, "txt_BackgroundColor", background_color, sizeof(background_color));
    mg_http_get_var(&hm->body, "txt_Name", name, sizeof(name));

    int fontSize = atoi(fontSize_str);

    WebForms *form = webforms_create();
    if (!form) {
        mg_http_reply(c, 500, "", "Internal error");
        return;
    }

    // Build InputPlace selectors (each returns a heap-allocated string)
    char *ipForm = webforms_ip_tag("form");
    char *ipH3   = webforms_ip_tag("h3");
    char *ipBtn  = webforms_ip_tag("btn_SetBodyValue");

    // _Generic dispatch: int -> webforms_set_font_size_int
    webforms_set_font_size(form, ipForm, fontSize);
    webforms_set_background_color(form, ipForm, background_color);
    webforms_set_disabled(form, ipBtn, true);

    webforms_add_tag(form, ipForm, "h3", "");

    char welcome[256];
    snprintf(welcome, sizeof(welcome), "Welcome %s!", name);
    webforms_set_text(form, ipH3, welcome);

    // Read response (heap-allocated)
    char *response = webforms_response(form);
    if (response) {
        mg_http_reply(c, 200, "Content-Type: text/plain\r\n", "%s", response);
        free(response);
    }

    // Release InputPlace strings
    free(ipForm);
    free(ipH3);
    free(ipBtn);

    // Clean and destroy instance
    webforms_clean(form);
    webforms_free(form);
}

static void fn(struct mg_connection *c, int ev, void *ev_data)
{
    if (ev == MG_EV_HTTP_MSG) {
        struct mg_http_message *hm = (struct mg_http_message *) ev_data;

        if (mg_match(hm->uri, mg_str("/"), NULL)) {
            if (mg_strcmp(hm->method, mg_str("POST")) == 0) {
                handle_form(c, hm);
            } else {
                mg_http_reply(c, 200, "Content-Type: text/html\r\n", "%s", backEndRender("view"));
            }
        } else if (mg_match(hm->uri, mg_str("/script/*"), NULL)) {
            // Serve static files from ./script/
            struct mg_http_serve_opts opts = { .root_dir = "." };
            mg_http_serve_dir(c, hm, &opts);
        } else {
            mg_http_reply(c, 404, "", "Not found");
        }
    }
}

int main(void)
{
    struct mg_mgr mgr;
    mg_mgr_init(&mgr);

    printf("========================================\n");
    printf("WebForms Core C Test Server\n");
    printf("========================================\n");
    printf("sizeof(void*) = %llu bytes\n", (unsigned long long)sizeof(void *));
    printf("Server running on http://127.0.0.1:8080\n");
    printf("Open browser and visit:\n");
    printf("  http://127.0.0.1:8080/\n");
    printf("Press Ctrl+C to stop\n");
    printf("========================================\n");

    if (mg_http_listen(&mgr, "http://127.0.0.1:8080", fn, NULL) == NULL) {
        fprintf(stderr, "Failed to start server\n");
        mg_mgr_free(&mgr);
        return 1;
    }

    for (;;) {
        mg_mgr_poll(&mgr, 1000);
    }

    mg_mgr_free(&mgr);
    return 0;
}
```

In the upper part of the View file, it is first checked whether the submit button has been clicked or not, if it has been clicked, an instance of the WebForms class is created, then the WebForms methods are called, and then the response method is printed on the screen, and other parts Views are not displayed.
Please note that if the submit button is not clicked (initial request), the view page will be displayed completely for the requester.

As you can see, the WebFormsJS script has been added in the header section of the View file above.

The latest version of the WebFormsJS script is available through the link below.

https://github.com/elanatframework/Web_forms/blob/elanat_framework/web-forms.js
