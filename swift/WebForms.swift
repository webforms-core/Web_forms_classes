// Compatible with WebFormsJS version 1.6

import Foundation

class WebForms {
    private var webFormsData = NameValueCollection()
    
    // For Extension
    func addLine(name: String, value: String) {
        webFormsData.add(name: name, value: value)
    }
    
    // Add
    func addId(inputPlace: String, id: String) {
        webFormsData.add(name: "ai" + inputPlace, value: id)
    }
    
    func addName(inputPlace: String, name: String) {
        webFormsData.add(name: "an" + inputPlace, value: name)
    }
    
    func addValue(inputPlace: String, value: String) {
        webFormsData.add(name: "av" + inputPlace, value: value)
    }
    
    func addClass(inputPlace: String, className: String) {
        webFormsData.add(name: "ac" + inputPlace, value: className)
    }
    
    func addStyle(inputPlace: String, style: String) {
        webFormsData.add(name: "as" + inputPlace, value: style)
    }
    
    func addStyle(inputPlace: String, name: String, value: String) {
        webFormsData.add(name: "as" + inputPlace, value: "\(name):\(value)")
    }
    
    func addOptionTag(inputPlace: String, text: String, value: String, selected: Bool = false) {
        let selectedValue = selected ? "|1" : ""
        webFormsData.add(name: "ao" + inputPlace, value: "\(value)|\(text)\(selectedValue)")
    }
    
    func addCheckBoxTag(inputPlace: String, text: String, value: String, checked: Bool = false) {
        let checkedValue = checked ? "|1" : ""
        webFormsData.add(name: "ak" + inputPlace, value: "\(value)|\(text)\(checkedValue)")
    }
    
    func addTitle(inputPlace: String, title: String) {
        webFormsData.add(name: "al" + inputPlace, value: title)
    }
    
    func addText(inputPlace: String, text: String) {
        let modifiedText = text.replacingOccurrences(of: "\n", with: "$[ln];")
        webFormsData.add(name: "at" + inputPlace, value: modifiedText)
    }
    
    func addTextToUp(inputPlace: String, text: String) {
        let modifiedText = text.replacingOccurrences(of: "\n", with: "$[ln];")
        webFormsData.add(name: "pt" + inputPlace, value: modifiedText)
    }
    
    func addAttribute(inputPlace: String, attribute: String, value: String = "") {
        webFormsData.add(name: "aa" + inputPlace, value: "\(attribute)|\(value)")
    }
    
    func addTag(inputPlace: String, tagName: String, id: String = "") {
        let tagValue = !id.isEmpty ? "\(tagName)|\(id)" : tagName
        webFormsData.add(name: "nt" + inputPlace, value: tagValue)
    }
    
    func addTagToUp(inputPlace: String, tagName: String, id: String = "") {
        let tagValue = !id.isEmpty ? "\(tagName)|\(id)" : tagName
        webFormsData.add(name: "ut" + inputPlace, value: tagValue)
    }
    
    func addTagBefore(inputPlace: String, tagName: String, id: String = "") {
        let tagValue = !id.isEmpty ? "\(tagName)|\(id)" : tagName
        webFormsData.add(name: "bt" + inputPlace, value: tagValue)
    }
    
    func addTagAfter(inputPlace: String, tagName: String, id: String = "") {
        let tagValue = !id.isEmpty ? "\(tagName)|\(id)" : tagName
        webFormsData.add(name: "ft" + inputPlace, value: tagValue)
    }
    
    // Set
    func setId(inputPlace: String, id: String) {
        webFormsData.add(name: "si" + inputPlace, value: id)
    }
    
    func setName(inputPlace: String, name: String) {
        webFormsData.add(name: "sn" + inputPlace, value: name)
    }
    
    func setValue(inputPlace: String, value: String) {
        webFormsData.add(name: "sv" + inputPlace, value: value)
    }
    
    func setClass(inputPlace: String, className: String) {
        webFormsData.add(name: "sc" + inputPlace, value: className)
    }
    
    func setStyle(inputPlace: String, style: String) {
        webFormsData.add(name: "ss" + inputPlace, value: style)
    }
    
    func setStyle(inputPlace: String, name: String, value: String) {
        webFormsData.add(name: "ss" + inputPlace, value: "\(name):\(value)")
    }
    
    func setOptionTag(inputPlace: String, text: String, value: String, selected: Bool = false) {
        let selectedValue = selected ? "|1" : ""
        webFormsData.add(name: "so" + inputPlace, value: "\(value)|\(text)\(selectedValue)")
    }
    
    func setChecked(inputPlace: String, checked: Bool = false) {
        webFormsData.add(name: "sk" + inputPlace, value: checked ? "1" : "0")
    }
    
