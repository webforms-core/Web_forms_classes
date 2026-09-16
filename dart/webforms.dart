// webforms.dart 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.1

class WebForms {
  static const int _gs = 29;
  static const int _us = 31;

  String _webFormsData = '';

  void _add(String name, [String? value]) {
    if (_webFormsData.isNotEmpty) {
      _webFormsData += '\n';
    }
    _webFormsData += value != null ? '$name=$value' : name;
  }

  void _addToUp(String name, [String? value]) {
    String line = value != null ? '$name=$value' : name;
    if (_webFormsData.isNotEmpty) {
      line += '\n';
    }
    _webFormsData = line + _webFormsData;
  }

  String getLineByIndex(int index) {
    if (_webFormsData.isEmpty) {
      return '';
    }

    List<String> lines = _webFormsData.split('\n');

    if (index < 0) {
      index = lines.length + index;
    }

    if (index < 0 || index >= lines.length) {
      return '';
    }

    return lines[index];
  }

  void updateLineByIndex(int index, String name, String value) {
    if (_webFormsData.isEmpty) {
      return;
    }

    List<String> lines = _webFormsData.split('\n');

    if (index < 0) {
      index = lines.length + index;
    }

    if (index < 0 || index >= lines.length) {
      return;
    }

    lines[index] = name + (value.isEmpty ? '' : '=$value');

    _webFormsData = lines.join('\n');
  }

  // For Extension
  void addLine(String name, String value) => _add(name, value);

  // Add
  // Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.
  void addId(String inputPlace, String id) => _add('ai$inputPlace', id);
  void addName(String inputPlace, String name) => _add('an$inputPlace', name);
  void addValue(String inputPlace, String value) => _add('av$inputPlace', value);
  void addClass(String inputPlace, String class_) => _add('ac$inputPlace', class_);
  void addStyle(String inputPlace, Object styleOrName, [String? value]) {
    if (value != null) {
      _add('as$inputPlace', '$styleOrName:$value');
    } else {
      _add('as$inputPlace', styleOrName.toString());
    }
  }
  void addOptionTag(String inputPlace, String text, String value, {bool selected = false}) => _add('ao$inputPlace', '$value${String.fromCharCode(_gs)}$text${selected ? '${String.fromCharCode(_gs)}1' : ''}');
  void addCheckBoxTag(String inputPlace, String text, String value, {bool checked = false}) => _add('ak$inputPlace', '$value${String.fromCharCode(_gs)}$text${checked ? '${String.fromCharCode(_gs)}1' : ''}');
  void addTitle(String inputPlace, String title) => _add('al$inputPlace', title);
  void addLabel(String inputPlace, String label) => _add('aA$inputPlace', label);
  void addText(String inputPlace, String text) => _add('at$inputPlace', text.replaceAll('\n', r'$[ln];'));
  void addTextToUp(String inputPlace, String text) => _add('pt$inputPlace', text.replaceAll('\n', r'$[ln];'));
  void addAttribute(String inputPlace, String attribute, [String value = '', int splitter = 0]) => _add('aa$inputPlace', attribute + String.fromCharCode(_gs) + ((splitter != 0) ? String.fromCharCode(splitter) : '') + (value.isNotEmpty ? '${String.fromCharCode(_gs)}$value' : ''));
  void addTag(String inputPlace, String tagName, [String id = '']) => _add('nt$inputPlace', tagName + (id.isNotEmpty ? '${String.fromCharCode(_gs)}$id' : ''));
  void addTagToUp(String inputPlace, String tagName, [String id = '']) => _add('ut$inputPlace', tagName + (id.isNotEmpty ? '${String.fromCharCode(_gs)}$id' : ''));
  void addTagBefore(String inputPlace, String tagName, [String id = '']) => _add('bt$inputPlace', tagName + (id.isNotEmpty ? '${String.fromCharCode(_gs)}$id' : ''));
  void addTagAfter(String inputPlace, String tagName, [String id = '']) => _add('ft$inputPlace', tagName + (id.isNotEmpty ? '${String.fromCharCode(_gs)}$id' : ''));
  void addHidden(String inputPlace, String name, String value, [String id = '']) => _add('ah$inputPlace', name + String.fromCharCode(_gs) + value + (id.isNotEmpty ? '${String.fromCharCode(_gs)}$id' : ''));

  // Set
  // Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.
  void setId(String inputPlace, String id) => _add('si$inputPlace', id);
  void setName(String inputPlace, String name) => _add('sn$inputPlace', name);
  void setValue(String inputPlace, String value) => _add('sv$inputPlace', value);
  void setClass(String inputPlace, String class_) => _add('sc$inputPlace', class_);
  void setStyle(String inputPlace, Object styleOrName, [String? value]) {
    if (value != null) {
      _add('ss$inputPlace', '$styleOrName:$value');
    } else {
      _add('ss$inputPlace', styleOrName.toString());
    }
  }
  void setOptionTag(String inputPlace, String text, String value, {bool selected = false}) => _add('so$inputPlace', '$value${String.fromCharCode(_gs)}$text${selected ? '${String.fromCharCode(_gs)}1' : ''}');
  void setChecked(String inputPlace, {bool checked = false}) => _add('sk$inputPlace', checked ? '1' : '0');
  void setCheckBoxTag(String inputPlace, String text, String value, {bool checked = false}) => _add('sk$inputPlace', '$value${String.fromCharCode(_gs)}$text${checked ? '${String.fromCharCode(_gs)}1' : ''}');
  void setTitle(String inputPlace, String title) => _add('sl$inputPlace', title);
  void setLabel(String inputPlace, String label) => _add('sA$inputPlace', label);
  void setText(String inputPlace, String text) => _add('st$inputPlace', text.replaceAll('\n', r'$[ln];'));
  void setAttribute(String inputPlace, String attribute, [String value = '']) => _add('sa$inputPlace', attribute + String.fromCharCode(_gs) + (value.isNotEmpty ? '${String.fromCharCode(_gs)}$value' : ''));
  void setWidth(String inputPlace, Object width) {
    final finalWidth = width is int ? '${width}px' : width.toString();
    _add('sw$inputPlace', finalWidth);
  }
  void setHeight(String inputPlace, Object height) {
    final finalHeight = height is int ? '${height}px' : height.toString();
    _add('sh$inputPlace', finalHeight);
  }
  void setBackgroundColor(String inputPlace, String color) => _add('bc$inputPlace', color);
  void setTextColor(String inputPlace, String color) => _add('tc$inputPlace', color);
  void setFontName(String inputPlace, String name) => _add('fn$inputPlace', name);
  void setFontSize(String inputPlace, Object size) {
    final finalSize = size is int ? '${size}px' : size.toString();
    _add('fs$inputPlace', finalSize);
  }
  void setFontBold(String inputPlace, bool bold) => _add('fb$inputPlace', bold ? '1' : '0');
  void setVisible(String inputPlace, bool visible) => _add('vi$inputPlace', visible ? '1' : '0');
  void setTextAlign(String inputPlace, String align) => _add('ta$inputPlace', align);
  void setReadOnly(String inputPlace, bool readOnly) => _add('sr$inputPlace', readOnly ? '1' : '0');
  void setDisabled(String inputPlace, bool disabled) => _add('sd$inputPlace', disabled ? '1' : '0');
  void setFocus(String inputPlace, bool focus) => _add('sf$inputPlace', focus ? '1' : '0');
  void setMinLength(String inputPlace, Object length) => _add('mn$inputPlace', length.toString());
  void setMaxLength(String inputPlace, Object length) => _add('mx$inputPlace', length.toString());
  void setSelectedValue(String inputPlace, String value) => _add('ts$inputPlace', value);
  void setSelectedIndex(String inputPlace, Object index) => _add('ti$inputPlace', index.toString());
  void setCheckedValue(String inputPlace, String value, bool checked) => _add('ks$inputPlace', value + String.fromCharCode(_gs) + (checked ? '1' : '0'));
  void setCheckedIndex(String inputPlace, Object index, bool checked) => _add('ki$inputPlace', index.toString() + String.fromCharCode(_gs) + (checked ? '1' : '0'));

  // Insert
  // Creates the Data only if it does not exist; otherwise, does nothing.
  void insertId(String inputPlace, String id) => _add('ii$inputPlace', id);
  void insertName(String inputPlace, String name) => _add('in$inputPlace', name);
  void insertValue(String inputPlace, String value) => _add('iv$inputPlace', value);
  void insertClass(String inputPlace, String class_) => _add('ic$inputPlace', class_);
  void insertStyle(String inputPlace, Object styleOrName, [String? value]) {
    if (value != null) {
      _add('is$inputPlace', '$styleOrName:$value');
    } else {
      _add('is$inputPlace', styleOrName.toString());
    }
  }
  void insertOptionTag(String inputPlace, String text, String value, {bool selected = false}) => _add('io$inputPlace', '$value${String.fromCharCode(_gs)}$text${selected ? '${String.fromCharCode(_gs)}1' : ''}');
  void insertCheckBoxTag(String inputPlace, String text, String value, {bool checked = false}) => _add('ik$inputPlace', '$value${String.fromCharCode(_gs)}$text${checked ? '${String.fromCharCode(_gs)}1' : ''}');
  void insertTitle(String inputPlace, String title) => _add('il$inputPlace', title);
  void insertLabel(String inputPlace, String label) => _add('iA$inputPlace', label);
  void insertText(String inputPlace, String text) => _add('it$inputPlace', text.replaceAll('\n', r'$[ln];'));
  void insertAttribute(String inputPlace, String attribute, [String value = '', int splitter = 0]) => _add('ia$inputPlace', attribute + String.fromCharCode(_gs) + ((splitter != 0) ? String.fromCharCode(splitter) : '') + (value.isNotEmpty ? '${String.fromCharCode(_gs)}$value' : ''));

  // Delete
  void deleteId(String inputPlace) => _add('di$inputPlace');
  void deleteName(String inputPlace) => _add('dn$inputPlace');
  void deleteValue(String inputPlace) => _add('dv$inputPlace');
  void deleteClass(String inputPlace, String className) => _add('dc$inputPlace', className);
  void deleteStyle(String inputPlace, String styleName) => _add('ds$inputPlace', styleName);
  void deleteOptionTag(String inputPlace, String value) => _add('do$inputPlace', value);
  void deleteAllOptionTag(String inputPlace) => _add('do$inputPlace', '*');
  void deleteCheckBoxTag(String inputPlace, String value) => _add('dk$inputPlace', value);
  void deleteAllCheckBoxTag(String inputPlace) => _add('dk$inputPlace', '*');
  void deleteTitle(String inputPlace) => _add('dl$inputPlace');
  void deleteLabel(String inputPlace) => _add('dA$inputPlace');
  void deleteText(String inputPlace) => _add('dt$inputPlace');
  void deleteAttribute(String inputPlace, String attribute) => _add('da$inputPlace', attribute);
  void delete(String inputPlace) => _add('de$inputPlace');
  void deleteParent(String inputPlace) => _add('dp$inputPlace');

