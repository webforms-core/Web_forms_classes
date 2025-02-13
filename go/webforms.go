// Compatible with WebFormsJS version 1.6

package webforms

import (
	"fmt"
	"net/http"
	"strconv"
	"strings"
)

type WebForms struct {
	WebFormsData NameValueCollection
}

func (w *WebForms) AddLine(name, value string) {
	w.WebFormsData.Add(name, value)
}

// Add
func (w *WebForms) AddId(inputPlace, id string) {
	w.WebFormsData.Add("ai"+inputPlace, id)
}

func (w *WebForms) AddName(inputPlace, name string) {
	w.WebFormsData.Add("an"+inputPlace, name)
}

func (w *WebForms) AddValue(inputPlace, value string) {
	w.WebFormsData.Add("av"+inputPlace, value)
}

func (w *WebForms) AddClass(inputPlace, class string) {
	w.WebFormsData.Add("ac"+inputPlace, class)
}

func (w *WebForms) AddStyle(inputPlace, style string) {
	w.WebFormsData.Add("as"+inputPlace, style)
}

func (w *WebForms) AddOptionTag(inputPlace, text, value string, selected bool) {
	selectedFlag := ""
	if selected {
		selectedFlag = "|1"
	}
	w.WebFormsData.Add("ao"+inputPlace, value+"|"+text+selectedFlag)
}

func (w *WebForms) AddCheckBoxTag(inputPlace, text, value string, checked bool) {
	checkedFlag := ""
	if checked {
		checkedFlag = "|1"
	}
	w.WebFormsData.Add("ak"+inputPlace, value+"|"+text+checkedFlag)
}

func (w *WebForms) AddTitle(inputPlace, title string) {
	w.WebFormsData.Add("al"+inputPlace, title)
}

func (w *WebForms) AddText(inputPlace, text string) {
	w.WebFormsData.Add("at"+inputPlace, strings.ReplaceAll(text, "\n", "$[ln];"))
}

func (w *WebForms) AddTextToUp(inputPlace, text string) {
	w.WebFormsData.Add("pt"+inputPlace, strings.ReplaceAll(text, "\n", "$[ln];"))
}

func (w *WebForms) AddAttribute(inputPlace, attribute, value string) {
	w.WebFormsData.Add("aa"+inputPlace, attribute+"|"+value)
}

func (w *WebForms) AddTag(inputPlace, tagName, id string) {
	if id != "" {
		w.WebFormsData.Add("nt"+inputPlace, tagName+"|"+id)
	} else {
		w.WebFormsData.Add("nt"+inputPlace, tagName)
	}
}

func (w *WebForms) AddTagToUp(inputPlace, tagName, id string) {
	if id != "" {
		w.WebFormsData.Add("ut"+inputPlace, tagName+"|"+id)
	} else {
		w.WebFormsData.Add("ut"+inputPlace, tagName)
	}
}

func (w *WebForms) AddTagBefore(inputPlace, tagName, id string) {
	if id != "" {
		w.WebFormsData.Add("bt"+inputPlace, tagName+"|"+id)
	} else {
		w.WebFormsData.Add("bt"+inputPlace, tagName)
	}
}

func (w *WebForms) AddTagAfter(inputPlace, tagName, id string) {
	if id != "" {
		w.WebFormsData.Add("ft"+inputPlace, tagName+"|"+id)
	} else {
		w.WebFormsData.Add("ft"+inputPlace, tagName)
	}
}

// Set methods
func (w *WebForms) SetId(inputPlace, id string) {
	w.WebFormsData.Add("si"+inputPlace, id)
}

func (w *WebForms) SetName(inputPlace, name string) {
	w.WebFormsData.Add("sn"+inputPlace, name)
}

func (w *WebForms) SetValue(inputPlace, value string) {
	w.WebFormsData.Add("sv"+inputPlace, value)
}

func (w *WebForms) SetClass(inputPlace, class string) {
	w.WebFormsData.Add("sc"+inputPlace, class)
}

func (w *WebForms) SetStyle(inputPlace, style string) {
	w.WebFormsData.Add("ss"+inputPlace, style)
}

func (w *WebForms) SetOptionTag(inputPlace, text, value string, selected bool) {
	selectedFlag := ""
	if selected {
		selectedFlag = "|1"
	}
	w.WebFormsData.Add("so"+inputPlace, value+"|"+text+selectedFlag)
}

func (w *WebForms) SetChecked(inputPlace string, checked bool) {
	if checked {
		w.WebFormsData.Add("sk"+inputPlace, "1")
	} else {
		w.WebFormsData.Add("sk"+inputPlace, "0")
	}
}

func (w *WebForms) SetCheckBoxTagToList(inputPlace, text, value string, checked bool) {
	checkedFlag := ""
	if checked {
		checkedFlag = "|1"
	}
	w.WebFormsData.Add("sk"+inputPlace, value+"|"+text+checkedFlag)
}

func (w *WebForms) SetTitle(inputPlace, title string) {
	w.WebFormsData.Add("sl"+inputPlace, title)
}

func (w *WebForms) SetText(inputPlace, text string) {
	w.WebFormsData.Add("st"+inputPlace, strings.ReplaceAll(text, "\n", "$[ln];"))
}

func (w *WebForms) SetAttribute(inputPlace, attribute, value string) {
	if value != "" {
		w.WebFormsData.Add("sa"+inputPlace, attribute+"|"+value)
	} else {
		w.WebFormsData.Add("sa"+inputPlace, attribute)
	}
}

func (w *WebForms) SetWidth(inputPlace, width string) {
	w.WebFormsData.Add("sw"+inputPlace, width)
}