    func setCheckBoxTagToList(inputPlace: String, text: String, value: String, checked: Bool = false) {
        let checkedValue = checked ? "|1" : ""
        webFormsData.add(name: "sk" + inputPlace, value: "\(value)|\(text)\(checkedValue)")
    }
    
    func setTitle(inputPlace: String, title: String) {
        webFormsData.add(name: "sl" + inputPlace, value: title)
    }
    
    func setText(inputPlace: String, text: String) {
        let modifiedText = text.replacingOccurrences(of: "\n", with: "$[ln];")
        webFormsData.add(name: "st" + inputPlace, value: modifiedText)
    }
    
    func setAttribute(inputPlace: String, attribute: String, value: String = "") {
        webFormsData.add(name: "sa" + inputPlace, value: "\(attribute)|\(value)")
    }
    
    func setWidth(inputPlace: String, width: String) {
        webFormsData.add(name: "sw" + inputPlace, value: width)
    }
    
    func setWidth(inputPlace: String, width: Int) {
        setWidth(inputPlace: inputPlace, width: "\(width)px")
    }
    
    func setHeight(inputPlace: String, height: String) {
        webFormsData.add(name: "sh" + inputPlace, value: height)
    }
    
    func setHeight(inputPlace: String, height: Int) {
        setHeight(inputPlace: inputPlace, height: "\(height)px")
    }
    
    // Insert
    func insertId(inputPlace: String, id: String) {
        webFormsData.add(name: "ii" + inputPlace, value: id)
    }
    
    func insertName(inputPlace: String, name: String) {
        webFormsData.add(name: "in" + inputPlace, value: name)
    }
    
    func insertValue(inputPlace: String, value: String) {
        webFormsData.add(name: "iv" + inputPlace, value: value)
    }
    
    func insertClass(inputPlace: String, className: String) {
        webFormsData.add(name: "ic" + inputPlace, value: className)
    }
    
    func insertStyle(inputPlace: String, style: String) {
        webFormsData.add(name: "is" + inputPlace, value: style)
    }
    
    func insertStyle(inputPlace: String, name: String, value: String) {
        webFormsData.add(name: "is" + inputPlace, value: "\(name):\(value)")
    }
    
    func insertOptionTag(inputPlace: String, text: String, value: String, selected: Bool = false) {
        let selectedValue = selected ? "|1" : ""
        webFormsData.add(name: "io" + inputPlace, value: "\(value)|\(text)\(selectedValue)")
    }
    
    func insertCheckBoxTag(inputPlace: String, text: String, value: String, checked: Bool = false) {
        let checkedValue = checked ? "|1" : ""
        webFormsData.add(name: "ik" + inputPlace, value: "\(value)|\(text)\(checkedValue)")
    }
    
    func insertTitle(inputPlace: String, title: String) {
        webFormsData.add(name: "il" + inputPlace, value: title)
    }
    
    func insertText(inputPlace: String, text: String) {
        let modifiedText = text.replacingOccurrences(of: "\n", with: "$[ln];")
        webFormsData.add(name: "it" + inputPlace, value: modifiedText)
    }
    
    func insertAttribute(inputPlace: String, attribute: String, value: String = "") {
        webFormsData.add(name: "ia" + inputPlace, value: "\(attribute)|\(value)")
    }
    
    // Delete
    func deleteId(inputPlace: String) {
        webFormsData.add(name: "di" + inputPlace, value: "1")
    }
    
    func deleteName(inputPlace: String) {
        webFormsData.add(name: "dn" + inputPlace, value: "1")
    }
    
    func deleteValue(inputPlace: String) {
        webFormsData.add(name: "dv" + inputPlace, value: "1")
    }
    
    func deleteClass(inputPlace: String, className: String) {
        webFormsData.add(name: "dc" + inputPlace, value: className)
    }
    
    func deleteStyle(inputPlace: String, styleName: String) {
        webFormsData.add(name: "ds" + inputPlace, value: styleName)
    }
    
    func deleteOptionTag(inputPlace: String, value: String) {
        webFormsData.add(name: "do" + inputPlace, value: value)
    }
    
    func deleteAllOptionTag(inputPlace: String) {
        webFormsData.add(name: "do" + inputPlace, value: "*")
    }
    
    func deleteCheckBoxTag(inputPlace: String, value: String) {
        webFormsData.add(name: "dk" + inputPlace, value: value)
    }
    
    func deleteAllCheckBoxTag(inputPlace: String) {
        webFormsData.add(name: "dk" + inputPlace, value: "*")
    }
    
    func deleteTitle(inputPlace: String) {
        webFormsData.add(name: "dl" + inputPlace, value: "1")
    }
    
    func deleteText(inputPlace: String) {
        webFormsData.add(name: "dt" + inputPlace, value: "1")
    }
    
