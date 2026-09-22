// webforms.ts 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.1

const GS = String.fromCharCode(29);
const US = String.fromCharCode(31);
const RS = String.fromCharCode(30);

// Helper function to safely convert null/undefined/number to string
function safe(value: string | number | boolean | null | undefined): string {
    if (value === null || value === undefined)
        return '';
    if (typeof value === 'number' || typeof value === 'boolean')
        return value.toString();
    return value;
}

export class WebForms {
    private static readonly GS = String.fromCharCode(29);
    private static readonly US = String.fromCharCode(31);

    private webFormsData: string = '';

    private add(name: string, value?: string | null): void {
        if (this.webFormsData.length > 0)
            this.webFormsData += '\n';

        this.webFormsData += name;

        if (value !== undefined) {
            this.webFormsData += '=';
            if (value !== null)
                this.webFormsData += value;
        }
    }

    private addToUp(name: string, value?: string | null): void {
        let line: string;

        if (value !== undefined) {
            line = name + '=' + (value !== null ? value : '');
        } else {
            line = name;
        }

        if (this.webFormsData.length > 0)
            line += '\n';

        this.webFormsData = line + this.webFormsData;
    }

    private getLineByIndex(index: number): string {
        if (this.webFormsData.length === 0)
            return '';

        const data = this.webFormsData;
        const lines = data.split('\n');

        if (index < 0)
            index = lines.length + index;

        if (index < 0 || index >= lines.length)
            return '';

        return lines[index];
    }

    private updateLineByIndex(index: number, name: string, value: string): void {
        if (this.webFormsData.length === 0)
            return;

        const data = this.webFormsData;
        const lines = data.split('\n');

        if (index < 0)
            index = lines.length + index;

        if (index < 0 || index >= lines.length)
            return;

        lines[index] = name + (value === null || value === undefined || value === '' ? '' : '=' + value);

        this.webFormsData = lines.join('\n');
    }

    // For Extension
    public addLine(name: string, value: string): void {
        this.add(name, value);
    }

    // Add
    // Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.
    public addId(inputPlace: string, id: string): void { this.add('ai' + inputPlace, id); }
    public addName(inputPlace: string, name: string): void { this.add('an' + inputPlace, name); }
    public addValue(inputPlace: string, value: string): void { this.add('av' + inputPlace, value); }
    public addClass(inputPlace: string, className: string): void { this.add('ac' + inputPlace, className); }
    public addStyle(inputPlace: string, style: string): void { this.add('as' + inputPlace, style); }
    public addStyleWithName(inputPlace: string, name: string, value: string): void { this.add('as' + inputPlace, name + ':' + value); }
    public addOptionTag(inputPlace: string, text: string, value: string, selected: boolean = false): void {
        this.add('ao' + inputPlace, value + GS + text + (selected ? GS + '1' : ''));
    }
    public addCheckBoxTag(inputPlace: string, text: string, value: string, checked: boolean = false): void {
        this.add('ak' + inputPlace, value + GS + text + (checked ? GS + '1' : ''));
    }
    public addTitle(inputPlace: string, title: string): void { this.add('al' + inputPlace, title); }
    public addLabel(inputPlace: string, label: string): void { this.add('aA' + inputPlace, label); }
    public addText(inputPlace: string, text: string): void {
        this.add('at' + inputPlace, text.split('\n').join('$[ln];'));
    }
    public addTextToUp(inputPlace: string, text: string): void {
        this.add('pt' + inputPlace, text.split('\n').join('$[ln];'));
    }
    public addAttribute(inputPlace: string, attribute: string, value: string = '', splitter: string = '\0'): void {
        this.add('aa' + inputPlace, attribute + GS + (splitter !== '\0' ? splitter : '') + (value !== null && value !== undefined && value !== '' ? GS + value : ''));
    }
    public addTag(inputPlace: string, tagName: string, id: string = ''): void {
        this.add('nt' + inputPlace, tagName + (id !== null && id !== undefined && id !== '' ? GS + id : ''));
    }
    public addTagToUp(inputPlace: string, tagName: string, id: string = ''): void {
        this.add('ut' + inputPlace, tagName + (id !== null && id !== undefined && id !== '' ? GS + id : ''));
    }
    public addTagBefore(inputPlace: string, tagName: string, id: string = ''): void {
        this.add('bt' + inputPlace, tagName + (id !== null && id !== undefined && id !== '' ? GS + id : ''));
    }
    public addTagAfter(inputPlace: string, tagName: string, id: string = ''): void {
        this.add('ft' + inputPlace, tagName + (id !== null && id !== undefined && id !== '' ? GS + id : ''));
    }
    public addHidden(inputPlace: string, name: string, value: string, id: string = ''): void {
        this.add('ah' + inputPlace, name + GS + value + (id !== null && id !== undefined && id !== '' ? GS + id : ''));
    }

    // Set
    // Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.
    public setId(inputPlace: string, id: string): void { this.add('si' + inputPlace, id); }
    public setName(inputPlace: string, name: string): void { this.add('sn' + inputPlace, name); }
    public setValue(inputPlace: string, value: string): void { this.add('sv' + inputPlace, value); }
    public setClass(inputPlace: string, className: string): void { this.add('sc' + inputPlace, className); }
    public setStyle(inputPlace: string, style: string): void { this.add('ss' + inputPlace, style); }
    public setStyleWithName(inputPlace: string, name: string, value: string): void { this.add('ss' + inputPlace, name + ':' + value); }
    public setOptionTag(inputPlace: string, text: string, value: string, selected: boolean = false): void {
        this.add('so' + inputPlace, value + GS + text + (selected ? GS + '1' : ''));
    }
    public setChecked(inputPlace: string, checked: boolean = false): void { this.add('sk' + inputPlace, checked ? '1' : '0'); }
    public setCheckBoxTag(inputPlace: string, text: string, value: string, checked: boolean = false): void {
        this.add('sk' + inputPlace, value + GS + text + (checked ? GS + '1' : ''));
    }
    public setTitle(inputPlace: string, title: string): void { this.add('sl' + inputPlace, title); }
    public setLabel(inputPlace: string, label: string): void { this.add('sA' + inputPlace, label); }
    public setText(inputPlace: string, text: string): void {
        this.add('st' + inputPlace, text.split('\n').join('$[ln];'));
    }
    public setAttribute(inputPlace: string, attribute: string, value: string = ''): void {
        this.add('sa' + inputPlace, attribute + GS + (value !== null && value !== undefined && value !== '' ? GS + value : ''));
    }
    public setWidth(inputPlace: string, width: string | number): void {
        const finalWidth = typeof width === 'number' ? width.toString() + 'px' : width;
        this.add('sw' + inputPlace, finalWidth);
    }
    public setHeight(inputPlace: string, height: string | number): void {
        const finalHeight = typeof height === 'number' ? height.toString() + 'px' : height;
        this.add('sh' + inputPlace, finalHeight);
    }
    public setBackgroundColor(inputPlace: string, color: string): void { this.add('bc' + inputPlace, color); }
    public setTextColor(inputPlace: string, color: string): void { this.add('tc' + inputPlace, color); }
    public setFontName(inputPlace: string, name: string): void { this.add('fn' + inputPlace, name); }
    public setFontSize(inputPlace: string, size: string | number): void {
        const finalSize = typeof size === 'number' ? size.toString() + 'px' : size;
        this.add('fs' + inputPlace, finalSize);
    }
    public setFontBold(inputPlace: string, bold: boolean): void { this.add('fb' + inputPlace, bold ? '1' : '0'); }
    public setVisible(inputPlace: string, visible: boolean): void { this.add('vi' + inputPlace, visible ? '1' : '0'); }
    public setTextAlign(inputPlace: string, align: string): void { this.add('ta' + inputPlace, align); }
    public setReadOnly(inputPlace: string, readOnly: boolean): void { this.add('sr' + inputPlace, readOnly ? '1' : '0'); }
    public setDisabled(inputPlace: string, disabled: boolean): void { this.add('sd' + inputPlace, disabled ? '1' : '0'); }
    public setFocus(inputPlace: string, focus: boolean): void { this.add('sf' + inputPlace, focus ? '1' : '0'); }
    public setMinLength(inputPlace: string, length: string | number): void {
        const finalLength = typeof length === 'number' ? length.toString() : length;
        this.add('mn' + inputPlace, finalLength);
    }
    public setMaxLength(inputPlace: string, length: string | number): void {
        const finalLength = typeof length === 'number' ? length.toString() : length;
        this.add('mx' + inputPlace, finalLength);
    }
    public setSelectedValue(inputPlace: string, value: string): void { this.add('ts' + inputPlace, value); }
    public setSelectedIndex(inputPlace: string, index: string | number): void {
        const finalIndex = typeof index === 'number' ? index.toString() : index;
        this.add('ti' + inputPlace, finalIndex);
    }
    public setCheckedValue(inputPlace: string, value: string, checked: boolean): void {
        this.add('ks' + inputPlace, value + GS + (checked ? '1' : '0'));
    }
    public setCheckedIndex(inputPlace: string, index: string | number, checked: boolean): void {
        const finalIndex = typeof index === 'number' ? index.toString() : index;
        this.add('ki' + inputPlace, finalIndex + GS + (checked ? '1' : '0'));
    }

    // Insert
    // Creates the Data only if it does not exist; otherwise, does nothing.
    public insertId(inputPlace: string, id: string): void { this.add('ii' + inputPlace, id); }
    public insertName(inputPlace: string, name: string): void { this.add('in' + inputPlace, name); }
    public insertValue(inputPlace: string, value: string): void { this.add('iv' + inputPlace, value); }
    public insertClass(inputPlace: string, className: string): void { this.add('ic' + inputPlace, className); }
    public insertStyle(inputPlace: string, style: string): void { this.add('is' + inputPlace, style); }
    public insertStyleWithName(inputPlace: string, name: string, value: string): void { this.add('is' + inputPlace, name + ':' + value); }
    public insertOptionTag(inputPlace: string, text: string, value: string, selected: boolean = false): void {
        this.add('io' + inputPlace, value + GS + text + (selected ? GS + '1' : ''));
    }
    public insertCheckBoxTag(inputPlace: string, text: string, value: string, checked: boolean = false): void {
        this.add('ik' + inputPlace, value + GS + text + (checked ? GS + '1' : ''));
    }
    public insertTitle(inputPlace: string, title: string): void { this.add('il' + inputPlace, title); }
    public insertLabel(inputPlace: string, label: string): void { this.add('iA' + inputPlace, label); }
    public insertText(inputPlace: string, text: string): void {
        this.add('it' + inputPlace, text.split('\n').join('$[ln];'));
    }
    public insertAttribute(inputPlace: string, attribute: string, value: string = '', splitter: string = '\0'): void {
        this.add('ia' + inputPlace, attribute + GS + (splitter !== '\0' ? splitter : '') + (value !== null && value !== undefined && value !== '' ? GS + value : ''));
    }

