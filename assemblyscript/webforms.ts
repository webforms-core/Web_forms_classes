// webforms.ts 2.1 - The WebAssembly Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.1

export const GS: string = String.fromCharCode(29);
export const US: string = String.fromCharCode(31);
export const RS: string = String.fromCharCode(30);

export class WebForms {
    private webFormsData: string = "";

    private _add(name: string, value: string | null = null): void {
        if (this.webFormsData.length > 0) {
            this.webFormsData += "\n";
        }
        this.webFormsData += name;
        if (value !== null) {
            this.webFormsData += "=" + value;
        }
    }

    private _addToUp(name: string, value: string | null = null): void {
        const line = value !== null ? `${name}=${value}` : name;
        if (this.webFormsData.length > 0) {
            this.webFormsData = line + "\n" + this.webFormsData;
        } else {
            this.webFormsData = line;
        }
    }

    private _getLineByIndex(index: i32): string {
        if (this.webFormsData.length == 0) return "";
        const lines = this.webFormsData.split("\n");
        if (index < 0) index = lines.length + index;
        if (index < 0 || index >= lines.length) return "";
        return lines[index];
    }

    private _updateLineByIndex(index: i32, name: string, value: string): void {
        if (this.webFormsData.length == 0) return;
        const lines = this.webFormsData.split("\n");
        if (index < 0) index = lines.length + index;
        if (index < 0 || index >= lines.length) return;
        lines[index] = name + (value.length ? "=" + value : "");
        this.webFormsData = lines.join("\n");
    }

    // For Extension
    public addLine(name: string, value: string): void {
        this._add(name, value);
    }

	// Add
	// Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.
    public addId(inputPlace: string, id: string): void {
        this._add("ai" + inputPlace, id);
    }

    public addName(inputPlace: string, name: string): void {
        this._add("an" + inputPlace, name);
    }

    public addValue(inputPlace: string, value: string): void {
        this._add("av" + inputPlace, value);
    }

    public addClass(inputPlace: string, className: string): void {
        this._add("ac" + inputPlace, className);
    }

    public addStyle(inputPlace: string, style: string): void {
        this._add("as" + inputPlace, style);
    }

    public addStyleNameValue(inputPlace: string, name: string, value: string): void {
        this._add("as" + inputPlace, name + ":" + value);
    }

    public addOptionTag(inputPlace: string, text: string, value: string, selected: boolean = false): void {
        this._add("ao" + inputPlace, value + GS + text + (selected ? GS + "1" : ""));
    }

    public addCheckBoxTag(inputPlace: string, text: string, value: string, checked: boolean = false): void {
        this._add("ak" + inputPlace, value + GS + text + (checked ? GS + "1" : ""));
    }

    public addTitle(inputPlace: string, title: string): void {
        this._add("al" + inputPlace, title);
    }

    public addLabel(inputPlace: string, label: string): void {
        this._add("aA" + inputPlace, label);
    }

    public addText(inputPlace: string, text: string): void {
        this._add("at" + inputPlace, text.replace("\n", "$[ln];"));
    }

    public addTextToUp(inputPlace: string, text: string): void {
        this._addToUp("pt" + inputPlace, text.replace("\n", "$[ln];"));
    }

    public addAttribute(inputPlace: string, attribute: string, value: string = "", splitter: string = ""): void {
        const splitterStr = splitter ? splitter : "";
        const valuePart = value.length > 0 ? GS + value : "";
        this._add("aa" + inputPlace, attribute + GS + splitterStr + valuePart);
    }

    public addTag(inputPlace: string, tagName: string, id: string = ""): void {
        const idPart = id.length > 0 ? GS + id : "";
        this._add("nt" + inputPlace, tagName + idPart);
    }

    public addTagToUp(inputPlace: string, tagName: string, id: string = ""): void {
        const idPart = id.length > 0 ? GS + id : "";
        this._add("ut" + inputPlace, tagName + idPart);
    }

    public addTagBefore(inputPlace: string, tagName: string, id: string = ""): void {
        const idPart = id.length > 0 ? GS + id : "";
        this._add("bt" + inputPlace, tagName + idPart);
    }

    public addTagAfter(inputPlace: string, tagName: string, id: string = ""): void {
        const idPart = id.length > 0 ? GS + id : "";
        this._add("ft" + inputPlace, tagName + idPart);
    }

    public addHidden(inputPlace: string, name: string, value: string, id: string = ""): void {
        const idPart = id.length > 0 ? GS + id : "";
        this._add("ah" + inputPlace, name + GS + value + idPart);
    }

    // Set
	// Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.
    public setId(inputPlace: string, id: string): void {
        this._add("si" + inputPlace, id);
    }

    public setName(inputPlace: string, name: string): void {
        this._add("sn" + inputPlace, name);
    }

    public setValue(inputPlace: string, value: string): void {
        this._add("sv" + inputPlace, value);
    }

    public setClass(inputPlace: string, className: string): void {
        this._add("sc" + inputPlace, className);
    }

    public setStyle(inputPlace: string, style: string): void {
        this._add("ss" + inputPlace, style);
    }

    public setStyleNameValue(inputPlace: string, name: string, value: string): void {
        this._add("ss" + inputPlace, name + ":" + value);
    }

    public setOptionTag(inputPlace: string, text: string, value: string, selected: boolean = false): void {
        this._add("so" + inputPlace, value + GS + text + (selected ? GS + "1" : ""));
    }

    public setChecked(inputPlace: string, checked: boolean = false): void {
        this._add("sk" + inputPlace, checked ? "1" : "0");
    }

    public setCheckBoxTag(inputPlace: string, text: string, value: string, checked: boolean = false): void {
        this._add("sk" + inputPlace, value + GS + text + (checked ? GS + "1" : ""));
    }

    public setTitle(inputPlace: string, title: string): void {
        this._add("sl" + inputPlace, title);
    }

    public setLabel(inputPlace: string, label: string): void {
        this._add("sA" + inputPlace, label);
    }

    public setText(inputPlace: string, text: string): void {
        this._add("st" + inputPlace, text.replace("\n", "$[ln];"));
    }

    public setAttribute(inputPlace: string, attribute: string, value: string = ""): void {
        const valuePart = value.length > 0 ? GS + value : "";
        this._add("sa" + inputPlace, attribute + GS + valuePart);
    }

    public setWidth(inputPlace: string, width: string): void {
        this._add("sw" + inputPlace, width);
    }

    public setWidthInt(inputPlace: string, width: i32): void {
        this.setWidth(inputPlace, width.toString() + "px");
    }

    public setHeight(inputPlace: string, height: string): void {
        this._add("sh" + inputPlace, height);
    }

    public setHeightInt(inputPlace: string, height: i32): void {
        this.setHeight(inputPlace, height.toString() + "px");
    }

    public setBackgroundColor(inputPlace: string, color: string): void {
        this._add("bc" + inputPlace, color);
    }

    public setTextColor(inputPlace: string, color: string): void {
        this._add("tc" + inputPlace, color);
    }

    public setFontName(inputPlace: string, name: string): void {
        this._add("fn" + inputPlace, name);
    }

    public setFontSize(inputPlace: string, size: string): void {
        this._add("fs" + inputPlace, size);
    }

    public setFontSizeInt(inputPlace: string, size: i32): void {
        this._add("fs" + inputPlace, size.toString() + "px");
    }

    public setFontBold(inputPlace: string, bold: boolean): void {
        this._add("fb" + inputPlace, bold ? "1" : "0");
    }

    public setVisible(inputPlace: string, visible: boolean): void {
        this._add("vi" + inputPlace, visible ? "1" : "0");
    }

    public setTextAlign(inputPlace: string, align: string): void {
        this._add("ta" + inputPlace, align);
    }

    public setReadOnly(inputPlace: string, readOnly: boolean): void {
        this._add("sr" + inputPlace, readOnly ? "1" : "0");
    }

    public setDisabled(inputPlace: string, disabled: boolean): void {
        this._add("sd" + inputPlace, disabled ? "1" : "0");
    }

    public setFocus(inputPlace: string, focus: boolean): void {
        this._add("sf" + inputPlace, focus ? "1" : "0");
    }

    public setMinLength(inputPlace: string, length: string): void {
        this._add("mn" + inputPlace, length);
    }

    public setMinLengthInt(inputPlace: string, length: i32): void {
        this.setMinLength(inputPlace, length.toString());
    }

    public setMaxLength(inputPlace: string, length: string): void {
        this._add("mx" + inputPlace, length);
    }

    public setMaxLengthInt(inputPlace: string, length: i32): void {
        this.setMaxLength(inputPlace, length.toString());
    }

    public setSelectedValue(inputPlace: string, value: string): void {
        this._add("ts" + inputPlace, value);
    }

    public setSelectedIndex(inputPlace: string, index: string): void {
        this._add("ti" + inputPlace, index);
    }

    public setSelectedIndexInt(inputPlace: string, index: i32): void {
        this.setSelectedIndex(inputPlace, index.toString());
    }

    public setCheckedValue(inputPlace: string, value: string, checked: boolean): void {
        this._add("ks" + inputPlace, value + GS + (checked ? "1" : "0"));
    }

    public setCheckedIndex(inputPlace: string, index: string, checked: boolean): void {
        this._add("ki" + inputPlace, index + GS + (checked ? "1" : "0"));
    }

    public setCheckedIndexInt(inputPlace: string, index: i32, checked: boolean): void {
        this.setCheckedIndex(inputPlace, index.toString(), checked);
    }

	// Insert
	// Creates the Data only if it does not exist; otherwise, does nothing.
    public insertId(inputPlace: string, id: string): void {
        this._add("ii" + inputPlace, id);
    }

    public insertName(inputPlace: string, name: string): void {
        this._add("in" + inputPlace, name);
    }

    public insertValue(inputPlace: string, value: string): void {
        this._add("iv" + inputPlace, value);
    }

    public insertClass(inputPlace: string, className: string): void {
        this._add("ic" + inputPlace, className);
    }

    public insertStyle(inputPlace: string, style: string): void {
        this._add("is" + inputPlace, style);
    }

    public insertStyleNameValue(inputPlace: string, name: string, value: string): void {
        this._add("is" + inputPlace, name + ":" + value);
    }

    public insertOptionTag(inputPlace: string, text: string, value: string, selected: boolean = false): void {
        this._add("io" + inputPlace, value + GS + text + (selected ? GS + "1" : ""));
    }

    public insertCheckBoxTag(inputPlace: string, text: string, value: string, checked: boolean = false): void {
        this._add("ik" + inputPlace, value + GS + text + (checked ? GS + "1" : ""));
    }

    public insertTitle(inputPlace: string, title: string): void {
        this._add("il" + inputPlace, title);
    }

    public insertLabel(inputPlace: string, label: string): void {
        this._add("iA" + inputPlace, label);
    }

    public insertText(inputPlace: string, text: string): void {
        this._add("it" + inputPlace, text.replace("\n", "$[ln];"));
    }

    public insertAttribute(inputPlace: string, attribute: string, value: string = "", splitter: string = ""): void {
        const splitterStr = splitter ? splitter : "";
        const valuePart = value.length > 0 ? GS + value : "";
        this._add("ia" + inputPlace, attribute + GS + splitterStr + valuePart);
    }

    // Delete
    public deleteId(inputPlace: string): void {
        this._add("di" + inputPlace);
    }

    public deleteName(inputPlace: string): void {
        this._add("dn" + inputPlace);
    }

    public deleteValue(inputPlace: string): void {
        this._add("dv" + inputPlace);
    }

