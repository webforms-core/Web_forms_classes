import 'dart:io';

class WebForms {
  List<Map<String, String>> webFormsData = [];

  // For Extension
  void addLine(String name, String value) {
    webFormsData.add({'name': name, 'value': value});
  }

  // Add
  void addId(String inputPlace, String id) => addLine('ai$inputPlace', id);
  void addName(String inputPlace, String name) => addLine('an$inputPlace', name);
  void addValue(String inputPlace, String value) => addLine('av$inputPlace', value);
  void addClass(String inputPlace, String className) => addLine('ac$inputPlace', className);
  void addStyle(String inputPlace, String style) => addLine('as$inputPlace', style);
  void addStyleWithName(String inputPlace, String name, String value) => addLine('as$inputPlace', '$name:$value');
  void addOptionTag(String inputPlace, String text, String value, [bool selected = false]) => addLine('ao$inputPlace', '$value|$text${selected ? "|1" : ""}');
  void addCheckBoxTag(String inputPlace, String text, String value, [bool checked = false]) => addLine('ak$inputPlace', '$value|$text${checked ? "|1" : ""}');
  void addTitle(String inputPlace, String title) => addLine('al$inputPlace', title);
  void addText(String inputPlace, String text) => addLine('at$inputPlace', text.replaceAll('\n', r'$[ln];'));
  void addTextToUp(String inputPlace, String text) => addLine('pt$inputPlace', text.replaceAll('\n', r'$[ln];'));
  void addAttribute(String inputPlace, String attribute, [String value = '']) => addLine('aa$inputPlace', '$attribute|$value');
  void addTag(String inputPlace, String tagName, [String id = '']) => addLine('nt$inputPlace', '$tagName${id.isNotEmpty ? '|$id' : ''}');
  void addTagToUp(String inputPlace, String tagName, [String id = '']) => addLine('ut$inputPlace', '$tagName${id.isNotEmpty ? '|$id' : ''}');
  void addTagBefore(String inputPlace, String tagName, [String id = '']) => addLine('bt$inputPlace', '$tagName${id.isNotEmpty ? '|$id' : ''}');
  void addTagAfter(String inputPlace, String tagName, [String id = '']) => addLine('ft$inputPlace', '$tagName${id.isNotEmpty ? '|$id' : ''}');

  // Set
  void setId(String inputPlace, String id) => addLine('si$inputPlace', id);
  void setName(String inputPlace, String name) => addLine('sn$inputPlace', name);
  void setValue(String inputPlace, String value) => addLine('sv$inputPlace', value);
  void setClass(String inputPlace, String className) => addLine('sc$inputPlace', className);
  void setStyle(String inputPlace, String style) => addLine('ss$inputPlace', style);
  void setStyleWithName(String inputPlace, String name, String value) => addLine('ss$inputPlace', '$name:$value');
  void setOptionTag(String inputPlace, String text, String value, [bool selected = false]) => addLine('so$inputPlace', '$value|$text${selected ? "|1" : ""}');
  void setChecked(String inputPlace, [bool checked = false]) => addLine('sk$inputPlace', checked ? '1' : '0');
  void setCheckBoxTagToList(String inputPlace, String text, String value, [bool checked = false]) => addLine('sk$inputPlace', '$value|$text${checked ? "|1" : ""}');
  void setTitle(String inputPlace, String title) => addLine('sl$inputPlace', title);
  void setText(String inputPlace, String text) => addLine('st$inputPlace', text.replaceAll('\n', r'$[ln];'));
  void setAttribute(String inputPlace, String attribute, [String value = '']) => addLine('sa$inputPlace', '$attribute${value.isNotEmpty ? '|$value' : ''}');
  void setWidth(String inputPlace, String width) => addLine('sw$inputPlace', width);
  void setWidthInPixels(String inputPlace, int width) => setWidth(inputPlace, '${width}px');
  void setHeight(String inputPlace, String height) => addLine('sh$inputPlace', height);
  void setHeightInPixels(String inputPlace, int height) => setHeight(inputPlace, '${height}px');