  // Tag
  void swapTag(String inputPlace, String outputPlace) => _add('sp$inputPlace', outputPlace);
  void setReflection(String inputPlace, String tag) => _add('sR$inputPlace', tag);
  void setReflectionByOutputPlace(String inputPlace, String outputPlace) => _add('iR$inputPlace', outputPlace);
  void setMorph(String inputPlace, String tag) => _add('sM$inputPlace', tag);
  void setMorphByOutputPlace(String inputPlace, String outputPlace) => _add('iM$inputPlace', outputPlace);

  // Browser
  void changeUrl(String url) => _add('cu', url);
  void setHeadTitle(String title) => _add('ht', title);
  void clipboardWriteText(String text) => _add('nw', text);
  void scrollTo(Object x, Object y) => _add('ws', x.toString() + String.fromCharCode(_gs) + y.toString());
  void historyGo(Object steps) => _add('wg', steps.toString());
  void reloadPage() => _add('lr');
  void redirect(String path) => _add('lh', path);

  // Increase
  void increaseMinLength(String inputPlace, Object value) => _add('+n$inputPlace', value.toString());
  void increaseMaxLength(String inputPlace, Object value) => _add('+x$inputPlace', value.toString());
  void increaseFontSize(String inputPlace, Object value) => _add('+f$inputPlace', value.toString());
  void increaseWidth(String inputPlace, Object value) => _add('+w$inputPlace', value.toString());
  void increaseHeight(String inputPlace, Object value) => _add('+h$inputPlace', value.toString());
  void increaseValue(String inputPlace, Object value) => _add('+v$inputPlace', value.toString());

  // Decrease
  void decreaseMinLength(String inputPlace, Object value) => _add('-n$inputPlace', value.toString());
  void decreaseMaxLength(String inputPlace, Object value) => _add('-x$inputPlace', value.toString());
  void decreaseFontSize(String inputPlace, Object value) => _add('-f$inputPlace', value.toString());
  void decreaseWidth(String inputPlace, Object value) => _add('-w$inputPlace', value.toString());
  void decreaseHeight(String inputPlace, Object value) => _add('-h$inputPlace', value.toString());
  void decreaseValue(String inputPlace, Object value) => _add('-v$inputPlace', value.toString());