    // Delete
    public deleteId(inputPlace: string): void { this.add('di' + inputPlace); }
    public deleteName(inputPlace: string): void { this.add('dn' + inputPlace); }
    public deleteValue(inputPlace: string): void { this.add('dv' + inputPlace); }
    public deleteClass(inputPlace: string, className: string): void { this.add('dc' + inputPlace, className); }
    public deleteStyle(inputPlace: string, styleName: string): void { this.add('ds' + inputPlace, styleName); }
    public deleteOptionTag(inputPlace: string, value: string): void { this.add('do' + inputPlace, value); }
    public deleteAllOptionTag(inputPlace: string): void { this.add('do' + inputPlace, '*'); }
    public deleteCheckBoxTag(inputPlace: string, value: string): void { this.add('dk' + inputPlace, value); }
    public deleteAllCheckBoxTag(inputPlace: string): void { this.add('dk' + inputPlace, '*'); }
    public deleteTitle(inputPlace: string): void { this.add('dl' + inputPlace); }
    public deleteLabel(inputPlace: string): void { this.add('dA' + inputPlace); }
    public deleteText(inputPlace: string): void { this.add('dt' + inputPlace); }
    public deleteAttribute(inputPlace: string, attribute: string): void { this.add('da' + inputPlace, attribute); }
    public delete(inputPlace: string): void { this.add('de' + inputPlace); }
    public deleteParent(inputPlace: string): void { this.add('dp' + inputPlace); }

    // Tag
    public swapTag(inputPlace: string, outputPlace: string): void { this.add('sp' + inputPlace, outputPlace); }
    public setReflection(inputPlace: string, tag: string): void { this.add('sR' + inputPlace, tag); }
    public setReflectionByOutputPlace(inputPlace: string, outputPlace: string): void { this.add('iR' + inputPlace, outputPlace); }
    public setMorph(inputPlace: string, tag: string): void { this.add('sM' + inputPlace, tag); }
    public setMorphByOutputPlace(inputPlace: string, outputPlace: string): void { this.add('iM' + inputPlace, outputPlace); }

    // Browser
    public changeUrl(url: string): void { this.add('cu', url); }
    public setHeadTitle(title: string): void { this.add('ht', title); }
    public clipboardWriteText(text: string): void { this.add('nw', text); }
    public scrollTo(x: string | number, y: string | number): void {
        const xs = typeof x === 'number' ? x.toString() : x;
        const ys = typeof y === 'number' ? y.toString() : y;
        this.add('ws', xs + GS + ys);
    }
    public historyGo(steps: string | number): void {
        const stepsStr = typeof steps === 'number' ? steps.toString() : steps;
        this.add('wg', stepsStr);
    }
    public reloadPage(): void { this.add('lr'); }
    public redirect(path: string): void { this.add('lh', path); }

    // Increase
    public increaseMinLength(inputPlace: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('+n' + inputPlace, v);
    }
    public increaseMaxLength(inputPlace: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('+x' + inputPlace, v);
    }
    public increaseFontSize(inputPlace: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('+f' + inputPlace, v);
    }
    public increaseWidth(inputPlace: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('+w' + inputPlace, v);
    }
    public increaseHeight(inputPlace: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('+h' + inputPlace, v);
    }
    public increaseValue(inputPlace: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('+v' + inputPlace, v);
    }

    // Decrease
    public decreaseMinLength(inputPlace: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('-n' + inputPlace, v);
    }
    public decreaseMaxLength(inputPlace: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('-x' + inputPlace, v);
    }
    public decreaseFontSize(inputPlace: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('-f' + inputPlace, v);
    }
    public decreaseWidth(inputPlace: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('-w' + inputPlace, v);
    }
    public decreaseHeight(inputPlace: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('-h' + inputPlace, v);
    }
    public decreaseValue(inputPlace: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('-v' + inputPlace, v);
    }

