// WebForms.swift 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.1

import Foundation

class WebForms {
    private static let GS = "\u{1D}"
    private static let US = "\u{1F}"

    private var webFormsData = ""

    internal func add(_ name: String, _ value: String) {
        if !webFormsData.isEmpty {
            webFormsData.append("\n")
        }
        webFormsData.append(name)
        webFormsData.append("=")
        webFormsData.append(value)
    }

    internal func add(_ name: String) {
        if !webFormsData.isEmpty {
            webFormsData.append("\n")
        }
        webFormsData.append(name)
    }

    internal func addToUp(_ name: String, _ value: String) {
        var line = "\(name)=\(value)"
        if !webFormsData.isEmpty {
            line += "\n"
        }
        webFormsData = line + webFormsData
    }

    internal func addToUp(_ name: String) {
        var line = name
        if !webFormsData.isEmpty {
            line += "\n"
        }
        webFormsData = line + webFormsData
    }

    internal func getLineByIndex(_ index: Int) -> String {
        if webFormsData.isEmpty {
            return ""
        }
        let data = webFormsData
        let lines = data.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        var idx = index
        if idx < 0 {
            idx = lines.count + idx
        }
        if idx < 0 || idx >= lines.count {
            return ""
        }
        return lines[idx]
    }

    internal func updateLineByIndex(_ index: Int, _ name: String, _ value: String) {
        if webFormsData.isEmpty {
            return
        }
        let data = webFormsData
        var lines = data.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        var idx = index
        if idx < 0 {
            idx = lines.count + idx
        }
        if idx < 0 || idx >= lines.count {
            return
        }
        lines[idx] = name + (value.isEmpty ? "" : "=" + value)
        webFormsData = lines.joined(separator: "\n")
    }

    // For Extension
    public func addLine(_ name: String, _ value: String) { add(name, value) }

    // Add
    // Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.
    public func addId(_ inputPlace: String, _ id: String) { add("ai" + inputPlace, id) }
    public func addName(_ inputPlace: String, _ name: String) { add("an" + inputPlace, name) }
    public func addValue(_ inputPlace: String, _ value: String) { add("av" + inputPlace, value) }
    public func addClass(_ inputPlace: String, _ `class`: String) { add("ac" + inputPlace, `class`) }
    public func addStyle(_ inputPlace: String, _ style: String) { add("as" + inputPlace, style) }
    public func addStyle(_ inputPlace: String, _ name: String, _ value: String) { add("as" + inputPlace, name + ":" + value) }
    public func addOptionTag(_ inputPlace: String, _ text: String, _ value: String, _ selected: Bool = false) { add("ao" + inputPlace, value + WebForms.GS + text + (selected ? WebForms.GS + "1" : "")) }
    public func addCheckBoxTag(_ inputPlace: String, _ text: String, _ value: String, _ checked: Bool = false) { add("ak" + inputPlace, value + WebForms.GS + text + (checked ? WebForms.GS + "1" : "")) }
    public func addTitle(_ inputPlace: String, _ title: String) { add("al" + inputPlace, title) }
    public func addLabel(_ inputPlace: String, _ label: String) { add("aA" + inputPlace, label) }
    public func addText(_ inputPlace: String, _ text: String) { add("at" + inputPlace, text.replacingOccurrences(of: "\n", with: "$[ln];")) }
    public func addTextToUp(_ inputPlace: String, _ text: String) { add("pt" + inputPlace, text.replacingOccurrences(of: "\n", with: "$[ln];")) }
    public func addAttribute(_ inputPlace: String, _ attribute: String, _ value: String = "", _ splitter: Character = "\0") { add("aa" + inputPlace, attribute + WebForms.GS + (splitter != "\0" ? String(splitter) : "") + (!value.isEmpty ? WebForms.GS + value : "")) }
    public func addTag(_ inputPlace: String, _ tagName: String, _ id: String = "") { add("nt" + inputPlace, tagName + (!id.isEmpty ? WebForms.GS + id : "")) }
    public func addTagToUp(_ inputPlace: String, _ tagName: String, _ id: String = "") { add("ut" + inputPlace, tagName + (!id.isEmpty ? WebForms.GS + id : "")) }
    public func addTagBefore(_ inputPlace: String, _ tagName: String, _ id: String = "") { add("bt" + inputPlace, tagName + (!id.isEmpty ? WebForms.GS + id : "")) }
    public func addTagAfter(_ inputPlace: String, _ tagName: String, _ id: String = "") { add("ft" + inputPlace, tagName + (!id.isEmpty ? WebForms.GS + id : "")) }
    public func addHidden(_ inputPlace: String, _ name: String, _ value: String, _ id: String = "") { add("ah" + inputPlace, name + WebForms.GS + value + (!id.isEmpty ? WebForms.GS + id : "")) }

    // Set
    // Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.
    public func setId(_ inputPlace: String, _ id: String) { add("si" + inputPlace, id) }
    public func setName(_ inputPlace: String, _ name: String) { add("sn" + inputPlace, name) }
    public func setValue(_ inputPlace: String, _ value: String) { add("sv" + inputPlace, value) }
    public func setClass(_ inputPlace: String, _ `class`: String) { add("sc" + inputPlace, `class`) }
    public func setStyle(_ inputPlace: String, _ style: String) { add("ss" + inputPlace, style) }
    public func setStyle(_ inputPlace: String, _ name: String, _ value: String) { add("ss" + inputPlace, name + ":" + value) }
    public func setOptionTag(_ inputPlace: String, _ text: String, _ value: String, _ selected: Bool = false) { add("so" + inputPlace, value + WebForms.GS + text + (selected ? WebForms.GS + "1" : "")) }
    public func setChecked(_ inputPlace: String, _ checked: Bool = false) { add("sk" + inputPlace, checked ? "1" : "0") }
    public func setCheckBoxTag(_ inputPlace: String, _ text: String, _ value: String, _ checked: Bool = false) { add("sk" + inputPlace, value + WebForms.GS + text + (checked ? WebForms.GS + "1" : "")) }
    public func setTitle(_ inputPlace: String, _ title: String) { add("sl" + inputPlace, title) }
    public func setLabel(_ inputPlace: String, _ label: String) { add("sA" + inputPlace, label) }
    public func setText(_ inputPlace: String, _ text: String) { add("st" + inputPlace, text.replacingOccurrences(of: "\n", with: "$[ln];")) }
    public func setAttribute(_ inputPlace: String, _ attribute: String, _ value: String = "") { add("sa" + inputPlace, attribute + WebForms.GS + (!value.isEmpty ? WebForms.GS + value : "")) }
    public func setWidth(_ inputPlace: String, _ width: String) { add("sw" + inputPlace, width) }
    public func setWidth(_ inputPlace: String, _ width: Int) { setWidth(inputPlace, String(width) + "px") }
    public func setHeight(_ inputPlace: String, _ height: String) { add("sh" + inputPlace, height) }
    public func setHeight(_ inputPlace: String, _ height: Int) { setHeight(inputPlace, String(height) + "px") }
    public func setBackgroundColor(_ inputPlace: String, _ color: String) { add("bc" + inputPlace, color) }
    public func setTextColor(_ inputPlace: String, _ color: String) { add("tc" + inputPlace, color) }
    public func setFontName(_ inputPlace: String, _ name: String) { add("fn" + inputPlace, name) }
    public func setFontSize(_ inputPlace: String, _ size: String) { add("fs" + inputPlace, size) }
    public func setFontSize(_ inputPlace: String, _ size: Int) { add("fs" + inputPlace, String(size) + "px") }
    public func setFontBold(_ inputPlace: String, _ bold: Bool) { add("fb" + inputPlace, bold ? "1" : "0") }
    public func setVisible(_ inputPlace: String, _ visible: Bool) { add("vi" + inputPlace, visible ? "1" : "0") }
    public func setTextAlign(_ inputPlace: String, _ align: String) { add("ta" + inputPlace, align) }
    public func setReadOnly(_ inputPlace: String, _ readOnly: Bool) { add("sr" + inputPlace, readOnly ? "1" : "0") }
    public func setDisabled(_ inputPlace: String, _ disabled: Bool) { add("sd" + inputPlace, disabled ? "1" : "0") }
    public func setFocus(_ inputPlace: String, _ focus: Bool) { add("sf" + inputPlace, focus ? "1" : "0") }
    public func setMinLength(_ inputPlace: String, _ length: String) { add("mn" + inputPlace, length) }
    public func setMinLength(_ inputPlace: String, _ length: Int) { setMinLength(inputPlace, String(length)) }
    public func setMaxLength(_ inputPlace: String, _ length: String) { add("mx" + inputPlace, length) }
    public func setMaxLength(_ inputPlace: String, _ length: Int) { setMaxLength(inputPlace, String(length)) }
    public func setSelectedValue(_ inputPlace: String, _ value: String) { add("ts" + inputPlace, value) }
    public func setSelectedIndex(_ inputPlace: String, _ index: String) { add("ti" + inputPlace, index) }
    public func setSelectedIndex(_ inputPlace: String, _ index: Int) { setSelectedIndex(inputPlace, String(index)) }
    public func setCheckedValue(_ inputPlace: String, _ value: String, _ checked: Bool) { add("ks" + inputPlace, value + WebForms.GS + (checked ? "1" : "0")) }
    public func setCheckedIndex(_ inputPlace: String, _ index: String, _ checked: Bool) { add("ki" + inputPlace, index + WebForms.GS + (checked ? "1" : "0")) }
    public func setCheckedIndex(_ inputPlace: String, _ index: Int, _ checked: Bool) { setCheckedIndex(inputPlace, String(index), checked) }

    // Insert
    // Creates the Data only if it does not exist; otherwise, does nothing.
    public func insertId(_ inputPlace: String, _ id: String) { add("ii" + inputPlace, id) }
    public func insertName(_ inputPlace: String, _ name: String) { add("in" + inputPlace, name) }
    public func insertValue(_ inputPlace: String, _ value: String) { add("iv" + inputPlace, value) }
    public func insertClass(_ inputPlace: String, _ `class`: String) { add("ic" + inputPlace, `class`) }
    public func insertStyle(_ inputPlace: String, _ style: String) { add("is" + inputPlace, style) }
    public func insertStyle(_ inputPlace: String, _ name: String, _ value: String) { add("is" + inputPlace, name + ":" + value) }
    public func insertOptionTag(_ inputPlace: String, _ text: String, _ value: String, _ selected: Bool = false) { add("io" + inputPlace, value + WebForms.GS + text + (selected ? WebForms.GS + "1" : "")) }
    public func insertCheckBoxTag(_ inputPlace: String, _ text: String, _ value: String, _ checked: Bool = false) { add("ik" + inputPlace, value + WebForms.GS + text + (checked ? WebForms.GS + "1" : "")) }
    public func insertTitle(_ inputPlace: String, _ title: String) { add("il" + inputPlace, title) }
    public func insertLabel(_ inputPlace: String, _ label: String) { add("iA" + inputPlace, label) }
    public func insertText(_ inputPlace: String, _ text: String) { add("it" + inputPlace, text.replacingOccurrences(of: "\n", with: "$[ln];")) }
    public func insertAttribute(_ inputPlace: String, _ attribute: String, _ value: String = "", _ splitter: Character = "\0") { add("ia" + inputPlace, attribute + WebForms.GS + (splitter != "\0" ? String(splitter) : "") + (!value.isEmpty ? WebForms.GS + value : "")) }
    
    // Delete
    public func deleteId(_ inputPlace: String) { add("di" + inputPlace) }
    public func deleteName(_ inputPlace: String) { add("dn" + inputPlace) }
    public func deleteValue(_ inputPlace: String) { add("dv" + inputPlace) }
    public func deleteClass(_ inputPlace: String, _ className: String) { add("dc" + inputPlace, className) }
    public func deleteStyle(_ inputPlace: String, _ styleName: String) { add("ds" + inputPlace, styleName) }
    public func deleteOptionTag(_ inputPlace: String, _ value: String) { add("do" + inputPlace, value) }
    public func deleteAllOptionTag(_ inputPlace: String) { add("do" + inputPlace, "*") }
    public func deleteCheckBoxTag(_ inputPlace: String, _ value: String) { add("dk" + inputPlace, value) }
    public func deleteAllCheckBoxTag(_ inputPlace: String) { add("dk" + inputPlace, "*") }
    public func deleteTitle(_ inputPlace: String) { add("dl" + inputPlace) }
    public func deleteLabel(_ inputPlace: String) { add("dA" + inputPlace) }
    public func deleteText(_ inputPlace: String) { add("dt" + inputPlace) }
    public func deleteAttribute(_ inputPlace: String, _ attribute: String) { add("da" + inputPlace, attribute) }
    public func delete(_ inputPlace: String) { add("de" + inputPlace) }
    public func deleteParent(_ inputPlace: String) { add("dp" + inputPlace) }