    func deleteAttribute(inputPlace: String, attribute: String) {
        webFormsData.add(name: "da" + inputPlace, value: attribute)
    }
    
    func delete(inputPlace: String) {
        webFormsData.add(name: "de" + inputPlace, value: "1")
    }
    
    func deleteParent(inputPlace: String) {
        webFormsData.add(name: "dp" + inputPlace, value: "1")
    }
    
    // Other
    func setBackgroundColor(inputPlace: String, color: String) {
        webFormsData.add(name: "bc" + inputPlace, value: color)
    }
    
    func setTextColor(inputPlace: String, color: String) {
        webFormsData.add(name: "tc" + inputPlace, value: color)
    }
    
    func setFontName(inputPlace: String, name: String) {
        webFormsData.add(name: "fn" + inputPlace, value: name)
    }
    
    func setFontSize(inputPlace: String, size: String) {
        webFormsData.add(name: "fs" + inputPlace, value: size)
    }
    
    func setFontSize(inputPlace: String, size: Int) {
        webFormsData.add(name: "fs" + inputPlace, value: "\(size)px")
    }
    
    func setFontBold(inputPlace: String, bold: Bool) {
        webFormsData.add(name: "fb" + inputPlace, value: bold ? "1" : "0")
    }
    
    func setVisible(inputPlace: String, visible: Bool) {
        webFormsData.add(name: "vi" + inputPlace, value: visible ? "1" : "0")
    }
    
    func setTextAlign(inputPlace: String, align: String) {
        webFormsData.add(name: "ta" + inputPlace, value: align)
    }
    
    func setReadOnly(inputPlace: String, readOnly: Bool) {
        webFormsData.add(name: "sr" + inputPlace, value: readOnly ? "1" : "0")
    }
    
    func setDisabled(inputPlace: String, disabled: Bool) {
        webFormsData.add(name: "sd" + inputPlace, value: disabled ? "1" : "0")
    }
    
    func setFocus(inputPlace: String, focus: Bool) {
        webFormsData.add(name: "sf" + inputPlace, value: focus ? "1" : "0")
    }
    
    func setMinLength(inputPlace: String, length: Int) {
        webFormsData.add(name: "mn" + inputPlace, value: "\(length)")
    }
    
    func setMaxLength(inputPlace: String, length: Int) {
        webFormsData.add(name: "mx" + inputPlace, value: "\(length)")
    }
    
    func setSelectedValue(inputPlace: String, value: String) {
        webFormsData.add(name: "ts" + inputPlace, value: value)
    }
    
    func setSelectedIndex(inputPlace: String, index: Int) {
        webFormsData.add(name: "ti" + inputPlace, value: "\(index)")
    }
    
    func setCheckedValue(inputPlace: String, value: String, selected: Bool) {
        webFormsData.add(name: "ks" + inputPlace, value: "\(value)|\(selected ? "1" : "0")")
    }
    
    func setCheckedIndex(inputPlace: String, index: Int, selected: Bool) {
        webFormsData.add(name: "ki" + inputPlace, value: "\(index)|\(selected ? "1" : "0")")
    }
    
    func callScript(scriptText: String) {
        let modifiedText = scriptText.replacingOccurrences(of: "\n", with: "$[ln];")
        webFormsData.add(name: "_", value: modifiedText)
    }
    
    func loadUrl(inputPlace: String, url: String) {
        webFormsData.add(name: "lu" + inputPlace, value: url)
    }
    
    func changeUrl(url: String) {
        webFormsData.add(name: "cu", value: url)
    }
    
    func removeSessionCache(cacheKey: String) {
        webFormsData.add(name: "rs", value: cacheKey)
    }
    
    func removeAllSessionCache() {
        webFormsData.add(name: "rs", value: "*")
    }
    
    func removeCache(cacheKey: String) {
        webFormsData.add(name: "rd", value: cacheKey)
    }
    
    func removeAllCache() {
        webFormsData.add(name: "rd", value: "*")
    }
    
    func setSessionCache() {
        webFormsData.add(name: "cs", value: "1")
    }
    
    func setCache(second: Int) {
        webFormsData.add(name: "cd", value: "\(second)")
    }
    
    func setCache() {
        webFormsData.add(name: "cd", value: "*")
    }
    
    // Increase
    func increaseMinLength(inputPlace: String, value: Int) {
        webFormsData.add(name: "+n" + inputPlace, value: "\(value)")
    }
    
    func increaseMaxLength(inputPlace: String, value: Int) {
        webFormsData.add(name: "+x" + inputPlace, value: "\(value)")
    }
    
    func increaseFontSize(inputPlace: String, value: Int) {
        webFormsData.add(name: "+f" + inputPlace, value: "\(value)")
    }
    
    func increaseWidth(inputPlace: String, value: Int) {
        webFormsData.add(name: "+w" + inputPlace, value: "\(value)")
    }
    