    public deleteClass(inputPlace: string, className: string): void {
        this._add("dc" + inputPlace, className);
    }

    public deleteStyle(inputPlace: string, styleName: string): void {
        this._add("ds" + inputPlace, styleName);
    }

    public deleteOptionTag(inputPlace: string, value: string): void {
        this._add("do" + inputPlace, value);
    }

    public deleteAllOptionTag(inputPlace: string): void {
        this._add("do" + inputPlace, "*");
    }

    public deleteCheckBoxTag(inputPlace: string, value: string): void {
        this._add("dk" + inputPlace, value);
    }

    public deleteAllCheckBoxTag(inputPlace: string): void {
        this._add("dk" + inputPlace, "*");
    }

    public deleteTitle(inputPlace: string): void {
        this._add("dl" + inputPlace);
    }

    public deleteLabel(inputPlace: string): void {
        this._add("dA" + inputPlace);
    }

    public deleteText(inputPlace: string): void {
        this._add("dt" + inputPlace);
    }

    public deleteAttribute(inputPlace: string, attribute: string): void {
        this._add("da" + inputPlace, attribute);
    }

    public delete(inputPlace: string): void {
        this._add("de" + inputPlace);
    }

    public deleteParent(inputPlace: string): void {
        this._add("dp" + inputPlace);
    }

    // Tag
    public swapTag(inputPlace: string, outputPlace: string): void {
        this._add("sp" + inputPlace, outputPlace);
    }

    public setReflection(inputPlace: string, tag: string): void {
        this._add("sR" + inputPlace, tag);
    }

    public setReflectionByOutputPlace(inputPlace: string, outputPlace: string): void {
        this._add("iR" + inputPlace, outputPlace);
    }

    public setMorph(inputPlace: string, tag: string): void {
        this._add("sM" + inputPlace, tag);
    }

    public setMorphByOutputPlace(inputPlace: string, outputPlace: string): void {
        this._add("iM" + inputPlace, outputPlace);
    }

    // Browser
    public changeUrl(url: string): void {
        this._add("cu", url);
    }

    public setHeadTitle(title: string): void {
        this._add("ht", title);
    }

    public clipboardWriteText(text: string): void {
        this._add("nw", text);
    }

    public scrollTo(x: string, y: string): void {
        this._add("ws", x + GS + y);
    }

    public scrollToInt(x: i32, y: i32): void {
        this.scrollTo(x.toString(), y.toString());
    }

    public historyGo(steps: string): void {
        this._add("wg", steps);
    }

    public historyGoInt(steps: i32): void {
        this.historyGo(steps.toString());
    }

    public reloadPage(): void {
        this._add("lr");
    }

    public redirect(path: string): void {
        this._add("lh", path);
    }

    // Increase
    public increaseMinLength(inputPlace: string, value: string): void {
        this._add("+n" + inputPlace, value);
    }

    public increaseMinLengthInt(inputPlace: string, value: i32): void {
        this.increaseMinLength(inputPlace, value.toString());
    }

    public increaseMaxLength(inputPlace: string, value: string): void {
        this._add("+x" + inputPlace, value);
    }

    public increaseMaxLengthInt(inputPlace: string, value: i32): void {
        this.increaseMaxLength(inputPlace, value.toString());
    }

    public increaseFontSize(inputPlace: string, value: string): void {
        this._add("+f" + inputPlace, value);
    }

    public increaseFontSizeInt(inputPlace: string, value: i32): void {
        this.increaseFontSize(inputPlace, value.toString());
    }

    public increaseWidth(inputPlace: string, value: string): void {
        this._add("+w" + inputPlace, value);
    }

    public increaseWidthInt(inputPlace: string, value: i32): void {
        this.increaseWidth(inputPlace, value.toString());
    }

    public increaseHeight(inputPlace: string, value: string): void {
        this._add("+h" + inputPlace, value);
    }

    public increaseHeightInt(inputPlace: string, value: i32): void {
        this.increaseHeight(inputPlace, value.toString());
    }

    public increaseValue(inputPlace: string, value: string): void {
        this._add("+v" + inputPlace, value);
    }

    public increaseValueInt(inputPlace: string, value: i32): void {
        this.increaseValue(inputPlace, value.toString());
    }

    // Decrease
    public decreaseMinLength(inputPlace: string, value: string): void {
        this._add("-n" + inputPlace, value);
    }

    public decreaseMinLengthInt(inputPlace: string, value: i32): void {
        this.decreaseMinLength(inputPlace, value.toString());
    }

    public decreaseMaxLength(inputPlace: string, value: string): void {
        this._add("-x" + inputPlace, value);
    }

    public decreaseMaxLengthInt(inputPlace: string, value: i32): void {
        this.decreaseMaxLength(inputPlace, value.toString());
    }

    public decreaseFontSize(inputPlace: string, value: string): void {
        this._add("-f" + inputPlace, value);
    }

    public decreaseFontSizeInt(inputPlace: string, value: i32): void {
        this.decreaseFontSize(inputPlace, value.toString());
    }

    public decreaseWidth(inputPlace: string, value: string): void {
        this._add("-w" + inputPlace, value);
    }

    public decreaseWidthInt(inputPlace: string, value: i32): void {
        this.decreaseWidth(inputPlace, value.toString());
    }

    public decreaseHeight(inputPlace: string, value: string): void {
        this._add("-h" + inputPlace, value);
    }

    public decreaseHeightInt(inputPlace: string, value: i32): void {
        this.decreaseHeight(inputPlace, value.toString());
    }

    public decreaseValue(inputPlace: string, value: string): void {
        this._add("-v" + inputPlace, value);
    }

    public decreaseValueInt(inputPlace: string, value: i32): void {
        this.decreaseValue(inputPlace, value.toString());
    }

	// Event
	// ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
	// All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.
    public triggerEvent(inputPlace: string, htmlEventListener: string, constructorName: string | null = null): void {
        this._add("TE" + inputPlace, htmlEventListener + (constructorName ? GS + constructorName : ""));
    }

