// WebForms.js 2.0 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.0

class WebForms {
    constructor() {
        this.webFormsData = [];
    }

    // Private helper methods
    _addLine(name, value = null) {
        if (value !== null) {
            this.webFormsData.push(`${name}=${value}`);
        } else {
            this.webFormsData.push(name);
        }
    }

    _getLineByIndex(index) {
        if (this.webFormsData.length === 0 || index < -this.webFormsData.length || index >= this.webFormsData.length) {
            return "";
        }

        if (index < 0) {
            index = this.webFormsData.length + index;
        }

        return this.webFormsData[index];
    }

    _updateLineByIndex(index, name, value = null) {
        if (this.webFormsData.length === 0 || index < -this.webFormsData.length || index >= this.webFormsData.length) {
            return;
        }

        if (index < 0) {
            index = this.webFormsData.length + index;
        }

        if (value !== null) {
            this.webFormsData[index] = `${name}=${value}`;
        } else {
            this.webFormsData[index] = name;
        }
    }

    // For Extension
    addLine(name, value) {
        this._addLine(name, value);
    }

    // Add methods
    addId(inputPlace, id) {
        this._addLine(`ai${inputPlace}`, id);
    }

    addName(inputPlace, name) {
        this._addLine(`an${inputPlace}`, name);
    }

    addValue(inputPlace, value) {
        this._addLine(`av${inputPlace}`, value);
    }

    addClass(inputPlace, className) {
        this._addLine(`ac${inputPlace}`, className);
    }

    addStyle(inputPlace, styleOrName, value = null) {
        if (value === null) {
            this._addLine(`as${inputPlace}`, styleOrName);
        } else {
            this._addLine(`as${inputPlace}`, `${styleOrName}:${value}`);
        }
    }

    addOptionTag(inputPlace, text, value, selected = false) {
        this._addLine(`ao${inputPlace}`, `${value}|${text}${selected ? '|1' : ''}`);
    }

    addCheckBoxTag(inputPlace, text, value, checked = false) {
        this._addLine(`ak${inputPlace}`, `${value}|${text}${checked ? '|1' : ''}`);
    }

    addTitle(inputPlace, title) {
        this._addLine(`al${inputPlace}`, title);
    }

    addLabel(inputPlace, label) {
        this._addLine(`aA${inputPlace}`, label);
    }

    addText(inputPlace, text) {
        this._addLine(`at${inputPlace}`, text.replace(/\n/g, "$[ln];"));
    }

    addTextToUp(inputPlace, text) {
        this._addLine(`pt${inputPlace}`, text.replace(/\n/g, "$[ln];"));
    }

    addAttribute(inputPlace, attribute, value = "", splitter = '\0') {
        const splitterStr = splitter !== '\0' ? splitter : "";
        const valueStr = value ? `|${value}` : "";
        this._addLine(`aa${inputPlace}`, `${attribute}|${splitterStr}${valueStr}`);
    }

    addTag(inputPlace, tagName, id = "") {
        this._addLine(`nt${inputPlace}`, tagName + (id ? `|${id}` : ''));
    }

    addTagToUp(inputPlace, tagName, id = "") {
        this._addLine(`ut${inputPlace}`, tagName + (id ? `|${id}` : ''));
    }

    addTagBefore(inputPlace, tagName, id = "") {
        this._addLine(`bt${inputPlace}`, tagName + (id ? `|${id}` : ''));
    }

    addTagAfter(inputPlace, tagName, id = "") {
        this._addLine(`ft${inputPlace}`, tagName + (id ? `|${id}` : ''));
    }

    addHidden(inputPlace, value, id = "") {
        this._addLine(`ah${inputPlace}`, value + (id ? `|${id}` : ''));
    }

    // Set methods
    setId(inputPlace, id) {
        this._addLine(`si${inputPlace}`, id);
    }

    setName(inputPlace, name) {
        this._addLine(`sn${inputPlace}`, name);
    }

    setValue(inputPlace, value) {
        this._addLine(`sv${inputPlace}`, value);
    }

    setClass(inputPlace, className) {
        this._addLine(`sc${inputPlace}`, className);
    }

    setStyle(inputPlace, styleOrName, value = null) {
        if (value === null) {
            this._addLine(`ss${inputPlace}`, styleOrName);
        } else {
            this._addLine(`ss${inputPlace}`, `${styleOrName}:${value}`);
        }
    }

    setOptionTag(inputPlace, text, value, selected = false) {
        this._addLine(`so${inputPlace}`, `${value}|${text}${selected ? '|1' : ''}`);
    }

    setChecked(inputPlace, checked = false) {
        this._addLine(`sk${inputPlace}`, checked ? "1" : "0");
    }

    setCheckBoxTag(inputPlace, text, value, checked = false) {
        this._addLine(`sk${inputPlace}`, `${value}|${text}${checked ? '|1' : ''}`);
    }

    setTitle(inputPlace, title) {
        this._addLine(`sl${inputPlace}`, title);
    }

    setLabel(inputPlace, label) {
        this._addLine(`sA${inputPlace}`, label);
    }

    setText(inputPlace, text) {
        this._addLine(`st${inputPlace}`, text.replace(/\n/g, "$[ln];"));
    }

    setAttribute(inputPlace, attribute, value = "") {
        const valueStr = value ? `|${value}` : "";
        this._addLine(`sa${inputPlace}`, `${attribute}${valueStr}`);
    }

    setWidth(inputPlace, width) {
        if (typeof width === 'number') {
            this._addLine(`sw${inputPlace}`, `${width}px`);
        } else {
            this._addLine(`sw${inputPlace}`, width);
        }
    }

    setHeight(inputPlace, height) {
        if (typeof height === 'number') {
            this._addLine(`sh${inputPlace}`, `${height}px`);
        } else {
            this._addLine(`sh${inputPlace}`, height);
        }
    }

    setBackgroundColor(inputPlace, color) {
        this._addLine(`bc${inputPlace}`, color);
    }

    setTextColor(inputPlace, color) {
        this._addLine(`tc${inputPlace}`, color);
    }

    setFontName(inputPlace, name) {
        this._addLine(`fn${inputPlace}`, name);
    }

    setFontSize(inputPlace, size) {
        if (typeof size === 'number') {
            this._addLine(`fs${inputPlace}`, `${size}px`);
        } else {
            this._addLine(`fs${inputPlace}`, size);
        }
    }

    setFontBold(inputPlace, bold) {
        this._addLine(`fb${inputPlace}`, bold ? "1" : "0");
    }

    setVisible(inputPlace, visible) {
        this._addLine(`vi${inputPlace}`, visible ? "1" : "0");
    }

    setTextAlign(inputPlace, align) {
        this._addLine(`ta${inputPlace}`, align);
    }

    setReadOnly(inputPlace, readOnly) {
        this._addLine(`sr${inputPlace}`, readOnly ? "1" : "0");
    }

    setDisabled(inputPlace, disabled) {
        this._addLine(`sd${inputPlace}`, disabled ? "1" : "0");
    }

    setFocus(inputPlace, focus) {
        this._addLine(`sf${inputPlace}`, focus ? "1" : "0");
    }

    setMinLength(inputPlace, length) {
        this._addLine(`mn${inputPlace}`, String(length));
    }

    setMaxLength(inputPlace, length) {
        this._addLine(`mx${inputPlace}`, String(length));
    }

    setSelectedValue(inputPlace, value) {
        this._addLine(`ts${inputPlace}`, value);
    }

    setSelectedIndex(inputPlace, index) {
        this._addLine(`ti${inputPlace}`, String(index));
    }

    setCheckedValue(inputPlace, value, selected) {
        this._addLine(`ks${inputPlace}`, `${value}|${selected ? "1" : "0"}`);
    }

    setCheckedIndex(inputPlace, index, selected) {
        this._addLine(`ki${inputPlace}`, `${index}|${selected ? "1" : "0"}`);
    }

    // Insert methods
    insertId(inputPlace, id) {
        this._addLine(`ii${inputPlace}`, id);
    }

    insertName(inputPlace, name) {
        this._addLine(`in${inputPlace}`, name);
    }

    insertValue(inputPlace, value) {
        this._addLine(`iv${inputPlace}`, value);
    }

    insertClass(inputPlace, className) {
        this._addLine(`ic${inputPlace}`, className);
    }

    insertStyle(inputPlace, styleOrName, value = null) {
        if (value === null) {
            this._addLine(`is${inputPlace}`, styleOrName);
        } else {
            this._addLine(`is${inputPlace}`, `${styleOrName}:${value}`);
        }
    }

    insertOptionTag(inputPlace, text, value, selected = false) {
        this._addLine(`io${inputPlace}`, `${value}|${text}${selected ? '|1' : ''}`);
    }

    insertCheckBoxTag(inputPlace, text, value, checked = false) {
        this._addLine(`ik${inputPlace}`, `${value}|${text}${checked ? '|1' : ''}`);
    }

    insertTitle(inputPlace, title) {
        this._addLine(`il${inputPlace}`, title);
    }

    insertLabel(inputPlace, label) {
        this._addLine(`iA${inputPlace}`, label);
    }

    insertText(inputPlace, text) {
        this._addLine(`it${inputPlace}`, text.replace(/\n/g, "$[ln];"));
    }

    insertAttribute(inputPlace, attribute, value = "", splitter = '\0') {
        const splitterStr = splitter !== '\0' ? splitter : "";
        const valueStr = value ? `|${value}` : "";
        this._addLine(`ia${inputPlace}`, `${attribute}|${splitterStr}${valueStr}`);
    }

    // Delete methods
    deleteId(inputPlace) {
        this._addLine(`di${inputPlace}`);
    }

    deleteName(inputPlace) {
        this._addLine(`dn${inputPlace}`);
    }

    deleteValue(inputPlace) {
        this._addLine(`dv${inputPlace}`);
    }

    deleteClass(inputPlace, className) {
        this._addLine(`dc${inputPlace}`, className);
    }

    deleteStyle(inputPlace, styleName) {
        this._addLine(`ds${inputPlace}`, styleName);
    }

    deleteOptionTag(inputPlace, value) {
        this._addLine(`do${inputPlace}`, value);
    }