func (w *WebForms) SetHeight(inputPlace, height string) {
	w.WebFormsData.Add("sh"+inputPlace, height)
}

// Insert methods
func (w *WebForms) InsertId(inputPlace, id string) {
	w.WebFormsData.Add("ii"+inputPlace, id)
}

func (w *WebForms) InsertName(inputPlace, name string) {
	w.WebFormsData.Add("in"+inputPlace, name)
}

func (w *WebForms) InsertValue(inputPlace, value string) {
	w.WebFormsData.Add("iv"+inputPlace, value)
}

func (w *WebForms) InsertClass(inputPlace, class string) {
	w.WebFormsData.Add("ic"+inputPlace, class)
}

func (w *WebForms) InsertStyle(inputPlace, style string) {
	w.WebFormsData.Add("is"+inputPlace, style)
}

func (w *WebForms) InsertOptionTag(inputPlace, text, value string, selected bool) {
	selectedFlag := ""
	if selected {
		selectedFlag = "|1"
	}
	w.WebFormsData.Add("io"+inputPlace, value+"|"+text+selectedFlag)
}

func (w *WebForms) InsertCheckBoxTag(inputPlace, text, value string, checked bool) {
	checkedFlag := ""
	if checked {
		checkedFlag = "|1"
	}
	w.WebFormsData.Add("ik"+inputPlace, value+"|"+text+checkedFlag)
}

func (w *WebForms) InsertTitle(inputPlace, title string) {
	w.WebFormsData.Add("il"+inputPlace, title)
}

func (w *WebForms) InsertText(inputPlace, text string) {
	w.WebFormsData.Add("it"+inputPlace, strings.ReplaceAll(text, "\n", "$[ln];"))
}

func (w *WebForms) InsertAttribute(inputPlace, attribute, value string) {
	if value != "" {
		w.WebFormsData.Add("ia"+inputPlace, attribute+"|"+value)
	} else {
		w.WebFormsData.Add("ia"+inputPlace, attribute)
	}
}

// Delete methods
func (w *WebForms) DeleteId(inputPlace string) {
	w.WebFormsData.Add("di"+inputPlace, "1")
}

func (w *WebForms) DeleteName(inputPlace string) {
	w.WebFormsData.Add("dn"+inputPlace, "1")
}

func (w *WebForms) DeleteValue(inputPlace string) {
	w.WebFormsData.Add("dv"+inputPlace, "1")
}

func (w *WebForms) DeleteClass(inputPlace, className string) {
	w.WebFormsData.Add("dc"+inputPlace, className)
}

func (w *WebForms) DeleteStyle(inputPlace, styleName string) {
	w.WebFormsData.Add("ds"+inputPlace, styleName)
}

func (w *WebForms) DeleteOptionTag(inputPlace, value string) {
	w.WebFormsData.Add("do"+inputPlace, value)
}

func (w *WebForms) DeleteAllOptionTag(inputPlace string) {
	w.WebFormsData.Add("do"+inputPlace, "*")
}

func (w *WebForms) DeleteCheckBoxTag(inputPlace, value string) {
	w.WebFormsData.Add("dk"+inputPlace, value)
}

func (w *WebForms) DeleteAllCheckBoxTag(inputPlace string) {
	w.WebFormsData.Add("dk"+inputPlace, "*")
}

func (w *WebForms) DeleteTitle(inputPlace string) {
	w.WebFormsData.Add("dl"+inputPlace, "1")
}

func (w *WebForms) DeleteText(inputPlace string) {
	w.WebFormsData.Add("dt"+inputPlace, "1")
}

func (w *WebForms) DeleteAttribute(inputPlace, attribute string) {
	w.WebFormsData.Add("da"+inputPlace, attribute)
}

func (w *WebForms) Delete(inputPlace string) {
	w.WebFormsData.Add("de"+inputPlace, "1")
}

func (w *WebForms) DeleteParent(inputPlace string) {
	w.WebFormsData.Add("dp"+inputPlace, "1")
}

// Other methods
func (w *WebForms) SetBackgroundColor(inputPlace, color string) {
	w.WebFormsData.Add("bc"+inputPlace, color)
}

func (w *WebForms) SetTextColor(inputPlace, color string) {
	w.WebFormsData.Add("tc"+inputPlace, color)
}

func (w *WebForms) SetFontName(inputPlace, name string) {
	w.WebFormsData.Add("fn"+inputPlace, name)
}

func (w *WebForms) SetFontSize(inputPlace, size string) {
	w.WebFormsData.Add("fs"+inputPlace, size)
}

func (w *WebForms) SetFontSizeInt(inputPlace string, size int) {
	w.SetFontSize(inputPlace, strconv.Itoa(size)+"px")
}

func (w *WebForms) SetFontBold(inputPlace string, bold bool) {
	if bold {
		w.WebFormsData.Add("fb"+inputPlace, "1")
	} else {
		w.WebFormsData.Add("fb"+inputPlace, "0")
	}
}

func (w *WebForms) SetVisible(inputPlace string, visible bool) {
	if visible {
		w.WebFormsData.Add("vi"+inputPlace, "1")
	} else {
		w.WebFormsData.Add("vi"+inputPlace, "0")
	}
}

func (w *WebForms) SetTextAlign(inputPlace, align string) {
	w.WebFormsData.Add("ta"+inputPlace, align)
}

func (w *WebForms) SetReadOnly(inputPlace string, readOnly bool) {
	if readOnly {
		w.WebFormsData.Add("sr"+inputPlace, "1")
	} else {
		w.WebFormsData.Add("sr"+inputPlace, "0")
	}
}