    // Tag
    public func swapTag(_ inputPlace: String, _ outputPlace: String) { add("sp" + inputPlace, outputPlace) }
    public func setReflection(_ inputPlace: String, _ tag: String) { add("sR" + inputPlace, tag) }
    public func setReflectionByOutputPlace(_ inputPlace: String, _ outputPlace: String) { add("iR" + inputPlace, outputPlace) }
    public func setMorph(_ inputPlace: String, _ tag: String) { add("sM" + inputPlace, tag) }
    public func setMorphByOutputPlace(_ inputPlace: String, _ outputPlace: String) { add("iM" + inputPlace, outputPlace) }

    // Browser
    public func changeUrl(_ url: String) { add("cu", url) }
    public func setHeadTitle(_ title: String) { add("ht", title) }
    public func clipboardWriteText(_ text: String) { add("nw", text) }
    public func scrollTo(_ x: String, _ y: String) { add("ws", x + WebForms.GS + y) }
    public func scrollTo(_ x: Int, _ y: Int) { scrollTo(String(x), String(y)) }
    public func historyGo(_ steps: String) { add("wg", steps) }
    public func historyGo(_ steps: Int) { historyGo(String(steps)) }
    public func reloadPage() { add("lr") }
    public func redirect(_ path: String) { add("lh", path) }

    // Increase
    public func increaseMinLength(_ inputPlace: String, _ value: String) { add("+n" + inputPlace, value) }
    public func increaseMinLength(_ inputPlace: String, _ value: Int) { increaseMinLength(inputPlace, String(value)) }
    public func increaseMaxLength(_ inputPlace: String, _ value: String) { add("+x" + inputPlace, value) }
    public func increaseMaxLength(_ inputPlace: String, _ value: Int) { increaseMaxLength(inputPlace, String(value)) }
    public func increaseFontSize(_ inputPlace: String, _ value: String) { add("+f" + inputPlace, value) }
    public func increaseFontSize(_ inputPlace: String, _ value: Int) { increaseFontSize(inputPlace, String(value)) }
    public func increaseWidth(_ inputPlace: String, _ value: String) { add("+w" + inputPlace, value) }
    public func increaseWidth(_ inputPlace: String, _ value: Int) { increaseWidth(inputPlace, String(value)) }
    public func increaseHeight(_ inputPlace: String, _ value: String) { add("+h" + inputPlace, value) }
    public func increaseHeight(_ inputPlace: String, _ value: Int) { increaseHeight(inputPlace, String(value)) }
    public func increaseValue(_ inputPlace: String, _ value: String) { add("+v" + inputPlace, value) }
    public func increaseValue(_ inputPlace: String, _ value: Int) { increaseValue(inputPlace, String(value)) }

    // Decrease
    public func decreaseMinLength(_ inputPlace: String, _ value: String) { add("-n" + inputPlace, value) }
    public func decreaseMinLength(_ inputPlace: String, _ value: Int) { decreaseMinLength(inputPlace, String(value)) }
    public func decreaseMaxLength(_ inputPlace: String, _ value: String) { add("-x" + inputPlace, value) }
    public func decreaseMaxLength(_ inputPlace: String, _ value: Int) { decreaseMaxLength(inputPlace, String(value)) }
    public func decreaseFontSize(_ inputPlace: String, _ value: String) { add("-f" + inputPlace, value) }
    public func decreaseFontSize(_ inputPlace: String, _ value: Int) { decreaseFontSize(inputPlace, String(value)) }
    public func decreaseWidth(_ inputPlace: String, _ value: String) { add("-w" + inputPlace, value) }
    public func decreaseWidth(_ inputPlace: String, _ value: Int) { decreaseWidth(inputPlace, String(value)) }
    public func decreaseHeight(_ inputPlace: String, _ value: String) { add("-h" + inputPlace, value) }
    public func decreaseHeight(_ inputPlace: String, _ value: Int) { decreaseHeight(inputPlace, String(value)) }
    public func decreaseValue(_ inputPlace: String, _ value: String) { add("-v" + inputPlace, value) }
    public func decreaseValue(_ inputPlace: String, _ value: Int) { decreaseValue(inputPlace, String(value)) }