    deleteAllOptionTag(inputPlace) {
        this._addLine(`do${inputPlace}`, "*");
    }

    deleteCheckBoxTag(inputPlace, value) {
        this._addLine(`dk${inputPlace}`, value);
    }

    deleteAllCheckBoxTag(inputPlace) {
        this._addLine(`dk${inputPlace}`, "*");
    }

    deleteTitle(inputPlace) {
        this._addLine(`dl${inputPlace}`);
    }

    deleteLabel(inputPlace) {
        this._addLine(`dA${inputPlace}`);
    }

    deleteText(inputPlace) {
        this._addLine(`dt${inputPlace}`);
    }

    deleteAttribute(inputPlace, attribute) {
        this._addLine(`da${inputPlace}`, attribute);
    }

    delete(inputPlace) {
        this._addLine(`de${inputPlace}`);
    }

    deleteParent(inputPlace) {
        this._addLine(`dp${inputPlace}`);
    }

    // Tag methods
    swapTag(inputPlace, outputPlace) {
        this._addLine(`sp${inputPlace}`, outputPlace);
    }

    setReflection(inputPlace, tag) {
        this._addLine(`sR${inputPlace}`, tag);
    }

    setReflectionByOutputPlace(inputPlace, outputPlace) {
        this._addLine(`iR${inputPlace}`, outputPlace);
    }

    // Browser methods
    changeUrl(url) {
        this._addLine(`cu`, url);
    }

    setHeadTitle(title) {
        this._addLine(`ht`, title);
    }

    clipboardWriteText(text) {
        this._addLine(`nw`, text);
    }

    scrollTo(x, y) {
        this._addLine(`ws`, `${x}|${y}`);
    }

    historyGo(steps) {
        this._addLine(`wg`, String(steps));
    }

    reloadPage() {
        this._addLine(`lr`);
    }

    redirect(path) {
        this._addLine(`lh`, path);
    }

    // Increase methods
    increaseMinLength(inputPlace, value) {
        this._addLine(`+n${inputPlace}`, String(value));
    }

    increaseMaxLength(inputPlace, value) {
        this._addLine(`+x${inputPlace}`, String(value));
    }

    increaseFontSize(inputPlace, value) {
        this._addLine(`+f${inputPlace}`, String(value));
    }

    increaseWidth(inputPlace, value) {
        this._addLine(`+w${inputPlace}`, String(value));
    }

    increaseHeight(inputPlace, value) {
        this._addLine(`+h${inputPlace}`, String(value));
    }

    increaseValue(inputPlace, value) {
        this._addLine(`+v${inputPlace}`, String(value));
    }

    // Decrease methods
    decreaseMinLength(inputPlace, value) {
        this._addLine(`-n${inputPlace}`, String(value));
    }

    decreaseMaxLength(inputPlace, value) {
        this._addLine(`-x${inputPlace}`, String(value));
    }

    decreaseFontSize(inputPlace, value) {
        this._addLine(`-f${inputPlace}`, String(value));
    }

    decreaseWidth(inputPlace, value) {
        this._addLine(`-w${inputPlace}`, String(value));
    }

    decreaseHeight(inputPlace, value) {
        this._addLine(`-h${inputPlace}`, String(value));
    }

    decreaseValue(inputPlace, value) {
        this._addLine(`-v${inputPlace}`, String(value));
    }

    // Event methods
    triggerEvent(inputPlace, htmlEventListener, constructorName = null) {
        this._addLine(`TE${inputPlace}`, htmlEventListener + (constructorName ? `|${constructorName}` : ""));
    }

    setPostEvent(inputPlace, htmlEvent) {
        this._addLine(`Ep${inputPlace}`, htmlEvent);
    }

    setPostEventView(inputPlace, htmlEvent) {
        this._addLine(`Ep${inputPlace}`, `${htmlEvent}|+`);
    }

    setPostEventTo(inputPlace, htmlEvent, outputPlace) {
        this._addLine(`Ep${inputPlace}`, `${htmlEvent}|${outputPlace}`);
    }

    setPostEventListener(inputPlace, htmlEventListener) {
        this._addLine(`EP${inputPlace}`, htmlEventListener);
    }

    setPostEventListenerView(inputPlace, htmlEventListener) {
        this._addLine(`EP${inputPlace}`, `${htmlEventListener}|+`);
    }

    setPostEventListenerTo(inputPlace, htmlEventListener, outputPlace) {
        this._addLine(`EP${inputPlace}`, `${htmlEventListener}|${outputPlace}`);
    }

    setGetEvent(inputPlace, htmlEvent, path = null) {
        this._addLine(`Eg${inputPlace}`, `${htmlEvent}|${path || "#"}`);
    }

    setGetEventWithOutputPlace(inputPlace, htmlEvent, outputPlace, path = null) {
        this._addLine(`Eg${inputPlace}`, `${htmlEvent}|${path || "#"}|${outputPlace}`);
    }

    setGetEventListener(inputPlace, htmlEventListener, path = null) {
        this._addLine(`EG${inputPlace}`, `${htmlEventListener}|${path || "#"}`);
    }

    setGetEventListenerWithOutputPlace(inputPlace, htmlEventListener, outputPlace, path = null) {
        this._addLine(`EG${inputPlace}`, `${htmlEventListener}|${path || "#"}|${outputPlace}`);
    }

    setPatchEvent(inputPlace, htmlEvent, path = null) {
        this._addLine(`Ea${inputPlace}`, `${htmlEvent}|${path || "#"}`);
    }

    setPatchEventWithOutputPlace(inputPlace, htmlEvent, outputPlace, path = null) {
        this._addLine(`Ea${inputPlace}`, `${htmlEvent}|${path || "#"}|${outputPlace}`);
    }

    setPatchEventListener(inputPlace, htmlEventListener, path = null) {
        this._addLine(`EA${inputPlace}`, `${htmlEventListener}|${path || "#"}`);
    }

    setPatchEventListenerWithOutputPlace(inputPlace, htmlEventListener, outputPlace, path = null) {
        this._addLine(`EA${inputPlace}`, `${htmlEventListener}|${path || "#"}|${outputPlace}`);
    }

    setDeleteEvent(inputPlace, htmlEvent, path = null) {
        this._addLine(`El${inputPlace}`, `${htmlEvent}|${path || "#"}`);
    }

    setDeleteEventWithOutputPlace(inputPlace, htmlEvent, outputPlace, path = null) {
        this._addLine(`El${inputPlace}`, `${htmlEvent}|${path || "#"}|${outputPlace}`);
    }

    setDeleteEventListener(inputPlace, htmlEventListener, path = null) {
        this._addLine(`EL${inputPlace}`, `${htmlEventListener}|${path || "#"}`);
    }

    setDeleteEventListenerWithOutputPlace(inputPlace, htmlEventListener, outputPlace, path = null) {
        this._addLine(`EL${inputPlace}`, `${htmlEventListener}|${path || "#"}|${outputPlace}`);
    }

    setOptionsEvent(inputPlace, htmlEvent, path = null) {
        this._addLine(`Eo${inputPlace}`, `${htmlEvent}|${path || "#"}`);
    }

    setOptionsEventWithOutputPlace(inputPlace, htmlEvent, outputPlace, path = null) {
        this._addLine(`Eo${inputPlace}`, `${htmlEvent}|${path || "#"}|${outputPlace}`);
    }

    setOptionsEventListener(inputPlace, htmlEventListener, path = null) {
        this._addLine(`EO${inputPlace}`, `${htmlEventListener}|${path || "#"}`);
    }

    setOptionsEventListenerWithOutputPlace(inputPlace, htmlEventListener, outputPlace, path = null) {
        this._addLine(`EO${inputPlace}`, `${htmlEventListener}|${path || "#"}|${outputPlace}`);
    }

    setTraceEvent(inputPlace, htmlEvent, path = null) {
        this._addLine(`Er${inputPlace}`, `${htmlEvent}|${path || "#"}`);
    }

    setTraceEventWithOutputPlace(inputPlace, htmlEvent, outputPlace, path = null) {
        this._addLine(`Er${inputPlace}`, `${htmlEvent}|${path || "#"}|${outputPlace}`);
    }

    setTraceEventListener(inputPlace, htmlEventListener, path = null) {
        this._addLine(`ER${inputPlace}`, `${htmlEventListener}|${path || "#"}`);
    }

    setTraceEventListenerWithOutputPlace(inputPlace, htmlEventListener, outputPlace, path = null) {
        this._addLine(`ER${inputPlace}`, `${htmlEventListener}|${path || "#"}|${outputPlace}`);
    }

    setConnectEvent(inputPlace, htmlEvent, path = null) {
        this._addLine(`Ec${inputPlace}`, `${htmlEvent}|${path || "#"}`);
    }

    setConnectEventWithOutputPlace(inputPlace, htmlEvent, outputPlace, path = null) {
        this._addLine(`Ec${inputPlace}`, `${htmlEvent}|${path || "#"}|${outputPlace}`);
    }

    setConnectEventListener(inputPlace, htmlEventListener, path = null) {
        this._addLine(`EC${inputPlace}`, `${htmlEventListener}|${path || "#"}`);
    }

    setConnectEventListenerWithOutputPlace(inputPlace, htmlEventListener, outputPlace, path = null) {
        this._addLine(`EC${inputPlace}`, `${htmlEventListener}|${path || "#"}|${outputPlace}`);
    }

    setHeadEvent(inputPlace, htmlEvent, path = null) {
        this._addLine(`Eh${inputPlace}`, `${htmlEvent}|${path || "#"}`);
    }

    setHeadEventListener(inputPlace, htmlEventListener, path = null) {
        this._addLine(`EH${inputPlace}`, `${htmlEventListener}|${path || "#"}`);
    }

    setTagEvent(inputPlace, htmlEvent, outputPlace) {
        this._addLine(`Et${inputPlace}`, `${htmlEvent}|${outputPlace}`);
    }

    setTagEventListener(inputPlace, htmlEventListener, outputPlace) {
        this._addLine(`ET${inputPlace}`, `${htmlEventListener}|${outputPlace}`);
    }