func (w *WebForms) SetDisabled(inputPlace string, disabled bool) {
	if disabled {
		w.WebFormsData.Add("sd"+inputPlace, "1")
	} else {
		w.WebFormsData.Add("sd"+inputPlace, "0")
	}
}

func (w *WebForms) SetFocus(inputPlace string, focus bool) {
	if focus {
		w.WebFormsData.Add("sf"+inputPlace, "1")
	} else {
		w.WebFormsData.Add("sf"+inputPlace, "0")
	}
}

func (w *WebForms) SetMinLength(inputPlace string, length int) {
	w.WebFormsData.Add("mn"+inputPlace, strconv.Itoa(length))
}

func (w *WebForms) SetMaxLength(inputPlace string, length int) {
	w.WebFormsData.Add("mx"+inputPlace, strconv.Itoa(length))
}

func (w *WebForms) SetSelectedValue(inputPlace, value string) {
	w.WebFormsData.Add("ts"+inputPlace, value)
}

func (w *WebForms) SetSelectedIndex(inputPlace string, index int) {
	w.WebFormsData.Add("ti"+inputPlace, strconv.Itoa(index))
}

func (w *WebForms) SetCheckedValue(inputPlace, value string, selected bool) {
	selectedStr := "0"
	if selected {
		selectedStr = "1"
	}
	w.WebFormsData.Add("ks"+inputPlace, value+"|"+selectedStr)
}

func (w *WebForms) SetCheckedIndex(inputPlace string, index int, selected bool) {
	selectedStr := "0"
	if selected {
		selectedStr = "1"
	}
	w.WebFormsData.Add("ki"+inputPlace, strconv.Itoa(index)+"|"+selectedStr)
}

func (w *WebForms) CallScript(scriptText string) {
	w.WebFormsData.Add("_", strings.ReplaceAll(scriptText, "\n", "$[ln];"))
}

func (w *WebForms) LoadUrl(inputPlace, url string) {
	w.WebFormsData.Add("lu"+inputPlace, url)
}

func (w *WebForms) ChangeUrl(url string) {
	w.WebFormsData.Add("cu", url)
}

func (w *WebForms) RemoveSessionCache(cacheKey string) {
	w.WebFormsData.Add("rs", cacheKey)
}

func (w *WebForms) RemoveAllSessionCache() {
	w.WebFormsData.Add("rs", "")
}

func (w *WebForms) RemoveCache(cacheKey string) {
	w.WebFormsData.Add("rd", cacheKey)
}

func (w *WebForms) RemoveAllCache() {
	w.WebFormsData.Add("rd", "")
}

func (w *WebForms) SetSessionCache() {
	w.WebFormsData.Add("cs", "1")
}

func (w *WebForms) SetCache(second int) {
	w.WebFormsData.Add("cd", strconv.Itoa(second))
}

func (w *WebForms) SetCacheNoTime() {
	w.WebFormsData.Add("cd", "")
}