    // Event
    // ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
    // All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.
    public triggerEvent(inputPlace: string, htmlEventListener: string, constructorName: string | null = null): void {
        this.add('TE' + inputPlace, htmlEventListener + (constructorName !== null && constructorName !== undefined && constructorName !== '' ? GS + constructorName : ''));
    }
    public setPostEvent(inputPlace: string, htmlEvent: string, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('Ep' + inputPlace, htmlEvent + GS + outputPlace);
        else
            this.add('Ep' + inputPlace, htmlEvent);
    }
    public setPostEventAddView(inputPlace: string, htmlEvent: string): void {
        this.add('Ep' + inputPlace, htmlEvent + GS + '+');
    }
    public setPostEventListener(inputPlace: string, htmlEventListener: string, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('EP' + inputPlace, htmlEventListener + GS + outputPlace);
        else
            this.add('EP' + inputPlace, htmlEventListener);
    }
    public setPostEventListenerAddView(inputPlace: string, htmlEventListener: string): void {
        this.add('EP' + inputPlace, htmlEventListener + GS + '+');
    }
    public setGetEvent(inputPlace: string, htmlEvent: string, path: string | null = null, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('Eg' + inputPlace, htmlEvent + GS + (path !== null && path !== undefined && path !== '' ? path : '#') + GS + outputPlace);
        else
            this.add('Eg' + inputPlace, htmlEvent + GS + (path !== null && path !== undefined && path !== '' ? path : '#'));
    }
    public setGetEventListener(inputPlace: string, htmlEventListener: string, path: string | null = null, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('EG' + inputPlace, htmlEventListener + GS + (path !== null && path !== undefined && path !== '' ? path : '#') + GS + outputPlace);
        else
            this.add('EG' + inputPlace, htmlEventListener + GS + (path !== null && path !== undefined && path !== '' ? path : '#'));
    }
    public setPutEvent(inputPlace: string, htmlEvent: string, path: string | null = null, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('Et' + inputPlace, htmlEvent + GS + (path !== null && path !== undefined && path !== '' ? path : '#') + GS + outputPlace);
        else
            this.add('Et' + inputPlace, htmlEvent + GS + (path !== null && path !== undefined && path !== '' ? path : '#'));
    }
    public setPutEventListener(inputPlace: string, htmlEventListener: string, path: string | null = null, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('ET' + inputPlace, htmlEventListener + GS + (path !== null && path !== undefined && path !== '' ? path : '#') + GS + outputPlace);
        else
            this.add('ET' + inputPlace, htmlEventListener + GS + (path !== null && path !== undefined && path !== '' ? path : '#'));
    }
    public setPatchEvent(inputPlace: string, htmlEvent: string, path: string | null = null, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('Ea' + inputPlace, htmlEvent + GS + (path !== null && path !== undefined && path !== '' ? path : '#') + GS + outputPlace);
        else
            this.add('Ea' + inputPlace, htmlEvent + GS + (path !== null && path !== undefined && path !== '' ? path : '#'));
    }
    public setPatchEventListener(inputPlace: string, htmlEventListener: string, path: string | null = null, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('EA' + inputPlace, htmlEventListener + GS + (path !== null && path !== undefined && path !== '' ? path : '#') + GS + outputPlace);
        else
            this.add('EA' + inputPlace, htmlEventListener + GS + (path !== null && path !== undefined && path !== '' ? path : '#'));
    }
    public setDeleteEvent(inputPlace: string, htmlEvent: string, path: string | null = null, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('El' + inputPlace, htmlEvent + GS + (path !== null && path !== undefined && path !== '' ? path : '#') + GS + outputPlace);
        else
            this.add('El' + inputPlace, htmlEvent + GS + (path !== null && path !== undefined && path !== '' ? path : '#'));
    }
    public setDeleteEventListener(inputPlace: string, htmlEventListener: string, path: string | null = null, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('EL' + inputPlace, htmlEventListener + GS + (path !== null && path !== undefined && path !== '' ? path : '#') + GS + outputPlace);
        else
            this.add('EL' + inputPlace, htmlEventListener + GS + (path !== null && path !== undefined && path !== '' ? path : '#'));
    }
    public setOptionsEvent(inputPlace: string, htmlEvent: string, path: string | null = null, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('Eo' + inputPlace, htmlEvent + GS + (path !== null && path !== undefined && path !== '' ? path : '#') + GS + outputPlace);
        else
            this.add('Eo' + inputPlace, htmlEvent + GS + (path !== null && path !== undefined && path !== '' ? path : '#'));
    }
    public setOptionsEventListener(inputPlace: string, htmlEventListener: string, path: string | null = null, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('EO' + inputPlace, htmlEventListener + GS + (path !== null && path !== undefined && path !== '' ? path : '#') + GS + outputPlace);
        else
            this.add('EO' + inputPlace, htmlEventListener + GS + (path !== null && path !== undefined && path !== '' ? path : '#'));
    }
    public setHeadEvent(inputPlace: string, htmlEvent: string, path: string | null = null): void {
        this.add('Eh' + inputPlace, htmlEvent + GS + (path !== null && path !== undefined && path !== '' ? path : '#'));
    }
    public setHeadEventListener(inputPlace: string, htmlEventListener: string, path: string | null = null): void {
        this.add('EH' + inputPlace, htmlEventListener + GS + (path !== null && path !== undefined && path !== '' ? path : '#'));
    }
    // IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
    public setSendEvent(inputPlace: string, htmlEvent: string, data: string, path: string | null = null, method: string = 'POST', isMultiPart: boolean = false, contentType: string = 'text/plain', outputPlace?: string | null): void {
        this.add('En' + inputPlace, htmlEvent + GS + data.split('\n').join('$[ln];').split('"').join('$[dq];').split("'").join('$[sq];') + GS + (path !== null && path !== undefined && path !== '' ? path : '#') + GS + method + GS + (isMultiPart ? '1' : '0') + GS + contentType + GS + safe(outputPlace));
    }
    public setSendEventListener(inputPlace: string, htmlEventListener: string, data: string, path: string | null = null, method: string = 'POST', isMultiPart: boolean = false, contentType: string = 'text/plain', outputPlace?: string | null): void {
        this.add('EN' + inputPlace, htmlEventListener + GS + data.split('\n').join('$[ln];') + GS + (path !== null && path !== undefined && path !== '' ? path : '#') + GS + method + GS + (isMultiPart ? '1' : '0') + GS + contentType + GS + safe(outputPlace));
    }
    public setCommentEvent(inputPlace: string, htmlEvent: string, index?: string | number, outputPlace?: string | null): void {
        this.add('Eb' + inputPlace, htmlEvent + GS + safe(index) + GS + safe(outputPlace));
    }
    public setCommentEventListener(inputPlace: string, htmlEventListener: string, index?: string | number, outputPlace?: string | null): void {
        this.add('EB' + inputPlace, htmlEventListener + GS + safe(index) + GS + safe(outputPlace));
    }
    public setWasmEvent(inputPlace: string, htmlEvent: string, wasmLanguage: string, wasmUrl: string, methodName: string, args: (string | number | boolean)[] | null = null, outputPlace?: string | null): void {
        let argsJoin = '';

        if (args !== null)
            argsJoin = args.length > 0 ? '[' + args.join(US) : '';

        this.add('Ey' + inputPlace, htmlEvent + GS + wasmLanguage + GS + wasmUrl + GS + methodName + GS + argsJoin + GS + safe(outputPlace));
    }
    public setWasmEventListener(inputPlace: string, htmlEventListener: string, wasmLanguage: string, wasmUrl: string, methodName: string, args: (string | number | boolean)[] | null = null, outputPlace?: string | null): void {
        let argsJoin = '';

        if (args !== null)
            argsJoin = args.length > 0 ? '[' + args.join(US) : '';

        this.add('EY' + inputPlace, htmlEventListener + GS + wasmLanguage + GS + wasmUrl + GS + methodName + GS + argsJoin + GS + safe(outputPlace));
    }
    public setWebSocketEvent(inputPlace: string, htmlEvent: string, path: string): void {
        this.add('Ew' + inputPlace, htmlEvent + GS + path);
    }
    public setWebSocketEventListener(inputPlace: string, htmlEventListener: string, path: string): void {
        this.add('EW' + inputPlace, htmlEventListener + GS + path);
    }
    public setSSEEvent(inputPlace: string, htmlEvent: string, path: string, shouldReconnect: boolean = true, reconnectTryTimeout: number = 3000, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('Ee' + inputPlace, htmlEvent + GS + path + GS + (shouldReconnect ? '1' : '0') + GS + reconnectTryTimeout.toString() + GS + outputPlace);
        else
            this.add('Ee' + inputPlace, htmlEvent + GS + path + GS + (shouldReconnect ? '1' : '0') + GS + reconnectTryTimeout.toString());
    }
    public setSSEEventListener(inputPlace: string, htmlEventListener: string, path: string, shouldReconnect: boolean = true, reconnectTryTimeout: number = 3000, outputPlace?: string): void {
        if (outputPlace !== undefined)
            this.add('EE' + inputPlace, htmlEventListener + GS + path + GS + (shouldReconnect ? '1' : '0') + GS + reconnectTryTimeout.toString() + GS + outputPlace);
        else
            this.add('EE' + inputPlace, htmlEventListener + GS + path + GS + (shouldReconnect ? '1' : '0') + GS + reconnectTryTimeout.toString());
    }
    public setFrontEvent(inputPlace: string, htmlEvent: string, modulePath: string, args: (string | number | boolean)[] | null = null, outputPlace?: string | null): void {
        let argsJoin = '';

        if (args !== null)
            argsJoin = args.length > 0 ? GS + '[' + args.join(US) : '';

        this.add('Ej' + inputPlace, htmlEvent + GS + modulePath + GS + safe(outputPlace) + argsJoin);
    }
    public setFrontEventListener(inputPlace: string, htmlEventListener: string, modulePath: string, args: (string | number | boolean)[] | null = null, outputPlace?: string | null): void {
        let argsJoin = '';

        if (args !== null)
            argsJoin = args.length > 0 ? GS + '[' + args.join(US) : '';

        this.add('EJ' + inputPlace, htmlEventListener + GS + modulePath + GS + safe(outputPlace) + argsJoin);
    }
    public setMasterPagesEvent(inputPlace: string, htmlEvent: string, outputPlace?: string | null): void {
        this.add('Eu' + inputPlace, htmlEvent + GS + safe(outputPlace));
    }
    public setMasterPagesEventListener(inputPlace: string, htmlEventListener: string, outputPlace?: string | null): void {
        this.add('EU' + inputPlace, htmlEventListener + GS + safe(outputPlace));
    }
    public setPreventDefaultEvent(inputPlace: string, htmlEvent: string): void {
        this.add('Ed' + inputPlace, htmlEvent);
    }
    public setPreventDefaultEventListener(inputPlace: string, htmlEventListener: string): void {
        this.add('ED' + inputPlace, htmlEventListener);
    }
    public setStopPropagationEvent(inputPlace: string, htmlEvent: string): void {
        this.add('Es' + inputPlace, htmlEvent);
    }
    public setStopPropagationEventListener(inputPlace: string, htmlEventListener: string): void {
        this.add('ES' + inputPlace, htmlEventListener);
    }
    public setMethodEvent(inputPlace: string, htmlEvent: string, methodName: string, args: (string | number | boolean)[] | null = null): void {
        let argsJoin = '';

        if (args !== null)
            argsJoin = args.length > 0 ? GS + '[' + args.join(US) : '';

        this.add('Em' + inputPlace, htmlEvent + GS + methodName + argsJoin);
    }
    public setMethodEventListener(inputPlace: string, htmlEventListener: string, methodName: string, args: (string | number | boolean)[] | null = null): void {
        let argsJoin = '';

        if (args !== null)
            argsJoin = args.length > 0 ? GS + '[' + args.join(US) : '';

        this.add('EM' + inputPlace, htmlEventListener + GS + methodName + argsJoin);
    }
    public setModuleMethodEvent(inputPlace: string, htmlEvent: string, methodName: string, args: (string | number | boolean)[] | null = null): void {
        let argsJoin = '';

        if (args !== null)
            argsJoin = args.length > 0 ? GS + '[' + args.join(US) : '';

        this.add('Ex' + inputPlace, htmlEvent + GS + methodName + argsJoin);
    }
    public setModuleMethodEventListener(inputPlace: string, htmlEventListener: string, methodName: string, args: (string | number | boolean)[] | null = null): void {
        let argsJoin = '';

        if (args !== null)
            argsJoin = args.length > 0 ? GS + '[' + args.join(US) : '';

        this.add('EX' + inputPlace, htmlEventListener + GS + methodName + argsJoin);
    }
    public assignConfirmEvent(inputPlace: string, htmlEvent: string, text: string = 'Are you sure you want to proceed?', type: string = 'none', title: string = 'Confirm', okText: string = 'OK', cancelText: string = 'Cancel'): void {
        this.add('Ef' + inputPlace, htmlEvent + GS + (text === 'Are you sure you want to proceed?' ? '' : text) + GS + (type === 'none' ? '' : type) + GS + (title === 'Confirm' ? '' : title) + GS + (okText === 'OK' ? '' : okText) + GS + (cancelText === 'Cancel' ? '' : cancelText));
    }
    public removePostEvent(inputPlace: string, htmlEvent: string): void { this.add('Rp' + inputPlace, htmlEvent); }
    public removePostEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RP' + inputPlace, htmlEventListener); }
    public removeGetEvent(inputPlace: string, htmlEvent: string): void { this.add('Rg' + inputPlace, htmlEvent); }
    public removeGetEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RG' + inputPlace, htmlEventListener); }
    public removePutEvent(inputPlace: string, htmlEvent: string): void { this.add('Rt' + inputPlace, htmlEvent); }
    public removePutEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RT' + inputPlace, htmlEventListener); }
    public removePatchEvent(inputPlace: string, htmlEvent: string): void { this.add('Ra' + inputPlace, htmlEvent); }
    public removePatchEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RA' + inputPlace, htmlEventListener); }
    public removeDeleteEvent(inputPlace: string, htmlEvent: string): void { this.add('Rl' + inputPlace, htmlEvent); }
    public removeDeleteEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RL' + inputPlace, htmlEventListener); }
    public removeOptionsEvent(inputPlace: string, htmlEvent: string): void { this.add('Ro' + inputPlace, htmlEvent); }
    public removeOptionsEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RO' + inputPlace, htmlEventListener); }
    public removeHeadEvent(inputPlace: string, htmlEvent: string): void { this.add('Rh' + inputPlace, htmlEvent); }
    public removeHeadEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RH' + inputPlace, htmlEventListener); }
    public removeSendEvent(inputPlace: string, htmlEvent: string): void { this.add('Rn' + inputPlace, htmlEvent); }
    public removeSendEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RN' + inputPlace, htmlEventListener); }
    public removeCommentEvent(inputPlace: string, htmlEvent: string): void { this.add('Rb' + inputPlace, htmlEvent); }
    public removeCommentEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RB' + inputPlace, htmlEventListener); }
    public removeWasmEvent(inputPlace: string, htmlEvent: string): void { this.add('Ry' + inputPlace, htmlEvent); }
    public removeWasmEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RY' + inputPlace, htmlEventListener); }
    public removeWebSocketEvent(inputPlace: string, htmlEvent: string): void { this.add('Rw' + inputPlace, htmlEvent); }
    public removeWebSocketEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RW' + inputPlace, htmlEventListener); }
    public removeSSEEvent(inputPlace: string, htmlEvent: string): void { this.add('Re' + inputPlace, htmlEvent); }
    public removeSSEEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RE' + inputPlace, htmlEventListener); }
    public removeFrontEvent(inputPlace: string, htmlEvent: string): void { this.add('Rj' + inputPlace, htmlEvent); }
    public removeFrontEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RJ' + inputPlace, htmlEventListener); }
    public removePreventDefaultEvent(inputPlace: string, htmlEvent: string): void { this.add('Rd' + inputPlace, htmlEvent); }
    public removePreventDefaultEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RD' + inputPlace, htmlEventListener); }
    public removeMasterPagesEvent(inputPlace: string, htmlEvent: string): void { this.add('Ru' + inputPlace, htmlEvent); }
    public removeMasterPagesEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RU' + inputPlace, htmlEventListener); }
    public removeStopPropagationEvent(inputPlace: string, htmlEvent: string): void { this.add('Rs' + inputPlace, htmlEvent); }
    public removeStopPropagationEventListener(inputPlace: string, htmlEventListener: string): void { this.add('RS' + inputPlace, htmlEventListener); }
    public removeMethodEvent(inputPlace: string, htmlEvent: string, methodName: string): void { this.add('Rm' + inputPlace, htmlEvent + GS + methodName); }
    public removeMethodEventListener(inputPlace: string, htmlEventListener: string, methodName: string): void { this.add('RM' + inputPlace, htmlEventListener + GS + methodName); }
    public removeModuleMethodEvent(inputPlace: string, htmlEvent: string, methodName: string): void { this.add('Rx' + inputPlace, htmlEvent + GS + methodName); }
    public removeModuleMethodEventListener(inputPlace: string, htmlEventListener: string, methodName: string): void { this.add('RX' + inputPlace, htmlEventListener + GS + methodName); }
    public removeConfirmEvent(inputPlace: string, htmlEvent: string): void { this.add('Rf' + inputPlace, htmlEvent); }

    // Custom Event
    // This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
    // Watch: attribute, style, text, children, value
    // Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
    // Range: Only Use For Compare With inrange Value. Split By Comma ","
    // Key: Only Use For Watch With attribute And style Value
    public createCustomDOMEvent(inputPlace: string, eventName: string, watch: string, key: string, compare: string, value: string, range: string, immediate: boolean = false, delay: string | number = '0'): void {
        const delayStr = typeof delay === 'number' ? delay.toString() : delay;
        this.add('eC' + inputPlace, eventName + GS + watch + GS + key + GS + compare + GS + value + GS + range + GS + (immediate ? '1' : '0') + GS + delayStr);
    }
    public enableScrollBottomEvent(enable: boolean = true): void { this.add('eb', enable ? '1' : '0'); }
    public enableReachedElementEvent(inputPlace: string, once: boolean, enable: boolean = true): void {
        this.add('er' + inputPlace, (once ? '1' : '0') + GS + (enable ? '1' : '0'));
    }

    // Module
    public loadModule(modulePath: string, methods: string[] | null = null): void {
        methods = methods ?? [];
        this.add('Ml', modulePath + (methods.length > 0 ? GS + '[' + methods.join(US) : ''));
    }
    public unloadModule(modulePath: string): void { this.add('Mu', modulePath); }
    public deleteModuleMethod(methodName: string): void { this.add('Md', methodName); }

    // Unit Testing
    // InputPlace Is Actual, Expected Is Tag/OutputPlace
    public assertEqual(inputPlace: string, tag: string): void {
        this.add('At' + inputPlace, tag.split('\n').join('$[ln];'));
    }
    public assertEqualByOutputPlace(inputPlace: string, outputPlace: string): void {
        this.add('Ao' + inputPlace, outputPlace);
    }

    // Debug
    public createDebugger(pause: boolean = false): void { this.add('Dc', pause ? '1' : '0'); }