    func increaseHeight(inputPlace: String, value: Int) {
        webFormsData.add(name: "+h" + inputPlace, value: "\(value)")
    }
    
    func increaseValue(inputPlace: String, value: Int) {
        webFormsData.add(name: "+v" + inputPlace, value: "\(value)")
    }
    
    // Decrease
    func decreaseMinLength(inputPlace: String, value: Int) {
        webFormsData.add(name: "-n" + inputPlace, value: "\(value)")
    }
    
    func decreaseMaxLength(inputPlace: String, value: Int) {
        webFormsData.add(name: "-x" + inputPlace, value: "\(value)")
    }
    
    func decreaseFontSize(inputPlace: String, value: Int) {
        webFormsData.add(name: "-f" + inputPlace, value: "\(value)")
    }
    
    func decreaseWidth(inputPlace: String, value: Int) {
        webFormsData.add(name: "-w" + inputPlace, value: "\(value)")
    }
    
    func decreaseHeight(inputPlace: String, value: Int) {
        webFormsData.add(name: "-h" + inputPlace, value: "\(value)")
    }
    
    func decreaseValue(inputPlace: String, value: Int) {
        webFormsData.add(name: "-v" + inputPlace, value: "\(value)")
    }
    
    // Event
    func setPostEvent(inputPlace: String, htmlEvent: String) {
        webFormsData.add(name: "Ep" + inputPlace, value: htmlEvent)
    }
    
    func setPostEventAdding(inputPlace: String, htmlEvent: String) {
        webFormsData.add(name: "Ep" + inputPlace, value: "\(htmlEvent)|+")
    }
    
    func setPostEventTo(inputPlace: String, htmlEvent: String, outputPlace: String) {
        webFormsData.add(name: "Ep" + inputPlace, value: "\(htmlEvent)|\(outputPlace)")
    }
    
    func setPostEventListener(inputPlace: String, htmlEventListener: String) {
        webFormsData.add(name: "EP" + inputPlace, value: htmlEventListener)
    }
    
    func setPostEventListenerAdding(inputPlace: String, htmlEventListener: String) {
        webFormsData.add(name: "EP" + inputPlace, value: "\(htmlEventListener)|+")
    }
    
    func setPostEventListenerTo(inputPlace: String, htmlEventListener: String, outputPlace: String) {
        webFormsData.add(name: "EP" + inputPlace, value: "\(htmlEventListener)|\(outputPlace)")
    }
    
    func setGetEvent(inputPlace: String, htmlEvent: String, path: String? = nil) {
        let pathValue = path ?? "#"
        webFormsData.add(name: "Eg" + inputPlace, value: "\(htmlEvent)|\(pathValue)")
    }
    
    func setGetEvent(inputPlace: String, htmlEvent: String, outputPlace: String, path: String? = nil) {
        let pathValue = path ?? "#"
        webFormsData.add(name: "Eg" + inputPlace, value: "\(htmlEvent)|\(pathValue)|\(outputPlace)")
    }
    
    func setGetEventInForm(inputPlace: String, htmlEvent: String) {
        webFormsData.add(name: "Eg" + inputPlace, value: htmlEvent)
    }
    
    func setGetEventInForm(inputPlace: String, htmlEvent: String, outputPlace: String) {
        webFormsData.add(name: "Eg" + inputPlace, value: "\(htmlEvent)|\(outputPlace)")
    }
    
    func setGetEventListener(inputPlace: String, htmlEventListener: String, path: String? = nil) {
        let pathValue = path ?? "#"
        webFormsData.add(name: "EG" + inputPlace, value: "\(htmlEventListener)|\(pathValue)")
    }
    
    func setGetEventListener(inputPlace: String, htmlEventListener: String, outputPlace: String, path: String? = nil) {
        let pathValue = path ?? "#"
        webFormsData.add(name: "EG" + inputPlace, value: "\(htmlEventListener)|\(pathValue)|\(outputPlace)")
    }
    
    func setGetEventInFormListener(inputPlace: String, htmlEventListener: String) {
        webFormsData.add(name: "EG" + inputPlace, value: htmlEventListener)
    }
    
    func setGetEventInFormListener(inputPlace: String, htmlEventListener: String, outputPlace: String) {
        webFormsData.add(name: "EG" + inputPlace, value: "\(htmlEventListener)|\(outputPlace)")
    }
    
    func setTagEvent(inputPlace: String, htmlEvent: String, outputPlace: String) {
        webFormsData.add(name: "Et" + inputPlace, value: "\(htmlEvent)|\(outputPlace)")
    }
    
    func setTagEventListener(inputPlace: String, htmlEvent: String, outputPlace: String) {
        webFormsData.add(name: "ET" + inputPlace, value: "\(htmlEvent)|\(outputPlace)")
    }
    