  // Event
  // ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
  // All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.
  void triggerEvent(String inputPlace, String htmlEventListener, [String? constructorName]) => _add('TE$inputPlace', htmlEventListener + (constructorName != null ? '${String.fromCharCode(_gs)}$constructorName' : ''));
  void setPostEvent(String inputPlace, String htmlEvent, [String? outputPlace]) => _add('Ep$inputPlace', htmlEvent + (outputPlace != null ? '${String.fromCharCode(_gs)}$outputPlace' : ''));
  void setPostEventAddView(String inputPlace, String htmlEvent) => _add('Ep$inputPlace', htmlEvent + String.fromCharCode(_gs) + '+');
  void setPostEventListener(String inputPlace, String htmlEventListener, [String? outputPlace]) => _add('EP$inputPlace', htmlEventListener + (outputPlace != null ? '${String.fromCharCode(_gs)}$outputPlace' : ''));
  void setPostEventListenerAddView(String inputPlace, String htmlEventListener) => _add('EP$inputPlace', htmlEventListener + String.fromCharCode(_gs) + '+');
  void setGetEvent(String inputPlace, String htmlEvent, [String? pathOrOutput, String? outputPlace]) {
    if (outputPlace != null) {
      _add('Eg$inputPlace', htmlEvent + String.fromCharCode(_gs) + (pathOrOutput ?? '#') + String.fromCharCode(_gs) + outputPlace);
    } else {
      _add('Eg$inputPlace', htmlEvent + String.fromCharCode(_gs) + (pathOrOutput ?? '#'));
    }
  }
  void setGetEventListener(String inputPlace, String htmlEventListener, [String? pathOrOutput, String? outputPlace]) {
    if (outputPlace != null) {
      _add('EG$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (pathOrOutput ?? '#') + String.fromCharCode(_gs) + outputPlace);
    } else {
      _add('EG$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (pathOrOutput ?? '#'));
    }
  }
  void setPutEvent(String inputPlace, String htmlEvent, [String? pathOrOutput, String? outputPlace]) {
    if (outputPlace != null) {
      _add('Et$inputPlace', htmlEvent + String.fromCharCode(_gs) + (pathOrOutput ?? '#') + String.fromCharCode(_gs) + outputPlace);
    } else {
      _add('Et$inputPlace', htmlEvent + String.fromCharCode(_gs) + (pathOrOutput ?? '#'));
    }
  }
  void setPutEventListener(String inputPlace, String htmlEventListener, [String? pathOrOutput, String? outputPlace]) {
    if (outputPlace != null) {
      _add('ET$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (pathOrOutput ?? '#') + String.fromCharCode(_gs) + outputPlace);
    } else {
      _add('ET$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (pathOrOutput ?? '#'));
    }
  }
  void setPatchEvent(String inputPlace, String htmlEvent, [String? pathOrOutput, String? outputPlace]) {
    if (outputPlace != null) {
      _add('Ea$inputPlace', htmlEvent + String.fromCharCode(_gs) + (pathOrOutput ?? '#') + String.fromCharCode(_gs) + outputPlace);
    } else {
      _add('Ea$inputPlace', htmlEvent + String.fromCharCode(_gs) + (pathOrOutput ?? '#'));
    }
  }
  void setPatchEventListener(String inputPlace, String htmlEventListener, [String? pathOrOutput, String? outputPlace]) {
    if (outputPlace != null) {
      _add('EA$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (pathOrOutput ?? '#') + String.fromCharCode(_gs) + outputPlace);
    } else {
      _add('EA$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (pathOrOutput ?? '#'));
    }
  }
  void setDeleteEvent(String inputPlace, String htmlEvent, [String? pathOrOutput, String? outputPlace]) {
    if (outputPlace != null) {
      _add('El$inputPlace', htmlEvent + String.fromCharCode(_gs) + (pathOrOutput ?? '#') + String.fromCharCode(_gs) + outputPlace);
    } else {
      _add('El$inputPlace', htmlEvent + String.fromCharCode(_gs) + (pathOrOutput ?? '#'));
    }
  }
  void setDeleteEventListener(String inputPlace, String htmlEventListener, [String? pathOrOutput, String? outputPlace]) {
    if (outputPlace != null) {
      _add('EL$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (pathOrOutput ?? '#') + String.fromCharCode(_gs) + outputPlace);
    } else {
      _add('EL$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (pathOrOutput ?? '#'));
    }
  }
  void setOptionsEvent(String inputPlace, String htmlEvent, [String? pathOrOutput, String? outputPlace]) {
    if (outputPlace != null) {
      _add('Eo$inputPlace', htmlEvent + String.fromCharCode(_gs) + (pathOrOutput ?? '#') + String.fromCharCode(_gs) + outputPlace);
    } else {
      _add('Eo$inputPlace', htmlEvent + String.fromCharCode(_gs) + (pathOrOutput ?? '#'));
    }
  }
  void setOptionsEventListener(String inputPlace, String htmlEventListener, [String? pathOrOutput, String? outputPlace]) {
    if (outputPlace != null) {
      _add('EO$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (pathOrOutput ?? '#') + String.fromCharCode(_gs) + outputPlace);
    } else {
      _add('EO$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (pathOrOutput ?? '#'));
    }
  }
  void setHeadEvent(String inputPlace, String htmlEvent, [String? path]) => _add('Eh$inputPlace', htmlEvent + String.fromCharCode(_gs) + (path ?? '#'));
  void setHeadEventListener(String inputPlace, String htmlEventListener, [String? path]) => _add('EH$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (path ?? '#'));
  // IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
  void setSendEvent(String inputPlace, String htmlEvent, String data, {String? path, String method = 'POST', bool isMultiPart = false, String contentType = 'text/plain', String? outputPlace}) => _add('En$inputPlace', htmlEvent + String.fromCharCode(_gs) + data.replaceAll('\n', r'$[ln];').replaceAll('"', r'$[dq];').replaceAll("'", r'$[sq];') + String.fromCharCode(_gs) + (path ?? '#') + String.fromCharCode(_gs) + method + String.fromCharCode(_gs) + (isMultiPart ? '1' : '0') + String.fromCharCode(_gs) + contentType + String.fromCharCode(_gs) + (outputPlace ?? ''));
  void setSendEventListener(String inputPlace, String htmlEventListener, String data, {String? path, String method = 'POST', bool isMultiPart = false, String contentType = 'text/plain', String? outputPlace}) => _add('EN$inputPlace', htmlEventListener + String.fromCharCode(_gs) + data.replaceAll('\n', r'$[ln];') + String.fromCharCode(_gs) + (path ?? '#') + String.fromCharCode(_gs) + method + String.fromCharCode(_gs) + (isMultiPart ? '1' : '0') + String.fromCharCode(_gs) + contentType + String.fromCharCode(_gs) + (outputPlace ?? ''));
  void setCommentEvent(String inputPlace, String htmlEvent, {Object? index, String? outputPlace}) => _add('Eb$inputPlace', htmlEvent + String.fromCharCode(_gs) + (index?.toString() ?? '') + String.fromCharCode(_gs) + (outputPlace ?? ''));
  void setCommentEventListener(String inputPlace, String htmlEventListener, {Object? index, String? outputPlace}) => _add('EB$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (index?.toString() ?? '') + String.fromCharCode(_gs) + (outputPlace ?? ''));
  void setWasmEvent(String inputPlace, String htmlEvent, String wasmLanguage, String wasmUrl, String methodName, {List<Object>? args, String? outputPlace}) {
    String argsJoin = '';
    if (args != null && args.isNotEmpty) {
      argsJoin = '[' + args.map((e) => e.toString()).join(String.fromCharCode(_us));
    }
    _add('Ey$inputPlace', htmlEvent + String.fromCharCode(_gs) + wasmLanguage + String.fromCharCode(_gs) + wasmUrl + String.fromCharCode(_gs) + methodName + String.fromCharCode(_gs) + argsJoin + String.fromCharCode(_gs) + (outputPlace ?? ''));
  }
  void setWasmEventListener(String inputPlace, String htmlEventListener, String wasmLanguage, String wasmUrl, String methodName, {List<Object>? args, String? outputPlace}) {
    String argsJoin = '';
    if (args != null && args.isNotEmpty) {
      argsJoin = '[' + args.map((e) => e.toString()).join(String.fromCharCode(_us));
    }
    _add('EY$inputPlace', htmlEventListener + String.fromCharCode(_gs) + wasmLanguage + String.fromCharCode(_gs) + wasmUrl + String.fromCharCode(_gs) + methodName + String.fromCharCode(_gs) + argsJoin + String.fromCharCode(_gs) + (outputPlace ?? ''));
  }
  void setWebSocketEvent(String inputPlace, String htmlEvent, String path) => _add('Ew$inputPlace', htmlEvent + String.fromCharCode(_gs) + path);
  void setWebSocketEventListener(String inputPlace, String htmlEventListener, String path) => _add('EW$inputPlace', htmlEventListener + String.fromCharCode(_gs) + path);
  void setSseEvent(String inputPlace, String htmlEvent, String path, {bool shouldReconnect = true, int reconnectTryTimeout = 3000, String? outputPlace}) {
    if (outputPlace != null) {
      _add('Ee$inputPlace', htmlEvent + String.fromCharCode(_gs) + path + String.fromCharCode(_gs) + (shouldReconnect ? '1' : '0') + String.fromCharCode(_gs) + reconnectTryTimeout.toString() + String.fromCharCode(_gs) + outputPlace);
    } else {
      _add('Ee$inputPlace', htmlEvent + String.fromCharCode(_gs) + path + String.fromCharCode(_gs) + (shouldReconnect ? '1' : '0') + String.fromCharCode(_gs) + reconnectTryTimeout.toString());
    }
  }
  void setSseEventListener(String inputPlace, String htmlEventListener, String path, {bool shouldReconnect = true, int reconnectTryTimeout = 3000, String? outputPlace}) {
    if (outputPlace != null) {
      _add('EE$inputPlace', htmlEventListener + String.fromCharCode(_gs) + path + String.fromCharCode(_gs) + (shouldReconnect ? '1' : '0') + String.fromCharCode(_gs) + reconnectTryTimeout.toString() + String.fromCharCode(_gs) + outputPlace);
    } else {
      _add('EE$inputPlace', htmlEventListener + String.fromCharCode(_gs) + path + String.fromCharCode(_gs) + (shouldReconnect ? '1' : '0') + String.fromCharCode(_gs) + reconnectTryTimeout.toString());
    }
  }
  void setFrontEvent(String inputPlace, String htmlEvent, String modulePath, {List<Object>? args, String? outputPlace}) {
    String argsJoin = '';
    if (args != null && args.isNotEmpty) {
      argsJoin = String.fromCharCode(_gs) + '[' + args.map((e) => e.toString()).join(String.fromCharCode(_us));
    }
    _add('Ej$inputPlace', htmlEvent + String.fromCharCode(_gs) + modulePath + String.fromCharCode(_gs) + (outputPlace ?? '') + argsJoin);
  }
  void setFrontEventListener(String inputPlace, String htmlEventListener, String modulePath, {List<Object>? args, String? outputPlace}) {
    String argsJoin = '';
    if (args != null && args.isNotEmpty) {
      argsJoin = String.fromCharCode(_gs) + '[' + args.map((e) => e.toString()).join(String.fromCharCode(_us));
    }
    _add('EJ$inputPlace', htmlEventListener + String.fromCharCode(_gs) + modulePath + String.fromCharCode(_gs) + (outputPlace ?? '') + argsJoin);
  }
  void setMasterPagesEvent(String inputPlace, String htmlEvent, [String? outputPlace]) => _add('Eu$inputPlace', htmlEvent + String.fromCharCode(_gs) + (outputPlace ?? ''));
  void setMasterPagesEventListener(String inputPlace, String htmlEventListener, [String? outputPlace]) => _add('EU$inputPlace', htmlEventListener + String.fromCharCode(_gs) + (outputPlace ?? ''));
  void setPreventDefaultEvent(String inputPlace, String htmlEvent) => _add('Ed$inputPlace', htmlEvent);
  void setPreventDefaultEventListener(String inputPlace, String htmlEventListener) => _add('ED$inputPlace', htmlEventListener);
  void setStopPropagationEvent(String inputPlace, String htmlEvent) => _add('Es$inputPlace', htmlEvent);
  void setStopPropagationEventListener(String inputPlace, String htmlEventListener) => _add('ES$inputPlace', htmlEventListener);
  void setMethodEvent(String inputPlace, String htmlEvent, String methodName, {List<Object>? args}) {
    String argsJoin = '';
    if (args != null && args.isNotEmpty) {
      argsJoin = String.fromCharCode(_gs) + '[' + args.map((e) => e.toString()).join(String.fromCharCode(_us));
    }
    _add('Em$inputPlace', htmlEvent + String.fromCharCode(_gs) + methodName + argsJoin);
  }
  void setMethodEventListener(String inputPlace, String htmlEventListener, String methodName, {List<Object>? args}) {
    String argsJoin = '';
    if (args != null && args.isNotEmpty) {
      argsJoin = String.fromCharCode(_gs) + '[' + args.map((e) => e.toString()).join(String.fromCharCode(_us));
    }
    _add('EM$inputPlace', htmlEventListener + String.fromCharCode(_gs) + methodName + argsJoin);
  }
  void setModuleMethodEvent(String inputPlace, String htmlEvent, String methodName, {List<Object>? args}) {
    String argsJoin = '';
    if (args != null && args.isNotEmpty) {
      argsJoin = String.fromCharCode(_gs) + '[' + args.map((e) => e.toString()).join(String.fromCharCode(_us));
    }
    _add('Ex$inputPlace', htmlEvent + String.fromCharCode(_gs) + methodName + argsJoin);
  }
  void setModuleMethodEventListener(String inputPlace, String htmlEventListener, String methodName, {List<Object>? args}) {
    String argsJoin = '';
    if (args != null && args.isNotEmpty) {
      argsJoin = String.fromCharCode(_gs) + '[' + args.map((e) => e.toString()).join(String.fromCharCode(_us));
    }
    _add('EX$inputPlace', htmlEventListener + String.fromCharCode(_gs) + methodName + argsJoin);
  }
  void assignConfirmEvent(String inputPlace, String htmlEvent, {String text = 'Are you sure you want to proceed?', String type = 'none', String title = 'Confirm', String okText = 'OK', String cancelText = 'Cancel'}) => _add('Ef$inputPlace', htmlEvent + String.fromCharCode(_gs) + (text == 'Are you sure you want to proceed?' ? '' : text) + String.fromCharCode(_gs) + (type == 'none' ? '' : type) + String.fromCharCode(_gs) + (title == 'Confirm' ? '' : title) + String.fromCharCode(_gs) + (okText == 'OK' ? '' : okText) + String.fromCharCode(_gs) + (cancelText == 'Cancel' ? '' : cancelText));
  void removePostEvent(String inputPlace, String htmlEvent) => _add('Rp$inputPlace', htmlEvent);
  void removePostEventListener(String inputPlace, String htmlEventListener) => _add('RP$inputPlace', htmlEventListener);
  void removeGetEvent(String inputPlace, String htmlEvent) => _add('Rg$inputPlace', htmlEvent);
  void removeGetEventListener(String inputPlace, String htmlEventListener) => _add('RG$inputPlace', htmlEventListener);
  void removePutEvent(String inputPlace, String htmlEvent) => _add('Rt$inputPlace', htmlEvent);
  void removePutEventListener(String inputPlace, String htmlEventListener) => _add('RT$inputPlace', htmlEventListener);
  void removePatchEvent(String inputPlace, String htmlEvent) => _add('Ra$inputPlace', htmlEvent);
  void removePatchEventListener(String inputPlace, String htmlEventListener) => _add('RA$inputPlace', htmlEventListener);
  void removeDeleteEvent(String inputPlace, String htmlEvent) => _add('Rl$inputPlace', htmlEvent);
  void removeDeleteEventListener(String inputPlace, String htmlEventListener) => _add('RL$inputPlace', htmlEventListener);
  void removeOptionsEvent(String inputPlace, String htmlEvent) => _add('Ro$inputPlace', htmlEvent);
  void removeOptionsEventListener(String inputPlace, String htmlEventListener) => _add('RO$inputPlace', htmlEventListener);
  void removeHeadEvent(String inputPlace, String htmlEvent) => _add('Rh$inputPlace', htmlEvent);
  void removeHeadEventListener(String inputPlace, String htmlEventListener) => _add('RH$inputPlace', htmlEventListener);
  void removeSendEvent(String inputPlace, String htmlEvent) => _add('Rn$inputPlace', htmlEvent);
  void removeSendEventListener(String inputPlace, String htmlEventListener) => _add('RN$inputPlace', htmlEventListener);
  void removeCommentEvent(String inputPlace, String htmlEvent) => _add('Rb$inputPlace', htmlEvent);
  void removeCommentEventListener(String inputPlace, String htmlEventListener) => _add('RB$inputPlace', htmlEventListener);
  void removeWasmEvent(String inputPlace, String htmlEvent) => _add('Ry$inputPlace', htmlEvent);
  void removeWasmEventListener(String inputPlace, String htmlEventListener) => _add('RY$inputPlace', htmlEventListener);
  void removeWebSocketEvent(String inputPlace, String htmlEvent) => _add('Rw$inputPlace', htmlEvent);
  void removeWebSocketEventListener(String inputPlace, String htmlEventListener) => _add('RW$inputPlace', htmlEventListener);
  void removeSseEvent(String inputPlace, String htmlEvent) => _add('Re$inputPlace', htmlEvent);
  void removeSseEventListener(String inputPlace, String htmlEventListener) => _add('RE$inputPlace', htmlEventListener);
  void removeFrontEvent(String inputPlace, String htmlEvent) => _add('Rj$inputPlace', htmlEvent);
  void removeFrontEventListener(String inputPlace, String htmlEventListener) => _add('RJ$inputPlace', htmlEventListener);
  void removePreventDefaultEvent(String inputPlace, String htmlEvent) => _add('Rd$inputPlace', htmlEvent);
  void removePreventDefaultEventListener(String inputPlace, String htmlEventListener) => _add('RD$inputPlace', htmlEventListener);
  void removeMasterPagesEvent(String inputPlace, String htmlEvent) => _add('Ru$inputPlace', htmlEvent);
  void removeMasterPagesEventListener(String inputPlace, String htmlEventListener) => _add('RU$inputPlace', htmlEventListener);
  void removeStopPropagationEvent(String inputPlace, String htmlEvent) => _add('Rs$inputPlace', htmlEvent);
  void removeStopPropagationEventListener(String inputPlace, String htmlEventListener) => _add('RS$inputPlace', htmlEventListener);
  void removeMethodEvent(String inputPlace, String htmlEvent, String methodName) => _add('Rm$inputPlace', htmlEvent + String.fromCharCode(_gs) + methodName);
  void removeMethodEventListener(String inputPlace, String htmlEventListener, String methodName) => _add('RM$inputPlace', htmlEventListener + String.fromCharCode(_gs) + methodName);
  void removeModuleMethodEvent(String inputPlace, String htmlEvent, String methodName) => _add('Rx$inputPlace', htmlEvent + String.fromCharCode(_gs) + methodName);
  void removeModuleMethodEventListener(String inputPlace, String htmlEventListener, String methodName) => _add('RX$inputPlace', htmlEventListener + String.fromCharCode(_gs) + methodName);
  void removeConfirmEvent(String inputPlace, String htmlEvent) => _add('Rf$inputPlace', htmlEvent);

  // Custom Event
  // This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
  // Watch: attribute, style, text, children, value
  // Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
  // Range: Only Use For Compare With inrange Value. Split By Comma ","
  // Key: Only Use For Watch With attribute And style Value
  void createCustomDomEvent(String inputPlace, String eventName, String watch, String key, String compare, String value, String range, {bool immediate = false, Object? delay}) {
    String delayStr = delay is int ? delay.toString() : (delay?.toString() ?? '0');
    _add('eC$inputPlace', eventName + String.fromCharCode(_gs) + watch + String.fromCharCode(_gs) + key + String.fromCharCode(_gs) + compare + String.fromCharCode(_gs) + value + String.fromCharCode(_gs) + range + String.fromCharCode(_gs) + (immediate ? '1' : '0') + String.fromCharCode(_gs) + delayStr);
  }
  void enableScrollBottomEvent({bool enable = true}) => _add('eb', enable ? '1' : '0');
  void enableReachedElementEvent(String inputPlace, bool once, {bool enable = true}) => _add('er$inputPlace', (once ? '1' : '0') + String.fromCharCode(_gs) + (enable ? '1' : '0'));

  // Module
  void loadModule(String modulePath, [List<String>? methods]) {
    methods ??= const [];
    _add('Ml', modulePath + ((methods.isNotEmpty) ? String.fromCharCode(_gs) + '[' + methods.join(String.fromCharCode(_us)) : ''));
  }
  void unloadModule(String modulePath) => _add('Mu', modulePath);
  void deleteModuleMethod(String methodName) => _add('Md', methodName);

  // Unit Testing
  // InputPlace Is Actual, Expected Is Tag/OutputPlace
  void assertEqual(String inputPlace, String tag) => _add('At$inputPlace', tag.replaceAll('\n', r'$[ln];'));
  void assertEqualByOutputPlace(String inputPlace, String outputPlace) => _add('Ao$inputPlace', outputPlace);

  // Debug
  void createDebugger({bool pause = false}) => _add('Dc', pause ? '1' : '0');

  // Service Worker
  // To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
  void serviceWorkerRegister({String? path, String? scopePath}) => _add('wR', (path ?? '') + String.fromCharCode(_gs) + (scopePath ?? ''));
  void serviceWorkerPreCacheStatic(List<String> pathList) => _add('wp', pathList.join(String.fromCharCode(_gs)));
  void serviceWorkerDynamicCache(String path, [Object? seconds]) {
    String secStr = seconds is int ? (seconds > 0 ? seconds.toString() : '') : (seconds?.toString() ?? '');
    _add('wc', path + (secStr.isNotEmpty ? String.fromCharCode(_gs) + secStr : ''));
  }
  void serviceWorkerDeleteDynamicCache([String? path]) => _add('wd', path ?? '');
  void serviceWorkerDynamicCacheTtlUpdate(String path, [Object? seconds]) {
    String secStr = seconds is int ? (seconds > 0 ? seconds.toString() : '') : (seconds?.toString() ?? '');
    _add('wt', path + (secStr.isNotEmpty ? String.fromCharCode(_gs) + secStr : ''));
  }
  // Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
  // Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
  // CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
  void serviceWorkerRouteSet(String path, String type, {bool cacheDynamic = false}) => _add('wr', path + String.fromCharCode(_gs) + type + (cacheDynamic ? String.fromCharCode(_gs) + '1' : ''));
  void serviceWorkerRouteAlias(String path, String to) => _add('wa', path + String.fromCharCode(_gs) + to);
  void serviceWorkerDeleteRouteAlias([String? path]) => _add('wC', path ?? '');
  // Delete All Route And Alias
  void serviceWorkerDeleteRoute([String? path]) => _add('wD', path ?? '');

  // SSE
  void disconnectSse(String path) => _add('Ds', path);
  void disconnectAllSse() => _add('Ds');

  // State
  void addState({String? path, String? title}) => _add('AS', (path ?? '') + String.fromCharCode(_gs) + (title ?? ''));
  void saveState({String? path, String? title}) => _add('As', (path ?? '') + String.fromCharCode(_gs) + (title ?? ''));
  void loadState(String path) => _add('ls', path);
  void deleteState([String? path]) => _add('DS', path ?? '');
  void deleteAllState() => _add('DS', '*');

  // Cookie
  void setCookie(String key, String value, Object seconds, [String? path]) {
    _add('sC', key + String.fromCharCode(_gs) + value + String.fromCharCode(_gs) + seconds.toString() + (path != null ? String.fromCharCode(_gs) + path : ''));
  }

  // Save (Session Cache)
  void saveId(String inputPlace, [String key = '.']) => _add('@gi$inputPlace', key);
  void saveName(String inputPlace, [String key = '.']) => _add('@gn$inputPlace', key);
  void saveValue(String inputPlace, [String key = '.']) => _add('@gv$inputPlace', key);
  void saveValueLength(String inputPlace, [String key = '.']) => _add('@ge$inputPlace', key);
  void saveClass(String inputPlace, [String key = '.']) => _add('@gc$inputPlace', key);
  void saveStyle(String inputPlace, [String key = '.']) => _add('@gs$inputPlace', key);
  void saveTitle(String inputPlace, [String key = '.']) => _add('@gl$inputPlace', key);
  void saveLabel(String inputPlace, [String key = '.']) => _add('@gA$inputPlace', key);
  void saveText(String inputPlace, [String key = '.']) => _add('@gt$inputPlace', key);
  void saveOuterText(String inputPlace, [String key = '.']) => _add('@go$inputPlace', key);
  void saveTextLength(String inputPlace, [String key = '.']) => _add('@gg$inputPlace', key);
  void saveAttribute(String inputPlace, String attribute, [String key = '.']) => _add('@ga$inputPlace', key + String.fromCharCode(_gs) + attribute);
  void saveWidth(String inputPlace, [String key = '.']) => _add('@gw$inputPlace', key);
  void saveHeight(String inputPlace, [String key = '.']) => _add('@gh$inputPlace', key);
  void saveReadOnly(String inputPlace, [String key = '.']) => _add('@gr$inputPlace', key);
  void saveSelectedIndex(String inputPlace, [String key = '.']) => _add('@gx$inputPlace', key);
  void saveTextAlign(String inputPlace, [String key = '.']) => _add('@gT$inputPlace', key);
  void saveNodeLength(String inputPlace, [String key = '.']) => _add('@gL$inputPlace', key);
  void saveVisible(String inputPlace, [String key = '.']) => _add('@gV$inputPlace', key);
  void saveUrl(String url, {bool fetchScript = false, String key = '.'}) => _add('@gu', key + String.fromCharCode(_gs) + url + (fetchScript ? String.fromCharCode(_gs) + '1' : ''));
  void saveIndex(String inputPlace, [String key = '.']) => _add('@gI$inputPlace', key);
  void removeSave(String cacheKey) => _add('rs', cacheKey);
  void removeAllSave() => _add('rs', '*');
  // Calling the SetSave Method Causes Action Control Requests Triggered by Events Using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send Event, to be Temporarily Saved on the Active Page, so the Request will not be Sent to the Server Again.
  void setSave() => _add('cs', '*');
  void addSaveValue(String cacheKey, String value) => _add('SA', cacheKey + String.fromCharCode(_gs) + value.replaceAll('\n', r'$[ln];'));
  void insertSaveValue(String cacheKey, String value) => _add('SI', cacheKey + String.fromCharCode(_gs) + value.replaceAll('\n', r'$[ln];'));
  void appendSaveValue(String cacheKey, String value) => _add('SP', cacheKey + String.fromCharCode(_gs) + value.replaceAll('\n', r'$[ln];'));
  void replaceSaveValue(String cacheKey, String searchValue, String value) => _add('SR', cacheKey + String.fromCharCode(_gs) + value.replaceAll('\n', r'$[ln];') + String.fromCharCode(_gs) + searchValue.replaceAll('\n', r'$[ln];'));

  // Cache
  void cacheId(String inputPlace, [String key = '.']) => _add('@ci$inputPlace', key);
  void cacheName(String inputPlace, [String key = '.']) => _add('@cn$inputPlace', key);
  void cacheValue(String inputPlace, [String key = '.']) => _add('@cv$inputPlace', key);
  void cacheValueLength(String inputPlace, [String key = '.']) => _add('@ce$inputPlace', key);
  void cacheClass(String inputPlace, [String key = '.']) => _add('@cc$inputPlace', key);
  void cacheStyle(String inputPlace, [String key = '.']) => _add('@cs$inputPlace', key);
  void cacheTitle(String inputPlace, [String key = '.']) => _add('@cl$inputPlace', key);
  void cacheLabel(String inputPlace, [String key = '.']) => _add('@cA$inputPlace', key);
  void cacheText(String inputPlace, [String key = '.']) => _add('@ct$inputPlace', key);
  void cacheOuterText(String inputPlace, [String key = '.']) => _add('@co$inputPlace', key);
  void cacheTextLength(String inputPlace, [String key = '.']) => _add('@cg$inputPlace', key);
  void cacheAttribute(String inputPlace, String attribute, [String key = '.']) => _add('@ca$inputPlace', key + String.fromCharCode(_gs) + attribute);
  void cacheWidth(String inputPlace, [String key = '.']) => _add('@cw$inputPlace', key);
  void cacheHeight(String inputPlace, [String key = '.']) => _add('@ch$inputPlace', key);
  void cacheReadOnly(String inputPlace, [String key = '.']) => _add('@cr$inputPlace', key);
  void cacheSelectedIndex(String inputPlace, [String key = '.']) => _add('@cx$inputPlace', key);
  void cacheTextAlign(String inputPlace, [String key = '.']) => _add('@cT$inputPlace', key);
  void cacheNodeLength(String inputPlace, [String key = '.']) => _add('@cL$inputPlace', key);
  void cacheVisible(String inputPlace, [String key = '.']) => _add('@cV$inputPlace', key);
  void cacheUrl(String url, {bool fetchScript = false, String key = '.'}) => _add('@cu', key + String.fromCharCode(_gs) + url + (fetchScript ? String.fromCharCode(_gs) + '1' : ''));
  void cacheIndex(String inputPlace, [String key = '.']) => _add('@cI$inputPlace', key);
  void removeCache(String cacheKey) => _add('rd', cacheKey);
  void removeAllCache() => _add('rd', '*');
  // Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
  void setCache([Object? second]) {
    if (second == null) {
      _add('cd', '*');
    } else {
      _add('cd', second.toString());
    }
  }
  void addCacheValue(String cacheKey, String value) => _add('CA', cacheKey + String.fromCharCode(_gs) + value.replaceAll('\n', r'$[ln];'));
  void insertCacheValue(String cacheKey, String value) => _add('CI', cacheKey + String.fromCharCode(_gs) + value.replaceAll('\n', r'$[ln];'));
  void appendCacheValue(String cacheKey, String value) => _add('CP', cacheKey + String.fromCharCode(_gs) + value.replaceAll('\n', r'$[ln];'));
  void replaceCacheValue(String cacheKey, String searchValue, String value) => _add('CR', cacheKey + String.fromCharCode(_gs) + value.replaceAll('\n', r'$[ln];') + String.fromCharCode(_gs) + searchValue.replaceAll('\n', r'$[ln];'));

  // Call
  void loadUrl(String inputPlace, String url) => _add('lu$inputPlace', url);
  void runActionControls(String actionControls, {bool withoutWebFormsSection = true, String? index, bool useCurrentEvent = true}) => _add('lA', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + (withoutWebFormsSection ? '1' : '0') + String.fromCharCode(_gs) + (index ?? '') + String.fromCharCode(_gs) + actionControls);
  void callScript(String scriptText) => _add('_', scriptText.replaceAll('\n', r'$[ln];'));
  void callMethod(String methodName, {List<Object>? args}) {
    String argsJoin = '';
    if (args != null && args.isNotEmpty) {
      argsJoin = String.fromCharCode(_gs) + '[' + args.map((e) => e.toString()).join(String.fromCharCode(_us));
    }
    _add('lm', methodName + argsJoin);
  }
  void callModuleMethod(String methodName, {List<Object>? args}) {
    String argsJoin = '';
    if (args != null && args.isNotEmpty) {
      argsJoin = String.fromCharCode(_gs) + '[' + args.map((e) => e.toString()).join(String.fromCharCode(_us));
    }
    _add('lM', methodName + argsJoin);
  }
  void callPostBack(String formInputPlace, [String? outputPlace]) => _add('Lp', '1' + String.fromCharCode(_gs) + formInputPlace + (outputPlace != null ? String.fromCharCode(_gs) + outputPlace : ''));
  void callCommentBack({Object? index, String? inputPlace, bool useCurrentEvent = true}) => _add('LC', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + (index?.toString() ?? '') + String.fromCharCode(_gs) + (inputPlace ?? ''));
  void callWasmBack(String wasmLanguage, String wasmUrl, String methodName, {List<Object>? args, String? outputPlace, bool useCurrentEvent = true}) {
    String argsJoin = '';
    if (args != null && args.isNotEmpty) {
      argsJoin = '[' + args.map((e) => e.toString()).join(String.fromCharCode(_us));
    }
    _add('Ly', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + wasmLanguage + String.fromCharCode(_gs) + wasmUrl + String.fromCharCode(_gs) + methodName + String.fromCharCode(_gs) + argsJoin + String.fromCharCode(_gs) + (outputPlace ?? ''));
  }
  void callWebSocketBack(String path, {bool useCurrentEvent = true}) => _add('Lw', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + path);
  void callSseBack(String path, {String? outputPlace, bool useCurrentEvent = true, bool shouldReconnect = true, Object? reconnectTryTimeout}) {
    String timeoutStr = reconnectTryTimeout is int ? reconnectTryTimeout.toString() : (reconnectTryTimeout?.toString() ?? '3000');
    _add('Ls', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + path + String.fromCharCode(_gs) + (shouldReconnect ? '1' : '0') + String.fromCharCode(_gs) + timeoutStr + (outputPlace != null ? String.fromCharCode(_gs) + outputPlace : ''));
  }
  void callFront(String modulePath, {List<Object>? args, String? outputPlace, bool useCurrentEvent = true}) {
    String argsJoin = '';
    if (args != null && args.isNotEmpty) {
      argsJoin = String.fromCharCode(_gs) + '[' + args.map((e) => e.toString()).join(String.fromCharCode(_us));
    }
    _add('Lj', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + modulePath + String.fromCharCode(_gs) + (outputPlace ?? '') + argsJoin);
  }
  void callGetBack(String path, {String? outputPlace, bool useCurrentEvent = true}) => _add('Lg', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + path + (outputPlace != null ? String.fromCharCode(_gs) + outputPlace : ''));
  void callPutBack(String path, {String? outputPlace, bool useCurrentEvent = true}) => _add('Lt', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + path + (outputPlace != null ? String.fromCharCode(_gs) + outputPlace : ''));
  void callPatchBack(String path, {String? outputPlace, bool useCurrentEvent = true}) => _add('LP', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + path + (outputPlace != null ? String.fromCharCode(_gs) + outputPlace : ''));
  void callDeleteBack(String path, {String? outputPlace, bool useCurrentEvent = true}) => _add('Ld', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + path + (outputPlace != null ? String.fromCharCode(_gs) + outputPlace : ''));
  void callHeadBack(String path, {bool useCurrentEvent = true}) => _add('Lh', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + path);
  void callOptionsBack(String path, {String? outputPlace, bool useCurrentEvent = true}) => _add('Lo', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + path + (outputPlace != null ? String.fromCharCode(_gs) + outputPlace : ''));
  void callSendBack(String path, String method, bool isMultiPart, String contentType, String data, {String? outputPlace, bool useCurrentEvent = true}) => _add('LS', (useCurrentEvent ? '1' : '0') + String.fromCharCode(_gs) + path + String.fromCharCode(_gs) + method + String.fromCharCode(_gs) + (isMultiPart ? '1' : '0') + String.fromCharCode(_gs) + contentType + String.fromCharCode(_gs) + data.replaceAll('\n', r'$[ln];') + (outputPlace != null ? String.fromCharCode(_gs) + outputPlace : ''));

  // Update
  void increase(String inputPlace, double value) => _add('gt$inputPlace', 'i' + String.fromCharCode(_gs) + value.toString());
  void decrease(String inputPlace, double value) => _add('gt$inputPlace', 'i' + String.fromCharCode(_gs) + (value * -1).toString());
  // If You Don't Use Deep Mode, any Tags Inside the Current Tag Will Simply Be Treated as Strings. Deep Mode Does not Remove Inner Elements.
  void replace(String inputPlace, String value, String newValue, {bool alsoStartTag = false, bool deep = true}) => _add('gt$inputPlace', 'r' + String.fromCharCode(_gs) + value + String.fromCharCode(_gs) + newValue + String.fromCharCode(_gs) + (alsoStartTag ? '1' : '0') + String.fromCharCode(_gs) + (deep ? '1' : '0'));
  // HTML Converts Attribute Names to Lowercase, so they Need to Be Written in Lowercase.
  void replaceStartTag(String inputPlace, String value, String newValue) => _add('gt$inputPlace', 's' + String.fromCharCode(_gs) + value + String.fromCharCode(_gs) + newValue);

  // Pre Runner
  void assignDelay(int miliSecond, {int index = -1}) {
    String currentLine = getLineByIndex(index);
    if (currentLine.isEmpty) return;

    int eqIndex = currentLine.indexOf('=');
    String namePart = eqIndex == -1 ? currentLine : currentLine.substring(0, eqIndex);
    String valuePart = eqIndex == -1 ? '' : currentLine.substring(eqIndex + 1);
    
    String newName = ':$miliSecond)$namePart';
    updateLineByIndex(index, newName, valuePart);
  }

  void assignDelayChange(int miliSecond, {int index = -1}) {
    String currentLine = getLineByIndex(index);
    if (currentLine.isEmpty) return;

    int eqIndex = currentLine.indexOf('=');
    String namePart = eqIndex == -1 ? currentLine : currentLine.substring(0, eqIndex);
    String valuePart = eqIndex == -1 ? '' : currentLine.substring(eqIndex + 1);
    
    String currentName = namePart;
    if (currentName.startsWith(':') && currentName.contains(')')) {
      int closingBracket = currentName.indexOf(')');
      currentName = currentName.substring(closingBracket + 1);
    }

    String newName = ':$miliSecond)$currentName';
    updateLineByIndex(index, newName, valuePart);
  }

  void assignInterval(int miliSecond, {String? id, int index = -1}) {
    String currentLine = getLineByIndex(index);
    if (currentLine.isEmpty) return;

    int eqIndex = currentLine.indexOf('=');
    String namePart = eqIndex == -1 ? currentLine : currentLine.substring(0, eqIndex);
    String valuePart = eqIndex == -1 ? '' : currentLine.substring(eqIndex + 1);
    
    String newName = '($miliSecond${id != null ? '|$id' : ''})$namePart';
    updateLineByIndex(index, newName, valuePart);
  }

  void assignIntervalChange(int miliSecond, {String? id, int index = -1}) {
    String currentLine = getLineByIndex(index);
    if (currentLine.isEmpty) return;

    int eqIndex = currentLine.indexOf('=');
    String namePart = eqIndex == -1 ? currentLine : currentLine.substring(0, eqIndex);
    String valuePart = eqIndex == -1 ? '' : currentLine.substring(eqIndex + 1);
    
    String currentName = namePart;
    if (currentName.startsWith('(') && currentName.contains(')')) {
      int closingBracket = currentName.indexOf(')');
      currentName = currentName.substring(closingBracket + 1);
    }

    String newName = '($miliSecond${id != null ? '|$id' : ''})$currentName';
    updateLineByIndex(index, newName, valuePart);
  }

  void deleteInterval(String id) => _add('Di', id);

  void assignRepeat(int count, {int index = -1}) {
    String currentLine = getLineByIndex(index);
    if (currentLine.isEmpty) return;

    int eqIndex = currentLine.indexOf('=');
    String namePart = eqIndex == -1 ? currentLine : currentLine.substring(0, eqIndex);
    String valuePart = eqIndex == -1 ? '' : currentLine.substring(eqIndex + 1);
    
    String newName = ',$count)$namePart';
    updateLineByIndex(index, newName, valuePart);
  }

  void assignRepeatChange(int count, {int index = -1}) {
    String currentLine = getLineByIndex(index);
    if (currentLine.isEmpty) return;

    int eqIndex = currentLine.indexOf('=');
    String namePart = eqIndex == -1 ? currentLine : currentLine.substring(0, eqIndex);
    String valuePart = eqIndex == -1 ? '' : currentLine.substring(eqIndex + 1);
    
    String currentName = namePart;
    if (currentName.startsWith(',') && currentName.contains(')')) {
      int closingBracket = currentName.indexOf(')');
      currentName = currentName.substring(closingBracket + 1);
    }

    String newName = ',$count)$currentName';
    updateLineByIndex(index, newName, valuePart);
  }

  // Index
  void startIndex([String name = '']) => _add('#', name);
  // This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
  void startState() => startIndex(r'$');
  void goTo(Object lineOrIndex, [Object? repeatOrIndex, Object? repeat]) {
    if (repeat != null) {
      _add('&', lineOrIndex.toString() + String.fromCharCode(_gs) + repeat.toString());
    } else if (repeatOrIndex != null) {
      _add('&', '#$lineOrIndex' + String.fromCharCode(_gs) + repeatOrIndex.toString());
    } else {
      _add('&', lineOrIndex.toString() + String.fromCharCode(_gs) + '1');
    }
  }

  // Start
  void startTransientDom(String inputPlace) => _add('td', inputPlace);
  void endTransientDom() => _add('td', ';');

  // Message
  // Type: warning, problem, help, success, none
  void alert(String text, {String type = 'none', String title = 'Alert', String okText = 'OK'}) => _add('Al', text + String.fromCharCode(_gs) + (type == 'none' ? '' : type) + String.fromCharCode(_gs) + (title == 'Alert' ? '' : title) + String.fromCharCode(_gs) + (okText == 'OK' ? '' : okText));
  void message(String text, {String type = 'none', Object? duration}) {
    String durStr = duration is int ? duration.toString() : (duration?.toString() ?? '0');
    _add('me', text + String.fromCharCode(_gs) + (type == 'none' ? '' : type) + String.fromCharCode(_gs) + (durStr == '0' ? '' : durStr));
  }

  // Type: log, info, warn, error, debug, trace, group, groupend, table
  void consoleMessage(String text, {String type = 'log'}) => _add('mc', text.replaceAll('\n', r'$[ln];') + (type == 'log' ? '' : String.fromCharCode(_gs) + type));
  void consoleMessageAssert(String text, String condition) => _add('ma', text.replaceAll('\n', r'$[ln];') + String.fromCharCode(_gs) + condition);

  // Enable
  //Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
  void enableWebSocket({bool enable = true}) => _add('ew', enable ? '1' : '0');
  void enableWebSocketOnce() => _add('ew', r'$');
  void addWebSocket(String path) => _add('aw$path');
  // Disconnected WebSocket
  void deleteWebSocket(String path) => _add('dw$path');

  // Use
  // InputPlace Using Only For form Element
  void useWebSocket(String inputPlace) => _add('uw$inputPlace');
  void useOnlyChangeUpdate(String inputPlace) => _add('uo$inputPlace');

  // Condition And Loop
  // Condition And Loop Supports Brackets and Then
  // Type: warning, problem, help, success, none
  // Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
  // Nested Conditions and Nested Loops are Possible.
  WebForms confirmIsTrueAccept({String text = 'Are you sure you want to proceed?', String type = 'none', String title = 'Confirm', String okText = 'OK', String cancelText = 'Cancel', int interval = 100}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'ct', (text == 'Are you sure you want to proceed?' ? '' : text) + String.fromCharCode(_gs) + (type == 'none' ? '' : type) + String.fromCharCode(_gs) + (title == 'Confirm' ? '' : title) + String.fromCharCode(_gs) + (okText == 'OK' ? '' : okText) + String.fromCharCode(_gs) + (cancelText == 'Cancel' ? '' : cancelText));
    return this;
  }
  WebForms confirmIsFalseAccept({String text = 'Are you sure you want to proceed?', String type = 'none', String title = 'Confirm', String okText = 'OK', String cancelText = 'Cancel', int interval = 100}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'cf', (text == 'Are you sure you want to proceed?' ? '' : text) + String.fromCharCode(_gs) + (type == 'none' ? '' : type) + String.fromCharCode(_gs) + (title == 'Confirm' ? '' : title) + String.fromCharCode(_gs) + (okText == 'OK' ? '' : okText) + String.fromCharCode(_gs) + (cancelText == 'Cancel' ? '' : cancelText));
    return this;
  }
  WebForms isGreaterThan(String firstValue, String secondValue, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'gt', firstValue + String.fromCharCode(_gs) + secondValue);
    return this;
  }
  WebForms isLessThan(String firstValue, String secondValue, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'lt', firstValue + String.fromCharCode(_gs) + secondValue);
    return this;
  }
  WebForms isEqualTo(String firstValue, String secondValue, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'et', firstValue + String.fromCharCode(_gs) + secondValue);
    return this;
  }
  WebForms isNotEqualTo(String firstValue, String secondValue, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'Nt', firstValue + String.fromCharCode(_gs) + secondValue);
    return this;
  }
  WebForms exist(String value, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'ex', value);
    return this;
  }
  WebForms notExist(String value, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'nx', value);
    return this;
  }
  WebForms isTrue(String value, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'tr', value);
    return this;
  }
  WebForms isFalse(String value, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'fa', value);
    return this;
  }
  WebForms isMatchMedia(String value, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'mm', value);
    return this;
  }
  WebForms isNotMatchMedia(String value, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'nm', value);
    return this;
  }
  WebForms include(String text, String value, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'In', value + String.fromCharCode(_gs) + text);
    return this;
  }
  WebForms notInclude(String text, String value, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'Nn', value + String.fromCharCode(_gs) + text);
    return this;
  }
  WebForms elementExists(String inputPlace, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'eE', inputPlace);
    return this;
  }
  WebForms elementNotExists(String inputPlace, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'nE', inputPlace);
    return this;
  }
  WebForms isRegexMatch(String value, String pattern, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 're', value + String.fromCharCode(_gs) + pattern);
    return this;
  }
  WebForms isRegexNotMatch(String value, String pattern, {int interval = -1}) {
    _add(((interval >= 0) ? '{($interval)' : '{') + 'rn', value + String.fromCharCode(_gs) + pattern);
    return this;
  }
  // In: Everything Becomes A JSON List.
  // Key: Creates A Temporary Data In The Browser IndexedDB.
  // Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
  WebForms forEach(String path, String in_, {String key = '.'}) {
    _add('{fe', path + String.fromCharCode(_gs) + in_ + String.fromCharCode(_gs) + key);
    return this;
  }
  void break_() => _add(';');
  WebForms else_() {
    _add('}e');
    return this;
  }
  void startBracket() => _add('{');
  void endBracket() => _add('}');
  // Used Then In Condition And Loop Methods
  WebForms then(WebForms newForm) {
    String? data = newForm.getWebFormsData();
    if (data != null && data.isNotEmpty) {
      if (data.contains('\n')) {
        newForm._addToUp('{');
        newForm._add('}');
      }
    }
    appendForm(newForm);
    return this;
  }

  WebForms thenWith(void Function(WebForms) configure) {
    var newForm = WebForms();
    configure(newForm);
    String data = newForm.getWebFormsData();
    if (data.isNotEmpty) {
      if (data.contains('\n')) {
        newForm._addToUp('{', '');
        newForm._add('}');
      }
    }
    appendForm(newForm);
    return this;
  }

  WebForms repeat(WebForms newForm, int repeatCount) {
    String bodyData = newForm.getWebFormsData();
    if (bodyData.isEmpty) return this;
    int startLine = bodyData.split('\n').length * -1;
    appendForm(newForm);
    goTo(startLine.toString(), (repeatCount - 1).toString());
    return this;
  }

  WebForms repeatWithIndex(WebForms newForm, int repeatCount, String index) {
    goTo(index, '1');
    startIndex(index);
    String bodyData = newForm.getWebFormsData();
    if (bodyData.isEmpty) return this;
    appendForm(newForm);
    if (index.isEmpty) {
      int indexNumber = -1;
      for (String x in getWebFormsData().split('\n')) {
        if (x.startsWith('#')) indexNumber++;
      }
      goTo(indexNumber.toString(), (repeatCount - 1).toString());
    } else {
      goTo(index, (repeatCount - 1).toString());
    }
    return this;
  }

  WebForms repeatWith(void Function(WebForms) configure, int repeatCount) {
    var newForm = WebForms();
    configure(newForm);
    return repeat(newForm, repeatCount);
  }

  WebForms repeatWithIndexWith(
      void Function(WebForms) configure, int repeatCount, String index) {
    var newForm = WebForms();
    configure(newForm);
    return repeatWithIndex(newForm, repeatCount, index);
  }

  // Async
  // It Supports Brackets and Then
  WebForms async() {
    _add('{(a)');
    return this;
  }
  void delay(Object miliSecond) => _add('De', miliSecond.toString());

  // Option
  void changeOption(String name, String value) => _add('co', name + String.fromCharCode(_gs) + value);
  void resetOption([String? name]) => _add('ro', name ?? '');

  // Format Storage
  void createFormatStorage(String key, String data) => _add('.C', key + String.fromCharCode(_gs) + data);
  void deleteFormatStorage(String key) => _add('.D', key);
  void addJson(String key, String path, String value) => _add('.a', key + String.fromCharCode(_gs) + 'j' + String.fromCharCode(_gs) + value + String.fromCharCode(_gs) + path);
  // Name: For Support Attribute, Set Double At Sign (@@) Before Name.
  void addXml(String key, String path, String name, [String? value]) => _add('.a', key + String.fromCharCode(_gs) + 'x' + String.fromCharCode(_gs) + name + String.fromCharCode(_gs) + (value ?? '') + String.fromCharCode(_gs) + path);
  void addIni(String key, String path, String value, {bool isIniLike = false}) => _add('.a', key + String.fromCharCode(_gs) + 'i' + String.fromCharCode(_gs) + (isIniLike ? '1' : '0') + String.fromCharCode(_gs) + value + String.fromCharCode(_gs) + path);
  void addTextLine(String key, Object line, String text) => _add('.a', key + String.fromCharCode(_gs) + 't' + String.fromCharCode(_gs) + text + String.fromCharCode(_gs) + line.toString());
  void addVariable(String key, String value) => _add('.a', key + String.fromCharCode(_gs) + 'v' + String.fromCharCode(_gs) + value);
  void updateJson(String key, String path, String value) => _add('.u', key + String.fromCharCode(_gs) + 'j' + String.fromCharCode(_gs) + value + String.fromCharCode(_gs) + path);
  void updateXml(String key, String path, String value) => _add('.u', key + String.fromCharCode(_gs) + 'x' + String.fromCharCode(_gs) + value + String.fromCharCode(_gs) + path);
  void updateIni(String key, String path, String value, {bool isIniLike = false}) => _add('.u', key + String.fromCharCode(_gs) + 'i' + String.fromCharCode(_gs) + (isIniLike ? '1' : '0') + String.fromCharCode(_gs) + value + String.fromCharCode(_gs) + path);
  void updateTexLine(String key, Object line, String text) => _add('.u', key + String.fromCharCode(_gs) + 't' + String.fromCharCode(_gs) + text + String.fromCharCode(_gs) + line.toString());
  void updateVariable(String key, String value) => _add('.u', key + String.fromCharCode(_gs) + 'v' + String.fromCharCode(_gs) + value);
  void increaseVariable(String key, Object value) => _add('.i', key + String.fromCharCode(_gs) + 'v' + String.fromCharCode(_gs) + value.toString());
  void decreaseVariable(String key, int value) => increaseVariable(key, value * -1);
  void deleteJson(String key, String path) => _add('.d', key + String.fromCharCode(_gs) + 'j' + String.fromCharCode(_gs) + path);
  void deleteXml(String key, String path) => _add('.d', key + String.fromCharCode(_gs) + 'x' + String.fromCharCode(_gs) + path);
  void deleteIni(String key, String path, {bool isIniLike = false}) => _add('.d', key + String.fromCharCode(_gs) + 'i' + String.fromCharCode(_gs) + (isIniLike ? '1' : '0') + String.fromCharCode(_gs) + path);
  void deleteTextLine(String key, Object line) => _add('.d', key + String.fromCharCode(_gs) + 't' + String.fromCharCode(_gs) + line.toString());
  void deleteVariable(String key) => _add('.d', key + String.fromCharCode(_gs) + 'v');

  // Template Engine
  // Pattern Example: {{value}}, ((value)), *value*, $value;
  void bindJsonToTemplate(String inputPlace, String jsonText, String path, String pattern, {bool alsoStartTag = true}) => _add('Tj$inputPlace', jsonText + String.fromCharCode(_gs) + path + String.fromCharCode(_gs) + pattern + String.fromCharCode(_gs) + (alsoStartTag ? '1' : '0'));
  // Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
  void bindXmlToTemplate(String inputPlace, String xmlText, String path, String pattern, {bool alsoStartTag = true}) => _add('Tx$inputPlace', xmlText + String.fromCharCode(_gs) + path + String.fromCharCode(_gs) + pattern + String.fromCharCode(_gs) + (alsoStartTag ? '1' : '0'));
  void bindIniToTemplate(String inputPlace, String iniText, String path, String pattern, {bool alsoStartTag = true}) => _add('Ti$inputPlace', iniText + String.fromCharCode(_gs) + path + String.fromCharCode(_gs) + pattern + String.fromCharCode(_gs) + (alsoStartTag ? '1' : '0'));

  // Inject
  // Need Add @: to First of String
  String inject(String value) => r'$[$value];';

  // Action Control
  void replaceActionControl(String searchValue, String value, {bool addingToUp = false}) {
    if (addingToUp) {
      _addToUp('rE', searchValue + String.fromCharCode(_gs) + value);
    } else {
      _add('rE', searchValue + String.fromCharCode(_gs) + value);
    }
  }

  void assignReplace(String searchValue, String value, {int index = -1}) {
    String currentLine = getLineByIndex(index);
    if (currentLine.isEmpty) return;

    int eqIndex = currentLine.indexOf('=');
    String namePart = eqIndex == -1 ? currentLine : currentLine.substring(0, eqIndex);
    String valuePart = eqIndex == -1 ? '' : currentLine.substring(eqIndex + 1);
    
    String newName = ';$searchValue${String.fromCharCode(_gs)}$value${String.fromCharCode(_gs)}$namePart';
    updateLineByIndex(index, newName, valuePart);
  }

  // Hash And Checksum
  void setHash() => _add('SH');
  void setChecksum() => _add('CS');

  int _checksumCalculation(String text) {
    int sum = 0;
    int mod = 65536;
    int shift = 5;

    for (int c in text.runes) {
      sum = (((sum << shift) | (sum >> (16 - shift))) ^ c) % mod;
    }

    return sum;
  }

  String getChecksum() => _checksumCalculation(getWebFormsData()).toString();

  // Get
  String getFormsActionData() {
    if (_webFormsData.isEmpty) {
      return '';
    }
    return _webFormsData;
  }

  String response() {
    return '[web-forms]\n${getFormsActionData()}';
  }

  String getFormsActionDataLineBreak() {
    if (_webFormsData.isEmpty) {
      return '';
    }
    String processedData = _webFormsData.replaceAll('"', r'$[dq];');
    return processedData.replaceAll('\n', r'$[sln];');
  }

  // Export
  String exportToHtmlComment({bool addLine = false}) {
    String responseText = response().replaceAll('--', r'$[dd];');
    if (responseText.endsWith('-')) {
      responseText = responseText.substring(0, responseText.length - 1) + r'$[da];';
    }
    return (addLine ? '\n' : '') + '<!--$responseText-->';
  }

  // Using it for SSE Response
  String exportToLineBreak([String? src]) {
    return r'[web-forms]$[sln];' + getFormsActionDataLineBreak();
  }

  String getWebFormsData() {
    return _webFormsData;
  }

  void appendForm(WebForms? form) {
    if (form == null) return;
    String otherData = form.getWebFormsData();
    if (otherData.isNotEmpty) {
      if (_webFormsData.isNotEmpty) {
        _webFormsData += '\n';
      }
      _webFormsData += otherData;
    }
  }

  void clean() {
    _webFormsData = '';
  }
}

