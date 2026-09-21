# webforms.R 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
# Compatible with WebFormsJS version 2.1

GS <- intToUtf8(29)
US <- intToUtf8(31)

NUL <- rawToChar(as.raw(0))

WebForms <- R6::R6Class("WebForms",
  private = list(
    webFormsData = ""
  ),
  public = list(
    initialize = function() {
      private$webFormsData <- ""
    },

    # internal void Add(string Name, string Value)
    # internal void Add(string Name)
    add = function(name, value = NULL) {
      if (nchar(private$webFormsData) > 0) {
        private$webFormsData <- paste0(private$webFormsData, "\n")
      }
      private$webFormsData <- paste0(private$webFormsData, name)
      if (!is.null(value) && nchar(value) > 0) {
        private$webFormsData <- paste0(private$webFormsData, "=", value)
      }
    },

    # internal void AddToUp(string name, string value)
    # internal void AddToUp(string name)
    add_to_up = function(name, value = NULL) {
      line <- name
      if (!is.null(value) && nchar(value) > 0) {
        line <- paste0(name, "=", value)
      }
      if (nchar(private$webFormsData) > 0) {
        line <- paste0(line, "\n")
      }
      private$webFormsData <- paste0(line, private$webFormsData)
    },

    # internal string GetLineByIndex(int Index)
    get_line_by_index = function(index) {
      if (nchar(private$webFormsData) == 0) {
        return("")
      }
      data <- private$webFormsData
      lines <- strsplit(data, "\n", fixed = TRUE)[[1]]
      if (index < 0) {
        index <- length(lines) + index
      }
      if (index < 0 || index >= length(lines)) {
        return("")
      }
      return(lines[index + 1])
    },

    # internal void UpdateLineByIndex(int Index, string Name, string Value)
    update_line_by_index = function(index, name, value = "") {
      if (nchar(private$webFormsData) == 0) {
        return(invisible(NULL))
      }
      data <- private$webFormsData
      lines <- strsplit(data, "\n", fixed = TRUE)[[1]]
      if (index < 0) {
        index <- length(lines) + index
      }
      if (index < 0 || index >= length(lines)) {
        return(invisible(NULL))
      }
      val_part <- if (is.null(value) || nchar(value) == 0) "" else paste0("=", value)
      lines[index + 1] <- paste0(name, val_part)
      private$webFormsData <- paste(lines, collapse = "\n")
      invisible(NULL)
    },

    # For Extension
    # public void AddLine(string Name, string Value) => Add(Name, Value);
    add_line = function(name, value) {
      self$add(name, value)
    },

    # Add
    # Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.
    add_id = function(inputPlace, id) self$add(paste0("ai", inputPlace), id),
    add_name = function(inputPlace, name) self$add(paste0("an", inputPlace), name),
    add_value = function(inputPlace, value) self$add(paste0("av", inputPlace), value),
    add_class = function(inputPlace, class) self$add(paste0("ac", inputPlace), class),
    add_style = function(inputPlace, style_or_name, value = NULL) {
      if (is.null(value)) {
        self$add(paste0("as", inputPlace), style_or_name)
      } else {
        self$add(paste0("as", inputPlace), paste0(style_or_name, ":", value))
      }
    },
    add_option_tag = function(inputPlace, text, value, selected = FALSE) {
      self$add(paste0("ao", inputPlace), paste0(value, GS, text, if (selected) paste0(GS, "1") else ""))
    },
    add_check_box_tag = function(inputPlace, text, value, checked = FALSE) {
      self$add(paste0("ak", inputPlace), paste0(value, GS, text, if (checked) paste0(GS, "1") else ""))
    },
    add_title = function(inputPlace, title) self$add(paste0("al", inputPlace), title),
    add_label = function(inputPlace, label) self$add(paste0("aA", inputPlace), label),
    add_text = function(inputPlace, text) {
      self$add(paste0("at", inputPlace), gsub("\n", "$[ln];", text, fixed = TRUE))
    },
    add_text_to_up = function(inputPlace, text) {
      self$add_to_up(paste0("pt", inputPlace), gsub("\n", "$[ln];", text, fixed = TRUE))
    },
    add_attribute = function(inputPlace, attribute, value = "", splitter = NUL) {
      splitter_str <- if (splitter != NUL) splitter else ""
      val_part <- if (!is.null(value) && nchar(value) > 0) paste0(GS, value) else ""
      self$add(paste0("aa", inputPlace), paste0(attribute, GS, splitter_str, val_part))
    },
    add_tag = function(inputPlace, tagName, id = "") {
      id_part <- if (!is.null(id) && nchar(id) > 0) paste0(GS, id) else ""
      self$add(paste0("nt", inputPlace), paste0(tagName, id_part))
    },
    add_tag_to_up = function(inputPlace, tagName, id = "") {
      id_part <- if (!is.null(id) && nchar(id) > 0) paste0(GS, id) else ""
      self$add(paste0("ut", inputPlace), paste0(tagName, id_part))
    },
    add_tag_before = function(inputPlace, tagName, id = "") {
      id_part <- if (!is.null(id) && nchar(id) > 0) paste0(GS, id) else ""
      self$add(paste0("bt", inputPlace), paste0(tagName, id_part))
    },
    add_tag_after = function(inputPlace, tagName, id = "") {
      id_part <- if (!is.null(id) && nchar(id) > 0) paste0(GS, id) else ""
      self$add(paste0("ft", inputPlace), paste0(tagName, id_part))
    },
    add_hidden = function(inputPlace, name, value, id = "") {
      id_part <- if (!is.null(id) && nchar(id) > 0) paste0(GS, id) else ""
      self$add(paste0("ah", inputPlace), paste0(name, GS, value, id_part))
    },

    # Set
    # Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.
    set_id = function(inputPlace, id) self$add(paste0("si", inputPlace), id),
    set_name = function(inputPlace, name) self$add(paste0("sn", inputPlace), name),
    set_value = function(inputPlace, value) self$add(paste0("sv", inputPlace), value),
    set_class = function(inputPlace, class) self$add(paste0("sc", inputPlace), class),
    set_style = function(inputPlace, style_or_name, value = NULL) {
      if (is.null(value)) {
        self$add(paste0("ss", inputPlace), style_or_name)
      } else {
        self$add(paste0("ss", inputPlace), paste0(style_or_name, ":", value))
      }
    },
    set_option_tag = function(inputPlace, text, value, selected = FALSE) {
      self$add(paste0("so", inputPlace), paste0(value, GS, text, if (selected) paste0(GS, "1") else ""))
    },
    set_checked = function(inputPlace, checked = FALSE) {
      self$add(paste0("sk", inputPlace), if (checked) "1" else "0")
    },
    set_check_box_tag = function(inputPlace, text, value, checked = FALSE) {
      self$add(paste0("sk", inputPlace), paste0(value, GS, text, if (checked) paste0(GS, "1") else ""))
    },
    set_title = function(inputPlace, title) self$add(paste0("sl", inputPlace), title),
    set_label = function(inputPlace, label) self$add(paste0("sA", inputPlace), label),
    set_text = function(inputPlace, text) {
      self$add(paste0("st", inputPlace), gsub("\n", "$[ln];", text, fixed = TRUE))
    },
    set_attribute = function(inputPlace, attribute, value = "") {
      val_part <- if (!is.null(value) && nchar(value) > 0) paste0(GS, value) else ""
      self$add(paste0("sa", inputPlace), paste0(attribute, GS, val_part))
    },
    set_width = function(inputPlace, width) {
      final_width <- if (is.numeric(width)) paste0(width, "px") else as.character(width)
      self$add(paste0("sw", inputPlace), final_width)
    },
    set_height = function(inputPlace, height) {
      final_height <- if (is.numeric(height)) paste0(height, "px") else as.character(height)
      self$add(paste0("sh", inputPlace), final_height)
    },
    set_background_color = function(inputPlace, color) self$add(paste0("bc", inputPlace), color),
    set_text_color = function(inputPlace, color) self$add(paste0("tc", inputPlace), color),
    set_font_name = function(inputPlace, name) self$add(paste0("fn", inputPlace), name),
    set_font_size = function(inputPlace, size) {
      final_size <- if (is.numeric(size)) paste0(size, "px") else as.character(size)
      self$add(paste0("fs", inputPlace), final_size)
    },
    set_font_bold = function(inputPlace, bold) self$add(paste0("fb", inputPlace), if (bold) "1" else "0"),
    set_visible = function(inputPlace, visible) self$add(paste0("vi", inputPlace), if (visible) "1" else "0"),
    set_text_align = function(inputPlace, align) self$add(paste0("ta", inputPlace), align),
    set_read_only = function(inputPlace, readOnly) self$add(paste0("sr", inputPlace), if (readOnly) "1" else "0"),
    set_disabled = function(inputPlace, disabled) self$add(paste0("sd", inputPlace), if (disabled) "1" else "0"),
    set_focus = function(inputPlace, focus) self$add(paste0("sf", inputPlace), if (focus) "1" else "0"),
    set_min_length = function(inputPlace, length) {
      final_length <- if (is.numeric(length)) as.character(length) else length
      self$add(paste0("mn", inputPlace), final_length)
    },
    set_max_length = function(inputPlace, length) {
      final_length <- if (is.numeric(length)) as.character(length) else length
      self$add(paste0("mx", inputPlace), final_length)
    },
    set_selected_value = function(inputPlace, value) self$add(paste0("ts", inputPlace), value),
    set_selected_index = function(inputPlace, index) {
      final_index <- if (is.numeric(index)) as.character(index) else index
      self$add(paste0("ti", inputPlace), final_index)
    },
    set_checked_value = function(inputPlace, value, checked) {
      self$add(paste0("ks", inputPlace), paste0(value, GS, if (checked) "1" else "0"))
    },
    set_checked_index = function(inputPlace, index, checked) {
      final_index <- if (is.numeric(index)) as.character(index) else index
      self$add(paste0("ki", inputPlace), paste0(final_index, GS, if (checked) "1" else "0"))
    },

    # Insert
    # Creates the Data only if it does not exist; otherwise, does nothing.
    insert_id = function(inputPlace, id) self$add(paste0("ii", inputPlace), id),
    insert_name = function(inputPlace, name) self$add(paste0("in", inputPlace), name),
    insert_value = function(inputPlace, value) self$add(paste0("iv", inputPlace), value),
    insert_class = function(inputPlace, class) self$add(paste0("ic", inputPlace), class),
    insert_style = function(inputPlace, style_or_name, value = NULL) {
      if (is.null(value)) {
        self$add(paste0("is", inputPlace), style_or_name)
      } else {
        self$add(paste0("is", inputPlace), paste0(style_or_name, ":", value))
      }
    },
    insert_option_tag = function(inputPlace, text, value, selected = FALSE) {
      self$add(paste0("io", inputPlace), paste0(value, GS, text, if (selected) paste0(GS, "1") else ""))
    },
    insert_check_box_tag = function(inputPlace, text, value, checked = FALSE) {
      self$add(paste0("ik", inputPlace), paste0(value, GS, text, if (checked) paste0(GS, "1") else ""))
    },
    insert_title = function(inputPlace, title) self$add(paste0("il", inputPlace), title),
    insert_label = function(inputPlace, label) self$add(paste0("iA", inputPlace), label),
    insert_text = function(inputPlace, text) {
      self$add(paste0("it", inputPlace), gsub("\n", "$[ln];", text, fixed = TRUE))
    },
    insert_attribute = function(inputPlace, attribute, value = "", splitter = NUL) {
      splitter_str <- if (splitter != NUL) splitter else ""
      val_part <- if (!is.null(value) && nchar(value) > 0) paste0(GS, value) else ""
      self$add(paste0("ia", inputPlace), paste0(attribute, GS, splitter_str, val_part))
    },

    # Delete
    delete_id = function(inputPlace) self$add(paste0("di", inputPlace)),
    delete_name = function(inputPlace) self$add(paste0("dn", inputPlace)),
    delete_value = function(inputPlace) self$add(paste0("dv", inputPlace)),
    delete_class = function(inputPlace, className) self$add(paste0("dc", inputPlace), className),
    delete_style = function(inputPlace, styleName) self$add(paste0("ds", inputPlace), styleName),
    delete_option_tag = function(inputPlace, value) self$add(paste0("do", inputPlace), value),
    delete_all_option_tag = function(inputPlace) self$add(paste0("do", inputPlace), "*"),
    delete_check_box_tag = function(inputPlace, value) self$add(paste0("dk", inputPlace), value),
    delete_all_check_box_tag = function(inputPlace) self$add(paste0("dk", inputPlace), "*"),
    delete_title = function(inputPlace) self$add(paste0("dl", inputPlace)),
    delete_label = function(inputPlace) self$add(paste0("dA", inputPlace)),
    delete_text = function(inputPlace) self$add(paste0("dt", inputPlace)),
    delete_attribute = function(inputPlace, attribute) self$add(paste0("da", inputPlace), attribute),
    delete = function(inputPlace) self$add(paste0("de", inputPlace)),
    delete_parent = function(inputPlace) self$add(paste0("dp", inputPlace)),

    # Tag
    swap_tag = function(inputPlace, outputPlace) self$add(paste0("sp", inputPlace), outputPlace),
    set_reflection = function(inputPlace, tag) self$add(paste0("sR", inputPlace), tag),
    set_reflection_by_output_place = function(inputPlace, outputPlace) self$add(paste0("iR", inputPlace), outputPlace),
    set_morph = function(inputPlace, tag) self$add(paste0("sM", inputPlace), tag),
    set_morph_by_output_place = function(inputPlace, outputPlace) self$add(paste0("iM", inputPlace), outputPlace),

    # Browser
    change_url = function(url) self$add("cu", url),
    set_head_title = function(title) self$add("ht", title),
    clipboard_write_text = function(text) self$add("nw", text),
    scroll_to = function(x, y) {
      x_str <- if (is.numeric(x)) as.character(x) else x
      y_str <- if (is.numeric(y)) as.character(y) else y
      self$add("ws", paste0(x_str, GS, y_str))
    },
    history_go = function(steps) {
      steps_str <- if (is.numeric(steps)) as.character(steps) else steps
      self$add("wg", steps_str)
    },
    reload_page = function() self$add("lr"),
    redirect = function(path) self$add("lh", path),

    # Increase
    increase_min_length = function(inputPlace, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(paste0("+n", inputPlace), val_str)
    },
    increase_max_length = function(inputPlace, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(paste0("+x", inputPlace), val_str)
    },
    increase_font_size = function(inputPlace, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(paste0("+f", inputPlace), val_str)
    },
    increase_width = function(inputPlace, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(paste0("+w", inputPlace), val_str)
    },
    increase_height = function(inputPlace, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(paste0("+h", inputPlace), val_str)
    },
    increase_value = function(inputPlace, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(paste0("+v", inputPlace), val_str)
    },

    # Decrease
    decrease_min_length = function(inputPlace, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(paste0("-n", inputPlace), val_str)
    },
    decrease_max_length = function(inputPlace, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(paste0("-x", inputPlace), val_str)
    },
    decrease_font_size = function(inputPlace, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(paste0("-f", inputPlace), val_str)
    },
    decrease_width = function(inputPlace, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(paste0("-w", inputPlace), val_str)
    },
    decrease_height = function(inputPlace, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(paste0("-h", inputPlace), val_str)
    },
    decrease_value = function(inputPlace, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(paste0("-v", inputPlace), val_str)
    },

	# Event
	# ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
	# All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.
	trigger_event = function(inputPlace, htmlEventListener, constructorName = NULL) {
	  cn_part <- if (!is.null(constructorName) && nchar(constructorName) > 0) {
		paste0(GS, constructorName)
	  } else {
		""
	  }

	  self$add(
		paste0("TE", inputPlace),
		paste0(htmlEventListener, cn_part)
	  )
	},

	set_post_event = function(inputPlace, htmlEvent, outputPlace = NULL) {
	  if (is.null(outputPlace)) {
		self$add(
		  paste0("Ep", inputPlace),
		  htmlEvent
		)
	  } else {
		self$add(
		  paste0("Ep", inputPlace),
		  paste0(htmlEvent, GS, outputPlace)
		)
	  }
	},

	set_post_event_add_view = function(inputPlace, htmlEvent) {
	  self$add(
		paste0("Ep", inputPlace),
		paste0(htmlEvent, GS, "+")
	  )
	},

	set_post_event_listener = function(inputPlace, htmlEventListener, outputPlace = NULL) {
	  if (is.null(outputPlace)) {
		self$add(
		  paste0("EP", inputPlace),
		  htmlEventListener
		)
	  } else {
		self$add(
		  paste0("EP", inputPlace),
		  paste0(htmlEventListener, GS, outputPlace)
		)
	  }
	},

	set_post_event_listener_add_view = function(inputPlace, htmlEventListener) {
	  self$add(
		paste0("EP", inputPlace),
		paste0(htmlEventListener, GS, "+")
	  )
	},

	set_get_event = function(inputPlace, htmlEvent, path_or_outputPlace = NULL, path = NULL) {
	  if (is.null(path)) {
		path_val <- if (is.null(path_or_outputPlace) || nchar(path_or_outputPlace) == 0) {
		  "#"
		} else {
		  path_or_outputPlace
		}

		self$add(
		  paste0("Eg", inputPlace),
		  paste0(htmlEvent, GS, path_val)
		)
	  } else {
		path_val <- if (nchar(path) == 0) "#" else path

		self$add(
		  paste0("Eg", inputPlace),
		  paste0(htmlEvent, GS, path_val, GS, path_or_outputPlace)
		)
	  }
	},

	set_get_event_listener = function(inputPlace, htmlEventListener, path_or_outputPlace = NULL, path = NULL) {
	  if (is.null(path)) {
		path_val <- if (is.null(path_or_outputPlace) || nchar(path_or_outputPlace) == 0) {
		  "#"
		} else {
		  path_or_outputPlace
		}

		self$add(
		  paste0("EG", inputPlace),
		  paste0(htmlEventListener, GS, path_val)
		)
	  } else {
		path_val <- if (nchar(path) == 0) "#" else path

		self$add(
		  paste0("EG", inputPlace),
		  paste0(htmlEventListener, GS, path_val, GS, path_or_outputPlace)
		)
	  }
	},

	set_put_event = function(inputPlace, htmlEvent, path_or_outputPlace = NULL, path = NULL) {
	  if (is.null(path)) {
		path_val <- if (is.null(path_or_outputPlace) || nchar(path_or_outputPlace) == 0) {
		  "#"
		} else {
		  path_or_outputPlace
		}

		self$add(
		  paste0("Et", inputPlace),
		  paste0(htmlEvent, GS, path_val)
		)
	  } else {
		path_val <- if (nchar(path) == 0) "#" else path

		self$add(
		  paste0("Et", inputPlace),
		  paste0(htmlEvent, GS, path_val, GS, path_or_outputPlace)
		)
	  }
	},

	set_put_event_listener = function(inputPlace, htmlEventListener, path_or_outputPlace = NULL, path = NULL) {
	  if (is.null(path)) {
		path_val <- if (is.null(path_or_outputPlace) || nchar(path_or_outputPlace) == 0) {
		  "#"
		} else {
		  path_or_outputPlace
		}

		self$add(
		  paste0("ET", inputPlace),
		  paste0(htmlEventListener, GS, path_val)
		)
	  } else {
		path_val <- if (nchar(path) == 0) "#" else path

		self$add(
		  paste0("ET", inputPlace),
		  paste0(htmlEventListener, GS, path_val, GS, path_or_outputPlace)
		)
	  }
	},

	set_patch_event = function(inputPlace, htmlEvent, path_or_outputPlace = NULL, path = NULL) {
	  if (is.null(path)) {
		path_val <- if (is.null(path_or_outputPlace) || nchar(path_or_outputPlace) == 0) {
		  "#"
		} else {
		  path_or_outputPlace
		}

		self$add(
		  paste0("Ea", inputPlace),
		  paste0(htmlEvent, GS, path_val)
		)
	  } else {
		path_val <- if (nchar(path) == 0) "#" else path

		self$add(
		  paste0("Ea", inputPlace),
		  paste0(htmlEvent, GS, path_val, GS, path_or_outputPlace)
		)
	  }
	},

	set_patch_event_listener = function(inputPlace, htmlEventListener, path_or_outputPlace = NULL, path = NULL) {
	  if (is.null(path)) {
		path_val <- if (is.null(path_or_outputPlace) || nchar(path_or_outputPlace) == 0) {
		  "#"
		} else {
		  path_or_outputPlace
		}

		self$add(
		  paste0("EA", inputPlace),
		  paste0(htmlEventListener, GS, path_val)
		)
	  } else {
		path_val <- if (nchar(path) == 0) "#" else path

		self$add(
		  paste0("EA", inputPlace),
		  paste0(htmlEventListener, GS, path_val, GS, path_or_outputPlace)
		)
	  }
	},

	set_delete_event = function(inputPlace, htmlEvent, path_or_outputPlace = NULL, path = NULL) {
	  if (is.null(path)) {
		path_val <- if (is.null(path_or_outputPlace) || nchar(path_or_outputPlace) == 0) {
		  "#"
		} else {
		  path_or_outputPlace
		}

		self$add(
		  paste0("El", inputPlace),
		  paste0(htmlEvent, GS, path_val)
		)
	  } else {
		path_val <- if (nchar(path) == 0) "#" else path

		self$add(
		  paste0("El", inputPlace),
		  paste0(htmlEvent, GS, path_val, GS, path_or_outputPlace)
		)
	  }
	},

	set_delete_event_listener = function(inputPlace, htmlEventListener, path_or_outputPlace = NULL, path = NULL) {
	  if (is.null(path)) {
		path_val <- if (is.null(path_or_outputPlace) || nchar(path_or_outputPlace) == 0) {
		  "#"
		} else {
		  path_or_outputPlace
		}

		self$add(
		  paste0("EL", inputPlace),
		  paste0(htmlEventListener, GS, path_val)
		)
	  } else {
		path_val <- if (nchar(path) == 0) "#" else path

		self$add(
		  paste0("EL", inputPlace),
		  paste0(htmlEventListener, GS, path_val, GS, path_or_outputPlace)
		)
	  }
	},

	set_options_event = function(inputPlace, htmlEvent, path_or_outputPlace = NULL, path = NULL) {
	  if (is.null(path)) {
		path_val <- if (is.null(path_or_outputPlace) || nchar(path_or_outputPlace) == 0) {
		  "#"
		} else {
		  path_or_outputPlace
		}

		self$add(
		  paste0("Eo", inputPlace),
		  paste0(htmlEvent, GS, path_val)
		)
	  } else {
		path_val <- if (nchar(path) == 0) "#" else path

		self$add(
		  paste0("Eo", inputPlace),
		  paste0(htmlEvent, GS, path_val, GS, path_or_outputPlace)
		)
	  }
	},

	set_options_event_listener = function(inputPlace, htmlEventListener, path_or_outputPlace = NULL, path = NULL) {
	  if (is.null(path)) {
		path_val <- if (is.null(path_or_outputPlace) || nchar(path_or_outputPlace) == 0) {
		  "#"
		} else {
		  path_or_outputPlace
		}

		self$add(
		  paste0("EO", inputPlace),
		  paste0(htmlEventListener, GS, path_val)
		)
	  } else {
		path_val <- if (nchar(path) == 0) "#" else path

		self$add(
		  paste0("EO", inputPlace),
		  paste0(htmlEventListener, GS, path_val, GS, path_or_outputPlace)
		)
	  }
	},

	set_head_event = function(inputPlace, htmlEvent, path = NULL) {
	  path_val <- if (is.null(path) || nchar(path) == 0) "#" else path

	  self$add(
		paste0("Eh", inputPlace),
		paste0(htmlEvent, GS, path_val)
	  )
	},

	set_head_event_listener = function(inputPlace, htmlEventListener, path = NULL) {
	  path_val <- if (is.null(path) || nchar(path) == 0) "#" else path

	  self$add(
		paste0("EH", inputPlace),
		paste0(htmlEventListener, GS, path_val)
	  )
	},

	# IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
	set_send_event = function(
	  inputPlace,
	  htmlEvent,
	  data,
	  path = NULL,
	  method = "POST",
	  isMultiPart = FALSE,
	  contentType = "text/plain",
	  outputPlace = NULL
	) {
	  data_processed <- gsub("\n", "$[ln];", data, fixed = TRUE)
	  data_processed <- gsub("\"", "$[dq];", data_processed, fixed = TRUE)
	  data_processed <- gsub("'", "$[sq];", data_processed, fixed = TRUE)

	  path_val <- if (is.null(path) || nchar(path) == 0) "#" else path
	  mp_val <- if (isMultiPart) "1" else "0"
	  out_val <- if (is.null(outputPlace)) "" else outputPlace

	  self$add(
		paste0("En", inputPlace),
		paste0(
		  htmlEvent,
		  GS,
		  data_processed,
		  GS,
		  path_val,
		  GS,
		  method,
		  GS,
		  mp_val,
		  GS,
		  contentType,
		  GS,
		  out_val
		)
	  )
	},

	set_send_event_listener = function(
	  inputPlace,
	  htmlEventListener,
	  data,
	  path = NULL,
	  method = "POST",
	  isMultiPart = FALSE,
	  contentType = "text/plain",
	  outputPlace = NULL
	) {
	  data_processed <- gsub("\n", "$[ln];", data, fixed = TRUE)

	  path_val <- if (is.null(path) || nchar(path) == 0) "#" else path
	  mp_val <- if (isMultiPart) "1" else "0"
	  out_val <- if (is.null(outputPlace)) "" else outputPlace

	  self$add(
		paste0("EN", inputPlace),
		paste0(
		  htmlEventListener,
		  GS,
		  data_processed,
		  GS,
		  path_val,
		  GS,
		  method,
		  GS,
		  mp_val,
		  GS,
		  contentType,
		  GS,
		  out_val
		)
	  )
	},

	set_comment_event = function(inputPlace, htmlEvent, index = NULL, outputPlace = NULL) {
	  idx_val <- if (is.null(index)) "" else as.character(index)
	  out_val <- if (is.null(outputPlace)) "" else outputPlace

	  self$add(
		paste0("Eb", inputPlace),
		paste0(htmlEvent, GS, idx_val, GS, out_val)
	  )
	},

	set_comment_event_listener = function(inputPlace, htmlEventListener, index = NULL, outputPlace = NULL) {
	  idx_val <- if (is.null(index)) "" else as.character(index)
	  out_val <- if (is.null(outputPlace)) "" else outputPlace

	  self$add(
		paste0("EB", inputPlace),
		paste0(htmlEventListener, GS, idx_val, GS, out_val)
	  )
	},

	set_wasm_event = function(
	  inputPlace,
	  htmlEvent,
	  wasmLanguage,
	  wasmUrl,
	  methodName,
	  args = NULL,
	  outputPlace = NULL
	) {
	  args_join <- ""

	  if (!is.null(args)) {
		args_join <- if (length(args) > 0) {
		  paste0("[", paste(args, collapse = US))
		} else {
		  "["
		}
	  }

	  out_val <- if (is.null(outputPlace)) "" else outputPlace

	  self$add(
		paste0("Ey", inputPlace),
		paste0(
		  htmlEvent,
		  GS,
		  wasmLanguage,
		  GS,
		  wasmUrl,
		  GS,
		  methodName,
		  GS,
		  args_join,
		  GS,
		  out_val
		)
	  )
	},

	set_wasm_event_listener = function(
	  inputPlace,
	  htmlEventListener,
	  wasmLanguage,
	  wasmUrl,
	  methodName,
	  args = NULL,
	  outputPlace = NULL
	) {
	  args_join <- ""

	  if (!is.null(args)) {
		args_join <- if (length(args) > 0) {
		  paste0("[", paste(args, collapse = US))
		} else {
		  "["
		}
	  }

	  out_val <- if (is.null(outputPlace)) "" else outputPlace

	  self$add(
		paste0("EY", inputPlace),
		paste0(
		  htmlEventListener,
		  GS,
		  wasmLanguage,
		  GS,
		  wasmUrl,
		  GS,
		  methodName,
		  GS,
		  args_join,
		  GS,
		  out_val
		)
	  )
	},

	set_web_socket_event = function(inputPlace, htmlEvent, path) {
	  self$add(
		paste0("Ew", inputPlace),
		paste0(htmlEvent, GS, path)
	  )
	},

	set_web_socket_event_listener = function(inputPlace, htmlEventListener, path) {
	  self$add(
		paste0("EW", inputPlace),
		paste0(htmlEventListener, GS, path)
	  )
	},

	set_sse_event = function(
	  inputPlace,
	  htmlEvent,
	  path,
	  output_or_shouldReconnect = TRUE,
	  shouldReconnect = TRUE,
	  reconnectTryTimeout = 3000
	) {
	  if (is.logical(output_or_shouldReconnect)) {
		# C# overload:
		# SetSSEEvent(InputPlace, HtmlEvent, Path,
		#             bool ShouldReconnect = true,
		#             int ReconnectTryTimeout = 3000)

		sr <- output_or_shouldReconnect
		rt <- reconnectTryTimeout

		# Support the normal positional form:
		# set_sse_event(..., FALSE, 5000)
		if (!missing(shouldReconnect)) {
		  rt <- shouldReconnect
		}

		self$add(
		  paste0("Ee", inputPlace),
		  paste0(
			htmlEvent,
			GS,
			path,
			GS,
			if (sr) "1" else "0",
			GS,
			as.character(rt)
		  )
		)
	  } else {
		# C# overload:
		# SetSSEEvent(InputPlace, HtmlEvent, Path,
		#             string OutputPlace,
		#             bool ShouldReconnect = true,
		#             int ReconnectTryTimeout = 3000)

		out_val <- output_or_shouldReconnect
		sr <- shouldReconnect
		rt <- reconnectTryTimeout

		self$add(
		  paste0("Ee", inputPlace),
		  paste0(
			htmlEvent,
			GS,
			path,
			GS,
			if (sr) "1" else "0",
			GS,
			as.character(rt),
			GS,
			out_val
		  )
		)
	  }
	},

	set_sse_event_listener = function(
	  inputPlace,
	  htmlEventListener,
	  path,
	  output_or_shouldReconnect = TRUE,
	  shouldReconnect = TRUE,
	  reconnectTryTimeout = 3000
	) {
	  if (is.logical(output_or_shouldReconnect)) {
		# C# overload:
		# SetSSEEventListener(InputPlace, HtmlEventListener, Path,
		#                     bool ShouldReconnect = true,
		#                     int ReconnectTryTimeout = 3000)

		sr <- output_or_shouldReconnect
		rt <- reconnectTryTimeout

		if (!missing(shouldReconnect)) {
		  rt <- shouldReconnect
		}

		self$add(
		  paste0("EE", inputPlace),
		  paste0(
			htmlEventListener,
			GS,
			path,
			GS,
			if (sr) "1" else "0",
			GS,
			as.character(rt)
		  )
		)
	  } else {
		# C# overload:
		# SetSSEEventListener(InputPlace, HtmlEventListener, Path,
		#                     string OutputPlace,
		#                     bool ShouldReconnect = true,
		#                     int ReconnectTryTimeout = 3000)

		out_val <- output_or_shouldReconnect
		sr <- shouldReconnect
		rt <- reconnectTryTimeout

		self$add(
		  paste0("EE", inputPlace),
		  paste0(
			htmlEventListener,
			GS,
			path,
			GS,
			if (sr) "1" else "0",
			GS,
			as.character(rt),
			GS,
			out_val
		  )
		)
	  }
	},

	set_front_event = function(
	  inputPlace,
	  htmlEvent,
	  modulePath,
	  args = NULL,
	  outputPlace = NULL
	) {
	  args_join <- ""

	  if (!is.null(args)) {
		args_join <- if (length(args) > 0) {
		  paste0(GS, "[", paste(args, collapse = US))
		} else {
		  ""
		}
	  }

	  out_val <- if (is.null(outputPlace)) "" else outputPlace

	  self$add(
		paste0("Ej", inputPlace),
		paste0(
		  htmlEvent,
		  GS,
		  modulePath,
		  GS,
		  out_val,
		  args_join
		)
	  )
	},

	set_front_event_listener = function(
	  inputPlace,
	  htmlEventListener,
	  modulePath,
	  args = NULL,
	  outputPlace = NULL
	) {
	  args_join <- ""

	  if (!is.null(args)) {
		args_join <- if (length(args) > 0) {
		  paste0(GS, "[", paste(args, collapse = US))
		} else {
		  ""
		}
	  }

	  out_val <- if (is.null(outputPlace)) "" else outputPlace

	  self$add(
		paste0("EJ", inputPlace),
		paste0(
		  htmlEventListener,
		  GS,
		  modulePath,
		  GS,
		  out_val,
		  args_join
		)
	  )
	},

	set_master_pages_event = function(inputPlace, htmlEvent, outputPlace = NULL) {
	  out_val <- if (is.null(outputPlace)) "" else outputPlace

	  self$add(
		paste0("Eu", inputPlace),
		paste0(htmlEvent, GS, out_val)
	  )
	},

	set_master_pages_event_listener = function(inputPlace, htmlEventListener, outputPlace = NULL) {
	  out_val <- if (is.null(outputPlace)) "" else outputPlace

	  self$add(
		paste0("EU", inputPlace),
		paste0(htmlEventListener, GS, out_val)
	  )
	},

	set_prevent_default_event = function(inputPlace, htmlEvent) {
	  self$add(
		paste0("Ed", inputPlace),
		htmlEvent
	  )
	},

	set_prevent_default_event_listener = function(inputPlace, htmlEventListener) {
	  self$add(
		paste0("ED", inputPlace),
		htmlEventListener
	  )
	},

	set_stop_propagation_event = function(inputPlace, htmlEvent) {
	  self$add(
		paste0("Es", inputPlace),
		htmlEvent
	  )
	},

	set_stop_propagation_event_listener = function(inputPlace, htmlEventListener) {
	  self$add(
		paste0("ES", inputPlace),
		htmlEventListener
	  )
	},

	set_method_event = function(
	  inputPlace,
	  htmlEvent,
	  methodName,
	  args = NULL
	) {
	  args_join <- ""

	  if (!is.null(args)) {
		args_join <- if (length(args) > 0) {
		  paste0(GS, "[", paste(args, collapse = US))
		} else {
		  ""
		}
	  }

	  self$add(
		paste0("Em", inputPlace),
		paste0(
		  htmlEvent,
		  GS,
		  methodName,
		  args_join
		)
	  )
	},

	set_method_event_listener = function(
	  inputPlace,
	  htmlEventListener,
	  methodName,
	  args = NULL
	) {
	  args_join <- ""

	  if (!is.null(args)) {
		args_join <- if (length(args) > 0) {
		  paste0(GS, "[", paste(args, collapse = US))
		} else {
		  ""
		}
	  }

	  self$add(
		paste0("EM", inputPlace),
		paste0(
		  htmlEventListener,
		  GS,
		  methodName,
		  args_join
		)
	  )
	},

	set_module_method_event = function(
	  inputPlace,
	  htmlEvent,
	  methodName,
	  args = NULL
	) {
	  args_join <- ""

	  if (!is.null(args)) {
		args_join <- if (length(args) > 0) {
		  paste0(GS, "[", paste(args, collapse = US))
		} else {
		  ""
		}
	  }

	  self$add(
		paste0("Ex", inputPlace),
		paste0(
		  htmlEvent,
		  GS,
		  methodName,
		  args_join
		)
	  )
	},

	set_module_method_event_listener = function(
	  inputPlace,
	  htmlEventListener,
	  methodName,
	  args = NULL
	) {
	  args_join <- ""

	  if (!is.null(args)) {
		args_join <- if (length(args) > 0) {
		  paste0(GS, "[", paste(args, collapse = US))
		} else {
		  ""
		}
	  }

	  self$add(
		paste0("EX", inputPlace),
		paste0(
		  htmlEventListener,
		  GS,
		  methodName,
		  args_join
		)
	  )
	},

	assign_confirm_event = function(
	  inputPlace,
	  htmlEvent,
	  text = "Are you sure you want to proceed?",
	  type = "none",
	  title = "Confirm",
	  okText = "OK",
	  cancelText = "Cancel"
	) {
	  text_val <- if (text == "Are you sure you want to proceed?") "" else text
	  type_val <- if (type == "none") "" else type
	  title_val <- if (title == "Confirm") "" else title
	  ok_val <- if (okText == "OK") "" else okText
	  cancel_val <- if (cancelText == "Cancel") "" else cancelText

	  self$add(
		paste0("Ef", inputPlace),
		paste0(
		  htmlEvent,
		  GS,
		  text_val,
		  GS,
		  type_val,
		  GS,
		  title_val,
		  GS,
		  ok_val,
		  GS,
		  cancel_val
		)
	  )
	},
    remove_post_event = function(inputPlace, htmlEvent) self$add(paste0("Rp", inputPlace), htmlEvent),
    remove_post_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RP", inputPlace), htmlEventListener),
    remove_get_event = function(inputPlace, htmlEvent) self$add(paste0("Rg", inputPlace), htmlEvent),
    remove_get_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RG", inputPlace), htmlEventListener),
    remove_put_event = function(inputPlace, htmlEvent) self$add(paste0("Rt", inputPlace), htmlEvent),
    remove_put_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RT", inputPlace), htmlEventListener),
    remove_patch_event = function(inputPlace, htmlEvent) self$add(paste0("Ra", inputPlace), htmlEvent),
    remove_patch_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RA", inputPlace), htmlEventListener),
    remove_delete_event = function(inputPlace, htmlEvent) self$add(paste0("Rl", inputPlace), htmlEvent),
    remove_delete_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RL", inputPlace), htmlEventListener),
    remove_options_event = function(inputPlace, htmlEvent) self$add(paste0("Ro", inputPlace), htmlEvent),
    remove_options_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RO", inputPlace), htmlEventListener),
    remove_head_event = function(inputPlace, htmlEvent) self$add(paste0("Rh", inputPlace), htmlEvent),
    remove_head_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RH", inputPlace), htmlEventListener),
    remove_send_event = function(inputPlace, htmlEvent) self$add(paste0("Rn", inputPlace), htmlEvent),
    remove_send_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RN", inputPlace), htmlEventListener),
    remove_comment_event = function(inputPlace, htmlEvent) self$add(paste0("Rb", inputPlace), htmlEvent),
    remove_comment_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RB", inputPlace), htmlEventListener),
    remove_wasm_event = function(inputPlace, htmlEvent) self$add(paste0("Ry", inputPlace), htmlEvent),
    remove_wasm_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RY", inputPlace), htmlEventListener),
    remove_web_socket_event = function(inputPlace, htmlEvent) self$add(paste0("Rw", inputPlace), htmlEvent),
    remove_web_socket_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RW", inputPlace), htmlEventListener),
    remove_sse_event = function(inputPlace, htmlEvent) self$add(paste0("Re", inputPlace), htmlEvent),
    remove_sse_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RE", inputPlace), htmlEventListener),
    remove_front_event = function(inputPlace, htmlEvent) self$add(paste0("Rj", inputPlace), htmlEvent),
    remove_front_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RJ", inputPlace), htmlEventListener),
    remove_prevent_default_event = function(inputPlace, htmlEvent) self$add(paste0("Rd", inputPlace), htmlEvent),
    remove_prevent_default_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RD", inputPlace), htmlEventListener),
    remove_master_pages_event = function(inputPlace, htmlEvent) self$add(paste0("Ru", inputPlace), htmlEvent),
    remove_master_pages_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RU", inputPlace), htmlEventListener),
    remove_stop_propagation_event = function(inputPlace, htmlEvent) self$add(paste0("Rs", inputPlace), htmlEvent),
    remove_stop_propagation_event_listener = function(inputPlace, htmlEventListener) self$add(paste0("RS", inputPlace), htmlEventListener),
    remove_method_event = function(inputPlace, htmlEvent, methodName) self$add(paste0("Rm", inputPlace), paste0(htmlEvent, GS, methodName)),
    remove_method_event_listener = function(inputPlace, htmlEventListener, methodName) self$add(paste0("RM", inputPlace), paste0(htmlEventListener, GS, methodName)),
    remove_module_method_event = function(inputPlace, htmlEvent, methodName) self$add(paste0("Rx", inputPlace), paste0(htmlEvent, GS, methodName)),
    remove_module_method_event_listener = function(inputPlace, htmlEventListener, methodName) self$add(paste0("RX", inputPlace), paste0(htmlEventListener, GS, methodName)),
    remove_confirm_event = function(inputPlace, htmlEvent) self$add(paste0("Rf", inputPlace), htmlEvent),

    # Custom Event
    # This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
    # Watch: attribute, style, text, children, value
    # Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
    # Range: Only Use For Compare With inrange Value. Split By Comma ","
    # Key: Only Use For Watch With attribute And style Value
    create_custom_dom_event = function(inputPlace, eventName, watch, key, compare, value, range, immediate = FALSE, delay = "0") {
      delay_str <- if (is.numeric(delay)) as.character(delay) else delay
      self$add(paste0("eC", inputPlace), paste0(eventName, GS, watch, GS, key, GS, compare, GS, value, GS, range, GS, if (immediate) "1" else "0", GS, delay_str))
    },
    enable_scroll_bottom_event = function(enable = TRUE) {
      self$add("eb", if (enable) "1" else "0")
    },
    enable_reached_element_event = function(inputPlace, once, enable = TRUE) {
      self$add(paste0("er", inputPlace), paste0(if (once) "1" else "0", GS, if (enable) "1" else "0"))
    },

    # Module
    load_module = function(modulePath, methods = NULL) {
      if (is.null(methods)) methods <- character(0)
      methods_part <- if (length(methods) > 0) paste0(GS, "[", paste(methods, collapse = US)) else ""
      self$add("Ml", paste0(modulePath, methods_part))
    },
    unload_module = function(modulePath) self$add("Mu", modulePath),
    delete_module_method = function(methodName) self$add("Md", methodName),

    # Unit Testing
    # InputPlace Is Actual, Expected Is Tag/OutputPlace
    assert_equal = function(inputPlace, tag) {
      self$add(paste0("At", inputPlace), gsub("\n", "$[ln];", tag, fixed = TRUE))
    },
    assert_equal_by_output_place = function(inputPlace, outputPlace) {
      self$add(paste0("Ao", inputPlace), outputPlace)
    },

    # Debug
    create_debugger = function(pause = FALSE) {
      self$add("Dc", if (pause) "1" else "0")
    },

    # Service Worker
    # To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
    service_worker_register = function(path = NULL, scopePath = NULL) {
      p <- if (is.null(path)) "" else path
      sp <- if (is.null(scopePath)) "" else scopePath
      self$add("wR", paste0(p, GS, sp))
    },
    service_worker_pre_cache_static = function(pathList) {
      self$add("wp", paste(pathList, collapse = GS))
    },
    service_worker_dynamic_cache = function(path, seconds = "") {
      sec_str <- if (is.numeric(seconds)) (if (seconds > 0) as.character(seconds) else "") else seconds
      sec_part <- if (nchar(sec_str) > 0) paste0(GS, sec_str) else ""
      self$add("wc", paste0(path, sec_part))
    },
    service_worker_delete_dynamic_cache = function(path = NULL) {
      if (is.null(path)) {
        self$add("wd")
      } else {
        self$add("wd", path)
      }
    },
    service_worker_dynamic_cache_ttl_update = function(path, seconds = "") {
      sec_str <- if (is.numeric(seconds)) (if (seconds > 0) as.character(seconds) else "") else seconds
      sec_part <- if (nchar(sec_str) > 0) paste0(GS, sec_str) else ""
      self$add("wt", paste0(path, sec_part))
    },
    # Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
    # Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
    # CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
    service_worker_route_set = function(path, type, cacheDynamic = FALSE) {
      cd_val <- if (cacheDynamic) paste0(GS, "1") else ""
      self$add("wr", paste0(path, GS, type, cd_val))
    },
    service_worker_route_alias = function(path, to) {
      self$add("wa", paste0(path, GS, to))
    },
    service_worker_delete_route_alias = function(path = NULL) {
      if (is.null(path)) {
        self$add("wC")
      } else {
        self$add("wC", path)
      }
    },
    # Delete All Route And Alias
    service_worker_delete_route = function(path = NULL) {
      if (is.null(path)) {
        self$add("wD")
      } else {
        self$add("wD", path)
      }
    },

    # SSE
    disconnect_sse = function(path = NULL) {
      if (is.null(path)) {
        self$add("Ds")
      } else {
        self$add("Ds", path)
      }
    },
    disconnect_all_sse = function() {
      self$add("Ds")
    },

    # State
    add_state = function(path = NULL, title = NULL) {
      p <- if (is.null(path)) "" else path
      t <- if (is.null(title)) "" else title
      self$add("AS", paste0(p, GS, t))
    },
    save_state = function(path = NULL, title = NULL) {
      p <- if (is.null(path)) "" else path
      t <- if (is.null(title)) "" else title
      self$add("As", paste0(p, GS, t))
    },
    load_state = function(path) {
      self$add("ls", path)
    },
    delete_state = function(path = NULL) {
      if (is.null(path)) {
        self$add("DS")
      } else {
        self$add("DS", path)
      }
    },
    delete_all_state = function() {
      self$add("DS", "*")
    },

    # Cookie
    set_cookie = function(key, value, seconds, path = NULL) {
      sec_str <- if (is.numeric(seconds)) as.character(seconds) else seconds
      path_part <- if (!is.null(path) && nchar(path) > 0) paste0(GS, path) else ""
      self$add("sC", paste0(key, GS, value, GS, sec_str, path_part))
    },

    # Save (Session Cache)
    save_id = function(inputPlace, key = ".") self$add(paste0("@gi", inputPlace), key),
    save_name = function(inputPlace, key = ".") self$add(paste0("@gn", inputPlace), key),
    save_value = function(inputPlace, key = ".") self$add(paste0("@gv", inputPlace), key),
    save_value_length = function(inputPlace, key = ".") self$add(paste0("@ge", inputPlace), key),
    save_class = function(inputPlace, key = ".") self$add(paste0("@gc", inputPlace), key),
    save_style = function(inputPlace, key = ".") self$add(paste0("@gs", inputPlace), key),
    save_title = function(inputPlace, key = ".") self$add(paste0("@gl", inputPlace), key),
    save_label = function(inputPlace, key = ".") self$add(paste0("@gA", inputPlace), key),
    save_text = function(inputPlace, key = ".") self$add(paste0("@gt", inputPlace), key),
    save_outer_text = function(inputPlace, key = ".") self$add(paste0("@go", inputPlace), key),
    save_text_length = function(inputPlace, key = ".") self$add(paste0("@gg", inputPlace), key),
    save_attribute = function(inputPlace, attribute, key = ".") self$add(paste0("@ga", inputPlace), paste0(key, GS, attribute)),
    save_width = function(inputPlace, key = ".") self$add(paste0("@gw", inputPlace), key),
    save_height = function(inputPlace, key = ".") self$add(paste0("@gh", inputPlace), key),
    save_read_only = function(inputPlace, key = ".") self$add(paste0("@gr", inputPlace), key),
    save_selected_index = function(inputPlace, key = ".") self$add(paste0("@gx", inputPlace), key),
    save_text_align = function(inputPlace, key = ".") self$add(paste0("@gT", inputPlace), key),
    save_node_length = function(inputPlace, key = ".") self$add(paste0("@gL", inputPlace), key),
    save_visible = function(inputPlace, key = ".") self$add(paste0("@gV", inputPlace), key),
    save_url = function(url, fetchScript = FALSE, key = ".") {
      fs_val <- if (fetchScript) paste0(GS, "1") else ""
      self$add("@gu", paste0(key, GS, url, fs_val))
    },
    save_index = function(inputPlace, key = ".") self$add(paste0("@gI", inputPlace), key),
    remove_save = function(cacheKey) self$add("rs", cacheKey),
    remove_all_save = function() self$add("rs", "*"),
    # Calling the SetSave Method Causes Action Control Requests Triggered by Events Using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send Event, to be Temporarily Saved on the Active Page, so the Request will not be Sent to the Server Again.
    set_save = function() self$add("cs", "*"),
    add_save_value = function(cacheKey, value) {
      self$add("SA", paste0(cacheKey, GS, gsub("\n", "$[ln];", value, fixed = TRUE)))
    },
    insert_save_value = function(cacheKey, value) {
      self$add("SI", paste0(cacheKey, GS, gsub("\n", "$[ln];", value, fixed = TRUE)))
    },
    append_save_value = function(cacheKey, value) {
      self$add("SP", paste0(cacheKey, GS, gsub("\n", "$[ln];", value, fixed = TRUE)))
    },
    replace_save_value = function(cacheKey, searchValue, value) {
      self$add("SR", paste0(cacheKey, GS, gsub("\n", "$[ln];", value, fixed = TRUE), GS, gsub("\n", "$[ln];", searchValue, fixed = TRUE)))
    },
	
    # Cache
    cache_id = function(inputPlace, key = ".") self$add(paste0("@ci", inputPlace), key),
    cache_name = function(inputPlace, key = ".") self$add(paste0("@cn", inputPlace), key),
    cache_value = function(inputPlace, key = ".") self$add(paste0("@cv", inputPlace), key),
    cache_value_length = function(inputPlace, key = ".") self$add(paste0("@ce", inputPlace), key),
    cache_class = function(inputPlace, key = ".") self$add(paste0("@cc", inputPlace), key),
    cache_style = function(inputPlace, key = ".") self$add(paste0("@cs", inputPlace), key),
    cache_title = function(inputPlace, key = ".") self$add(paste0("@cl", inputPlace), key),
    cache_label = function(inputPlace, key = ".") self$add(paste0("@cA", inputPlace), key),
    cache_text = function(inputPlace, key = ".") self$add(paste0("@ct", inputPlace), key),
    cache_outer_text = function(inputPlace, key = ".") self$add(paste0("@co", inputPlace), key),
    cache_text_length = function(inputPlace, key = ".") self$add(paste0("@cg", inputPlace), key),
    cache_attribute = function(inputPlace, attribute, key = ".") self$add(paste0("@ca", inputPlace), paste0(key, GS, attribute)),
    cache_width = function(inputPlace, key = ".") self$add(paste0("@cw", inputPlace), key),
    cache_height = function(inputPlace, key = ".") self$add(paste0("@ch", inputPlace), key),
    cache_read_only = function(inputPlace, key = ".") self$add(paste0("@cr", inputPlace), key),
    cache_selected_index = function(inputPlace, key = ".") self$add(paste0("@cx", inputPlace), key),
    cache_text_align = function(inputPlace, key = ".") self$add(paste0("@cT", inputPlace), key),
    cache_node_length = function(inputPlace, key = ".") self$add(paste0("@cL", inputPlace), key),
    cache_visible = function(inputPlace, key = ".") self$add(paste0("@cV", inputPlace), key),
    cache_url = function(url, fetchScript = FALSE, key = ".") {
      fs_val <- if (fetchScript) paste0(GS, "1") else ""
      self$add("@cu", paste0(key, GS, url, fs_val))
    },
    cache_index = function(inputPlace, key = ".") self$add(paste0("@cI", inputPlace), key),
    remove_cache = function(cacheKey) self$add("rd", cacheKey),
    remove_all_cache = function() self$add("rd", "*"),
    # Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
    set_cache = function(second = NULL) {
      if (is.null(second)) {
        self$add("cd", "*")
      } else {
        sec_str <- if (is.numeric(second)) as.character(second) else second
        self$add("cd", sec_str)
      }
    },
    add_cache_value = function(cacheKey, value) {
      self$add("CA", paste0(cacheKey, GS, gsub("\n", "$[ln];", value, fixed = TRUE)))
    },
    insert_cache_value = function(cacheKey, value) {
      self$add("CI", paste0(cacheKey, GS, gsub("\n", "$[ln];", value, fixed = TRUE)))
    },
    append_cache_value = function(cacheKey, value) {
      self$add("CP", paste0(cacheKey, GS, gsub("\n", "$[ln];", value, fixed = TRUE)))
    },
    replace_cache_value = function(cacheKey, searchValue, value) {
      self$add("CR", paste0(cacheKey, GS, gsub("\n", "$[ln];", value, fixed = TRUE), GS, gsub("\n", "$[ln];", searchValue, fixed = TRUE)))
    },

    # Call
    load_url = function(inputPlace, url) self$add(paste0("lu", inputPlace), url),
    run_action_controls = function(actionControls, withoutWebFormsSection = TRUE, index = NULL, useCurrentEvent = TRUE) {
      uce_val <- if (useCurrentEvent) "1" else "0"
      wfs_val <- if (withoutWebFormsSection) "1" else "0"
      idx_val <- if (is.null(index)) "" else index
      self$add("lA", paste0(uce_val, GS, wfs_val, GS, idx_val, GS, actionControls))
    },
    call_script = function(scriptText) {
      self$add("_", gsub("\n", "$[ln];", scriptText, fixed = TRUE))
    },
    call_method = function(methodName, args = NULL) {
      argsJoin <- ""
      if (!is.null(args) && length(args) > 0) {
        argsJoin <- paste0(GS, "[", paste(args, collapse = US))
      }
      self$add("lm", paste0(methodName, argsJoin))
    },
    call_module_method = function(methodName, args = NULL) {
      argsJoin <- ""
      if (!is.null(args) && length(args) > 0) {
        argsJoin <- paste0(GS, "[", paste(args, collapse = US))
      }
      self$add("lM", paste0(methodName, argsJoin))
    },
    call_post_back = function(formInputPlace, outputPlace = NULL) {
      out_val <- if (!is.null(outputPlace) && nchar(outputPlace) > 0) paste0(GS, outputPlace) else ""
      self$add("Lp", paste0("1", GS, formInputPlace, out_val))
    },
    call_comment_back = function(index = NULL, inputPlace = NULL, useCurrentEvent = TRUE) {
      idx_str <- if (is.numeric(index)) as.character(index) else index
      uce_val <- if (useCurrentEvent) "1" else "0"
      inp_val <- if (is.null(inputPlace)) "" else inputPlace
      self$add("LC", paste0(uce_val, GS, idx_str, GS, inp_val))
    },
    call_wasm_back = function(wasmLanguage, wasmUrl, methodName, args = NULL, outputPlace = NULL, useCurrentEvent = TRUE) {
      argsJoin <- ""
      if (!is.null(args) && length(args) > 0) {
        argsJoin <- paste0("[", paste(args, collapse = US))
      }
      uce_val <- if (useCurrentEvent) "1" else "0"
      out_val <- if (is.null(outputPlace)) "" else outputPlace
      self$add("Ly", paste0(uce_val, GS, wasmLanguage, GS, wasmUrl, GS, methodName, GS, argsJoin, GS, out_val))
    },
    call_web_socket_back = function(path, useCurrentEvent = TRUE) {
      uce_val <- if (useCurrentEvent) "1" else "0"
      self$add("Lw", paste0(uce_val, GS, path))
    },
    call_sse_back = function(path, outputPlace = NULL, useCurrentEvent = TRUE, shouldReconnect = TRUE, reconnectTryTimeout = "3000") {
      uce_val <- if (useCurrentEvent) "1" else "0"
      sr_val <- if (shouldReconnect) "1" else "0"
      rt_str <- if (is.numeric(reconnectTryTimeout)) as.character(reconnectTryTimeout) else reconnectTryTimeout
      out_val <- if (!is.null(outputPlace) && nchar(outputPlace) > 0) paste0(GS, outputPlace) else ""
      self$add("Ls", paste0(uce_val, GS, path, GS, sr_val, GS, rt_str, out_val))
    },
    call_front = function(modulePath, args = NULL, outputPlace = NULL, useCurrentEvent = TRUE) {
      argsJoin <- ""
      if (!is.null(args) && length(args) > 0) {
        argsJoin <- paste0(GS, "[", paste(args, collapse = US))
      }
      uce_val <- if (useCurrentEvent) "1" else "0"
      out_val <- if (is.null(outputPlace)) "" else outputPlace
      self$add("Lj", paste0(uce_val, GS, modulePath, GS, out_val, argsJoin))
    },
    call_get_back = function(path, outputPlace = NULL, useCurrentEvent = TRUE) {
      uce_val <- if (useCurrentEvent) "1" else "0"
      out_val <- if (!is.null(outputPlace) && nchar(outputPlace) > 0) paste0(GS, outputPlace) else ""
      self$add("Lg", paste0(uce_val, GS, path, out_val))
    },
    call_put_back = function(path, outputPlace = NULL, useCurrentEvent = TRUE) {
      uce_val <- if (useCurrentEvent) "1" else "0"
      out_val <- if (!is.null(outputPlace) && nchar(outputPlace) > 0) paste0(GS, outputPlace) else ""
      self$add("Lt", paste0(uce_val, GS, path, out_val))
    },
    call_patch_back = function(path, outputPlace = NULL, useCurrentEvent = TRUE) {
      uce_val <- if (useCurrentEvent) "1" else "0"
      out_val <- if (!is.null(outputPlace) && nchar(outputPlace) > 0) paste0(GS, outputPlace) else ""
      self$add("LP", paste0(uce_val, GS, path, out_val))
    },
    call_delete_back = function(path, outputPlace = NULL, useCurrentEvent = TRUE) {
      uce_val <- if (useCurrentEvent) "1" else "0"
      out_val <- if (!is.null(outputPlace) && nchar(outputPlace) > 0) paste0(GS, outputPlace) else ""
      self$add("Ld", paste0(uce_val, GS, path, out_val))
    },
    call_head_back = function(path, useCurrentEvent = TRUE) {
      uce_val <- if (useCurrentEvent) "1" else "0"
      self$add("Lh", paste0(uce_val, GS, path))
    },
    call_options_back = function(path, outputPlace = NULL, useCurrentEvent = TRUE) {
      uce_val <- if (useCurrentEvent) "1" else "0"
      out_val <- if (!is.null(outputPlace) && nchar(outputPlace) > 0) paste0(GS, outputPlace) else ""
      self$add("Lo", paste0(uce_val, GS, path, out_val))
    },
    call_send_back = function(path, method, isMultiPart, contentType, data, outputPlace = NULL, useCurrentEvent = TRUE) {
      uce_val <- if (useCurrentEvent) "1" else "0"
      mp_val <- if (isMultiPart) "1" else "0"
      data_proc <- gsub("\n", "$[ln];", data, fixed = TRUE)
      out_val <- if (!is.null(outputPlace) && nchar(outputPlace) > 0) paste0(GS, outputPlace) else ""
      self$add("LS", paste0(uce_val, GS, path, GS, method, GS, mp_val, GS, contentType, GS, data_proc, out_val))
    },

    # Update
    increase = function(inputPlace, value) {
      self$add(paste0("gt", inputPlace), paste0("i", GS, as.character(value)))
    },
    decrease = function(inputPlace, value) {
      self$add(paste0("gt", inputPlace), paste0("i", GS, as.character(value * -1)))
    },
    # If You Don't Use Deep Mode, any Tags Inside the Current Tag Will Simply Be Treated as Strings. Deep Mode Does not Remove Inner Elements.
    replace = function(inputPlace, value, newValue, alsoStartTag = FALSE, deep = TRUE) {
      ast_val <- if (alsoStartTag) "1" else "0"
      deep_val <- if (deep) "1" else "0"
      self$add(paste0("gt", inputPlace), paste0("r", GS, value, GS, newValue, GS, ast_val, GS, deep_val))
    },
    # HTML Converts Attribute Names to Lowercase, so they Need to Be Written in Lowercase.
    replace_start_tag = function(inputPlace, value, newValue) {
      self$add(paste0("gt", inputPlace), paste0("s", GS, value, GS, newValue))
    },

    # Pre Runner
    assign_delay = function(miliSecond, index = -1) {
      currentLine <- self$get_line_by_index(index)
      if (is.null(currentLine) || nchar(currentLine) == 0) {
        return(invisible(NULL))
      }
      parts <- strsplit(currentLine, "=", fixed = TRUE)[[1]]
      newName <- paste0(":", miliSecond, ")", parts[1])
      newValue <- if (length(parts) > 1) parts[2] else ""
      self$update_line_by_index(index, newName, newValue)
      invisible(NULL)
    },
    assign_delay_change = function(miliSecond, index = -1) {
      currentLine <- self$get_line_by_index(index)
      if (is.null(currentLine) || nchar(currentLine) == 0) {
        return(invisible(NULL))
      }
      parts <- strsplit(currentLine, "=", fixed = TRUE)[[1]]
      currentName <- parts[1]
      if (startsWith(currentName, ":") && grepl(")", currentName, fixed = TRUE)) {
        closingBracket <- regexpr(")", currentName, fixed = TRUE)[1]
        currentName <- substr(currentName, closingBracket + 1, nchar(currentName))
      }
      newName <- paste0(":", miliSecond, ")", currentName)
      newValue <- if (length(parts) > 1) parts[2] else ""
      self$update_line_by_index(index, newName, newValue)
      invisible(NULL)
    },
    assign_interval = function(miliSecond, id = NULL, index = -1) {
      currentLine <- self$get_line_by_index(index)
      if (is.null(currentLine) || nchar(currentLine) == 0) {
        return(invisible(NULL))
      }
      parts <- strsplit(currentLine, "=", fixed = TRUE)[[1]]
      id_part <- if (!is.null(id) && nchar(id) > 0) paste0("|", id) else ""
      newName <- paste0("(", miliSecond, id_part, ")", parts[1])
      newValue <- if (length(parts) > 1) parts[2] else ""
      self$update_line_by_index(index, newName, newValue)
      invisible(NULL)
    },
    assign_interval_change = function(miliSecond, id = NULL, index = -1) {
      currentLine <- self$get_line_by_index(index)
      if (is.null(currentLine) || nchar(currentLine) == 0) {
        return(invisible(NULL))
      }
      parts <- strsplit(currentLine, "=", fixed = TRUE)[[1]]
      currentName <- parts[1]
      if (startsWith(currentName, "(") && grepl(")", currentName, fixed = TRUE)) {
        closingBracket <- regexpr(")", currentName, fixed = TRUE)[1]
        currentName <- substr(currentName, closingBracket + 1, nchar(currentName))
      }
      id_part <- if (!is.null(id) && nchar(id) > 0) paste0("|", id) else ""
      newName <- paste0("(", miliSecond, id_part, ")", currentName)
      newValue <- if (length(parts) > 1) parts[2] else ""
      self$update_line_by_index(index, newName, newValue)
      invisible(NULL)
    },
    delete_interval = function(id) {
      self$add("Di", id)
    },
    assign_repeat = function(count, index = -1) {
      currentLine <- self$get_line_by_index(index)
      if (is.null(currentLine) || nchar(currentLine) == 0) {
        return(invisible(NULL))
      }
      parts <- strsplit(currentLine, "=", fixed = TRUE)[[1]]
      newName <- paste0(",", count, ")", parts[1])
      newValue <- if (length(parts) > 1) parts[2] else ""
      self$update_line_by_index(index, newName, newValue)
      invisible(NULL)
    },
    assign_repeat_change = function(count, index = -1) {
      currentLine <- self$get_line_by_index(index)
      if (is.null(currentLine) || nchar(currentLine) == 0) {
        return(invisible(NULL))
      }
      parts <- strsplit(currentLine, "=", fixed = TRUE)[[1]]
      currentName <- parts[1]
      if (startsWith(currentName, ",") && grepl(")", currentName, fixed = TRUE)) {
        closingBracket <- regexpr(")", currentName, fixed = TRUE)[1]
        currentName <- substr(currentName, closingBracket + 1, nchar(currentName))
      }
      newName <- paste0(",", count, ")", currentName)
      newValue <- if (length(parts) > 1) parts[2] else ""
      self$update_line_by_index(index, newName, newValue)
      invisible(NULL)
    },

    # Index
    start_index = function(name = "") {
      self$add("#", name)
    },
    # This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
    start_state = function() {
      self$start_index("$")
    },
	go_to = function(line_or_index, repeat_count = 1) {
	  if (is.numeric(line_or_index)) {
		self$add(
		  "&",
		  paste0(
			as.character(line_or_index),
			GS,
			as.character(repeat_count)
		  )
		)
	  } else {
		if (is.numeric(repeat_count)) {
		  self$add(
			"&",
			paste0(
			  "#",
			  line_or_index,
			  GS,
			  as.character(repeat_count)
			)
		  )
		} else {
		  self$add(
			"&",
			paste0(
			  line_or_index,
			  GS,
			  repeat_count
			)
		  )
		}
	  }
	},
    
    # Start
    start_transient_dom = function(inputPlace) {
      self$add("td", inputPlace)
    },
    end_transient_dom = function() {
      self$add("td", ";")
    },

    # Message
    # Type: warning, problem, help, success, none
    alert = function(text, type = "none", title = "Alert", okText = "OK") {
      typ <- if (type == "none") "" else type
      tit <- if (title == "Alert") "" else title
      ok <- if (okText == "OK") "" else okText
      self$add("Al", paste0(text, GS, typ, GS, tit, GS, ok))
    },
	message = function(text, type_or_duration = "none", duration = "0") {
	  if (is.numeric(type_or_duration)) {
		# Message(string Text, int Duration)
		self$add(
		  "me",
		  paste0(
			text,
			GS,
			"",
			GS,
			as.character(type_or_duration)
		  )
		)
	  } else if (is.numeric(duration)) {
		# Message(string Text, string Type, int Duration)
		type_val <- if (type_or_duration == "none") "" else type_or_duration

		self$add(
		  "me",
		  paste0(
			text,
			GS,
			type_val,
			GS,
			as.character(duration)
		  )
		)
	  } else {
		# Message(string Text, string Type = "none", string Duration = "0")
		type_val <- if (type_or_duration == "none") "" else type_or_duration
		duration_val <- if (duration == "0") "" else as.character(duration)

		self$add(
		  "me",
		  paste0(
			text,
			GS,
			type_val,
			GS,
			duration_val
		  )
		)
	  }
	},

    # Type: log, info, warn, error, debug, trace, group, groupend, table
    console_message = function(text, type = "log") {
      typ <- if (type == "log") "" else paste0(GS, type)
      self$add("mc", paste0(gsub("\n", "$[ln];", text, fixed = TRUE), typ))
    },
    console_message_assert = function(text, condition) {
      self$add("ma", paste0(gsub("\n", "$[ln];", text, fixed = TRUE), GS, condition))
    },

    # Enable
    # Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
    enable_web_socket = function(enable = TRUE) {
      self$add("ew", if (enable) "1" else "0")
    },
    enable_web_socket_once = function() {
      self$add("ew", "$")
    },
    add_web_socket = function(path) {
      self$add(paste0("aw", path))
    },
    # Disconnected WebSocket
    delete_web_socket = function(path) {
      self$add(paste0("dw", path))
    },

    # Use
    # InputPlace Using Only For form Element
    use_web_socket = function(inputPlace) {
      self$add(paste0("uw", inputPlace))
    },
    use_only_change_update = function(inputPlace) {
      self$add(paste0("uo", inputPlace))
    },

    # Condition And Loop
    # Condition And Loop Supports Brackets and Then
    # Type: warning, problem, help, success, none
    # Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
    # Nested Conditions and Nested Loops are Possible.
    confirm_is_true_accept = function(text = "Are you sure you want to proceed?", type = "none", title = "Confirm", okText = "OK", cancelText = "Cancel", interval = 100) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      txt <- if (text == "Are you sure you want to proceed?") "" else text
      typ <- if (type == "none") "" else type
      tit <- if (title == "Confirm") "" else title
      ok <- if (okText == "OK") "" else okText
      cancel <- if (cancelText == "Cancel") "" else cancelText
      self$add(paste0(prefix, "ct"), paste0(txt, GS, typ, GS, tit, GS, ok, GS, cancel))
      return(self)
    },
    confirm_is_false_accept = function(text = "Are you sure you want to proceed?", type = "none", title = "Confirm", okText = "OK", cancelText = "Cancel", interval = 100) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      txt <- if (text == "Are you sure you want to proceed?") "" else text
      typ <- if (type == "none") "" else type
      tit <- if (title == "Confirm") "" else title
      ok <- if (okText == "OK") "" else okText
      cancel <- if (cancelText == "Cancel") "" else cancelText
      self$add(paste0(prefix, "cf"), paste0(txt, GS, typ, GS, tit, GS, ok, GS, cancel))
      return(self)
    },
    is_greater_than = function(firstValue, secondValue, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "gt"), paste0(firstValue, GS, secondValue))
      return(self)
    },
    is_less_than = function(firstValue, secondValue, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "lt"), paste0(firstValue, GS, secondValue))
      return(self)
    },
    is_equal_to = function(firstValue, secondValue, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "et"), paste0(firstValue, GS, secondValue))
      return(self)
    },
    is_not_equal_to = function(firstValue, secondValue, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "Nt"), paste0(firstValue, GS, secondValue))
      return(self)
    },
    exist = function(value, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "ex"), value)
      return(self)
    },
    not_exist = function(value, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "nx"), value)
      return(self)
    },
    is_true = function(value, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "tr"), value)
      return(self)
    },
    is_false = function(value, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "fa"), value)
      return(self)
    },
    is_match_media = function(value, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "mm"), value)
      return(self)
    },
    is_not_match_media = function(value, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "nm"), value)
      return(self)
    },
    include = function(text, value, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "In"), paste0(value, GS, text))
      return(self)
    },
    not_include = function(text, value, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "Nn"), paste0(value, GS, text))
      return(self)
    },
    element_exists = function(inputPlace, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "eE"), inputPlace)
      return(self)
    },
    element_not_exists = function(inputPlace, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "nE"), inputPlace)
      return(self)
    },
    is_regex_match = function(value, pattern, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "re"), paste0(value, GS, pattern))
      return(self)
    },
    is_regex_not_match = function(value, pattern, interval = -1) {
      prefix <- if (interval >= 0) paste0("{(", interval, ")") else "{"
      self$add(paste0(prefix, "rn"), paste0(value, GS, pattern))
      return(self)
    },
    # In: Everything Becomes A JSON List.
    # Key: Creates A Temporary Data In The Browser IndexedDB.
    # Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
    for_each = function(path, in_val, key = ".") {
      self$add("{fe", paste0(path, GS, in_val, GS, key))
      return(self)
    },
    break_ = function() {
      self$add(";")
    },
    else_ = function() {
      self$add("}e")
      return(self)
    },
    start_bracket = function() {
      self$add("{")
    },
    end_bracket = function() {
      self$add("}")
    },
    # Used Then In Condition And Loop Methods
	then = function(newForm_or_configure) {
	  if (is.function(newForm_or_configure)) {
		newForm <- WebForms$new()
		newForm_or_configure(newForm)
	  } else {
		newForm <- newForm_or_configure
	  }

	  if (!is.null(newForm)) {
		data <- newForm$get_web_forms_data()

		if (!is.null(data) && nchar(data) > 0) {
		  if (grepl("\n", data, fixed = TRUE)) {
			newForm$add_to_up("{")
			newForm$add("}")
		  }
		}

		self$append_form(newForm)
	  }

	  return(self)
	},

	repeat_ = function(newForm_or_configure, repeat_count, index = NULL) {
	  if (is.function(newForm_or_configure)) {
		newForm <- WebForms$new()
		newForm_or_configure(newForm)
	  } else {
		newForm <- newForm_or_configure
	  }

	  if (is.null(newForm)) {
		return(self)
	  }

	  if (missing(index)) {
		return(self$repeat_impl(newForm, repeat_count))
	  }

	  return(self$repeat_impl_with_index(newForm, repeat_count, index))
	},

	repeat_impl = function(newForm, repeat_count) {
	  bodyData <- newForm$get_web_forms_data()

	  if (is.null(bodyData) || nchar(bodyData) == 0) {
		return(self)
	  }

	  startLine <- length(
		strsplit(bodyData, "\n", fixed = TRUE)[[1]]
	  ) * -1

	  self$append_form(newForm)
	  self$go_to(startLine, repeat_count - 1)

	  return(self)
	},

	repeat_impl_with_index = function(newForm, repeat_count, index) {
	  self$go_to(index)
	  self$start_index(index)

	  bodyData <- newForm$get_web_forms_data()

	  if (is.null(bodyData) || nchar(bodyData) == 0) {
		return(self)
	  }

	  self$append_form(newForm)

	  if (is.null(index) || nchar(index) == 0) {
		indexNumber <- -1

		lines <- strsplit(
		  self$get_web_forms_data(),
		  "\n",
		  fixed = TRUE
		)[[1]]

		for (x in lines) {
		  if (startsWith(x, "#")) {
			indexNumber <- indexNumber + 1
		  }
		}

		self$go_to(
		  as.character(indexNumber),
		  repeat_count - 1
		)
	  } else {
		self$go_to(
		  index,
		  repeat_count - 1
		)
	  }

	  return(self)
	},

    # Async
    # It Supports Brackets and Then
    async = function() {
      self$add("{(a)")
      return(self)
    },
    delay = function(miliSecond) {
      ms_str <- if (is.numeric(miliSecond)) as.character(miliSecond) else miliSecond
      self$add("De", ms_str)
    },

    # Option
    change_option = function(name, value) {
      self$add("co", paste0(name, GS, value))
    },
    reset_option = function(name = NULL) {
      if (is.null(name)) {
        self$add("ro")
      } else {
        self$add("ro", name)
      }
    },

    # Format Storage
    create_format_storage = function(key, data) {
      self$add(".C", paste0(key, GS, data))
    },
    delete_format_storage = function(key) {
      self$add(".D", key)
    },
    add_json = function(key, path, value) {
      self$add(".a", paste0(key, GS, "j", GS, value, GS, path))
    },
    # Name: For Support Attribute, Set Double At Sign (@@) Before Name.
    add_xml = function(key, path, name, value = NULL) {
      val <- if (is.null(value)) "" else value
      self$add(".a", paste0(key, GS, "x", GS, name, GS, val, GS, path))
    },
    add_ini = function(key, path, value, isINILike = FALSE) {
      ini_val <- if (isINILike) "1" else "0"
      self$add(".a", paste0(key, GS, "i", GS, ini_val, GS, value, GS, path))
    },
    add_text_line = function(key, line, text) {
      line_str <- if (is.numeric(line)) as.character(line) else line
      self$add(".a", paste0(key, GS, "t", GS, text, GS, line_str))
    },
    add_variable = function(key, value) {
      self$add(".a", paste0(key, GS, "v", GS, value))
    },
    update_json = function(key, path, value) {
      self$add(".u", paste0(key, GS, "j", GS, value, GS, path))
    },
    update_xml = function(key, path, value) {
      self$add(".u", paste0(key, GS, "x", GS, value, GS, path))
    },
    update_ini = function(key, path, value, isINILike = FALSE) {
      ini_val <- if (isINILike) "1" else "0"
      self$add(".u", paste0(key, GS, "i", GS, ini_val, GS, value, GS, path))
    },
    update_tex_line = function(key, line, text) {
      line_str <- if (is.numeric(line)) as.character(line) else line
      self$add(".u", paste0(key, GS, "t", GS, text, GS, line_str))
    },
    update_variable = function(key, value) {
      self$add(".u", paste0(key, GS, "v", GS, value))
    },
    increase_variable = function(key, value) {
      val_str <- if (is.numeric(value)) as.character(value) else value
      self$add(".i", paste0(key, GS, "v", GS, val_str))
    },
    decrease_variable = function(key, value) {
      self$increase_variable(key, value * -1)
    },
    delete_json = function(key, path) {
      self$add(".d", paste0(key, GS, "j", GS, path))
    },
    delete_xml = function(key, path) {
      self$add(".d", paste0(key, GS, "x", GS, path))
    },
    delete_ini = function(key, path, isINILike = FALSE) {
      ini_val <- if (isINILike) "1" else "0"
      self$add(".d", paste0(key, GS, "i", GS, ini_val, GS, path))
    },
    delete_text_line = function(key, line) {
      line_str <- if (is.numeric(line)) as.character(line) else line
      self$add(".d", paste0(key, GS, "t", GS, line_str))
    },
    delete_variable = function(key) {
      self$add(".d", paste0(key, GS, "v"))
    },

    # Template Engine
    # Pattern Example: {{value}}, ((value)), *value*, $value;
    bind_json_to_template = function(inputPlace, jsonText, path, pattern, alsoStartTag = TRUE) {
      ast_val <- if (alsoStartTag) "1" else "0"
      self$add(paste0("Tj", inputPlace), paste0(jsonText, GS, path, GS, pattern, GS, ast_val))
    },
    # Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
    bind_xml_to_template = function(inputPlace, xmlText, path, pattern, alsoStartTag = TRUE) {
      ast_val <- if (alsoStartTag) "1" else "0"
      self$add(paste0("Tx", inputPlace), paste0(xmlText, GS, path, GS, pattern, GS, ast_val))
    },
    bind_ini_to_template = function(inputPlace, iniText, path, pattern, alsoStartTag = TRUE) {
      ast_val <- if (alsoStartTag) "1" else "0"
      self$add(paste0("Ti", inputPlace), paste0(iniText, GS, path, GS, pattern, GS, ast_val))
    },

    # Inject
    # Need Add @: to First of String
    inject = function(value) {
      return(paste0("$[", value, "];"))
    },

    # Action Control
    replace_action_control = function(searchValue, value, addingToUp = FALSE) {
      if (addingToUp) {
        self$add_to_up("rE", paste0(searchValue, GS, value))
      } else {
        self$add("rE", paste0(searchValue, GS, value))
      }
    },
    assign_replace = function(searchValue, value, index = -1) {
      currentLine <- self$get_line_by_index(index)
      if (is.null(currentLine) || nchar(currentLine) == 0) {
        return(invisible(NULL))
      }
      parts <- strsplit(currentLine, "=", fixed = TRUE)[[1]]
      newName <- paste0(";", searchValue, GS, value, GS, parts[1])
      newValue <- if (length(parts) > 1) parts[2] else ""
      self$update_line_by_index(index, newName, newValue)
      invisible(NULL)
    },

    # Hash And Checksum
    set_hash = function() {
      self$add("SH")
    },
    set_checksum = function() {
      self$add("CS")
    },
    checksum_calculation = function(text) {
      sum_val <- 0
      mod <- 65536
      shift <- 5
      chars <- strsplit(text, "")[[1]]
      for (c in chars) {
        # R doesn't have direct bitwise ops like C#, but we can simulate or use integer arithmetic
        # C#: sum = ((sum << shift) | (sum >> (16 - shift))) ^ c;
        # In R, we can use bitwShiftL, bitwShiftR, bitwOr, bitwXor
        sum_val <- bitwOr(bitwShiftL(sum_val, shift), bitwShiftR(sum_val, 16 - shift))
        sum_val <- bitwXor(sum_val, utf8ToInt(c))
        sum_val <- sum_val %% mod
      }
      return(as.character(sum_val))
    },
    get_checksum = function() {
      return(self$checksum_calculation(self$get_web_forms_data()))
    },

    # Get
    get_forms_action_data = function() {
      if (nchar(private$webFormsData) == 0) {
        return("")
      }
      return(private$webFormsData)
    },
    response = function() {
      return(paste0("[web-forms]\n", self$get_forms_action_data()))
    },
    get_forms_action_data_line_break = function() {
      if (nchar(private$webFormsData) == 0) {
        return("")
      }
      data <- private$webFormsData
      processedData <- gsub("\"", "$[dq];", data, fixed = TRUE)
      return(gsub("\n", "$[sln];", processedData, fixed = TRUE))
    },

    # Export
    export_to_html_comment = function(addLine = FALSE) {
      response <- self$response()
      response <- gsub("--", "$[dd];", response, fixed = TRUE)
      if (endsWith(response, "-")) {
        response <- paste0(substr(response, 1, nchar(response) - 1), "$[da];")
      }
      line_prefix <- if (addLine) "\n" else ""
      return(paste0(line_prefix, "<!--", response, "-->"))
    },

    # Using it for SSE Response
    export_to_line_break = function(src = NULL) {
      return(paste0("[web-forms]$[sln];", self$get_forms_action_data_line_break()))
    },

    get_web_forms_data = function() {
      return(private$webFormsData)
    },

    append_form = function(form) {
      if (is.null(form)) {
        return(invisible(NULL))
      }
      otherData <- form$get_web_forms_data()
      if (!is.null(otherData) && nchar(otherData) > 0) {
        if (nchar(private$webFormsData) > 0) {
          private$webFormsData <- paste0(private$webFormsData, "\n")
        }
        private$webFormsData <- paste0(private$webFormsData, otherData)
      }
      invisible(NULL)
    },

    clean = function() {
      private$webFormsData <- ""
      invisible(NULL)
    }
  )
)