    // Service Worker
    // To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
    public serviceWorkerRegister(path?: string | null, scopePath?: string | null): void {
        this.add('wR', safe(path) + GS + safe(scopePath));
    }
    public serviceWorkerPreCacheStatic(pathList: string[]): void {
        this.add('wp', pathList.join(GS));
    }
    public serviceWorkerDynamicCache(path: string, seconds: string | number = ''): void {
        const secondsStr = typeof seconds === 'number' ? (seconds > 0 ? seconds.toString() : '') : seconds;
        this.add('wc', path + (secondsStr !== '' ? GS + secondsStr : ''));
    }
    public serviceWorkerDeleteDynamicCache(path?: string): void {
        if (path !== undefined)
            this.add('wd', path);
        else
            this.add('wd');
    }
    public serviceWorkerDynamicCacheTTLUpdate(path: string, seconds: string | number = ''): void {
        const secondsStr = typeof seconds === 'number' ? (seconds > 0 ? seconds.toString() : '') : seconds;
        this.add('wt', path + (secondsStr !== '' ? GS + secondsStr : ''));
    }
    // Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
    // Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
    // CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
    public serviceWorkerRouteSet(path: string, type: string, cacheDynamic: boolean = false): void {
        this.add('wr', path + GS + type + (cacheDynamic ? GS + '1' : ''));
    }
    public serviceWorkerRouteAlias(path: string, to: string): void {
        this.add('wa', path + GS + to);
    }
    public serviceWorkerDeleteRouteAlias(path?: string): void {
        if (path !== undefined)
            this.add('wC', path);
        else
            this.add('wC');
    }
    // Delete All Route And Alias
    public serviceWorkerDeleteRoute(path?: string): void {
        if (path !== undefined)
            this.add('wD', path);
        else
            this.add('wD');
    }

    // SSE
    public disconnectSSE(path: string): void { this.add('Ds', path); }
    public disconnectAllSSE(): void { this.add('Ds'); }

    // State
    public addState(path?: string | null, title?: string | null): void {
        this.add('AS', safe(path) + GS + safe(title));
    }
    public saveState(path?: string | null, title?: string | null): void {
        this.add('As', safe(path) + GS + safe(title));
    }
    public loadState(path: string): void { this.add('ls', path); }
    public deleteState(path?: string | null): void {
        if (path !== undefined && path !== null)
            this.add('DS', path);
        else
            this.add('DS');
    }
    public deleteAllState(): void { this.add('DS', '*'); }

    // Cookie
    public setCookie(key: string, value: string, seconds: string | number, path: string | null = null): void {
        const secondsStr = typeof seconds === 'number' ? seconds.toString() : seconds;
        this.add('sC', key + GS + value + GS + secondsStr + (path !== null && path !== undefined && path !== '' ? GS + path : ''));
    }

    // Save (Session Cache)
    public saveId(inputPlace: string, key: string = '.'): void { this.add('@gi' + inputPlace, key); }
    public saveName(inputPlace: string, key: string = '.'): void { this.add('@gn' + inputPlace, key); }
    public saveValue(inputPlace: string, key: string = '.'): void { this.add('@gv' + inputPlace, key); }
    public saveValueLength(inputPlace: string, key: string = '.'): void { this.add('@ge' + inputPlace, key); }
    public saveClass(inputPlace: string, key: string = '.'): void { this.add('@gc' + inputPlace, key); }
    public saveStyle(inputPlace: string, key: string = '.'): void { this.add('@gs' + inputPlace, key); }
    public saveTitle(inputPlace: string, key: string = '.'): void { this.add('@gl' + inputPlace, key); }
    public saveLabel(inputPlace: string, key: string = '.'): void { this.add('@gA' + inputPlace, key); }
    public saveText(inputPlace: string, key: string = '.'): void { this.add('@gt' + inputPlace, key); }
    public saveOuterText(inputPlace: string, key: string = '.'): void { this.add('@go' + inputPlace, key); }
    public saveTextLength(inputPlace: string, key: string = '.'): void { this.add('@gg' + inputPlace, key); }
    public saveAttribute(inputPlace: string, attribute: string, key: string = '.'): void {
        this.add('@ga' + inputPlace, key + GS + attribute);
    }
    public saveWidth(inputPlace: string, key: string = '.'): void { this.add('@gw' + inputPlace, key); }
    public saveHeight(inputPlace: string, key: string = '.'): void { this.add('@gh' + inputPlace, key); }
    public saveReadOnly(inputPlace: string, key: string = '.'): void { this.add('@gr' + inputPlace, key); }
    public saveSelectedIndex(inputPlace: string, key: string = '.'): void { this.add('@gx' + inputPlace, key); }
    public saveTextAlign(inputPlace: string, key: string = '.'): void { this.add('@gT' + inputPlace, key); }
    public saveNodeLength(inputPlace: string, key: string = '.'): void { this.add('@gL' + inputPlace, key); }
    public saveVisible(inputPlace: string, key: string = '.'): void { this.add('@gV' + inputPlace, key); }
    public saveUrl(url: string, fetchScript: boolean = false, key: string = '.'): void {
        this.add('@gu', key + GS + url + (fetchScript ? GS + '1' : ''));
    }
    public saveIndex(inputPlace: string, key: string = '.'): void { this.add('@gI' + inputPlace, key); }
    public removeSave(cacheKey: string): void { this.add('rs', cacheKey); }
    public removeAllSave(): void { this.add('rs', '*'); }
    // Calling the SetSave Method Causes Action Control Requests Triggered by Events Using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send Event, to be Temporarily Saved on the Active Page, so the Request will not be Sent to the Server Again.
    public setSave(): void { this.add('cs', '*'); }
    public addSaveValue(cacheKey: string, value: string): void {
        this.add('SA', cacheKey + GS + value.split('\n').join('$[ln];'));
    }
    public insertSaveValue(cacheKey: string, value: string): void {
        this.add('SI', cacheKey + GS + value.split('\n').join('$[ln];'));
    }
    public appendSaveValue(cacheKey: string, value: string): void {
        this.add('SP', cacheKey + GS + value.split('\n').join('$[ln];'));
    }
    public replaceSaveValue(cacheKey: string, searchValue: string, value: string): void {
        this.add('SR', cacheKey + GS + value.split('\n').join('$[ln];') + GS + searchValue.split('\n').join('$[ln];'));
    }

    // Cache
    public cacheId(inputPlace: string, key: string = '.'): void { this.add('@ci' + inputPlace, key); }
    public cacheName(inputPlace: string, key: string = '.'): void { this.add('@cn' + inputPlace, key); }
    public cacheValue(inputPlace: string, key: string = '.'): void { this.add('@cv' + inputPlace, key); }
    public cacheValueLength(inputPlace: string, key: string = '.'): void { this.add('@ce' + inputPlace, key); }
    public cacheClass(inputPlace: string, key: string = '.'): void { this.add('@cc' + inputPlace, key); }
    public cacheStyle(inputPlace: string, key: string = '.'): void { this.add('@cs' + inputPlace, key); }
    public cacheTitle(inputPlace: string, key: string = '.'): void { this.add('@cl' + inputPlace, key); }
    public cacheLabel(inputPlace: string, key: string = '.'): void { this.add('@cA' + inputPlace, key); }
    public cacheText(inputPlace: string, key: string = '.'): void { this.add('@ct' + inputPlace, key); }
    public cacheOuterText(inputPlace: string, key: string = '.'): void { this.add('@co' + inputPlace, key); }
    public cacheTextLength(inputPlace: string, key: string = '.'): void { this.add('@cg' + inputPlace, key); }
    public cacheAttribute(inputPlace: string, attribute: string, key: string = '.'): void {
        this.add('@ca' + inputPlace, key + GS + attribute);
    }
    public cacheWidth(inputPlace: string, key: string = '.'): void { this.add('@cw' + inputPlace, key); }
    public cacheHeight(inputPlace: string, key: string = '.'): void { this.add('@ch' + inputPlace, key); }
    public cacheReadOnly(inputPlace: string, key: string = '.'): void { this.add('@cr' + inputPlace, key); }
    public cacheSelectedIndex(inputPlace: string, key: string = '.'): void { this.add('@cx' + inputPlace, key); }
    public cacheTextAlign(inputPlace: string, key: string = '.'): void { this.add('@cT' + inputPlace, key); }
    public cacheNodeLength(inputPlace: string, key: string = '.'): void { this.add('@cL' + inputPlace, key); }
    public cacheVisible(inputPlace: string, key: string = '.'): void { this.add('@cV' + inputPlace, key); }
    public cacheUrl(url: string, fetchScript: boolean = false, key: string = '.'): void {
        this.add('@cu', key + GS + url + (fetchScript ? GS + '1' : ''));
    }
    public cacheIndex(inputPlace: string, key: string = '.'): void { this.add('@cI' + inputPlace, key); }
    public removeCache(cacheKey: string): void { this.add('rd', cacheKey); }
    public removeAllCache(): void { this.add('rd', '*'); }
    // Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
    public setCache(second?: string | number): void {
        if (second === undefined) {
            this.add('cd', '*');
        } else if (typeof second === 'number') {
            this.add('cd', second.toString());
        } else {
            this.add('cd', second);
        }
    }
    public addCacheValue(cacheKey: string, value: string): void {
        this.add('CA', cacheKey + GS + value.split('\n').join('$[ln];'));
    }
    public insertCacheValue(cacheKey: string, value: string): void {
        this.add('CI', cacheKey + GS + value.split('\n').join('$[ln];'));
    }
    public appendCacheValue(cacheKey: string, value: string): void {
        this.add('CP', cacheKey + GS + value.split('\n').join('$[ln];'));
    }
    public replaceCacheValue(cacheKey: string, searchValue: string, value: string): void {
        this.add('CR', cacheKey + GS + value.split('\n').join('$[ln];') + GS + searchValue.split('\n').join('$[ln];'));
    }