class Security {
  String safeValue(String value) {
    if (value.isEmpty) {
      return value;
    }

    if (value[0] == '@') {
      value = '@$value';
    }

    value = value
        .replaceAll('\n', r'$[ln];')
        .replaceAll(',@', r'$[co];@')
        .replaceAll(String.fromCharCode(28), '')
        .replaceAll(String.fromCharCode(29), '')
        .replaceAll(String.fromCharCode(30), '')
        .replaceAll(String.fromCharCode(31), '');

    return value;
  }
}

// WebForms Place Criteria (WPC) DSL
class InputPlace {
  static const String document = ',';
  static const String window = '`';
  // When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
  static const String root = '~';
  static const String html = '.';
  static const String head = '^';
  static const String screenOrientation = '%';
  static const String all = '*';
  static const String parent = '/';
  static const String current = r'$';
  static const String target = '!';
  static const String upper = '-';

  static String id(String id) => id;
  static String name(Object nameOrNameWithIndex, [Object? index]) {
    if (index != null) {
      return '($nameOrNameWithIndex)$index';
    }
    return '($nameOrNameWithIndex)';
  }
  static String allNames(String name) => '($name)*';
  static String tag(Object tagOrTagWithIndex, [Object? index]) {
    if (index != null) {
      return '<$tagOrTagWithIndex>$index';
    }
    return '<$tagOrTagWithIndex>';
  }
  static String allTags(String tag) => '<$tag>*';
  static String child([Object? index]) {
    if (index != null) {
      return '<>$index';
    }
    return '<>';
  }
  static String allChild() => '<>*';
  static String class_(Object classOrClassWithIndex, [Object? index]) {
    if (index != null) {
      return '{$classOrClassWithIndex}$index';
    }
    return '{$classOrClassWithIndex}';
  }
  static String allClasses(String class_) => '{$class_}*';
  static String attribute(Object nameOrNameWithValue, [Object? valueOrIndex, Object? indexOrOperator, Object? operator]) {
    if (operator != null) {
      String opStr = (operator is int && operator != 0) ? String.fromCharCode(operator) : '';
      return '"$nameOrNameWithValue$opStr\'$valueOrIndex\'"${indexOrOperator ?? ''}"';
    } else if (indexOrOperator != null) {
      String opStr = (indexOrOperator is int && indexOrOperator != 0) ? String.fromCharCode(indexOrOperator) : '';
      return '"$nameOrNameWithValue$opStr\'$valueOrIndex\'"';
    } else if (valueOrIndex != null) {
      return '"$nameOrNameWithValue"$valueOrIndex';
    }
    return '"$nameOrNameWithValue"';
  }
  static String allAttributes(Object nameOrNameWithValue, [Object? valueOrIndex, Object? operator]) {
    if (valueOrIndex != null && operator != null) {
      String opStr = (operator is int && operator != 0) ? String.fromCharCode(operator) : '';
      return '"$nameOrNameWithValue$opStr\'$valueOrIndex\'"*';
    }
    return '"$nameOrNameWithValue"*';
  }
  static String query(String query) => '*${query.replaceAll('=', r'$[eq];').replaceAll('|', r'$[vb];').replaceAll('?', r'$[qu];')}';
  static String queryAll(String query) => '[${query.replaceAll('=', r'$[eq];').replaceAll('|', r'$[vb];').replaceAll('?', r'$[qu];')}';
}