# Security
Security <- R6::R6Class("Security",
  public = list(
    safe_value = function(value) {
      if (nchar(value) < 1) {
        return(value)
      }
      if (startsWith(value, "@")) {
        value <- paste0("@", value)
      }
      value <- gsub("\n", "$[ln];", value, fixed = TRUE)
      value <- gsub(",@", "$[co];@", value, fixed = TRUE)
      value <- gsub(intToUtf8(28), "", value, fixed = TRUE)
      value <- gsub(intToUtf8(29), "", value, fixed = TRUE)
      value <- gsub(intToUtf8(30), "", value, fixed = TRUE)
      value <- gsub(intToUtf8(31), "", value, fixed = TRUE)
      return(value)
    }
  )
)

# WebForms Place Criteria (WPC) DSL
InputPlace <- list(
  Document = ",",
  Window = "`",
  # When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
  Root = "~",
  HTML = ".",
  Head = "^",
  ScreenOrientation = "%",
  All = "*",
  Parent = "/",
  Current = "$",
  Target = "!",
  Upper = "-",
  
  Id = function(id) id,
  Name = function(name, index = NULL) {
    if (is.null(index)) {
      return(paste0("(", name, ")"))
    } else {
      return(paste0("(", name, ")", index))
    }
  },
  AllNames = function(name) paste0("(", name, ")*"),
  Tag = function(tag, index = NULL) {
    if (is.null(index)) {
      return(paste0("<", tag, ">"))
    } else {
      return(paste0("<", tag, ">", index))
    }
  },
  AllTags = function(tag) paste0("<", tag, ">*"),
  Child = function(index = NULL) {
    if (is.null(index)) {
      return("<>")
    } else {
      return(paste0("<>", index))
    }
  },
  AllChild = function() "<>*",
  Class = function(class_name, index = NULL) {
    if (is.null(index)) {
      return(paste0("{", class_name, "}"))
    } else {
      return(paste0("{", class_name, "}", index))
    }
  },
  AllClasses = function(class_name) paste0("{", class_name, "}*"),
  Attribute = function(name, value = NULL, index = NULL, operator = NUL) {
    if (is.null(value)) {
      if (is.null(index)) {
        return(paste0('"', name, '"'))
      } else {
        return(paste0('"', name, '"', index))
      }
    } else {
      op_str <- if (operator != NUL) operator else ""
      base_str <- paste0('"', name, op_str, "'", value, '"')
      if (is.null(index)) {
        return(base_str)
      } else {
        return(paste0(base_str, index))
      }
    }
  },
  AllAttributes = function(name, value = NULL, operator = NUL) {
    if (is.null(value)) {
      return(paste0('"', name, '"*'))
    } else {
      op_str <- if (operator != NUL) operator else ""
      return(paste0('"', name, op_str, "'", value, '"*'))
    }
  },
  Query = function(query) {
    q <- gsub("=", "$[eq];", query, fixed = TRUE)
    q <- gsub("|", "$[vb];", q, fixed = TRUE)
    q <- gsub("?", "$[qu];", q, fixed = TRUE)
    return(paste0("*", q))
  },
  QueryAll = function(query) {
    q <- gsub("=", "$[eq];", query, fixed = TRUE)
    q <- gsub("|", "$[vb];", q, fixed = TRUE)
    q <- gsub("?", "$[qu];", q, fixed = TRUE)
    return(paste0("[", q))
  }
)