    public setPostEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Ep" + inputPlace, htmlEvent);
    }

    public setPostEventOutput(inputPlace: string, htmlEvent: string, outputPlace: string): void {
        this._add("Ep" + inputPlace, htmlEvent + GS + outputPlace);
    }

    public setPostEventAddView(inputPlace: string, htmlEvent: string): void {
        this._add("Ep" + inputPlace, htmlEvent + GS + "+");
    }

    public setPostEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("EP" + inputPlace, htmlEventListener);
    }

    public setPostEventListenerOutput(inputPlace: string, htmlEventListener: string, outputPlace: string): void {
        this._add("EP" + inputPlace, htmlEventListener + GS + outputPlace);
    }

    public setPostEventListenerAddView(inputPlace: string, htmlEventListener: string): void {
        this._add("EP" + inputPlace, htmlEventListener + GS + "+");
    }

    public setGetEvent(inputPlace: string, htmlEvent: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("Eg" + inputPlace, htmlEvent + GS + pathStr);
    }

    public setGetEventOutput(inputPlace: string, htmlEvent: string, outputPlace: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("Eg" + inputPlace, htmlEvent + GS + pathStr + GS + outputPlace);
    }

    public setGetEventListener(inputPlace: string, htmlEventListener: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("EG" + inputPlace, htmlEventListener + GS + pathStr);
    }

    public setGetEventListenerOutput(inputPlace: string, htmlEventListener: string, outputPlace: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("EG" + inputPlace, htmlEventListener + GS + pathStr + GS + outputPlace);
    }

    public setPutEvent(inputPlace: string, htmlEvent: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("Et" + inputPlace, htmlEvent + GS + pathStr);
    }

    public setPutEventOutput(inputPlace: string, htmlEvent: string, outputPlace: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("Et" + inputPlace, htmlEvent + GS + pathStr + GS + outputPlace);
    }

    public setPutEventListener(inputPlace: string, htmlEventListener: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("ET" + inputPlace, htmlEventListener + GS + pathStr);
    }

    public setPutEventListenerOutput(inputPlace: string, htmlEventListener: string, outputPlace: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("ET" + inputPlace, htmlEventListener + GS + pathStr + GS + outputPlace);
    }

    public setPatchEvent(inputPlace: string, htmlEvent: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("Ea" + inputPlace, htmlEvent + GS + pathStr);
    }

    public setPatchEventOutput(inputPlace: string, htmlEvent: string, outputPlace: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("Ea" + inputPlace, htmlEvent + GS + pathStr + GS + outputPlace);
    }

    public setPatchEventListener(inputPlace: string, htmlEventListener: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("EA" + inputPlace, htmlEventListener + GS + pathStr);
    }

    public setPatchEventListenerOutput(inputPlace: string, htmlEventListener: string, outputPlace: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("EA" + inputPlace, htmlEventListener + GS + pathStr + GS + outputPlace);
    }

    public setDeleteEvent(inputPlace: string, htmlEvent: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("El" + inputPlace, htmlEvent + GS + pathStr);
    }

    public setDeleteEventOutput(inputPlace: string, htmlEvent: string, outputPlace: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("El" + inputPlace, htmlEvent + GS + pathStr + GS + outputPlace);
    }

    public setDeleteEventListener(inputPlace: string, htmlEventListener: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("EL" + inputPlace, htmlEventListener + GS + pathStr);
    }

    public setDeleteEventListenerOutput(inputPlace: string, htmlEventListener: string, outputPlace: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("EL" + inputPlace, htmlEventListener + GS + pathStr + GS + outputPlace);
    }

    public setOptionsEvent(inputPlace: string, htmlEvent: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("Eo" + inputPlace, htmlEvent + GS + pathStr);
    }

    public setOptionsEventOutput(inputPlace: string, htmlEvent: string, outputPlace: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("Eo" + inputPlace, htmlEvent + GS + pathStr + GS + outputPlace);
    }

    public setOptionsEventListener(inputPlace: string, htmlEventListener: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("EO" + inputPlace, htmlEventListener + GS + pathStr);
    }

    public setOptionsEventListenerOutput(inputPlace: string, htmlEventListener: string, outputPlace: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("EO" + inputPlace, htmlEventListener + GS + pathStr + GS + outputPlace);
    }

    public setHeadEvent(inputPlace: string, htmlEvent: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("Eh" + inputPlace, htmlEvent + GS + pathStr);
    }

    public setHeadEventListener(inputPlace: string, htmlEventListener: string, path: string | null = null): void {
        const pathStr = path ? path : "#";
        this._add("EH" + inputPlace, htmlEventListener + GS + pathStr);
    }

    // IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
    public setSendEvent(inputPlace: string, htmlEvent: string, data: string, path: string | null = null, method: string = "POST", isMultiPart: boolean = false, contentType: string = "text/plain", outputPlace: string | null = null): void {
        const pathStr = path ? path : "#";
        const outputStr = outputPlace ? GS + outputPlace : "";
        const dataStr = data.replace("\n", "$[ln];").replace("\"", "$[dq];").replace("'", "$[sq];");
        this._add("En" + inputPlace, htmlEvent + GS + dataStr + GS + pathStr + GS + method + GS + (isMultiPart ? "1" : "0") + GS + contentType + outputStr);
    }

    public setSendEventListener(inputPlace: string, htmlEventListener: string, data: string, path: string | null = null, method: string = "POST", isMultiPart: boolean = false, contentType: string = "text/plain", outputPlace: string | null = null): void {
        const pathStr = path ? path : "#";
        const outputStr = outputPlace ? GS + outputPlace : "";
        const dataStr = data.replace("\n", "$[ln];");
        this._add("EN" + inputPlace, htmlEventListener + GS + dataStr + GS + pathStr + GS + method + GS + (isMultiPart ? "1" : "0") + GS + contentType + outputStr);
    }

    public setCommentEvent(inputPlace: string, htmlEvent: string, index: string | null = null, outputPlace: string | null = null): void {
        const indexStr = index ? index : "";
        const outputStr = outputPlace ? GS + outputPlace : "";
        this._add("Eb" + inputPlace, htmlEvent + GS + indexStr + outputStr);
    }

    public setCommentEventI32(inputPlace: string, htmlEvent: string, index: i32, outputPlace: string | null = null): void {
        this.setCommentEvent(inputPlace, htmlEvent, index.toString(), outputPlace);
    }

    public setCommentEventListener(inputPlace: string, htmlEventListener: string, index: string | null = null, outputPlace: string | null = null): void {
        const indexStr = index ? index : "";
        const outputStr = outputPlace ? GS + outputPlace : "";
        this._add("EB" + inputPlace, htmlEventListener + GS + indexStr + outputStr);
    }

    public setCommentEventListenerI32(inputPlace: string, htmlEventListener: string, index: i32, outputPlace: string | null = null): void {
        this.setCommentEventListener(inputPlace, htmlEventListener, index.toString(), outputPlace);
    }

    public setWasmEvent(inputPlace: string, htmlEvent: string, wasmLanguage: string, wasmUrl: string, methodName: string, args: string[] | null = null, outputPlace: string | null = null): void {
        const argsJoin = args && args.length > 0 ? "[" + args.join(US) : "";
        this._add("Ey" + inputPlace, htmlEvent + GS + wasmLanguage + GS + wasmUrl + GS + methodName + GS + argsJoin + GS + (outputPlace ? outputPlace : ""));
    }

    public setWasmEventListener(inputPlace: string, htmlEventListener: string, wasmLanguage: string, wasmUrl: string, methodName: string, args: string[] | null = null, outputPlace: string | null = null): void {
        const argsJoin = args && args.length > 0 ? "[" + args.join(US) : "";
        this._add("EY" + inputPlace, htmlEventListener + GS + wasmLanguage + GS + wasmUrl + GS + methodName + GS + argsJoin + GS + (outputPlace ? outputPlace : ""));
    }

    public setWebSocketEvent(inputPlace: string, htmlEvent: string, path: string): void {
        this._add("Ew" + inputPlace, htmlEvent + GS + path);
    }

    public setWebSocketEventListener(inputPlace: string, htmlEventListener: string, path: string): void {
        this._add("EW" + inputPlace, htmlEventListener + GS + path);
    }

    public setSSEEvent(inputPlace: string, htmlEvent: string, path: string, shouldReconnect: boolean = true, reconnectTryTimeout: i32 = 3000): void {
        this._add("Ee" + inputPlace, htmlEvent + GS + path + GS + (shouldReconnect ? "1" : "0") + GS + reconnectTryTimeout.toString());
    }

    public setSSEEventOutput(inputPlace: string, htmlEvent: string, path: string, outputPlace: string, shouldReconnect: boolean = true, reconnectTryTimeout: i32 = 3000): void {
        this._add("Ee" + inputPlace, htmlEvent + GS + path + GS + (shouldReconnect ? "1" : "0") + GS + reconnectTryTimeout.toString() + GS + outputPlace);
    }

    public setSSEEventListener(inputPlace: string, htmlEventListener: string, path: string, shouldReconnect: boolean = true, reconnectTryTimeout: i32 = 3000): void {
        this._add("EE" + inputPlace, htmlEventListener + GS + path + GS + (shouldReconnect ? "1" : "0") + GS + reconnectTryTimeout.toString());
    }

    public setSSEEventListenerOutput(inputPlace: string, htmlEventListener: string, path: string, outputPlace: string, shouldReconnect: boolean = true, reconnectTryTimeout: i32 = 3000): void {
        this._add("EE" + inputPlace, htmlEventListener + GS + path + GS + (shouldReconnect ? "1" : "0") + GS + reconnectTryTimeout.toString() + GS + outputPlace);
    }

    public setFrontEvent(inputPlace: string, htmlEvent: string, modulePath: string, args: string[] | null = null, outputPlace: string | null = null): void {
        let argsJoin = "";
        if (args) {
            argsJoin = args.length > 0 ? GS + "[" + args.join(US) : "";
        }
        this._add("Ej" + inputPlace, htmlEvent + GS + modulePath + GS + (outputPlace ? outputPlace : "") + argsJoin);
    }

    public setFrontEventListener(inputPlace: string, htmlEventListener: string, modulePath: string, args: string[] | null = null, outputPlace: string | null = null): void {
        let argsJoin = "";
        if (args) {
            argsJoin = args.length > 0 ? GS + "[" + args.join(US) : "";
        }
        this._add("EJ" + inputPlace, htmlEventListener + GS + modulePath + GS + (outputPlace ? outputPlace : "") + argsJoin);
    }

    public setMasterPagesEvent(inputPlace: string, htmlEvent: string, outputPlace: string | null = null): void {
        this._add("Eu" + inputPlace, htmlEvent + GS + (outputPlace ? outputPlace : ""));
    }

    public setMasterPagesEventListener(inputPlace: string, htmlEventListener: string, outputPlace: string | null = null): void {
        this._add("EU" + inputPlace, htmlEventListener + GS + (outputPlace ? outputPlace : ""));
    }

    public setPreventDefaultEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Ed" + inputPlace, htmlEvent);
    }

    public setPreventDefaultEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("ED" + inputPlace, htmlEventListener);
    }

    public setStopPropagationEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Es" + inputPlace, htmlEvent);
    }

    public setStopPropagationEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("ES" + inputPlace, htmlEventListener);
    }

    public setMethodEvent(inputPlace: string, htmlEvent: string, methodName: string, args: string[] | null = null): void {
        let argsJoin = "";
        if (args) {
            argsJoin = args.length > 0 ? GS + "[" + args.join(US) : "";
        }
        this._add("Em" + inputPlace, htmlEvent + GS + methodName + argsJoin);
    }

    public setMethodEventListener(inputPlace: string, htmlEventListener: string, methodName: string, args: string[] | null = null): void {
        let argsJoin = "";
        if (args) {
            argsJoin = args.length > 0 ? GS + "[" + args.join(US) : "";
        }
        this._add("EM" + inputPlace, htmlEventListener + GS + methodName + argsJoin);
    }

    public setModuleMethodEvent(inputPlace: string, htmlEvent: string, methodName: string, args: string[] | null = null): void {
        let argsJoin = "";
        if (args) {
            argsJoin = args.length > 0 ? GS + "[" + args.join(US) : "";
        }
        this._add("Ex" + inputPlace, htmlEvent + GS + methodName + argsJoin);
    }

    public setModuleMethodEventListener(inputPlace: string, htmlEventListener: string, methodName: string, args: string[] | null = null): void {
        let argsJoin = "";
        if (args) {
            argsJoin = args.length > 0 ? GS + "[" + args.join(US) : "";
        }
        this._add("EX" + inputPlace, htmlEventListener + GS + methodName + argsJoin);
    }

    public assignConfirmEvent(inputPlace: string, htmlEvent: string, text: string = "Are you sure you want to proceed?", type_: string = "none", title: string = "Confirm", okText: string = "OK", cancelText: string = "Cancel", interval: i32 = 100): WebForms {
        const prefix = interval >= 0 ? "{(" + interval.toString() + ")" : "{";
        const textPart = text == "Are you sure you want to proceed?" ? "" : text;
        const typePart = type_ == "none" ? "" : type_;
        const titlePart = title == "Confirm" ? "" : title;
        const okPart = okText == "OK" ? "" : okText;
        const cancelPart = cancelText == "Cancel" ? "" : cancelText;
        this._add(prefix + "ct", textPart + GS + typePart + GS + titlePart + GS + okPart + GS + cancelPart);
        return this;
    }

    public removePostEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Rp" + inputPlace, htmlEvent);
    }

    public removePostEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RP" + inputPlace, htmlEventListener);
    }

    public removeGetEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Rg" + inputPlace, htmlEvent);
    }

    public removeGetEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RG" + inputPlace, htmlEventListener);
    }

    public removePutEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Rt" + inputPlace, htmlEvent);
    }

    public removePutEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RT" + inputPlace, htmlEventListener);
    }

    public removePatchEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Ra" + inputPlace, htmlEvent);
    }

    public removePatchEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RA" + inputPlace, htmlEventListener);
    }

    public removeDeleteEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Rl" + inputPlace, htmlEvent);
    }

    public removeDeleteEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RL" + inputPlace, htmlEventListener);
    }

    public removeOptionsEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Ro" + inputPlace, htmlEvent);
    }

    public removeOptionsEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RO" + inputPlace, htmlEventListener);
    }

    public removeHeadEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Rh" + inputPlace, htmlEvent);
    }

    public removeHeadEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RH" + inputPlace, htmlEventListener);
    }

    public removeSendEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Rn" + inputPlace, htmlEvent);
    }

    public removeSendEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RN" + inputPlace, htmlEventListener);
    }

    public removeCommentEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Rb" + inputPlace, htmlEvent);
    }

    public removeCommentEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RB" + inputPlace, htmlEventListener);
    }

    public removeWasmEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Ry" + inputPlace, htmlEvent);
    }

    public removeWasmEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RY" + inputPlace, htmlEventListener);
    }

    public removeWebSocketEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Rw" + inputPlace, htmlEvent);
    }

    public removeWebSocketEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RW" + inputPlace, htmlEventListener);
    }

    public removeSSEEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Re" + inputPlace, htmlEvent);
    }

    public removeSSEEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RE" + inputPlace, htmlEventListener);
    }

    public removeFrontEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Rj" + inputPlace, htmlEvent);
    }

    public removeFrontEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RJ" + inputPlace, htmlEventListener);
    }

    public removePreventDefaultEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Rd" + inputPlace, htmlEvent);
    }

    public removePreventDefaultEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RD" + inputPlace, htmlEventListener);
    }

    public removeMasterPagesEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Ru" + inputPlace, htmlEvent);
    }

    public removeMasterPagesEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RU" + inputPlace, htmlEventListener);
    }

    public removeStopPropagationEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Rs" + inputPlace, htmlEvent);
    }

    public removeStopPropagationEventListener(inputPlace: string, htmlEventListener: string): void {
        this._add("RS" + inputPlace, htmlEventListener);
    }

    public removeMethodEvent(inputPlace: string, htmlEvent: string, methodName: string): void {
        this._add("Rm" + inputPlace, htmlEvent + GS + methodName);
    }

    public removeMethodEventListener(inputPlace: string, htmlEventListener: string, methodName: string): void {
        this._add("RM" + inputPlace, htmlEventListener + GS + methodName);
    }

    public removeModuleMethodEvent(inputPlace: string, htmlEvent: string, methodName: string): void {
        this._add("Rx" + inputPlace, htmlEvent + GS + methodName);
    }

    public removeModuleMethodEventListener(inputPlace: string, htmlEventListener: string, methodName: string): void {
        this._add("RX" + inputPlace, htmlEventListener + GS + methodName);
    }

    public removeConfirmEvent(inputPlace: string, htmlEvent: string): void {
        this._add("Rf" + inputPlace, htmlEvent);
    }

	// Custom Event
	// This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
	// Watch: attribute, style, text, children, value
	// Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
	// Range: Only Use For Compare With inrange Value. Split By Comma ","
	// Key: Only Use For Watch With attribute And style Value
	public createCustomDOMEvent(inputPlace: string, eventName: string, watch: string, key: string, compare: string, value: string, range: string, immediate: boolean = false, delay: string = "0"): void {
		this._add("eC" + inputPlace, eventName + GS + watch + GS + key + GS + compare + GS + value + GS + range + GS + (immediate ? "1" : "0") + GS + delay);
	}

	public createCustomDOMEventWithDelayInt(inputPlace: string, eventName: string, watch: string, key: string, compare: string, value: string, range: string, immediate: boolean, delay: i32): void {
		this.createCustomDOMEvent(inputPlace, eventName, watch, key, compare, value, range, immediate, delay.toString());
	}

	public enableScrollBottomEvent(enable: boolean = true): void {
		this._add("eb", enable ? "1" : "0");
	}

	public enableReachedElementEvent(inputPlace: string, once: boolean, enable: boolean = true): void {
		this._add("er" + inputPlace, (once ? "1" : "0") + GS + (enable ? "1" : "0"));
	}
	
	// Module
	public loadModule(modulePath: string, methods: string[] | null = null): void {
		methods = methods || [];
		const methodsPart = methods.length > 0 ? GS + "[" + methods.join(US) : "";
		this._add("Ml", modulePath + methodsPart);
	}

	public unloadModule(modulePath: string): void {
		this._add("Mu", modulePath);
	}

	public deleteModuleMethod(methodName: string): void {
		this._add("Md", methodName);
	}
	
	// Unit Testing
	// InputPlace Using Only For form Element
	public assertEqual(inputPlace: string, tag: string): void {
		this._add("At" + inputPlace, tag.replace("\n", "$[ln];"));
	}

	public assertEqualByOutputPlace(inputPlace: string, outputPlace: string): void {
		this._add("Ao" + inputPlace, outputPlace);
	}
	
	// Debug
	public createDebugger(pause: boolean = false): void {
		this._add("Dc", pause ? "1" : "0");
	}
	
	// Service Worker
	// To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
	public serviceWorkerRegister(path: string | null = null, scopePath: string | null = null): void {
		this._add("wR", (path || "") + GS + (scopePath || ""));
	}

	public serviceWorkerPreCacheStatic(pathList: string[]): void {
		this._add("wp", pathList.join(GS));
	}

	public serviceWorkerDynamicCache(path: string, seconds: string = ""): void {
		this._add("wc", path + (seconds ? GS + seconds : ""));
	}

	public serviceWorkerDynamicCacheInt(path: string, seconds: i32): void {
		if (seconds > 0) {
			this.serviceWorkerDynamicCache(path, seconds.toString());
		} else {
			this.serviceWorkerDynamicCache(path, "");
		}
	}

	public serviceWorkerDeleteDynamicCache(): void {
		this._add("wd");
	}

	public serviceWorkerDeleteDynamicCacheWithPath(path: string): void {
		this._add("wd", path);
	}

	public serviceWorkerDynamicCacheTTLUpdate(path: string, seconds: string = ""): void {
		this._add("wt", path + (seconds ? GS + seconds : ""));
	}

	public serviceWorkerDynamicCacheTTLUpdateInt(path: string, seconds: i32): void {
		if (seconds > 0) {
			this.serviceWorkerDynamicCacheTTLUpdate(path, seconds.toString());
		} else {
			this.serviceWorkerDynamicCacheTTLUpdate(path, "");
		}
	}

	// Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
	// Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
	// CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
	public serviceWorkerRouteSet(path: string, type_: string, cacheDynamic: boolean = false): void {
		this._add("wr", path + GS + type_ + (cacheDynamic ? GS + "1" : ""));
	}

	public serviceWorkerRouteAlias(path: string, to: string): void {
		this._add("wa", path + GS + to);
	}

	public serviceWorkerDeleteRouteAlias(path: string | null = null): void {
		this._add("wC", path || "");
	}

	// Delete All Route And Alias
	public serviceWorkerDeleteRoute(): void {
		this._add("wD");
	}

	public serviceWorkerDeleteRouteWithPath(path: string): void {
		this._add("wD", path);
	}
	
	// SSE
	public disconnectSSE(path: string): void {
		this._add("Ds", path);
	}

	public disconnectAllSSE(): void {
		this._add("Ds");
	}
	
	// State
	public addState(path: string | null = null, title: string | null = null): void {
		this._add("AS", (path || "") + GS + (title || ""));
	}

	public saveState(path: string | null = null, title: string | null = null): void {
		this._add("As", (path || "") + GS + (title || ""));
	}

	public loadState(path: string): void {
		this._add("ls", path);
	}

	public deleteState(path: string | null = null): void {
		this._add("DS", path || "");
	}

	public deleteAllState(): void {
		this._add("DS", "*");
	}
	
	// Cookie
	public setCookie(key: string, value: string, seconds: string, path: string | null = null): void {
		this._add("sC", key + GS + value + GS + seconds + (path ? GS + path : ""));
	}

	public setCookieInt(key: string, value: string, seconds: i32, path: string | null = null): void {
		this.setCookie(key, value, seconds.toString(), path);
	}
	
	// Save (Session Cache)
	public saveId(inputPlace: string, key: string = "."): void {
		this._add("@gi" + inputPlace, key);
	}

	public saveName(inputPlace: string, key: string = "."): void {
		this._add("@gn" + inputPlace, key);
	}

	public saveValue(inputPlace: string, key: string = "."): void {
		this._add("@gv" + inputPlace, key);
	}

	public saveValueLength(inputPlace: string, key: string = "."): void {
		this._add("@ge" + inputPlace, key);
	}

	public saveClass(inputPlace: string, key: string = "."): void {
		this._add("@gc" + inputPlace, key);
	}

	public saveStyle(inputPlace: string, key: string = "."): void {
		this._add("@gs" + inputPlace, key);
	}

	public saveTitle(inputPlace: string, key: string = "."): void {
		this._add("@gl" + inputPlace, key);
	}

	public saveLabel(inputPlace: string, key: string = "."): void {
		this._add("@gA" + inputPlace, key);
	}

	public saveText(inputPlace: string, key: string = "."): void {
		this._add("@gt" + inputPlace, key);
	}

	public saveOuterText(inputPlace: string, key: string = "."): void {
		this._add("@go" + inputPlace, key);
	}

	public saveTextLength(inputPlace: string, key: string = "."): void {
		this._add("@gg" + inputPlace, key);
	}

	public saveAttribute(inputPlace: string, attribute: string, key: string = "."): void {
		this._add("@ga" + inputPlace, key + GS + attribute);
	}

	public saveWidth(inputPlace: string, key: string = "."): void {
		this._add("@gw" + inputPlace, key);
	}

	public saveHeight(inputPlace: string, key: string = "."): void {
		this._add("@gh" + inputPlace, key);
	}

	public saveReadOnly(inputPlace: string, key: string = "."): void {
		this._add("@gr" + inputPlace, key);
	}

	public saveSelectedIndex(inputPlace: string, key: string = "."): void {
		this._add("@gx" + inputPlace, key);
	}

	public saveTextAlign(inputPlace: string, key: string = "."): void {
		this._add("@gT" + inputPlace, key);
	}

	public saveNodeLength(inputPlace: string, key: string = "."): void {
		this._add("@gL" + inputPlace, key);
	}

	public saveVisible(inputPlace: string, key: string = "."): void {
		this._add("@gV" + inputPlace, key);
	}

	public saveUrl(url: string, fetchScript: boolean = false, key: string = "."): void {
		this._add("@gu", key + GS + url + (fetchScript ? GS + "1" : ""));
	}

	public saveIndex(inputPlace: string, key: string = "."): void {
		this._add("@gI" + inputPlace, key);
	}

	public removeSave(cacheKey: string): void {
		this._add("rs", cacheKey);
	}

	public removeAllSave(): void {
		this._add("rs", "*");
	}

	// Calling the SetSave Method Causes Action Control Requests Triggered by Events Using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send Event, to be Temporarily Saved on the Active Page, so the Request will not be Sent to the Server Again.
	public setSave(): void {
		this._add("cs", "*");
	}

	public addSaveValue(cacheKey: string, value: string): void {
		this._add("SA", cacheKey + GS + value.replace("\n", "$[ln];"));
	}

	public insertSaveValue(cacheKey: string, value: string): void {
		this._add("SI", cacheKey + GS + value.replace("\n", "$[ln];"));
	}

	public appendSaveValue(cacheKey: string, value: string): void {
		this._add("SP", cacheKey + GS + value.replace("\n", "$[ln];"));
	}

	public replaceSaveValue(cacheKey: string, searchValue: string, value: string): void {
		this._add("SR", cacheKey + GS + value.replace("\n", "$[ln];") + GS + searchValue.replace("\n", "$[ln];"));
	}
	
	// Cache
	public cacheId(inputPlace: string, key: string = "."): void {
		this._add("@ci" + inputPlace, key);
	}

	public cacheName(inputPlace: string, key: string = "."): void {
		this._add("@cn" + inputPlace, key);
	}

	public cacheValue(inputPlace: string, key: string = "."): void {
		this._add("@cv" + inputPlace, key);
	}

	public cacheValueLength(inputPlace: string, key: string = "."): void {
		this._add("@ce" + inputPlace, key);
	}

	public cacheClass(inputPlace: string, key: string = "."): void {
		this._add("@cc" + inputPlace, key);
	}

	public cacheStyle(inputPlace: string, key: string = "."): void {
		this._add("@cs" + inputPlace, key);
	}

	public cacheTitle(inputPlace: string, key: string = "."): void {
		this._add("@cl" + inputPlace, key);
	}

	public cacheLabel(inputPlace: string, key: string = "."): void {
		this._add("@cA" + inputPlace, key);
	}

	public cacheText(inputPlace: string, key: string = "."): void {
		this._add("@ct" + inputPlace, key);
	}

	public cacheOuterText(inputPlace: string, key: string = "."): void {
		this._add("@co" + inputPlace, key);
	}

	public cacheTextLength(inputPlace: string, key: string = "."): void {
		this._add("@cg" + inputPlace, key);
	}

	public cacheAttribute(inputPlace: string, attribute: string, key: string = "."): void {
		this._add("@ca" + inputPlace, key + GS + attribute);
	}

	public cacheWidth(inputPlace: string, key: string = "."): void {
		this._add("@cw" + inputPlace, key);
	}

	public cacheHeight(inputPlace: string, key: string = "."): void {
		this._add("@ch" + inputPlace, key);
	}

	public cacheReadOnly(inputPlace: string, key: string = "."): void {
		this._add("@cr" + inputPlace, key);
	}

	public cacheSelectedIndex(inputPlace: string, key: string = "."): void {
		this._add("@cx" + inputPlace, key);
	}

	public cacheTextAlign(inputPlace: string, key: string = "."): void {
		this._add("@cT" + inputPlace, key);
	}

	public cacheNodeLength(inputPlace: string, key: string = "."): void {
		this._add("@cL" + inputPlace, key);
	}

	public cacheVisible(inputPlace: string, key: string = "."): void {
		this._add("@cV" + inputPlace, key);
	}

	public cacheUrl(url: string, fetchScript: boolean = false, key: string = "."): void {
		this._add("@cu", key + GS + url + (fetchScript ? GS + "1" : ""));
	}

	public cacheIndex(inputPlace: string, key: string = "."): void {
		this._add("@cI" + inputPlace, key);
	}

	public removeCache(cacheKey: string): void {
		this._add("rd", cacheKey);
	}

	public removeAllCache(): void {
		this._add("rd", "*");
	}

	// Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
	public setCache(second: string): void {
		this._add("cd", second);
	}

	public setCacheInt(second: i32): void {
		this.setCache(second.toString());
	}

	public setCacheAll(): void {
		this.setCache("*");
	}

	public addCacheValue(cacheKey: string, value: string): void {
		this._add("CA", cacheKey + GS + value.replace("\n", "$[ln];"));
	}

	public insertCacheValue(cacheKey: string, value: string): void {
		this._add("CI", cacheKey + GS + value.replace("\n", "$[ln];"));
	}

	public appendCacheValue(cacheKey: string, value: string): void {
		this._add("CP", cacheKey + GS + value.replace("\n", "$[ln];"));
	}

	public replaceCacheValue(cacheKey: string, searchValue: string, value: string): void {
		this._add("CR", cacheKey + GS + value.replace("\n", "$[ln];") + GS + searchValue.replace("\n", "$[ln];"));
	}
	
	// Call
	public loadUrl(inputPlace: string, url: string): void {
		this._add("lu" + inputPlace, url);
	}

	public runActionControls(actionControls: string, withoutWebFormsSection: boolean = true, index: string | null = null, useCurrentEvent: boolean = true): void {
		this._add("lA", (useCurrentEvent ? "1" : "0") + GS + (withoutWebFormsSection ? "1" : "0") + GS + (index || "") + GS + actionControls);
	}

	public callScript(scriptText: string): void {
		this._add("_", scriptText.replace(/\n/g, "$[ln];"));
	}
	
	public callMethod(methodName: string, args: string[] | null = null): void {
		let argsJoin = "";
		if (args && args.length > 0) {
			argsJoin = GS + "[" + args.join(US);
		}
		this._add("lm", methodName + argsJoin);
	}

	public callModuleMethod(methodName: string, args: string[] | null = null): void {
		let argsJoin = "";
		if (args && args.length > 0) {
			argsJoin = GS + "[" + args.join(US);
		}
		this._add("lM", methodName + argsJoin);
	}
	
	public callPostBack(formInputPlace: string, outputPlace: string | null = null): void {
		const outputPart = outputPlace ? GS + outputPlace : "";
		this._add("Lp", "1" + GS + formInputPlace + outputPart);
	}

	public callCommentBack(index: string | null = null, inputPlace: string | null = null, useCurrentEvent: boolean = true): void {
		const indexStr = index || "";
		const inputStr = inputPlace || "";
		this._add("LC", (useCurrentEvent ? "1" : "0") + GS + indexStr + GS + inputStr);
	}

	public callCommentBackInt(index: i32, inputPlace: string | null = null, useCurrentEvent: boolean = true): void {
		this.callCommentBack(index.toString(), inputPlace, useCurrentEvent);
	}
	
	public callWasmBack(wasmLanguage: string, wasmUrl: string, methodName: string, args: string[] | null = null, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
		let argsJoin = "";
		if (args && args.length > 0) {
			argsJoin = "[" + args.join(US);
		}
		this._add("Ly", (useCurrentEvent ? "1" : "0") + GS + wasmLanguage + GS + wasmUrl + GS + methodName + GS + argsJoin + GS + (outputPlace || ""));
	}
	
	public callWebSocketBack(path: string, useCurrentEvent: boolean = true): void {
		this._add("Lw", (useCurrentEvent ? "1" : "0") + GS + path);
	}

	public callSSEBack(path: string, outputPlace: string | null = null, useCurrentEvent: boolean = true, shouldReconnect: boolean = true, reconnectTryTimeout: string = "3000"): void {
		const outputPart = outputPlace ? GS + outputPlace : "";
		this._add("Ls", (useCurrentEvent ? "1" : "0") + GS + path + GS + (shouldReconnect ? "1" : "0") + GS + reconnectTryTimeout + outputPart);
	}

	public callSSEBackWithInt(path: string, outputPlace: string, useCurrentEvent: boolean, shouldReconnect: boolean, reconnectTryTimeout: i32): void {
		this.callSSEBack(path, outputPlace, useCurrentEvent, shouldReconnect, reconnectTryTimeout.toString());
	}

	public callFront(modulePath: string, args: string[] | null = null, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
		let argsJoin = "";
		if (args && args.length > 0) {
			argsJoin = GS + "[" + args.join(US);
		}
		this._add("Lj", (useCurrentEvent ? "1" : "0") + GS + modulePath + GS + (outputPlace || "") + argsJoin);
	}

	public callGetBack(path: string, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
		const outputPart = outputPlace ? GS + outputPlace : "";
		this._add("Lg", (useCurrentEvent ? "1" : "0") + GS + path + outputPart);
	}

	public callPutBack(path: string, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
		const outputPart = outputPlace ? GS + outputPlace : "";
		this._add("Lt", (useCurrentEvent ? "1" : "0") + GS + path + outputPart);
	}

	public callPatchBack(path: string, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
		const outputPart = outputPlace ? GS + outputPlace : "";
		this._add("LP", (useCurrentEvent ? "1" : "0") + GS + path + outputPart);
	}

	public callDeleteBack(path: string, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
		const outputPart = outputPlace ? GS + outputPlace : "";
		this._add("Ld", (useCurrentEvent ? "1" : "0") + GS + path + outputPart);
	}

	public callHeadBack(path: string, useCurrentEvent: boolean = true): void {
		this._add("Lh", (useCurrentEvent ? "1" : "0") + GS + path);
	}

	public callOptionsBack(path: string, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
		const outputPart = outputPlace ? GS + outputPlace : "";
		this._add("Lo", (useCurrentEvent ? "1" : "0") + GS + path + outputPart);
	}

	public callSendBack(path: string, method: string, isMultiPart: boolean, contentType: string, data: string, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
		const outputPart = outputPlace ? GS + outputPlace : "";
		this._add("LS", (useCurrentEvent ? "1" : "0") + GS + path + GS + method + GS + (isMultiPart ? "1" : "0") + GS + contentType + GS + data.replace(/\n/g, "$[ln];") + outputPart);
	}

	// Update
	public increase(inputPlace: string, value: f32): void {
		this._add("gt" + inputPlace, "i" + GS + value.toString());
	}

	public decrease(inputPlace: string, value: f32): void {
		this.increase(inputPlace, -value);
	}

	// If You Don't Use Deep Mode, any Tags Inside the Current Tag Will Simply Be Treated as Strings. Deep Mode Does not Remove Inner Elements.
	public replace(inputPlace: string, value: string, newValue: string, alsoStartTag: boolean = false, deep: boolean = true): void {
		this._add("gt" + inputPlace, "r" + GS + value + GS + newValue + GS + (alsoStartTag ? "1" : "0") + GS + (deep ? "1" : "0"));
	}

	// HTML Converts Attribute Names to Lowercase, so they Need to Be Written in Lowercase.
	public replaceStartTag(inputPlace: string, value: string, newValue: string): void {
		this._add("gt" + inputPlace, "s" + GS + value + GS + newValue);
	}

	// Pre Runner
	public assignDelay(miliSecond: i32, index: i32 = -1): void {
		const currentLine = this._getLineByIndex(index);
		if (!currentLine || currentLine.length == 0) return;

		const parts = currentLine.split("=", 2);
		const newName = ":" + miliSecond.toString() + ")" + (parts.length > 0 ? parts[0] : "");
		const newValue = parts.length > 1 ? parts[1] : "";

		this._updateLineByIndex(index, newName, newValue);
	}

	public assignDelayChange(miliSecond: i32, index: i32 = -1): void {
		const currentLine = this._getLineByIndex(index);
		if (!currentLine || currentLine.length == 0) return;

		const parts = currentLine.split("=", 2);
		let currentName = parts[0];

		if (currentName.startsWith(":") && currentName.includes(")")) {
			const closingBracket = currentName.indexOf(")");
			currentName = currentName.substring(closingBracket + 1);
		}

		const newName = ":" + miliSecond.toString() + ")" + currentName;
		const newValue = parts.length > 1 ? parts[1] : "";

		this._updateLineByIndex(index, newName, newValue);
	}

	public assignInterval(miliSecond: i32, id: string | null = null, index: i32 = -1): void {
		const currentLine = this._getLineByIndex(index);
		if (!currentLine || currentLine.length == 0) return;

		const parts = currentLine.split("=", 2);
		const idPart = id ? "|" + id : "";
		const newName = "(" + miliSecond.toString() + idPart + ")" + (parts.length > 0 ? parts[0] : "");
		const newValue = parts.length > 1 ? parts[1] : "";

		this._updateLineByIndex(index, newName, newValue);
	}

	public assignIntervalChange(miliSecond: i32, id: string | null = null, index: i32 = -1): void {
		const currentLine = this._getLineByIndex(index);
		if (!currentLine || currentLine.length == 0) return;

		const parts = currentLine.split("=", 2);
		let currentName = parts[0];

		if (currentName.startsWith("(") && currentName.includes(")")) {
			const closingBracket = currentName.indexOf(")");
			currentName = currentName.substring(closingBracket + 1);
		}

		const idPart = id ? "|" + id : "";
		const newName = "(" + miliSecond.toString() + idPart + ")" + currentName;
		const newValue = parts.length > 1 ? parts[1] : "";

		this._updateLineByIndex(index, newName, newValue);
	}

	public deleteInterval(id: string): void {
		this._add("Di", id);
	}

	public assignRepeat(count: i32, index: i32 = -1): void {
		const currentLine = this._getLineByIndex(index);
		if (!currentLine || currentLine.length == 0) return;

		const parts = currentLine.split("=", 2);
		const newName = "," + count.toString() + ")" + (parts.length > 0 ? parts[0] : "");
		const newValue = parts.length > 1 ? parts[1] : "";

		this._updateLineByIndex(index, newName, newValue);
	}

	public assignRepeatChange(count: i32, index: i32 = -1): void {
		const currentLine = this._getLineByIndex(index);
		if (!currentLine || currentLine.length == 0) return;

		const parts = currentLine.split("=", 2);
		let currentName = parts[0];

		if (currentName.startsWith(",") && currentName.includes(")")) {
			const closingBracket = currentName.indexOf(")");
			currentName = currentName.substring(closingBracket + 1);
		}

		const newName = "," + count.toString() + ")" + currentName;
		const newValue = parts.length > 1 ? parts[1] : "";

		this._updateLineByIndex(index, newName, newValue);
	}

	// Index
	public startIndex(name: string = ""): void {
		this._add("#", name);
	}

	// This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
	public startState(): void {
		this.startIndex("$");
	}

	public goTo(line: string, repeat: string): void {
		this._add("&", line + GS + repeat);
	}

	public goToI32(line: i32, repeat: i32): void {
		this.goTo(line.toString(), repeat.toString());
	}

	public goToWithIndex(index: string, repeat: i32): void {
		this.goTo(index, repeat.toString());
	}

	// Start
	public startTransientDOM(inputPlace: string): void {
		this._add("td", inputPlace);
	}

	public endTransientDOM(): void {
		this._add("td", ";");
	}

	// Message
	// Type: warning, problem, help, success, none
	public alert(text: string, type_: string = "none", title: string = "Alert", okText: string = "OK"): void {
		this._add("Al", text + GS + (type_ == "none" ? "" : type_) + GS + (title == "Alert" ? "" : title) + GS + (okText == "OK" ? "" : okText));
	}

	public message(text: string, typeOrDuration: string | null = null, duration: string | null = null): void {
		if (typeOrDuration != null && !isNaN(parseInt(typeOrDuration))) {
			this._add("me", text + GS + "" + GS + typeOrDuration);
		} else {
			const typeStr = typeOrDuration != null ? typeOrDuration : "none";
			const durationStr = duration != null ? duration : "0";
			this._add("me", text + GS + (typeStr == "none" ? "" : typeStr) + GS + (durationStr == "0" ? "" : durationStr));
		}
	}

	public messageWithDuration(text: string, duration: i32): void {
		this.message(text, null, duration.toString());
	}

	// Type: log, info, warn, error, debug, trace, group, groupend, table
	public consoleMessage(text: string, type_: string = "log"): void {
		this._add("mc", text.replace(/\n/g, "$[ln];") + (type_ == "log" ? "" : GS + type_));
	}

	public consoleMessageAssert(text: string, condition: string): void {
		this._add("ma", text.replace(/\n/g, "$[ln];") + GS + condition);
	}

	// Enable
	// Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
	public enableWebSocket(enable: boolean = true): void {
		this._add("ew", enable ? "1" : "0");
	}

	public enableWebSocketOnce(): void {
		this._add("ew", "$");
	}

	public addWebSocket(path: string): void {
		this._add("aw" + path);
	}

	// Disconnected WebSocket
	public deleteWebSocket(path: string): void {
		this._add("dw" + path);
	}

	// Use
	// InputPlace Using Only For form Element
	public useWebSocket(inputPlace: string): void {
		this._add("uw" + inputPlace);
	}

	public useOnlyChangeUpdate(inputPlace: string): void {
		this._add("uo" + inputPlace);
	}
	
	// Condition And Loop
	// Condition And Loop Supports Brackets and Then
	// Type: warning, problem, help, success, none
	// Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
	// Nested Conditions and Nested Loops are Possible.

	public confirmIsTrueAccept(
		inputPlace: string,
		eventName: string,
		text: string = "Are you sure you want to proceed?",
		type_: string = "none",
		title: string = "Confirm",
		okText: string = "OK",
		cancelText: string = "Cancel",
		interval: i32 = 100
	): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		const textPart = text == "Are you sure you want to proceed?" ? "" : text;
		const typePart = type_ == "none" ? "" : type_;
		const titlePart = title == "Confirm" ? "" : title;
		const okPart = okText == "OK" ? "" : okText;
		const cancelPart = cancelText == "Cancel" ? "" : cancelText;

		this._add(prefix + "ct", textPart + GS + typePart + GS + titlePart + GS + okPart + GS + cancelPart);
		return this;
	}

	public confirmIsFalseAccept(
		inputPlace: string,
		eventName: string,
		text: string = "Are you sure you want to proceed?",
		type_: string = "none",
		title: string = "Confirm",
		okText: string = "OK",
		cancelText: string = "Cancel",
		interval: i32 = 100
	): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		const textPart = text == "Are you sure you want to proceed?" ? "" : text;
		const typePart = type_ == "none" ? "" : type_;
		const titlePart = title == "Confirm" ? "" : title;
		const okPart = okText == "OK" ? "" : okText;
		const cancelPart = cancelText == "Cancel" ? "" : cancelText;

		this._add(prefix + "cf", textPart + GS + typePart + GS + titlePart + GS + okPart + GS + cancelPart);
		return this;
	}

	public isGreaterThan(firstValue: string, secondValue: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "gt", firstValue + GS + secondValue);
		return this;
	}

	public isLessThan(firstValue: string, secondValue: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "lt", firstValue + GS + secondValue);
		return this;
	}

	public isEqualTo(firstValue: string, secondValue: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "et", firstValue + GS + secondValue);
		return this;
	}

	public isNotEqualTo(firstValue: string, secondValue: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "Nt", firstValue + GS + secondValue);
		return this;
	}

	public exist(value: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "ex", value);
		return this;
	}

	public notExist(value: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "nx", value);
		return this;
	}

	public isTrue(value: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "tr", value);
		return this;
	}

	public isFalse(value: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "fa", value);
		return this;
	}

	public isMatchMedia(value: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "mm", value);
		return this;
	}

	public isNotMatchMedia(value: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "nm", value);
		return this;
	}

	public include(text: string, value: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "In", value + GS + text);
		return this;
	}

	public notInclude(text: string, value: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "Nn", value + GS + text);
		return this;
	}

	public elementExists(inputPlace: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "eE", inputPlace);
		return this;
	}

	public elementNotExists(inputPlace: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "nE", inputPlace);
		return this;
	}

	public isRegexMatch(value: string, pattern: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "re", value + GS + pattern);
		return this;
	}

	public isRegexNotMatch(value: string, pattern: string, interval: i32 = -1): WebForms {
		const prefix = interval >= 0 ? `{(${interval})` : "{";
		this._add(prefix + "rn", value + GS + pattern);
		return this;
	}

	// In: Everything Becomes A JSON List.
	// Key: Creates A Temporary Data In The Browser IndexedDB.
	// Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
	public forEach(path: string, input: string, key: string = "."): WebForms {
		this._add("{fe", path + GS + input + GS + key);
		return this;
	}

	public break(): void {
		this._add(";");
	}

	public else(): WebForms {
		this._add("}e");
		return this;
	}

	public startBracket(): void {
		this._add("{");
	}

	public endBracket(): void {
		this._add("}");
	}

	// Used Then In Condition And Loop Methods
	public then(newForm: WebForms): WebForms {
		const data = newForm.getWebFormsData();
		if (data.length > 0 && data.includes("\n")) {
			newForm._addToUp("{");
			newForm._add("}");
		}
		this.appendForm(newForm);
		return this;
	}

	public repeat(newForm: WebForms, repeat: i32): WebForms {
		if (newForm == null) return this;
		const bodyData = newForm.getWebFormsData();
		if (bodyData.length == 0) return this;

		const startLine = -bodyData.split("\n").length;
		this.appendForm(newForm);
		this.goTo(startLine.toString(), (repeat - 1).toString());
		return this;
	}

	public repeatWithIndex(newForm: WebForms, repeat: i32, index: string): WebForms {
		if (newForm == null) return this;

		this.goTo(index, null);
		this.startIndex(index);

		const bodyData = newForm.getWebFormsData();
		if (bodyData.length == 0) return this;

		this.appendForm(newForm);

		if (index.length == 0) {
			let indexNumber = -1;
			for (let line of this.getWebFormsData().split("\n")) {
				if (line.startsWith("#")) indexNumber++;
			}
			this.goTo(indexNumber.toString(), (repeat - 1).toString());
		} else {
			this.goTo(index, (repeat - 1).toString());
		}

		return this;
	}
	
	// Async
	// It Supports Brackets and Then
	public async(): WebForms {
		this._add("{(a)");
		return this;
	}

	public delay(miliSecond: string): void {
		this._add("De", miliSecond);
	}

	public delayInt(miliSecond: i32): void {
		this.delay(miliSecond.toString());
	}

	// Option
	public changeOption(name: string, value: string): void {
		this._add("co", name + GS + value);
	}

	public resetOption(): void {
		this._add("ro");
	}

	public resetOptionName(name: string): void {
		this._add("ro", name);
	}
	
	// Format Storage
	public createFormatStorage(key: string, data: string): void {
		this._add(".C", key + GS + data);
	}

	public deleteFormatStorage(key: string): void {
		this._add(".D", key);
	}

	public addJSON(key: string, path: string, value: string): void {
		this._add(".a", key + GS + "j" + GS + value + GS + path);
	}

	// Name: For Support Attribute, Set Double At Sign (@@) Before Name.
	public addXML(key: string, path: string, name: string, value: string | null = null): void {
		const valueStr = value !== null ? value : "";
		this._add(".a", key + GS + "x" + GS + name + GS + valueStr + GS + path);
	}

	public addINI(key: string, path: string, value: string, isINILike: boolean = false): void {
		this._add(".a", key + GS + "i" + GS + (isINILike ? "1" : "0") + GS + value + GS + path);
	}

	public addTextLine(key: string, line: string, text: string): void {
		this._add(".a", key + GS + "t" + GS + text + GS + line);
	}

	public addTextLineInt(key: string, line: i32, text: string): void {
		this.addTextLine(key, line.toString(), text);
	}

	public addVariable(key: string, value: string): void {
		this._add(".a", key + GS + "v" + GS + value);
	}

	public updateJSON(key: string, path: string, value: string): void {
		this._add(".u", key + GS + "j" + GS + value + GS + path);
	}

	public updateXML(key: string, path: string, value: string): void {
		this._add(".u", key + GS + "x" + GS + value + GS + path);
	}

	public updateINI(key: string, path: string, value: string, isINILike: boolean = false): void {
		this._add(".u", key + GS + "i" + GS + (isINILike ? "1" : "0") + GS + value + GS + path);
	}

	public updateTextLine(key: string, line: string, text: string): void {
		this._add(".u", key + GS + "t" + GS + text + GS + line);
	}

	public updateTextLineInt(key: string, line: i32, text: string): void {
		this.updateTextLine(key, line.toString(), text);
	}

	public updateVariable(key: string, value: string): void {
		this._add(".u", key + GS + "v" + GS + value);
	}

	public increaseVariable(key: string, value: string): void {
		this._add(".i", key + GS + "v" + GS + value);
	}

	public increaseVariableInt(key: string, value: i32): void {
		this.increaseVariable(key, value.toString());
	}

	public decreaseVariable(key: string, value: i32): void {
		this.increaseVariableInt(key, -value);
	}

	public deleteJSON(key: string, path: string): void {
		this._add(".d", key + GS + "j" + GS + path);
	}

	public deleteXML(key: string, path: string): void {
		this._add(".d", key + GS + "x" + GS + path);
	}

	public deleteINI(key: string, path: string, isINILike: boolean = false): void {
		this._add(".d", key + GS + "i" + GS + (isINILike ? "1" : "0") + GS + path);
	}

	public deleteTextLine(key: string, line: string): void {
		this._add(".d", key + GS + "t" + GS + line);
	}

	public deleteTextLineInt(key: string, line: i32): void {
		this.deleteTextLine(key, line.toString());
	}

	public deleteVariable(key: string): void {
		this._add(".d", key + GS + "v");
	}
	
	// Template Engine
	// Pattern Example: {{value}}, ((value)), *value*, $value;
	public bindJSONToTemplate(inputPlace: string, JSONText: string, path: string, pattern: string, alsoStartTag: boolean = true): void {
		this._add("Tj" + inputPlace, JSONText + GS + path + GS + pattern + GS + (alsoStartTag ? "1" : "0"));
	}
	
	// Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
	public bindXMLToTemplate(inputPlace: string, XMLText: string, path: string, pattern: string, alsoStartTag: boolean = true): void {
		this._add("Tx" + inputPlace, XMLText + GS + path + GS + pattern + GS + (alsoStartTag ? "1" : "0"));
	}

	public bindINIToTemplate(inputPlace: string, INIText: string, path: string, pattern: string, alsoStartTag: boolean = true): void {
		this._add("Ti" + inputPlace, INIText + GS + path + GS + pattern + GS + (alsoStartTag ? "1" : "0"));
	}
	
	// Inject
	// Need Add @: to First of String
	public inject(value: string): string {
		return "$[" + value + "];";
	}

	// Action Control
	public replaceActionControl(searchValue: string, value: string, addToUp: boolean = false): void {
		if (addToUp) {
			this._addToUp("rE", searchValue + GS + value);
		} else {
			this._add("rE", searchValue + GS + value);
		}
	}

	public assignReplace(searchValue: string, value: string, index: i32 = -1): void {
		const currentLine = this._getLineByIndex(index);
		if (!currentLine || currentLine.length == 0) return;

		const parts = currentLine.split("=", 2);
		const newName = ";" + searchValue + GS + value + GS + parts[0];
		const newValue = parts.length > 1 ? parts[1] : "";

		this._updateLineByIndex(index, newName, newValue);
	}

	// Hash And Checksum
	public setHash(): void {
		this._add("SH");
	}

	public setChecksum(): void {
		this._add("CS");
	}

	public checksumCalculation(text: string): string {
		let sum = 0;
		const mod = 65536;
		const shift = 5;

		for (let i = 0; i < text.length; i++) {
			const c = text.charCodeAt(i);
			sum = ((sum << shift) | (sum >> (16 - shift))) ^ c;
			sum %= mod;
		}

		return sum.toString();
	}

	public getChecksum(): string {
		return this.checksumCalculation(this.getWebFormsData());
	}

	// Get
	public getFormsActionData(): string {
		return this.webFormsData;
	}

	public response(): string {
		return "[web-forms]\n" + this.getFormsActionData();
	}

	public getFormsActionDataLineBreak(): string {
		if (this.webFormsData.length == 0) return "";
		let data = this.webFormsData;
		return data.replace(/\n/g, "$[sln];");
	}

	// Export
	public exportToHtmlComment(addLine: boolean = false): string {
		let response = this.response();
		response = response.replace(/--/g, "$[dd];");
		if (response.endsWith("-")) {
			response = response.substring(0, response.length - 1) + "$[da];";
		}

		return (addLine ? "\n" : "") + "<!--" + response + "-->";
	}

	// Using it for SSE Response
	public exportToLineBreak(): string {
		return "[web-forms]$[sln];" + this.getFormsActionDataLineBreak();
	}

	public getWebFormsData(): string {
		return this.webFormsData;
	}

	public appendForm(form: WebForms): void {
		if (form == null) return;
		const otherData = form.getWebFormsData();
		if (otherData.length > 0) {
			if (this.webFormsData.length > 0) this.webFormsData += "\n";
			this.webFormsData += otherData;
		}
	}

	public clean(): void {
		this.webFormsData = "";
	}
}