  // Insert
  void insertId(String inputPlace, String id) => addLine('ii$inputPlace', id);
  void insertName(String inputPlace, String name) => addLine('in$inputPlace', name);
  void insertValue(String inputPlace, String value) => addLine('iv$inputPlace', value);
  void insertClass(String inputPlace, String className) => addLine('ic$inputPlace', className);
  void insertStyle(String inputPlace, String style) => addLine('is$inputPlace', style);
  void insertStyleWithName(String inputPlace, String name, String value) => addLine('is$inputPlace', '$name:$value');
  void insertOptionTag(String inputPlace, String text, String value, [bool selected = false]) => addLine('io$inputPlace', '$value|$text${selected ? "|1" : ""}');
  void insertCheckBoxTag(String inputPlace, String text, String value, [bool checked = false]) => addLine('ik$inputPlace', '$value|$text${checked ? "|1" : ""}');
  void insertTitle(String inputPlace, String title) => addLine('il$inputPlace', title);
  void insertText(String inputPlace, String text) => addLine('it$inputPlace', text.replaceAll('\n', r'$[ln];'));
  void insertAttribute(String inputPlace, String attribute, [String value = '']) => addLine('ia$inputPlace', '$attribute${value.isNotEmpty ? '|$value' : ''}');

  // Delete
  void deleteId(String inputPlace) => addLine('di$inputPlace', '1');
  void deleteName(String inputPlace) => addLine('dn$inputPlace', '1');
  void deleteValue(String inputPlace) => addLine('dv$inputPlace', '1');
  void deleteClass(String inputPlace, String className) => addLine('dc$inputPlace', className);
  void deleteStyle(String inputPlace, String styleName) => addLine('ds$inputPlace', styleName);
  void deleteOptionTag(String inputPlace, String value) => addLine('do$inputPlace', value);
  void deleteAllOptionTag(String inputPlace) => addLine('do$inputPlace', '*');
  void deleteCheckBoxTag(String inputPlace, String value) => addLine('dk$inputPlace', value);
  void deleteAllCheckBoxTag(String inputPlace) => addLine('dk$inputPlace', '*');
  void deleteTitle(String inputPlace) => addLine('dl$inputPlace', '1');
  void deleteText(String inputPlace) => addLine('dt$inputPlace', '1');
  void deleteAttribute(String inputPlace, String attribute) => addLine('da$inputPlace', attribute);
  void delete(String inputPlace) => addLine('de$inputPlace', '1');
  void deleteParent(String inputPlace) => addLine('dp$inputPlace', '1');

  // Other
  void setBackgroundColor(String inputPlace, String color) => addLine('bc$inputPlace', color);
  void setTextColor(String inputPlace, String color) => addLine('tc$inputPlace', color);
  void setFontName(String inputPlace, String name) => addLine('fn$inputPlace', name);
  void setFontSize(String inputPlace, String size) => addLine('fs$inputPlace', size);
  void setFontSizeInPixels(String inputPlace, int size) => setFontSize(inputPlace, '${size}px');
  void setFontBold(String inputPlace, bool bold) => addLine('fb$inputPlace', bold ? '1' : '0');
  void setVisible(String inputPlace, bool visible) => addLine('vi$inputPlace', visible ? '1' : '0');
  void setTextAlign(String inputPlace, String align) => addLine('ta$inputPlace', align);
  void setReadOnly(String inputPlace, bool readOnly) => addLine('sr$inputPlace', readOnly ? '1' : '0');
  void setDisabled(String inputPlace, bool disabled) => addLine('sd$inputPlace', disabled ? '1' : '0');
  void setFocus(String inputPlace, bool focus) => addLine('sf$inputPlace', focus ? '1' : '0');
  void setMinLength(String inputPlace, int length) => addLine('mn$inputPlace', length.toString());
  void setMaxLength(String inputPlace, int length) => addLine('mx$inputPlace', length.toString());
  void setSelectedValue(String inputPlace, String value) => addLine('ts$inputPlace', value);
  void setSelectedIndex(String inputPlace, int index) => addLine('ti$inputPlace', index.toString());
  void setCheckedValue(String inputPlace, String value, bool selected) => addLine('ks$inputPlace', '$value|${selected ? '1' : '0'}');
  void setCheckedIndex(String inputPlace, int index, bool selected) => addLine('ki$inputPlace', '$index|${selected ? '1' : '0'}');
  void callScript(String scriptText) => addLine('_', scriptText.replaceAll('\n', r'$[ln];'));
  void loadUrl(String inputPlace, String url) => addLine('lu$inputPlace', url);
  void changeUrl(String url) => addLine('cu', url);
  void removeSessionCache(String cacheKey) => addLine('rs', cacheKey);
  void removeAllSessionCache() => addLine('rs', '*');
  void removeCache(String cacheKey) => addLine('rd', cacheKey);
  void removeAllCache() => addLine('rd', '*');
  void setSessionCache() => addLine('cs', '1');
  void setCache(int second) => addLine('cd', second.toString());
  void setCacheAll() => addLine('cd', '*');