    setCommentEvent(inputPlace, htmlEvent, index = null, outputPlace = null) {
        this._addLine(`Eb${inputPlace}`, `${htmlEvent}|${index || ""}|${outputPlace || ""}`);
    }

    setCommentEventListener(inputPlace, htmlEventListener, index = null, outputPlace = null) {
        this._addLine(`EB${inputPlace}`, `${htmlEventListener}|${index || ""}|${outputPlace || ""}`);
    }

    setWasmEvent(inputPlace, htmlEvent, wasmLanguage, wasmUrl, methodName, args = null, outputPlace = null) {
        const argsJoin = args && args.length > 0 ? args.join(",") : "";
        this._addLine(`Ey${inputPlace}`, `${htmlEvent}|${wasmLanguage}|${wasmUrl}|${methodName}|${argsJoin}|${outputPlace || ""}`);
    }

    setWasmEventListener(inputPlace, htmlEventListener, wasmLanguage, wasmUrl, methodName, args = null, outputPlace = null) {
        const argsJoin = args && args.length > 0 ? args.join(",") : "";
        this._addLine(`EY${inputPlace}`, `${htmlEventListener}|${wasmLanguage}|${wasmUrl}|${methodName}|${argsJoin}|${outputPlace || ""}`);
    }

    setWebSocketEvent(inputPlace, htmlEvent, path) {
        this._addLine(`Ew${inputPlace}`, `${htmlEvent}|${path}`);
    }

    setWebSocketEventListener(inputPlace, htmlEventListener, path) {
        this._addLine(`EW${inputPlace}`, `${htmlEventListener}|${path}`);
    }

    setSSEEvent(inputPlace, htmlEvent, path, shouldReconnect = true, reconnectTryTimeout = 3000) {
        this._addLine(`Ee${inputPlace}`, `${htmlEvent}|${path}|${shouldReconnect ? "1" : "0"}|${reconnectTryTimeout}`);
    }

    setSSEEventWithOutputPlace(inputPlace, htmlEvent, path, outputPlace, shouldReconnect = true, reconnectTryTimeout = 3000) {
        this._addLine(`Ee${inputPlace}`, `${htmlEvent}|${path}|${shouldReconnect ? "1" : "0"}|${reconnectTryTimeout}|${outputPlace}`);
    }

    setSSEEventListener(inputPlace, htmlEventListener, path, shouldReconnect = true, reconnectTryTimeout = 3000) {
        this._addLine(`EE${inputPlace}`, `${htmlEventListener}|${path}|${shouldReconnect ? "1" : "0"}|${reconnectTryTimeout}`);
    }

    setSSEEventListenerWithOutputPlace(inputPlace, htmlEventListener, path, outputPlace, shouldReconnect = true, reconnectTryTimeout = 3000) {
        this._addLine(`EE${inputPlace}`, `${htmlEventListener}|${path}|${shouldReconnect ? "1" : "0"}|${reconnectTryTimeout}|${outputPlace}`);
    }

    setFrontEvent(inputPlace, htmlEvent, modulePath, args = null, outputPlace = null) {
        const argsJoin = args && args.length > 0 ? `|${args.join("|")}` : "";
        this._addLine(`Ej${inputPlace}`, `${htmlEvent}|${modulePath}|${outputPlace || ""}${argsJoin}`);
    }

    setFrontEventListener(inputPlace, htmlEventListener, modulePath, args = null, outputPlace = null) {
        const argsJoin = args && args.length > 0 ? `|${args.join("|")}` : "";
        this._addLine(`EJ${inputPlace}`, `${htmlEventListener}|${modulePath}|${outputPlace || ""}${argsJoin}`);
    }

