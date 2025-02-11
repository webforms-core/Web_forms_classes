library(BH)

# Define the WebForms class
WebForms <- function() {
  WebFormsData <- NameValueCollection()
  
  list(
    AddLine = function(Name, Value) {
      WebFormsData$Add(Name, Value)
    },
    AddId = function(InputPlace, Id) {
      WebFormsData$Add(paste0("ai", InputPlace), Id)
    },
    AddName = function(InputPlace, Name) {
      WebFormsData$Add(paste0("an", InputPlace), Name)
    },
    AddValue = function(InputPlace, Value) {
      WebFormsData$Add(paste0("av", InputPlace), Value)
    },
    AddClass = function(InputPlace, Class) {
      WebFormsData$Add(paste0("ac", InputPlace), Class)
    },
    AddStyle = function(InputPlace, Style) {
      WebFormsData$Add(paste0("as", InputPlace), Style)
    },
    AddStyleWithValue = function(InputPlace, Name, Value) {
      WebFormsData$Add(paste0("as", InputPlace), paste0(Name, ":", Value))
    },
    AddOptionTag = function(InputPlace, Text, Value, Selected = FALSE) {
      WebFormsData$Add(paste0("ao", InputPlace), paste0(Value, "|", Text, ifelse(Selected, "|1", "")))
    },
    AddCheckBoxTag = function(InputPlace, Text, Value, Checked = FALSE) {
      WebFormsData$Add(paste0("ak", InputPlace), paste0(Value, "|", Text, ifelse(Checked, "|1", "")))
    },
    AddTitle = function(InputPlace, Title) {
      WebFormsData$Add(paste0("al", InputPlace), Title)
    },
    AddText = function(InputPlace, Text) {
      WebFormsData$Add(paste0("at", InputPlace), gsub("\n", "$[ln];", Text))
    },
    AddTextToUp = function(InputPlace, Text) {
      WebFormsData$Add(paste0("pt", InputPlace), gsub("\n", "$[ln];", Text))
    },
    AddAttribute = function(InputPlace, Attribute, Value = "") {
      WebFormsData$Add(paste0("aa", InputPlace), paste0(Attribute, "|", Value))
    },
    AddTag = function(InputPlace, TagName, Id = "") {
      WebFormsData$Add(paste0("nt", InputPlace), paste0(TagName, ifelse(nchar(Id) > 0, paste0("|", Id), "")))
    },
    AddTagToUp = function(InputPlace, TagName, Id = "") {
      WebFormsData$Add(paste0("ut", InputPlace), paste0(TagName, ifelse(nchar(Id) > 0, paste0("|", Id), "")))
    },
    AddTagBefore = function(InputPlace, TagName, Id = "") {
      WebFormsData$Add(paste0("bt", InputPlace), paste0(TagName, ifelse(nchar(Id) > 0, paste0("|", Id), "")))
    },
    AddTagAfter = function(InputPlace, TagName, Id = "") {
      WebFormsData$Add(paste0("ft", InputPlace), paste0(TagName, ifelse(nchar(Id) > 0, paste0("|", Id), "")))
    },
    SetId = function(InputPlace, Id) {
      WebFormsData$Add(paste0("si", InputPlace), Id)
    },
    SetName = function(InputPlace, Name) {
      WebFormsData$Add(paste0("sn", InputPlace), Name)
    },
    SetValue = function(InputPlace, Value) {
      WebFormsData$Add(paste0("sv", InputPlace), Value)
    },
    SetClass = function(InputPlace, Class) {
      WebFormsData$Add(paste0("sc", InputPlace), Class)
    },
    SetStyle = function(InputPlace, Style) {
      WebFormsData$Add(paste0("ss", InputPlace), Style)
    },
    SetStyleWithValue = function(InputPlace, Name, Value) {
      WebFormsData$Add(paste0("ss", InputPlace), paste0(Name, ":", Value))
    },
    SetOptionTag = function(InputPlace, Text, Value, Selected = FALSE) {
      WebFormsData$Add(paste0("so", InputPlace), paste0(Value, "|", Text, ifelse(Selected, "|1", "")))
    },
    SetChecked = function(InputPlace, Checked = FALSE) {
      WebFormsData$Add(paste0("sk", InputPlace), ifelse(Checked, "1", "0"))
    },
    SetCheckBoxTagToList = function(InputPlace, Text, Value, Checked = FALSE) {
      WebFormsData$Add(paste0("sk", InputPlace), paste0(Value, "|", Text, ifelse(Checked, "|1", "")))
    },
    SetTitle = function(InputPlace, Title) {
      WebFormsData$Add(paste0("sl", InputPlace), Title)
    },
    SetText = function(InputPlace, Text) {
      WebFormsData$Add(paste0("st", InputPlace), gsub("\n", "$[ln];", Text))
    },
    SetAttribute = function(InputPlace, Attribute, Value = "") {
      WebFormsData$Add(paste0("sa", InputPlace), paste0(Attribute, ifelse(nchar(Value) > 0, paste0("|", Value), "")))
    },
    SetWidth = function(InputPlace, Width) {
      WebFormsData$Add(paste0("sw", InputPlace), Width)
    },
    SetWidth = function(InputPlace, Width) {
      SetWidth(InputPlace, paste0(Width, "px"))
    },
    SetHeight = function(InputPlace, Height) {
      WebFormsData$Add(paste0("sh", InputPlace), Height)
    },
    SetHeight = function(InputPlace, Height) {
      SetHeight(InputPlace, paste0(Height, "px"))
    },
    InsertId = function(InputPlace, Id) {
      WebFormsData$Add(paste0("ii", InputPlace), Id)
    },
    InsertName = function(InputPlace, Name) {
      WebFormsData$Add(paste0("in", InputPlace), Name)
    },
    InsertValue = function(InputPlace, Value) {
      WebFormsData$Add(paste0("iv", InputPlace), Value)
    },
    InsertClass = function(InputPlace, Class) {
      WebFormsData$Add(paste0("ic", InputPlace), Class)
    },
    InsertStyle = function(InputPlace, Style) {
      WebFormsData$Add(paste0("is", InputPlace), Style)
    },
    InsertStyle = function(InputPlace, Name, Value) {
      WebFormsData$Add(paste0("is", InputPlace), paste0(Name, ":", Value))
    },
    InsertOptionTag = function(InputPlace, Text, Value, Selected = FALSE) {
      WebFormsData$Add(paste0("io", InputPlace), paste0(Value, "|", Text, ifelse(Selected, "|1", "")))
    },
    InsertCheckBoxTag = function(InputPlace, Text, Value, Checked = FALSE) {
      WebFormsData$Add(paste0("ik", InputPlace), paste0(Value, "|", Text, ifelse(Checked, "|1", "")))
    },
    InsertTitle = function(InputPlace, Title) {
      WebFormsData$Add(paste0("il", InputPlace), Title)
    },
    InsertText = function(InputPlace, Text) {
      WebFormsData$Add(paste0("it", InputPlace), gsub("\n", "$[ln];", Text))
    },
    InsertAttribute = function(InputPlace, Attribute, Value = "") {
      WebFormsData$Add(paste0("ia", InputPlace), paste0(Attribute, ifelse(nchar(Value) > 0, paste0("|", Value), "")))
    },
    DeleteId = function(InputPlace) {
      WebFormsData$Add(paste0("di", InputPlace), "1")
    },
    DeleteName = function(InputPlace) {
      WebFormsData$Add(paste0("dn", InputPlace), "1")
    },
    DeleteValue = function(InputPlace) {
      WebFormsData$Add(paste0("dv", InputPlace), "1")
    },
    DeleteClass = function(InputPlace, ClassName) {
      WebFormsData$Add(paste0("dc", InputPlace), ClassName)
    },
    DeleteStyle = function(InputPlace, StyleName) {
      WebFormsData$Add(paste0("ds", InputPlace), StyleName)
    },
    DeleteOptionTag = function(InputPlace, Value) {
      WebFormsData$Add(paste0("do", InputPlace), Value)
    },
    DeleteAllOptionTag = function(InputPlace) {
      WebFormsData$Add(paste0("do", InputPlace), "*")
    },
    DeleteCheckBoxTag = function(InputPlace, Value) {
      WebFormsData$Add(paste0("dk", InputPlace), Value)
    },
    DeleteAllCheckBoxTag = function(InputPlace) {
      WebFormsData$Add(paste0("dk", InputPlace), "*")
    },
    DeleteTitle = function(InputPlace) {
      WebFormsData$Add(paste0("dl", InputPlace), "1")
    },
    DeleteText = function(InputPlace) {
      WebFormsData$Add(paste0("dt", InputPlace), "1")
    },
    DeleteAttribute = function(InputPlace, Attribute) {
      WebFormsData$Add(paste0("da", InputPlace), Attribute)
    },
    Delete = function(InputPlace) {
      WebFormsData$Add(paste0("de", InputPlace), "1")
    },
    DeleteParent = function(InputPlace) {
      WebFormsData$Add(paste0("dp", InputPlace), "1")
    },
    SetBackgroundColor = function(InputPlace, Color) {
      WebFormsData$Add(paste0("bc", InputPlace), Color)
    },
    SetTextColor = function(InputPlace, Color) {
      WebFormsData$Add(paste0("tc", InputPlace), Color)
    },
    SetFontName = function(InputPlace, Name) {
      WebFormsData$Add(paste0("fn", InputPlace), Name)
    },
    SetFontSize = function(InputPlace, Size) {
      WebFormsData$Add(paste0("fs", InputPlace), Size)
    },
    SetFontSizeString = function(InputPlace, Size) {
      WebFormsData$Add(paste0("fs", InputPlace), paste0(Size, "px"))
    },
    SetFontBold = function(InputPlace, Bold) {
      WebFormsData$Add(paste0("fb", InputPlace), ifelse(Bold, "1", "0"))
    },
    SetVisible = function(InputPlace, Visible) {
      WebFormsData$Add(paste0("vi", InputPlace), ifelse(Visible, "1", "0"))
    },
    SetTextAlign = function(InputPlace, Align) {
      WebFormsData$Add(paste0("ta", InputPlace), Align)
    },
    SetReadOnly = function(InputPlace, ReadOnly) {
      WebFormsData$Add(paste0("sr", InputPlace), ifelse(ReadOnly, "1", "0"))
    },
    SetDisabled = function(InputPlace, Disabled) {
      WebFormsData$Add(paste0("sd", InputPlace), ifelse(Disabled, "1", "0"))
    },
    SetFocus = function(InputPlace, Focus) {
      WebFormsData$Add(paste0("sf", InputPlace), ifelse(Focus, "1", "0"))
    },
    SetMinLength = function(InputPlace, Length) {
      WebFormsData$Add(paste0("mn", InputPlace), as.character(Length))
    },
    SetMaxLength = function(InputPlace, Length) {
      WebFormsData$Add(paste0("mx", InputPlace), as.character(Length))
    },
    SetSelectedValue = function(InputPlace, Value) {
      WebFormsData$Add(paste0("ts", InputPlace), Value)
    },
    SetSelectedIndex = function(InputPlace, Index) {
      WebFormsData$Add(paste0("ti", InputPlace), as.character(Index))
    },
    SetCheckedValue = function(InputPlace, Value, Selected) {
      WebFormsData$Add(paste0("ks", InputPlace), paste0(Value, "|", ifelse(Selected, "1", "0")))
    },
    SetCheckedIndex = function(InputPlace, Index, Selected) {
      WebFormsData$Add(paste0("ki", InputPlace), paste0(as.character(Index), "|", ifelse(Selected, "1", "0")))
    },
    CallScript = function(ScriptText) {
      WebFormsData$Add("_", gsub("\n", "$[ln];", ScriptText))
    },
    LoadUrl = function(InputPlace, Url) {
      WebFormsData$Add(paste0("lu", InputPlace), Url)
    },
    ChangeUrl = function(Url) {
      WebFormsData$Add("cu", Url)
    },
    RemoveSessionCache = function(CacheKey) {
      WebFormsData$Add("rs", CacheKey)
    },
    RemoveAllSessionCache = function() {
      WebFormsData$Add("rs", "*")
    },
    RemoveCache = function(CacheKey) {
      WebFormsData$Add("rd", CacheKey)
    },
    RemoveAllCache = function() {
      WebFormsData$Add("rd", "*")
    },
    SetSessionCache = function() {
      WebFormsData$Add("cs", "1")
    },
    SetCache = function(Second) {
      WebFormsData$Add("cd", as.character(Second))
    },
    SetCache = function() {
      WebFormsData$Add("cd", "*")
    },
    IncreaseMinLength = function(InputPlace, Value) {
      WebFormsData$Add(paste0("+n", InputPlace), as.character(Value))
    },
    IncreaseMaxLength = function(InputPlace, Value) {
      WebFormsData$Add(paste0("+x", InputPlace), as.character(Value))
    },
    IncreaseFontSize = function(InputPlace, Value) {
      WebFormsData$Add(paste0("+f", InputPlace), as.character(Value))
    },
    IncreaseWidth = function(InputPlace, Value) {
      WebFormsData$Add(paste0("+w", InputPlace), as.character(Value))
    },
    IncreaseHeight = function(InputPlace, Value) {
      WebFormsData$Add(paste0("+h", InputPlace), as.character(Value))
    },
    IncreaseValue = function(InputPlace, Value) {
      WebFormsData$Add(paste0("+v", InputPlace), as.character(Value))
    },
    DescreaseMinLength = function(InputPlace, Value) {
      WebFormsData$Add(paste0("-n", InputPlace), as.character(Value))
    },
    DescreaseMaxLength = function(InputPlace, Value) {
      WebFormsData$Add(paste0("-x", InputPlace), as.character(Value))
    },
    DescreaseFontSize = function(InputPlace, Value) {
      WebFormsData$Add(paste0("-f", InputPlace), as.character(Value))
    },
    DescreaseWidth = function(InputPlace, Value) {
      WebFormsData$Add(paste0("-w", InputPlace), as.character(Value))
    },
    DescreaseHeight = function(InputPlace, Value) {
      WebFormsData$Add(paste0("-h", InputPlace), as.character(Value))
    },
    DescreaseValue = function(InputPlace, Value) {
      WebFormsData$Add(paste0("-v", InputPlace), as.character(Value))
    },
    SetPostEvent = function(InputPlace, HtmlEvent) {
      WebFormsData$Add(paste0("Ep", InputPlace), HtmlEvent)
    },
    SetPostEventAdding = function(InputPlace, HtmlEvent) {
      WebFormsData$Add(paste0("Ep", InputPlace), paste0(HtmlEvent, "|+"))
    },
    SetPostEventTo = function(InputPlace, HtmlEvent, OutputPlace) {
      WebFormsData$Add(paste0("Ep", InputPlace), paste0(HtmlEvent, "|", OutputPlace))
    },
    SetPostEventListener = function(InputPlace, HtmlEventListener) {
      WebFormsData$Add(paste0("EP", InputPlace), HtmlEventListener)
    },
    SetPostEventListenerAdding = function(InputPlace, HtmlEventListener) {
      WebFormsData$Add(paste0("EP", InputPlace), paste0(HtmlEventListener, "|+"))
    },
    SetPostEventListenerTo = function(InputPlace, HtmlEventListener, OutputPlace) {
      WebFormsData$Add(paste0("EP", InputPlace), paste0(HtmlEventListener, "|", OutputPlace))
    },
    SetGetEvent = function(InputPlace, HtmlEvent, Path = NULL) {
      WebFormsData$Add(paste0("Eg", InputPlace), paste0(HtmlEvent, "|", ifelse(is.null(Path), "#", Path)))
    },
    SetGetEvent = function(InputPlace, HtmlEvent, OutputPlace, Path = NULL) {
      WebFormsData$Add(paste0("Eg", InputPlace), paste0(HtmlEvent, "|", ifelse(is.null(Path), "#", Path), "|", OutputPlace))
    },
    SetGetEventInForm = function(InputPlace, HtmlEvent) {
      WebFormsData$Add(paste0("Eg", InputPlace), HtmlEvent)
    },
    SetGetEventInForm = function(InputPlace, HtmlEvent, OutputPlace) {
      WebFormsData$Add(paste0("Eg", InputPlace), paste0(HtmlEvent, "|", OutputPlace))
    },
    SetGetEventListener = function(InputPlace, HtmlEventListener, Path = NULL) {
      WebFormsData$Add(paste0("EG", InputPlace), paste0(HtmlEventListener, "|", ifelse(is.null(Path), "#", Path)))
    },
    SetGetEventListener = function(InputPlace, HtmlEventListener, OutputPlace, Path = NULL) {
      WebFormsData$Add(paste0("EG", InputPlace), paste0(HtmlEventListener, "|", ifelse(is.null(Path), "#", Path), "|", OutputPlace))
    },
    SetGetEventInFormListener = function(InputPlace, HtmlEventListener) {
      WebFormsData$Add(paste0("EG", InputPlace), HtmlEventListener)
    },
    SetGetEventInFormListener = function(InputPlace, HtmlEventListener, OutputPlace) {
      WebFormsData$Add(paste0("EG", InputPlace), paste0(HtmlEventListener, "|", OutputPlace))
    },
    SetTagEvent = function(InputPlace, HtmlEvent, OutputPlace) {
      WebFormsData$Add(paste0("Et", InputPlace), paste0(HtmlEvent, "|", OutputPlace))
    },
    SetTagEventListener = function(InputPlace, HtmlEvent, OutputPlace) {
      WebFormsData$Add(paste0("ET", InputPlace), paste0(HtmlEvent, "|", OutputPlace))
    },
    RemovePostEvent = function(InputPlace, HtmlEvent) {
      WebFormsData$Add(paste0("Rp", InputPlace), HtmlEvent)
    },
    RemoveGetEvent = function(InputPlace, HtmlEvent) {
      WebFormsData$Add(paste0("Rg", InputPlace), HtmlEvent)
    },
    RemoveTagEvent = function(InputPlace, HtmlEvent) {
      WebFormsData$Add(paste0("Rt", InputPlace), HtmlEvent)
    },
    RemovePostEventListener = function(InputPlace, HtmlEventListener) {
      WebFormsData$Add(paste0("RP", InputPlace), HtmlEventListener)
    },
    RemoveGetEventListener = function(InputPlace, HtmlEventListener) {
      WebFormsData$Add(paste0("RG", InputPlace), HtmlEventListener)
    },
    RemoveTagEventListener = function(InputPlace, HtmlEventListener) {
      WebFormsData$Add(paste0("RT", InputPlace), HtmlEventListener)
    },
    SaveId = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@gi", InputPlace), Key)
    },
    SaveName = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@gn", InputPlace), Key)
    },
    SaveValue = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@gv", InputPlace), Key)
    },
    SaveValueLength = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@ge", InputPlace), Key)
    },
    SaveClass = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@gc", InputPlace), Key)
    },
    SaveStyle = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@gs", InputPlace), Key)
    },
    SaveTitle = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@gl", InputPlace), Key)
    },
    SaveText = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@gt", InputPlace), Key)
    },
    SaveTextLength = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@gg", InputPlace), Key)
    },
    SaveAttribute = function(InputPlace, Attribute, Key = ".") {
      WebFormsData$Add(paste0("@ga", InputPlace), paste0(Key, "|", Attribute))
    },
    SaveWidth = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@gw", InputPlace), Key)
    },
    SaveHeight = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@gh", InputPlace), Key)
    },
    SaveReadOnly = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@gr", InputPlace), Key)
    },
    SaveSelectedIndex = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@gx", InputPlace), Key)
    },
    SaveTextAlign = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@ta", InputPlace), Key)
    },
    SaveNodeLength = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@nl", InputPlace), Key)
    },
    SaveVisible = function(InputPlace, Key = ".") {
      WebFormsData$Add(paste0("@vi", InputPlace), Key)
    },
    AssignDelay = function(Second, Index = -1) {
      CurrentName <- WebFormsData$GetNameByIndex(Index)
      if (is.null(CurrentName) || nchar(CurrentName) == 0) {
        return()
      }
      WebFormsData$ChangeNameByIndex(Index, paste0(":", Second, ")", CurrentName))
    },
    AssignDelayChange = function(Second, Index = -1) {
      CurrentName <- WebFormsData$GetNameByIndex(Index)
      if (is.null(CurrentName) || nchar(CurrentName) == 0) {
        return()
      }
      CurrentName <- gsub("^:|)$", "", CurrentName)
      WebFormsData$ChangeNameByIndex(Index, paste0(":", Second, ")", CurrentName))
    },
    AssignInterval = function(Second, Index = -1) {
      CurrentName <- WebFormsData$GetNameByIndex(Index)
      if (is.null(CurrentName) || nchar(CurrentName) == 0) {
        return()
      }
      WebFormsData$ChangeNameByIndex(Index, paste0("(", Second, ")", CurrentName))
    },
    AssignIntervalChange = function(Second, Index = -1) {
      CurrentName <- WebFormsData$GetNameByIndex(Index)
      if (is.null(CurrentName) || nchar(CurrentName) == 0) {
        return()
      }
      CurrentName <- gsub("^\\(|\\)$", "", CurrentName)
      WebFormsData$ChangeNameByIndex(Index, paste0("(", Second, ")", CurrentName))
    },
    StartIndex = function(Name = "") {
      WebFormsData$Add("#", Name)
    },
    GetFormsActionData = function() {
      ReturnValue <- ""
      for (nv in WebFormsData$GetList()) {
        ReturnValue <- paste0(ReturnValue, "\n", nv$Name)
        if (nchar(nv$Value) > 0) {
          ReturnValue <- paste0(ReturnValue, "=", nv$Value)
        }
      }
      ReturnValue
    },
    Response = function() {
      paste0("[web-forms]", GetFormsActionData())
    },
    Response = function(context) {
      SetHeaders(context)
      Response()
    },
    GetFormsActionDataLineBreak = function() {
      ReturnValue <- ""
      WebFormsDataList <- WebFormsData$GetList()
      i <- length(WebFormsDataList)
      for (nv in WebFormsDataList) {
        ReturnValue <- paste0(ReturnValue, nv$Name)
        if (nchar(nv$Value) > 0) {
          ReturnValue <- paste0(ReturnValue, "=", gsub("\"", "$[dq];", nv$Value))
        }
        if (i > 1) {
          ReturnValue <- paste0(ReturnValue, "$[sln];")
        }
        i <- i - 1
      }
      ReturnValue
    },
    ExportToWebFormsTag = function(src = NULL) {
      paste0("<web-forms ac=\"", GetFormsActionDataLineBreak(), "\"", ifelse(!is.null(src), paste0(" src=\"", src, "\""), ""), "></web-forms>")
    },
    ExportToWebFormsTag = function(Width, Height, src = NULL) {
      paste0("<web-forms ac=\"", GetFormsActionDataLineBreak(), "\" width=\"", Width, "\" height=\"", Height, "\"", ifelse(!is.null(src), paste0(" src=\"", src, "\""), ""), "></web-forms>")
    },
    ExportToWebFormsTag = function(Width, Height, src = NULL) {
      ExportToWebFormsTag(paste0(Width, "px"), paste0(Height, "px"), src)
    },
    DoneToWebFormsTag = function(Id = NULL) {
      paste0("<web-forms ac=\"", GetFormsActionDataLineBreak(), "\"", ifelse(!is.null(Id), paste0(" id=\"", Id, "\" done=\"true\""), ""), "></web-forms>")
    },
    ExportToNameValue = function() {
      WebFormsData
    },
    AppendForm = function(form) {
      WebFormsData$AddList(form$ExportToNameValue()$GetList())
    },
    SetHeaders = function(context) {
      context$Response$Headers$Add("Content-Type", "text/plain")
    },
    Clean = function() {
      WebFormsData <- NameValueCollection()
    }
  )
}