  // Increase
  void increaseMinLength(String inputPlace, int value) => addLine('+n$inputPlace', value.toString());
  void increaseMaxLength(String inputPlace, int value) => addLine('+x$inputPlace', value.toString());
  void increaseFontSize(String inputPlace, int value) => addLine('+f$inputPlace', value.toString());
  void increaseWidth(String inputPlace, int value) => addLine('+w$inputPlace', value.toString());
  void increaseHeight(String inputPlace, int value) => addLine('+h$inputPlace', value.toString());
  void increaseValue(String inputPlace, int value) => addLine('+v$inputPlace', value.toString());

  // Decrease
  void decreaseMinLength(String inputPlace, int value) => addLine('-n$inputPlace', value.toString());
  void decreaseMaxLength(String inputPlace, int value) => addLine('-x$inputPlace', value.toString());
  void decreaseFontSize(String inputPlace, int value) => addLine('-f$inputPlace', value.toString());
  void decreaseWidth(String inputPlace, int value) => addLine('-w$inputPlace', value.toString());
  void decreaseHeight(String inputPlace, int value) => addLine('-h$inputPlace', value.toString());
  void decreaseValue(String inputPlace, int value) => addLine('-v$inputPlace', value.toString());

  // Event
  void setPostEvent(String inputPlace, String htmlEvent) => addLine('Ep$inputPlace', htmlEvent);
  void setPostEventAdding(String inputPlace, String htmlEvent) => addLine('Ep$inputPlace', '$htmlEvent|+');
  void setPostEventTo(String inputPlace, String htmlEvent, String outputPlace) => addLine('Ep$inputPlace', '$htmlEvent|$outputPlace');
  void setPostEventListener(String inputPlace, String htmlEventListener) => addLine('EP$inputPlace', htmlEventListener);
  void setPostEventListenerAdding(String inputPlace, String htmlEventListener) => addLine('EP$inputPlace', '$htmlEventListener|+');
  void setPostEventListenerTo(String inputPlace, String htmlEventListener, String outputPlace) => addLine('EP$inputPlace', '$htmlEventListener|$outputPlace');
  void setGetEvent(String inputPlace, String htmlEvent, [String path]) => addLine('Eg$inputPlace', '$htmlEvent|${path ?? '#'}');
  void setGetEventWithOutput(String inputPlace, String htmlEvent, String outputPlace, [String path]) => addLine('Eg$inputPlace', '$htmlEvent|${path ?? '#'}|$outputPlace');
  void setGetEventInForm(String inputPlace, String htmlEvent) => addLine('Eg$inputPlace', htmlEvent);
  void setGetEventInFormWithOutput(String inputPlace, String htmlEvent, String outputPlace) => addLine('Eg$inputPlace', '$htmlEvent|$outputPlace');
  void setGetEventListener(String inputPlace, String htmlEventListener, [String path]) => addLine('EG$inputPlace', '$htmlEventListener|${path ?? '#'}');
  void setGetEventListenerWithOutput(String inputPlace, String htmlEventListener, String outputPlace, [String path]) => addLine('EG$inputPlace', '$htmlEventListener|${path ?? '#'}|$outputPlace');
  void setGetEventInFormListener(String inputPlace, String htmlEventListener) => addLine('EG$inputPlace', htmlEventListener);
  void setGetEventInFormListenerWithOutput(String inputPlace, String htmlEventListener, String outputPlace) => addLine('EG$inputPlace', '$htmlEventListener|$outputPlace');
  void setTagEvent(String inputPlace, String htmlEvent, String outputPlace) => addLine('Et$inputPlace', '$htmlEvent|$outputPlace');
  void setTagEventListener(String inputPlace, String htmlEvent, String outputPlace) => addLine('ET$inputPlace', '$htmlEvent|$outputPlace');
  void removePostEvent(String inputPlace, String htmlEvent) => addLine('Rp$inputPlace', htmlEvent);
  void removeGetEvent(String inputPlace, String htmlEvent) => addLine('Rg$inputPlace', htmlEvent);
  void removeTagEvent(String inputPlace, String htmlEvent) => addLine('Rt$inputPlace', htmlEvent);
  void removePostEventListener(String inputPlace, String htmlEventListener) => addLine('RP$inputPlace', htmlEventListener);
  void removeGetEventListener(String inputPlace, String htmlEventListener) => addLine('RG$inputPlace', htmlEventListener);
  void removeTagEventListener(String inputPlace, String htmlEventListener) => addLine('RT$inputPlace', htmlEventListener);

  // Save
  void saveId(String inputPlace, [String key = '.']) => addLine('@gi$inputPlace', key);
  void saveName(String inputPlace, [String key = '.']) => addLine('@gn$inputPlace', key);
  void saveValue(String inputPlace, [String key = '.']) => addLine('@gv$inputPlace', key);
  void saveValueLength(String inputPlace, [String key = '.']) => addLine('@ge$inputPlace', key);
  void saveClass(String inputPlace, [String key = '.']) => addLine('@gc$inputPlace', key);
  void saveStyle(String inputPlace, [String key = '.']) => addLine('@gs$inputPlace', key);
  void saveTitle(String inputPlace, [String key = '.']) => addLine('@gl$inputPlace', key);
  void saveText(String inputPlace, [String key = '.']) => addLine('@gt$inputPlace', key);
  void saveTextLength(String inputPlace, [String key = '.']) => addLine('@gg$inputPlace', key);
  void saveAttribute(String inputPlace, String attribute, [String key = '.']) => addLine('@ga$inputPlace', '$key|$attribute');
  void saveWidth(String inputPlace, [String key = '.']) => addLine('@gw$inputPlace', key);
  void saveHeight(String inputPlace, [String key = '.']) => addLine('@gh$inputPlace', key);
  void saveReadOnly(String inputPlace, [String key = '.']) => addLine('@gr$inputPlace', key);
  void saveSelectedIndex(String inputPlace, [String key = '.']) => addLine('@gx$inputPlace', key);
  void saveTextAlign(String inputPlace, [String key = '.']) => addLine('@ta$inputPlace', key);
  void saveNodeLength(String inputPlace, [String key = '.']) => addLine('@nl$inputPlace', key);
  void saveVisible(String inputPlace, [String key = '.']) => addLine('@vi$inputPlace', key);

  // Pre Runner
  void assignDelay(double second, [int index = -1]) {
    String currentName = getNameByIndex(index);
    if (currentName.isEmpty) return;
    changeNameByIndex(index, ':${second})$currentName');
  }

  void assignDelayChange(double second, [int index = -1]) {
    String currentName = getNameByIndex(index);
    if (currentName.isEmpty) return;
    currentName = currentName.replaceAll(RegExp(r'^:.*\)'), '');
    changeNameByIndex(index, ':${second})$currentName');
  }

  void assignInterval(double second, [int index = -1]) {
    String currentName = getNameByIndex(index);
    if (currentName.isEmpty) return;
    changeNameByIndex(index, '(${second})$currentName');
  }

  void assignIntervalChange(double second, [int index = -1]) {
    String currentName = getNameByIndex(index);
    if (currentName.isEmpty) return;
    currentName = currentName.replaceAll(RegExp(r'^\(.*\)'), '');
    changeNameByIndex(index, '(${second})$currentName');
  }

  // Index
  void startIndex([String name = '']) => addLine('#', name);

  // Get
  String getFormsActionData() {
    String returnValue = '';
    for (var nv in webFormsData) {
      returnValue += '\n${nv['name']}';
      if (nv['value']!.isNotEmpty) returnValue += '=${nv['value']}';
    }
    return returnValue;
  }

  String response() {
    return '[web-forms]${getFormsActionData()}';
  }

  // Overload
  String response(HttpRequest request) {
    setHeaders(request.response);
    return response();
  }

  String getFormsActionDataLineBreak() {
    String returnValue = '';
    int i = webFormsData.length;
    for (var nv in webFormsData) {
      returnValue += nv['name'];
      if (nv['value']!.isNotEmpty) returnValue += '=${nv['value']!.replaceAll('"', r'$[dq];')}';
      if (i-- > 1) returnValue += r'$[sln];';
    }
    return returnValue;
  }

  // Export
  String exportToWebFormsTag([String src]) {
    return '<web-forms ac="${getFormsActionDataLineBreak()}"${src != null ? ' src="$src"' : ''}></web-forms>';
  }

  // Overload
  String exportToWebFormsTagWithSize(String width, String height, [String src]) {
    return '<web-forms ac="${getFormsActionDataLineBreak()}" width="$width" height="$height"${src != null ? ' src="$src"' : ''}></web-forms>';
  }

  // Overload
  String exportToWebFormsTagWithSizeInPixels(int width, int height, [String src]) {
    return exportToWebFormsTagWithSize('${width}px', '${height}px', src);
  }

  String doneToWebFormsTag([String id]) {
    return '<web-forms ac="${getFormsActionDataLineBreak()}"${id != null ? ' id="$id" done="true"' : ''}></web-forms>';
  }

  List<Map<String, String>> exportToNameValue() {
    return webFormsData;
  }

  void appendForm(WebForms form) {
    webFormsData.addAll(form.exportToNameValue());
  }

  void setHeaders(HttpResponse response) {
    response.headers.add('Content-Type', 'text/plain');
  }

  void clean() {
    webFormsData = [];
  }

  String getNameByIndex(int index) {
    int tmpIndex = (index >= 0) ? index : webFormsData.length + index;
    return webFormsData[tmpIndex]['name']!;
  }

  void changeNameByIndex(int index, String name) {
    int tmpIndex = (index >= 0) ? index : webFormsData.length + index;
    webFormsData[tmpIndex]['name'] = name;
  }
}

class InputPlace {
  static String id(String id) => id;
  static String name(String name) => '($name)';
  static String nameWithIndex(String name, int index) => '($name)$index';
  static String tag(String tag) => '<$tag>';
  static String tagWithIndex(String tag, int index) => '<$tag>$index';
  static String className(String className) => '{$className}';
  static String classNameWithIndex(String className, int index) => '{$className}$index';
  static String query(String query) => '*${query.replaceAll('=', r'$[eq];')}';
  static String queryAll(String query) => '[${query.replaceAll('=', r'$[eq];')}';
}

class OutputPlace extends InputPlace {}

class Fetch {
  static String random(int maxValue) => '@mr$maxValue';
  static String randomRange(int minValue, int maxValue) => '@mr$maxValue,$minValue';
  static const String dateYear = '@dy';
  static const String dateMonth = '@dm';
  static const String dateDay = '@dd';
  static const String dateHours = '@dh';
  static const String dateMinutes = '@di';
  static const String dateSeconds = '@ds';
  static const String dateMilliseconds = '@dl';
  static String cookie(String key) => '@co$key';
  static String session(String key) => '@cs$key';
  static String sessionWithReplace(String key, String replaceValue) => '@cs$key,$replaceValue';
  static String sessionAndRemove(String key) => '@cl$key';
  static String sessionAndRemoveWithReplace(String key, String replaceValue) => '@cl$key,$replaceValue';
  static String saved([String key = '.']) => '@cl$key';
  static String cache(String key) => '@cd$key';
  static String cacheWithReplace(String key, String replaceValue) => '@cd$key,$replaceValue';
  static String cacheAndRemove(String key) => '@ct$key';
  static String cacheAndRemoveWithReplace(String key, String replaceValue) => '@ct$key,$replaceValue';
  static String script(String scriptText) => '@_${scriptText.replaceAll('\n', r'$[ln];')}';
}

class HtmlEvent {
  static const String onAbort = 'onabort';
  static const String onAfterPrint = 'onafterprint';
  static const String onBeforePrint = 'onbeforeprint';
  static const String onBeforeUnload = 'onbeforeunload';
  static const String onBlur = 'onblur';
  static const String onCanPlay = 'oncanplay';
  static const String onCanPlayThrough = 'oncanplaythrough';
  static const String onChange = 'onchange';
  static const String onClick = 'onclick';
  static const String onCopy = 'oncopy';
  static const String onCut = 'oncut';
  static const String onDoubleClick = 'ondblclick';
  static const String onDrag = 'ondrag';
  static const String onDragEnd = 'ondragend';
  static const String onDragEnter = 'ondragenter';
  static const String onDragLeave = 'ondragleave';
  static const String onDragOver = 'ondragover';
  static const String onDragStart = 'ondragstart';
  static const String onDrop = 'ondrop';
  static const String onDurationChange = 'ondurationchange';
  static const String onEnded = 'onended';
  static const String onError = 'onerror';
  static const String onFocus = 'onfocus';
  static const String onFocusIn = 'onfocusin';
  static const String onFocusOut = 'onfocusout';
  static const String onHashChange = 'onhashchange';
  static const String onInput = 'oninput';
  static const String onInvalid = 'oninvalid';
  static const String onKeyDown = 'onkeydown';
  static const String onKeyPress = 'onkeypress';
  static const String onKeyUp = 'onkeyup';
  static const String onLoad = 'onload';
  static const String onLoadedData = 'onloadeddata';
  static const String onLoadedMetaData = 'onloadedmetadata';
  static const String onLoadStart = 'onloadstart';
  static const String onMouseDown = 'onmousedown';
  static const String onMouseEnter = 'onmouseenter';
  static const String onMouseLeave = 'onmouseleave';
  static const String onMouseMove = 'onmousemove';
  static const String onMouseOver = 'onmouseover';
  static const String onMouseOut = 'onmouseout';
  static const String onMouseUp = 'onmouseup';
  static const String onOffline = 'onoffline';
  static const String onOnline = 'ononline';
  static const String onPageHide = 'onpagehide';
  static const String onPageShow = 'onpageshow';
  static const String onPaste = 'onpaste';
  static const String onPause = 'onpause';
  static const String onPlay = 'onplay';
  static const String onPlaying = 'onplaying';
  static const String onProgress = 'onprogress';
  static const String onRateChange = 'onratechange';
  static const String onResize = 'onresize';
  static const String onReset = 'onreset';
  static const String onScroll = 'onscroll';
  static const String onSearch = 'onsearch';
  static const String onSeeked = 'onseeked';
  static const String onSeeking = 'onseeking';
  static const String onSelect = 'onselect';
  static const String onStalled = 'onstalled';
  static const String onSubmit = 'onsubmit';
  static const String onSuspend = 'onsuspend';
  static const String onTimeUpdate = 'ontimeupdate';
  static const String onToggle = 'ontoggle';
  static const String onTouchCancel = 'ontouchcancel';
  static const String onTouchEnd = 'ontouchend';
  static const String onTouchMove = 'ontouchmove';
  static const String onTouchStart = 'ontouchstart';
  static const String onUnload = 'onunload';
  static const String onVolumeChange = 'onvolumechange';
  static const String onWaiting = 'onwaiting';
}

class HtmlEventListener {
  static const String abort = 'abort';
  static const String afterPrint = 'afterprint';
  static const String beforePrint = 'beforeprint';
  static const String beforeUnload = 'beforeunload';
  static const String blur = 'blur';
  static const String canPlay = 'canplay';
  static const String canPlayThrough = 'canplaythrough';
  static const String change = 'change';
  static const String click = 'click';
  static const String copy = 'copy';
  static const String cut = 'cut';
  static const String doubleClick = 'dblclick';
  static const String drag = 'drag';
  static const String dragEnd = 'dragend';
  static const String dragEnter = 'dragenter';
  static const String dragLeave = 'dragleave';
  static const String dragOver = 'dragover';
  static const String dragStart = 'dragstart';
  static const String drop = 'drop';
  static const String durationChange = 'durationchange';
  static const String ended = 'ended';
  static const String error = 'error';
  static const String focus = 'focus';
  static const String focusIn = 'focusin';
  static const String focusOut = 'focusout';
  static const String hashChange = 'hashchange';
  static const String input = 'input';
  static const String invalid = 'invalid';
  static const String keyDown = 'keydown';
  static const String keyPress = 'keypress';
  static const String keyUp = 'keyup';
  static const String load = 'load';
  static const String loadedData = 'loadeddata';
  static const String loadedMetaData = 'loadedmetadata';
  static const String loadStart = 'loadstart';
  static const String mouseDown = 'mousedown';
  static const String mouseEnter = 'mouseenter';
  static const String mouseLeave = 'mouseleave';
  static const String mouseMove = 'mousemove';
  static const String mouseOver = 'mouseover';
  static const String mouseOut = 'mouseout';
  static const String mouseUp = 'mouseup';
  static const String offline = 'offline';
  static const String online = 'online';
  static const String pageHide = 'pagehide';
  static const String pageShow = 'pageshow';
  static const String paste = 'paste';
  static const String pause = 'pause';
  static const String play = 'play';
  static const String playing = 'playing';
  static const String progress = 'progress';
  static const String rateChange = 'ratechange';
  static const String resize = 'resize';
  static const String reset = 'reset';
  static const String scroll = 'scroll';
  static const String search = 'search';
  static const String seeked = 'seeked';
  static const String seeking = 'seeking';
  static const String select = 'select';
  static const String stalled = 'stalled';
  static const String submit = 'submit';
  static const String suspend = 'suspend';
  static const String timeUpdate = 'timeupdate';
  static const String toggle = 'toggle';
  static const String touchCancel = 'touchcancel';
  static const String touchEnd = 'touchend';
  static const String touchMove = 'touchmove';
  static const String touchStart = 'touchstart';
  static const String unload = 'unload';
  static const String volumeChange = 'volumechange';
  static const String waiting = 'waiting';

  static const String animationEnd = 'animationend';
  static const String animationIteration = 'animationiteration';
  static const String animationStart = 'animationstart';
  static const String contextMenu = 'contextmenu';
  static const String fullScreenChange = 'fullscreenchange';
  static const String fullScreenError = 'fullscreenerror';
  static const String popState = 'popstate';
  static const String transitionEnd = 'transitionend';
  static const String storage = 'storage';
  static const String wheel = 'wheel';
}

extension ExtensionWebFormsMethods on String {
  String appendPlace(String value) {
    if (isEmpty) return value;
    return '$this|$value';
  }

  String appendParent() {
    return '/$this';
  }

  String exportToWebFormsTag() {
    return '<web-forms src="$this"></web-forms>';
  }

  String exportToWebFormsTagWithSize(int width, int height) {
    return '<web-forms src="$this" width="$width" height="$height"></web-forms>';
  }

  String exportActionControlsToWebFormsTag() {
    return '<web-forms ac="$this"></web-forms>';
  }

  String removeOuter(String startString, String endString) {
    int start = indexOf(startString);
    if (start == -1) return this;
    int end = indexOf(endString, start);
    if (end == -1) return this;
    int lengthToRemove = (end - start) + endString.length;
    return replaceRange(start, start + lengthToRemove, '');
  }
}