    func removePostEvent(inputPlace: String, htmlEvent: String) {
        webFormsData.add(name: "Rp" + inputPlace, value: htmlEvent)
    }
    
    func removeGetEvent(inputPlace: String, htmlEvent: String) {
        webFormsData.add(name: "Rg" + inputPlace, value: htmlEvent)
    }
    
    func removeTagEvent(inputPlace: String, htmlEvent: String) {
        webFormsData.add(name: "Rt" + inputPlace, value: htmlEvent)
    }
    
    func removePostEventListener(inputPlace: String, htmlEventListener: String) {
        webFormsData.add(name: "RP" + inputPlace, value: htmlEventListener)
    }
    
    func removeGetEventListener(inputPlace: String, htmlEventListener: String) {
        webFormsData.add(name: "RG" + inputPlace, value: htmlEventListener)
    }
    
    func removeTagEventListener(inputPlace: String, htmlEventListener: String) {
        webFormsData.add(name: "RT" + inputPlace, value: htmlEventListener)
    }
    
    // Save
    func saveId(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@gi" + inputPlace, value: key)
    }
    
    func saveName(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@gn" + inputPlace, value: key)
    }
    
    func saveValue(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@gv" + inputPlace, value: key)
    }
    
    func saveValueLength(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@ge" + inputPlace, value: key)
    }
    
    func saveClass(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@gc" + inputPlace, value: key)
    }
    
    func saveStyle(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@gs" + inputPlace, value: key)
    }
    
    func saveTitle(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@gl" + inputPlace, value: key)
    }
    
    func saveText(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@gt" + inputPlace, value: key)
    }
    
    func saveTextLength(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@gg" + inputPlace, value: key)
    }
    
    func saveAttribute(inputPlace: String, attribute: String, key: String = ".") {
        webFormsData.add(name: "@ga" + inputPlace, value: "\(key)|\(attribute)")
    }
    
    func saveWidth(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@gw" + inputPlace, value: key)
    }
    
    func saveHeight(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@gh" + inputPlace, value: key)
    }
    
    func saveReadOnly(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@gr" + inputPlace, value: key)
    }
    
    func saveSelectedIndex(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@gx" + inputPlace, value: key)
    }
    
    func saveTextAlign(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@ta" + inputPlace, value: key)
    }
    
    func saveNodeLength(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@nl" + inputPlace, value: key)
    }
    
    func saveVisible(inputPlace: String, key: String = ".") {
        webFormsData.add(name: "@vi" + inputPlace, value: key)
    }
    
    // Pre Runner
    func assignDelay(second: Float, index: Int = -1) {
        let currentName = webFormsData.getNameByIndex(index: index)
        
        if currentName.isEmpty {
            return
        }
        
        webFormsData.changeNameByIndex(index: index, name: ":\(second))\(currentName)")
    }
    
    func assignDelayChange(second: Float, index: Int = -1) {
        let currentName = webFormsData.getNameByIndex(index: index)
        
        if currentName.isEmpty {
            return
        }
        
        let newName = currentName.replacingOccurrences(of: ":", with: "").replacingOccurrences(of: ")", with: "")
        webFormsData.changeNameByIndex(index: index, name: ":\(second))\(newName)")
    }
    
    func assignInterval(second: Float, index: Int = -1) {
        let currentName = webFormsData.getNameByIndex(index: index)
        
        if currentName.isEmpty {
            return
        }
        
        webFormsData.changeNameByIndex(index: index, name: "(\(second))\(currentName)")
    }
    
    func assignIntervalChange(second: Float, index: Int = -1) {
        let currentName = webFormsData.getNameByIndex(index: index)
        
        if currentName.isEmpty {
            return
        }
        
        let newName = currentName.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
        webFormsData.changeNameByIndex(index: index, name: "(\(second))\(newName)")
    }
    
    // Index
    func startIndex(name: String = "") {
        webFormsData.add(name: "#", value: name)
    }
    
    // Get
    func getFormsActionData() -> String {
        var returnValue = ""
        
        for nv in webFormsData.getList() {
            returnValue += "\n" + nv.name
            
            if !nv.value.isEmpty {
                returnValue += "=" + nv.value
            }
        }
        
        return returnValue
    }
    
    func response() -> String {
        return "[web-forms]" + getFormsActionData()
    }
    
    // Overload
    func response(context: HttpContext) -> String {
        setHeaders(context: context)
        return response()
    }
    
    func getFormsActionDataLineBreak() -> String {
        var returnValue = ""
        
        let webFormsDataList = webFormsData.getList()
        
        var i = webFormsDataList.count
        for nv in webFormsDataList {
            returnValue += nv.name
            
            if !nv.value.isEmpty {
                returnValue += "=" + nv.value.replacingOccurrences(of: "\"", with: "$[dq];")
            }
            
            if i > 1 {
                returnValue += "$[sln];"
            }
            i -= 1
        }
        
        return returnValue
    }
    