OutputPlace <- InputPlace

# Do not Add any Data Before or After it
RS <- intToUtf8(30)

Fetch <- list(
  # Method
  Random = function(maxValue, minValue = NULL) {
    if (is.null(minValue)) {
      return(paste0("@mr", maxValue))
    } else {
      return(paste0("@mr", maxValue, RS, minValue))
    }
  },
  SpaceToChar = function(text, character = "-") {
    paste0("@sc", character, RS, text)
  },
  EncodeURI = function(text) paste0("@ue", text),
  DecodeURI = function(text) paste0("@ud", text),
  
  Method = function(methodName, args = NULL) {
    returnValue <- paste0("@cm", methodName)
    if (!is.null(args) && length(args) > 0) {
      returnValue <- paste0(returnValue, RS, paste(args, collapse = US))
    }
    return(returnValue)
  },
  
  ModuleMethod = function(methodName, args = NULL) {
    returnValue <- paste0("@cM", methodName)
    if (!is.null(args) && length(args) > 0) {
      returnValue <- paste0(returnValue, RS, paste(args, collapse = US))
    }
    return(returnValue)
  },
  
  # MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
  WasmMethod = function(wasmLanguage, wasmUrl, methodName, args = NULL, key = ".") {
    returnValue <- paste0("@wA", wasmLanguage, RS, wasmUrl, RS, methodName)
    if (!is.null(args) && length(args) > 0) {
      returnValue <- paste0(returnValue, RS, paste(args, collapse = US))
    }
    return(returnValue)
  },
  
  Script = function(scriptText) paste0("@_", gsub("\n", "$[ln];", scriptText, fixed = TRUE)),
  LoadUrl = function(url, fetchScript = FALSE) paste0("@lu", url, if (fetchScript) paste0(RS, "1") else ""),
  LoadHtml = function(url, fetchInputPlace = "", fetchScript = FALSE) {
    paste0("@lh", url, RS, if (fetchScript) "1" else "0", if (nchar(fetchInputPlace) > 0) paste0(RS, fetchInputPlace) else "")
  },
  LoadLine = function(url, line) paste0("@ll", url, RS, as.character(line)),
  LoadINI = function(url, name, isINILike = FALSE) paste0("@li", url, RS, name, if (isINILike) paste0(RS, "1") else ""),
  # Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
  LoadJSON = function(url, name) paste0("@lj", url, RS, name),
  # Name: Name Or XPath; XPath Index Starts At 1
  LoadXML = function(url, name) paste0("@lx", url, RS, name),
  # MethodName: It's Check Function Or Variable
  HasMethod = function(methodName) paste0("@hm", methodName),
  HasModuleMethod = function(methodName) paste0("@hM", methodName),
  # This Method Return True Or False If Key Pressed
  # Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
  GetModifierState = function(modifier) paste0("@ms", modifier),
  
  # Math
  Math = function(methodName, args = NULL) {
    returnValue <- paste0("@M#", methodName)
    if (!is.null(args) && length(args) > 0) {
      returnValue <- paste0(returnValue, RS, paste(args, collapse = US))
    }
    return(returnValue)
  },
  
  # Data
  DateYear = "@dy",
  # Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1 
  DateMonth = "@dm",
  DateDay = "@dd",
  DateDate = "@dD",
  DateHours = "@dh",
  DateMinutes = "@di",
  DateSeconds = "@ds",
  DateMilliseconds = "@dl",
  
  # String
  Space = "@sp",
  AtSign = "@sa",
  
  # Tag
  GetId = function(inputPlace) paste0("@$i", inputPlace),
  GetName = function(inputPlace) paste0("@$n", inputPlace),
  GetValue = function(inputPlace) paste0("@$v", inputPlace),
  GetValueLength = function(inputPlace) paste0("@$e", inputPlace),
  GetClass = function(inputPlace) paste0("@$c", inputPlace),
  GetStyle = function(inputPlace) paste0("@$s", inputPlace),
  GetTitle = function(inputPlace) paste0("@$l", inputPlace),
  GetLabel = function(inputPlace) paste0("@$A", inputPlace),
  GetText = function(inputPlace) paste0("@$t", inputPlace),
  GetOuterText = function(inputPlace) paste0("@$o", inputPlace),
  GetTextLength = function(inputPlace) paste0("@$g", inputPlace),
  GetAttribute = function(inputPlace, attribute) paste0("@$a", inputPlace, RS, attribute),
  GetWidth = function(inputPlace) paste0("@$w", inputPlace),
  GetHeight = function(inputPlace) paste0("@$h", inputPlace),
  GetIsReadOnly = function(inputPlace) paste0("@$r", inputPlace),
  GetSelectedIndex = function(inputPlace) paste0("@$x", inputPlace),
  GetIndex = function(inputPlace) paste0("@$I", inputPlace),
  GetTextAlign = function(inputPlace) paste0("@$T", inputPlace),
  GetNodeLength = function(inputPlace) paste0("@$L", inputPlace),
  GetIsVisible = function(inputPlace) paste0("@$V", inputPlace),
  
  # Save
  HasHash = function(hash) paste0("@HH", hash),
  Cookie = function(key) paste0("@co", key),
  Save = function(key = ".", replaceValue = NULL) {
    if (is.null(replaceValue)) {
      paste0("@cs", key)
    } else {
      paste0("@cs", key, RS, replaceValue)
    }
  },
  SaveThenRemove = function(key) paste0("@cl", key),
  SaveLength = function(key = ".") paste0("@cg", key),
  Cache = function(key = ".", replaceValue = NULL) {
    if (is.null(replaceValue)) {
      paste0("@cd", key)
    } else {
      paste0("@cd", key, RS, replaceValue)
    }
  },
  CacheThenRemove = function(key) paste0("@ct", key),
  CacheLength = function(key = ".") paste0("@cG", key),
  SaveLine = function(key = ".", line = 0) paste0("@lL", key, "[", line),
  SaveLineConsume = function(key = ".") paste0("@lL", key),
  # INIKey: Only Direct Key is Supported
  SaveINI = function(key, iniKey) paste0("@lI", key, "[", iniKey),
  CacheLine = function(key = ".", line = 0) paste0("@dL", key, "[", line),
  CacheLineConsume = function(key = ".") paste0("@dL", key),
  # INIKey: Only Direct Key is Supported
  CacheINI = function(key, iniKey) paste0("@dI", key, "[", iniKey),
  
  # Format Storage
  FormatStore = function(key) paste0("@fr", key),
  FormatStoreByXMLQuery = function(key, xPath) paste0("@fx", key, RS, xPath),
  FormatStoreByJSONQuery = function(key, query) paste0("@fj", key, RS, query),
  FormatStoreByINI = function(key, name) paste0("@fi", key, RS, name),
  FormatStoreByText = function(key, line) paste0("@ft", key, RS, as.character(line)),
  FormatStoreByVariable = function(key) paste0("@fv", key),
  
  # State
  HasState = function(path) paste0("@hs", path),
  
  # SSE
  SSEIsConnected = function(path) paste0("@Sc", path),
  
  # WebSockets
  WebSocketsIsConnected = function(path = "") paste0("@Wc", path),
  
  # Document
  TabIsActive = "@da",
  
  # Window
  Href = "@wf",
  PathName = "@wP",
  Query = function(name = "*") paste0("@wq", name),
  Hash = "@wh",
  Host = "@wH",
  HostName = "@wn",
  Port = "@wT",
  Origin = "@wo",
  GetSelection = "@ws",
  ScrollX = "@wx",
  ScrollY = "@wy",
  Segment = function(index) paste0("@wS", index),
  # It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
  HashSegment = function(index) paste0("@wt", index),
  
  # Navigator
  ClipboardText = "@nC",
  GeoLatitude = "@nW",
  GeoLongitude = "@nO",
  Language = "@nL",
  IsOnLine = "@no",
  UserAgent = "@na",
  
  # Screen
  ScreenWidth = "@sw",
  ScreenHeight = "@sh",
  ScreenOrientationType = "@so",
  ScreenOrientationAngle = "@sr",
  
  # Performance
  TimeOrigin = "@pt",
  PerformanceNow = "@pn",
  
  # Event
  Event = "@EV",
  EventSerialize = "@Es",
  EventKey = "@ek",
  EventWhich = "@ew",
  EventClientX = "@ex",
  EventClientY = "@ey",
  EventPageX = "@eX",
  EventPageY = "@eY",
  EventOffsetX = "@Ex",
  EventOffsetY = "@Ey",
  EventDeltaY = "@ed"
)