export class Security {
  public safeValue(value: string): string {
    if (value.length == 0) return value;
    if (value.charAt(0) == '@') value = "@" + value;

    value = value.replace(/\n/g, "$[ln];");
    value = value.replace(/,@/g, "$[co];@");
    value = value.replace(/\x1c/g, "\0");
    value = value.replace(/\x1d/g, "\0");
    value = value.replace(/\x1e/g, "\0");
    value = value.replace(/\x1f/g, "\0");

    return value;
  }
}

// WebForms Place Criteria (WPC) DSL
export class InputPlace {
  public static Document: string = ",";
  public static Window: string = "`";
  // When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
  public static Root: string = "~";
  public static HTML: string = ".";
  public static Head: string = "^";
  public static ScreenOrientation: string = "%";
  public static All: string = "*";
  public static Parent: string = "/";
  public static Current: string = "$";
  public static Target: string = "!";
  public static Upper: string = "-";

  public static id(id: string): string {
    return id;
  }

  public static name(name: string): string {
    return "(" + name + ")";
  }

  public static nameWithIndex(name: string, index: i32): string {
    return "(" + name + ")" + index.toString();
  }

  public static allNames(name: string): string {
    return "(" + name + ")*";
  }

  public static tag(tag: string): string {
    return "<" + tag + ">";
  }