    // Export
    func exportToWebFormsTag(src: String? = nil) -> String {
        let srcValue = src != nil ? " src=\"\(src!)\"" : ""
        return "<web-forms ac=\"\(getFormsActionDataLineBreak())\"\(srcValue)></web-forms>"
    }
    
    // Overload
    func exportToWebFormsTag(width: String, height: String, src: String? = nil) -> String {
        let srcValue = src != nil ? " src=\"\(src!)\"" : ""
        return "<web-forms ac=\"\(getFormsActionDataLineBreak())\" width=\"\(width)\" height=\"\(height)\"\(srcValue)></web-forms>"
    }
    
    // Overload
    func exportToWebFormsTag(width: Int, height: Int, src: String? = nil) -> String {
        return exportToWebFormsTag(width: "\(width)px", height: "\(height)px", src: src)
    }
    
    func doneToWebFormsTag(id: String? = nil) -> String {
        let idValue = id != nil ? " id=\"\(id!)\" done=\"true\"" : ""
        return "<web-forms ac=\"\(getFormsActionDataLineBreak())\"\(idValue)></web-forms>"
    }
    
    func exportToNameValue() -> NameValueCollection {
        return webFormsData
    }
    
    func appendForm(form: WebForms) {
        webFormsData.addList(form.exportToNameValue().getList())
    }
    
    func setHeaders(context: HttpContext) {
        context.response.headers.add(name: "Content-Type", value: "text/plain")
    }
    
    func clean() {
        webFormsData = NameValueCollection()
    }
}

class InputPlace {
    static func id(_ id: String) -> String {
        return id
    }
    
    static func name(_ name: String) -> String {
        return "(\(name))"
    }
    
    static func name(_ name: String, index: Int) -> String {
        return "(\(name))\(index)"
    }
    
    static func tag(_ tag: String) -> String {
        return "<\(tag)>"
    }
    
    static func tag(_ tag: String, index: Int) -> String {
        return "<\(tag)>\(index)"
    }
    
    static func `class`(_ className: String) -> String {
        return "{\(className)}"
    }
    
    static func `class`(_ className: String, index: Int) -> String {
        return "{\(className)}\(index)"
    }
    
    static func query(_ query: String) -> String {
        return "*\(query.replacingOccurrences(of: "=", with: "$[eq];"))"
    }
    
    static func queryAll(_ query: String) -> String {
        return "[\(query.replacingOccurrences(of: "=", with: "$[eq];"))"
    }
}

class OutputPlace: InputPlace {}

class Fetch {
    static func random(maxValue: Int) -> String {
        return "@mr\(maxValue)"
    }
    
    static func random(minValue: Int, maxValue: Int) -> String {
        return "@mr\(maxValue),\(minValue)"
    }
    
    static let dateYear = "@dy"
    static let dateMonth = "@dm"
    static let dateDay = "@dd"
    static let dateHours = "@dh"
    static let dateMinutes = "@di"
    static let dateSeconds = "@ds"
    static let dateMilliseconds = "@dl"
    
    static func cookie(key: String) -> String {
        return "@co\(key)"
    }
    
    static func session(key: String) -> String {
        return "@cs\(key)"
    }
    
    static func session(key: String, replaceValue: String) -> String {
        return "@cs\(key),\(replaceValue)"
    }
    
    static func sessionAndRemove(key: String) -> String {
        return "@cl\(key)"
    }
    
    static func sessionAndRemove(key: String, replaceValue: String) -> String {
        return "@cl\(key),\(replaceValue)"
    }
    
    static func saved(key: String = ".") -> String {
        return "@cl\(key)"
    }
    
    static func cache(key: String) -> String {
        return "@cd\(key)"
    }
    
    static func cache(key: String, replaceValue: String) -> String {
        return "@cd\(key),\(replaceValue)"
    }
    
    static func cacheAndRemove(key: String) -> String {
        return "@ct\(key)"
    }
    
    static func cacheAndRemove(key: String, replaceValue: String) -> String {
        return "@ct\(key),\(replaceValue)"
    }
    
    static func script(scriptText: String) -> String {
        return "@_\(scriptText.replacingOccurrences(of: "\n", with: "$[ln];"))"
    }
}