# Define the InputPlace class
InputPlace <- list(
  Id = function(Id) Id,
  Name = function(Name) paste0('(', Name, ')'),
  NameWithIndex = function(Name, Index) paste0('(', Name, ')', Index),
  Tag = function(Tag) paste0('<', Tag, '>'),
  TagWithIndex = function(Tag, Index) paste0('<', Tag, '>', Index),
  Class = function(Class) paste0('{', Class, '}'),
  ClassWithIndex = function(Class, Index) paste0('{', Class, '}', Index),
  Query = function(Query) paste0("*", gsub("=", "$[eq];", Query)),
  QueryAll = function(Query) paste0("[", gsub("=", "$[eq];", Query))
)

# Define the OutputPlace class (inherits from InputPlace)
OutputPlace <- InputPlace

# Define the Fetch class
Fetch <- list(
  Random = function(MaxValue) paste0("@mr", MaxValue),
  RandomRange = function(MinValue, MaxValue) paste0("@mr", MaxValue, ",", MinValue),
  DateYear = "@dy",
  DateMonth = "@dm",
  DateDay = "@dd",
  DateHours = "@dh",
  DateMinutes = "@di",
  DateSeconds = "@ds",
  DateMilliseconds = "@dl",
  Cookie = function(Key) paste0("@co", Key),
  Session = function(Key) paste0("@cs", Key),
  SessionWithReplace = function(Key, ReplaceValue) paste0("@cs", Key, ",", ReplaceValue),
  SessionAndRemove = function(Key) paste0("@cl", Key),
  SessionAndRemoveWithReplace = function(Key, ReplaceValue) paste0("@cl", Key, ",", ReplaceValue),
  Saved = function(Key = ".") paste0("@cl", Key),
  Cache = function(Key) paste0("@cd", Key),
  CacheWithReplace = function(Key, ReplaceValue) paste0("@cd", Key, ",", ReplaceValue),
  CacheAndRemove = function(Key) paste0("@ct", Key),
  CacheAndRemoveWithReplace = function(Key, ReplaceValue) paste0("@ct", Key, ",", ReplaceValue),
  Script = function(ScriptText) paste0("@_", gsub("\n", "$[ln];", ScriptText))
)