  public static tagWithIndex(tag: string, index: i32): string {
    return "<" + tag + ">" + index.toString();
  }

  public static allTags(tag: string): string {
    return "<" + tag + ">*";
  }

  public static child(): string {
    return "<>";
  }

  public static childWithIndex(index: i32): string {
    return "<>" + index.toString();
  }

  public static allChild(): string {
    return "<>*";
  }

  public static className(className: string): string {
    return "{" + className + "}";
  }

  public static classNameWithIndex(className: string, index: i32): string {
    return "{" + className + "}" + index.toString();
  }

  public static allClasses(className: string): string {
    return "{" + className + "}*";
  }

  public static attribute(name: string): string {
    return "\"" + name + "\"";
  }

  public static attributeWithIndex(name: string, index: i32): string {
    return "\"" + name + "\"" + index.toString();
  }

  public static allAttributes(name: string): string {
    return "\"" + name + "\"*";
  }

  // Operator: '^', '$', '*', '~'
  public static attributeWithKey(name: string, value: string, op: string = ""): string {
    return "\"" + name + (op.length > 0 ? op : "") + "'" + value + "\"";
  }

  public static attributeWithKeyAndIndex(name: string, value: string, index: i32, op: string = ""): string {
    return "\"" + name + (op.length > 0 ? op : "") + "'" + value + "\"" + index.toString();
  }