WasmLanguage <- list(
  # The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
  C = "c",
  CPP = "c",
  Rust = "rust",
  CSharp = "csharp",
  # .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
  CSharpMediator = "csharp-m",
  GO = "go",
  JAVA = "java",
  AssemblyScript = "as"
)

HtmlEvent <- list(
  OnAbort = "onabort",
  OnAfterPrint = "onafterprint",
  OnBeforePrint = "onbeforeprint",
  OnBeforeUnload = "onbeforeunload",
  OnBlur = "onblur",
  OnCanPlay = "oncanplay",
  OnCanPlayThrough = "oncanplaythrough",
  OnChange = "onchange",
  OnClick = "onclick",
  OnCopy = "oncopy",
  OnCut = "oncut",
  OnDoubleClick = "ondblclick",
  OnDrag = "ondrag",
  OnDragEnd = "ondragend",
  OnDragEnter = "ondragenter",
  OnDragLeave = "ondragleave",
  OnDragOver = "ondragover",
  OnDragStart = "ondragstart",
  OnDrop = "ondrop",
  OnDurationChange = "ondurationchange",
  OnEnded = "onended",
  OnError = "onerror",
  OnFocus = "onfocus",
  OnFocusin = "onfocusin",
  OnFocusOut = "onfocusout",
  OnHashChange = "onhashchange",
  OnInput = "oninput",
  OnInvalid = "oninvalid",
  OnKeyDown = "onkeydown",
  OnKeyPress = "onkeypress",
  OnKeyUp = "onkeyup",
  OnLoad = "onload",
  OnLoadedData = "onloadeddata",
  OnLoadedMetaData = "onloadedmetadata",
  OnLoadStart = "onloadstart",
  OnMouseDown = "onmousedown",
  OnMouseEnter = "onmouseenter",
  OnMouseLeave = "onmouseleave",
  OnMouseMove = "onmousemove",
  OnMouseOver = "onmouseover",
  OnMouseOut = "onmouseout",
  OnMouseUp = "onmouseup",
  OnOffline = "onoffline",
  OnOnline = "ononline",
  OnPageHide = "onpagehide",
  OnPageShow = "onpageshow",
  OnPaste = "onpaste",
  OnPause = "onpause",
  OnPlay = "onplay",
  OnPlaying = "onplaying",
  OnProgress = "onprogress",
  OnRateChange = "onratechange",
  OnResize = "onresize",
  OnReset = "onreset",
  OnScroll = "onscroll",
  OnSearch = "onsearch",
  OnSeeked = "onseeked",
  OnSeeking = "onseeking",
  OnSelect = "onselect",
  OnStalled = "onstalled",
  OnSubmit = "onsubmit",
  OnSuspend = "onsuspend",
  OnTimeUpdate = "ontimeupdate",
  OnToggle = "ontoggle",
  OnTouchCancel = "ontouchcancel",
  OnTouchend = "ontouchend",
  OnTouchMove = "ontouchmove",
  OnTouchStart = "ontouchstart",
  OnUnload = "onunload",
  OnVolumeChange = "onvolumechange",
  OnWaiting = "onwaiting",
  OnWheel = "onwheel"
)