    // Call
    public loadUrl(inputPlace: string, url: string): void { this.add('lu' + inputPlace, url); }
    public runActionControls(actionControls: string, withoutWebFormsSection: boolean = true, index?: string | null, useCurrentEvent: boolean = true): void {
        this.add('lA', (useCurrentEvent ? '1' : '0') + GS + (withoutWebFormsSection ? '1' : '0') + GS + safe(index) + GS + actionControls);
    }
    public callScript(scriptText: string): void {
        this.add('_', scriptText.split('\n').join('$[ln];'));
    }
    public callMethod(methodName: string, args: (string | number | boolean)[] | null = null): void {
        let argsJoin = '';

        if (args !== null)
            argsJoin = args.length > 0 ? GS + '[' + args.join(US) : '';

        this.add('lm', methodName + argsJoin);
    }
    public callModuleMethod(methodName: string, args: (string | number | boolean)[] | null = null): void {
        let argsJoin = '';

        if (args !== null)
            argsJoin = args.length > 0 ? GS + '[' + args.join(US) : '';

        this.add('lM', methodName + argsJoin);
    }
    public callPostBack(formInputPlace: string, outputPlace: string | null = null): void {
        this.add('Lp', '1' + GS + formInputPlace + (outputPlace !== null && outputPlace !== undefined && outputPlace !== '' ? GS + outputPlace : ''));
    }
    public callCommentBack(index?: string | number, inputPlace?: string | null, useCurrentEvent: boolean = true): void {
        this.add('LC', (useCurrentEvent ? '1' : '0') + GS + safe(index) + GS + safe(inputPlace));
    }
    public callWasmBack(wasmLanguage: string, wasmUrl: string, methodName: string, args: (string | number | boolean)[] | null = null, outputPlace?: string | null, useCurrentEvent: boolean = true): void {
        let argsJoin = '';

        if (args !== null)
            argsJoin = args.length > 0 ? '[' + args.join(US) : '';

        this.add('Ly', (useCurrentEvent ? '1' : '0') + GS + wasmLanguage + GS + wasmUrl + GS + methodName + GS + argsJoin + GS + safe(outputPlace));
    }
    public callWebSocketBack(path: string, useCurrentEvent: boolean = true): void {
        this.add('Lw', (useCurrentEvent ? '1' : '0') + GS + path);
    }
    public callSSEBack(path: string, outputPlace: string | null = null, useCurrentEvent: boolean = true, shouldReconnect: boolean = true, reconnectTryTimeout: string | number = '3000'): void {
        const timeoutStr = typeof reconnectTryTimeout === 'number' ? reconnectTryTimeout.toString() : reconnectTryTimeout;
        this.add('Ls', (useCurrentEvent ? '1' : '0') + GS + path + GS + (shouldReconnect ? '1' : '0') + GS + timeoutStr + (outputPlace !== null && outputPlace !== undefined && outputPlace !== '' ? GS + outputPlace : ''));
    }
    public callFront(modulePath: string, args: (string | number | boolean)[] | null = null, outputPlace?: string | null, useCurrentEvent: boolean = true): void {
        let argsJoin = '';

        if (args !== null)
            argsJoin = args.length > 0 ? GS + '[' + args.join(US) : '';

        this.add('Lj', (useCurrentEvent ? '1' : '0') + GS + modulePath + GS + safe(outputPlace) + argsJoin);
    }
    public callGetBack(path: string, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
        this.add('Lg', (useCurrentEvent ? '1' : '0') + GS + path + (outputPlace !== null && outputPlace !== undefined && outputPlace !== '' ? GS + outputPlace : ''));
    }
    public callPutBack(path: string, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
        this.add('Lt', (useCurrentEvent ? '1' : '0') + GS + path + (outputPlace !== null && outputPlace !== undefined && outputPlace !== '' ? GS + outputPlace : ''));
    }
    public callPatchBack(path: string, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
        this.add('LP', (useCurrentEvent ? '1' : '0') + GS + path + (outputPlace !== null && outputPlace !== undefined && outputPlace !== '' ? GS + outputPlace : ''));
    }
    public callDeleteBack(path: string, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
        this.add('Ld', (useCurrentEvent ? '1' : '0') + GS + path + (outputPlace !== null && outputPlace !== undefined && outputPlace !== '' ? GS + outputPlace : ''));
    }
    public callHeadBack(path: string, useCurrentEvent: boolean = true): void {
        this.add('Lh', (useCurrentEvent ? '1' : '0') + GS + path);
    }
    public callOptionsBack(path: string, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
        this.add('Lo', (useCurrentEvent ? '1' : '0') + GS + path + (outputPlace !== null && outputPlace !== undefined && outputPlace !== '' ? GS + outputPlace : ''));
    }
    public callSendBack(path: string, method: string, isMultiPart: boolean, contentType: string, data: string, outputPlace: string | null = null, useCurrentEvent: boolean = true): void {
        this.add('LS', (useCurrentEvent ? '1' : '0') + GS + path + GS + method + GS + (isMultiPart ? '1' : '0') + GS + contentType + GS + data.split('\n').join('$[ln];') + (outputPlace !== null && outputPlace !== undefined && outputPlace !== '' ? GS + outputPlace : ''));
    }

    // Update
    public increase(inputPlace: string, value: number): void { this.add('gt' + inputPlace, 'i' + GS + value.toString()); }
    public decrease(inputPlace: string, value: number): void { this.add('gt' + inputPlace, 'i' + GS + (value * -1).toString()); }
    // If You Don't Use Deep Mode, any Tags Inside the Current Tag Will Simply Be Treated as Strings. Deep Mode Does not Remove Inner Elements.
    public replace(inputPlace: string, value: string, newValue: string, alsoStartTag: boolean = false, deep: boolean = true): void {
        this.add('gt' + inputPlace, 'r' + GS + value + GS + newValue + GS + (alsoStartTag ? '1' : '0') + GS + (deep ? '1' : '0'));
    }
    // HTML Converts Attribute Names to Lowercase, so they Need to Be Written in Lowercase.
    public replaceStartTag(inputPlace: string, value: string, newValue: string): void {
        this.add('gt' + inputPlace, 's' + GS + value + GS + newValue);
    }

    // Pre Runner
    public assignDelay(miliSecond: number, index: number = -1): void {
        const currentLine = this.getLineByIndex(index);
        if (currentLine === null || currentLine === undefined || currentLine === '')
            return;

        const parts = currentLine.split('=');
        const parts0 = parts[0];
        const parts1 = parts.length > 1 ? currentLine.substring(parts0.length + 1) : '';
        const newName = ':' + miliSecond + ')' + parts0;
        const newValue = parts1;

        this.updateLineByIndex(index, newName, newValue);
    }

    public assignDelayChange(miliSecond: number, index: number = -1): void {
        const currentLine = this.getLineByIndex(index);
        if (currentLine === null || currentLine === undefined || currentLine === '')
            return;

        const parts = currentLine.split('=');
        let currentName = parts[0];
        const newValue = parts.length > 1 ? currentLine.substring(currentName.length + 1) : '';

        if (currentName.startsWith(':') && currentName.includes(')')) {
            const closingBracket = currentName.indexOf(')');
            currentName = currentName.substring(closingBracket + 1);
        }

        const newName = ':' + miliSecond + ')' + currentName;

        this.updateLineByIndex(index, newName, newValue);
    }

    public assignInterval(miliSecond: number, id: string | null = null, index: number = -1): void {
        const currentLine = this.getLineByIndex(index);
        if (currentLine === null || currentLine === undefined || currentLine === '')
            return;

        const parts = currentLine.split('=');
        const parts0 = parts[0];
        const newValue = parts.length > 1 ? currentLine.substring(parts0.length + 1) : '';
        const newName = '(' + miliSecond + (id !== null && id !== undefined && id !== '' ? '|' + id : '') + ')' + parts0;

        this.updateLineByIndex(index, newName, newValue);
    }

    public assignIntervalChange(miliSecond: number, id: string | null = null, index: number = -1): void {
        const currentLine = this.getLineByIndex(index);
        if (currentLine === null || currentLine === undefined || currentLine === '')
            return;

        const parts = currentLine.split('=');
        let currentName = parts[0];
        const newValue = parts.length > 1 ? currentLine.substring(currentName.length + 1) : '';

        if (currentName.startsWith('(') && currentName.includes(')')) {
            const closingBracket = currentName.indexOf(')');
            currentName = currentName.substring(closingBracket + 1);
        }

        const newName = '(' + miliSecond + (id !== null && id !== undefined && id !== '' ? '|' + id : '') + ')' + currentName;

        this.updateLineByIndex(index, newName, newValue);
    }

    public deleteInterval(id: string): void { this.add('Di', id); }

    public assignRepeat(count: number, index: number = -1): void {
        const currentLine = this.getLineByIndex(index);
        if (currentLine === null || currentLine === undefined || currentLine === '')
            return;

        const parts = currentLine.split('=');
        const parts0 = parts[0];
        const newValue = parts.length > 1 ? currentLine.substring(parts0.length + 1) : '';
        const newName = ',' + count + ')' + parts0;

        this.updateLineByIndex(index, newName, newValue);
    }

    public assignRepeatChange(count: number, index: number = -1): void {
        const currentLine = this.getLineByIndex(index);
        if (currentLine === null || currentLine === undefined || currentLine === '')
            return;

        const parts = currentLine.split('=');
        let currentName = parts[0];
        const newValue = parts.length > 1 ? currentLine.substring(currentName.length + 1) : '';

        if (currentName.startsWith(',') && currentName.includes(')')) {
            const closingBracket = currentName.indexOf(')');
            currentName = currentName.substring(closingBracket + 1);
        }

        const newName = ',' + count + ')' + currentName;

        this.updateLineByIndex(index, newName, newValue);
    }

    // Index
    public startIndex(name: string = ''): void { this.add('#', name); }
    // This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
    public startState(): void { this.startIndex('$'); }
    public goTo(line: string, repeat: string): void;
    public goTo(line: number, repeat?: number): void;
    public goTo(index: string, repeat?: number): void;
    public goTo(a: string | number, b?: string | number): void {
        if (typeof a === 'number') {
            const repeat = b === undefined ? '1' : (b as number).toString();
            this.add('&', a.toString() + GS + repeat);
        } else if (typeof b === 'string') {
            this.add('&', a + GS + b);
        } else {
            const repeat = b === undefined ? '1' : (b as number).toString();
            this.add('&', '#' + a + GS + repeat);
        }
    }

    // Start
    public startTransientDOM(inputPlace: string): void { this.add('td', inputPlace); }
    public endTransientDOM(): void { this.add('td', ';'); }

    // Message
    // Type: warning, problem, help, success, none
    public alert(text: string, type: string = 'none', title: string = 'Alert', okText: string = 'OK'): void {
        this.add('Al', text + GS + (type === 'none' ? '' : type) + GS + (title === 'Alert' ? '' : title) + GS + (okText === 'OK' ? '' : okText));
    }
    public message(text: string, typeOrDuration?: string | number, duration?: string | number): void {
        let type: string;
        let dur: string;

        if (typeof typeOrDuration === 'number') {
            type = '';
            dur = typeOrDuration.toString();
        } else {
            type = typeOrDuration !== undefined ? typeOrDuration : 'none';
            dur = duration !== undefined
                ? (typeof duration === 'number' ? duration.toString() : duration)
                : '0';
        }

        this.add('me', text + GS + (type === 'none' ? '' : type) + GS + (dur === '0' ? '' : dur));
    }

    // Type: log, info, warn, error, debug, trace, group, groupend, table
    public consoleMessage(text: string, type: string = 'log'): void {
        this.add('mc', text.split('\n').join('$[ln];') + (type === 'log' ? '' : GS + type));
    }
    public consoleMessageAssert(text: string, condition: string): void {
        this.add('ma', text.split('\n').join('$[ln];') + GS + condition);
    }

    // Enable
    // Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
    public enableWebSocket(enable: boolean = true): void { this.add('ew', enable ? '1' : '0'); }
    public enableWebSocketOnce(): void { this.add('ew', '$'); }
    public addWebSocket(path: string): void { this.add('aw' + path); }
    // Disconnected WebSocket
    public deleteWebSocket(path: string): void { this.add('dw' + path); }

    // Use
    // InputPlace Using Only For form Element
    public useWebSocket(inputPlace: string): void { this.add('uw' + inputPlace); }
    public useOnlyChangeUpdate(inputPlace: string): void { this.add('uo' + inputPlace); }