class OutputPlace extends InputPlace {}

// Do not Add any Data Before or After it
class Fetch {
  static const int _rs = 30;
  static const int _us = 31;

  // Method
  static String random(Object maxValueOrMin, [Object? maxValue]) {
    if (maxValue != null) {
      return '@mr$maxValue${String.fromCharCode(_rs)}$maxValueOrMin';
    }
    return '@mr$maxValueOrMin';
  }
  static String spaceToChar(String text, [String character = '-']) => '@sc$character${String.fromCharCode(_rs)}$text';
  static String encodeUri(String text) => '@ue$text';
  static String decodeUri(String text) => '@ud$text';

  static String method(String methodName, [List<Object>? args]) {
    String returnValue = '@cm$methodName';
    if (args != null && args.isNotEmpty) {
      returnValue += '${String.fromCharCode(_rs)}${args.map((e) => e.toString()).join(String.fromCharCode(_us))}';
    }
    return returnValue;
  }

  static String moduleMethod(String methodName, [List<Object>? args]) {
    String returnValue = '@cM$methodName';
    if (args != null && args.isNotEmpty) {
      returnValue += '${String.fromCharCode(_rs)}${args.map((e) => e.toString()).join(String.fromCharCode(_us))}';
    }
    return returnValue;
  }

  // MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
  static String wasmMethod(String wasmLanguage, String wasmUrl, String methodName, {List<Object>? args, String key = '.'}) {
    String returnValue = '@wA$wasmLanguage${String.fromCharCode(_rs)}$wasmUrl${String.fromCharCode(_rs)}$methodName';
    if (args != null && args.isNotEmpty) {
      returnValue += '${String.fromCharCode(_rs)}${args.map((e) => e.toString()).join(String.fromCharCode(_us))}';
    }
    return returnValue;
  }