    // Event
    // ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
    // All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.
    public func triggerEvent(_ inputPlace: String, _ htmlEventListener: String, _ constructorName: String? = nil) { add("TE" + inputPlace, htmlEventListener + (!(constructorName ?? "").isEmpty ? WebForms.GS + constructorName! : "")) }
    public func setPostEvent(_ inputPlace: String, _ htmlEvent: String) { add("Ep" + inputPlace, htmlEvent) }
    public func setPostEvent(_ inputPlace: String, _ htmlEvent: String, _ outputPlace: String) { add("Ep" + inputPlace, htmlEvent + WebForms.GS + outputPlace) }
    public func setPostEventAddView(_ inputPlace: String, _ htmlEvent: String) { add("Ep" + inputPlace, htmlEvent + WebForms.GS + "+") }
    public func setPostEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("EP" + inputPlace, htmlEventListener) }
    public func setPostEventListener(_ inputPlace: String, _ htmlEventListener: String, _ outputPlace: String) { add("EP" + inputPlace, htmlEventListener + WebForms.GS + outputPlace) }
    public func setPostEventListenerAddView(_ inputPlace: String, _ htmlEventListener: String) { add("EP" + inputPlace, htmlEventListener + WebForms.GS + "+") }
    public func setGetEvent(_ inputPlace: String, _ htmlEvent: String, _ path: String? = nil) { add("Eg" + inputPlace, htmlEvent + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#")) }
    public func setGetEvent(_ inputPlace: String, _ htmlEvent: String, _ outputPlace: String, _ path: String? = nil) { add("Eg" + inputPlace, htmlEvent + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#") + WebForms.GS + outputPlace) }
    public func setGetEventListener(_ inputPlace: String, _ htmlEventListener: String, _ path: String? = nil) { add("EG" + inputPlace, htmlEventListener + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#")) }
    public func setGetEventListener(_ inputPlace: String, _ htmlEventListener: String, _ outputPlace: String, _ path: String? = nil) { add("EG" + inputPlace, htmlEventListener + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#") + WebForms.GS + outputPlace) }
    public func setPutEvent(_ inputPlace: String, _ htmlEvent: String, _ path: String? = nil) { add("Et" + inputPlace, htmlEvent + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#")) }
    public func setPutEvent(_ inputPlace: String, _ htmlEvent: String, _ outputPlace: String, _ path: String? = nil) { add("Et" + inputPlace, htmlEvent + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#") + WebForms.GS + outputPlace) }
    public func setPutEventListener(_ inputPlace: String, _ htmlEventListener: String, _ path: String? = nil) { add("ET" + inputPlace, htmlEventListener + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#")) }
    public func setPutEventListener(_ inputPlace: String, _ htmlEventListener: String, _ outputPlace: String, _ path: String? = nil) { add("ET" + inputPlace, htmlEventListener + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#") + WebForms.GS + outputPlace) }
    public func setPatchEvent(_ inputPlace: String, _ htmlEvent: String, _ path: String? = nil) { add("Ea" + inputPlace, htmlEvent + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#")) }
    public func setPatchEvent(_ inputPlace: String, _ htmlEvent: String, _ outputPlace: String, _ path: String? = nil) { add("Ea" + inputPlace, htmlEvent + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#") + WebForms.GS + outputPlace) }
    public func setPatchEventListener(_ inputPlace: String, _ htmlEventListener: String, _ path: String? = nil) { add("EA" + inputPlace, htmlEventListener + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#")) }
    public func setPatchEventListener(_ inputPlace: String, _ htmlEventListener: String, _ outputPlace: String, _ path: String? = nil) { add("EA" + inputPlace, htmlEventListener + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#") + WebForms.GS + outputPlace) }
    public func setDeleteEvent(_ inputPlace: String, _ htmlEvent: String, _ path: String? = nil) { add("El" + inputPlace, htmlEvent + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#")) }
    public func setDeleteEvent(_ inputPlace: String, _ htmlEvent: String, _ outputPlace: String, _ path: String? = nil) { add("El" + inputPlace, htmlEvent + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#") + WebForms.GS + outputPlace) }
    public func setDeleteEventListener(_ inputPlace: String, _ htmlEventListener: String, _ path: String? = nil) { add("EL" + inputPlace, htmlEventListener + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#")) }
    public func setDeleteEventListener(_ inputPlace: String, _ htmlEventListener: String, _ outputPlace: String, _ path: String? = nil) { add("EL" + inputPlace, htmlEventListener + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#") + WebForms.GS + outputPlace) }
    public func setOptionsEvent(_ inputPlace: String, _ htmlEvent: String, _ path: String? = nil) { add("Eo" + inputPlace, htmlEvent + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#")) }
    public func setOptionsEvent(_ inputPlace: String, _ htmlEvent: String, _ outputPlace: String, _ path: String? = nil) { add("Eo" + inputPlace, htmlEvent + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#") + WebForms.GS + outputPlace) }
    public func setOptionsEventListener(_ inputPlace: String, _ htmlEventListener: String, _ path: String? = nil) { add("EO" + inputPlace, htmlEventListener + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#")) }
    public func setOptionsEventListener(_ inputPlace: String, _ htmlEventListener: String, _ outputPlace: String, _ path: String? = nil) { add("EO" + inputPlace, htmlEventListener + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#") + WebForms.GS + outputPlace) }
    public func setHeadEvent(_ inputPlace: String, _ htmlEvent: String, _ path: String? = nil) { add("Eh" + inputPlace, htmlEvent + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#")) }
    public func setHeadEventListener(_ inputPlace: String, _ htmlEventListener: String, _ path: String? = nil) { add("EH" + inputPlace, htmlEventListener + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#")) }
    // IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
    public func setSendEvent(_ inputPlace: String, _ htmlEvent: String, _ data: String, _ path: String? = nil, _ method: String = "POST", _ isMultiPart: Bool = false, _ contentType: String = "text/plain", _ outputPlace: String? = nil) { add("En" + inputPlace, htmlEvent + WebForms.GS + data.replacingOccurrences(of: "\n", with: "$[ln];").replacingOccurrences(of: "\"", with: "$[dq];").replacingOccurrences(of: "'", with: "$[sq];") + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#") + WebForms.GS + method + WebForms.GS + (isMultiPart ? "1" : "0") + WebForms.GS + contentType + WebForms.GS + outputPlace) }
    public func setSendEventListener(_ inputPlace: String, _ htmlEventListener: String, _ data: String, _ path: String? = nil, _ method: String = "POST", _ isMultiPart: Bool = false, _ contentType: String = "text/plain", _ outputPlace: String? = nil) { add("EN" + inputPlace, htmlEventListener + WebForms.GS + data.replacingOccurrences(of: "\n", with: "$[ln];") + WebForms.GS + (!(path ?? "").isEmpty ? path! : "#") + WebForms.GS + method + WebForms.GS + (isMultiPart ? "1" : "0") + WebForms.GS + contentType + WebForms.GS + outputPlace) }
    public func setCommentEvent(_ inputPlace: String, _ htmlEvent: String, _ index: String? = nil, _ outputPlace: String? = nil) { add("Eb" + inputPlace, htmlEvent + WebForms.GS + index + WebForms.GS + outputPlace) }
    public func setCommentEvent(_ inputPlace: String, _ htmlEvent: String, _ index: Int, _ outputPlace: String? = nil) { setCommentEvent(inputPlace, htmlEvent, String(index), outputPlace) }
    public func setCommentEventListener(_ inputPlace: String, _ htmlEventListener: String, _ index: String? = nil, _ outputPlace: String? = nil) { add("EB" + inputPlace, htmlEventListener + WebForms.GS + index + WebForms.GS + outputPlace) }
    public func setCommentEventListener(_ inputPlace: String, _ htmlEventListener: String, _ index: Int, _ outputPlace: String? = nil) { setCommentEventListener(inputPlace, htmlEventListener, String(index), outputPlace) }
    public func setWasmEvent(_ inputPlace: String, _ htmlEvent: String, _ wasmLanguage: String, _ wasmUrl: String, _ methodName: String, _ args: [Any]? = nil, _ outputPlace: String? = nil) {
        var argsJoin = ""
        if let args = args {
            argsJoin = args.count > 0 ? "[" + args.map { "\($0)" }.joined(separator: WebForms.US) : ""
        }
        add("Ey" + inputPlace, htmlEvent + WebForms.GS + wasmLanguage + WebForms.GS + wasmUrl + WebForms.GS + methodName + WebForms.GS + argsJoin + WebForms.GS + outputPlace)
    }
    public func setWasmEventListener(_ inputPlace: String, _ htmlEventListener: String, _ wasmLanguage: String, _ wasmUrl: String, _ methodName: String, _ args: [Any]? = nil, _ outputPlace: String? = nil) {
        var argsJoin = ""
        if let args = args {
            argsJoin = args.count > 0 ? "[" + args.map { "\($0)" }.joined(separator: WebForms.US) : ""
        }
        add("EY" + inputPlace, htmlEventListener + WebForms.GS + wasmLanguage + WebForms.GS + wasmUrl + WebForms.GS + methodName + WebForms.GS + argsJoin + WebForms.GS + outputPlace)
    }
    public func setWebSocketEvent(_ inputPlace: String, _ htmlEvent: String, _ path: String) { add("Ew" + inputPlace, htmlEvent + WebForms.GS + path) }
    public func setWebSocketEventListener(_ inputPlace: String, _ htmlEventListener: String, _ path: String) { add("EW" + inputPlace, htmlEventListener + WebForms.GS + path) }
    public func setSSEEvent(_ inputPlace: String, _ htmlEvent: String, _ path: String, _ shouldReconnect: Bool = true, _ reconnectTryTimeout: Int = 3000) { add("Ee" + inputPlace, htmlEvent + WebForms.GS + path + WebForms.GS + (shouldReconnect ? "1" : "0") + WebForms.GS + String(reconnectTryTimeout)) }
    public func setSSEEvent(_ inputPlace: String, _ htmlEvent: String, _ path: String, _ outputPlace: String, _ shouldReconnect: Bool = true, _ reconnectTryTimeout: Int = 3000) { add("Ee" + inputPlace, htmlEvent + WebForms.GS + path + WebForms.GS + (shouldReconnect ? "1" : "0") + WebForms.GS + String(reconnectTryTimeout) + WebForms.GS + outputPlace) }
    public func setSSEEventListener(_ inputPlace: String, _ htmlEventListener: String, _ path: String, _ shouldReconnect: Bool = true, _ reconnectTryTimeout: Int = 3000) { add("EE" + inputPlace, htmlEventListener + WebForms.GS + path + WebForms.GS + (shouldReconnect ? "1" : "0") + WebForms.GS + String(reconnectTryTimeout)) }
    public func setSSEEventListener(_ inputPlace: String, _ htmlEventListener: String, _ path: String, _ outputPlace: String, _ shouldReconnect: Bool = true, _ reconnectTryTimeout: Int = 3000) { add("EE" + inputPlace, htmlEventListener + WebForms.GS + path + WebForms.GS + (shouldReconnect ? "1" : "0") + WebForms.GS + String(reconnectTryTimeout) + WebForms.GS + outputPlace) }
    public func setFrontEvent(_ inputPlace: String, _ htmlEvent: String, _ modulePath: String, _ args: [Any]? = nil, _ outputPlace: String? = nil) {
        var argsJoin = ""
        if let args = args {
            argsJoin = args.count > 0 ? WebForms.GS + "[" + args.map { "\($0)" }.joined(separator: WebForms.US) : ""
        }
        add("Ej" + inputPlace, htmlEvent + WebForms.GS + modulePath + WebForms.GS + outputPlace + argsJoin)
    }
    public func setFrontEventListener(_ inputPlace: String, _ htmlEventListener: String, _ modulePath: String, _ args: [Any]? = nil, _ outputPlace: String? = nil) {
        var argsJoin = ""
        if let args = args {
            argsJoin = args.count > 0 ? WebForms.GS + "[" + args.map { "\($0)" }.joined(separator: WebForms.US) : ""
        }
        add("EJ" + inputPlace, htmlEventListener + WebForms.GS + modulePath + WebForms.GS + outputPlace + argsJoin)
    }
    public func setMasterPagesEvent(_ inputPlace: String, _ htmlEvent: String, _ outputPlace: String? = nil) { add("Eu" + inputPlace, htmlEvent + WebForms.GS + outputPlace) }
    public func setMasterPagesEventListener(_ inputPlace: String, _ htmlEventListener: String, _ outputPlace: String? = nil) { add("EU" + inputPlace, htmlEventListener + WebForms.GS + outputPlace) }
    public func setPreventDefaultEvent(_ inputPlace: String, _ htmlEvent: String) { add("Ed" + inputPlace, htmlEvent) }
    public func setPreventDefaultEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("ED" + inputPlace, htmlEventListener) }
    public func setStopPropagationEvent(_ inputPlace: String, _ htmlEvent: String) { add("Es" + inputPlace, htmlEvent) }
    public func setStopPropagationEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("ES" + inputPlace, htmlEventListener) }
    public func setMethodEvent(_ inputPlace: String, _ htmlEvent: String, _ methodName: String, _ args: [Any]? = nil) {
        var argsJoin = ""
        if let args = args {
            argsJoin = args.count > 0 ? WebForms.GS + "[" + args.map { "\($0)" }.joined(separator: WebForms.US) : ""
        }
        add("Em" + inputPlace, htmlEvent + WebForms.GS + methodName + argsJoin)
    }
    public func setMethodEventListener(_ inputPlace: String, _ htmlEventListener: String, _ methodName: String, _ args: [Any]? = nil) {
        var argsJoin = ""
        if let args = args {
            argsJoin = args.count > 0 ? WebForms.GS + "[" + args.map { "\($0)" }.joined(separator: WebForms.US) : ""
        }
        add("EM" + inputPlace, htmlEventListener + WebForms.GS + methodName + argsJoin)
    }
    public func setModuleMethodEvent(_ inputPlace: String, _ htmlEvent: String, _ methodName: String, _ args: [Any]? = nil) {
        var argsJoin = ""
        if let args = args {
            argsJoin = args.count > 0 ? WebForms.GS + "[" + args.map { "\($0)" }.joined(separator: WebForms.US) : ""
        }
        add("Ex" + inputPlace, htmlEvent + WebForms.GS + methodName + argsJoin)
    }
    public func setModuleMethodEventListener(_ inputPlace: String, _ htmlEventListener: String, _ methodName: String, _ args: [Any]? = nil) {
        var argsJoin = ""
        if let args = args {
            argsJoin = args.count > 0 ? WebForms.GS + "[" + args.map { "\($0)" }.joined(separator: WebForms.US) : ""
        }
        add("EX" + inputPlace, htmlEventListener + WebForms.GS + methodName + argsJoin)
    }
    public func assignConfirmEvent(_ inputPlace: String, _ htmlEvent: String, _ text: String = "Are you sure you want to proceed?", _ type: String = "none", _ title: String = "Confirm", _ okText: String = "OK", _ cancelText: String = "Cancel") { add("Ef" + inputPlace, htmlEvent + WebForms.GS + (text == "Are you sure you want to proceed?" ? "" : text) + WebForms.GS + (type == "none" ? "" : type) + WebForms.GS + (title == "Confirm" ? "" : title) + WebForms.GS + (okText == "OK" ? "" : okText) + WebForms.GS + (cancelText == "Cancel" ? "" : cancelText)) }
    public func removePostEvent(_ inputPlace: String, _ htmlEvent: String) { add("Rp" + inputPlace, htmlEvent) }
    public func removePostEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RP" + inputPlace, htmlEventListener) }
    public func removeGetEvent(_ inputPlace: String, _ htmlEvent: String) { add("Rg" + inputPlace, htmlEvent) }
    public func removeGetEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RG" + inputPlace, htmlEventListener) }
    public func removePutEvent(_ inputPlace: String, _ htmlEvent: String) { add("Rt" + inputPlace, htmlEvent) }
    public func removePutEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RT" + inputPlace, htmlEventListener) }
    public func removePatchEvent(_ inputPlace: String, _ htmlEvent: String) { add("Ra" + inputPlace, htmlEvent) }
    public func removePatchEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RA" + inputPlace, htmlEventListener) }
    public func removeDeleteEvent(_ inputPlace: String, _ htmlEvent: String) { add("Rl" + inputPlace, htmlEvent) }
    public func removeDeleteEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RL" + inputPlace, htmlEventListener) }
    public func removeOptionsEvent(_ inputPlace: String, _ htmlEvent: String) { add("Ro" + inputPlace, htmlEvent) }
    public func removeOptionsEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RO" + inputPlace, htmlEventListener) }
    public func removeHeadEvent(_ inputPlace: String, _ htmlEvent: String) { add("Rh" + inputPlace, htmlEvent) }
    public func removeHeadEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RH" + inputPlace, htmlEventListener) }
    public func removeSendEvent(_ inputPlace: String, _ htmlEvent: String) { add("Rn" + inputPlace, htmlEvent) }
    public func removeSendEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RN" + inputPlace, htmlEventListener) }
    public func removeCommentEvent(_ inputPlace: String, _ htmlEvent: String) { add("Rb" + inputPlace, htmlEvent) }
    public func removeCommentEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RB" + inputPlace, htmlEventListener) }
    public func removeWasmEvent(_ inputPlace: String, _ htmlEvent: String) { add("Ry" + inputPlace, htmlEvent) }
    public func removeWasmEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RY" + inputPlace, htmlEventListener) }
    public func removeWebSocketEvent(_ inputPlace: String, _ htmlEvent: String) { add("Rw" + inputPlace, htmlEvent) }
    public func removeWebSocketEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RW" + inputPlace, htmlEventListener) }
    public func removeSSEEvent(_ inputPlace: String, _ htmlEvent: String) { add("Re" + inputPlace, htmlEvent) }
    public func removeSSEEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RE" + inputPlace, htmlEventListener) }
    public func removeFrontEvent(_ inputPlace: String, _ htmlEvent: String) { add("Rj" + inputPlace, htmlEvent) }
    public func removeFrontEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RJ" + inputPlace, htmlEventListener) }
    public func removePreventDefaultEvent(_ inputPlace: String, _ htmlEvent: String) { add("Rd" + inputPlace, htmlEvent) }
    public func removePreventDefaultEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RD" + inputPlace, htmlEventListener) }
    public func removeMasterPagesEvent(_ inputPlace: String, _ htmlEvent: String) { add("Ru" + inputPlace, htmlEvent) }
    public func removeMasterPagesEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RU" + inputPlace, htmlEventListener) }
    public func removeStopPropagationEvent(_ inputPlace: String, _ htmlEvent: String) { add("Rs" + inputPlace, htmlEvent) }
    public func removeStopPropagationEventListener(_ inputPlace: String, _ htmlEventListener: String) { add("RS" + inputPlace, htmlEventListener) }
    public func removeMethodEvent(_ inputPlace: String, _ htmlEvent: String, _ methodName: String) { add("Rm" + inputPlace, htmlEvent + WebForms.GS + methodName) }
    public func removeMethodEventListener(_ inputPlace: String, _ htmlEventListener: String, _ methodName: String) { add("RM" + inputPlace, htmlEventListener + WebForms.GS + methodName) }
    public func removeModuleMethodEvent(_ inputPlace: String, _ htmlEvent: String, _ methodName: String) { add("Rx" + inputPlace, htmlEvent + WebForms.GS + methodName) }
    public func removeModuleMethodEventListener(_ inputPlace: String, _ htmlEventListener: String, _ methodName: String) { add("RX" + inputPlace, htmlEventListener + WebForms.GS + methodName) }
    public func removeConfirmEvent(_ inputPlace: String, _ htmlEvent: String) { add("Rf" + inputPlace, htmlEvent) }

    // Custom Event
    // This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
    // Watch: attribute, style, text, children, value
    // Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
    // Range: Only Use For Compare With inrange Value. Split By Comma ","
    // Key: Only Use For Watch With attribute And style Value
    public func createCustomDOMEvent(_ inputPlace: String, _ eventName: String, _ watch: String, _ key: String, _ compare: String, _ value: String, _ range: String, _ immediate: Bool = false, _ delay: String = "0") { add("eC" + inputPlace, eventName + WebForms.GS + watch + WebForms.GS + key + WebForms.GS + compare + WebForms.GS + value + WebForms.GS + range + WebForms.GS + (immediate ? "1" : "0") + WebForms.GS + delay) }
    public func createCustomDOMEvent(_ inputPlace: String, _ eventName: String, _ watch: String, _ key: String, _ compare: String, _ value: String, _ range: String, _ immediate: Bool, _ delay: Int) { createCustomDOMEvent(inputPlace, eventName, watch, key, compare, value, range, immediate, String(delay)) }
    public func enableScrollBottomEvent(_ enable: Bool = true) { add("eb", enable ? "1" : "0") }
    public func enableReachedElementEvent(_ inputPlace: String, _ once: Bool, _ enable: Bool = true) { add("er" + inputPlace, (once ? "1" : "0") + WebForms.GS + (enable ? "1" : "0")) }

    // Module
    public func loadModule(_ modulePath: String, _ methods: [String]? = nil) {
        let methods = methods ?? []
        add("Ml", modulePath + (methods.count > 0 ? WebForms.GS + "[" + methods.joined(separator: WebForms.US) : ""))
    }
    public func unloadModule(_ modulePath: String) { add("Mu", modulePath) }
    public func deleteModuleMethod(_ methodName: String) { add("Md", methodName) }

    // Unit Testing
    // InputPlace Is Actual, Expected Is Tag/OutputPlace
    public func assertEqual(_ inputPlace: String, _ tag: String) { add("At" + inputPlace, tag.replacingOccurrences(of: "\n", with: "$[ln];")) }
    public func assertEqualByOutputPlace(_ inputPlace: String, _ outputPlace: String) { add("Ao" + inputPlace, outputPlace) }

    // Debug
    public func createDebugger(_ pause: Bool = false) { add("Dc", pause ? "1" : "0") }

    // Service Worker
    // To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
    public func serviceWorkerRegister(_ path: String? = nil, _ scopePath: String? = nil) { add("wR", (path ?? "") + WebForms.GS + (scopePath ?? "")) }
    public func serviceWorkerPreCacheStatic(_ pathList: [String]) { add("wp", pathList.joined(separator: WebForms.GS)) }
    public func serviceWorkerDynamicCache(_ path: String, _ seconds: String = "") { add("wc", path + (seconds != "" ? WebForms.GS + seconds : "")) }
    public func serviceWorkerDynamicCache(_ path: String, _ seconds: Int) { serviceWorkerDynamicCache(path, seconds > 0 ? String(seconds) : "") }
    public func serviceWorkerDeleteDynamicCache() { add("wd") }
    public func serviceWorkerDeleteDynamicCache(_ path: String) { add("wd", path) }
    public func serviceWorkerDynamicCacheTTLUpdate(_ path: String, _ seconds: String = "") { add("wt", path + (seconds != "" ? WebForms.GS + seconds : "")) }
    public func serviceWorkerDynamicCacheTTLUpdate(_ path: String, _ seconds: Int) { serviceWorkerDynamicCacheTTLUpdate(path, seconds > 0 ? String(seconds) : "") }
    // Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
    // Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
    // CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
    public func serviceWorkerRouteSet(_ path: String, _ type: String, _ cacheDynamic: Bool = false) { add("wr", path + WebForms.GS + type + (cacheDynamic ? WebForms.GS + "1" : "")) }
    public func serviceWorkerRouteAlias(_ path: String, _ to: String) { add("wa", path + WebForms.GS + to) }
    public func serviceWorkerDeleteRouteAlias(_ path: String? = nil) { add("wC", path) }
    // Delete All Route And Alias
    public func serviceWorkerDeleteRoute() { add("wD") }
    public func serviceWorkerDeleteRoute(_ path: String) { add("wD", path) }

    // SSE
    public func disconnectSSE(_ path: String) { add("Ds", path) }
    public func disconnectAllSSE() { add("Ds") }

    // State
    public func addState(_ path: String? = nil, _ title: String? = nil) { add("AS", (path ?? "") + WebForms.GS + (title ?? "")) }
    public func saveState(_ path: String? = nil, _ title: String? = nil) { add("As", (path ?? "") + WebForms.GS + (title ?? "")) }
    public func loadState(_ path: String) { add("ls", path) }
    public func deleteState(_ path: String? = nil) { add("DS", path) }
    public func deleteAllState() { add("DS", "*") }

    // Cookie
    public func setCookie(_ key: String, _ value: String, _ seconds: String, _ path: String? = nil) { add("sC", key + WebForms.GS + value + WebForms.GS + seconds + (!(path ?? "").isEmpty ? WebForms.GS + path! : "")) }
    public func setCookie(_ key: String, _ value: String, _ seconds: Int, _ path: String? = nil) { setCookie(key, value, String(seconds), path) }

    // Save (Session Cache)
    public func saveId(_ inputPlace: String, _ key: String = ".") { add("@gi" + inputPlace, key) }
    public func saveName(_ inputPlace: String, _ key: String = ".") { add("@gn" + inputPlace, key) }
    public func saveValue(_ inputPlace: String, _ key: String = ".") { add("@gv" + inputPlace, key) }
    public func saveValueLength(_ inputPlace: String, _ key: String = ".") { add("@ge" + inputPlace, key) }
    public func saveClass(_ inputPlace: String, _ key: String = ".") { add("@gc" + inputPlace, key) }
    public func saveStyle(_ inputPlace: String, _ key: String = ".") { add("@gs" + inputPlace, key) }
    public func saveTitle(_ inputPlace: String, _ key: String = ".") { add("@gl" + inputPlace, key) }
    public func saveLabel(_ inputPlace: String, _ key: String = ".") { add("@gA" + inputPlace, key) }
    public func saveText(_ inputPlace: String, _ key: String = ".") { add("@gt" + inputPlace, key) }
    public func saveOuterText(_ inputPlace: String, _ key: String = ".") { add("@go" + inputPlace, key) }
    public func saveTextLength(_ inputPlace: String, _ key: String = ".") { add("@gg" + inputPlace, key) }
    public func saveAttribute(_ inputPlace: String, _ attribute: String, _ key: String = ".") { add("@ga" + inputPlace, key + WebForms.GS + attribute) }
    public func saveWidth(_ inputPlace: String, _ key: String = ".") { add("@gw" + inputPlace, key) }
    public func saveHeight(_ inputPlace: String, _ key: String = ".") { add("@gh" + inputPlace, key) }
    public func saveReadOnly(_ inputPlace: String, _ key: String = ".") { add("@gr" + inputPlace, key) }
    public func saveSelectedIndex(_ inputPlace: String, _ key: String = ".") { add("@gx" + inputPlace, key) }
    public func saveTextAlign(_ inputPlace: String, _ key: String = ".") { add("@gT" + inputPlace, key) }
    public func saveNodeLength(_ inputPlace: String, _ key: String = ".") { add("@gL" + inputPlace, key) }
    public func saveVisible(_ inputPlace: String, _ key: String = ".") { add("@gV" + inputPlace, key) }
    public func saveUrl(_ url: String, _ fetchScript: Bool = false, _ key: String = ".") { add("@gu", key + WebForms.GS + url + (fetchScript ? WebForms.GS + "1" : "")) }
    public func saveIndex(_ inputPlace: String, _ key: String = ".") { add("@gI" + inputPlace, key) }
    public func removeSave(_ cacheKey: String) { add("rs", cacheKey) }
    public func removeAllSave() { add("rs", "*") }
    // Calling the SetSave Method Causes Action Control Requests Triggered by Events Using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send Event, to be Temporarily Saved on the Active Page, so the Request will not be Sent to the Server Again.
    public func setSave() { add("cs", "*") }
    public func addSaveValue(_ cacheKey: String, _ value: String) { add("SA", cacheKey + WebForms.GS + value.replacingOccurrences(of: "\n", with: "$[ln];")) }
    public func insertSaveValue(_ cacheKey: String, _ value: String) { add("SI", cacheKey + WebForms.GS + value.replacingOccurrences(of: "\n", with: "$[ln];")) }
    public func appendSaveValue(_ cacheKey: String, _ value: String) { add("SP", cacheKey + WebForms.GS + value.replacingOccurrences(of: "\n", with: "$[ln];")) }
    public func replaceSaveValue(_ cacheKey: String, _ searchValue: String, _ value: String) { add("SR", cacheKey + WebForms.GS + value.replacingOccurrences(of: "\n", with: "$[ln];") + WebForms.GS + searchValue.replacingOccurrences(of: "\n", with: "$[ln];")) }

    // Cache
    public func cacheId(_ inputPlace: String, _ key: String = ".") { add("@ci" + inputPlace, key) }
    public func cacheName(_ inputPlace: String, _ key: String = ".") { add("@cn" + inputPlace, key) }
    public func cacheValue(_ inputPlace: String, _ key: String = ".") { add("@cv" + inputPlace, key) }
    public func cacheValueLength(_ inputPlace: String, _ key: String = ".") { add("@ce" + inputPlace, key) }
    public func cacheClass(_ inputPlace: String, _ key: String = ".") { add("@cc" + inputPlace, key) }
    public func cacheStyle(_ inputPlace: String, _ key: String = ".") { add("@cs" + inputPlace, key) }
    public func cacheTitle(_ inputPlace: String, _ key: String = ".") { add("@cl" + inputPlace, key) }
    public func cacheLabel(_ inputPlace: String, _ key: String = ".") { add("@cA" + inputPlace, key) }
    public func cacheText(_ inputPlace: String, _ key: String = ".") { add("@ct" + inputPlace, key) }
    public func cacheOuterText(_ inputPlace: String, _ key: String = ".") { add("@co" + inputPlace, key) }
    public func cacheTextLength(_ inputPlace: String, _ key: String = ".") { add("@cg" + inputPlace, key) }
    public func cacheAttribute(_ inputPlace: String, _ attribute: String, _ key: String = ".") { add("@ca" + inputPlace, key + WebForms.GS + attribute) }
    public func cacheWidth(_ inputPlace: String, _ key: String = ".") { add("@cw" + inputPlace, key) }
    public func cacheHeight(_ inputPlace: String, _ key: String = ".") { add("@ch" + inputPlace, key) }
    public func cacheReadOnly(_ inputPlace: String, _ key: String = ".") { add("@cr" + inputPlace, key) }
    public func cacheSelectedIndex(_ inputPlace: String, _ key: String = ".") { add("@cx" + inputPlace, key) }
    public func cacheTextAlign(_ inputPlace: String, _ key: String = ".") { add("@cT" + inputPlace, key) }
    public func cacheNodeLength(_ inputPlace: String, _ key: String = ".") { add("@cL" + inputPlace, key) }
    public func cacheVisible(_ inputPlace: String, _ key: String = ".") { add("@cV" + inputPlace, key) }
    public func cacheUrl(_ url: String, _ fetchScript: Bool = false, _ key: String = ".") { add("@cu", key + WebForms.GS + url + (fetchScript ? WebForms.GS + "1" : "")) }
    public func cacheIndex(_ inputPlace: String, _ key: String = ".") { add("@cI" + inputPlace, key) }
    public func removeCache(_ cacheKey: String) { add("rd", cacheKey) }
    public func removeAllCache() { add("rd", "*") }
    // Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
    public func setCache(_ second: String) { add("cd", second) }
    public func setCache(_ second: Int) { setCache(String(second)) }
    public func setCache() { add("cd", "*") }
    public func addCacheValue(_ cacheKey: String, _ value: String) { add("CA", cacheKey + WebForms.GS + value.replacingOccurrences(of: "\n", with: "$[ln];")) }
    public func insertCacheValue(_ cacheKey: String, _ value: String) { add("CI", cacheKey + WebForms.GS + value.replacingOccurrences(of: "\n", with: "$[ln];")) }
    public func appendCacheValue(_ cacheKey: String, _ value: String) { add("CP", cacheKey + WebForms.GS + value.replacingOccurrences(of: "\n", with: "$[ln];")) }
    public func replaceCacheValue(_ cacheKey: String, _ searchValue: String, _ value: String) { add("CR", cacheKey + WebForms.GS + value.replacingOccurrences(of: "\n", with: "$[ln];") + WebForms.GS + searchValue.replacingOccurrences(of: "\n", with: "$[ln];")) }

    // Call
    public func loadUrl(_ inputPlace: String, _ url: String) { add("lu" + inputPlace, url) }
    public func runActionControls(_ actionControls: String, _ withoutWebFormsSection: Bool = true, _ index: String? = nil, _ useCurrentEvent: Bool = true) { add("lA", (useCurrentEvent ? "1" : "0") + WebForms.GS + (withoutWebFormsSection ? "1" : "0") + WebForms.GS + index + WebForms.GS + actionControls) }
    public func callScript(_ scriptText: String) { add("_", scriptText.replacingOccurrences(of: "\n", with: "$[ln];")) }
    public func callMethod(_ methodName: String, _ args: [Any]? = nil) {
        var argsJoin = ""
        if let args = args {
            argsJoin = args.count > 0 ? WebForms.GS + "[" + args.map { "\($0)" }.joined(separator: WebForms.US) : ""
        }
        add("lm", methodName + argsJoin)
    }
    public func callModuleMethod(_ methodName: String, _ args: [Any]? = nil) {
        var argsJoin = ""
        if let args = args {
            argsJoin = args.count > 0 ? WebForms.GS + "[" + args.map { "\($0)" }.joined(separator: WebForms.US) : ""
        }
        add("lM", methodName + argsJoin)
    }
    public func callPostBack(_ formInputPlace: String, _ outputPlace: String? = nil) { add("Lp", "1" + WebForms.GS + formInputPlace + (!(outputPlace ?? "").isEmpty ? WebForms.GS + outputPlace! : "")) }
    public func callCommentBack(_ index: String? = nil, _ inputPlace: String? = nil, _ useCurrentEvent: Bool = true) { add("LC", (useCurrentEvent ? "1" : "0") + WebForms.GS + index + WebForms.GS + inputPlace) }
    public func callCommentBack(_ index: Int, _ inputPlace: String? = nil, _ useCurrentEvent: Bool = true) { callCommentBack(String(index), inputPlace, useCurrentEvent) }
    public func callWasmBack(_ wasmLanguage: String, _ wasmUrl: String, _ methodName: String, _ args: [Any]? = nil, _ outputPlace: String? = nil, _ useCurrentEvent: Bool = true) {
        var argsJoin = ""
        if let args = args {
            argsJoin = args.count > 0 ? "[" + args.map { "\($0)" }.joined(separator: WebForms.US) : ""
        }
        add("Ly", (useCurrentEvent ? "1" : "0") + WebForms.GS + wasmLanguage + WebForms.GS + wasmUrl + WebForms.GS + methodName + WebForms.GS + argsJoin + WebForms.GS + outputPlace)
    }
    public func callWebSocketBack(_ path: String, _ useCurrentEvent: Bool = true) { add("Lw", (useCurrentEvent ? "1" : "0") + WebForms.GS + path) }
    public func callSSEBack(_ path: String, _ outputPlace: String? = nil, _ useCurrentEvent: Bool = true, _ shouldReconnect: Bool = true, _ reconnectTryTimeout: String = "3000") { add("Ls", (useCurrentEvent ? "1" : "0") + WebForms.GS + path + WebForms.GS + (shouldReconnect ? "1" : "0") + WebForms.GS + reconnectTryTimeout + (!(outputPlace ?? "").isEmpty ? WebForms.GS + outputPlace! : "")) }
    public func callSSEBack(_ path: String, _ outputPlace: String, _ useCurrentEvent: Bool, _ shouldReconnect: Bool, _ reconnectTryTimeout: Int) { callSSEBack(path, outputPlace, useCurrentEvent, shouldReconnect, String(reconnectTryTimeout)) }
    public func callFront(_ modulePath: String, _ args: [Any]? = nil, _ outputPlace: String? = nil, _ useCurrentEvent: Bool = true) {
        var argsJoin = ""
        if let args = args {
            argsJoin = args.count > 0 ? WebForms.GS + "[" + args.map { "\($0)" }.joined(separator: WebForms.US) : ""
        }
        add("Lj", (useCurrentEvent ? "1" : "0") + WebForms.GS + modulePath + WebForms.GS + outputPlace + argsJoin)
    }
    public func callGetBack(_ path: String, _ outputPlace: String? = nil, _ useCurrentEvent: Bool = true) { add("Lg", (useCurrentEvent ? "1" : "0") + WebForms.GS + path + (!(outputPlace ?? "").isEmpty ? WebForms.GS + outputPlace! : "")) }
    public func callPutBack(_ path: String, _ outputPlace: String? = nil, _ useCurrentEvent: Bool = true) { add("Lt", (useCurrentEvent ? "1" : "0") + WebForms.GS + path + (!(outputPlace ?? "").isEmpty ? WebForms.GS + outputPlace! : "")) }
    public func callPatchBack(_ path: String, _ outputPlace: String? = nil, _ useCurrentEvent: Bool = true) { add("LP", (useCurrentEvent ? "1" : "0") + WebForms.GS + path + (!(outputPlace ?? "").isEmpty ? WebForms.GS + outputPlace! : "")) }
    public func callDeleteBack(_ path: String, _ outputPlace: String? = nil, _ useCurrentEvent: Bool = true) { add("Ld", (useCurrentEvent ? "1" : "0") + WebForms.GS + path + (!(outputPlace ?? "").isEmpty ? WebForms.GS + outputPlace! : "")) }
    public func callHeadBack(_ path: String, _ useCurrentEvent: Bool = true) { add("Lh", (useCurrentEvent ? "1" : "0") + WebForms.GS + path) }
    public func callOptionsBack(_ path: String, _ outputPlace: String? = nil, _ useCurrentEvent: Bool = true) { add("Lo", (useCurrentEvent ? "1" : "0") + WebForms.GS + path + (!(outputPlace ?? "").isEmpty ? WebForms.GS + outputPlace! : "")) }
    public func callSendBack(_ path: String, _ method: String, _ isMultiPart: Bool, _ contentType: String, _ data: String, _ outputPlace: String? = nil, _ useCurrentEvent: Bool = true) { add("LS", (useCurrentEvent ? "1" : "0") + WebForms.GS + path + WebForms.GS + method + WebForms.GS + (isMultiPart ? "1" : "0") + WebForms.GS + contentType + WebForms.GS + data.replacingOccurrences(of: "\n", with: "$[ln];") + (!(outputPlace ?? "").isEmpty ? WebForms.GS + outputPlace! : "")) }

    // Update
    public func increase(_ inputPlace: String, _ value: Float) { add("gt" + inputPlace, "i" + WebForms.GS + String(value)) }
    public func decrease(_ inputPlace: String, _ value: Float) { add("gt" + inputPlace, "i" + WebForms.GS + String(value * -1)) }
    // If You Don't Use Deep Mode, any Tags Inside the Current Tag Will Simply Be Treated as Strings. Deep Mode Does not Remove Inner Elements.
    public func replace(_ inputPlace: String, _ value: String, _ newValue: String, _ alsoStartTag: Bool = false, _ deep: Bool = true) { add("gt" + inputPlace, "r" + WebForms.GS + value + WebForms.GS + newValue + WebForms.GS + (alsoStartTag ? "1" : "0") + WebForms.GS + (deep ? "1" : "0")) }
    // HTML Converts Attribute Names to Lowercase, so they Need to Be Written in Lowercase.
    public func replaceStartTag(_ inputPlace: String, _ value: String, _ newValue: String) { add("gt" + inputPlace, "s" + WebForms.GS + value + WebForms.GS + newValue) }

    // Pre Runner
    public func assignDelay(_ miliSecond: Int, _ index: Int = -1) {
        let currentLine = getLineByIndex(index)
        if currentLine.isEmpty {
            return
        }
        let parts = currentLine.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false).map(String.init)
        let newName = ":" + String(miliSecond) + ")" + parts[0]
        let newValue = parts.count > 1 ? parts[1] : ""
        updateLineByIndex(index, newName, newValue)
    }

    public func assignDelayChange(_ miliSecond: Int, _ index: Int = -1) {
        let currentLine = getLineByIndex(index)
        if currentLine.isEmpty {
            return
        }
        let parts = currentLine.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false).map(String.init)
        var currentName = parts[0]
        if currentName.hasPrefix(":") && currentName.contains(")") {
            let closingBracket = currentName.firstIndex(of: ")")!
            currentName = String(currentName[currentName.index(after: closingBracket)...])
        }
        let newName = ":" + String(miliSecond) + ")" + currentName
        let newValue = parts.count > 1 ? parts[1] : ""
        updateLineByIndex(index, newName, newValue)
    }

    public func assignInterval(_ miliSecond: Int, _ id: String? = nil, _ index: Int = -1) {
        let currentLine = getLineByIndex(index)
        if currentLine.isEmpty {
            return
        }
        let parts = currentLine.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false).map(String.init)
        let newName = "(" + String(miliSecond) + (!(id ?? "").isEmpty ? "|" + id! : "") + ")" + parts[0]
        let newValue = parts.count > 1 ? parts[1] : ""
        updateLineByIndex(index, newName, newValue)
    }

    public func assignIntervalChange(_ miliSecond: Int, _ id: String? = nil, _ index: Int = -1) {
        let currentLine = getLineByIndex(index)
        if currentLine.isEmpty {
            return
        }
        let parts = currentLine.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false).map(String.init)
        var currentName = parts[0]
        if currentName.hasPrefix("(") && currentName.contains(")") {
            let closingBracket = currentName.firstIndex(of: ")")!
            currentName = String(currentName[currentName.index(after: closingBracket)...])
        }
        let newName = "(" + String(miliSecond) + (!(id ?? "").isEmpty ? "|" + id! : "") + ")" + currentName
        let newValue = parts.count > 1 ? parts[1] : ""
        updateLineByIndex(index, newName, newValue)
    }

    public func deleteInterval(_ id: String) { add("Di", id) }

    public func assignRepeat(_ count: Int, _ index: Int = -1) {
        let currentLine = getLineByIndex(index)
        if currentLine.isEmpty {
            return
        }
        let parts = currentLine.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false).map(String.init)
        let newName = "," + String(count) + ")" + parts[0]
        let newValue = parts.count > 1 ? parts[1] : ""
        updateLineByIndex(index, newName, newValue)
    }

    public func assignRepeatChange(_ count: Int, _ index: Int = -1) {
        let currentLine = getLineByIndex(index)
        if currentLine.isEmpty {
            return
        }
        let parts = currentLine.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false).map(String.init)
        var currentName = parts[0]
        if currentName.hasPrefix(",") && currentName.contains(")") {
            let closingBracket = currentName.firstIndex(of: ")")!
            currentName = String(currentName[currentName.index(after: closingBracket)...])
        }
        let newName = "," + String(count) + ")" + currentName
        let newValue = parts.count > 1 ? parts[1] : ""
        updateLineByIndex(index, newName, newValue)
    }

    // Index
    public func startIndex(_ name: String) { add("#", name) }
    public func startIndex() { startIndex("") }
    // This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
    public func startState() { startIndex("$") }
    public func goTo(_ line: String, _ `repeat`: String) { add("&", line + WebForms.GS + `repeat`) }
    public func goTo(_ line: Int, _ `repeat`: Int = 1) { goTo(String(line), String(`repeat`)) }
    public func goTo(_ index: String, _ `repeat`: Int = 1) { add("&", "#" + index + WebForms.GS + String(`repeat`)) }
    
    // Start
    public func startTransientDOM(_ inputPlace: String) { add("td", inputPlace) }
    public func endTransientDOM() { add("td", ";") }

    // Message
    // Type: warning, problem, help, success, none
    public func alert(_ text: String, _ type: String = "none", _ title: String = "Alert", _ okText: String = "OK") { add("Al", text + WebForms.GS + (type == "none" ? "" : type) + WebForms.GS + (title == "Alert" ? "" : title) + WebForms.GS + (okText == "OK" ? "" : okText)) }
    public func message(_ text: String, _ type: String = "none", _ duration: String = "0") { add("me", text + WebForms.GS + (type == "none" ? "" : type) + WebForms.GS + (duration == "0" ? "" : duration)) }
    public func message(_ text: String, _ type: String, _ duration: Int) { message(text, type, String(duration)) }
    public func message(_ text: String, _ duration: Int) { message(text, "", String(duration)) }

    // Type: log, info, warn, error, debug, trace, group, groupend, table
    public func consoleMessage(_ text: String, _ type: String = "log") { add("mc", text.replacingOccurrences(of: "\n", with: "$[ln];") + (type == "log" ? "" : WebForms.GS + type)) }
    public func consoleMessageAssert(_ text: String, _ condition: String) { add("ma", text.replacingOccurrences(of: "\n", with: "$[ln];") + WebForms.GS + condition) }

    // Enable
    // Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
    public func enableWebSocket(_ enable: Bool = true) { add("ew", enable ? "1" : "0") }
    public func enableWebSocketOnce() { add("ew", "$") }
    public func addWebSocket(_ path: String) { add("aw" + path) }
    // Disconnected WebSocket
    public func deleteWebSocket(_ path: String) { add("dw" + path) }

    // Use
    // InputPlace Using Only For form Element
    public func useWebSocket(_ inputPlace: String) { add("uw" + inputPlace) }
    public func useOnlyChangeUpdate(_ inputPlace: String) { add("uo" + inputPlace) }

    // Condition And Loop
    // Condition And Loop Supports Brackets and Then
    // Type: warning, problem, help, success, none
    // Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
    // Nested Conditions and Nested Loops are Possible.
    @discardableResult
    public func confirmIsTrueAccept(_ text: String = "Are you sure you want to proceed?", _ type: String = "none", _ title: String = "Confirm", _ okText: String = "OK", _ cancelText: String = "Cancel", _ interval: Int = 100) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "ct", (text == "Are you sure you want to proceed?" ? "" : text) + WebForms.GS + (type == "none" ? "" : type) + WebForms.GS + (title == "Confirm" ? "" : title) + WebForms.GS + (okText == "OK" ? "" : okText) + WebForms.GS + (cancelText == "Cancel" ? "" : cancelText))
        return self
    }
    @discardableResult
    public func confirmIsFalseAccept(_ text: String = "Are you sure you want to proceed?", _ type: String = "none", _ title: String = "Confirm", _ okText: String = "OK", _ cancelText: String = "Cancel", _ interval: Int = 100) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "cf", (text == "Are you sure you want to proceed?" ? "" : text) + WebForms.GS + (type == "none" ? "" : type) + WebForms.GS + (title == "Confirm" ? "" : title) + WebForms.GS + (okText == "OK" ? "" : okText) + WebForms.GS + (cancelText == "Cancel" ? "" : cancelText))
        return self
    }
    @discardableResult
    public func isGreaterThan(_ firstValue: String, _ secondValue: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "gt", firstValue + WebForms.GS + secondValue)
        return self
    }
    @discardableResult
    public func isLessThan(_ firstValue: String, _ secondValue: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "lt", firstValue + WebForms.GS + secondValue)
        return self
    }
    @discardableResult
    public func isEqualTo(_ firstValue: String, _ secondValue: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "et", firstValue + WebForms.GS + secondValue)
        return self
    }
    @discardableResult
    public func isNotEqualTo(_ firstValue: String, _ secondValue: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "Nt", firstValue + WebForms.GS + secondValue)
        return self
    }
    @discardableResult
    public func exist(_ value: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "ex", value)
        return self
    }
    @discardableResult
    public func notExist(_ value: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "nx", value)
        return self
    }
    @discardableResult
    public func isTrue(_ value: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "tr", value)
        return self
    }
    @discardableResult
    public func isFalse(_ value: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "fa", value)
        return self
    }
    @discardableResult
    public func isMatchMedia(_ value: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "mm", value)
        return self
    }
    @discardableResult
    public func isNotMatchMedia(_ value: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "nm", value)
        return self
    }
    @discardableResult
    public func include(_ text: String, _ value: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "In", value + WebForms.GS + text)
        return self
    }
    @discardableResult
    public func notInclude(_ text: String, _ value: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "Nn", value + WebForms.GS + text)
        return self
    }
    @discardableResult
    public func elementExists(_ inputPlace: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "eE", inputPlace)
        return self
    }
    @discardableResult
    public func elementNotExists(_ inputPlace: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "nE", inputPlace)
        return self
    }
    @discardableResult
    public func isRegexMatch(_ value: String, _ pattern: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "re", value + WebForms.GS + pattern)
        return self
    }
    @discardableResult
    public func isRegexNotMatch(_ value: String, _ pattern: String, _ interval: Int = -1) -> WebForms {
        add((interval >= 0 ? "{(" + String(interval) + ")" : "{") + "rn", value + WebForms.GS + pattern)
        return self
    }
    // In: Everything Becomes A JSON List.
    // Key: Creates A Temporary Data In The Browser IndexedDB.
    // Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
    @discardableResult
    public func forEach(_ path: String, _ `in`: String, _ key: String = ".") -> WebForms {
        add("{fe", path + WebForms.GS + `in` + WebForms.GS + key)
        return self
    }
    public func `break`() { add(";") }
    @discardableResult
    public func `else`() -> WebForms {
        add("}e")
        return self
    }
    public func startBracket() { add("{") }
    public func endBracket() { add("}") }
    // Used Then In Condition And Loop Methods
    @discardableResult
    public func then(_ newForm: WebForms?) -> WebForms {
        let data = newForm?.getWebFormsData()
        if let data = data, !data.isEmpty {
            if data.contains("\n") {
                newForm?.addToUp("{")
                newForm?.add("}")
            }
        }
        appendForm(newForm)
        return self
    }

    @discardableResult
    public func then(_ configure: (WebForms) -> Void) -> WebForms {
        let newForm = WebForms()
        configure(newForm)
        let data = newForm.getWebFormsData()
        if !data.isEmpty {
            if data.contains("\n") {
                newForm.addToUp("{")
                newForm.add("}")
            }
        }
        appendForm(newForm)
        return self
    }

    @discardableResult
    public func `repeat`(_ newForm: WebForms?, _ `repeat`: Int) -> WebForms {
        guard let newForm = newForm else {
            return self
        }
        let bodyData = newForm.getWebFormsData()
        if bodyData.isEmpty {
            return self
        }
        let startLine = bodyData.split(separator: "\n", omittingEmptySubsequences: false).count * -1
        appendForm(newForm)
        goTo(startLine, `repeat` - 1)
        return self
    }
    
    @discardableResult
    public func `repeat`(_ newForm: WebForms?, _ `repeat`: Int, _ index: String) -> WebForms {
        guard let newForm = newForm else {
            return self
        }
        goTo(index)
        startIndex(index)
        let bodyData = newForm.getWebFormsData()
        if bodyData.isEmpty {
            return self
        }
        appendForm(newForm)
        if index.isEmpty {
            var indexNumber = -1
            for x in getWebFormsData().split(separator: "\n", omittingEmptySubsequences: false) {
                if x.hasPrefix("#") {
                    indexNumber += 1
                }
            }
            goTo(indexNumber, `repeat` - 1)
        } else {
            goTo(index, `repeat` - 1)
        }
        return self
    }

    @discardableResult
    public func `repeat`(_ configure: (WebForms) -> Void, _ `repeat`: Int) -> WebForms {
        let newForm = WebForms()
        configure(newForm)
        return self.`repeat`(newForm, `repeat`)
    }
    
    @discardableResult
    public func `repeat`(_ configure: (WebForms) -> Void, _ `repeat`: Int, _ index: String) -> WebForms {
        let newForm = WebForms()
        configure(newForm)
        return self.`repeat`(newForm, `repeat`, index)
    }

    // Async
    // It Supports Brackets and Then
    @discardableResult
    public func `async`() -> WebForms {
        add("{(a)")
        return self
    }
    public func delay(_ miliSecond: String) { add("De", miliSecond) }
    public func delay(_ miliSecond: Int) { delay(String(miliSecond)) }

    // Option
    public func changeOption(_ name: String, _ value: String) { add("co", name + WebForms.GS + value) }
    public func resetOption() { add("ro") }
    public func resetOption(_ name: String) { add("ro", name) }

    // Format Storage
    public func createFormatStorage(_ key: String, _ data: String) { add(".C", key + WebForms.GS + data) }
    public func deleteFormatStorage(_ key: String) { add(".D", key) }
    public func addJSON(_ key: String, _ path: String, _ value: String) { add(".a", key + WebForms.GS + "j" + WebForms.GS + value + WebForms.GS + path) }
    // Name: For Support Attribute, Set Double At Sign (@@) Before Name.
    public func addXML(_ key: String, _ path: String, _ name: String, _ value: String? = nil) { add(".a", key + WebForms.GS + "x" + WebForms.GS + name + WebForms.GS + value + WebForms.GS + path) }
    public func addINI(_ key: String, _ path: String, _ value: String, _ isINILike: Bool = false) { add(".a", key + WebForms.GS + "i" + WebForms.GS + (isINILike ? "1" : "0") + WebForms.GS + value + WebForms.GS + path) }
    public func addTextLine(_ key: String, _ line: String, _ text: String) { add(".a", key + WebForms.GS + "t" + WebForms.GS + text + WebForms.GS + line) }
    public func addTextLine(_ key: String, _ line: Int, _ text: String) { addTextLine(key, String(line), text) }
    public func addVariable(_ key: String, _ value: String) { add(".a", key + WebForms.GS + "v" + WebForms.GS + value) }
    public func updateJSON(_ key: String, _ path: String, _ value: String) { add(".u", key + WebForms.GS + "j" + WebForms.GS + value + WebForms.GS + path) }
    public func updateXML(_ key: String, _ path: String, _ value: String) { add(".u", key + WebForms.GS + "x" + WebForms.GS + value + WebForms.GS + path) }
    public func updateINI(_ key: String, _ path: String, _ value: String, _ isINILike: Bool = false) { add(".u", key + WebForms.GS + "i" + WebForms.GS + (isINILike ? "1" : "0") + WebForms.GS + value + WebForms.GS + path) }
    public func updateTexLine(_ key: String, _ line: String, _ text: String) { add(".u", key + WebForms.GS + "t" + WebForms.GS + text + WebForms.GS + line) }
    public func updateTexLine(_ key: String, _ line: Int, _ text: String) { updateTexLine(key, String(line), text) }
    public func updateVariable(_ key: String, _ value: String) { add(".u", key + WebForms.GS + "v" + WebForms.GS + value) }
    public func increaseVariable(_ key: String, _ value: String) { add(".i", key + WebForms.GS + "v" + WebForms.GS + value) }
    public func increaseVariable(_ key: String, _ value: Int) { increaseVariable(key, String(value)) }
    public func decreaseVariable(_ key: String, _ value: Int) { increaseVariable(key, value * -1) }
    public func deleteJSON(_ key: String, _ path: String) { add(".d", key + WebForms.GS + "j" + WebForms.GS + path) }
    public func deleteXML(_ key: String, _ path: String) { add(".d", key + WebForms.GS + "x" + WebForms.GS + path) }
    public func deleteINI(_ key: String, _ path: String, _ isINILike: Bool = false) { add(".d", key + WebForms.GS + "i" + WebForms.GS + String(isINILike) + WebForms.GS + path) }
    public func deleteTextLine(_ key: String, _ line: String) { add(".d", key + WebForms.GS + "t" + WebForms.GS + line) }
    public func deleteTextLine(_ key: String, _ line: Int) { deleteTextLine(key, String(line)) }
    public func deleteVariable(_ key: String) { add(".d", key + WebForms.GS + "v") }

    // Template Engine
    // Pattern Example: {{value}}, ((value)), *value*, $value;
    public func bindJSONToTemplate(_ inputPlace: String, _ jsonText: String, _ path: String, _ pattern: String, _ alsoStartTag: Bool = true) { add("Tj" + inputPlace, jsonText + WebForms.GS + path + WebForms.GS + pattern + WebForms.GS + (alsoStartTag ? "1" : "0")) }
    // Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
    public func bindXMLToTemplate(_ inputPlace: String, _ xmlText: String, _ path: String, _ pattern: String, _ alsoStartTag: Bool = true) { add("Tx" + inputPlace, xmlText + WebForms.GS + path + WebForms.GS + pattern + WebForms.GS + (alsoStartTag ? "1" : "0")) }
    public func bindINIToTemplate(_ inputPlace: String, _ iniText: String, _ path: String, _ pattern: String, _ alsoStartTag: Bool = true) { add("Ti" + inputPlace, iniText + WebForms.GS + path + WebForms.GS + pattern + WebForms.GS + (alsoStartTag ? "1" : "0")) }

    // Inject
    // Need Add @: to First of String
    public func inject(_ value: String) -> String { "$[" + value + "];" }

    // Action Control
    public func replaceActionControl(_ searchValue: String, _ value: String, _ addingToUp: Bool = false) {
        if addingToUp {
            addToUp("rE", searchValue + WebForms.GS + value)
        } else {
            add("rE", searchValue + WebForms.GS + value)
        }
    }
    
    public func assignReplace(_ searchValue: String, _ value: String, _ index: Int = -1) {
        let currentLine = getLineByIndex(index)
        if currentLine.isEmpty {
            return
        }
        let parts = currentLine.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false).map(String.init)
        let newName = ";" + searchValue + WebForms.GS + value + WebForms.GS + parts[0]
        let newValue = parts.count > 1 ? parts[1] : ""
        updateLineByIndex(index, newName, newValue)
    }

    // Hash And Checksum
    public func setHash() { add("SH") }
    public func setChecksum() { add("CS") }

    public func checksumCalculation(_ text: String) -> String {
        var sum: Int32 = 0
        let mod: Int32 = 65536
        let shift: Int32 = 5

        for c in text.utf16 {
            sum = ((sum << shift) | (sum >> (16 - shift))) ^ Int32(c)
            sum %= mod
        }

        return String(sum)
    }

    public func getChecksum() -> String { checksumCalculation(getWebFormsData()) }

    // Get
    public func getFormsActionData() -> String {
        if webFormsData.isEmpty {
            return ""
        }
        return webFormsData
    }

    public func response() -> String {
        return "[web-forms]\n" + getFormsActionData()
    }

    public func getFormsActionDataLineBreak() -> String {
        if webFormsData.isEmpty {
            return ""
        }
        let data = webFormsData
        let processedData = data.replacingOccurrences(of: "\"", with: "$[dq];")
        return processedData.replacingOccurrences(of: "\n", with: "$[sln];")
    }

    // Export
    public func exportToHtmlComment(_ addLine: Bool = false) -> String {
        var response = response().replacingOccurrences(of: "--", with: "$[dd];")
        if response.hasSuffix("-") {
            response = String(response.dropLast()) + "$[da];"
        }
        return (addLine ? "\n" : "") + "<!--" + response + "-->"
    }

    // Using it for SSE Response
    public func exportToLineBreak(_ src: String? = nil) -> String {
        return "[web-forms]$[sln];" + getFormsActionDataLineBreak()
    }

    public func getWebFormsData() -> String {
        return webFormsData
    }

    public func appendForm(_ form: WebForms?) {
        guard let form = form else {
            return
        }
        let otherData = form.getWebFormsData()
        if !otherData.isEmpty {
            if !webFormsData.isEmpty {
                webFormsData.append("\n")
            }
            webFormsData.append(otherData)
        }
    }

    public func clean() {
        webFormsData = ""
    }
}

class Security {
    public func safeValue(_ value: String) -> String {
        if value.isEmpty {
            return value
        }

        var value = value

        if value.hasPrefix("@") {
            value = "@" + value
        }

        value = value
            .replacingOccurrences(of: "\n", with: "$[ln];")
            .replacingOccurrences(of: ",@", with: "$[co];@")
            .replacingOccurrences(of: "\u{1C}", with: "\0")
            .replacingOccurrences(of: "\u{1D}", with: "\0")
            .replacingOccurrences(of: "\u{1E}", with: "\0")
            .replacingOccurrences(of: "\u{1F}", with: "\0")

        return value
    }
}

// WebForms Place Criteria (WPC) DSL
class InputPlace {
    public static let document = ","
    public static let window = "`"
    // When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
    public static let root = "~"
    public static let html = "."
    public static let head = "^"
    public static let screenOrientation = "%"
    public static let all = "*"
    public static let parent = "/"
    public static let current = "$"
    public static let target = "!"
    public static let upper = "-"

    public static func id(_ id: String) -> String { id }
    public static func name(_ name: String) -> String { "(" + name + ")" }
    public static func name(_ name: String, _ index: Int) -> String { "(" + name + ")" + String(index) }
    public static func allNames(_ name: String) -> String { "(" + name + ")*" }
    public static func tag(_ tag: String) -> String { "<" + tag + ">" }
    public static func tag(_ tag: String, _ index: Int) -> String { "<" + tag + ">" + String(index) }
    public static func allTags(_ tag: String) -> String { "<" + tag + ">*" }
    public static func child() -> String { "<>" }
    public static func child(_ index: Int) -> String { "<>" + String(index) }
    public static func allChild() -> String { "<>*" }
    public static func `class`(_ `class`: String) -> String { "{" + `class` + "}" }
    public static func `class`(_ `class`: String, _ index: Int) -> String { "{" + `class` + "}" + String(index) }
    public static func allClasses(_ `class`: String) -> String { "{" + `class` + "}*" }
    public static func attribute(_ name: String) -> String { "\"" + name + "\"" }
    public static func attribute(_ name: String, _ index: Int) -> String { "\"" + name + "\"" + String(index) }
    public static func allAttributes(_ name: String) -> String { "\"" + name + "\"*" }
    // Operator: '^', '$', '*', '~'
    public static func attribute(_ name: String, _ value: String, _ `operator`: Character = "\0") -> String { "\"" + name + (`operator` != "\0" ? String(`operator`) : "") + "'" + value + "\"" }
    public static func attribute(_ name: String, _ value: String, _ index: Int, _ `operator`: Character = "\0") -> String { "\"" + name + (`operator` != "\0" ? String(`operator`) : "") + "'" + value + "\"" + String(index) }
    public static func allAttributes(_ name: String, _ value: String, _ `operator`: Character = "\0") -> String { "\"" + name + (`operator` != "\0" ? String(`operator`) : "") + "'" + value + "\"*" }
    public static func query(_ query: String) -> String { "*" + query.replacingOccurrences(of: "=", with: "$[eq];").replacingOccurrences(of: "|", with: "$[vb];").replacingOccurrences(of: "?", with: "$[qu];") }
    public static func queryAll(_ query: String) -> String { "[" + query.replacingOccurrences(of: "=", with: "$[eq];").replacingOccurrences(of: "|", with: "$[vb];").replacingOccurrences(of: "?", with: "$[qu];") }
}

class OutputPlace: InputPlace {}

// Do not Add any Data Before or After it
class Fetch {
    private static let RS = "\u{1E}"
    private static let US = "\u{1F}"

    // Method
    public static func random(_ maxValue: Int) -> String { "@mr" + String(maxValue) }
    public static func random(_ minValue: Int, _ maxValue: Int) -> String { "@mr" + String(maxValue) + RS + String(minValue) }
    public static func spaceToChar(_ text: String, _ character: String = "-") -> String { "@sc" + character + RS + text }
    public static func encodeURI(_ text: String) -> String { "@ue" + text }
    public static func decodeURI(_ text: String) -> String { "@ud" + text }

    public static func method(_ methodName: String, _ args: [Any]? = nil) -> String {
        var returnValue = "@cm" + methodName

        if let args = args {
            returnValue += args.count > 0 ? RS + args.map { "\($0)" }.joined(separator: US) : ""
        }

        return returnValue
    }

    public static func moduleMethod(_ methodName: String, _ args: [Any]? = nil) -> String {
        var returnValue = "@cM" + methodName

        if let args = args {
            returnValue += args.count > 0 ? RS + args.map { "\($0)" }.joined(separator: US) : ""
        }

        return returnValue
    }

    // MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
    public static func wasmMethod(_ wasmLanguage: String, _ wasmUrl: String, _ methodName: String, _ args: [Any]? = nil, _ key: String = ".") -> String {
        var returnValue = "@wA" + wasmLanguage + RS + wasmUrl + RS + methodName

        if let args = args {
            returnValue += args.count > 0 ? RS + args.map { "\($0)" }.joined(separator: US) : ""
        }

        return returnValue
    }

    public static func script(_ scriptText: String) -> String { "@_" + scriptText.replacingOccurrences(of: "\n", with: "$[ln];") }
    public static func loadUrl(_ url: String, _ fetchScript: Bool = false) -> String { "@lu" + url + (fetchScript ? RS + "1" : "") }
    public static func loadHtml(_ url: String, _ fetchInputPlace: String = "", _ fetchScript: Bool = false) -> String { "@lh" + url + RS + (fetchScript ? "1" : "0") + (!fetchInputPlace.isEmpty ? RS + fetchInputPlace : "") }
    public static func loadLine(_ url: String, _ line: Int) -> String { "@ll" + url + RS + String(line) }
    public static func loadINI(_ url: String, _ name: String, _ isINILike: Bool = false) -> String { "@li" + url + RS + name + (isINILike ? RS + "1" : "") }
    // Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
    public static func loadJSON(_ url: String, _ name: String) -> String { "@lj" + url + RS + name }
    // Name: Name Or XPath; XPath Index Starts At 1
    public static func loadXML(_ url: String, _ name: String) -> String { "@lx" + url + RS + name }
    // MethodName: It's Check Function Or Variable
    public static func hasMethod(_ methodName: String) -> String { "@hm" + methodName }
    public static func hasModuleMethod(_ methodName: String) -> String { "@hM" + methodName }
    // This Method Return True Or False If Key Pressed
    // Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
    public static func getModifierState(_ modifier: String) -> String { "@ms" + modifier }

    // Math
    public static func math(_ methodName: String, _ args: [Any]? = nil) -> String {
        var returnValue = "@M#" + methodName

        if let args = args {
            returnValue += args.count > 0 ? RS + args.map { "\($0)" }.joined(separator: US) : ""
        }

        return returnValue
    }

    // Data
    public static let dateYear = "@dy"
    // Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1 
    public static let dateMonth = "@dm"
    public static let dateDay = "@dd"
    public static let dateDate = "@dD"
    public static let dateHours = "@dh"
    public static let dateMinutes = "@di"
    public static let dateSeconds = "@ds"
    public static let dateMilliseconds = "@dl"

    // String
    public static let space = "@sp"
    public static let atSign = "@sa"

    // Tag
    public static func getId(_ inputPlace: String) -> String { "@$i" + inputPlace }
    public static func getName(_ inputPlace: String) -> String { "@$n" + inputPlace }
    public static func getValue(_ inputPlace: String) -> String { "@$v" + inputPlace }
    public static func getValueLength(_ inputPlace: String) -> String { "@$e" + inputPlace }
    public static func getClass(_ inputPlace: String) -> String { "@$c" + inputPlace }
    public static func getStyle(_ inputPlace: String) -> String { "@$s" + inputPlace }
    public static func getTitle(_ inputPlace: String) -> String { "@$l" + inputPlace }
    public static func getLabel(_ inputPlace: String) -> String { "@$A" + inputPlace }
    public static func getText(_ inputPlace: String) -> String { "@$t" + inputPlace }
    public static func getOuterText(_ inputPlace: String) -> String { "@$o" + inputPlace }
    public static func getTextLength(_ inputPlace: String) -> String { "@$g" + inputPlace }
    public static func getAttribute(_ inputPlace: String, _ attribute: String) -> String { "@$a" + inputPlace + RS + attribute }
    public static func getWidth(_ inputPlace: String) -> String { "@$w" + inputPlace }
    public static func getHeight(_ inputPlace: String) -> String { "@$h" + inputPlace }
    public static func getIsReadOnly(_ inputPlace: String) -> String { "@$r" + inputPlace }
    public static func getSelectedIndex(_ inputPlace: String) -> String { "@$x" + inputPlace }
    public static func getIndex(_ inputPlace: String) -> String { "@$I" + inputPlace }
    public static func getTextAlign(_ inputPlace: String) -> String { "@$T" + inputPlace }
    public static func getNodeLength(_ inputPlace: String) -> String { "@$L" + inputPlace }
    public static func getIsVisible(_ inputPlace: String) -> String { "@$V" + inputPlace }

    // Save
    public static func hasHash(_ hash: String) -> String { "@HH" + hash }
    public static func cookie(_ key: String) -> String { "@co" + key }
    public static func save(_ key: String = ".") -> String { "@cs" + key }
    public static func save(_ key: String, _ replaceValue: String) -> String { "@cs" + key + RS + replaceValue }
    public static func saveThenRemove(_ key: String) -> String { "@cl" + key }
    public static func saveLength(_ key: String = ".") -> String { "@cg" + key }
    public static func cache(_ key: String = ".") -> String { "@cd" + key }
    public static func cache(_ key: String, _ replaceValue: String) -> String { "@cd" + key + RS + replaceValue }
    public static func cacheThenRemove(_ key: String) -> String { "@ct" + key }
    public static func cacheLength(_ key: String = ".") -> String { "@cG" + key }
    public static func saveLine(_ key: String = ".", _ line: Int = 0) -> String { "@lL" + key + "[" + String(line) }
    public static func saveLineConsume(_ key: String = ".") -> String { "@lL" + key }
    // INIKey: Only Direct Key is Supported
    public static func saveINI(_ key: String, _ iniKey: String) -> String { "@lI" + key + "[" + iniKey }
    public static func cacheLine(_ key: String = ".", _ line: Int = 0) -> String { "@dL" + key + "[" + String(line) }
    public static func cacheLineConsume(_ key: String = ".") -> String { "@dL" + key }
    // INIKey: Only Direct Key is Supported
    public static func cacheINI(_ key: String, _ iniKey: String) -> String { "@dI" + key + "[" + iniKey }

    // Format Storage
    public static func formatStore(_ key: String) -> String { "@fr" + key }
    public static func formatStoreByXMLQuery(_ key: String, _ xPath: String) -> String { "@fx" + key + RS + xPath }
    public static func formatStoreByJSONQuery(_ key: String, _ query: String) -> String { "@fj" + key + RS + query }
    public static func formatStoreByINI(_ key: String, _ name: String) -> String { "@fi" + key + RS + name }
    public static func formatStoreByText(_ key: String, _ line: Int) -> String { "@ft" + key + RS + String(line) }
    public static func formatStoreByVariable(_ key: String) -> String { "@fv" + key }

    // State
    public static func hasState(_ path: String) -> String { "@hs" + path }

    // SSE
    public static func sseIsConnected(_ path: String) -> String { "@Sc" + path }

    // WebSockets
    public static func webSocketsIsConnected(_ path: String = "") -> String { "@Wc" + path }

    // Document
    public static let tabIsActive = "@da"

    // Window
    public static let href = "@wf"
    public static let pathName = "@wP"
    public static func query(_ name: String = "*") -> String { "@wq" + name }
    public static let hash = "@wh"
    public static let host = "@wH"
    public static let hostName = "@wn"
    public static let port = "@wT"
    public static let origin = "@wo"
    public static let getSelection = "@ws"
    public static let scrollX = "@wx"
    public static let scrollY = "@wy"
    public static func segment(_ index: Int) -> String { "@wS" + String(index) }
    // It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
    public static func hashSegment(_ index: Int) -> String { "@wt" + String(index) }

    // Navigator
    public static let clipboardText = "@nC"
    public static let geoLatitude = "@nW"
    public static let geoLongitude = "@nO"
    public static let language = "@nL"
    public static let isOnLine = "@no"
    public static let userAgent = "@na"

    // Screen
    public static let screenWidth = "@sw"
    public static let screenHeight = "@sh"
    public static let screenOrientationType = "@so"
    public static let screenOrientationAngle = "@sr"

    // Performance
    public static let timeOrigin = "@pt"
    public static let performanceNow = "@pn"

    // Event
    public static let event = "@EV"
    public static let eventSerialize = "@Es"
    public static let eventKey = "@ek"
    public static let eventWhich = "@ew"
    public static let eventClientX = "@ex"
    public static let eventClientY = "@ey"
    public static let eventPageX = "@eX"
    public static let eventPageY = "@eY"
    public static let eventOffsetX = "@Ex"
    public static let eventOffsetY = "@Ey"
    public static let eventDeltaY = "@ed"
}

enum WasmLanguage {
    // The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
    public static let c = "c"
    public static let cpp = "c"
    public static let rust = "rust"
    public static let cSharp = "csharp"
    // .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
    public static let cSharpMediator = "csharp-m"
    public static let go = "go"
    public static let java = "java"
    public static let assemblyScript = "as"
}

enum HtmlEvent {
    public static let onAbort = "onabort"
    public static let onAfterPrint = "onafterprint"
    public static let onBeforePrint = "onbeforeprint"
    public static let onBeforeUnload = "onbeforeunload"
    public static let onBlur = "onblur"
    public static let onCanPlay = "oncanplay"
    public static let onCanPlayThrough = "oncanplaythrough"
    public static let onChange = "onchange"
    public static let onClick = "onclick"
    public static let onCopy = "oncopy"
    public static let onCut = "oncut"
    public static let onDoubleClick = "ondblclick"
    public static let onDrag = "ondrag"
    public static let onDragEnd = "ondragend"
    public static let onDragEnter = "ondragenter"
    public static let onDragLeave = "ondragleave"
    public static let onDragOver = "ondragover"
    public static let onDragStart = "ondragstart"
    public static let onDrop = "ondrop"
    public static let onDurationChange = "ondurationchange"
    public static let onEnded = "onended"
    public static let onError = "onerror"
    public static let onFocus = "onfocus"
    public static let onFocusin = "onfocusin"
    public static let onFocusOut = "onfocusout"
    public static let onHashChange = "onhashchange"
    public static let onInput = "oninput"
    public static let onInvalid = "oninvalid"
    public static let onKeyDown = "onkeydown"
    public static let onKeyPress = "onkeypress"
    public static let onKeyUp = "onkeyup"
    public static let onLoad = "onload"
    public static let onLoadedData = "onloadeddata"
    public static let onLoadedMetaData = "onloadedmetadata"
    public static let onLoadStart = "onloadstart"
    public static let onMouseDown = "onmousedown"
    public static let onMouseEnter = "onmouseenter"
    public static let onMouseLeave = "onmouseleave"
    public static let onMouseMove = "onmousemove"
    public static let onMouseOver = "onmouseover"
    public static let onMouseOut = "onmouseout"
    public static let onMouseUp = "onmouseup"
    public static let onOffline = "onoffline"
    public static let onOnline = "ononline"
    public static let onPageHide = "onpagehide"
    public static let onPageShow = "onpageshow"
    public static let onPaste = "onpaste"
    public static let onPause = "onpause"
    public static let onPlay = "onplay"
    public static let onPlaying = "onplaying"
    public static let onProgress = "onprogress"
    public static let onRateChange = "onratechange"
    public static let onResize = "onresize"
    public static let onReset = "onreset"
    public static let onScroll = "onscroll"
    public static let onSearch = "onsearch"
    public static let onSeeked = "onseeked"
    public static let onSeeking = "onseeking"
    public static let onSelect = "onselect"
    public static let onStalled = "onstalled"
    public static let onSubmit = "onsubmit"
    public static let onSuspend = "onsuspend"
    public static let onTimeUpdate = "ontimeupdate"
    public static let onToggle = "ontoggle"
    public static let onTouchCancel = "ontouchcancel"
    public static let onTouchend = "ontouchend"
    public static let onTouchMove = "ontouchmove"
    public static let onTouchStart = "ontouchstart"
    public static let onUnload = "onunload"
    public static let onVolumeChange = "onvolumechange"
    public static let onWaiting = "onwaiting"
    public static let onWheel = "onwheel"
}

enum HtmlEventListener {
    public static let abort = "abort"
    public static let afterPrint = "afterprint"
    public static let beforePrint = "beforeprint"
    public static let beforeUnload = "beforeunload"
    public static let blur = "blur"
    public static let canPlay = "canplay"
    public static let canPlayThrough = "canplaythrough"
    public static let change = "change"
    public static let click = "click"
    public static let copy = "copy"
    public static let cut = "cut"
    public static let doubleClick = "dblclick"
    public static let drag = "drag"
    public static let dragEnd = "dragend"
    public static let dragEnter = "dragenter"
    public static let dragLeave = "dragleave"
    public static let dragOver = "dragover"
    public static let dragStart = "dragstart"
    public static let drop = "drop"
    public static let durationChange = "durationchange"
    public static let ended = "ended"
    public static let error = "error"
    public static let focus = "focus"
    public static let focusin = "focusin"
    public static let focusOut = "focusout"
    public static let hashChange = "hashchange"
    public static let input = "input"
    public static let invalid = "invalid"
    public static let keyDown = "keydown"
    public static let keyPress = "keypress"
    public static let keyUp = "keyup"
    public static let load = "load"
    public static let loadedData = "loadeddata"
    public static let loadedMetaData = "loadedmetadata"
    public static let loadStart = "loadstart"
    public static let mouseDown = "mousedown"
    public static let mouseEnter = "mouseenter"
    public static let mouseLeave = "mouseleave"
    public static let mouseMove = "mousemove"
    public static let mouseOver = "mouseover"
    public static let mouseOut = "mouseout"
    public static let mouseUp = "mouseup"
    public static let offline = "offline"
    public static let online = "online"
    public static let pageHide = "pagehide"
    public static let pageShow = "pageshow"
    public static let paste = "paste"
    public static let pause = "pause"
    public static let play = "play"
    public static let playing = "playing"
    public static let progress = "progress"
    public static let rateChange = "ratechange"
    public static let resize = "resize"
    public static let reset = "reset"
    public static let scroll = "scroll"
    public static let search = "search"
    public static let seeked = "seeked"
    public static let seeking = "seeking"
    public static let select = "select"
    public static let stalled = "stalled"
    public static let submit = "submit"
    public static let suspend = "suspend"
    public static let timeUpdate = "timeupdate"
    public static let toggle = "toggle"
    public static let touchCancel = "touchcancel"
    public static let touchend = "touchend"
    public static let touchMove = "touchmove"
    public static let touchStart = "touchstart"
    public static let unload = "unload"
    public static let volumeChange = "volumechange"
    public static let waiting = "waiting"
    public static let wheel = "wheel"

    public static let animationEnd = "animationend"
    public static let animationIteration = "animationiteration"
    public static let animationStart = "animationstart"
    public static let contextMenu = "contextmenu"
    public static let fullScreenChange = "fullscreenchange"
    public static let fullScreenError = "fullscreenerror"
    public static let popState = "popstate"
    public static let transitionEnd = "transitionend"
    public static let storage = "storage"

    // Custom
    public static let scrollBottom = "scrollbottom" // Need Call EnableScrollBottomEvent Method Before
    public static let elementReached = "elementreached" // Need Call EnableReachedElementEvent Method Before
}

extension String {
    public func child(_ value: String) -> String {
        if self.isEmpty {
            return value
        }
        return self + "|" + value
    }

    public func parent() -> String {
        if self.isEmpty {
            return self
        }
        if self.hasSuffix("|/") || self.hasSuffix("//") {
            return self + "/"
        }
        return self + "|/"
    }

    public func criteria(_ value: String) -> String {
        if self.isEmpty {
            return value
        }
        return self + "?" + value.replacingOccurrences(of: "|", with: "$[vb];").replacingOccurrences(of: "?", with: "$[qu];")
    }

    public func appendFetchReplace(_ searchValue: String, _ value: String) -> String {
        let FS = "\u{1C}"

        let text = String(self.dropFirst())
        return "@;" + searchValue + FS + value + FS + text
    }

    public func lineBreak(_ encodeLine: Bool = false) -> String {
        let encode = encodeLine ? "$[sln];" : ""
        return self.replacingOccurrences(of: "\r\n", with: encode).replacingOccurrences(of: "\n", with: encode).replacingOccurrences(of: "\r", with: encode)
    }

    // Converts Numbers to Strings
    public func toJSString() -> String {
        return "\"" + self + "\""
    }

    // Get JS Object Momentary 
    public func toJSObject() -> String {
        return "$" + self
    }

    // Get JS Object Returned Value Once
    public func toJSReturnObject() -> String {
        return "$@" + self
    }
}