    // Condition And Loop
    // Condition And Loop Supports Brackets and Then
    // Type: warning, problem, help, success, none
    // Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
    // Nested Conditions and Nested Loops are Possible.
    public confirmIsTrueAccept(text: string = 'Are you sure you want to proceed?', type: string = 'none', title: string = 'Confirm', okText: string = 'OK', cancelText: string = 'Cancel', interval: number = 100): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'ct', (text === 'Are you sure you want to proceed?' ? '' : text) + GS + (type === 'none' ? '' : type) + GS + (title === 'Confirm' ? '' : title) + GS + (okText === 'OK' ? '' : okText) + GS + (cancelText === 'Cancel' ? '' : cancelText));
        return this;
    }
    public confirmIsFalseAccept(text: string = 'Are you sure you want to proceed?', type: string = 'none', title: string = 'Confirm', okText: string = 'OK', cancelText: string = 'Cancel', interval: number = 100): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'cf', (text === 'Are you sure you want to proceed?' ? '' : text) + GS + (type === 'none' ? '' : type) + GS + (title === 'Confirm' ? '' : title) + GS + (okText === 'OK' ? '' : okText) + GS + (cancelText === 'Cancel' ? '' : cancelText));
        return this;
    }
    public isGreaterThan(firstValue: string, secondValue: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'gt', firstValue + GS + secondValue);
        return this;
    }
    public isLessThan(firstValue: string, secondValue: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'lt', firstValue + GS + secondValue);
        return this;
    }
    public isEqualTo(firstValue: string, secondValue: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'et', firstValue + GS + secondValue);
        return this;
    }
    public isNotEqualTo(firstValue: string, secondValue: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'Nt', firstValue + GS + secondValue);
        return this;
    }
    public exist(value: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'ex', value);
        return this;
    }
    public notExist(value: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'nx', value);
        return this;
    }
    public isTrue(value: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'tr', value);
        return this;
    }
    public isFalse(value: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'fa', value);
        return this;
    }
    public isMatchMedia(value: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'mm', value);
        return this;
    }
    public isNotMatchMedia(value: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'nm', value);
        return this;
    }
    public include(text: string, value: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'In', value + GS + text);
        return this;
    }
    public notInclude(text: string, value: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'Nn', value + GS + text);
        return this;
    }
    public elementExists(inputPlace: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'eE', inputPlace);
        return this;
    }
    public elementNotExists(inputPlace: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'nE', inputPlace);
        return this;
    }
    public isRegexMatch(value: string, pattern: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 're', value + GS + pattern);
        return this;
    }
    public isRegexNotMatch(value: string, pattern: string, interval: number = -1): WebForms {
        this.add((interval >= 0 ? '{(' + interval + ')' : '{') + 'rn', value + GS + pattern);
        return this;
    }
    // In: Everything Becomes A JSON List.
    // Key: Creates A Temporary Data In The Browser IndexedDB.
    // Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
    public forEach(path: string, inValue: string, key: string = '.'): WebForms {
        this.add('{fe', path + GS + inValue + GS + key);
        return this;
    }
    public break(): void { this.add(';'); }
    public else(): WebForms {
        this.add('}e');
        return this;
    }
    public startBracket(): void { this.add('{'); }
    public endBracket(): void { this.add('}'); }
    // Used Then In Condition And Loop Methods
    public then(newForm: WebForms): WebForms;
    public then(configure: (form: WebForms) => void): WebForms;
    public then(arg: WebForms | ((form: WebForms) => void)): WebForms {
        let newForm: WebForms;

        if (arg instanceof WebForms) {
            newForm = arg;
        } else {
            newForm = new WebForms();
            arg(newForm);
        }

        const data = newForm?.getWebFormsData();

        if (data !== null && data !== undefined && data !== '') {
            if (data.includes('\n')) {
                newForm.addToUp('{');
                newForm.add('}');
            }
        }

        this.appendForm(newForm);
        return this;
    }

    public repeat(newForm: WebForms, repeatCount: number, index?: string): WebForms;
    public repeat(configure: (form: WebForms) => void, repeatCount: number, index?: string): WebForms;
    public repeat(arg: WebForms | ((form: WebForms) => void), repeatCount: number, index?: string): WebForms {
        let newForm: WebForms;

        if (arg instanceof WebForms) {
            newForm = arg;
        } else {
            newForm = new WebForms();
            arg(newForm);
        }

        if (newForm == null)
            return this;

        if (index === undefined) {
            const bodyData = newForm.getWebFormsData();

            if (bodyData === null || bodyData === undefined || bodyData === '')
                return this;

            const startLine = -1 * bodyData.split('\n').length;

            this.appendForm(newForm);
            this.goTo(startLine, repeatCount - 1);
        } else {
            this.goTo(index);
            this.startIndex(index);

            const bodyData = newForm.getWebFormsData();

            if (bodyData === null || bodyData === undefined || bodyData === '')
                return this;

            this.appendForm(newForm);

            if (index === '') {
                let indexNumber = -1;

                for (const x of this.getWebFormsData().split('\n')) {
                    if (x.startsWith('#'))
                        indexNumber++;
                }

                this.goTo(indexNumber.toString(), repeatCount - 1);
            } else {
                this.goTo(index, repeatCount - 1);
            }
        }

        return this;
    }

    // Async
    // It Supports Brackets and Then
    public async(): WebForms {
        this.add('{(a)');
        return this;
    }
    public delay(miliSecond: string | number): void {
        const ms = typeof miliSecond === 'number' ? miliSecond.toString() : miliSecond;
        this.add('De', ms);
    }

    // Option
    public changeOption(name: string, value: string): void { this.add('co', name + GS + value); }
    public resetOption(name?: string): void {
        if (name !== undefined)
            this.add('ro', name);
        else
            this.add('ro');
    }

    // Format Storage
    public createFormatStorage(key: string, data: string): void { this.add('.C', key + GS + data); }
    public deleteFormatStorage(key: string): void { this.add('.D', key); }
    public addJSON(key: string, path: string, value: string): void { this.add('.a', key + GS + 'j' + GS + value + GS + path); }
    // Name: For Support Attribute, Set Double At Sign (@@) Before Name.
    public addXML(key: string, path: string, name: string, value?: string | null): void {
        this.add('.a', key + GS + 'x' + GS + name + GS + safe(value) + GS + path);
    }
    public addINI(key: string, path: string, value: string, isINILike: boolean = false): void {
        this.add('.a', key + GS + 'i' + GS + (isINILike ? '1' : '0') + GS + value + GS + path);
    }
    public addTextLine(key: string, line: string | number, text: string): void {
        const lineStr = typeof line === 'number' ? line.toString() : line;
        this.add('.a', key + GS + 't' + GS + text + GS + lineStr);
    }
    public addVariable(key: string, value: string): void { this.add('.a', key + GS + 'v' + GS + value); }
    public updateJSON(key: string, path: string, value: string): void { this.add('.u', key + GS + 'j' + GS + value + GS + path); }
    public updateXML(key: string, path: string, value: string): void { this.add('.u', key + GS + 'x' + GS + value + GS + path); }
    public updateINI(key: string, path: string, value: string, isINILike: boolean = false): void {
        this.add('.u', key + GS + 'i' + GS + (isINILike ? '1' : '0') + GS + value + GS + path);
    }
    public updateTexLine(key: string, line: string | number, text: string): void {
        const lineStr = typeof line === 'number' ? line.toString() : line;
        this.add('.u', key + GS + 't' + GS + text + GS + lineStr);
    }
    public updateVariable(key: string, value: string): void { this.add('.u', key + GS + 'v' + GS + value); }
    public increaseVariable(key: string, value: string | number): void {
        const v = typeof value === 'number' ? value.toString() : value;
        this.add('.i', key + GS + 'v' + GS + v);
    }
    public decreaseVariable(key: string, value: number): void { this.increaseVariable(key, value * -1); }
    public deleteJSON(key: string, path: string): void { this.add('.d', key + GS + 'j' + GS + path); }
    public deleteXML(key: string, path: string): void { this.add('.d', key + GS + 'x' + GS + path); }
    public deleteINI(key: string, path: string, isINILike: boolean = false): void {
        this.add('.d', key + GS + 'i' + GS + (isINILike ? '1' : '0') + GS + path);
    }
    public deleteTextLine(key: string, line: string | number): void {
        const lineStr = typeof line === 'number' ? line.toString() : line;
        this.add('.d', key + GS + 't' + GS + lineStr);
    }
    public deleteVariable(key: string): void { this.add('.d', key + GS + 'v'); }

    // Template Engine
    // Pattern Example: {{value}}, ((value)), *value*, $value;
    public bindJSONToTemplate(inputPlace: string, jsonText: string, path: string, pattern: string, alsoStartTag: boolean = true): void {
        this.add('Tj' + inputPlace, jsonText + GS + path + GS + pattern + GS + (alsoStartTag ? '1' : '0'));
    }
    // Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
    public bindXMLToTemplate(inputPlace: string, xmlText: string, path: string, pattern: string, alsoStartTag: boolean = true): void {
        this.add('Tx' + inputPlace, xmlText + GS + path + GS + pattern + GS + (alsoStartTag ? '1' : '0'));
    }
    public bindINIToTemplate(inputPlace: string, iniText: string, path: string, pattern: string, alsoStartTag: boolean = true): void {
        this.add('Ti' + inputPlace, iniText + GS + path + GS + pattern + GS + (alsoStartTag ? '1' : '0'));
    }

    // Inject
    // Need Add @: to First of String
    public inject(value: string): string { return '$[' + value + '];'; }

    // Action Control
    public replaceActionControl(searchValue: string, value: string, addingToUp: boolean = false): void {
        if (addingToUp)
            this.addToUp('rE', searchValue + GS + value);
        else
            this.add('rE', searchValue + GS + value);
    }

    public assignReplace(searchValue: string, value: string, index: number = -1): void {
        const currentLine = this.getLineByIndex(index);
        if (currentLine === null || currentLine === undefined || currentLine === '')
            return;

        const parts = currentLine.split('=');
        const parts0 = parts[0];
        const newValue = parts.length > 1 ? currentLine.substring(parts0.length + 1) : '';
        const newName = ';' + searchValue + GS + value + GS + parts0;

        this.updateLineByIndex(index, newName, newValue);
    }

    // Hash And Checksum
    public setHash(): void { this.add('SH'); }
    public setChecksum(): void { this.add('CS'); }

    public checksumCalculation(text: string): string {
        let sum = 0;
        const mod = 65536;
        const shift = 5;

        for (let i = 0; i < text.length; i++) {
            const c = text.charCodeAt(i);
            sum = ((sum << shift) | (sum >>> (16 - shift))) ^ c;
            sum %= mod;
        }

        return sum.toString();
    }

    public getChecksum(): string { return this.checksumCalculation(this.getWebFormsData()); }

    // Get
    public getFormsActionData(): string {
        if (this.webFormsData.length === 0)
            return '';

        return this.webFormsData;
    }

    public response(): string {
        return '[web-forms]\n' + this.getFormsActionData();
    }

    public getFormsActionDataLineBreak(): string {
        if (this.webFormsData.length === 0)
            return '';

        const data = this.webFormsData;
        const processedData = data.split('"').join('$[dq];');
        return processedData.split('\n').join('$[sln];');
    }

    // Export
    public exportToHtmlComment(addLine: boolean = false): string {
        let response = this.response().split('--').join('$[dd];');
        if (response.charAt(response.length - 1) === '-')
            response = response.substring(0, response.length - 1) + '$[da];';

        return (addLine ? '\n' : '') + '<!--' + response + '-->';
    }

    // Using it for SSE Response
    public exportToLineBreak(src: string | null = null): string {
        return '[web-forms]$[sln];' + this.getFormsActionDataLineBreak();
    }

    public getWebFormsData(): string {
        return this.webFormsData;
    }

    public appendForm(form: WebForms): void {
        if (form == null)
            return;

        const otherData = form.getWebFormsData();
        if (otherData !== null && otherData !== undefined && otherData !== '') {
            if (this.webFormsData.length > 0)
                this.webFormsData += '\n';
            this.webFormsData += otherData;
        }
    }

    public clean(): void {
        this.webFormsData = '';
    }
}