  static String script(String scriptText) => '@_${scriptText.replaceAll('\n', r'$[ln];')}';
  static String loadUrl(String url, {bool fetchScript = false}) => '@lu$url${fetchScript ? '${String.fromCharCode(_rs)}1' : ''}';
  static String loadHtml(String url, {String fetchInputPlace = '', bool fetchScript = false}) => '@lh$url${String.fromCharCode(_rs)}${fetchScript ? '1' : '0'}${fetchInputPlace.isNotEmpty ? '${String.fromCharCode(_rs)}$fetchInputPlace' : ''}';
  static String loadLine(String url, int line) => '@ll$url${String.fromCharCode(_rs)}$line';
  static String loadIni(String url, String name, {bool isIniLike = false}) => '@li$url${String.fromCharCode(_rs)}$name${isIniLike ? '${String.fromCharCode(_rs)}1' : ''}';
  // Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
  static String loadJson(String url, String name) => '@lj$url${String.fromCharCode(_rs)}$name';
  // Name: Name Or XPath; XPath Index Starts At 1
  static String loadXml(String url, String name) => '@lx$url${String.fromCharCode(_rs)}$name';
  // MethodName: It's Check Function Or Variable
  static String hasMethod(String methodName) => '@hm$methodName';
  static String hasModuleMethod(String methodName) => '@hM$methodName';
  // This Method Return True Or False If Key Pressed
  // Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
  static String getModifierState(String modifier) => '@ms$modifier';