// Increase methods
func (w *WebForms) IncreaseMinLength(inputPlace string, value int) {
	w.WebFormsData.Add("+n"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) IncreaseMaxLength(inputPlace string, value int) {
	w.WebFormsData.Add("+x"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) IncreaseFontSize(inputPlace string, value int) {
	w.WebFormsData.Add("+f"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) IncreaseWidth(inputPlace string, value int) {
	w.WebFormsData.Add("+w"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) IncreaseHeight(inputPlace string, value int) {
	w.WebFormsData.Add("+h"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) IncreaseValue(inputPlace string, value int) {
	w.WebFormsData.Add("+v"+inputPlace, strconv.Itoa(value))
}

// Decrease methods
func (w *WebForms) DecreaseMinLength(inputPlace string, value int) {
	w.WebFormsData.Add("-n"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) DecreaseMaxLength(inputPlace string, value int) {
	w.WebFormsData.Add("-x"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) DecreaseFontSize(inputPlace string, value int) {
	w.WebFormsData.Add("-f"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) DecreaseWidth(inputPlace string, value int) {
	w.WebFormsData.Add("-w"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) DecreaseHeight(inputPlace string, value int) {
	w.WebFormsData.Add("-h"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) DecreaseValue(inputPlace string, value int) {
	w.WebFormsData.Add("-v"+inputPlace, strconv.Itoa(value))
}

// Event methods
func (w *WebForms) SetPostEvent(inputPlace, htmlEvent string) {
	w.WebFormsData.Add("Ep"+inputPlace, htmlEvent)
}

func (w *WebForms) SetPostEventAdding(inputPlace, htmlEvent string) {
	w.WebFormsData.Add("Ep"+inputPlace, htmlEvent+"|+")
}

func (w *WebForms) SetPostEventTo(inputPlace, htmlEvent, outputPlace string) {
	w.WebFormsData.Add("Ep"+inputPlace, htmlEvent+"|"+outputPlace)
}

func (w *WebForms) SetPostEventListener(inputPlace, htmlEventListener string) {
	w.WebFormsData.Add("EP"+inputPlace, htmlEventListener)
}

func (w *WebForms) SetPostEventListenerAdding(inputPlace, htmlEventListener string) {
	w.WebFormsData.Add("EP"+inputPlace, htmlEventListener+"|+")
}

func (w *WebForms) SetPostEventListenerTo(inputPlace, htmlEventListener, outputPlace string) {
	w.WebFormsData.Add("EP"+inputPlace, htmlEventListener+"|"+outputPlace)
}

func (w *WebForms) SetGetEvent(inputPlace, htmlEvent string, path string) {
	if len(path) > 0 {
		w.WebFormsData.Add("Eg"+inputPlace, htmlEvent+"|"+path)
	} else {
		w.WebFormsData.Add("Eg"+inputPlace, htmlEvent+"|#")
	}
}

func (w *WebForms) SetGetEventWithOutput(inputPlace, htmlEvent, outputPlace string, path ...string) {
	if len(path) > 0 && path[0] != "" {
		w.WebFormsData.Add("Eg"+inputPlace, htmlEvent+"|"+path[0]+"|"+outputPlace)
	} else {
		w.WebFormsData.Add("Eg"+inputPlace, htmlEvent+"|#|"+outputPlace)
	}
}

func (w *WebForms) SetGetEventInForm(inputPlace, htmlEvent string) {
	w.WebFormsData.Add("Eg"+inputPlace, htmlEvent)
}

func (w *WebForms) SetGetEventInFormWithOutput(inputPlace, htmlEvent, outputPlace string) {
	w.WebFormsData.Add("Eg"+inputPlace, htmlEvent+"|"+outputPlace)
}

func (w *WebForms) SetGetEventListener(inputPlace, htmlEventListener string, path ...string) {
	if len(path) > 0 && path[0] != "" {
		w.WebFormsData.Add("EG"+inputPlace, htmlEventListener+"|"+path[0])
	} else {
		w.WebFormsData.Add("EG"+inputPlace, htmlEventListener+"|#")
	}
}

func (w *WebForms) SetGetEventListenerWithOutput(inputPlace, htmlEventListener, outputPlace string, path ...string) {
	if len(path) > 0 && path[0] != "" {
		w.WebFormsData.Add("EG"+inputPlace, htmlEventListener+"|"+path[0]+"|"+outputPlace)
	} else {
		w.WebFormsData.Add("EG"+inputPlace, htmlEventListener+"|#|"+outputPlace)
	}
}

func (w *WebForms) SetGetEventInFormListener(inputPlace, htmlEventListener string) {
	w.WebFormsData.Add("EG"+inputPlace, htmlEventListener)
}

func (w *WebForms) SetGetEventInFormListenerWithOutput(inputPlace, htmlEventListener, outputPlace string) {
	w.WebFormsData.Add("EG"+inputPlace, htmlEventListener+"|"+outputPlace)
}

func (w *WebForms) SetTagEvent(inputPlace, htmlEvent, outputPlace string) {
	w.WebFormsData.Add("Et"+inputPlace, htmlEvent+"|"+outputPlace)
}

func (w *WebForms) SetTagEventListener(inputPlace, htmlEvent, outputPlace string) {
	w.WebFormsData.Add("ET"+inputPlace, htmlEvent+"|"+outputPlace)
}

func (w *WebForms) RemovePostEvent(inputPlace, htmlEvent string) {
	w.WebFormsData.Add("Rp"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveGetEvent(inputPlace, htmlEvent string) {
	w.WebFormsData.Add("Rg"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveTagEvent(inputPlace, htmlEvent string) {
	w.WebFormsData.Add("Rt"+inputPlace, htmlEvent)
}

func (w *WebForms) RemovePostEventListener(inputPlace, htmlEventListener string) {
	w.WebFormsData.Add("RP"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveGetEventListener(inputPlace, htmlEventListener string) {
	w.WebFormsData.Add("RG"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveTagEventListener(inputPlace, htmlEventListener string) {
	w.WebFormsData.Add("RT"+inputPlace, htmlEventListener)
}

// Save methods
func (w *WebForms) SaveId(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@gi"+inputPlace, key)
}

func (w *WebForms) SaveName(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@gn"+inputPlace, key)
}

func (w *WebForms) SaveValue(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@gv"+inputPlace, key)
}

func (w *WebForms) SaveValueLength(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@ge"+inputPlace, key)
}

func (w *WebForms) SaveClass(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@gc"+inputPlace, key)
}

func (w *WebForms) SaveStyle(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@gs"+inputPlace, key)
}

func (w *WebForms) SaveTitle(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@gl"+inputPlace, key)
}

func (w *WebForms) SaveText(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@gt"+inputPlace, key)
}

func (w *WebForms) SaveTextLength(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@gg"+inputPlace, key)
}

func (w *WebForms) SaveAttribute(inputPlace, attribute, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@ga"+inputPlace, key+"|"+attribute)
}

func (w *WebForms) SaveWidth(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@gw"+inputPlace, key)
}

func (w *WebForms) SaveHeight(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@gh"+inputPlace, key)
}

func (w *WebForms) SaveReadOnly(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@gr"+inputPlace, key)
}

func (w *WebForms) SaveSelectedIndex(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@gx"+inputPlace, key)
}

func (w *WebForms) SaveTextAlign(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@ta"+inputPlace, key)
}

func (w *WebForms) SaveNodeLength(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@nl"+inputPlace, key)
}

func (w *WebForms) SaveVisible(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.WebFormsData.Add("@vi"+inputPlace, key)
}

// Pre Runner methods
func (w *WebForms) AssignDelay(second float64, index int) {
	currentName := w.WebFormsData.GetValue(w.WebFormsData.GetNameByIndex(index))

	if currentName == "" {
		return
	}

	w.WebFormsData.ChangeNameByIndex(index, ":"+fmt.Sprintf("%f", second)+")"+currentName)
}

func (w *WebForms) AssignDelayChange(second float64, index int) {
	currentName := w.WebFormsData.GetValue(w.WebFormsData.GetNameByIndex(index))

	if currentName == "" {
		return
	}

	currentName = removeOuter(currentName, ":", ")")
	w.WebFormsData.ChangeNameByIndex(index, ":"+fmt.Sprintf("%f", second)+")"+currentName)
}

func (w *WebForms) AssignInterval(second float64, index int) {
	currentName := w.WebFormsData.GetValue(w.WebFormsData.GetNameByIndex(index))

	if currentName == "" {
		return
	}

	w.WebFormsData.ChangeNameByIndex(index, "("+fmt.Sprintf("%f", second)+")"+currentName)
}

func (w *WebForms) AssignIntervalChange(second float64, index int) {
	currentName := w.WebFormsData.GetValue(w.WebFormsData.GetNameByIndex(index))

	if currentName == "" {
		return
	}

	currentName = removeOuter(currentName, "(", ")")
	w.WebFormsData.ChangeNameByIndex(index, "("+fmt.Sprintf("%f", second)+")"+currentName)
}

// Index
func (w *WebForms) StartIndex(name string) {
	w.WebFormsData.Add("#", name)
}

func (w *WebForms) StartIndexEmpty() {
	w.StartIndex("")
}

// Get methods
func (w *WebForms) GetFormsActionData() string {
	var returnValue strings.Builder

	for _, nv := range w.WebFormsData.GetList() {
		returnValue.WriteString("\n" + nv.Name)
		if nv.Value != "" {
			returnValue.WriteString("=" + nv.Value)
		}
	}

	return returnValue.String()
}

func (w *WebForms) Response() string {
	return "[web-forms]" + w.GetFormsActionData()
}

// Overload
func (w *WebForms) ResponseWithResponse(writer http.ResponseWriter) string {
	w.SetHeaders(writer)
	return w.Response()
}

func (w *WebForms) GetFormsActionDataLineBreak() string {
	var returnValue strings.Builder

	webFormsDataList := w.WebFormsData.GetList()
	i := len(webFormsDataList)

	for _, nv := range webFormsDataList {
		returnValue.WriteString(nv.Name)

		if nv.Value != "" {
			returnValue.WriteString("=" + strings.ReplaceAll(nv.Value, "\"", "$[dq];"))
		}

		if i--; i > 0 {
			returnValue.WriteString("$[sln];")
		}
	}

	return returnValue.String()
}

// Export methods
func (w *WebForms) ExportToWebFormsTag(src string) string {
	return fmt.Sprintf("<web-forms ac=\"%s\"%s></web-forms>", w.GetFormsActionDataLineBreak(), optionalSrc(src))
}

// Overload
func (w *WebForms) ExportToWebFormsTagWithDimensions(width, height, src string) string {
	return fmt.Sprintf("<web-forms ac=\"%s\" width=\"%s\" height=\"%s\"%s></web-forms>", w.GetFormsActionDataLineBreak(), width, height, optionalSrc(src))
}

// Overload
func (w *WebForms) ExportToWebFormsTagWithIntDimensions(width, height int, src string) string {
	return w.ExportToWebFormsTagWithDimensions(fmt.Sprintf("%dpx", width), fmt.Sprintf("%dpx", height), src)
}

func (w *WebForms) DoneToWebFormsTag(id string) string {
	return fmt.Sprintf("<web-forms ac=\"%s\"%s done=\"true\"></web-forms>", w.GetFormsActionDataLineBreak(), optionalId(id))
}

func (w *WebForms) ExportToNameValue() NameValueCollection {
	return w.WebFormsData
}

func (w *WebForms) AppendForm(form WebForms) {
	nameValueCollection := form.ExportToNameValue()
	w.WebFormsData.AddList(nameValueCollection.GetList())
}

func (w *WebForms) SetHeaders(writer http.ResponseWriter) {
	writer.Header().Set("Content-Type", "text/plain")
}

func (w *WebForms) Clean() {
	w.WebFormsData = NameValueCollection{}
}

func optionalSrc(src string) string {
	if src != "" {
		return fmt.Sprintf(" src=\"%s\"", src)
	}
	return ""
}

func optionalId(id string) string {
	if id != "" {
		return fmt.Sprintf(" id=\"%s\"", id)
	}
	return ""
}

func removeOuter(text, startString, endString string) string {
	start := strings.Index(text, startString)
	if start == -1 {
		return text
	}

	end := strings.Index(text[start:], endString)
	if end == -1 {
		return text
	}

	end += start + len(endString)
	return text[:start] + text[end:]
}

type InputPlace struct{}

func (InputPlace) Id(id string) string {
	return id
}

func (InputPlace) Name(name string) string {
	return "(" + name + ")"
}

func (InputPlace) NameWithIndex(name string, index int) string {
	return fmt.Sprintf("(%s)%d", name, index)
}

func (InputPlace) Tag(tag string) string {
	return "<" + tag + ">"
}

func (InputPlace) TagWithIndex(tag string, index int) string {
	return fmt.Sprintf("<%s>%d", tag, index)
}

func (InputPlace) Class(class string) string {
	return "{" + class + "}"
}

func (InputPlace) ClassWithIndex(class string, index int) string {
	return fmt.Sprintf("{%s}%d", class, index)
}

func (InputPlace) Query(query string) string {
	return "*" + strings.ReplaceAll(query, "=", "$[eq];")
}

func (InputPlace) QueryAll(query string) string {
	return "[" + strings.ReplaceAll(query, "=", "$[eq];")
}

type OutputPlace struct {
	InputPlace
}

// Do Not Add Any Data Before Or After It
type Fetch struct{}

func (Fetch) Random(maxValue int) string {
	return fmt.Sprintf("@mr%d", maxValue)
}

func (Fetch) RandomRange(minValue, maxValue int) string {
	return fmt.Sprintf("@mr%d,%d", maxValue, minValue)
}

var (
	DateYear         = "@dy"
	DateMonth        = "@dm"
	DateDay          = "@dd"
	DateHours        = "@dh"
	DateMinutes      = "@di"
	DateSeconds      = "@ds"
	DateMilliseconds = "@dl"
)

func (Fetch) Cookie(key string) string {
	return "@co" + key
}

func (Fetch) Session(key string) string {
	return "@cs" + key
}

func (Fetch) SessionWithReplace(key, replaceValue string) string {
	return "@cs" + key + "," + replaceValue
}

func (Fetch) SessionAndRemove(key string) string {
	return "@cl" + key
}

func (Fetch) SessionAndRemoveWithReplace(key, replaceValue string) string {
	return "@cl" + key + "," + replaceValue
}

func (Fetch) Saved(key string) string {
	return "@cl" + key
}

func (Fetch) Cache(key string) string {
	return "@cd" + key
}

func (Fetch) CacheWithReplace(key, replaceValue string) string {
	return "@cd" + key + "," + replaceValue
}

func (Fetch) CacheAndRemove(key string) string {
	return "@ct" + key
}

func (Fetch) CacheAndRemoveWithReplace(key, replaceValue string) string {
	return "@ct" + key + "," + replaceValue
}

func (Fetch) Script(scriptText string) string {
	return "@_" + strings.ReplaceAll(scriptText, "\n", "$[ln];")
}

func AppendPlace(text, value string) string {
	if len(text) < 1 {
		return value
	}
	return text + "|" + value
}

type HtmlEvent struct{}

func (HtmlEvent) OnAbort() string          { return "onabort" }
func (HtmlEvent) OnAfterPrint() string     { return "onafterprint" }
func (HtmlEvent) OnBeforePrint() string    { return "onbeforeprint" }
func (HtmlEvent) OnBeforeUnload() string   { return "onbeforeunload" }
func (HtmlEvent) OnBlur() string           { return "onblur" }
func (HtmlEvent) OnCanPlay() string        { return "oncanplay" }
func (HtmlEvent) OnCanPlayThrough() string { return "oncanplaythrough" }
func (HtmlEvent) OnChange() string         { return "onchange" }
func (HtmlEvent) OnClick() string          { return "onclick" }
func (HtmlEvent) OnCopy() string           { return "oncopy" }
func (HtmlEvent) OnCut() string            { return "oncut" }
func (HtmlEvent) OnDoubleClick() string    { return "ondblclick" }
func (HtmlEvent) OnDrag() string           { return "ondrag" }
func (HtmlEvent) OnDragEnd() string        { return "ondragend" }
func (HtmlEvent) OnDragEnter() string      { return "ondragenter" }
func (HtmlEvent) OnDragLeave() string      { return "ondragleave" }
func (HtmlEvent) OnDragOver() string       { return "ondragover" }
func (HtmlEvent) OnDragStart() string      { return "ondragstart" }
func (HtmlEvent) OnDrop() string           { return "ondrop" }
func (HtmlEvent) OnDurationChange() string { return "ondurationchange" }
func (HtmlEvent) OnEnded() string          { return "onended" }
func (HtmlEvent) OnError() string          { return "onerror" }
func (HtmlEvent) OnFocus() string          { return "onfocus" }
func (HtmlEvent) OnFocusin() string        { return "onfocusin" }
func (HtmlEvent) OnFocusOut() string       { return "onfocusout" }
func (HtmlEvent) OnHashChange() string     { return "onhashchange" }
func (HtmlEvent) OnInput() string          { return "oninput" }
func (HtmlEvent) OnInvalid() string        { return "oninvalid" }
func (HtmlEvent) OnKeyDown() string        { return "onkeydown" }
func (HtmlEvent) OnKeyPress() string       { return "onkeypress" }
func (HtmlEvent) OnKeyUp() string          { return "onkeyup" }
func (HtmlEvent) OnLoad() string           { return "onload" }
func (HtmlEvent) OnLoadedData() string     { return "onloadeddata" }
func (HtmlEvent) OnLoadedMetaData() string { return "onloadedmetadata" }
func (HtmlEvent) OnLoadStart() string      { return "onloadstart" }
func (HtmlEvent) OnMouseDown() string      { return "onmousedown" }
func (HtmlEvent) OnMouseEnter() string     { return "onmouseenter" }
func (HtmlEvent) OnMouseLeave() string     { return "onmouseleave" }
func (HtmlEvent) OnMouseMove() string      { return "onmousemove" }
func (HtmlEvent) OnMouseOver() string      { return "onmouseover" }
func (HtmlEvent) OnMouseOut() string       { return "onmouseout" }
func (HtmlEvent) OnMouseUp() string        { return "onmouseup" }
func (HtmlEvent) OnOffline() string        { return "onoffline" }
func (HtmlEvent) OnOnline() string         { return "ononline" }
func (HtmlEvent) OnPageHide() string       { return "onpagehide" }
func (HtmlEvent) OnPageShow() string       { return "onpageshow" }
func (HtmlEvent) OnPaste() string          { return "onpaste" }
func (HtmlEvent) OnPause() string          { return "onpause" }
func (HtmlEvent) OnPlay() string           { return "onplay" }
func (HtmlEvent) OnPlaying() string        { return "onplaying" }
func (HtmlEvent) OnProgress() string       { return "onprogress" }
func (HtmlEvent) OnRateChange() string     { return "onratechange" }
func (HtmlEvent) OnResize() string         { return "onresize" }
func (HtmlEvent) OnReset() string          { return "onreset" }
func (HtmlEvent) OnScroll() string         { return "onscroll" }
func (HtmlEvent) OnSearch() string         { return "onsearch" }
func (HtmlEvent) OnSeeked() string         { return "onseeked" }
func (HtmlEvent) OnSeeking() string        { return "onseeking" }
func (HtmlEvent) OnSelect() string         { return "onselect" }
func (HtmlEvent) OnStalled() string        { return "onstalled" }
func (HtmlEvent) OnSubmit() string         { return "onsubmit" }
func (HtmlEvent) OnSuspend() string        { return "onsuspend" }
func (HtmlEvent) OnTimeUpdate() string     { return "ontimeupdate" }
func (HtmlEvent) OnToggle() string         { return "ontoggle" }
func (HtmlEvent) OnTouchCancel() string    { return "ontouchcancel" }
func (HtmlEvent) OnTouchend() string       { return "ontouchend" }
func (HtmlEvent) OnTouchMove() string      { return "ontouchmove" }
func (HtmlEvent) OnTouchStart() string     { return "ontouchstart" }
func (HtmlEvent) OnUnload() string         { return "onunload" }
func (HtmlEvent) OnVolumeChange() string   { return "onvolumechange" }
func (HtmlEvent) OnWaiting() string        { return "onwaiting" }

type HtmlEventListener struct{}

func (HtmlEvent) Abort() string          { return "abort" }
func (HtmlEvent) AfterPrint() string     { return "afterprint" }
func (HtmlEvent) BeforePrint() string    { return "beforeprint" }
func (HtmlEvent) BeforeUnload() string   { return "beforeunload" }
func (HtmlEvent) Blur() string           { return "blur" }
func (HtmlEvent) CanPlay() string        { return "canplay" }
func (HtmlEvent) CanPlayThrough() string { return "canplaythrough" }
func (HtmlEvent) Change() string         { return "change" }
func (HtmlEvent) Click() string          { return "click" }
func (HtmlEvent) Copy() string           { return "copy" }
func (HtmlEvent) Cut() string            { return "cut" }
func (HtmlEvent) DoubleClick() string    { return "dblclick" }
func (HtmlEvent) Drag() string           { return "drag" }
func (HtmlEvent) DragEnd() string        { return "dragend" }
func (HtmlEvent) DragEnter() string      { return "dragenter" }
func (HtmlEvent) DragLeave() string      { return "dragleave" }
func (HtmlEvent) DragOver() string       { return "dragover" }
func (HtmlEvent) DragStart() string      { return "dragstart" }
func (HtmlEvent) Drop() string           { return "drop" }
func (HtmlEvent) DurationChange() string { return "durationchange" }
func (HtmlEvent) Ended() string          { return "ended" }
func (HtmlEvent) Error() string          { return "error" }
func (HtmlEvent) Focus() string          { return "focus" }
func (HtmlEvent) Focusin() string        { return "focusin" }
func (HtmlEvent) FocusOut() string       { return "focusout" }
func (HtmlEvent) HashChange() string     { return "hashchange" }
func (HtmlEvent) Input() string          { return "input" }
func (HtmlEvent) Invalid() string        { return "invalid" }
func (HtmlEvent) KeyDown() string        { return "keydown" }
func (HtmlEvent) KeyPress() string       { return "keypress" }
func (HtmlEvent) KeyUp() string          { return "keyup" }
func (HtmlEvent) Load() string           { return "load" }
func (HtmlEvent) LoadedData() string     { return "loadeddata" }
func (HtmlEvent) LoadedMetaData() string { return "loadedmetadata" }
func (HtmlEvent) LoadStart() string      { return "loadstart" }
func (HtmlEvent) MouseDown() string      { return "mousedown" }
func (HtmlEvent) MouseEnter() string     { return "mouseenter" }
func (HtmlEvent) MouseLeave() string     { return "mouseleave" }
func (HtmlEvent) MouseMove() string      { return "mousemove" }
func (HtmlEvent) MouseOver() string      { return "mouseover" }
func (HtmlEvent) MouseOut() string       { return "mouseout" }
func (HtmlEvent) MouseUp() string        { return "mouseup" }
func (HtmlEvent) Offline() string        { return "offline" }
func (HtmlEvent) Online() string         { return "online" }
func (HtmlEvent) PageHide() string       { return "pagehide" }
func (HtmlEvent) PageShow() string       { return "pageshow" }
func (HtmlEvent) Paste() string          { return "paste" }
func (HtmlEvent) Pause() string          { return "pause" }
func (HtmlEvent) Play() string           { return "play" }
func (HtmlEvent) Playing() string        { return "playing" }
func (HtmlEvent) Progress() string       { return "progress" }
func (HtmlEvent) RateChange() string     { return "ratechange" }
func (HtmlEvent) Resize() string         { return "resize" }
func (HtmlEvent) Reset() string          { return "reset" }
func (HtmlEvent) Scroll() string         { return "scroll" }
func (HtmlEvent) Search() string         { return "search" }
func (HtmlEvent) Seeked() string         { return "seeked" }
func (HtmlEvent) Seeking() string        { return "seeking" }
func (HtmlEvent) Select() string         { return "select" }
func (HtmlEvent) Stalled() string        { return "stalled" }
func (HtmlEvent) Submit() string         { return "submit" }
func (HtmlEvent) Suspend() string        { return "suspend" }
func (HtmlEvent) TimeUpdate() string     { return "timeupdate" }
func (HtmlEvent) Toggle() string         { return "toggle" }
func (HtmlEvent) TouchCancel() string    { return "touchcancel" }
func (HtmlEvent) Touchend() string       { return "touchend" }
func (HtmlEvent) TouchMove() string      { return "touchmove" }
func (HtmlEvent) TouchStart() string     { return "touchstart" }
func (HtmlEvent) Unload() string         { return "unload" }
func (HtmlEvent) VolumeChange() string   { return "volumechange" }
func (HtmlEvent) Waiting() string        { return "waiting" }

func (HtmlEvent) AnimationEnd() string       { return "animationend" }
func (HtmlEvent) AnimationIteration() string { return "animationiteration" }
func (HtmlEvent) AnimationStart() string     { return "animationstart" }
func (HtmlEvent) ContextMenu() string        { return "contextmenu" }
func (HtmlEvent) FullScreenChange() string   { return "fullscreenchange" }
func (HtmlEvent) FullScreenError() string    { return "fullscreenerror" }
func (HtmlEvent) PopState() string           { return "popstate" }
func (HtmlEvent) TransitionEnd() string      { return "transitionend" }
func (HtmlEvent) Storage() string            { return "storage" }
func (HtmlEvent) Wheel() string              { return "wheel" }

func AppendParent(text string) string {
	return "/" + text
}

func ExportToWebFormsTag(src string) string {
	return "<web-forms src=\"" + src + "\"></web-forms>"
}

// Overload
func ExportToWebFormsTagWithDimensions(src string, width, height int) string {
	return fmt.Sprintf("<web-forms src=\"%s\" width=\"%d\" height=\"%d\"></web-forms>", src, width, height)
}

func ExportActionControlsToWebFormsTag(actionControls string) string {
	return "<web-forms ac=\"" + actionControls + "\"></web-forms>"
}

func RemoveOuter(text, startString, endString string) string {
	start := strings.Index(text, startString)
	if start == -1 {
		return text
	}

	end := strings.Index(text[start:], endString)
	if end == -1 {
		return text
	}

	end += start + len(endString)
	return text[:start] + text[end:]
}

type NameValue struct {
	Name  string
	Value string
}

type NameValueCollection struct {
	NameValueList []NameValue
}

func (nvc *NameValueCollection) Add(name, value string) {
	nvc.NameValueList = append(nvc.NameValueList, NameValue{Name: name, Value: value})
}

func (nvc *NameValueCollection) Set(name, value string) {
	if !nvc.Exist(name) {
		nvc.Add(name, value)
	} else {
		nvc.ChangeValue(name, value)
	}
}

func (nvc *NameValueCollection) Delete(name string) {
	var tmpNameValueList []NameValue
	for _, nv := range nvc.NameValueList {
		if nv.Name != name {
			tmpNameValueList = append(tmpNameValueList, nv)
		}
	}
	nvc.NameValueList = tmpNameValueList
}

func (nvc *NameValueCollection) DeleteByIndex(index int) {
	tmpIndex := index
	if index < 0 {
		tmpIndex = len(nvc.NameValueList) + index
	}
	nvc.NameValueList = append(nvc.NameValueList[:tmpIndex], nvc.NameValueList[tmpIndex+1:]...)

}

func (nvc *NameValueCollection) Empty() {
	nvc.NameValueList = []NameValue{}
}

func (nvc *NameValueCollection) Exist(name string) bool {
	for _, nv := range nvc.NameValueList {
		if nv.Name == name {
			return true
		}
	}
	return false
}

func (nvc *NameValueCollection) ChangeValue(name, value string) {
	for i, nv := range nvc.NameValueList {
		if nv.Name == name {
			nvc.NameValueList[i].Value = value
			break
		}
	}
}

func (nvc *NameValueCollection) ChangeName(name, newName string) {
	for i, nv := range nvc.NameValueList {
		if nv.Name == name {
			nvc.NameValueList[i].Name = newName
			break
		}
	}
}

func (nvc *NameValueCollection) ChangeValueOverload(name, newName, value string) {
	for i, nv := range nvc.NameValueList {
		if nv.Name == name {
			nvc.NameValueList[i].Name = newName
			nvc.NameValueList[i].Value = value
			break
		}
	}
}

func (nvc *NameValueCollection) ChangeValueByIndex(index int, value string) {
	tmpIndex := index
	if index < 0 {
		tmpIndex = len(nvc.NameValueList) + index
	}
	nvc.NameValueList[tmpIndex].Value = value
}

func (nvc *NameValueCollection) ChangeNameByIndex(index int, name string) {
	tmpIndex := index
	if index < 0 {
		tmpIndex = len(nvc.NameValueList) + index
	}
	nvc.NameValueList[tmpIndex].Name = name
}

func (nvc *NameValueCollection) ChangeNameValueByIndex(index int, name, value string) {
	tmpIndex := index
	if index < 0 {
		tmpIndex = len(nvc.NameValueList) + index
	}
	nvc.NameValueList[tmpIndex].Name = name
	nvc.NameValueList[tmpIndex].Value = value
}

func (nvc *NameValueCollection) AddList(nameValueList []NameValue) {
	nvc.NameValueList = append(nvc.NameValueList, nameValueList...)
}

func (nvc *NameValueCollection) GetValue(name string) string {
	for _, nv := range nvc.NameValueList {
		if nv.Name == name {
			return nv.Value
		}
	}
	return ""
}

func (nvc *NameValueCollection) GetNameByIndex(index int) string {
	tmpIndex := index
	if index < 0 {
		tmpIndex = len(nvc.NameValueList) + index
	}
	return nvc.NameValueList[tmpIndex].Name
}

func (nvc *NameValueCollection) GetValueByIndex(index int) string {
	tmpIndex := index
	if index < 0 {
		tmpIndex = len(nvc.NameValueList) + index
	}
	return nvc.NameValueList[tmpIndex].Value
}

func (nvc *NameValueCollection) GetList() []NameValue {
	return nvc.NameValueList
}