HtmlEventListener <- list(
  Abort = "abort",
  AfterPrint = "afterprint",
  BeforePrint = "beforeprint",
  BeforeUnload = "beforeunload",
  Blur = "blur",
  CanPlay = "canplay",
  CanPlayThrough = "canplaythrough",
  Change = "change",
  Click = "click",
  Copy = "copy",
  Cut = "cut",
  DoubleClick = "dblclick",
  Drag = "drag",
  DragEnd = "dragend",
  DragEnter = "dragenter",
  DragLeave = "dragleave",
  DragOver = "dragover",
  DragStart = "dragstart",
  Drop = "drop",
  DurationChange = "durationchange",
  Ended = "ended",
  Error = "error",
  Focus = "focus",
  Focusin = "focusin",
  FocusOut = "focusout",
  HashChange = "hashchange",
  Input = "input",
  Invalid = "invalid",
  KeyDown = "keydown",
  KeyPress = "keypress",
  KeyUp = "keyup",
  Load = "load",
  LoadedData = "loadeddata",
  LoadedMetaData = "loadedmetadata",
  LoadStart = "loadstart",
  MouseDown = "mousedown",
  MouseEnter = "mouseenter",
  MouseLeave = "mouseleave",
  MouseMove = "mousemove",
  MouseOver = "mouseover",
  MouseOut = "mouseout",
  MouseUp = "mouseup",
  Offline = "offline",
  Online = "online",
  PageHide = "pagehide",
  PageShow = "pageshow",
  Paste = "paste",
  Pause = "pause",
  Play = "play",
  Playing = "playing",
  Progress = "progress",
  RateChange = "ratechange",
  Resize = "resize",
  Reset = "reset",
  Scroll = "scroll",
  Search = "search",
  Seeked = "seeked",
  Seeking = "seeking",
  Select = "select",
  Stalled = "stalled",
  Submit = "submit",
  Suspend = "suspend",
  TimeUpdate = "timeupdate",
  Toggle = "toggle",
  TouchCancel = "touchcancel",
  Touchend = "touchend",
  TouchMove = "touchmove",
  TouchStart = "touchstart",
  Unload = "unload",
  VolumeChange = "volumechange",
  Waiting = "waiting",
  Wheel = "wheel",
  
  AnimationEnd = "animationend",
  AnimationIteration = "animationiteration",
  AnimationStart = "animationstart",
  ContextMenu = "contextmenu",
  FullScreenChange = "fullscreenchange",
  FullScreenError = "fullscreenerror",
  PopState = "popstate",
  TransitionEnd = "transitionend",
  Storage = "storage",
  
  # Custom
  ScrollBottom = "scrollbottom", # Need Call EnableScrollBottomEvent Method Before
  ElementReached = "elementreached" # Need Call EnableReachedElementEvent Method Before
)