  // Math
  static String math(String methodName, [List<Object>? args]) {
    String returnValue = '@M#$methodName';
    if (args != null && args.isNotEmpty) {
      returnValue += '${String.fromCharCode(_rs)}${args.map((e) => e.toString()).join(String.fromCharCode(_us))}';
    }
    return returnValue;
  }

  // Data
  static const String dateYear = '@dy';
  // Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1 
  static const String dateMonth = '@dm';
  static const String dateDay = '@dd';
  static const String dateDate = '@dD';
  static const String dateHours = '@dh';
  static const String dateMinutes = '@di';
  static const String dateSeconds = '@ds';
  static const String dateMilliseconds = '@dl';

  // String
  static const String space = '@sp';
  static const String atSign = '@sa';

  // Tag
  static String getId(String inputPlace) => '@\$i$inputPlace';
  static String getName(String inputPlace) => '@\$n$inputPlace';
  static String getValue(String inputPlace) => '@\$v$inputPlace';
  static String getValueLength(String inputPlace) => '@\$e$inputPlace';
  static String getClass(String inputPlace) => '@\$c$inputPlace';
  static String getStyle(String inputPlace) => '@\$s$inputPlace';
  static String getTitle(String inputPlace) => '@\$l$inputPlace';
  static String getLabel(String inputPlace) => '@\$A$inputPlace';
  static String getText(String inputPlace) => '@\$t$inputPlace';
  static String getOuterText(String inputPlace) => '@\$o$inputPlace';
  static String getTextLength(String inputPlace) => '@\$g$inputPlace';
  static String getAttribute(String inputPlace, String attribute) => '@\$a$inputPlace${String.fromCharCode(_rs)}$attribute';
  static String getWidth(String inputPlace) => '@\$w$inputPlace';
  static String getHeight(String inputPlace) => '@\$h$inputPlace';
  static String getIsReadOnly(String inputPlace) => '@\$r$inputPlace';
  static String getSelectedIndex(String inputPlace) => '@\$x$inputPlace';
  static String getIndex(String inputPlace) => '@\$I$inputPlace';
  static String getTextAlign(String inputPlace) => '@\$T$inputPlace';
  static String getNodeLength(String inputPlace) => '@\$L$inputPlace';
  static String getIsVisible(String inputPlace) => '@\$V$inputPlace';