export class Security {
    public safeValue(value: string): string {
        if (value.length < 1)
            return value;

        if (value[0] === '@')
            value = '@' + value;

        value = value
            .split('\n').join('$[ln];')
            .split(',@').join('$[co];@')
            .split(String.fromCharCode(28)).join('\0')
            .split(String.fromCharCode(29)).join('\0')
            .split(String.fromCharCode(30)).join('\0')
            .split(String.fromCharCode(31)).join('\0');

        return value;
    }
}

// WebForms Place Criteria (WPC) DSL
export class InputPlace {
    public static readonly Document = ',';
    public static readonly Window = '`';
    // When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
    public static readonly Root = '~';
    public static readonly HTML = '.';
    public static readonly Head = '^';
    public static readonly ScreenOrientation = '%';
    public static readonly All = '*';
    public static readonly Parent = '/';
    public static readonly Current = '$';
    public static readonly Target = '!';
    public static readonly Upper = '-';

    public static id(id: string): string { return id; }

    public static name(name: string, index?: number): string {
        if (index !== undefined)
            return '(' + name + ')' + index;
        return '(' + name + ')';
    }

    public static allNames(name: string): string { return '(' + name + ')*'; }

    public static tag(tag: string, index?: number): string {
        if (index !== undefined)
            return '<' + tag + '>' + index;
        return '<' + tag + '>';
    }

    public static allTags(tag: string): string { return '<' + tag + '>*'; }

    public static child(index?: number): string {
        if (index !== undefined)
            return '<>' + index;
        return '<>';
    }

    public static allChild(): string { return '<>*'; }

    public static class(className: string, index?: number): string {
        if (index !== undefined)
            return '{' + className + '}' + index;
        return '{' + className + '}';
    }

    public static allClasses(className: string): string { return '{' + className + '}*'; }

    // Operator: '^', '$', '*', '~'
    public static attribute(name: string): string;
    public static attribute(name: string, index: number): string;
    public static attribute(name: string, value: string, operator?: string): string;
    public static attribute(name: string, value: string, index: number, operator?: string): string;
    public static attribute(name: string, arg2?: string | number, arg3?: string | number, arg4?: string): string {
        if (arg2 === undefined) {
            return '"' + name + '"';
        }

        if (typeof arg2 === 'number') {
            return '"' + name + '"' + arg2.toString();
        }

        const value = arg2;

        if (arg3 === undefined) {
            return '"' + name + "'" + value + '"';
        }

        if (typeof arg3 === 'number') {
            const index = arg3;
            const op = (arg4 !== undefined && arg4 !== null && arg4 !== '' && arg4 !== '\0') ? arg4 : '';
            return '"' + name + op + "'" + value + '"' + index.toString();
        }

        const op = (arg3 !== undefined && arg3 !== null && arg3 !== '' && arg3 !== '\0') ? arg3 : '';
        return '"' + name + op + "'" + value + '"';
    }

    public static allAttributes(name: string, value?: string, operator?: string): string {
        if (value !== undefined) {
            const op = (operator !== undefined && operator !== null && operator !== '' && operator !== '\0') ? operator : '';
            return '"' + name + op + "'" + value + '"*';
        }
        return '"' + name + '"*';
    }

    public static query(query: string): string {
        return '*' + query.split('=').join('$[eq];').split('|').join('$[vb];').split('?').join('$[qu];');
    }

    public static queryAll(query: string): string {
        return '[' + query.split('=').join('$[eq];').split('|').join('$[vb];').split('?').join('$[qu];');
    }
}

export class OutputPlace extends InputPlace { }

// Do not Add any Data Before or After it
export class Fetch {
    private static readonly RS = String.fromCharCode(30);
    private static readonly US = String.fromCharCode(31);

    // Method
    public static random(maxValue: number): string { return '@mr' + maxValue.toString(); }
    public static randomWithMin(minValue: number, maxValue: number): string {
        return '@mr' + maxValue.toString() + this.RS + minValue.toString();
    }
    public static spaceToChar(text: string, character: string = '-'): string {
        return '@sc' + character + this.RS + text;
    }
    public static encodeURI(text: string): string { return '@ue' + text; }
    public static decodeURI(text: string): string { return '@ud' + text; }

    public static method(methodName: string, args: (string | number | boolean)[] | null = null): string {
        let returnValue = '@cm' + methodName;

        if (args !== null)
            returnValue += args.length > 0 ? this.RS + args.join(this.US) : '';

        return returnValue;
    }

    public static moduleMethod(methodName: string, args: (string | number | boolean)[] | null = null): string {
        let returnValue = '@cM' + methodName;

        if (args !== null)
            returnValue += args.length > 0 ? this.RS + args.join(this.US) : '';

        return returnValue;
    }

    // MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
    public static wasmMethod(wasmLanguage: string, wasmUrl: string, methodName: string, args: (string | number | boolean)[] | null = null, key: string = '.'): string {
        let returnValue = '@wA' + wasmLanguage + this.RS + wasmUrl + this.RS + methodName;

        if (args !== null)
            returnValue += args.length > 0 ? this.RS + args.join(this.US) : '';

        return returnValue;
    }

    public static script(scriptText: string): string {
        return '@_' + scriptText.split('\n').join('$[ln];');
    }
    public static loadUrl(url: string, fetchScript: boolean = false): string {
        return '@lu' + url + (fetchScript ? this.RS + '1' : '');
    }
    public static loadHtml(url: string, fetchInputPlace: string = '', fetchScript: boolean = false): string {
        return '@lh' + url + this.RS + (fetchScript ? '1' : '0') + (fetchInputPlace !== null && fetchInputPlace !== undefined && fetchInputPlace !== '' ? this.RS + fetchInputPlace : '');
    }
    public static loadLine(url: string, line: number): string {
        return '@ll' + url + this.RS + line.toString();
    }
    public static loadINI(url: string, name: string, isINILike: boolean = false): string {
        return '@li' + url + this.RS + name + (isINILike ? this.RS + '1' : '');
    }
    // Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
    public static loadJSON(url: string, name: string): string {
        return '@lj' + url + this.RS + name;
    }
    // Name: Name Or XPath; XPath Index Starts At 1
    public static loadXML(url: string, name: string): string {
        return '@lx' + url + this.RS + name;
    }
    // MethodName: It's Check Function Or Variable
    public static hasMethod(methodName: string): string { return '@hm' + methodName; }
    public static hasModuleMethod(methodName: string): string { return '@hM' + methodName; }
    // This Method Return True Or False If Key Pressed
    // Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
    public static getModifierState(modifier: string): string { return '@ms' + modifier; }

    // Math
    public static math(methodName: string, args: (string | number | boolean)[] | null = null): string {
        let returnValue = '@M#' + methodName;

        if (args !== null)
            returnValue += args.length > 0 ? this.RS + args.join(this.US) : '';

        return returnValue;
    }

    // Data
    public static readonly DateYear = '@dy';
    // Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1 
    public static readonly DateMonth = '@dm';
    public static readonly DateDay = '@dd';
    public static readonly DateDate = '@dD';
    public static readonly DateHours = '@dh';
    public static readonly DateMinutes = '@di';
    public static readonly DateSeconds = '@ds';
    public static readonly DateMilliseconds = '@dl';

    // String
    public static readonly Space = '@sp';
    public static readonly AtSign = '@sa';

    // Tag
    public static getId(inputPlace: string): string { return '@$i' + inputPlace; }
    public static getName(inputPlace: string): string { return '@$n' + inputPlace; }
    public static getValue(inputPlace: string): string { return '@$v' + inputPlace; }
    public static getValueLength(inputPlace: string): string { return '@$e' + inputPlace; }
    public static getClass(inputPlace: string): string { return '@$c' + inputPlace; }
    public static getStyle(inputPlace: string): string { return '@$s' + inputPlace; }
    public static getTitle(inputPlace: string): string { return '@$l' + inputPlace; }
    public static getLabel(inputPlace: string): string { return '@$A' + inputPlace; }
    public static getText(inputPlace: string): string { return '@$t' + inputPlace; }
    public static getOuterText(inputPlace: string): string { return '@$o' + inputPlace; }
    public static getTextLength(inputPlace: string): string { return '@$g' + inputPlace; }
    public static getAttribute(inputPlace: string, attribute: string): string {
        return '@$a' + inputPlace + this.RS + attribute;
    }
    public static getWidth(inputPlace: string): string { return '@$w' + inputPlace; }
    public static getHeight(inputPlace: string): string { return '@$h' + inputPlace; }
    public static getIsReadOnly(inputPlace: string): string { return '@$r' + inputPlace; }
    public static getSelectedIndex(inputPlace: string): string { return '@$x' + inputPlace; }
    public static getIndex(inputPlace: string): string { return '@$I' + inputPlace; }
    public static getTextAlign(inputPlace: string): string { return '@$T' + inputPlace; }
    public static getNodeLength(inputPlace: string): string { return '@$L' + inputPlace; }
    public static getIsVisible(inputPlace: string): string { return '@$V' + inputPlace; }

    // Save
    public static hasHash(hash: string): string { return '@HH' + hash; }
    public static cookie(key: string): string { return '@co' + key; }
    public static save(key: string = '.'): string { return '@cs' + key; }
    public static saveWithReplace(key: string, replaceValue: string): string {
        return '@cs' + key + this.RS + replaceValue;
    }
    public static saveThenRemove(key: string): string { return '@cl' + key; }
    public static saveLength(key: string = '.'): string { return '@cg' + key; }
    public static cache(key: string = '.'): string { return '@cd' + key; }
    public static cacheWithReplace(key: string, replaceValue: string): string {
        return '@cd' + key + this.RS + replaceValue;
    }
    public static cacheThenRemove(key: string): string { return '@ct' + key; }
    public static cacheLength(key: string = '.'): string { return '@cG' + key; }
    public static saveLine(key: string = '.', line: number = 0): string {
        return '@lL' + key + '[' + line.toString();
    }
    public static saveLineConsume(key: string = '.'): string { return '@lL' + key; }
    // INIKey: Only Direct Key is Supported
    public static saveINI(key: string, iniKey: string): string {
        return '@lI' + key + '[' + iniKey;
    }
    public static cacheLine(key: string = '.', line: number = 0): string {
        return '@dL' + key + '[' + line.toString();
    }
    public static cacheLineConsume(key: string = '.'): string { return '@dL' + key; }
    // INIKey: Only Direct Key is Supported
    public static cacheINI(key: string, iniKey: string): string {
        return '@dI' + key + '[' + iniKey;
    }

    // Format Storage
    public static formatStore(key: string): string { return '@fr' + key; }
    public static formatStoreByXMLQuery(key: string, xpath: string): string {
        return '@fx' + key + this.RS + xpath;
    }
    public static formatStoreByJSONQuery(key: string, query: string): string {
        return '@fj' + key + this.RS + query;
    }
    public static formatStoreByINI(key: string, name: string): string {
        return '@fi' + key + this.RS + name;
    }
    public static formatStoreByText(key: string, line: number): string {
        return '@ft' + key + this.RS + line.toString();
    }
    public static formatStoreByVariable(key: string): string { return '@fv' + key; }

    // State
    public static hasState(path: string): string { return '@hs' + path; }

    // SSE
    public static sseIsConnected(path: string): string { return '@Sc' + path; }

    // WebSockets
    public static webSocketsIsConnected(path: string = ''): string { return '@Wc' + path; }

    // Document
    public static readonly TabIsActive = '@da';