    setSendEvent(inputPlace, htmlEvent, data, path = null, method = "POST", isMultiPart = false, contentType = "text/plain", outputPlace = null) {
        const safeData = data.replace(/\n/g, "$[ln];").replace(/"/g, "$[dq];").replace(/'/g, "$[sq];");
        this._addLine(`En${inputPlace}`, `${htmlEvent}|${safeData}|${path || "#"}|${method}|${isMultiPart ? "1" : "0"}|${contentType}|${outputPlace || ""}`);
    }

    setSendEventListener(inputPlace, htmlEventListener, data, path = null, method = "POST", isMultiPart = false, contentType = "text/plain", outputPlace = null) {
        const safeData = data.replace(/\n/g, "$[ln];");
        this._addLine(`EN${inputPlace}`, `${htmlEventListener}|${safeData}|${path || "#"}|${method}|${isMultiPart ? "1" : "0"}|${contentType}|${outputPlace || ""}`);
    }

    setMasterPagesEvent(inputPlace, htmlEvent, outputPlace = null) {
        this._addLine(`Eu${inputPlace}`, `${htmlEvent}|${outputPlace || ""}`);
    }

    setMasterPagesEventListener(inputPlace, htmlEventListener, outputPlace = null) {
        this._addLine(`EU${inputPlace}`, `${htmlEventListener}|${outputPlace || ""}`);
    }

    setPreventDefaultEvent(inputPlace, htmlEvent) {
        this._addLine(`Ed${inputPlace}`, htmlEvent);
    }

    setPreventDefaultEventListener(inputPlace, htmlEventListener) {
        this._addLine(`ED${inputPlace}`, htmlEventListener);
    }

    setStopPropagationEvent(inputPlace, htmlEvent) {
        this._addLine(`Es${inputPlace}`, htmlEvent);
    }

    setStopPropagationEventListener(inputPlace, htmlEventListener) {
        this._addLine(`ES${inputPlace}`, htmlEventListener);
    }

    setMethodEvent(inputPlace, htmlEvent, methodName, args = null) {
        const argsJoin = args && args.length > 0 ? `|${args.join("|")}` : "";
        this._addLine(`Em${inputPlace}`, `${htmlEvent}|${methodName}${argsJoin}`);
    }

    setMethodEventListener(inputPlace, htmlEventListener, methodName, args = null) {
        const argsJoin = args && args.length > 0 ? `|${args.join("|")}` : "";
        this._addLine(`EM${inputPlace}`, `${htmlEventListener}|${methodName}${argsJoin}`);
    }

    setModuleMethodEvent(inputPlace, htmlEvent, methodName, args = null) {
        const argsJoin = args && args.length > 0 ? `|${args.join("|")}` : "";
        this._addLine(`Ex${inputPlace}`, `${htmlEvent}|${methodName}${argsJoin}`);
    }

    setModuleMethodEventListener(inputPlace, htmlEventListener, methodName, args = null) {
        const argsJoin = args && args.length > 0 ? `|${args.join("|")}` : "";
        this._addLine(`EX${inputPlace}`, `${htmlEventListener}|${methodName}${argsJoin}`);
    }

    assignConfirmEvent(inputPlace, htmlEvent, text = "Are you sure you want to proceed?", type = "none", title = "Confirm", okText = "OK", cancelText = "Cancel") {
        const textStr = text === "Are you sure you want to proceed?" ? "" : text;
        const typeStr = type === "none" ? "" : type;
        const titleStr = title === "Confirm" ? "" : title;
        const okTextStr = okText === "OK" ? "" : okText;
        const cancelTextStr = cancelText === "Cancel" ? "" : cancelText;
        this._addLine(`Ef${inputPlace}`, `${htmlEvent}|${textStr}|${typeStr}|${titleStr}|${okTextStr}|${cancelTextStr}`);
    }

    // Remove event methods (simplified for brevity)
    removePostEvent(inputPlace, htmlEvent) {
        this._addLine(`Rp${inputPlace}`, htmlEvent);
    }

    removePostEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RP${inputPlace}`, htmlEventListener);
    }

    removeGetEvent(inputPlace, htmlEvent) {
        this._addLine(`Rg${inputPlace}`, htmlEvent);
    }

    removeGetEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RG${inputPlace}`, htmlEventListener);
    }

    removePatchEvent(inputPlace, htmlEvent) {
        this._addLine(`Ra${inputPlace}`, htmlEvent);
    }

    removePatchEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RA${inputPlace}`, htmlEventListener);
    }

    removeDeleteEvent(inputPlace, htmlEvent) {
        this._addLine(`Rl${inputPlace}`, htmlEvent);
    }

    removeDeleteEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RL${inputPlace}`, htmlEventListener);
    }

    removeHeadEvent(inputPlace, htmlEvent) {
        this._addLine(`Rh${inputPlace}`, htmlEvent);
    }

    removeHeadEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RH${inputPlace}`, htmlEventListener);
    }

    removeOptionsEvent(inputPlace, htmlEvent) {
        this._addLine(`Ro${inputPlace}`, htmlEvent);
    }

    removeOptionsEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RO${inputPlace}`, htmlEventListener);
    }

    removeTraceEvent(inputPlace, htmlEvent) {
        this._addLine(`Rr${inputPlace}`, htmlEvent);
    }

    removeTraceEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RR${inputPlace}`, htmlEventListener);
    }

    removeConnectEvent(inputPlace, htmlEvent) {
        this._addLine(`Rc${inputPlace}`, htmlEvent);
    }

    removeConnectEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RC${inputPlace}`, htmlEventListener);
    }

    removeTagEvent(inputPlace, htmlEvent) {
        this._addLine(`Rt${inputPlace}`, htmlEvent);
    }

    removeTagEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RT${inputPlace}`, htmlEventListener);
    }

    removeCommentEvent(inputPlace, htmlEvent) {
        this._addLine(`Rb${inputPlace}`, htmlEvent);
    }

    removeCommentEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RB${inputPlace}`, htmlEventListener);
    }

    removeWasmEvent(inputPlace, htmlEvent) {
        this._addLine(`Ry${inputPlace}`, htmlEvent);
    }

    removeWasmEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RY${inputPlace}`, htmlEventListener);
    }

    removeWebSocketEvent(inputPlace, htmlEvent) {
        this._addLine(`Rw${inputPlace}`, htmlEvent);
    }

    removeWebSocketEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RW${inputPlace}`, htmlEventListener);
    }

    removeSSEEvent(inputPlace, htmlEvent) {
        this._addLine(`Re${inputPlace}`, htmlEvent);
    }

    removeSSEEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RE${inputPlace}`, htmlEventListener);
    }

    removeFrontEvent(inputPlace, htmlEvent) {
        this._addLine(`Rj${inputPlace}`, htmlEvent);
    }

    removeFrontEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RJ${inputPlace}`, htmlEventListener);
    }

    removeSendEvent(inputPlace, htmlEvent) {
        this._addLine(`Rn${inputPlace}`, htmlEvent);
    }

    removeSendEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RN${inputPlace}`, htmlEventListener);
    }

    removePreventDefaultEvent(inputPlace, htmlEvent) {
        this._addLine(`Rd${inputPlace}`, htmlEvent);
    }

    removePreventDefaultEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RD${inputPlace}`, htmlEventListener);
    }

    removeMasterPagesEvent(inputPlace, htmlEvent) {
        this._addLine(`Ru${inputPlace}`, htmlEvent);
    }

    removeMasterPagesEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RU${inputPlace}`, htmlEventListener);
    }

    removeStopPropagationEvent(inputPlace, htmlEvent) {
        this._addLine(`Rs${inputPlace}`, htmlEvent);
    }

    removeStopPropagationEventListener(inputPlace, htmlEventListener) {
        this._addLine(`RS${inputPlace}`, htmlEventListener);
    }

    removeMethodEvent(inputPlace, htmlEvent, methodName) {
        this._addLine(`Rm${inputPlace}`, `${htmlEvent}|${methodName}`);
    }

    removeMethodEventListener(inputPlace, htmlEventListener, methodName) {
        this._addLine(`RM${inputPlace}`, `${htmlEventListener}|${methodName}`);
    }

    removeModuleMethodEvent(inputPlace, htmlEvent, methodName) {
        this._addLine(`Rx${inputPlace}`, `${htmlEvent}|${methodName}`);
    }

    removeModuleMethodEventListener(inputPlace, htmlEventListener, methodName) {
        this._addLine(`RX${inputPlace}`, `${htmlEventListener}|${methodName}`);
    }

    removeConfirmEvent(inputPlace, htmlEvent) {
        this._addLine(`Rf${inputPlace}`, htmlEvent);
    }

    // Custom Event methods
    createCustomDOMEvent(inputPlace, eventName, watch, key, compare, value, range, immediate = false, delay = 0) {
        this._addLine(`eC${inputPlace}`, `${eventName}|${watch}|${key}|${compare}|${value}|${range}|${immediate ? "1" : "0"}|${delay}`);
    }

    enableScrollBottomEvent(enable = true) {
        this._addLine(`eb`, enable ? "1" : "0");
    }

    enableReachedElementEvent(inputPlace, once, enable = true) {
        this._addLine(`er${inputPlace}`, `${once ? "1" : "0"}|${enable ? "1" : "0"}`);
    }

    // Module methods
    loadModule(modulePath, methods) {
        this._addLine(`Ml`, modulePath + (methods && methods.length > 0 ? `|${methods.join("|")}` : ""));
    }

    unloadModule(modulePath) {
        this._addLine(`Mu`, modulePath);
    }

    deleteModuleMethod(methodName) {
        this._addLine(`Md`, methodName);
    }

    // Unit Testing methods
    assertEqual(inputPlace, tag) {
        this._addLine(`At${inputPlace}`, tag.replace(/\n/g, "$[ln];"));
    }

    assertEqualByOutputPlace(inputPlace, outputPlace) {
        this._addLine(`Ao${inputPlace}`, outputPlace);
    }

    // Service Worker methods
    serviceWorkerRegister(path = null, scopePath = null) {
        this._addLine(`wR`, `${path || ""}|${scopePath || ""}`);
    }

    serviceWorkerPreCacheStatic(pathList) {
        this._addLine(`wp`, pathList.join("|"));
    }

    serviceWorkerDynamicCache(path, seconds = 0) {
        this._addLine(`wc`, path + (seconds > 0 ? `|${seconds}` : ""));
    }

    serviceWorkerDeleteDynamicCache(path = null) {
        if (path) {
            this._addLine(`wd`, path);
        } else {
            this._addLine(`wd`);
        }
    }

    serviceWorkerDynamicCacheTTLUpdate(path, seconds = 0) {
        this._addLine(`wt`, path + (seconds > 0 ? `|${seconds}` : ""));
    }

    serviceWorkerRouteSet(path, type, cacheDynamic = false) {
        this._addLine(`wr`, `${path}|${type}${cacheDynamic ? "|1" : ""}`);
    }

    serviceWorkerRouteAlias(path, to) {
        this._addLine(`wa`, `${path}|${to}`);
    }

    serviceWorkerDeleteRouteAlias(path = null) {
        this._addLine(`wC`, path || "");
    }

    serviceWorkerDeleteRoute(path = null) {
        if (path) {
            this._addLine(`wD`, path);
        } else {
            this._addLine(`wD`);
        }
    }

    // SSE methods
    disconnectSSE(path = null) {
        if (path) {
            this._addLine(`Ds`, path);
        } else {
            this._addLine(`Ds`);
        }
    }

    // State methods
    addState(path = null, title = null) {
        this._addLine(`AS`, `${path || ""}|${title || ""}`);
    }

    deleteState(path = null) {
        if (path) {
            this._addLine(`DS`, path);
        } else {
            this._addLine(`DS`, "*");
        }
    }

    // Cookie methods
    setCookie(key, value, seconds, path = null) {
        this._addLine(`sC`, `${key}|${value}|${seconds}${path ? `|${path}` : ""}`);
    }

    // Save/Session Cache methods
    saveId(inputPlace, key = ".") {
        this._addLine(`@gi${inputPlace}`, key);
    }

    saveName(inputPlace, key = ".") {
        this._addLine(`@gn${inputPlace}`, key);
    }

    saveValue(inputPlace, key = ".") {
        this._addLine(`@gv${inputPlace}`, key);
    }

    saveValueLength(inputPlace, key = ".") {
        this._addLine(`@ge${inputPlace}`, key);
    }

    saveClass(inputPlace, key = ".") {
        this._addLine(`@gc${inputPlace}`, key);
    }

    saveStyle(inputPlace, key = ".") {
        this._addLine(`@gs${inputPlace}`, key);
    }

    saveTitle(inputPlace, key = ".") {
        this._addLine(`@gl${inputPlace}`, key);
    }

    saveLabel(inputPlace, key = ".") {
        this._addLine(`@gA${inputPlace}`, key);
    }

    saveText(inputPlace, key = ".") {
        this._addLine(`@gt${inputPlace}`, key);
    }

    saveOuterText(inputPlace, key = ".") {
        this._addLine(`@go${inputPlace}`, key);
    }

    saveTextLength(inputPlace, key = ".") {
        this._addLine(`@gg${inputPlace}`, key);
    }

    saveAttribute(inputPlace, attribute, key = ".") {
        this._addLine(`@ga${inputPlace}`, `${key}|${attribute}`);
    }

    saveWidth(inputPlace, key = ".") {
        this._addLine(`@gw${inputPlace}`, key);
    }

    saveHeight(inputPlace, key = ".") {
        this._addLine(`@gh${inputPlace}`, key);
    }

    saveReadOnly(inputPlace, key = ".") {
        this._addLine(`@gr${inputPlace}`, key);
    }

    saveSelectedIndex(inputPlace, key = ".") {
        this._addLine(`@gx${inputPlace}`, key);
    }

    saveTextAlign(inputPlace, key = ".") {
        this._addLine(`@gT${inputPlace}`, key);
    }

    saveNodeLength(inputPlace, key = ".") {
        this._addLine(`@gL${inputPlace}`, key);
    }

    saveVisible(inputPlace, key = ".") {
        this._addLine(`@gV${inputPlace}`, key);
    }

    saveUrl(url, fetchScript = false, key = ".") {
        this._addLine(`@gu`, `${key}|${url}${fetchScript ? "|1" : ""}`);
    }

    saveIndex(inputPlace, key = ".") {
        this._addLine(`@gI${inputPlace}`, key);
    }

    removeSessionCache(cacheKey) {
        if (cacheKey) {
            this._addLine(`rs`, cacheKey);
        } else {
            this._addLine(`rs`, "*");
        }
    }

    setSessionCache() {
        this._addLine(`cs`, "*");
    }

    addSessionCacheValue(cacheKey, value) {
        this._addLine(`SA`, `${cacheKey}|${value.replace(/\n/g, "$[ln];")}`);
    }

    insertSessionCacheValue(cacheKey, value) {
        this._addLine(`SI`, `${cacheKey}|${value.replace(/\n/g, "$[ln];")}`);
    }

    // Cache methods
    cacheId(inputPlace, key = ".") {
        this._addLine(`@ci${inputPlace}`, key);
    }

    cacheName(inputPlace, key = ".") {
        this._addLine(`@cn${inputPlace}`, key);
    }

    cacheValue(inputPlace, key = ".") {
        this._addLine(`@cv${inputPlace}`, key);
    }

    cacheValueLength(inputPlace, key = ".") {
        this._addLine(`@ce${inputPlace}`, key);
    }

    cacheClass(inputPlace, key = ".") {
        this._addLine(`@cc${inputPlace}`, key);
    }

    cacheStyle(inputPlace, key = ".") {
        this._addLine(`@cs${inputPlace}`, key);
    }

    cacheTitle(inputPlace, key = ".") {
        this._addLine(`@cl${inputPlace}`, key);
    }

    cacheLabel(inputPlace, key = ".") {
        this._addLine(`@cA${inputPlace}`, key);
    }

    cacheText(inputPlace, key = ".") {
        this._addLine(`@ct${inputPlace}`, key);
    }

    cacheOuterText(inputPlace, key = ".") {
        this._addLine(`@co${inputPlace}`, key);
    }

    cacheTextLength(inputPlace, key = ".") {
        this._addLine(`@cg${inputPlace}`, key);
    }

    cacheAttribute(inputPlace, attribute, key = ".") {
        this._addLine(`@ca${inputPlace}`, `${key}|${attribute}`);
    }

    cacheWidth(inputPlace, key = ".") {
        this._addLine(`@cw${inputPlace}`, key);
    }

    cacheHeight(inputPlace, key = ".") {
        this._addLine(`@ch${inputPlace}`, key);
    }

    cacheReadOnly(inputPlace, key = ".") {
        this._addLine(`@cr${inputPlace}`, key);
    }

    cacheSelectedIndex(inputPlace, key = ".") {
        this._addLine(`@cx${inputPlace}`, key);
    }

    cacheTextAlign(inputPlace, key = ".") {
        this._addLine(`@cT${inputPlace}`, key);
    }

    cacheNodeLength(inputPlace, key = ".") {
        this._addLine(`@cL${inputPlace}`, key);
    }

    cacheVisible(inputPlace, key = ".") {
        this._addLine(`@cV${inputPlace}`, key);
    }

    cacheUrl(url, fetchScript = false, key = ".") {
        this._addLine(`@cu`, `${key}|${url}${fetchScript ? "|1" : ""}`);
    }

    cacheIndex(inputPlace, key = ".") {
        this._addLine(`@cI${inputPlace}`, key);
    }

    removeCache(cacheKey) {
        if (cacheKey) {
            this._addLine(`rd`, cacheKey);
        } else {
            this._addLine(`rd`, "*");
        }
    }

    setCache(second = '*') {
        if (second === '*') {
            this._addLine(`cd`, "*");
        } else {
            this._addLine(`cd`, String(second));
        }
    }

    addCacheValue(cacheKey, value) {
        this._addLine(`CA`, `${cacheKey}|${value.replace(/\n/g, "$[ln];")}`);
    }

    insertCacheValue(cacheKey, value) {
        this._addLine(`CI`, `${cacheKey}|${value.replace(/\n/g, "$[ln];")}`);
    }

    // Call methods
    loadUrl(inputPlace, url) {
        this._addLine(`lu${inputPlace}`, url);
    }

    runActionControls(actionControls, index = null, withoutWebFormsSection = false, useCurrentEvent = true) {
        const indexStr = index !== null ? index : "";
        this._addLine(`lA`, `${useCurrentEvent ? "1" : "0"}|${withoutWebFormsSection ? "1" : "0"}|${indexStr}|${actionControls}`);
    }

    callScript(scriptText) {
        this._addLine(`_`, scriptText.replace(/\n/g, "$[ln];"));
    }

    callMethod(methodName, args = null) {
        const argsJoin = args && args.length > 0 ? `|${args.join("|")}` : "";
        this._addLine(`lm`, `${methodName}${argsJoin}`);
    }

    callModuleMethod(methodName, args = null) {
        const argsJoin = args && args.length > 0 ? `|${args.join("|")}` : "";
        this._addLine(`lM`, `${methodName}${argsJoin}`);
    }

    callPostBack(formInputPlace, outputPlace = null) {
        this._addLine(`Lp`, `1|${formInputPlace}${outputPlace ? `|${outputPlace}` : ""}`);
    }

    callTagBack(outputPlace = null, useCurrentEvent = true) {
        this._addLine(`Lt`, `${useCurrentEvent ? "1" : "0"}${outputPlace ? `|${outputPlace}` : ""}`);
    }

    callCommentBack(index = null, outputPlace = null, useCurrentEvent = true) {
        const indexStr = index !== null ? index : "";
        this._addLine(`LC`, `${useCurrentEvent ? "1" : "0"}|${indexStr}|${outputPlace || ""}`);
    }

    callWasmBack(wasmLanguage, wasmUrl, methodName, args = null, outputPlace = null, useCurrentEvent = true) {
        const argsJoin = args && args.length > 0 ? args.join(",") : "";
        this._addLine(`Ly`, `${useCurrentEvent ? "1" : "0"}|${wasmLanguage}|${wasmUrl}|${methodName}|${argsJoin}|${outputPlace || ""}`);
    }

    callWebSocketBack(path, useCurrentEvent = true) {
        this._addLine(`Lw`, `${useCurrentEvent ? "1" : "0"}|${path}`);
    }

    callSSEBack(path, outputPlace = null, useCurrentEvent = true, shouldReconnect = true, reconnectTryTimeout = 3000) {
        this._addLine(`Ls`, `${useCurrentEvent ? "1" : "0"}|${path}|${shouldReconnect ? "1" : "0"}|${reconnectTryTimeout}${outputPlace ? `|${outputPlace}` : ""}`);
    }

    callFront(modulePath, args = null, outputPlace = null, useCurrentEvent = true) {
        const argsJoin = args && args.length > 0 ? `|${args.join("|")}` : "";
        this._addLine(`Lj`, `${useCurrentEvent ? "1" : "0"}|${modulePath}|${outputPlace || ""}${argsJoin}`);
    }

    callGetBack(path, outputPlace = null, useCurrentEvent = true) {
        this._addLine(`Lg`, `${useCurrentEvent ? "1" : "0"}|${path}${outputPlace ? `|${outputPlace}` : ""}`);
    }

    callPutBack(path, outputPlace = null, useCurrentEvent = true) {
        this._addLine(`Lu`, `${useCurrentEvent ? "1" : "0"}|${path}${outputPlace ? `|${outputPlace}` : ""}`);
    }

    callPatchBack(path, outputPlace = null, useCurrentEvent = true) {
        this._addLine(`LP`, `${useCurrentEvent ? "1" : "0"}|${path}${outputPlace ? `|${outputPlace}` : ""}`);
    }

    callDeleteBack(path, outputPlace = null, useCurrentEvent = true) {
        this._addLine(`Ld`, `${useCurrentEvent ? "1" : "0"}|${path}${outputPlace ? `|${outputPlace}` : ""}`);
    }

    callHeadBack(path, outputPlace = null, useCurrentEvent = true) {
        this._addLine(`Lh`, `${useCurrentEvent ? "1" : "0"}|${path}${outputPlace ? `|${outputPlace}` : ""}`);
    }

    callOptionsBack(path, outputPlace = null, useCurrentEvent = true) {
        this._addLine(`Lo`, `${useCurrentEvent ? "1" : "0"}|${path}${outputPlace ? `|${outputPlace}` : ""}`);
    }

    callTraceBack(path, outputPlace = null, useCurrentEvent = true) {
        this._addLine(`LT`, `${useCurrentEvent ? "1" : "0"}|${path}${outputPlace ? `|${outputPlace}` : ""}`);
    }

    callConnectBack(path, outputPlace = null, useCurrentEvent = true) {
        this._addLine(`Lc`, `${useCurrentEvent ? "1" : "0"}|${path}${outputPlace ? `|${outputPlace}` : ""}`);
    }

    callSendBack(path, method, isMultiPart, contentType, data, outputPlace = null, useCurrentEvent = true) {
        const safeData = data.replace(/\n/g, "$[ln];").replace(/\|/g, "$[vb];");
        this._addLine(`LS`, `${useCurrentEvent ? "1" : "0"}|${path}|${method}|${isMultiPart ? "1" : "0"}|${contentType}|${safeData}${outputPlace ? `|${outputPlace}` : ""}`);
    }

    // Update methods
    increase(inputPlace, value) {
        this._addLine(`gt${inputPlace}`, `i|${value}`);
    }

    decrease(inputPlace, value) {
        this._addLine(`gt${inputPlace}`, `i|${value * -1}`);
    }

    replace(inputPlace, value, newValue, alsoStartTag = false, deep = false) {
        let safeValue = value;
        let safeNewValue = newValue;

        if (safeValue && safeValue[0] === '@') {
            safeValue = safeValue.substring(1);
            safeValue = `$[at];${safeValue}`;
        }

        if (safeNewValue && safeNewValue[0] === '@') {
            safeNewValue = safeNewValue.substring(1);
            safeNewValue = `$[at];${safeNewValue}`;
        }

        this._addLine(`gt${inputPlace}`, `r|${safeValue}|${safeNewValue}|${alsoStartTag ? "1" : "0"}|${deep ? "1" : "0"}`);
    }

    replaceStartTag(inputPlace, value, newValue) {
        let safeValue = value;
        let safeNewValue = newValue;

        if (safeValue && safeValue[0] === '@') {
            safeValue = safeValue.substring(1);
            safeValue = `$[at];${safeValue}`;
        }

        if (safeNewValue && safeNewValue[0] === '@') {
            safeNewValue = safeNewValue.substring(1);
            safeNewValue = `$[at];${safeNewValue}`;
        }

        this._addLine(`gt${inputPlace}`, `s|${safeValue}|${safeNewValue}`);
    }

    // Pre Runner methods
    assignDelay(milliSecond, index = -1) {
        const currentLine = this._getLineByIndex(index);
        if (!currentLine) return;

        const parts = currentLine.split('=', 2);
        const newName = `:${milliSecond})${parts[0]}`;
        const newValue = parts.length > 1 ? parts[1] : "";

        this._updateLineByIndex(index, newName, newValue);
    }

    assignDelayChange(milliSecond, index = -1) {
        const currentLine = this._getLineByIndex(index);
        if (!currentLine) return;

        const parts = currentLine.split('=', 2);
        let currentName = parts[0];

        if (currentName.startsWith(":") && currentName.includes(")")) {
            const closingBracket = currentName.indexOf(')');
            currentName = currentName.substring(closingBracket + 1);
        }

        const newName = `:${milliSecond})${currentName}`;
        const newValue = parts.length > 1 ? parts[1] : "";

        this._updateLineByIndex(index, newName, newValue);
    }

    assignInterval(milliSecond, id = null, index = -1) {
        const currentLine = this._getLineByIndex(index);
        if (!currentLine) return;

        const parts = currentLine.split('=', 2);
        const newName = `(${milliSecond}${id ? `|${id}` : ""})${parts[0]}`;
        const newValue = parts.length > 1 ? parts[1] : "";

        this._updateLineByIndex(index, newName, newValue);
    }

    assignIntervalChange(milliSecond, id = null, index = -1) {
        const currentLine = this._getLineByIndex(index);
        if (!currentLine) return;

        const parts = currentLine.split('=', 2);
        let currentName = parts[0];

        if (currentName.startsWith("(") && currentName.includes(")")) {
            const closingBracket = currentName.indexOf(')');
            currentName = currentName.substring(closingBracket + 1);
        }

        const newName = `(${milliSecond}${id ? `|${id}` : ""})${currentName}`;
        const newValue = parts.length > 1 ? parts[1] : "";

        this._updateLineByIndex(index, newName, newValue);
    }

    deleteInterval(id) {
        this._addLine(`Di`, id);
    }

    assignRepeat(count, index = -1) {
        const currentLine = this._getLineByIndex(index);
        if (!currentLine) return;

        const parts = currentLine.split('=', 2);
        const newName = `,${count})${parts[0]}`;
        const newValue = parts.length > 1 ? parts[1] : "";

        this._updateLineByIndex(index, newName, newValue);
    }

    assignRepeatChange(count, index = -1) {
        const currentLine = this._getLineByIndex(index);
        if (!currentLine) return;

        const parts = currentLine.split('=', 2);
        let currentName = parts[0];

        if (currentName.startsWith(",") && currentName.includes(")")) {
            const closingBracket = currentName.indexOf(')');
            currentName = currentName.substring(closingBracket + 1);
        }

        const newName = `,${count})${currentName}`;
        const newValue = parts.length > 1 ? parts[1] : "";

        this._updateLineByIndex(index, newName, newValue);
    }

    // Index methods
    startIndex(name = "") {
        this._addLine(`#`, name);
    }

    goTo(line, repeat = 1) {
        if (typeof line === 'number') {
            this._addLine(`&`, `${line}|${repeat}`);
        } else {
            this._addLine(`&`, `#${line}|${repeat}`);
        }
    }

    // Start methods
    startTransientDOM(inputPlace) {
        this._addLine(`td`, inputPlace);
    }

    endTransientDOM() {
        this._addLine(`td`, ";");
    }

    // Message methods
    alert(text, type = "none", title = "Alert", okText = "OK") {
        const typeStr = type === "none" ? "" : type;
        const titleStr = title === "Alert" ? "" : title;
        const okTextStr = okText === "OK" ? "" : okText;
        this._addLine(`Al`, `${text}|${typeStr}|${titleStr}|${okTextStr}`);
    }

    message(text, type = "none", duration = 0) {
        const typeStr = type === "none" ? "" : type;
        const durationStr = duration === 0 ? "" : String(duration);
        this._addLine(`me`, `${text}|${typeStr}|${durationStr}`);
    }

    consoleMessage(text, type = "log") {
        const typeStr = type === "log" ? "" : type;
        this._addLine(`mc`, `${text.replace(/\n/g, "$[ln];")}${typeStr ? `|${typeStr}` : ""}`);
    }

    consoleMessageAssert(text, condition) {
        this._addLine(`ma`, `${text.replace(/\n/g, "$[ln];")}|${condition}`);
    }

    // Enable methods
    enableWebSocket(enable = true) {
        this._addLine(`ew`, enable ? "1" : "0");
    }

    enableWebSocketOnce() {
        this._addLine(`ew`, "$");
    }

    addWebSocket(path) {
        this._addLine(`aw${path}`);
    }

    // Use methods
    useWebSocket(inputPlace) {
        this._addLine(`uw${inputPlace}`);
    }

    useOnlyChangeUpdate(inputPlace) {
        this._addLine(`uo${inputPlace}`);
    }

    // Condition methods
    confirmIsTrueAccept(text = "Are you sure you want to proceed?", type = "none", title = "Confirm", okText = "OK", cancelText = "Cancel", interval = 100) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        const textStr = text === "Are you sure you want to proceed?" ? "" : text;
        const typeStr = type === "none" ? "" : type;
        const titleStr = title === "Confirm" ? "" : title;
        const okTextStr = okText === "OK" ? "" : okText;
        const cancelTextStr = cancelText === "Cancel" ? "" : cancelText;
        this._addLine(`${prefix}ct`, `${textStr}|${typeStr}|${titleStr}|${okTextStr}|${cancelTextStr}`);
    }

    confirmIsFalseAccept(text = "Are you sure you want to proceed?", type = "none", title = "Confirm", okText = "OK", cancelText = "Cancel", interval = 100) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        const textStr = text === "Are you sure you want to proceed?" ? "" : text;
        const typeStr = type === "none" ? "" : type;
        const titleStr = title === "Confirm" ? "" : title;
        const okTextStr = okText === "OK" ? "" : okText;
        const cancelTextStr = cancelText === "Cancel" ? "" : cancelText;
        this._addLine(`${prefix}cf`, `${textStr}|${typeStr}|${titleStr}|${okTextStr}|${cancelTextStr}`);
    }

    isGreaterThan(firstValue, secondValue, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}gt`, `${firstValue}|${secondValue}`);
    }

    isLessThan(firstValue, secondValue, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}lt`, `${firstValue}|${secondValue}`);
    }

    isEqualTo(firstValue, secondValue, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}et`, `${firstValue}|${secondValue}`);
    }

    isNotEqualTo(firstValue, secondValue, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}Nt`, `${firstValue}|${secondValue}`);
    }

    exist(value, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}ex`, value);
    }

    notExist(value, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}nx`, value);
    }

    isTrue(value, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}tr`, value);
    }

    isFalse(value, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}fa`, value);
    }

    isMatchMedia(value, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}mm`, value);
    }

    isNotMatchMedia(value, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}nm`, value);
    }

    include(text, value, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}In`, `${value}|${text}`);
    }

    notInclude(text, value, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}Nn`, `${value}|${text}`);
    }

    elementExists(inputPlace, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}eE`, inputPlace);
    }

    elementNotExists(inputPlace, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}nE`, inputPlace);
    }

    isRegexMatch(value, pattern, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}re`, `${value}|${pattern}`);
    }

    isRegexNotMatch(value, pattern, interval = -1) {
        const prefix = interval >= 0 ? `{(${interval})` : "{";
        this._addLine(`${prefix}rn`, `${value}|${pattern}`);
    }

    break() {
        this._addLine(`;`);
    }

    startBracket() {
        this._addLine(`{`);
    }

    endBracket() {
        this._addLine(`}`);
    }

    // Async methods
    async() {
        this._addLine(`{(a)`);
    }

    delay(milliSecond) {
        this._addLine(`De`, String(milliSecond));
    }

    // Format Storage methods
    createFormatStorage(key, data) {
        this._addLine(`.C`, `${key}|${data}`);
    }

    deleteFormatStorage(key) {
        this._addLine(`.D`, key);
    }

    addJSON(key, path, value) {
        this._addLine(`.a`, `${key}|j|${value}|${path}`);
    }

    addXML(key, path, name, value = null) {
        let safeName = name;
        if (safeName && safeName[0] === '@') {
            safeName = safeName.substring(1);
            safeName = `$[at];${safeName}`;
        }
        safeName = safeName.replace(/@/g, "$[at];");
        this._addLine(`.a`, `${key}|x|${safeName}|${value || ""}|${path}`);
    }

    addINI(key, path, value, isINILike = false) {
        this._addLine(`.a`, `${key}|i|${isINILike ? "1" : "0"}|${value}|${path}`);
    }

    addTextLine(key, line, text) {
        this._addLine(`.a`, `${key}|t|${text}|${line}`);
    }

    addVariable(key, value) {
        this._addLine(`.a`, `${key}|v|${value}`);
    }

    updateJSON(key, path, value) {
        this._addLine(`.u`, `${key}|j|${value}|${path}`);
    }

    updateXML(key, path, value) {
        this._addLine(`.u`, `${key}|x|${value}|${path}`);
    }

    updateINI(key, path, value, isINILike = false) {
        this._addLine(`.u`, `${key}|i|${isINILike ? "1" : "0"}|${value}|${path}`);
    }

    updateTextLine(key, line, text) {
        this._addLine(`.u`, `${key}|t|${text}|${line}`);
    }

    updateVariable(key, value) {
        this._addLine(`.u`, `${key}|v|${value}`);
    }

    increaseVariable(key, value) {
        this._addLine(`.i`, `${key}|v|${value}`);
    }

    decreaseVariable(key, value) {
        this.increaseVariable(key, value * -1);
    }

    deleteJSON(key, path) {
        this._addLine(`.d`, `${key}|j|${path}`);
    }

    deleteXML(key, path) {
        this._addLine(`.d`, `${key}|x|${path}`);
    }

    deleteINI(key, path, isINILike = false) {
        this._addLine(`.d`, `${key}|i|${isINILike}|${path}`);
    }

    deleteTextLine(key, line) {
        this._addLine(`.d`, `${key}|t|${line}`);
    }

    deleteVariable(key) {
        this._addLine(`.d`, `${key}|v`);
    }

    // Inject method
    inject(value) {
        return `$[${value}];`;
    }

    // Hash And Checksum methods
    setHash() {
        this._addLine(`SH`);
    }

    setChecksum() {
        this._addLine(`CS`);
    }

    checksumCalculation(text) {
        let sum = 0;
        const mod = 65536;
        const shift = 5;

        for (let i = 0; i < text.length; i++) {
            sum = ((sum << shift) | (sum >> (16 - shift))) ^ text.charCodeAt(i);
            sum %= mod;
        }

        return sum.toString();
    }

    getChecksum() {
        return this.checksumCalculation(this.getWebFormsData());
    }

    // Get methods
    getFormsActionData() {
        return this.webFormsData.join('\n');
    }

    response() {
        return `[web-forms]\n${this.getFormsActionData()}`;
    }

    getFormsActionDataLineBreak() {
        const data = this.getFormsActionData();
        const processedData = data.replace(/"/g, "$[dq];");
        return processedData.replace(/\n/g, "$[sln];");
    }

    // Export methods
    exportToWebFormsTag(src = null) {
        return `<web-forms ac="${this.getFormsActionDataLineBreak()}"${src ? ` src="${src}"` : ''}></web-forms>`;
    }

    exportToLineBreak(src = null) {
        return `[web-forms]$[sln];${this.getFormsActionDataLineBreak()}`;
    }

    exportToWebFormsTagWithDimensions(width, height, src = null) {
        return `<web-forms ac="${this.getFormsActionDataLineBreak()}" width="${width}" height="${height}"${src ? ` src="${src}"` : ''}></web-forms>`;
    }

    doneToWebFormsTag(id = null) {
        return `<web-forms ac="${this.getFormsActionDataLineBreak()}"${id ? ` id="${id}" done="true"` : ''}></web-forms>`;
    }

    exportToHtmlComment(addLine = false) {
        return `${addLine ? '\n' : ''}<!--${this.response()}-->`;
    }

    getWebFormsData() {
        return this.webFormsData.join('\n');
    }

    appendForm(form) {
        if (!form) return;

        const otherData = form.getWebFormsData();
        if (otherData) {
            if (this.webFormsData.length > 0) {
                this.webFormsData.push(...otherData.split('\n'));
            } else {
                this.webFormsData = otherData.split('\n');
            }
        }
    }

    setHeaders(context) {
        context.setHeader("Content-Type", "text/plain");
    }

    clean() {
        this.webFormsData = [];
    }
}

// Security class
class Security {
    safeValue(value) {
        if (!value || value.length < 1) {
            return value;
        }

        let result = value;
        if (result[0] === '@') {
            result = result.substring(1);
            result = `$[at];${result}`;
        }

        result = result.replace(/\n/g, "$[ln];");
        result = result.replace(/\|/g, "$[vb];");
        result = result.replace(/,@/g, "$[co];@");

        return result;
    }
}

// InputPlace class
class InputPlace {
    static get Window() { return "`"; }
    static get Root() { return "~"; }
    static get Current() { return "$"; }
    static get Target() { return "!"; }
    static get Upper() { return "-"; }
    static get Head() { return "^"; }
    static get ScreenOrientation() { return "%"; }

    static id(id) {
        return id;
    }

    static name(name) {
        return `(${name})`;
    }

    static nameWithIndex(name, index) {
        return `(${name})${index}`;
    }

    static allNames(name) {
        return `(${name})*`;
    }

    static tag(tag) {
        return `<${tag}>`;
    }

    static tagWithIndex(tag, index) {
        return `<${tag}>${index}`;
    }

    static allTags(tag) {
        return `<${tag}>*`;
    }

    static className(className) {
        return `{${className}}`;
    }

    static classNameWithIndex(className, index) {
        return `{${className}}${index}`;
    }

    static allClasses(className) {
        return `{${className}}*`;
    }

    static query(query) {
        return `*${query.replace(/=/g, "$[eq];")}`;
    }

    static queryAll(query) {
        return `[${query.replace(/=/g, "$[eq];")}`;
    }
}

// OutputPlace class (extends InputPlace)
class OutputPlace extends InputPlace {}

// Fetch class
class Fetch {
    // Method
    static random(maxValue, minValue = null) {
        if (minValue !== null) {
            return `@mr${maxValue},${minValue}`;
        } else {
            return `@mr${maxValue}`;
        }
    }

    static spaceToChar(text, character = "-") {
        return `@sc${character},${text}`;
    }

    static encodeURI(text) {
        return `@ue${text}`;
    }

    static decodeURI(text) {
        return `@ud${text}`;
    }

    static method(methodName, args = null) {
        let returnValue = `@cm${methodName}`;
        if (args && args.length > 0) {
            returnValue += `,${args.join(",")}`;
        }
        return returnValue;
    }

    static moduleMethod(methodName, args = null) {
        let returnValue = `@cM${methodName}`;
        if (args && args.length > 0) {
            returnValue += `,${args.join(",")}`;
        }
        return returnValue;
    }

    static wasmMethod(wasmLanguage, wasmUrl, methodName, args = null, key = ".") {
        let returnValue = `@wA${wasmLanguage},${wasmUrl},${methodName}`;
        if (args && args.length > 0) {
            returnValue += `,${args.join(",")}`;
        }
        return returnValue;
    }

    static script(scriptText) {
        return `@_${scriptText.replace(/\n/g, "$[ln];")}`;
    }

    static loadUrl(url, fetchScript = false) {
        return `@lu${url}${fetchScript ? ",1" : ""}`;
    }

    static loadHtml(url, fetchInputPlace = null, fetchScript = false) {
        return `@lh${url},${fetchScript ? "1" : "0"}${fetchInputPlace ? `,${fetchInputPlace}` : ""}`;
    }

    static loadLine(url, line) {
        return `@ll${url},${line}`;
    }

    static loadINI(url, name, isINILike = false) {
        return `@li${url},${name}${isINILike ? ",1" : ""}`;
    }

    static loadJSON(url, name) {
        return `@lj${url},${name}`;
    }

    static loadXML(url, name) {
        return `@lx${url},${name}`;
    }

    static hasMethod(methodName) {
        return `@hm${methodName}`;
    }

    static hasModuleMethod(methodName) {
        return `@hM${methodName}`;
    }

    static getModifierState(modifier) {
        return `@ms${modifier}`;
    }

    // Math
    static math(methodName, args = null) {
        let returnValue = `@M#${methodName}`;
        if (args && args.length > 0) {
            returnValue += `,${args.join(",")}`;
        }
        return returnValue;
    }

    // Data
    static get DateYear() { return "@dy"; }
    static get DateMonth() { return "@dm"; }
    static get DateDay() { return "@dd"; }
    static get DateHours() { return "@dh"; }
    static get DateMinutes() { return "@di"; }
    static get DateSeconds() { return "@ds"; }
    static get DateMilliseconds() { return "@dl"; }

    // String
    static get Space() { return "@sp"; }
    static get AtSign() { return "@sa"; }

    // Tag
    static getId(inputPlace) {
        return `@$i${inputPlace}`;
    }

    static getName(inputPlace) {
        return `@$n${inputPlace}`;
    }

    static getValue(inputPlace) {
        return `@$v${inputPlace}`;
    }

    static getValueLength(inputPlace) {
        return `@$e${inputPlace}`;
    }

    static getClass(inputPlace) {
        return `@$c${inputPlace}`;
    }

    static getStyle(inputPlace) {
        return `@$s${inputPlace}`;
    }

    static getTitle(inputPlace) {
        return `@$l${inputPlace}`;
    }

    static getLabel(inputPlace) {
        return `@$A${inputPlace}`;
    }

    static getText(inputPlace) {
        return `@$t${inputPlace}`;
    }

    static getOuterText(inputPlace) {
        return `@$o${inputPlace}`;
    }

    static getTextLength(inputPlace) {
        return `@$g${inputPlace}`;
    }

    static getAttribute(inputPlace, attribute) {
        return `@$a${inputPlace},${attribute}`;
    }

    static getWidth(inputPlace) {
        return `@$w${inputPlace}`;
    }

    static getHeight(inputPlace) {
        return `@$h${inputPlace}`;
    }

    static getIsReadOnly(inputPlace) {
        return `@$r${inputPlace}`;
    }

    static getSelectedIndex(inputPlace) {
        return `@$x${inputPlace}`;
    }

    static getIndex(inputPlace) {
        return `@$I${inputPlace}`;
    }

    static getTextAlign(inputPlace) {
        return `@$T${inputPlace}`;
    }

    static getNodeLength(inputPlace) {
        return `@$L${inputPlace}`;
    }

    static getIsVisible(inputPlace) {
        return `@$V${inputPlace}`;
    }

    // Save
    static hasHash(hash) {
        return `@HH${hash}`;
    }

    static cookie(key) {
        return `@co${key}`;
    }

    static session(key, replaceValue = null) {
        if (replaceValue !== null) {
            return `@cs${key},${replaceValue}`;
        } else {
            return `@cs${key}`;
        }
    }

    static sessionAndRemove(key, replaceValue = null) {
        if (replaceValue !== null) {
            return `@cl${key},${replaceValue}`;
        } else {
            return `@cl${key}`;
        }
    }

    static saved(key = ".") {
        return Fetch.session(key);
    }

    static cache(key = ".", replaceValue = null) {
        if (replaceValue !== null) {
            return `@cd${key},${replaceValue}`;
        } else {
            return `@cd${key}`;
        }
    }

    static cacheAndRemove(key, replaceValue = null) {
        if (replaceValue !== null) {
            return `@ct${key},${replaceValue}`;
        } else {
            return `@ct${key}`;
        }
    }

    static savedLine(key = ".", line = 0) {
        return `@lL${key}[${line}`;
    }

    static savedLineConsume(key = ".") {
        return `@lL${key}`;
    }

    static savedINI(key, iniKey) {
        return `@lI${key}[${iniKey}`;
    }

    static cacheLine(key = ".", line = 0) {
        return `@dL${key}[${line}`;
    }

    static cacheLineConsume(key = ".") {
        return `@dL${key}`;
    }

    static cacheINI(key, iniKey) {
        return `@dI${key}[${iniKey}`;
    }

    // Format Storage
    static formatStore(key) {
        return `@fr${key}`;
    }

    static formatStoreByXMLQuery(key, xpath) {
        return `@fx${key},${xpath}`;
    }

    static formatStoreByJSONQuery(key, query) {
        return `@fj${key},${query}`;
    }

    static formatStoreByINI(key, name) {
        return `@fi${key},${name}`;
    }

    static formatStoreByText(key, line) {
        return `@ft${key},${line}`;
    }

    static formatStoreByVariable(key) {
        return `@fv${key}`;
    }

    // Document
    static get TabIsActive() { return "@da"; }

    // Window
    static get Href() { return "@wf"; }
    static get PathName() { return "@wP"; }
    static get Query() { return "@wq"; }
    static get Hash() { return "@wh"; }
    static get Host() { return "@wH"; }
    static get HostName() { return "@wn"; }
    static get Port() { return "@wT"; }
    static get Origin() { return "@wo"; }
    static get GetSelection() { return "@ws"; }
    static get ScrollX() { return "@wx"; }
    static get ScrollY() { return "@wy"; }

    // Navigator
    static get ClipboardText() { return "@nC"; }
    static get GeoLatitude() { return "@nW"; }
    static get GeoLongitude() { return "@nO"; }
    static get Language() { return "@nL"; }
    static get IsOnLine() { return "@no"; }
    static get UserAgent() { return "@na"; }

    // Screen
    static get ScreenWidth() { return "@sw"; }
    static get ScreenHeight() { return "@sh"; }
    static get ScreenOrientationType() { return "@so"; }
    static get ScreenOrientationAngle() { return "@sr"; }

    // Performance
    static get TimeOrigin() { return "@pt"; }
    static get PerformanceNow() { return "@pn"; }

    // Event
    static get Event() { return "@EV"; }
    static get EventSerialize() { return "@Es"; }
    static get EventKey() { return "@ek"; }
    static get EventWhich() { return "@ew"; }
    static get EventClientX() { return "@ex"; }
    static get EventClientY() { return "@ey"; }
    static get EventPageX() { return "@eX"; }
    static get EventPageY() { return "@eY"; }
    static get EventOffsetX() { return "@Ex"; }
    static get EventOffsetY() { return "@Ey"; }
    static get EventDeltaY() { return "@ed"; }
}

// WasmLanguage class
class WasmLanguage {
    static get C() { return "c"; }
    static get CPP() { return "c"; }
    static get Rust() { return "rust"; }
    static get CSharp() { return "csharp"; }
    static get GO() { return "go"; }
    static get JAVA() { return "java"; }
    static get AssemblyScript() { return "as"; }
}

// HtmlEvent class
class HtmlEvent {
    static get OnAbort() { return "onabort"; }
    static get OnAfterPrint() { return "onafterprint"; }
    static get OnBeforePrint() { return "onbeforeprint"; }
    static get OnBeforeUnload() { return "onbeforeunload"; }
    static get OnBlur() { return "onblur"; }
    static get OnCanPlay() { return "oncanplay"; }
    static get OnCanPlayThrough() { return "oncanplaythrough"; }
    static get OnChange() { return "onchange"; }
    static get OnClick() { return "onclick"; }
    static get OnCopy() { return "oncopy"; }
    static get OnCut() { return "oncut"; }
    static get OnDoubleClick() { return "ondblclick"; }
    static get OnDrag() { return "ondrag"; }
    static get OnDragEnd() { return "ondragend"; }
    static get OnDragEnter() { return "ondragenter"; }
    static get OnDragLeave() { return "ondragleave"; }
    static get OnDragOver() { return "ondragover"; }
    static get OnDragStart() { return "ondragstart"; }
    static get OnDrop() { return "ondrop"; }
    static get OnDurationChange() { return "ondurationchange"; }
    static get OnEnded() { return "onended"; }
    static get OnError() { return "onerror"; }
    static get OnFocus() { return "onfocus"; }
    static get OnFocusin() { return "onfocusin"; }
    static get OnFocusOut() { return "onfocusout"; }
    static get OnHashChange() { return "onhashchange"; }
    static get OnInput() { return "oninput"; }
    static get OnInvalid() { return "oninvalid"; }
    static get OnKeyDown() { return "onkeydown"; }
    static get OnKeyPress() { return "onkeypress"; }
    static get OnKeyUp() { return "onkeyup"; }
    static get OnLoad() { return "onload"; }
    static get OnLoadedData() { return "onloadeddata"; }
    static get OnLoadedMetaData() { return "onloadedmetadata"; }
    static get OnLoadStart() { return "onloadstart"; }
    static get OnMouseDown() { return "onmousedown"; }
    static get OnMouseEnter() { return "onmouseenter"; }
    static get OnMouseLeave() { return "onmouseleave"; }
    static get OnMouseMove() { return "onmousemove"; }
    static get OnMouseOver() { return "onmouseover"; }
    static get OnMouseOut() { return "onmouseout"; }
    static get OnMouseUp() { return "onmouseup"; }
    static get OnOffline() { return "onoffline"; }
    static get OnOnline() { return "ononline"; }
    static get OnPageHide() { return "onpagehide"; }
    static get OnPageShow() { return "onpageshow"; }
    static get OnPaste() { return "onpaste"; }
    static get OnPause() { return "onpause"; }
    static get OnPlay() { return "onplay"; }
    static get OnPlaying() { return "onplaying"; }
    static get OnProgress() { return "onprogress"; }
    static get OnRateChange() { return "onratechange"; }
    static get OnResize() { return "onresize"; }
    static get OnReset() { return "onreset"; }
    static get OnScroll() { return "onscroll"; }
    static get OnSearch() { return "onsearch"; }
    static get OnSeeked() { return "onseeked"; }
    static get OnSeeking() { return "onseeking"; }
    static get OnSelect() { return "onselect"; }
    static get OnStalled() { return "onstalled"; }
    static get OnSubmit() { return "onsubmit"; }
    static get OnSuspend() { return "onsuspend"; }
    static get OnTimeUpdate() { return "ontimeupdate"; }
    static get OnToggle() { return "ontoggle"; }
    static get OnTouchCancel() { return "ontouchcancel"; }
    static get OnTouchend() { return "ontouchend"; }
    static get OnTouchMove() { return "ontouchmove"; }
    static get OnTouchStart() { return "ontouchstart"; }
    static get OnUnload() { return "onunload"; }
    static get OnVolumeChange() { return "onvolumechange"; }
    static get OnWaiting() { return "onwaiting"; }
    static get OnWheel() { return "onwheel"; }
}

// HtmlEventListener class
class HtmlEventListener {
    static get Abort() { return "abort"; }
    static get AfterPrint() { return "afterprint"; }
    static get BeforePrint() { return "beforeprint"; }
    static get BeforeUnload() { return "beforeunload"; }
    static get Blur() { return "blur"; }
    static get CanPlay() { return "canplay"; }
    static get CanPlayThrough() { return "canplaythrough"; }
    static get Change() { return "change"; }
    static get Click() { return "click"; }
    static get Copy() { return "copy"; }
    static get Cut() { return "cut"; }
    static get DoubleClick() { return "dblclick"; }
    static get Drag() { return "drag"; }
    static get DragEnd() { return "dragend"; }
    static get DragEnter() { return "dragenter"; }
    static get DragLeave() { return "dragleave"; }
    static get DragOver() { return "dragover"; }
    static get DragStart() { return "dragstart"; }
    static get Drop() { return "drop"; }
    static get DurationChange() { return "durationchange"; }
    static get Ended() { return "ended"; }
    static get Error() { return "error"; }
    static get Focus() { return "focus"; }
    static get Focusin() { return "focusin"; }
    static get FocusOut() { return "focusout"; }
    static get HashChange() { return "hashchange"; }
    static get Input() { return "input"; }
    static get Invalid() { return "invalid"; }
    static get KeyDown() { return "keydown"; }
    static get KeyPress() { return "keypress"; }
    static get KeyUp() { return "keyup"; }
    static get Load() { return "load"; }
    static get LoadedData() { return "loadeddata"; }
    static get LoadedMetaData() { return "loadedmetadata"; }
    static get LoadStart() { return "loadstart"; }
    static get MouseDown() { return "mousedown"; }
    static get MouseEnter() { return "mouseenter"; }
    static get MouseLeave() { return "mouseleave"; }
    static get MouseMove() { return "mousemove"; }
    static get MouseOver() { return "mouseover"; }
    static get MouseOut() { return "mouseout"; }
    static get MouseUp() { return "mouseup"; }
    static get Offline() { return "offline"; }
    static get Online() { return "online"; }
    static get PageHide() { return "pagehide"; }
    static get PageShow() { return "pageshow"; }
    static get Paste() { return "paste"; }
    static get Pause() { return "pause"; }
    static get Play() { return "play"; }
    static get Playing() { return "playing"; }
    static get Progress() { return "progress"; }
    static get RateChange() { return "ratechange"; }
    static get Resize() { return "resize"; }
    static get Reset() { return "reset"; }
    static get Scroll() { return "scroll"; }
    static get Search() { return "search"; }
    static get Seeked() { return "seeked"; }
    static get Seeking() { return "seeking"; }
    static get Select() { return "select"; }
    static get Stalled() { return "stalled"; }
    static get Submit() { return "submit"; }
    static get Suspend() { return "suspend"; }
    static get TimeUpdate() { return "timeupdate"; }
    static get Toggle() { return "toggle"; }
    static get TouchCancel() { return "touchcancel"; }
    static get Touchend() { return "touchend"; }
    static get TouchMove() { return "touchmove"; }
    static get TouchStart() { return "touchstart"; }
    static get Unload() { return "unload"; }
    static get VolumeChange() { return "volumechange"; }
    static get Waiting() { return "waiting"; }
    static get Wheel() { return "wheel"; }

    static get AnimationEnd() { return "animationend"; }
    static get AnimationIteration() { return "animationiteration"; }
    static get AnimationStart() { return "animationstart"; }
    static get ContextMenu() { return "contextmenu"; }
    static get FullScreenChange() { return "fullscreenchange"; }
    static get FullScreenError() { return "fullscreenerror"; }
    static get PopState() { return "popstate"; }
    static get TransitionEnd() { return "transitionend"; }
    static get Storage() { return "storage"; }

    // Custom
    static get ScrollBottom() { return "scrollbottom"; }
    static get ElementReached() { return "elementreached"; }
}

// ExtensionWebFormsMethods class
class ExtensionWebFormsMethods {
    static appendPlace(text, value) {
        if (!text || text.length < 1) {
            return value;
        }
        return `${text}|${value}`;
    }

    static appendParent(text) {
        return `/${text}`;
    }

    static exportActionControlsToWebFormsTag(actionControls, addLine = false) {
        return `${addLine ? '\n' : ''}<web-forms ac="${actionControls}"></web-forms>`;
    }

    static exportActionControlsToHtmlComment(actionControls, addLine = false) {
        return `${addLine ? '\n' : ''}<!--[web-forms]\n${actionControls}-->`;
    }

    static exportActionControlsToResponse(actionControls) {
        return `[web-forms]\n${actionControls}`;
    }

    static removeOuter(text, startString, endString) {
        const start = text.indexOf(startString);
        if (start === -1) return text;

        const end = text.indexOf(endString, start);
        if (end === -1) return text;

        const lengthToRemove = (end - start) + endString.length;
        return text.substring(0, start) + text.substring(end + endString.length);
    }

    static lineBreak(text) {
        return text.replace(/\n/g, "$[sln]");
    }
}

// Export all classes
module.exports = {
    WebForms,
    Security,
    InputPlace,
    OutputPlace,
    Fetch,
    WasmLanguage,
    HtmlEvent,
    HtmlEventListener,
    ExtensionWebFormsMethods
};