# Define the HtmlEvent class
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
  OnWaiting = "onwaiting"
)

# Define the HtmlEventListener class
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
  AnimationEnd = "animationend",
  AnimationIteration = "animationiteration",
  AnimationStart = "animationstart",
  ContextMenu = "contextmenu",
  FullScreenChange = "fullscreenchange",
  FullScreenError = "fullscreenerror",
  PopState = "popstate",
  TransitionEnd = "transitionend",
  Storage = "storage",
  Wheel = "wheel"
)

# Define the ExtensionWebFormsMethods class
ExtensionWebFormsMethods <- list(
  AppendPlace = function(Text, Value) {
    if (nchar(Text) < 1) return(Value)
    paste0(Text, "|", Value)
  },
  AppendParent = function(Text) paste0("/", Text),
  ExportToWebFormsTag = function(src) paste0("<web-forms src=\"", src, "\"></web-forms>"),
  ExportToWebFormsTagWithSize = function(src, Width, Height) paste0("<web-forms src=\"", src, "\" width=\"", Width, "\" height=\"", Height, "\"></web-forms>"),
  ExportActionControlsToWebFormsTag = function(ActionControls) paste0("<web-forms ac=\"", ActionControls, "\"></web-forms>"),
  RemoveOuter = function(Text, StartString, EndString) {
    Start <- regexpr(StartString, Text)
    if (Start == -1) return(Text)
    End <- regexpr(EndString, Text, Start + nchar(StartString))
    if (End == -1) return(Text)
    substr(Text, Start + nchar(StartString), End - 1)
  }
)