class HtmlEvent {
    static let onAbort = "onabort"
    static let onAfterPrint = "onafterprint"
    static let onBeforePrint = "onbeforeprint"
    static let onBeforeUnload = "onbeforeunload"
    static let onBlur = "onblur"
    static let onCanPlay = "oncanplay"
    static let onCanPlayThrough = "oncanplaythrough"
    static let onChange = "onchange"
    static let onClick = "onclick"
    static let onCopy = "oncopy"
    static let onCut = "oncut"
    static let onDoubleClick = "ondblclick"
    static let onDrag = "ondrag"
    static let onDragEnd = "ondragend"
    static let onDragEnter = "ondragenter"
    static let onDragLeave = "ondragleave"
    static let onDragOver = "ondragover"
    static let onDragStart = "ondragstart"
    static let onDrop = "ondrop"
    static let onDurationChange = "ondurationchange"
    static let onEnded = "onended"
    static let onError = "onerror"
    static let onFocus = "onfocus"
    static let onFocusin = "onfocusin"
    static let onFocusOut = "onfocusout"
    static let onHashChange = "onhashchange"
    static let onInput = "oninput"
    static let onInvalid = "oninvalid"
    static let onKeyDown = "onkeydown"
    static let onKeyPress = "onkeypress"
    static let onKeyUp = "onkeyup"
    static let onLoad = "onload"
    static let onLoadedData = "onloadeddata"
    static let onLoadedMetaData = "onloadedmetadata"
    static let onLoadStart = "onloadstart"
    static let onMouseDown = "onmousedown"
    static let onMouseEnter = "onmouseenter"
    static let onMouseLeave = "onmouseleave"
    static let onMouseMove = "onmousemove"
    static let onMouseOver = "onmouseover"
    static let onMouseOut = "onmouseout"
    static let onMouseUp = "onmouseup"
    static let onOffline = "onoffline"
    static let onOnline = "ononline"
    static let onPageHide = "onpagehide"
    static let onPageShow = "onpageshow"
    static let onPaste = "onpaste"
    static let onPause = "onpause"
    static let onPlay = "onplay"
    static let onPlaying = "onplaying"
    static let onProgress = "onprogress"
    static let onRateChange = "onratechange"
    static let onResize = "onresize"
    static let onReset = "onreset"
    static let onScroll = "onscroll"
    static let onSearch = "onsearch"
    static let onSeeked = "onseeked"
    static let onSeeking = "onseeking"
    static let onSelect = "onselect"
    static let onStalled = "onstalled"
    static let onSubmit = "onsubmit"
    static let onSuspend = "onsuspend"
    static let onTimeUpdate = "ontimeupdate"
    static let onToggle = "ontoggle"
    static let onTouchCancel = "ontouchcancel"
    static let onTouchend = "ontouchend"
    static let onTouchMove = "ontouchmove"
    static let onTouchStart = "ontouchstart"
    static let onUnload = "onunload"
    static let onVolumeChange = "onvolumechange"
    static let onWaiting = "onwaiting"
}

class HtmlEventListener {
    static let abort = "abort"
    static let afterPrint = "afterprint"
    static let beforePrint = "beforeprint"
    static let beforeUnload = "beforeunload"
    static let blur = "blur"
    static let canPlay = "canplay"
    static let canPlayThrough = "canplaythrough"
    static let change = "change"
    static let click = "click"
    static let copy = "copy"
    static let cut = "cut"
    static let doubleClick = "dblclick"
    static let drag = "drag"
    static let dragEnd = "dragend"
    static let dragEnter = "dragenter"
    static let dragLeave = "dragleave"
    static let dragOver = "dragover"
    static let dragStart = "dragstart"
    static let drop = "drop"
    static let durationChange = "durationchange"
    static let ended = "ended"
    static let error = "error"
    static let focus = "focus"
    static let focusin = "focusin"
    static let focusOut = "focusout"
    static let hashChange = "hashchange"
    static let input = "input"
    static let invalid = "invalid"
    static let keyDown = "keydown"
    static let keyPress = "keypress"
    static let keyUp = "keyup"
    static let load = "load"
    static let loadedData = "loadeddata"
    static let loadedMetaData = "loadedmetadata"
    static let loadStart = "loadstart"
    static let mouseDown = "mousedown"
    static let mouseEnter = "mouseenter"
    static let mouseLeave = "mouseleave"
    static let mouseMove = "mousemove"
    static let mouseOver = "mouseover"
    static let mouseOut = "mouseout"
    static let mouseUp = "mouseup"
    static let offline = "offline"
    static let online = "online"
    static let pageHide = "pagehide"
    static let pageShow = "pageshow"
    static let paste = "paste"
    static let pause = "pause"
    static let play = "play"
    static let playing = "playing"
    static let progress = "progress"
    static let rateChange = "ratechange"
    static let resize = "resize"
    static let reset = "reset"
    static let scroll = "scroll"
    static let search = "search"
    static let seeked = "seeked"
    static let seeking = "seeking"
    static let select = "select"
    static let stalled = "stalled"
    static let submit = "submit"
    static let suspend = "suspend"
    static let timeUpdate = "timeupdate"
    static let toggle = "toggle"
    static let touchCancel = "touchcancel"
    static let touchend = "touchend"
    static let touchMove = "touchmove"
    static let touchStart = "touchstart"
    static let unload = "unload"
    static let volumeChange = "volumechange"
    static let waiting = "waiting"
    