  public static allAttributesWithKey(name: string, value: string, op: string = ""): string {
    return "\"" + name + (op.length > 0 ? op : "") + "'" + value + "\"*";
  }
 
  public static query(query: string): string {
    return "*" + query.replace("=", "$[eq];").replace("|", "$[vb];").replace("?", "$[qu];");
  }

  public static queryAll(query: string): string {
    return "[" + query.replace("=", "$[eq];").replace("|", "$[vb];").replace("?", "$[qu];");
  }
}

export class OutputPlace extends InputPlace {
}

// Do not Add any Data Before or After it
export class Fetch {
  // Method
  public static random(maxValue: i32): string {
    return "@mr" + maxValue.toString();
  }

  public static randomWithMin(minValue: i32, maxValue: i32): string {
    return "@mr" + maxValue.toString() + RS + minValue.toString();
  }

  public static spaceToChar(text: string, character: string = "-"): string {
    return "@sc" + character + RS + text;
  }

  public static encodeURI(text: string): string {
    return "@ue" + text;
  }

  public static decodeURI(text: string): string {
    return "@ud" + text;
  }

  public static method(methodName: string, args: string[] = []): string {
    return "@cm" + methodName + (args.length > 0 ? RS + "[" + args.join(US) : "");
  }

  public static moduleMethod(methodName: string, args: string[] = []): string {
    return "@cM" + methodName + (args.length > 0 ? RS + "[" + args.join(US) : "");
  }

  // MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
  public static wasmMethod(
    wasmLanguage: string,
    wasmUrl: string,
    methodName: string,
    args: string[] = [],
    key: string = "."
  ): string {
    return "@wA" + wasmLanguage + RS + wasmUrl + RS + methodName + (args.length > 0 ? RS + "[" + args.join(US) : "");
  }

  public static script(scriptText: string): string {
    return "@_" + scriptText.replace(/\n/g, "$[ln];");
  }

  public static loadUrl(url: string, fetchScript: bool = false): string {
    return "@lu" + url + (fetchScript ? RS + "1" : "");
  }

  public static loadHtml(url: string, fetchInputPlace: string = "", fetchScript: bool = false): string {
    return "@lh" + url + RS + (fetchScript ? "1" : "0") + (fetchInputPlace.length > 0 ? RS + fetchInputPlace : "");
  }

  public static loadLine(url: string, line: i32): string {
    return "@ll" + url + RS + line.toString();
  }

  public static loadINI(url: string, name: string, isINILike: bool = false): string {
    return "@li" + url + RS + name + (isINILike ? RS + "1" : "");
  }

  // Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
  public static loadJSON(url: string, name: string): string {
    return "@lj" + url + RS + name;
  }

  // Name: Name Or XPath; XPath Index Starts At 1
  public static loadXML(url: string, name: string): string {
    return "@lx" + url + RS + name;
  }

  // MethodName: It's Check Function Or Variable
  public static hasMethod(methodName: string): string {
    return "@hm" + methodName;
  }

  public static hasModuleMethod(methodName: string): string {
    return "@hM" + methodName;
  }

  // This Method Return True Or False If Key Pressed
  // Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
  public static getModifierState(modifier: string): string {
    return "@ms" + modifier;
  }

  // Data
  public static DateYear: string = "@dy";
  public static DateMonth: string = "@dm"; // Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1 
  public static DateDay: string = "@dd";
  public static DateDate: string = "@dD";
  public static DateHours: string = "@dh";
  public static DateMinutes: string = "@di";
  public static DateSeconds: string = "@ds";
  public static DateMilliseconds: string = "@dl";

  // String
  public static Space: string = "@sp";
  public static AtSign: string = "@sa";

  // Tag
  public static getId(inputPlace: string): string {
    return "@$i" + inputPlace;
  }

  public static getName(inputPlace: string): string {
    return "@$n" + inputPlace;
  }

  public static getValue(inputPlace: string): string {
    return "@$v" + inputPlace;
  }

  public static getValueLength(inputPlace: string): string {
    return "@$e" + inputPlace;
  }

  public static getClass(inputPlace: string): string {
    return "@$c" + inputPlace;
  }

  public static getStyle(inputPlace: string): string {
    return "@$s" + inputPlace;
  }

  public static getTitle(inputPlace: string): string {
    return "@$l" + inputPlace;
  }

  public static getLabel(inputPlace: string): string {
    return "@$A" + inputPlace;
  }

  public static getText(inputPlace: string): string {
    return "@$t" + inputPlace;
  }

  public static getOuterText(inputPlace: string): string {
    return "@$o" + inputPlace;
  }

  public static getTextLength(inputPlace: string): string {
    return "@$g" + inputPlace;
  }

  public static getAttribute(inputPlace: string, attribute: string): string {
    return "@$a" + inputPlace + RS + attribute;
  }

  public static getWidth(inputPlace: string): string {
    return "@$w" + inputPlace;
  }

  public static getHeight(inputPlace: string): string {
    return "@$h" + inputPlace;
  }

  public static getIsReadOnly(inputPlace: string): string {
    return "@$r" + inputPlace;
  }

  public static getSelectedIndex(inputPlace: string): string {
    return "@$x" + inputPlace;
  }

  public static getIndex(inputPlace: string): string {
    return "@$I" + inputPlace;
  }

  public static getTextAlign(inputPlace: string): string {
    return "@$T" + inputPlace;
  }

  public static getNodeLength(inputPlace: string): string {
    return "@$L" + inputPlace;
  }

  public static getIsVisible(inputPlace: string): string {
    return "@$V" + inputPlace;
  }

  // Save
  public static hasHash(hash: string): string {
    return "@HH" + hash;
  }

  public static cookie(key: string): string {
    return "@co" + key;
  }

  public static save(key: string = "."): string {
    return "@cs" + key;
  }

  public static saveWithReplace(key: string, replaceValue: string): string {
    return "@cs" + key + RS + replaceValue;
  }

  public static saveThenRemove(key: string): string {
    return "@cl" + key;
  }

  public static saveLength(key: string = "."): string {
    return "@cg" + key;
  }

  public static cache(key: string = "."): string {
    return "@cd" + key;
  }

  public static cacheWithReplace(key: string, replaceValue: string): string {
    return "@cd" + key + RS + replaceValue;
  }

  public static cacheThenRemove(key: string): string {
    return "@ct" + key;
  }

  public static cacheLength(key: string = "."): string {
    return "@cG" + key;
  }

  public static saveLine(key: string = ".", line: i32 = 0): string {
    return "@lL" + key + "[" + line.toString();
  }

  public static saveLineConsume(key: string = "."): string {
    return "@lL" + key;
  }

  public static saveINI(key: string, iniKey: string): string {
    return "@lI" + key + "[" + iniKey;
  }

  public static cacheLine(key: string = ".", line: i32 = 0): string {
    return "@dL" + key + "[" + line.toString();
  }