# ExtensionWebFormsMethods
# In R, extension methods are implemented as standalone functions taking the target object as the first argument.

ext_child <- function(text, value) {
  if (nchar(text) < 1) {
    return(value)
  }
  return(paste0(text, "|", value))
}

ext_parent <- function(text) {
  if (nchar(text) < 1) {
    return(text)
  }
  if (endsWith(text, "|/") || endsWith(text, "//")) {
    return(paste0(text, "/"))
  }
  return(paste0(text, "|/"))
}

ext_criteria <- function(text, value) {
  if (nchar(text) < 1) {
    return(value)
  }
  val_processed <- gsub("|", "$[vb];", value, fixed = TRUE)
  val_processed <- gsub("?", "$[qu];", val_processed, fixed = TRUE)
  return(paste0(text, "?", val_processed))
}

ext_append_fetch_replace <- function(text, searchValue, value) {
  FS <- intToUtf8(28)
  text <- substr(text, 2, nchar(text))
  return(paste0("@;", searchValue, FS, value, FS, text))
}

ext_line_break <- function(text, encodeLine = FALSE) {
  encode <- if (encodeLine) "$[sln];" else ""
  text <- gsub("\r\n", encode, text, fixed = TRUE)
  text <- gsub("\n", encode, text, fixed = TRUE)
  text <- gsub("\r", encode, text, fixed = TRUE)
  return(text)
}

# Converts Numbers to Strings
ext_to_js_string <- function(text) {
  return(paste0('"', text, '"'))
}

# Get JS Object Momentary 
ext_to_js_object <- function(text) {
  return(paste0("$", text))
}

# Get JS Object Returned Value Once
ext_to_js_return_object <- function(text) {
  return(paste0("$@", text))
}