    static let animationEnd = "animationend"
    static let animationIteration = "animationiteration"
    static let animationStart = "animationstart"
    static let contextMenu = "contextmenu"
    static let fullScreenChange = "fullscreenchange"
    static let fullScreenError = "fullscreenerror"
    static let popState = "popstate"
    static let transitionEnd = "transitionend"
    static let storage = "storage"
    static let wheel = "wheel"
}

extension String {
    func appendPlace(_ value: String) -> String {
        if self.isEmpty {
            return value
        }
        return "\(self)|\(value)"
    }
    
    func appendParent() -> String {
        return "/\(self)"
    }
    
    func exportToWebFormsTag() -> String {
        return "<web-forms src=\"\(self)\"></web-forms>"
    }
    
    func exportToWebFormsTag(width: Int, height: Int) -> String {
        return "<web-forms src=\"\(self)\" width=\"\(width)\" height=\"\(height)\"></web-forms>"
    }
    
    func exportActionControlsToWebFormsTag() -> String {
        return "<web-forms ac=\"\(self)\"></web-forms>"
    }
    
    func removeOuter(startString: String, endString: String) -> String {
        guard let startRange = self.range(of: startString),
              let endRange = self.range(of: endString, range: startRange.upperBound..<self.endIndex) else {
            return self
        }
        
        let rangeToRemove = startRange.lowerBound..<endRange.upperBound
        return self.replacingCharacters(in: rangeToRemove, with: "")
    }
}

class NameValue {
    var name: String
    var value: String
    
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

class NameValueCollection {
    private var nameValueList: [NameValue] = []
    
    func add(name: String, value: String) {
        nameValueList.append(NameValue(name: name, value: value))
    }
    
    func set(name: String, value: String) {
        if !exist(name: name) {
            add(name: name, value: value)
        } else {
            changeValue(name: name, value: value)
        }
    }
    
    func delete(name: String) {
        nameValueList = nameValueList.filter { $0.name != name }
    }
    
    func deleteByIndex(index: Int) {
        let tmpIndex = index >= 0 ? index : nameValueList.count + index
        nameValueList.remove(at: tmpIndex)
    }
    
    func empty() {
        nameValueList = []
    }
    
    func exist(name: String) -> Bool {
        return nameValueList.contains { $0.name == name }
    }
    
    func changeValue(name: String, value: String) {
        if let index = nameValueList.firstIndex(where: { $0.name == name }) {
            nameValueList[index].value = value
        }
    }
    
    func changeName(name: String, newName: String) {
        if let index = nameValueList.firstIndex(where: { $0.name == name }) {
            nameValueList[index].name = newName
        }
    }
    
    func changeValue(name: String, newName: String, value: String) {
        if let index = nameValueList.firstIndex(where: { $0.name == name }) {
            nameValueList[index].name = newName
            nameValueList[index].value = value
        }
    }
    
    func changeValueByIndex(index: Int, value: String) {
        let tmpIndex = index >= 0 ? index : nameValueList.count + index
        nameValueList[tmpIndex].value = value
    }
    
    func changeNameByIndex(index: Int, name: String) {
        let tmpIndex = index >= 0 ? index : nameValueList.count + index
        nameValueList[tmpIndex].name = name
    }
    
    func changeNameValueByIndex(index: Int, name: String, value: String) {
        let tmpIndex = index >= 0 ? index : nameValueList.count + index
        nameValueList[tmpIndex].name = name
        nameValueList[tmpIndex].value = value
    }
    
    func addList(_ list: [NameValue]) {
        nameValueList.append(contentsOf: list)
    }
    
    func getValue(name: String) -> String {
        return nameValueList.first { $0.name == name }?.value ?? ""
    }
    
    func getNameByIndex(index: Int) -> String {
        let tmpIndex = index >= 0 ? index : nameValueList.count + index
        return nameValueList[tmpIndex].name
    }
    
    func getValueByIndex(index: Int) -> String {
        let tmpIndex = index >= 0 ? index : nameValueList.count + index
        return nameValueList[tmpIndex].value
    }
    
    func getList() -> [NameValue] {
        return nameValueList
    }
}

class HttpContext {
    var response: HttpResponse
    
    init(response: HttpResponse) {
        self.response = response
    }
}

class HttpResponse {
    var headers: HttpHeaders
    
    init(headers: HttpHeaders) {
        self.headers = headers
    }
}

class HttpHeaders {
    func add(name: String, value: String) {
        // Implementation for adding headers
    }
}