  public static cacheLineConsume(key: string = "."): string {
    return "@dL" + key;
  }

  public static cacheINI(key: string, iniKey: string): string {
    return "@dI" + key + "[" + iniKey;
  }

  // Format Storage
  public static formatStore(key: string): string {
    return "@fr" + key;
  }

  public static formatStoreByXMLQuery(key: string, xPath: string): string {
    return "@fx" + key + RS + xPath;
  }

  public static formatStoreByJSONQuery(key: string, query: string): string {
    return "@fj" + key + RS + query;
  }

  public static formatStoreByINI(key: string, name: string): string {
    return "@fi" + key + RS + name;
  }

  public static formatStoreByText(key: string, line: i32): string {
    return "@ft" + key + RS + line.toString();
  }

  public static formatStoreByVariable(key: string): string {
    return "@fv" + key;
  }

  // State
  public static hasState(path: string): string {
    return "@hs" + path;
  }

  // SSE
  public static sseIsConnected(path: string): string {
    return "@Sc" + path;
  }

  // WebSockets
  public static webSocketsIsConnected(path: string = ""): string {
    return "@Wc" + path;
  }

  // Document
  public static tabIsActive: string = "@da";

  // Window
  public static href: string = "@wf";
  public static pathName: string = "@wP";
  public static query(name: string = "*"): string {
    return "@wq" + name;
  }

  public static hash: string = "@wh";
  public static host: string = "@wH";
  public static hostName: string = "@wn";
  public static port: string = "@wT";
  public static origin: string = "@wo";
  public static getSelection: string = "@ws";
  public static scrollX: string = "@wx";
  public static scrollY: string = "@wy";
  public static segment(index: i32): string {
    return "@wS" + index.toString();
  }

  // It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
  public static hashSegment(index: i32): string {
    return "@wt" + index.toString();
  }

  // Navigator
  public static clipboardText: string = "@nC";
  public static geoLatitude: string = "@nW";
  public static geoLongitude: string = "@nO";
  public static language: string = "@nL";
  public static isOnLine: string = "@no";
  public static userAgent: string = "@na";

  // Screen
  public static screenWidth: string = "@sw";
  public static screenHeight: string = "@sh";
  public static screenOrientationType: string = "@so";
  public static screenOrientationAngle: string = "@sr";

  // Performance
  public static timeOrigin: string = "@pt";
  public static performanceNow: string = "@pn";

  // Event
  public static event: string = "@EV";
  public static eventSerialize: string = "@Es";
  public static eventKey: string = "@ek";
  public static eventWhich: string = "@ew";
  public static eventClientX: string = "@ex";
  public static eventClientY: string = "@ey";
  public static eventPageX: string = "@eX";
  public static eventPageY: string = "@eY";
  public static eventOffsetX: string = "@Ex";
  public static eventOffsetY: string = "@Ey";
  public static eventDeltaY: string = "@ed";
}

export class WasmLanguage {
  // The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
  public static C: string = "c";
  public static CPP: string = "c";
  public static Rust: string = "rust";
  public static CSharp: string = "csharp";
  // .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
  public static CSharpMediator: string = "csharp-m";
  public static GO: string = "go";
  public static JAVA: string = "java";
  public static AssemblyScript: string = "as";
}

export class HtmlEvent {
    public static OnAbort: string = "onabort";
    public static OnAfterPrint: string = "onafterprint";
    public static OnBeforePrint: string = "onbeforeprint";
    public static OnBeforeUnload: string = "onbeforeunload";
    public static OnBlur: string = "onblur";
    public static OnCanPlay: string = "oncanplay";
    public static OnCanPlayThrough: string = "oncanplaythrough";
    public static OnChange: string = "onchange";
    public static OnClick: string = "onclick";
    public static OnCopy: string = "oncopy";
    public static OnCut: string = "oncut";
    public static OnDoubleClick: string = "ondblclick";
    public static OnDrag: string = "ondrag";
    public static OnDragEnd: string = "ondragend";
    public static OnDragEnter: string = "ondragenter";
    public static OnDragLeave: string = "ondragleave";
    public static OnDragOver: string = "ondragover";
    public static OnDragStart: string = "ondragstart";
    public static OnDrop: string = "ondrop";
    public static OnDurationChange: string = "ondurationchange";
    public static OnEnded: string = "onended";
    public static OnError: string = "onerror";
    public static OnFocus: string = "onfocus";
    public static OnFocusIn: string = "onfocusin";
    public static OnFocusOut: string = "onfocusout";
    public static OnHashChange: string = "onhashchange";
    public static OnInput: string = "oninput";
    public static OnInvalid: string = "oninvalid";
    public static OnKeyDown: string = "onkeydown";
    public static OnKeyPress: string = "onkeypress";
    public static OnKeyUp: string = "onkeyup";
    public static OnLoad: string = "onload";
    public static OnLoadedData: string = "onloadeddata";
    public static OnLoadedMetaData: string = "onloadedmetadata";
    public static OnLoadStart: string = "onloadstart";
    public static OnMouseDown: string = "onmousedown";
    public static OnMouseEnter: string = "onmouseenter";
    public static OnMouseLeave: string = "onmouseleave";
    public static OnMouseMove: string = "onmousemove";
    public static OnMouseOver: string = "onmouseover";
    public static OnMouseOut: string = "onmouseout";
    public static OnMouseUp: string = "onmouseup";
    public static OnOffline: string = "onoffline";
    public static OnOnline: string = "ononline";
    public static OnPageHide: string = "onpagehide";
    public static OnPageShow: string = "onpageshow";
    public static OnPaste: string = "onpaste";
    public static OnPause: string = "onpause";
    public static OnPlay: string = "onplay";
    public static OnPlaying: string = "onplaying";
    public static OnProgress: string = "onprogress";
    public static OnRateChange: string = "onratechange";
    public static OnResize: string = "onresize";
    public static OnReset: string = "onreset";
    public static OnScroll: string = "onscroll";
    public static OnSearch: string = "onsearch";
    public static OnSeeked: string = "onseeked";
    public static OnSeeking: string = "onseeking";
    public static OnSelect: string = "onselect";
    public static OnStalled: string = "onstalled";
    public static OnSubmit: string = "onsubmit";
    public static OnSuspend: string = "onsuspend";
    public static OnTimeUpdate: string = "ontimeupdate";
    public static OnToggle: string = "ontoggle";
    public static OnTouchCancel: string = "ontouchcancel";
    public static OnTouchEnd: string = "ontouchend";
    public static OnTouchMove: string = "ontouchmove";
    public static OnTouchStart: string = "ontouchstart";
    public static OnUnload: string = "onunload";
    public static OnVolumeChange: string = "onvolumechange";
    public static OnWaiting: string = "onwaiting";
    public static OnWheel: string = "onwheel";
}

export class HtmlEventListener {
    public static Abort: string = "abort";
    public static AfterPrint: string = "afterprint";
    public static BeforePrint: string = "beforeprint";
    public static BeforeUnload: string = "beforeunload";
    public static Blur: string = "blur";
    public static CanPlay: string = "canplay";
    public static CanPlayThrough: string = "canplaythrough";
    public static Change: string = "change";
    public static Click: string = "click";
    public static Copy: string = "copy";
    public static Cut: string = "cut";
    public static DoubleClick: string = "dblclick";
    public static Drag: string = "drag";
    public static DragEnd: string = "dragend";
    public static DragEnter: string = "dragenter";
    public static DragLeave: string = "dragleave";
    public static DragOver: string = "dragover";
    public static DragStart: string = "dragstart";
    public static Drop: string = "drop";
    public static DurationChange: string = "durationchange";
    public static Ended: string = "ended";
    public static Error: string = "error";
    public static Focus: string = "focus";
    public static FocusIn: string = "focusin";
    public static FocusOut: string = "focusout";
    public static HashChange: string = "hashchange";
    public static Input: string = "input";
    public static Invalid: string = "invalid";
    public static KeyDown: string = "keydown";
    public static KeyPress: string = "keypress";
    public static KeyUp: string = "keyup";
    public static Load: string = "load";
    public static LoadedData: string = "loadeddata";
    public static LoadedMetaData: string = "loadedmetadata";
    public static LoadStart: string = "loadstart";
    public static MouseDown: string = "mousedown";
    public static MouseEnter: string = "mouseenter";
    public static MouseLeave: string = "mouseleave";
    public static MouseMove: string = "mousemove";
    public static MouseOver: string = "mouseover";
    public static MouseOut: string = "mouseout";
    public static MouseUp: string = "mouseup";
    public static Offline: string = "offline";
    public static Online: string = "online";
    public static PageHide: string = "pagehide";
    public static PageShow: string = "pageshow";
    public static Paste: string = "paste";
    public static Pause: string = "pause";
    public static Play: string = "play";
    public static Playing: string = "playing";
    public static Progress: string = "progress";
    public static RateChange: string = "ratechange";
    public static Resize: string = "resize";
    public static Reset: string = "reset";
    public static Scroll: string = "scroll";
    public static Search: string = "search";
    public static Seeked: string = "seeked";
    public static Seeking: string = "seeking";
    public static Select: string = "select";
    public static Stalled: string = "stalled";
    public static Submit: string = "submit";
    public static Suspend: string = "suspend";
    public static TimeUpdate: string = "timeupdate";
    public static Toggle: string = "toggle";
    public static TouchCancel: string = "touchcancel";
    public static TouchEnd: string = "touchend";
    public static TouchMove: string = "touchmove";
    public static TouchStart: string = "touchstart";
    public static Unload: string = "unload";
    public static VolumeChange: string = "volumechange";
    public static Waiting: string = "waiting";
    public static Wheel: string = "wheel";

    public static AnimationEnd: string = "animationend";
    public static AnimationIteration: string = "animationiteration";
    public static AnimationStart: string = "animationstart";
    public static ContextMenu: string = "contextmenu";
    public static FullScreenChange: string = "fullscreenchange";
    public static FullScreenError: string = "fullscreenerror";
    public static PopState: string = "popstate";
    public static TransitionEnd: string = "transitionend";
    public static Storage: string = "storage";

    // Custom
    public static ScrollBottom: string = "scrollbottom"; // Need Call EnableScrollBottomEvent Method Before
    public static ElementReached: string = "elementreached"; // Need Call EnableReachedElementEvent Method Before
}

export class WebFormsExtensions {
  public static child(text: string, value: string): string {
    return text.length == 0 ? value : text + "|" + value;
  }

  public static parent(text: string): string {
    if (text.length == 0) return text;
    if (text.endsWith("|/") || text.endsWith("//")) {
      return text + "/";
    }
    return text + "|/";
  }

  public static criteria(text: string, value: string): string {
    if (text.length == 0) return value;
    return text + "?" + value.replace("|", "$[vb];").replace("?", "$[qu];");
  }

  public static appendFetchReplace(text: string, searchValue: string, value: string): string {
    const fs = String.fromCharCode(28);
    return "@;" + searchValue + fs + value + fs + text.substring(1);
  }

  public static lineBreak(text: string, encodeLine: bool = false): string {
    const encode = encodeLine ? "$[sln];" : "";
    return text.replace(/\r\n/g, encode).replace(/\n/g, encode).replace(/\r/g, encode);
  }

  // Converts Numbers to Strings
  public static toJSString(text: string): string {
    return `"${text}"`;
  }

  // Get JS Object Momentary 
  public static toJSObject(text: string): string {
    return "$" + text;
  }

  // Get JS Object Returned Value Once
  public static toJSReturnObject(text: string): string {
    return "$@" + text;
  }
}