# Define the NameValue class
NameValue <- function(Name = "", Value = "") {
  list(Name = Name, Value = Value)
}

# Define the NameValueCollection class
NameValueCollection <- function() {
  NameValueList <- list()
  
  list(
    Add = function(Name, Value) {
      NameValueList <<- append(NameValueList, list(NameValue(Name, Value)))
    },
    Set = function(Name, Value) {
      if (!Exist(Name)) {
        Add(Name, Value)
      } else {
        ChangeValue(Name, Value)
      }
    },
    Delete = function(Name) {
      NameValueList <<- Filter(function(nv) nv$Name != Name, NameValueList)
    },
    DeleteByIndex = function(Index) {
      TmpIndex <- ifelse(Index >= 0, Index, length(NameValueList) + Index)
      NameValueList <<- NameValueList[-TmpIndex]
    },
    Empty = function() {
      NameValueList <<- list()
    },
    Exist = function(Name) {
      any(sapply(NameValueList, function(nv) nv$Name == Name))
    },
    ChangeValue = function(Name, Value) {
      for (i in seq_along(NameValueList)) {
        if (NameValueList[[i]]$Name == Name) {
          NameValueList[[i]]$Value <<- Value
          break
        }
      }
    },
    ChangeName = function(Name, NewName) {
      for (i in seq_along(NameValueList)) {
        if (NameValueList[[i]]$Name == Name) {
          NameValueList[[i]]$Name <<- NewName
          break
        }
      }
    },
    ChangeValueByIndex = function(Index, Value) {
      TmpIndex <- ifelse(Index >= 0, Index, length(NameValueList) + Index)
      NameValueList[[TmpIndex]]$Value <<- Value
    },
    ChangeNameByIndex = function(Index, Name) {
      TmpIndex <- ifelse(Index >= 0, Index, length(NameValueList) + Index)
      NameValueList[[TmpIndex]]$Name <<- Name
    },
    ChangeNameValueByIndex = function(Index, Name, Value) {
      TmpIndex <- ifelse(Index >= 0, Index, length(NameValueList) + Index)
      NameValueList[[TmpIndex]]$Name <<- Name
      NameValueList[[TmpIndex]]$Value <<- Value
    },
    AddList = function(newList) {
      NameValueList <<- append(NameValueList, newList)
    },
    GetValue = function(Name) {
      for (nv in NameValueList) {
        if (nv$Name == Name) {
          return(nv$Value)
        }
      }
      return("")
    },
    GetNameByIndex = function(Index) {
      TmpIndex <- ifelse(Index >= 0, Index, length(NameValueList) + Index)
      NameValueList[[TmpIndex]]$Name
    },
    GetValueByIndex = function(Index) {
      TmpIndex <- ifelse(Index >= 0, Index, length(NameValueList) + Index)
      NameValueList[[TmpIndex]]$Value
    },
    GetList = function() {
      NameValueList
    }
  )
}