    // Window
    public static readonly Href = '@wf';
    public static readonly PathName = '@wP';
    public static query(name: string = '*'): string { return '@wq' + name; }
    public static readonly Hash = '@wh';
    public static readonly Host = '@wH';
    public static readonly HostName = '@wn';
    public static readonly Port = '@wT';
    public static readonly Origin = '@wo';
    public static readonly GetSelection = '@ws';
    public static readonly ScrollX = '@wx';
    public static readonly ScrollY = '@wy';
    public static segment(index: number): string { return '@wS' + index.toString(); }
    // It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
    public static hashSegment(index: number): string { return '@wt' + index.toString(); }

    // Navigator
    public static readonly ClipboardText = '@nC';
    public static readonly GeoLatitude = '@nW';
    public static readonly GeoLongitude = '@nO';
    public static readonly Language = '@nL';
    public static readonly IsOnLine = '@no';
    public static readonly UserAgent = '@na';

    // Screen
    public static readonly ScreenWidth = '@sw';
    public static readonly ScreenHeight = '@sh';
    public static readonly ScreenOrientationType = '@so';
    public static readonly ScreenOrientationAngle = '@sr';

    // Performance
    public static readonly TimeOrigin = '@pt';
    public static readonly PerformanceNow = '@pn';

    // Event
    public static readonly Event = '@EV';
    public static readonly EventSerialize = '@Es';
    public static readonly EventKey = '@ek';
    public static readonly EventWhich = '@ew';
    public static readonly EventClientX = '@ex';
    public static readonly EventClientY = '@ey';
    public static readonly EventPageX = '@eX';
    public static readonly EventPageY = '@eY';
    public static readonly EventOffsetX = '@Ex';
    public static readonly EventOffsetY = '@Ey';
    public static readonly EventDeltaY = '@ed';
}

export class WasmLanguage {
    // The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
    public static readonly C = 'c';
    public static readonly CPP = 'c';
    public static readonly Rust = 'rust';
    public static readonly CSharp = 'csharp';
    // .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
    public static readonly CSharpMediator = 'csharp-m';
    public static readonly GO = 'go';
    public static readonly JAVA = 'java';
    public static readonly AssemblyScript = 'as';
}

export class HtmlEvent {
    public static readonly OnAbort = 'onabort';
    public static readonly OnAfterPrint = 'onafterprint';
    public static readonly OnBeforePrint = 'onbeforeprint';
    public static readonly OnBeforeUnload = 'onbeforeunload';
    public static readonly OnBlur = 'onblur';
    public static readonly OnCanPlay = 'oncanplay';
    public static readonly OnCanPlayThrough = 'oncanplaythrough';
    public static readonly OnChange = 'onchange';
    public static readonly OnClick = 'onclick';
    public static readonly OnCopy = 'oncopy';
    public static readonly OnCut = 'oncut';
    public static readonly OnDoubleClick = 'ondblclick';
    public static readonly OnDrag = 'ondrag';
    public static readonly OnDragEnd = 'ondragend';
    public static readonly OnDragEnter = 'ondragenter';
    public static readonly OnDragLeave = 'ondragleave';
    public static readonly OnDragOver = 'ondragover';
    public static readonly OnDragStart = 'ondragstart';
    public static readonly OnDrop = 'ondrop';
    public static readonly OnDurationChange = 'ondurationchange';
    public static readonly OnEnded = 'onended';
    public static readonly OnError = 'onerror';
    public static readonly OnFocus = 'onfocus';
    public static readonly OnFocusin = 'onfocusin';
    public static readonly OnFocusOut = 'onfocusout';
    public static readonly OnHashChange = 'onhashchange';
    public static readonly OnInput = 'oninput';
    public static readonly OnInvalid = 'oninvalid';
    public static readonly OnKeyDown = 'onkeydown';
    public static readonly OnKeyPress = 'onkeypress';
    public static readonly OnKeyUp = 'onkeyup';
    public static readonly OnLoad = 'onload';
    public static readonly OnLoadedData = 'onloadeddata';
    public static readonly OnLoadedMetaData = 'onloadedmetadata';
    public static readonly OnLoadStart = 'onloadstart';
    public static readonly OnMouseDown = 'onmousedown';
    public static readonly OnMouseEnter = 'onmouseenter';
    public static readonly OnMouseLeave = 'onmouseleave';
    public static readonly OnMouseMove = 'onmousemove';
    public static readonly OnMouseOver = 'onmouseover';
    public static readonly OnMouseOut = 'onmouseout';
    public static readonly OnMouseUp = 'onmouseup';
    public static readonly OnOffline = 'onoffline';
    public static readonly OnOnline = 'ononline';
    public static readonly OnPageHide = 'onpagehide';
    public static readonly OnPageShow = 'onpageshow';
    public static readonly OnPaste = 'onpaste';
    public static readonly OnPause = 'onpause';
    public static readonly OnPlay = 'onplay';
    public static readonly OnPlaying = 'onplaying';
    public static readonly OnProgress = 'onprogress';
    public static readonly OnRateChange = 'onratechange';
    public static readonly OnResize = 'onresize';
    public static readonly OnReset = 'onreset';
    public static readonly OnScroll = 'onscroll';
    public static readonly OnSearch = 'onsearch';
    public static readonly OnSeeked = 'onseeked';
    public static readonly OnSeeking = 'onseeking';
    public static readonly OnSelect = 'onselect';
    public static readonly OnStalled = 'onstalled';
    public static readonly OnSubmit = 'onsubmit';
    public static readonly OnSuspend = 'onsuspend';
    public static readonly OnTimeUpdate = 'ontimeupdate';
    public static readonly OnToggle = 'ontoggle';
    public static readonly OnTouchCancel = 'ontouchcancel';
    public static readonly OnTouchend = 'ontouchend';
    public static readonly OnTouchMove = 'ontouchmove';
    public static readonly OnTouchStart = 'ontouchstart';
    public static readonly OnUnload = 'onunload';
    public static readonly OnVolumeChange = 'onvolumechange';
    public static readonly OnWaiting = 'onwaiting';
    public static readonly OnWheel = 'onwheel';
}

export class HtmlEventListener {
    public static readonly Abort = 'abort';
    public static readonly AfterPrint = 'afterprint';
    public static readonly BeforePrint = 'beforeprint';
    public static readonly BeforeUnload = 'beforeunload';
    public static readonly Blur = 'blur';
    public static readonly CanPlay = 'canplay';
    public static readonly CanPlayThrough = 'canplaythrough';
    public static readonly Change = 'change';
    public static readonly Click = 'click';
    public static readonly Copy = 'copy';
    public static readonly Cut = 'cut';
    public static readonly DoubleClick = 'dblclick';
    public static readonly Drag = 'drag';
    public static readonly DragEnd = 'dragend';
    public static readonly DragEnter = 'dragenter';
    public static readonly DragLeave = 'dragleave';
    public static readonly DragOver = 'dragover';
    public static readonly DragStart = 'dragstart';
    public static readonly Drop = 'drop';
    public static readonly DurationChange = 'durationchange';
    public static readonly Ended = 'ended';
    public static readonly Error = 'error';
    public static readonly Focus = 'focus';
    public static readonly Focusin = 'focusin';
    public static readonly FocusOut = 'focusout';
    public static readonly HashChange = 'hashchange';
    public static readonly Input = 'input';
    public static readonly Invalid = 'invalid';
    public static readonly KeyDown = 'keydown';
    public static readonly KeyPress = 'keypress';
    public static readonly KeyUp = 'keyup';
    public static readonly Load = 'load';
    public static readonly LoadedData = 'loadeddata';
    public static readonly LoadedMetaData = 'loadedmetadata';
    public static readonly LoadStart = 'loadstart';
    public static readonly MouseDown = 'mousedown';
    public static readonly MouseEnter = 'mouseenter';
    public static readonly MouseLeave = 'mouseleave';
    public static readonly MouseMove = 'mousemove';
    public static readonly MouseOver = 'mouseover';
    public static readonly MouseOut = 'mouseout';
    public static readonly MouseUp = 'mouseup';
    public static readonly Offline = 'offline';
    public static readonly Online = 'online';
    public static readonly PageHide = 'pagehide';
    public static readonly PageShow = 'pageshow';
    public static readonly Paste = 'paste';
    public static readonly Pause = 'pause';
    public static readonly Play = 'play';
    public static readonly Playing = 'playing';
    public static readonly Progress = 'progress';
    public static readonly RateChange = 'ratechange';
    public static readonly Resize = 'resize';
    public static readonly Reset = 'reset';
    public static readonly Scroll = 'scroll';
    public static readonly Search = 'search';
    public static readonly Seeked = 'seeked';
    public static readonly Seeking = 'seeking';
    public static readonly Select = 'select';
    public static readonly Stalled = 'stalled';
    public static readonly Submit = 'submit';
    public static readonly Suspend = 'suspend';
    public static readonly TimeUpdate = 'timeupdate';
    public static readonly Toggle = 'toggle';
    public static readonly TouchCancel = 'touchcancel';
    public static readonly Touchend = 'touchend';
    public static readonly TouchMove = 'touchmove';
    public static readonly TouchStart = 'touchstart';
    public static readonly Unload = 'unload';
    public static readonly VolumeChange = 'volumechange';
    public static readonly Waiting = 'waiting';
    public static readonly Wheel = 'wheel';

    public static readonly AnimationEnd = 'animationend';
    public static readonly AnimationIteration = 'animationiteration';
    public static readonly AnimationStart = 'animationstart';
    public static readonly ContextMenu = 'contextmenu';
    public static readonly FullScreenChange = 'fullscreenchange';
    public static readonly FullScreenError = 'fullscreenerror';
    public static readonly PopState = 'popstate';
    public static readonly TransitionEnd = 'transitionend';
    public static readonly Storage = 'storage';

    // Custom
    public static readonly ScrollBottom = 'scrollbottom'; // Need Call EnableScrollBottomEvent Method Before
    public static readonly ElementReached = 'elementreached'; // Need Call EnableReachedElementEvent Method Before
}

declare global {
    interface String {
        child(value: string): string;
        parent(): string;
        criteria(value: string): string;
        appendFetchReplace(searchValue: string, value: string): string;
        lineBreak(encodeLine?: boolean): string;
        toJSString(): string;
        toJSObject(): string;
        toJSReturnObject(): string;
    }
}

String.prototype.child = function (this: string, value: string): string {
    if (this.length < 1)
        return value;

    return this + '|' + value;
};

String.prototype.parent = function (this: string): string {
    if (this.length < 1)
        return this;

    if (this.endsWith('|/') || this.endsWith('//'))
        return this + '/';

    return this + '|/';
};

String.prototype.criteria = function (this: string, value: string): string {
    if (this.length < 1)
        return value;

    return this + '?' + value.split('|').join('$[vb];').split('?').join('$[qu];');
};

String.prototype.appendFetchReplace = function (this: string, searchValue: string, value: string): string {
    const FS = String.fromCharCode(28);

    let text = this.substring(1);
    return '@;' + searchValue + FS + value + FS + text;
};

String.prototype.lineBreak = function (this: string, encodeLine: boolean = false): string {
    const encode = encodeLine ? '$[sln];' : '';
    return this.split('\r\n').join(encode).split('\n').join(encode).split('\r').join(encode);
};

// Converts Numbers to Strings
String.prototype.toJSString = function (this: string): string {
    return '"' + this + '"';
};

// Get JS Object Momentary 
String.prototype.toJSObject = function (this: string): string {
    return '$' + this;
};

// Get JS Object Returned Value Once
String.prototype.toJSReturnObject = function (this: string): string {
    return '$@' + this;
};