  // Save
  static String hasHash(String hash) => '@HH$hash';
  static String cookie(String key) => '@co$key';
  static String save([Object? keyOrKeyWithReplace, Object? replaceValue]) {
    if (replaceValue != null) {
      return '@cs$keyOrKeyWithReplace${String.fromCharCode(_rs)}$replaceValue';
    }
    return '@cs${keyOrKeyWithReplace ?? '.'}';
  }
  static String saveThenRemove(String key) => '@cl$key';
  static String saveLength([Object? key = '.']) => '@cg$key';
  static String cache([Object? keyOrKeyWithReplace, Object? replaceValue]) {
    if (replaceValue != null) {
      return '@cd$keyOrKeyWithReplace${String.fromCharCode(_rs)}$replaceValue';
    }
    return '@cd${keyOrKeyWithReplace ?? '.'}';
  }
  static String cacheThenRemove(String key) => '@ct$key';
  static String cacheLength([Object? key = '.']) => '@cG$key';
  static String saveLine({Object key = '.', int line = 0}) => '@lL$key[$line';
  static String saveLineConsume([Object key = '.']) => '@lL$key';
  // INIKey: Only Direct Key is Supported
  static String saveIni(String key, String iniKey) => '@lI$key[$iniKey';
  static String cacheLine({Object key = '.', int line = 0}) => '@dL$key[$line';
  static String cacheLineConsume([Object key = '.']) => '@dL$key';
  // INIKey: Only Direct Key is Supported
  static String cacheIni(String key, String iniKey) => '@dI$key[$iniKey';

  // Format Storage
  static String formatStore(String key) => '@fr$key';
  static String formatStoreByXmlQuery(String key, String xPath) => '@fx$key${String.fromCharCode(_rs)}$xPath';
  static String formatStoreByJsonQuery(String key, String query) => '@fj$key${String.fromCharCode(_rs)}$query';
  static String formatStoreByIni(String key, String name) => '@fi$key${String.fromCharCode(_rs)}$name';
  static String formatStoreByText(String key, int line) => '@ft$key${String.fromCharCode(_rs)}$line';
  static String formatStoreByVariable(String key) => '@fv$key';

  // State
  static String hasState(String path) => '@hs$path';

  // SSE
  static String sseIsConnected(String path) => '@Sc$path';

  // WebSockets
  static String webSocketsIsConnected([String path = '']) => '@Wc$path';

  // Document
  static const String tabIsActive = '@da';

  // Window
  static const String href = '@wf';
  static const String pathName = '@wP';
  static String query([String name = '*']) => '@wq$name';
  static const String hash = '@wh';
  static const String host = '@wH';
  static const String hostName = '@wn';
  static const String port = '@wT';
  static const String origin = '@wo';
  static const String getSelection = '@ws';
  static const String scrollX = '@wx';
  static const String scrollY = '@wy';
  static String segment(int index) => '@wS$index';
  // It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
  static String hashSegment(int index) => '@wt$index';

  // Navigator
  static const String clipboardText = '@nC';
  static const String geoLatitude = '@nW';
  static const String geoLongitude = '@nO';
  static const String language = '@nL';
  static const String isOnLine = '@no';
  static const String userAgent = '@na';

  // Screen
  static const String screenWidth = '@sw';
  static const String screenHeight = '@sh';
  static const String screenOrientationType = '@so';
  static const String screenOrientationAngle = '@sr';

  // Performance
  static const String timeOrigin = '@pt';
  static const String performanceNow = '@pn';

  // Event
  static const String event = '@EV';
  static const String eventSerialize = '@Es';
  static const String eventKey = '@ek';
  static const String eventWhich = '@ew';
  static const String eventClientX = '@ex';
  static const String eventClientY = '@ey';
  static const String eventPageX = '@eX';
  static const String eventPageY = '@eY';
  static const String eventOffsetX = '@Ex';
  static const String eventOffsetY = '@Ey';
  static const String eventDeltaY = '@ed';
}

class WasmLanguage {
  // The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
  static const String c = 'c';
  static const String cpp = 'c';
  static const String rust = 'rust';
  static const String cSharp = 'csharp';
  // .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
  static const String cSharpMediator = 'csharp-m';
  static const String go = 'go';
  static const String java = 'java';
  static const String assemblyScript = 'as';
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
  static const String onFocusin = 'onfocusin';
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
  static const String onTouchend = 'ontouchend';
  static const String onTouchMove = 'ontouchmove';
  static const String onTouchStart = 'ontouchstart';
  static const String onUnload = 'onunload';
  static const String onVolumeChange = 'onvolumechange';
  static const String onWaiting = 'onwaiting';
  static const String onWheel = 'onwheel';
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
  static const String focusin = 'focusin';
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
  static const String touchend = 'touchend';
  static const String touchMove = 'touchmove';
  static const String touchStart = 'touchstart';
  static const String unload = 'unload';
  static const String volumeChange = 'volumechange';
  static const String waiting = 'waiting';
  static const String wheel = 'wheel';

  static const String animationEnd = 'animationend';
  static const String animationIteration = 'animationiteration';
  static const String animationStart = 'animationstart';
  static const String contextMenu = 'contextmenu';
  static const String fullScreenChange = 'fullscreenchange';
  static const String fullScreenError = 'fullscreenerror';
  static const String popState = 'popstate';
  static const String transitionEnd = 'transitionend';
  static const String storage = 'storage';

  // Custom
  static const String scrollBottom = 'scrollbottom'; // Need Call EnableScrollBottomEvent Method Before
  static const String elementReached = 'elementreached'; // Need Call EnableReachedElementEvent Method Before
}

extension ExtensionWebFormsMethods on String {
  String child(String value) {
    if (isEmpty) {
      return value;
    }
    return '$this|$value';
  }

  String parent() {
    if (isEmpty) {
      return this;
    }
    if (endsWith('|/') || endsWith('//')) {
      return '$this/';
    }
    return '$this|/';
  }

  String criteria(String value) {
    if (isEmpty) {
      return value;
    }
    return '$this?${value.replaceAll('|', r'$[vb];').replaceAll('?', r'$[qu];')}';
  }

  String appendFetchReplace(String searchValue, String value) {
    const int fs = 28;
    String text = substring(1);
    return '@;$searchValue${String.fromCharCode(fs)}$value${String.fromCharCode(fs)}$text';
  }

  String lineBreak({bool encodeLine = false}) {
    String encode = encodeLine ? r'$[sln];' : '';
    return replaceAll('\r\n', encode).replaceAll('\n', encode).replaceAll('\r', encode);
  }

  // Converts Numbers to Strings
  String toJsString() {
    return '"$this"';
  }

  // Get JS Object Momentary
  String toJsObject() {
    return r'$$this';
  }

  // Get JS Object Returned Value Once
  String toJsReturnObject() {
    return r'$@$this';
  }
}
