// WebForms.go 2.0 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.0

package webforms

import (
	"bytes"
	"fmt"
	"net/http"
	"strconv"
	"strings"
)

type WebForms struct {
	WebFormsData bytes.Buffer
}

func (w *WebForms) add(name, value string) {
	if w.WebFormsData.Len() > 0 {
		w.WebFormsData.WriteByte('\n')
	}
	w.WebFormsData.WriteString(name)
	w.WebFormsData.WriteByte('=')
	w.WebFormsData.WriteString(value)
}

func (w *WebForms) addNameOnly(name string) {
	if w.WebFormsData.Len() > 0 {
		w.WebFormsData.WriteByte('\n')
	}
	w.WebFormsData.WriteString(name)
}

func (w *WebForms) getLineByIndex(index int) string {
	if w.WebFormsData.Len() == 0 {
		return ""
	}

	data := w.WebFormsData.String()
	lines := strings.Split(data, "\n")

	if index < 0 {
		index = len(lines) + index
	}

	if index < 0 || index >= len(lines) {
		return ""
	}

	return lines[index]
}

func (w *WebForms) updateLineByIndex(index int, name, value string) {
	if w.WebFormsData.Len() == 0 {
		return
	}

	data := w.WebFormsData.String()
	lines := strings.Split(data, "\n")

	if index < 0 {
		index = len(lines) + index
	}

	if index < 0 || index >= len(lines) {
		return
	}

	if value == "" {
		lines[index] = name
	} else {
		lines[index] = name + "=" + value
	}

	w.WebFormsData.Reset()
	w.WebFormsData.WriteString(strings.Join(lines, "\n"))
}

// For Extension
func (w *WebForms) AddLine(name, value string) {
	w.add(name, value)
}

// Add methods
func (w *WebForms) AddId(inputPlace, id string) {
	w.add("ai"+inputPlace, id)
}

func (w *WebForms) AddName(inputPlace, name string) {
	w.add("an"+inputPlace, name)
}

func (w *WebForms) AddValue(inputPlace, value string) {
	w.add("av"+inputPlace, value)
}

func (w *WebForms) AddClass(inputPlace, class string) {
	w.add("ac"+inputPlace, class)
}

func (w *WebForms) AddStyle(inputPlace, style string) {
	w.add("as"+inputPlace, style)
}

func (w *WebForms) AddStyleWithNameValue(inputPlace, name, value string) {
	w.add("as"+inputPlace, name+":"+value)
}

func (w *WebForms) AddOptionTag(inputPlace, text, value string, selected bool) {
	selectedFlag := ""
	if selected {
		selectedFlag = "|1"
	}
	w.add("ao"+inputPlace, value+"|"+text+selectedFlag)
}

func (w *WebForms) AddCheckBoxTag(inputPlace, text, value string, checked bool) {
	checkedFlag := ""
	if checked {
		checkedFlag = "|1"
	}
	w.add("ak"+inputPlace, value+"|"+text+checkedFlag)
}

func (w *WebForms) AddTitle(inputPlace, title string) {
	w.add("al"+inputPlace, title)
}

func (w *WebForms) AddLabel(inputPlace, label string) {
	w.add("aA"+inputPlace, label)
}

func (w *WebForms) AddText(inputPlace, text string) {
	w.add("at"+inputPlace, strings.ReplaceAll(text, "\n", "$[ln];"))
}

func (w *WebForms) AddTextToUp(inputPlace, text string) {
	w.add("pt"+inputPlace, strings.ReplaceAll(text, "\n", "$[ln];"))
}

func (w *WebForms) AddAttribute(inputPlace, attribute, value string, splitter ...rune) {
	splitterStr := ""
	if len(splitter) > 0 && splitter[0] != 0 {
		splitterStr = string(splitter[0])
	}
	
	attrValue := attribute + "|" + splitterStr
	if value != "" {
		attrValue += "|" + value
	}
	w.add("aa"+inputPlace, attrValue)
}

func (w *WebForms) AddTag(inputPlace, tagName, id string) {
	if id != "" {
		w.add("nt"+inputPlace, tagName+"|"+id)
	} else {
		w.add("nt"+inputPlace, tagName)
	}
}

func (w *WebForms) AddTagToUp(inputPlace, tagName, id string) {
	if id != "" {
		w.add("ut"+inputPlace, tagName+"|"+id)
	} else {
		w.add("ut"+inputPlace, tagName)
	}
}

func (w *WebForms) AddTagBefore(inputPlace, tagName, id string) {
	if id != "" {
		w.add("bt"+inputPlace, tagName+"|"+id)
	} else {
		w.add("bt"+inputPlace, tagName)
	}
}

func (w *WebForms) AddTagAfter(inputPlace, tagName, id string) {
	if id != "" {
		w.add("ft"+inputPlace, tagName+"|"+id)
	} else {
		w.add("ft"+inputPlace, tagName)
	}
}

func (w *WebForms) AddHidden(inputPlace, value, id string) {
	if id != "" {
		w.add("ah"+inputPlace, value+"|"+id)
	} else {
		w.add("ah"+inputPlace, value)
	}
}

// Set methods
func (w *WebForms) SetId(inputPlace, id string) {
	w.add("si"+inputPlace, id)
}

func (w *WebForms) SetName(inputPlace, name string) {
	w.add("sn"+inputPlace, name)
}

func (w *WebForms) SetValue(inputPlace, value string) {
	w.add("sv"+inputPlace, value)
}

func (w *WebForms) SetClass(inputPlace, class string) {
	w.add("sc"+inputPlace, class)
}

func (w *WebForms) SetStyle(inputPlace, style string) {
	w.add("ss"+inputPlace, style)
}

func (w *WebForms) SetStyleWithNameValue(inputPlace, name, value string) {
	w.add("ss"+inputPlace, name+":"+value)
}

func (w *WebForms) SetOptionTag(inputPlace, text, value string, selected bool) {
	selectedFlag := ""
	if selected {
		selectedFlag = "|1"
	}
	w.add("so"+inputPlace, value+"|"+text+selectedFlag)
}

func (w *WebForms) SetChecked(inputPlace string, checked bool) {
	if checked {
		w.add("sk"+inputPlace, "1")
	} else {
		w.add("sk"+inputPlace, "0")
	}
}

func (w *WebForms) SetCheckBoxTag(inputPlace, text, value string, checked bool) {
	checkedFlag := ""
	if checked {
		checkedFlag = "|1"
	}
	w.add("sk"+inputPlace, value+"|"+text+checkedFlag)
}

func (w *WebForms) SetTitle(inputPlace, title string) {
	w.add("sl"+inputPlace, title)
}

func (w *WebForms) SetLabel(inputPlace, label string) {
	w.add("sA"+inputPlace, label)
}

func (w *WebForms) SetText(inputPlace, text string) {
	w.add("st"+inputPlace, strings.ReplaceAll(text, "\n", "$[ln];"))
}

func (w *WebForms) SetAttribute(inputPlace, attribute, value string) {
	attrValue := attribute
	if value != "" {
		attrValue += "|" + value
	}
	w.add("sa"+inputPlace, attrValue)
}

func (w *WebForms) SetWidth(inputPlace, width string) {
	w.add("sw"+inputPlace, width)
}

func (w *WebForms) SetWidthInt(inputPlace string, width int) {
	w.SetWidth(inputPlace, strconv.Itoa(width)+"px")
}

func (w *WebForms) SetHeight(inputPlace, height string) {
	w.add("sh"+inputPlace, height)
}

func (w *WebForms) SetHeightInt(inputPlace string, height int) {
	w.SetHeight(inputPlace, strconv.Itoa(height)+"px")
}

func (w *WebForms) SetBackgroundColor(inputPlace, color string) {
	w.add("bc"+inputPlace, color)
}

func (w *WebForms) SetTextColor(inputPlace, color string) {
	w.add("tc"+inputPlace, color)
}

func (w *WebForms) SetFontName(inputPlace, name string) {
	w.add("fn"+inputPlace, name)
}

func (w *WebForms) SetFontSize(inputPlace, size string) {
	w.add("fs"+inputPlace, size)
}

func (w *WebForms) SetFontSizeInt(inputPlace string, size int) {
	w.SetFontSize(inputPlace, strconv.Itoa(size)+"px")
}

func (w *WebForms) SetFontBold(inputPlace string, bold bool) {
	if bold {
		w.add("fb"+inputPlace, "1")
	} else {
		w.add("fb"+inputPlace, "0")
	}
}

func (w *WebForms) SetVisible(inputPlace string, visible bool) {
	if visible {
		w.add("vi"+inputPlace, "1")
	} else {
		w.add("vi"+inputPlace, "0")
	}
}

func (w *WebForms) SetTextAlign(inputPlace, align string) {
	w.add("ta"+inputPlace, align)
}

func (w *WebForms) SetReadOnly(inputPlace string, readOnly bool) {
	if readOnly {
		w.add("sr"+inputPlace, "1")
	} else {
		w.add("sr"+inputPlace, "0")
	}
}

func (w *WebForms) SetDisabled(inputPlace string, disabled bool) {
	if disabled {
		w.add("sd"+inputPlace, "1")
	} else {
		w.add("sd"+inputPlace, "0")
	}
}

func (w *WebForms) SetFocus(inputPlace string, focus bool) {
	if focus {
		w.add("sf"+inputPlace, "1")
	} else {
		w.add("sf"+inputPlace, "0")
	}
}

func (w *WebForms) SetMinLength(inputPlace string, length int) {
	w.add("mn"+inputPlace, strconv.Itoa(length))
}

func (w *WebForms) SetMaxLength(inputPlace string, length int) {
	w.add("mx"+inputPlace, strconv.Itoa(length))
}

func (w *WebForms) SetSelectedValue(inputPlace, value string) {
	w.add("ts"+inputPlace, value)
}

func (w *WebForms) SetSelectedIndex(inputPlace string, index int) {
	w.add("ti"+inputPlace, strconv.Itoa(index))
}

func (w *WebForms) SetCheckedValue(inputPlace, value string, selected bool) {
	selectedStr := "0"
	if selected {
		selectedStr = "1"
	}
	w.add("ks"+inputPlace, value+"|"+selectedStr)
}

func (w *WebForms) SetCheckedIndex(inputPlace string, index int, selected bool) {
	selectedStr := "0"
	if selected {
		selectedStr = "1"
	}
	w.add("ki"+inputPlace, strconv.Itoa(index)+"|"+selectedStr)
}

// Insert methods
func (w *WebForms) InsertId(inputPlace, id string) {
	w.add("ii"+inputPlace, id)
}

func (w *WebForms) InsertName(inputPlace, name string) {
	w.add("in"+inputPlace, name)
}

func (w *WebForms) InsertValue(inputPlace, value string) {
	w.add("iv"+inputPlace, value)
}

func (w *WebForms) InsertClass(inputPlace, class string) {
	w.add("ic"+inputPlace, class)
}

func (w *WebForms) InsertStyle(inputPlace, style string) {
	w.add("is"+inputPlace, style)
}

func (w *WebForms) InsertStyleWithNameValue(inputPlace, name, value string) {
	w.add("is"+inputPlace, name+":"+value)
}

func (w *WebForms) InsertOptionTag(inputPlace, text, value string, selected bool) {
	selectedFlag := ""
	if selected {
		selectedFlag = "|1"
	}
	w.add("io"+inputPlace, value+"|"+text+selectedFlag)
}

func (w *WebForms) InsertCheckBoxTag(inputPlace, text, value string, checked bool) {
	checkedFlag := ""
	if checked {
		checkedFlag = "|1"
	}
	w.add("ik"+inputPlace, value+"|"+text+checkedFlag)
}

func (w *WebForms) InsertTitle(inputPlace, title string) {
	w.add("il"+inputPlace, title)
}

func (w *WebForms) InsertLabel(inputPlace, label string) {
	w.add("iA"+inputPlace, label)
}

func (w *WebForms) InsertText(inputPlace, text string) {
	w.add("it"+inputPlace, strings.ReplaceAll(text, "\n", "$[ln];"))
}

func (w *WebForms) InsertAttribute(inputPlace, attribute, value string, splitter ...rune) {
	splitterStr := ""
	if len(splitter) > 0 && splitter[0] != 0 {
		splitterStr = string(splitter[0])
	}
	
	attrValue := attribute + "|" + splitterStr
	if value != "" {
		attrValue += "|" + value
	}
	w.add("ia"+inputPlace, attrValue)
}

// Delete methods
func (w *WebForms) DeleteId(inputPlace string) {
	w.addNameOnly("di" + inputPlace)
}

func (w *WebForms) DeleteName(inputPlace string) {
	w.addNameOnly("dn" + inputPlace)
}

func (w *WebForms) DeleteValue(inputPlace string) {
	w.addNameOnly("dv" + inputPlace)
}

func (w *WebForms) DeleteClass(inputPlace, className string) {
	w.add("dc"+inputPlace, className)
}

func (w *WebForms) DeleteStyle(inputPlace, styleName string) {
	w.add("ds"+inputPlace, styleName)
}

func (w *WebForms) DeleteOptionTag(inputPlace, value string) {
	w.add("do"+inputPlace, value)
}

func (w *WebForms) DeleteAllOptionTag(inputPlace string) {
	w.add("do"+inputPlace, "*")
}

func (w *WebForms) DeleteCheckBoxTag(inputPlace, value string) {
	w.add("dk"+inputPlace, value)
}

func (w *WebForms) DeleteAllCheckBoxTag(inputPlace string) {
	w.add("dk"+inputPlace, "*")
}

func (w *WebForms) DeleteTitle(inputPlace string) {
	w.addNameOnly("dl" + inputPlace)
}

func (w *WebForms) DeleteLabel(inputPlace string) {
	w.addNameOnly("dA" + inputPlace)
}

func (w *WebForms) DeleteText(inputPlace string) {
	w.addNameOnly("dt" + inputPlace)
}

func (w *WebForms) DeleteAttribute(inputPlace, attribute string) {
	w.add("da"+inputPlace, attribute)
}

func (w *WebForms) Delete(inputPlace string) {
	w.addNameOnly("de" + inputPlace)
}

func (w *WebForms) DeleteParent(inputPlace string) {
	w.addNameOnly("dp" + inputPlace)
}

// Tag methods
func (w *WebForms) SwapTag(inputPlace, outputPlace string) {
	w.add("sp"+inputPlace, outputPlace)
}

func (w *WebForms) SetReflection(inputPlace, tag string) {
	w.add("sR"+inputPlace, tag)
}

func (w *WebForms) SetReflectionByOutputPlace(inputPlace, outputPlace string) {
	w.add("iR"+inputPlace, outputPlace)
}

// Browser methods
func (w *WebForms) ChangeUrl(url string) {
	w.add("cu", url)
}

func (w *WebForms) SetHeadTitle(title string) {
	w.add("ht", title)
}

func (w *WebForms) ClipboardWriteText(text string) {
	w.add("nw", text)
}

func (w *WebForms) ScrollTo(x, y int) {
	w.add("ws", strconv.Itoa(x)+"|"+strconv.Itoa(y))
}

func (w *WebForms) HistoryGo(steps int) {
	w.add("wg", strconv.Itoa(steps))
}

func (w *WebForms) ReloadPage() {
	w.addNameOnly("lr")
}

func (w *WebForms) Redirect(path string) {
	w.add("lh", path)
}

// Increase methods
func (w *WebForms) IncreaseMinLength(inputPlace string, value int) {
	w.add("+n"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) IncreaseMaxLength(inputPlace string, value int) {
	w.add("+x"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) IncreaseFontSize(inputPlace string, value int) {
	w.add("+f"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) IncreaseWidth(inputPlace string, value int) {
	w.add("+w"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) IncreaseHeight(inputPlace string, value int) {
	w.add("+h"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) IncreaseValue(inputPlace string, value int) {
	w.add("+v"+inputPlace, strconv.Itoa(value))
}

// Decrease methods
func (w *WebForms) DecreaseMinLength(inputPlace string, value int) {
	w.add("-n"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) DecreaseMaxLength(inputPlace string, value int) {
	w.add("-x"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) DecreaseFontSize(inputPlace string, value int) {
	w.add("-f"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) DecreaseWidth(inputPlace string, value int) {
	w.add("-w"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) DecreaseHeight(inputPlace string, value int) {
	w.add("-h"+inputPlace, strconv.Itoa(value))
}

func (w *WebForms) DecreaseValue(inputPlace string, value int) {
	w.add("-v"+inputPlace, strconv.Itoa(value))
}

// Event methods
func (w *WebForms) TriggerEvent(inputPlace, htmlEventListener, constructorName string) {
	eventValue := htmlEventListener
	if constructorName != "" {
		eventValue += "|" + constructorName
	}
	w.add("TE"+inputPlace, eventValue)
}

func (w *WebForms) SetPostEvent(inputPlace, htmlEvent string) {
	w.add("Ep"+inputPlace, htmlEvent)
}

func (w *WebForms) SetPostEventView(inputPlace, htmlEvent string) {
	w.add("Ep"+inputPlace, htmlEvent+"|+")
}

func (w *WebForms) SetPostEventTo(inputPlace, htmlEvent, outputPlace string) {
	w.add("Ep"+inputPlace, htmlEvent+"|"+outputPlace)
}

func (w *WebForms) SetPostEventListener(inputPlace, htmlEventListener string) {
	w.add("EP"+inputPlace, htmlEventListener)
}

func (w *WebForms) SetPostEventListenerView(inputPlace, htmlEventListener string) {
	w.add("EP"+inputPlace, htmlEventListener+"|+")
}

func (w *WebForms) SetPostEventListenerTo(inputPlace, htmlEventListener, outputPlace string) {
	w.add("EP"+inputPlace, htmlEventListener+"|"+outputPlace)
}

func (w *WebForms) SetGetEvent(inputPlace, htmlEvent string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("Eg"+inputPlace, htmlEvent+"|"+pathValue)
}

func (w *WebForms) SetGetEventWithOutput(inputPlace, htmlEvent, outputPlace string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("Eg"+inputPlace, htmlEvent+"|"+pathValue+"|"+outputPlace)
}

func (w *WebForms) SetGetEventListener(inputPlace, htmlEventListener string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("EG"+inputPlace, htmlEventListener+"|"+pathValue)
}

func (w *WebForms) SetGetEventListenerWithOutput(inputPlace, htmlEventListener, outputPlace string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("EG"+inputPlace, htmlEventListener+"|"+pathValue+"|"+outputPlace)
}

func (w *WebForms) SetPatchEvent(inputPlace, htmlEvent string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("Ea"+inputPlace, htmlEvent+"|"+pathValue)
}

func (w *WebForms) SetPatchEventWithOutput(inputPlace, htmlEvent, outputPlace string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("Ea"+inputPlace, htmlEvent+"|"+pathValue+"|"+outputPlace)
}

func (w *WebForms) SetPatchEventListener(inputPlace, htmlEventListener string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("EA"+inputPlace, htmlEventListener+"|"+pathValue)
}

func (w *WebForms) SetPatchEventListenerWithOutput(inputPlace, htmlEventListener, outputPlace string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("EA"+inputPlace, htmlEventListener+"|"+pathValue+"|"+outputPlace)
}

func (w *WebForms) SetDeleteEvent(inputPlace, htmlEvent string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("El"+inputPlace, htmlEvent+"|"+pathValue)
}

func (w *WebForms) SetDeleteEventWithOutput(inputPlace, htmlEvent, outputPlace string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("El"+inputPlace, htmlEvent+"|"+pathValue+"|"+outputPlace)
}

func (w *WebForms) SetDeleteEventListener(inputPlace, htmlEventListener string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("EL"+inputPlace, htmlEventListener+"|"+pathValue)
}

func (w *WebForms) SetDeleteEventListenerWithOutput(inputPlace, htmlEventListener, outputPlace string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("EL"+inputPlace, htmlEventListener+"|"+pathValue+"|"+outputPlace)
}

func (w *WebForms) SetOptionsEvent(inputPlace, htmlEvent string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("Eo"+inputPlace, htmlEvent+"|"+pathValue)
}

func (w *WebForms) SetOptionsEventWithOutput(inputPlace, htmlEvent, outputPlace string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("Eo"+inputPlace, htmlEvent+"|"+pathValue+"|"+outputPlace)
}

func (w *WebForms) SetOptionsEventListener(inputPlace, htmlEventListener string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("EO"+inputPlace, htmlEventListener+"|"+pathValue)
}

func (w *WebForms) SetOptionsEventListenerWithOutput(inputPlace, htmlEventListener, outputPlace string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("EO"+inputPlace, htmlEventListener+"|"+pathValue+"|"+outputPlace)
}

func (w *WebForms) SetTraceEvent(inputPlace, htmlEvent string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("Er"+inputPlace, htmlEvent+"|"+pathValue)
}

func (w *WebForms) SetTraceEventWithOutput(inputPlace, htmlEvent, outputPlace string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("Er"+inputPlace, htmlEvent+"|"+pathValue+"|"+outputPlace)
}

func (w *WebForms) SetTraceEventListener(inputPlace, htmlEventListener string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("ER"+inputPlace, htmlEventListener+"|"+pathValue)
}

func (w *WebForms) SetTraceEventListenerWithOutput(inputPlace, htmlEventListener, outputPlace string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("ER"+inputPlace, htmlEventListener+"|"+pathValue+"|"+outputPlace)
}

func (w *WebForms) SetConnectEvent(inputPlace, htmlEvent string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("Ec"+inputPlace, htmlEvent+"|"+pathValue)
}

func (w *WebForms) SetConnectEventWithOutput(inputPlace, htmlEvent, outputPlace string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("Ec"+inputPlace, htmlEvent+"|"+pathValue+"|"+outputPlace)
}

func (w *WebForms) SetConnectEventListener(inputPlace, htmlEventListener string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("EC"+inputPlace, htmlEventListener+"|"+pathValue)
}

func (w *WebForms) SetConnectEventListenerWithOutput(inputPlace, htmlEventListener, outputPlace string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("EC"+inputPlace, htmlEventListener+"|"+pathValue+"|"+outputPlace)
}

func (w *WebForms) SetHeadEvent(inputPlace, htmlEvent string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("Eh"+inputPlace, htmlEvent+"|"+pathValue)
}

func (w *WebForms) SetHeadEventListener(inputPlace, htmlEventListener string, path ...string) {
	pathValue := "#"
	if len(path) > 0 && path[0] != "" {
		pathValue = path[0]
	}
	w.add("EH"+inputPlace, htmlEventListener+"|"+pathValue)
}

func (w *WebForms) SetTagEvent(inputPlace, htmlEvent, outputPlace string) {
	w.add("Et"+inputPlace, htmlEvent+"|"+outputPlace)
}

func (w *WebForms) SetTagEventListener(inputPlace, htmlEventListener, outputPlace string) {
	w.add("ET"+inputPlace, htmlEventListener+"|"+outputPlace)
}

func (w *WebForms) SetCommentEvent(inputPlace, htmlEvent, index string, outputPlace ...string) {
	outputPlaceValue := ""
	if len(outputPlace) > 0 {
		outputPlaceValue = outputPlace[0]
	}
	w.add("Eb"+inputPlace, htmlEvent+"|"+index+"|"+outputPlaceValue)
}

func (w *WebForms) SetCommentEventWithInt(inputPlace, htmlEvent string, index int, outputPlace ...string) {
	outputPlaceValue := ""
	if len(outputPlace) > 0 {
		outputPlaceValue = outputPlace[0]
	}
	w.SetCommentEvent(inputPlace, htmlEvent, strconv.Itoa(index), outputPlaceValue)
}

func (w *WebForms) SetCommentEventListener(inputPlace, htmlEventListener, index string, outputPlace ...string) {
	outputPlaceValue := ""
	if len(outputPlace) > 0 {
		outputPlaceValue = outputPlace[0]
	}
	w.add("EB"+inputPlace, htmlEventListener+"|"+index+"|"+outputPlaceValue)
}

func (w *WebForms) SetCommentEventListenerWithInt(inputPlace, htmlEventListener string, index int, outputPlace ...string) {
	outputPlaceValue := ""
	if len(outputPlace) > 0 {
		outputPlaceValue = outputPlace[0]
	}
	w.SetCommentEventListener(inputPlace, htmlEventListener, strconv.Itoa(index), outputPlaceValue)
}

func (w *WebForms) SetWasmEvent(inputPlace, htmlEvent, wasmLanguage, wasmUrl, methodName string, args []string, outputPlace ...string) {
	argsJoin := ""
	if args != nil && len(args) > 0 {
		argsJoin = strings.Join(args, ",")
	}
	
	outputPlaceValue := ""
	if len(outputPlace) > 0 {
		outputPlaceValue = outputPlace[0]
	}
	
	w.add("Ey"+inputPlace, htmlEvent+"|"+wasmLanguage+"|"+wasmUrl+"|"+methodName+"|"+argsJoin+"|"+outputPlaceValue)
}

func (w *WebForms) SetWasmEventListener(inputPlace, htmlEventListener, wasmLanguage, wasmUrl, methodName string, args []string, outputPlace ...string) {
	argsJoin := ""
	if args != nil && len(args) > 0 {
		argsJoin = strings.Join(args, ",")
	}
	
	outputPlaceValue := ""
	if len(outputPlace) > 0 {
		outputPlaceValue = outputPlace[0]
	}
	
	w.add("EY"+inputPlace, htmlEventListener+"|"+wasmLanguage+"|"+wasmUrl+"|"+methodName+"|"+argsJoin+"|"+outputPlaceValue)
}

func (w *WebForms) SetWebSocketEvent(inputPlace, htmlEvent, path string) {
	w.add("Ew"+inputPlace, htmlEvent+"|"+path)
}

func (w *WebForms) SetWebSocketEventListener(inputPlace, htmlEventListener, path string) {
	w.add("EW"+inputPlace, htmlEventListener+"|"+path)
}

func (w *WebForms) SetSSEEvent(inputPlace, htmlEvent, path string, shouldReconnect bool, reconnectTryTimeout int, outputPlace ...string) {
	shouldReconnectStr := "0"
	if shouldReconnect {
		shouldReconnectStr = "1"
	}
	
	eventValue := htmlEvent + "|" + path + "|" + shouldReconnectStr + "|" + strconv.Itoa(reconnectTryTimeout)
	
	if len(outputPlace) > 0 && outputPlace[0] != "" {
		eventValue += "|" + outputPlace[0]
	}
	
	w.add("Ee"+inputPlace, eventValue)
}

func (w *WebForms) SetSSEEventListener(inputPlace, htmlEventListener, path string, shouldReconnect bool, reconnectTryTimeout int, outputPlace ...string) {
	shouldReconnectStr := "0"
	if shouldReconnect {
		shouldReconnectStr = "1"
	}
	
	eventValue := htmlEventListener + "|" + path + "|" + shouldReconnectStr + "|" + strconv.Itoa(reconnectTryTimeout)
	
	if len(outputPlace) > 0 && outputPlace[0] != "" {
		eventValue += "|" + outputPlace[0]
	}
	
	w.add("EE"+inputPlace, eventValue)
}

func (w *WebForms) SetFrontEvent(inputPlace, htmlEvent, modulePath string, args []string, outputPlace ...string) {
	argsJoin := ""
	if args != nil && len(args) > 0 {
		argsJoin = "|" + strings.Join(args, "|")
	}
	
	outputPlaceValue := ""
	if len(outputPlace) > 0 {
		outputPlaceValue = outputPlace[0]
	}
	
	w.add("Ej"+inputPlace, htmlEvent+"|"+modulePath+"|"+outputPlaceValue+argsJoin)
}

func (w *WebForms) SetFrontEventListener(inputPlace, htmlEventListener, modulePath string, args []string, outputPlace ...string) {
	argsJoin := ""
	if args != nil && len(args) > 0 {
		argsJoin = "|" + strings.Join(args, "|")
	}
	
	outputPlaceValue := ""
	if len(outputPlace) > 0 {
		outputPlaceValue = outputPlace[0]
	}
	
	w.add("EJ"+inputPlace, htmlEventListener+"|"+modulePath+"|"+outputPlaceValue+argsJoin)
}

func (w *WebForms) SetSendEvent(inputPlace, htmlEvent, data string, path, method string, isMultiPart bool, contentType string, outputPlace ...string) {
	pathValue := "#"
	if path != "" {
		pathValue = path
	}
	
	isMultiPartStr := "0"
	if isMultiPart {
		isMultiPartStr = "1"
	}
	
	outputPlaceValue := ""
	if len(outputPlace) > 0 {
		outputPlaceValue = outputPlace[0]
	}
	
	processedData := strings.ReplaceAll(data, "\n", "$[ln];")
	processedData = strings.ReplaceAll(processedData, "\"", "$[dq];")
	processedData = strings.ReplaceAll(processedData, "'", "$[sq];")
	
	w.add("En"+inputPlace, htmlEvent+"|"+processedData+"|"+pathValue+"|"+method+"|"+isMultiPartStr+"|"+contentType+"|"+outputPlaceValue)
}

func (w *WebForms) SetSendEventListener(inputPlace, htmlEventListener, data string, path, method string, isMultiPart bool, contentType string, outputPlace ...string) {
	pathValue := "#"
	if path != "" {
		pathValue = path
	}
	
	isMultiPartStr := "0"
	if isMultiPart {
		isMultiPartStr = "1"
	}
	
	outputPlaceValue := ""
	if len(outputPlace) > 0 {
		outputPlaceValue = outputPlace[0]
	}
	
	processedData := strings.ReplaceAll(data, "\n", "$[ln];")
	
	w.add("EN"+inputPlace, htmlEventListener+"|"+processedData+"|"+pathValue+"|"+method+"|"+isMultiPartStr+"|"+contentType+"|"+outputPlaceValue)
}

func (w *WebForms) SetMasterPagesEvent(inputPlace, htmlEvent string, outputPlace ...string) {
	outputPlaceValue := ""
	if len(outputPlace) > 0 {
		outputPlaceValue = outputPlace[0]
	}
	w.add("Eu"+inputPlace, htmlEvent+"|"+outputPlaceValue)
}

func (w *WebForms) SetMasterPagesEventListener(inputPlace, htmlEventListener string, outputPlace ...string) {
	outputPlaceValue := ""
	if len(outputPlace) > 0 {
		outputPlaceValue = outputPlace[0]
	}
	w.add("EU"+inputPlace, htmlEventListener+"|"+outputPlaceValue)
}

func (w *WebForms) SetPreventDefaultEvent(inputPlace, htmlEvent string) {
	w.add("Ed"+inputPlace, htmlEvent)
}

func (w *WebForms) SetPreventDefaultEventListener(inputPlace, htmlEventListener string) {
	w.add("ED"+inputPlace, htmlEventListener)
}

func (w *WebForms) SetStopPropagationEvent(inputPlace, htmlEvent string) {
	w.add("Es"+inputPlace, htmlEvent)
}

func (w *WebForms) SetStopPropagationEventListener(inputPlace, htmlEventListener string) {
	w.add("ES"+inputPlace, htmlEventListener)
}

func (w *WebForms) SetMethodEvent(inputPlace, htmlEvent, methodName string, args []string) {
	argsJoin := ""
	if args != nil && len(args) > 0 {
		argsJoin = "|" + strings.Join(args, "|")
	}
	w.add("Em"+inputPlace, htmlEvent+"|"+methodName+argsJoin)
}

func (w *WebForms) SetMethodEventListener(inputPlace, htmlEventListener, methodName string, args []string) {
	argsJoin := ""
	if args != nil && len(args) > 0 {
		argsJoin = "|" + strings.Join(args, "|")
	}
	w.add("EM"+inputPlace, htmlEventListener+"|"+methodName+argsJoin)
}

func (w *WebForms) SetModuleMethodEvent(inputPlace, htmlEvent, methodName string, args []string) {
	argsJoin := ""
	if args != nil && len(args) > 0 {
		argsJoin = "|" + strings.Join(args, "|")
	}
	w.add("Ex"+inputPlace, htmlEvent+"|"+methodName+argsJoin)
}

func (w *WebForms) SetModuleMethodEventListener(inputPlace, htmlEventListener, methodName string, args []string) {
	argsJoin := ""
	if args != nil && len(args) > 0 {
		argsJoin = "|" + strings.Join(args, "|")
	}
	w.add("EX"+inputPlace, htmlEventListener+"|"+methodName+argsJoin)
}

func (w *WebForms) AssignConfirmEvent(inputPlace, htmlEvent, text, confirmType, title, okText, cancelText string) {
	textValue := ""
	if text != "Are you sure you want to proceed?" {
		textValue = text
	}
	
	typeValue := ""
	if confirmType != "none" {
		typeValue = confirmType
	}
	
	titleValue := ""
	if title != "Confirm" {
		titleValue = title
	}
	
	okTextValue := ""
	if okText != "OK" {
		okTextValue = okText
	}
	
	cancelTextValue := ""
	if cancelText != "Cancel" {
		cancelTextValue = cancelText
	}
	
	w.add("Ef"+inputPlace, htmlEvent+"|"+textValue+"|"+typeValue+"|"+titleValue+"|"+okTextValue+"|"+cancelTextValue)
}

// Remove event methods
func (w *WebForms) RemovePostEvent(inputPlace, htmlEvent string) {
	w.add("Rp"+inputPlace, htmlEvent)
}

func (w *WebForms) RemovePostEventListener(inputPlace, htmlEventListener string) {
	w.add("RP"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveGetEvent(inputPlace, htmlEvent string) {
	w.add("Rg"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveGetEventListener(inputPlace, htmlEventListener string) {
	w.add("RG"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemovePatchEvent(inputPlace, htmlEvent string) {
	w.add("Ra"+inputPlace, htmlEvent)
}

func (w *WebForms) RemovePatchEventListener(inputPlace, htmlEventListener string) {
	w.add("RA"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveDeleteEvent(inputPlace, htmlEvent string) {
	w.add("Rl"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveDeleteEventListener(inputPlace, htmlEventListener string) {
	w.add("RL"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveHeadEvent(inputPlace, htmlEvent string) {
	w.add("Rh"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveHeadEventListener(inputPlace, htmlEventListener string) {
	w.add("RH"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveOptionsEvent(inputPlace, htmlEvent string) {
	w.add("Ro"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveOptionsEventListener(inputPlace, htmlEventListener string) {
	w.add("RO"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveTraceEvent(inputPlace, htmlEvent string) {
	w.add("Rr"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveTraceEventListener(inputPlace, htmlEventListener string) {
	w.add("RR"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveConnectEvent(inputPlace, htmlEvent string) {
	w.add("Rc"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveConnectEventListener(inputPlace, htmlEventListener string) {
	w.add("RC"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveTagEvent(inputPlace, htmlEvent string) {
	w.add("Rt"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveTagEventListener(inputPlace, htmlEventListener string) {
	w.add("RT"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveCommentEvent(inputPlace, htmlEvent string) {
	w.add("Rb"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveCommentEventListener(inputPlace, htmlEventListener string) {
	w.add("RB"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveWasmEvent(inputPlace, htmlEvent string) {
	w.add("Ry"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveWasmEventListener(inputPlace, htmlEventListener string) {
	w.add("RY"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveWebSocketEvent(inputPlace, htmlEvent string) {
	w.add("Rw"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveWebSocketEventListener(inputPlace, htmlEventListener string) {
	w.add("RW"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveSSEEvent(inputPlace, htmlEvent string) {
	w.add("Re"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveSSEEventListener(inputPlace, htmlEventListener string) {
	w.add("RE"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveFrontEvent(inputPlace, htmlEvent string) {
	w.add("Rj"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveFrontEventListener(inputPlace, htmlEventListener string) {
	w.add("RJ"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveSendEvent(inputPlace, htmlEvent string) {
	w.add("Rn"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveSendEventListener(inputPlace, htmlEventListener string) {
	w.add("RN"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemovePreventDefaultEvent(inputPlace, htmlEvent string) {
	w.add("Rd"+inputPlace, htmlEvent)
}

func (w *WebForms) RemovePreventDefaultEventListener(inputPlace, htmlEventListener string) {
	w.add("RD"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveMasterPagesEvent(inputPlace, htmlEvent string) {
	w.add("Ru"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveMasterPagesEventListener(inputPlace, htmlEventListener string) {
	w.add("RU"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveStopPropagationEvent(inputPlace, htmlEvent string) {
	w.add("Rs"+inputPlace, htmlEvent)
}

func (w *WebForms) RemoveStopPropagationEventListener(inputPlace, htmlEventListener string) {
	w.add("RS"+inputPlace, htmlEventListener)
}

func (w *WebForms) RemoveMethodEvent(inputPlace, htmlEvent, methodName string) {
	w.add("Rm"+inputPlace, htmlEvent+"|"+methodName)
}

func (w *WebForms) RemoveMethodEventListener(inputPlace, htmlEventListener, methodName string) {
	w.add("RM"+inputPlace, htmlEventListener+"|"+methodName)
}

func (w *WebForms) RemoveModuleMethodEvent(inputPlace, htmlEvent, methodName string) {
	w.add("Rx"+inputPlace, htmlEvent+"|"+methodName)
}

func (w *WebForms) RemoveModuleMethodEventListener(inputPlace, htmlEventListener, methodName string) {
	w.add("RX"+inputPlace, htmlEventListener+"|"+methodName)
}

func (w *WebForms) RemoveConfirmEvent(inputPlace, htmlEvent string) {
	w.add("Rf"+inputPlace, htmlEvent)
}

// Custom Event methods
func (w *WebForms) CreateCustomDOMEvent(inputPlace, eventName, watch, key, compare, value, rangeValue string, immediate bool, delay int) {
	immediateStr := "0"
	if immediate {
		immediateStr = "1"
	}
	w.add("eC"+inputPlace, eventName+"|"+watch+"|"+key+"|"+compare+"|"+value+"|"+rangeValue+"|"+immediateStr+"|"+strconv.Itoa(delay))
}

func (w *WebForms) EnableScrollBottomEvent(enable bool) {
	if enable {
		w.add("eb", "1")
	} else {
		w.add("eb", "0")
	}
}

func (w *WebForms) EnableReachedElementEvent(inputPlace string, once, enable bool) {
	onceStr := "0"
	if once {
		onceStr = "1"
	}
	
	enableStr := "0"
	if enable {
		enableStr = "1"
	}
	
	w.add("er"+inputPlace, onceStr+"|"+enableStr)
}

// Module methods
func (w *WebForms) LoadModule(modulePath string, methods []string) {
	methodsJoin := ""
	if len(methods) > 0 {
		methodsJoin = "|" + strings.Join(methods, "|")
	}
	w.add("Ml", modulePath+methodsJoin)
}

func (w *WebForms) UnloadModule(modulePath string) {
	w.add("Mu", modulePath)
}

func (w *WebForms) DeleteModuleMethod(methodName string) {
	w.add("Md", methodName)
}

// Unit Testing methods
func (w *WebForms) AssertEqual(inputPlace, tag string) {
	w.add("At"+inputPlace, strings.ReplaceAll(tag, "\n", "$[ln];"))
}

func (w *WebForms) AssertEqualByOutputPlace(inputPlace, outputPlace string) {
	w.add("Ao"+inputPlace, outputPlace)
}

// Service Worker methods
func (w *WebForms) ServiceWorkerRegister(path, scopePath string) {
	pathValue := ""
	if path != "" {
		pathValue = path
	}
	
	scopePathValue := ""
	if scopePath != "" {
		scopePathValue = scopePath
	}
	
	w.add("wR", pathValue+"|"+scopePathValue)
}

func (w *WebForms) ServiceWorkerPreCacheStatic(pathList []string) {
	w.add("wp", strings.Join(pathList, "|"))
}

func (w *WebForms) ServiceWorkerDynamicCache(path string, seconds int) {
	if seconds > 0 {
		w.add("wc", path+"|"+strconv.Itoa(seconds))
	} else {
		w.add("wc", path)
	}
}

func (w *WebForms) ServiceWorkerDeleteDynamicCache() {
	w.addNameOnly("wd")
}

func (w *WebForms) ServiceWorkerDeleteDynamicCachePath(path string) {
	w.add("wd", path)
}

func (w *WebForms) ServiceWorkerDynamicCacheTTLUpdate(path string, seconds int) {
	if seconds > 0 {
		w.add("wt", path+"|"+strconv.Itoa(seconds))
	} else {
		w.add("wt", path)
	}
}

func (w *WebForms) ServiceWorkerRouteSet(path, routeType string, cacheDynamic bool) {
	cacheDynamicStr := "0"
	if cacheDynamic {
		cacheDynamicStr = "1"
	}
	w.add("wr", path+"|"+routeType+"|"+cacheDynamicStr)
}

func (w *WebForms) ServiceWorkerRouteAlias(path, to string) {
	w.add("wa", path+"|"+to)
}

func (w *WebForms) ServiceWorkerDeleteRouteAlias(path string) {
	w.add("wC", path)
}

func (w *WebForms) ServiceWorkerDeleteRoute() {
	w.addNameOnly("wD")
}

func (w *WebForms) ServiceWorkerDeleteRoutePath(path string) {
	w.add("wD", path)
}

// SSE methods
func (w *WebForms) DisconnectSSE(path string) {
	w.add("Ds", path)
}

func (w *WebForms) DisconnectAllSSE() {
	w.addNameOnly("Ds")
}

// State methods
func (w *WebForms) AddState(path, title string) {
	pathValue := ""
	if path != "" {
		pathValue = path
	}
	
	titleValue := ""
	if title != "" {
		titleValue = title
	}
	
	w.add("AS", pathValue+"|"+titleValue)
}

func (w *WebForms) DeleteState(path string) {
	w.add("DS", path)
}

func (w *WebForms) DeleteAllState() {
	w.add("DS", "*")
}

// Cookie methods
func (w *WebForms) SetCookie(key, value string, seconds int, path string) {
	pathValue := ""
	if path != "" {
		pathValue = "|" + path
	}
	w.add("sC", key+"|"+value+"|"+strconv.Itoa(seconds)+pathValue)
}

// Save/Session Cache methods
func (w *WebForms) SaveId(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gi"+inputPlace, key)
}

func (w *WebForms) SaveName(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gn"+inputPlace, key)
}

func (w *WebForms) SaveValue(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gv"+inputPlace, key)
}

func (w *WebForms) SaveValueLength(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@ge"+inputPlace, key)
}

func (w *WebForms) SaveClass(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gc"+inputPlace, key)
}

func (w *WebForms) SaveStyle(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gs"+inputPlace, key)
}

func (w *WebForms) SaveTitle(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gl"+inputPlace, key)
}

func (w *WebForms) SaveLabel(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gA"+inputPlace, key)
}

func (w *WebForms) SaveText(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gt"+inputPlace, key)
}

func (w *WebForms) SaveOuterText(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@go"+inputPlace, key)
}

func (w *WebForms) SaveTextLength(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gg"+inputPlace, key)
}

func (w *WebForms) SaveAttribute(inputPlace, attribute, key string) {
	if key == "" {
		key = "."
	}
	w.add("@ga"+inputPlace, key+"|"+attribute)
}

func (w *WebForms) SaveWidth(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gw"+inputPlace, key)
}

func (w *WebForms) SaveHeight(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gh"+inputPlace, key)
}

func (w *WebForms) SaveReadOnly(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gr"+inputPlace, key)
}

func (w *WebForms) SaveSelectedIndex(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gx"+inputPlace, key)
}

func (w *WebForms) SaveTextAlign(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gT"+inputPlace, key)
}

func (w *WebForms) SaveNodeLength(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gL"+inputPlace, key)
}

func (w *WebForms) SaveVisible(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gV"+inputPlace, key)
}

func (w *WebForms) SaveUrl(url string, fetchScript bool, key string) {
	if key == "" {
		key = "."
	}
	
	fetchScriptStr := "0"
	if fetchScript {
		fetchScriptStr = "1"
	}
	
	w.add("@gu", key+"|"+url+"|"+fetchScriptStr)
}

func (w *WebForms) SaveIndex(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@gI"+inputPlace, key)
}

func (w *WebForms) RemoveSessionCache(cacheKey string) {
	w.add("rs", cacheKey)
}

func (w *WebForms) RemoveAllSessionCache() {
	w.add("rs", "*")
}

func (w *WebForms) SetSessionCache() {
	w.add("cs", "*")
}

func (w *WebForms) AddSessionCacheValue(cacheKey, value string) {
	w.add("SA", cacheKey+"|"+strings.ReplaceAll(value, "\n", "$[ln];"))
}

func (w *WebForms) InsertSessionCacheValue(cacheKey, value string) {
	w.add("SI", cacheKey+"|"+strings.ReplaceAll(value, "\n", "$[ln];"))
}

// Cache methods
func (w *WebForms) CacheId(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@ci"+inputPlace, key)
}

func (w *WebForms) CacheName(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cn"+inputPlace, key)
}

func (w *WebForms) CacheValue(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cv"+inputPlace, key)
}

func (w *WebForms) CacheValueLength(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@ce"+inputPlace, key)
}

func (w *WebForms) CacheClass(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cc"+inputPlace, key)
}

func (w *WebForms) CacheStyle(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cs"+inputPlace, key)
}

func (w *WebForms) CacheTitle(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cl"+inputPlace, key)
}

func (w *WebForms) CacheLabel(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cA"+inputPlace, key)
}

func (w *WebForms) CacheText(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@ct"+inputPlace, key)
}

func (w *WebForms) CacheOuterText(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@co"+inputPlace, key)
}

func (w *WebForms) CacheTextLength(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cg"+inputPlace, key)
}

func (w *WebForms) CacheAttribute(inputPlace, attribute, key string) {
	if key == "" {
		key = "."
	}
	w.add("@ca"+inputPlace, key+"|"+attribute)
}

func (w *WebForms) CacheWidth(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cw"+inputPlace, key)
}

func (w *WebForms) CacheHeight(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@ch"+inputPlace, key)
}

func (w *WebForms) CacheReadOnly(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cr"+inputPlace, key)
}

func (w *WebForms) CacheSelectedIndex(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cx"+inputPlace, key)
}

func (w *WebForms) CacheTextAlign(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cT"+inputPlace, key)
}

func (w *WebForms) CacheNodeLength(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cL"+inputPlace, key)
}

func (w *WebForms) CacheVisible(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cV"+inputPlace, key)
}

func (w *WebForms) CacheUrl(url string, fetchScript bool, key string) {
	if key == "" {
		key = "."
	}
	
	fetchScriptStr := "0"
	if fetchScript {
		fetchScriptStr = "1"
	}
	
	w.add("@cu", key+"|"+url+"|"+fetchScriptStr)
}

func (w *WebForms) CacheIndex(inputPlace, key string) {
	if key == "" {
		key = "."
	}
	w.add("@cI"+inputPlace, key)
}

func (w *WebForms) RemoveCache(cacheKey string) {
	w.add("rd", cacheKey)
}

func (w *WebForms) RemoveAllCache() {
	w.add("rd", "*")
}

func (w *WebForms) SetCacheTime(second int) {
	w.add("cd", strconv.Itoa(second))
}

func (w *WebForms) SetCache() {
	w.add("cd", "*")
}

func (w *WebForms) AddCacheValue(cacheKey, value string) {
	w.add("CA", cacheKey+"|"+strings.ReplaceAll(value, "\n", "$[ln];"))
}

func (w *WebForms) InsertCacheValue(cacheKey, value string) {
	w.add("CI", cacheKey+"|"+strings.ReplaceAll(value, "\n", "$[ln];"))
}

// Call methods
func (w *WebForms) LoadUrl(inputPlace, url string) {
	w.add("lu"+inputPlace, url)
}

func (w *WebForms) RunActionControls(actionControls, index string, withoutWebFormsSection, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	withoutWebFormsSectionStr := "0"
	if withoutWebFormsSection {
		withoutWebFormsSectionStr = "1"
	}
	
	w.add("lA", useCurrentEventStr+"|"+withoutWebFormsSectionStr+"|"+index+"|"+actionControls)
}

func (w *WebForms) RunActionControlsInt(actionControls string, index int, withoutWebFormsSection, useCurrentEvent bool) {
	w.RunActionControls(actionControls, strconv.Itoa(index), withoutWebFormsSection, useCurrentEvent)
}

func (w *WebForms) CallScript(scriptText string) {
	w.add("_", strings.ReplaceAll(scriptText, "\n", "$[ln];"))
}

func (w *WebForms) CallMethod(methodName string, args []string) {
	argsJoin := ""
	if args != nil && len(args) > 0 {
		argsJoin = "|" + strings.Join(args, "|")
	}
	w.add("lm", methodName+argsJoin)
}

func (w *WebForms) CallModuleMethod(methodName string, args []string) {
	argsJoin := ""
	if args != nil && len(args) > 0 {
		argsJoin = "|" + strings.Join(args, "|")
	}
	w.add("lM", methodName+argsJoin)
}

func (w *WebForms) CallPostBack(formInputPlace, outputPlace string) {
	outputPlaceValue := ""
	if outputPlace != "" {
		outputPlaceValue = "|" + outputPlace
	}
	w.add("Lp", "1|"+formInputPlace+outputPlaceValue)
}

func (w *WebForms) CallTagBack(outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	outputPlaceValue := ""
	if outputPlace != "" {
		outputPlaceValue = "|" + outputPlace
	}
	
	w.add("Lt", useCurrentEventStr+outputPlaceValue)
}

func (w *WebForms) CallCommentBack(index, outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	w.add("LC", useCurrentEventStr+"|"+index+"|"+outputPlace)
}

func (w *WebForms) CallCommentBackInt(index int, outputPlace string, useCurrentEvent bool) {
	w.CallCommentBack(strconv.Itoa(index), outputPlace, useCurrentEvent)
}

func (w *WebForms) CallWasmBack(wasmLanguage, wasmUrl, methodName string, args []string, outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	argsJoin := ""
	if args != nil && len(args) > 0 {
		argsJoin = strings.Join(args, ",")
	}
	
	w.add("Ly", useCurrentEventStr+"|"+wasmLanguage+"|"+wasmUrl+"|"+methodName+"|"+argsJoin+"|"+outputPlace)
}

func (w *WebForms) CallWebSocketBack(path string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	w.add("Lw", useCurrentEventStr+"|"+path)
}

func (w *WebForms) CallSSEBack(path, outputPlace string, useCurrentEvent, shouldReconnect bool, reconnectTryTimeout int) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	shouldReconnectStr := "0"
	if shouldReconnect {
		shouldReconnectStr = "1"
	}
	
	outputPlaceValue := ""
	if outputPlace != "" {
		outputPlaceValue = "|" + outputPlace
	}
	
	w.add("Ls", useCurrentEventStr+"|"+path+"|"+shouldReconnectStr+"|"+strconv.Itoa(reconnectTryTimeout)+outputPlaceValue)
}

func (w *WebForms) CallFront(modulePath string, args []string, outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	argsJoin := ""
	if args != nil && len(args) > 0 {
		argsJoin = "|" + strings.Join(args, "|")
	}
	
	w.add("Lj", useCurrentEventStr+"|"+modulePath+"|"+outputPlace+argsJoin)
}

func (w *WebForms) CallGetBack(path, outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	outputPlaceValue := ""
	if outputPlace != "" {
		outputPlaceValue = "|" + outputPlace
	}
	
	w.add("Lg", useCurrentEventStr+"|"+path+outputPlaceValue)
}

func (w *WebForms) CallPutBack(path, outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	outputPlaceValue := ""
	if outputPlace != "" {
		outputPlaceValue = "|" + outputPlace
	}
	
	w.add("Lu", useCurrentEventStr+"|"+path+outputPlaceValue)
}

func (w *WebForms) CallPatchBack(path, outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	outputPlaceValue := ""
	if outputPlace != "" {
		outputPlaceValue = "|" + outputPlace
	}
	
	w.add("LP", useCurrentEventStr+"|"+path+outputPlaceValue)
}

func (w *WebForms) CallDeleteBack(path, outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	outputPlaceValue := ""
	if outputPlace != "" {
		outputPlaceValue = "|" + outputPlace
	}
	
	w.add("Ld", useCurrentEventStr+"|"+path+outputPlaceValue)
}

func (w *WebForms) CallHeadBack(path, outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	outputPlaceValue := ""
	if outputPlace != "" {
		outputPlaceValue = "|" + outputPlace
	}
	
	w.add("Lh", useCurrentEventStr+"|"+path+outputPlaceValue)
}

func (w *WebForms) CallOptionsBack(path, outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	outputPlaceValue := ""
	if outputPlace != "" {
		outputPlaceValue = "|" + outputPlace
	}
	
	w.add("Lo", useCurrentEventStr+"|"+path+outputPlaceValue)
}

func (w *WebForms) CallTraceBack(path, outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	outputPlaceValue := ""
	if outputPlace != "" {
		outputPlaceValue = "|" + outputPlace
	}
	
	w.add("LT", useCurrentEventStr+"|"+path+outputPlaceValue)
}

func (w *WebForms) CallConnectBack(path, outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	outputPlaceValue := ""
	if outputPlace != "" {
		outputPlaceValue = "|" + outputPlace
	}
	
	w.add("Lc", useCurrentEventStr+"|"+path+outputPlaceValue)
}

func (w *WebForms) CallSendBack(path, method string, isMultiPart bool, contentType, data, outputPlace string, useCurrentEvent bool) {
	useCurrentEventStr := "0"
	if useCurrentEvent {
		useCurrentEventStr = "1"
	}
	
	isMultiPartStr := "0"
	if isMultiPart {
		isMultiPartStr = "1"
	}
	
	processedData := strings.ReplaceAll(data, "\n", "$[ln];")
	processedData = strings.ReplaceAll(processedData, "|", "$[vb];")
	
	outputPlaceValue := ""
	if outputPlace != "" {
		outputPlaceValue = "|" + outputPlace
	}
	
	w.add("LS", useCurrentEventStr+"|"+path+"|"+method+"|"+isMultiPartStr+"|"+contentType+"|"+processedData+outputPlaceValue)
}

// Update methods
func (w *WebForms) Increase(inputPlace string, value float64) {
	w.add("gt"+inputPlace, "i|"+strconv.FormatFloat(value, 'f', -1, 64))
}

func (w *WebForms) Decrease(inputPlace string, value float64) {
	w.add("gt"+inputPlace, "i|"+strconv.FormatFloat(-value, 'f', -1, 64))
}

func (w *WebForms) Replace(inputPlace, value, newValue string, alsoStartTag, deep bool) {
	if value != "" && value[0] == '@' {
		value = value[1:]
		value = "$[at];" + value
	}
	
	if newValue != "" && newValue[0] == '@' {
		newValue = newValue[1:]
		newValue = "$[at];" + newValue
	}
	
	alsoStartTagStr := "0"
	if alsoStartTag {
		alsoStartTagStr = "1"
	}
	
	deepStr := "0"
	if deep {
		deepStr = "1"
	}
	
	w.add("gt"+inputPlace, "r|"+value+"|"+newValue+"|"+alsoStartTagStr+"|"+deepStr)
}

func (w *WebForms) ReplaceStartTag(inputPlace, value, newValue string) {
	if value != "" && value[0] == '@' {
		value = value[1:]
		value = "$[at];" + value
	}
	
	if newValue != "" && newValue[0] == '@' {
		newValue = newValue[1:]
		newValue = "$[at];" + newValue
	}
	
	w.add("gt"+inputPlace, "s|"+value+"|"+newValue)
}

// Pre Runner methods
func (w *WebForms) AssignDelay(miliSecond, index int) {
	currentLine := w.getLineByIndex(index)
	if currentLine == "" {
		return
	}
	
	parts := strings.SplitN(currentLine, "=", 2)
	newName := ":" + strconv.Itoa(miliSecond) + ")" + parts[0]
	
	var newValue string
	if len(parts) > 1 {
		newValue = parts[1]
	}
	
	w.updateLineByIndex(index, newName, newValue)
}

func (w *WebForms) AssignDelayChange(miliSecond, index int) {
	currentLine := w.getLineByIndex(index)
	if currentLine == "" {
		return
	}
	
	parts := strings.SplitN(currentLine, "=", 2)
	currentName := parts[0]
	
	if strings.HasPrefix(currentName, ":") && strings.Contains(currentName, ")") {
		closingBracket := strings.Index(currentName, ")")
		currentName = currentName[closingBracket+1:]
	}
	
	newName := ":" + strconv.Itoa(miliSecond) + ")" + currentName
	
	var newValue string
	if len(parts) > 1 {
		newValue = parts[1]
	}
	
	w.updateLineByIndex(index, newName, newValue)
}

func (w *WebForms) AssignInterval(miliSecond int, id string, index int) {
	currentLine := w.getLineByIndex(index)
	if currentLine == "" {
		return
	}
	
	parts := strings.SplitN(currentLine, "=", 2)
	
	idValue := ""
	if id != "" {
		idValue = "|" + id
	}
	
	newName := "(" + strconv.Itoa(miliSecond) + idValue + ")" + parts[0]
	
	var newValue string
	if len(parts) > 1 {
		newValue = parts[1]
	}
	
	w.updateLineByIndex(index, newName, newValue)
}

func (w *WebForms) AssignIntervalChange(miliSecond float64, id string, index int) {
	currentLine := w.getLineByIndex(index)
	if currentLine == "" {
		return
	}
	
	parts := strings.SplitN(currentLine, "=", 2)
	currentName := parts[0]
	
	if strings.HasPrefix(currentName, "(") && strings.Contains(currentName, ")") {
		closingBracket := strings.Index(currentName, ")")
		currentName = currentName[closingBracket+1:]
	}
	
	idValue := ""
	if id != "" {
		idValue = "|" + id
	}
	
	newName := "(" + strconv.FormatFloat(miliSecond, 'f', -1, 64) + idValue + ")" + currentName
	
	var newValue string
	if len(parts) > 1 {
		newValue = parts[1]
	}
	
	w.updateLineByIndex(index, newName, newValue)
}

func (w *WebForms) DeleteInterval(id string) {
	w.add("Di", id)
}

func (w *WebForms) AssignRepeat(count, index int) {
	currentLine := w.getLineByIndex(index)
	if currentLine == "" {
		return
	}
	
	parts := strings.SplitN(currentLine, "=", 2)
	newName := "," + strconv.Itoa(count) + ")" + parts[0]
	
	var newValue string
	if len(parts) > 1 {
		newValue = parts[1]
	}
	
	w.updateLineByIndex(index, newName, newValue)
}

func (w *WebForms) AssignRepeatChange(count, index int) {
	currentLine := w.getLineByIndex(index)
	if currentLine == "" {
		return
	}
	
	parts := strings.SplitN(currentLine, "=", 2)
	currentName := parts[0]
	
	if strings.HasPrefix(currentName, ",") && strings.Contains(currentName, ")") {
		closingBracket := strings.Index(currentName, ")")
		currentName = currentName[closingBracket+1:]
	}
	
	newName := "," + strconv.Itoa(count) + ")" + currentName
	
	var newValue string
	if len(parts) > 1 {
		newValue = parts[1]
	}
	
	w.updateLineByIndex(index, newName, newValue)
}

// Index methods
func (w *WebForms) StartIndex(name string) {
	w.add("#", name)
}

func (w *WebForms) StartIndexEmpty() {
	w.StartIndex("")
}

func (w *WebForms) GoToLine(line, repeat int) {
	w.add("&", strconv.Itoa(line)+"|"+strconv.Itoa(repeat))
}

func (w *WebForms) GoToIndex(index string, repeat int) {
	w.add("&", "#"+index+"|"+strconv.Itoa(repeat))
}

// Start methods
func (w *WebForms) StartTransientDOM(inputPlace string) {
	w.add("td", inputPlace)
}

func (w *WebForms) EndTransientDOM() {
	w.add("td", ";")
}

// Message methods
func (w *WebForms) Alert(text, alertType, title, okText string) {
	typeValue := ""
	if alertType != "none" {
		typeValue = alertType
	}
	
	titleValue := ""
	if title != "Alert" {
		titleValue = title
	}
	
	okTextValue := ""
	if okText != "OK" {
		okTextValue = okText
	}
	
	w.add("Al", text+"|"+typeValue+"|"+titleValue+"|"+okTextValue)
}

func (w *WebForms) Message(text, msgType string, duration int) {
	typeValue := ""
	if msgType != "none" {
		typeValue = msgType
	}
	
	durationValue := ""
	if duration != 0 {
		durationValue = strconv.Itoa(duration)
	}
	
	w.add("me", text+"|"+typeValue+"|"+durationValue)
}

func (w *WebForms) ConsoleMessage(text, consoleType string) {
	consoleTypeValue := ""
	if consoleType != "log" {
		consoleTypeValue = consoleType
	}
	
	processedText := strings.ReplaceAll(text, "\n", "$[ln];")
	
	if consoleTypeValue != "" {
		w.add("mc", processedText+"|"+consoleTypeValue)
	} else {
		w.add("mc", processedText)
	}
}

func (w *WebForms) ConsoleMessageAssert(text, condition string) {
	processedText := strings.ReplaceAll(text, "\n", "$[ln];")
	w.add("ma", processedText+"|"+condition)
}

// Enable methods
func (w *WebForms) EnableWebSocket(enable bool) {
	if enable {
		w.add("ew", "1")
	} else {
		w.add("ew", "0")
	}
}

func (w *WebForms) EnableWebSocketOnce() {
	w.add("ew", "$")
}

func (w *WebForms) AddWebSocket(path string) {
	w.addNameOnly("aw" + path)
}

// Use methods
func (w *WebForms) UseWebSocket(inputPlace string) {
	w.addNameOnly("uw" + inputPlace)
}

func (w *WebForms) UseOnlyChangeUpdate(inputPlace string) {
	w.addNameOnly("uo" + inputPlace)
}

// Condition methods
func (w *WebForms) ConfirmIsTrueAccept(text, confirmType, title, okText, cancelText string, interval float64) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.FormatFloat(interval, 'f', -1, 64) + ")"
	}
	
	textValue := ""
	if text != "Are you sure you want to proceed?" {
		textValue = text
	}
	
	typeValue := ""
	if confirmType != "none" {
		typeValue = confirmType
	}
	
	titleValue := ""
	if title != "Confirm" {
		titleValue = title
	}
	
	okTextValue := ""
	if okText != "OK" {
		okTextValue = okText
	}
	
	cancelTextValue := ""
	if cancelText != "Cancel" {
		cancelTextValue = cancelText
	}
	
	w.add(prefix+"ct", textValue+"|"+typeValue+"|"+titleValue+"|"+okTextValue+"|"+cancelTextValue)
}

func (w *WebForms) ConfirmIsFalseAccept(text, confirmType, title, okText, cancelText string, interval float64) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.FormatFloat(interval, 'f', -1, 64) + ")"
	}
	
	textValue := ""
	if text != "Are you sure you want to proceed?" {
		textValue = text
	}
	
	typeValue := ""
	if confirmType != "none" {
		typeValue = confirmType
	}
	
	titleValue := ""
	if title != "Confirm" {
		titleValue = title
	}
	
	okTextValue := ""
	if okText != "OK" {
		okTextValue = okText
	}
	
	cancelTextValue := ""
	if cancelText != "Cancel" {
		cancelTextValue = cancelText
	}
	
	w.add(prefix+"cf", textValue+"|"+typeValue+"|"+titleValue+"|"+okTextValue+"|"+cancelTextValue)
}

func (w *WebForms) IsGreaterThan(firstValue, secondValue string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"gt", firstValue+"|"+secondValue)
}

func (w *WebForms) IsLessThan(firstValue, secondValue string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"lt", firstValue+"|"+secondValue)
}

func (w *WebForms) IsEqualTo(firstValue, secondValue string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"et", firstValue+"|"+secondValue)
}

func (w *WebForms) IsNotEqualTo(firstValue, secondValue string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"Nt", firstValue+"|"+secondValue)
}

func (w *WebForms) Exist(value string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"ex", value)
}

func (w *WebForms) NotExist(value string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"nx", value)
}

func (w *WebForms) IsTrue(value string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"tr", value)
}

func (w *WebForms) IsFalse(value string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"fa", value)
}

func (w *WebForms) IsMatchMedia(value string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"mm", value)
}

func (w *WebForms) IsNotMatchMedia(value string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"nm", value)
}

func (w *WebForms) Include(text, value string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"In", value+"|"+text)
}

func (w *WebForms) NotInclude(text, value string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"Nn", value+"|"+text)
}

func (w *WebForms) ElementExists(inputPlace string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"eE", inputPlace)
}

func (w *WebForms) ElementNotExists(inputPlace string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"nE", inputPlace)
}

func (w *WebForms) IsRegexMatch(value, pattern string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"re", value+"|"+pattern)
}

func (w *WebForms) IsRegexNotMatch(value, pattern string, interval int) {
	prefix := "{"
	if interval >= 0 {
		prefix = "{(" + strconv.Itoa(interval) + ")"
	}
	w.add(prefix+"rn", value+"|"+pattern)
}

func (w *WebForms) Break() {
	w.addNameOnly(";")
}

func (w *WebForms) StartBracket() {
	w.addNameOnly("{")
}

func (w *WebForms) EndBracket() {
	w.addNameOnly("}")
}

// Async methods
func (w *WebForms) Async() {
	w.addNameOnly("{(a)")
}

func (w *WebForms) Delay(miliSecond int) {
	w.add("De", strconv.Itoa(miliSecond))
}

// Format Storage methods
func (w *WebForms) CreateFormatStorage(key, data string) {
	w.add(".C", key+"|"+data)
}

func (w *WebForms) DeleteFormatStorage(key string) {
	w.add(".D", key)
}

func (w *WebForms) AddJSON(key, path, value string) {
	w.add(".a", key+"|j|"+value+"|"+path)
}

func (w *WebForms) AddXML(key, path, name, value string) {
	if name != "" && name[0] == '@' {
		name = name[1:]
		name = "$[at];" + name
	}
	
	name = strings.ReplaceAll(name, "@", "$[at];")
	
	w.add(".a", key+"|x|"+name+"|"+value+"|"+path)
}

func (w *WebForms) AddINI(key, path, value string, isINILike bool) {
	isINILikeStr := "0"
	if isINILike {
		isINILikeStr = "1"
	}
	w.add(".a", key+"|i|"+isINILikeStr+"|"+value+"|"+path)
}

func (w *WebForms) AddTextLine(key string, line int, text string) {
	w.add(".a", key+"|t|"+text+"|"+strconv.Itoa(line))
}

func (w *WebForms) AddVariable(key, value string) {
	w.add(".a", key+"|v|"+value)
}

func (w *WebForms) UpdateJSON(key, path, value string) {
	w.add(".u", key+"|j|"+value+"|"+path)
}

func (w *WebForms) UpdateXML(key, path, value string) {
	w.add(".u", key+"|x|"+value+"|"+path)
}

func (w *WebForms) UpdateINI(key, path, value string, isINILike bool) {
	isINILikeStr := "0"
	if isINILike {
		isINILikeStr = "1"
	}
	w.add(".u", key+"|i|"+isINILikeStr+"|"+value+"|"+path)
}

func (w *WebForms) UpdateTextLine(key string, line int, text string) {
	w.add(".u", key+"|t|"+text+"|"+strconv.Itoa(line))
}

func (w *WebForms) UpdateVariable(key, value string) {
	w.add(".u", key+"|v|"+value)
}

func (w *WebForms) IncreaseVariable(key string, value int) {
	w.add(".i", key+"|v|"+strconv.Itoa(value))
}

func (w *WebForms) DecreaseVariable(key string, value int) {
	w.IncreaseVariable(key, -value)
}

func (w *WebForms) DeleteJSON(key, path string) {
	w.add(".d", key+"|j|"+path)
}

func (w *WebForms) DeleteXML(key, path string) {
	w.add(".d", key+"|x|"+path)
}

func (w *WebForms) DeleteINI(key, path string, isINILike bool) {
	isINILikeStr := "0"
	if isINILike {
		isINILikeStr = "1"
	}
	w.add(".d", key+"|i|"+isINILikeStr+"|"+path)
}

func (w *WebForms) DeleteTextLine(key string, line int) {
	w.add(".d", key+"|t|"+strconv.Itoa(line))
}

func (w *WebForms) DeleteVariable(key string) {
	w.add(".d", key+"|v")
}

// Inject method
func (w *WebForms) Inject(value string) string {
	return "$[" + value + "];"
}

// Hash And Checksum methods
func (w *WebForms) SetHash() {
	w.addNameOnly("SH")
}

func (w *WebForms) SetChecksum() {
	w.addNameOnly("CS")
}

func (w *WebForms) ChecksumCalculation(text string) string {
	sum := 0
	mod := 65536
	shift := 5
	
	for _, c := range text {
		sum = ((sum << shift) | (sum >> (16 - shift))) ^ int(c)
		sum %= mod
	}
	
	return strconv.Itoa(sum)
}

func (w *WebForms) GetChecksum() string {
	return w.ChecksumCalculation(w.GetWebFormsData())
}

// Get methods
func (w *WebForms) GetFormsActionData() string {
	return w.WebFormsData.String()
}

func (w *WebForms) Response() string {
	if w.WebFormsData.Len() == 0 {
		return "[web-forms]\n"
	}
	return "[web-forms]\n" + w.WebFormsData.String()
}

func (w *WebForms) ResponseWithHeaders(writer http.ResponseWriter) string {
	w.SetHeaders(writer)
	return w.Response()
}

func (w *WebForms) GetFormsActionDataLineBreak() string {
	if w.WebFormsData.Len() == 0 {
		return ""
	}
	
	data := w.WebFormsData.String()
	processedData := strings.ReplaceAll(data, "\"", "$[dq];")
	return strings.ReplaceAll(processedData, "\n", "$[sln];")
}

// Export methods
func (w *WebForms) ExportToWebFormsTag(src string) string {
	srcAttr := ""
	if src != "" {
		srcAttr = " src=\"" + src + "\""
	}
	return "<web-forms ac=\"" + w.GetFormsActionDataLineBreak() + "\"" + srcAttr + "></web-forms>"
}

func (w *WebForms) ExportToLineBreak(src string) string {
	srcAttr := ""
	if src != "" {
		srcAttr = "$[sln];" + src
	}
	return "[web-forms]$[sln];" + w.GetFormsActionDataLineBreak() + srcAttr
}

func (w *WebForms) ExportToWebFormsTagWithDimensions(width, height, src string) string {
	srcAttr := ""
	if src != "" {
		srcAttr = " src=\"" + src + "\""
	}
	return "<web-forms ac=\"" + w.GetFormsActionDataLineBreak() + "\" width=\"" + width + "\" height=\"" + height + "\"" + srcAttr + "></web-forms>"
}

func (w *WebForms) ExportToWebFormsTagWithIntDimensions(width, height int, src string) {
	w.ExportToWebFormsTagWithDimensions(strconv.Itoa(width)+"px", strconv.Itoa(height)+"px", src)
}

func (w *WebForms) DoneToWebFormsTag(id string) string {
	idAttr := ""
	if id != "" {
		idAttr = " id=\"" + id + "\""
	}
	return "<web-forms ac=\"" + w.GetFormsActionDataLineBreak() + "\"" + idAttr + " done=\"true\"></web-forms>"
}

func (w *WebForms) ExportToHtmlComment(addLine bool) string {
	prefix := ""
	if addLine {
		prefix = "\n"
	}
	return prefix + "<!--" + w.Response() + "-->"
}

func (w *WebForms) GetWebFormsData() string {
	return w.WebFormsData.String()
}

func (w *WebForms) AppendForm(form *WebForms) {
	if form == nil {
		return
	}
	
	otherData := form.GetWebFormsData()
	if otherData != "" {
		if w.WebFormsData.Len() > 0 {
			w.WebFormsData.WriteByte('\n')
		}
		w.WebFormsData.WriteString(otherData)
	}
}

func (w *WebForms) SetHeaders(writer http.ResponseWriter) {
	writer.Header().Set("Content-Type", "text/plain")
}

func (w *WebForms) Clean() {
	w.WebFormsData.Reset()
}

// Security struct
type Security struct{}

func (s Security) SafeValue(value string) string {
	if len(value) < 1 {
		return value
	}
	
	if value[0] == '@' {
		value = value[1:]
		value = "$[at];" + value
	}
	
	value = strings.ReplaceAll(value, "\n", "$[ln];")
	value = strings.ReplaceAll(value, "|", "$[vb];")
	value = strings.ReplaceAll(value, ",@", "$[co];@")
	
	return value
}

// InputPlace struct
type InputPlace struct{}

func (ip InputPlace) Window() string {
	return "`"
}

func (ip InputPlace) Root() string {
	return "~"
}

func (ip InputPlace) Current() string {
	return "$"
}

func (ip InputPlace) Target() string {
	return "!"
}

func (ip InputPlace) Upper() string {
	return "-"
}

func (ip InputPlace) Head() string {
	return "^"
}

func (ip InputPlace) ScreenOrientation() string {
	return "%"
}

func (ip InputPlace) Id(id string) string {
	return id
}

func (ip InputPlace) Name(name string) string {
	return "(" + name + ")"
}

func (ip InputPlace) NameWithIndex(name string, index int) string {
	return fmt.Sprintf("(%s)%d", name, index)
}

func (ip InputPlace) AllNames(name string) string {
	return "(" + name + ")*"
}

func (ip InputPlace) Tag(tag string) string {
	return "<" + tag + ">"
}

func (ip InputPlace) TagWithIndex(tag string, index int) string {
	return fmt.Sprintf("<%s>%d", tag, index)
}

func (ip InputPlace) AllTags(tag string) string {
	return "<" + tag + ">*"
}

func (ip InputPlace) Class(class string) string {
	return "{" + class + "}"
}

func (ip InputPlace) ClassWithIndex(class string, index int) string {
	return fmt.Sprintf("{%s}%d", class, index)
}

func (ip InputPlace) AllClasses(class string) string {
	return "{" + class + "}*"
}

func (ip InputPlace) Query(query string) string {
	return "*" + strings.ReplaceAll(query, "=", "$[eq];")
}

func (ip InputPlace) QueryAll(query string) string {
	return "[" + strings.ReplaceAll(query, "=", "$[eq];")
}

// OutputPlace struct
type OutputPlace struct {
	InputPlace
}

// Fetch struct
type Fetch struct{}

func (f Fetch) Random(maxValue int) string {
	return fmt.Sprintf("@mr%d", maxValue)
}

func (f Fetch) RandomRange(minValue, maxValue int) string {
	return fmt.Sprintf("@mr%d,%d", maxValue, minValue)
}

func (f Fetch) SpaceToChar(text, character string) string {
	char := "-"
	if character != "" {
		char = character
	}
	return "@sc" + char + "," + text
}

func (f Fetch) EncodeURI(text string) string {
	return "@ue" + text
}

func (f Fetch) DecodeURI(text string) string {
	return "@ud" + text
}

func (f Fetch) Method(methodName string, args []string) string {
	returnValue := "@cm" + methodName
	
	if args != nil && len(args) > 0 {
		returnValue += "," + strings.Join(args, ",")
	}
	
	return returnValue
}

func (f Fetch) ModuleMethod(methodName string, args []string) string {
	returnValue := "@cM" + methodName
	
	if args != nil && len(args) > 0 {
		returnValue += "," + strings.Join(args, ",")
	}
	
	return returnValue
}

func (f Fetch) WasmMethod(wasmLanguage, wasmUrl, methodName string, args []string, key string) string {
	returnValue := "@wA" + wasmLanguage + "," + wasmUrl + "," + methodName
	
	if args != nil && len(args) > 0 {
		returnValue += "," + strings.Join(args, ",")
	}
	
	return returnValue
}

func (f Fetch) Script(scriptText string) string {
	return "@_" + strings.ReplaceAll(scriptText, "\n", "$[ln];")
}

func (f Fetch) LoadUrl(url string, fetchScript bool) string {
	fetchScriptStr := ""
	if fetchScript {
		fetchScriptStr = ",1"
	}
	return "@lu" + url + fetchScriptStr
}

func (f Fetch) LoadHtml(url, fetchInputPlace string, fetchScript bool) string {
	fetchScriptStr := "0"
	if fetchScript {
		fetchScriptStr = "1"
	}
	
	fetchInputPlaceValue := ""
	if fetchInputPlace != "" {
		fetchInputPlaceValue = "," + fetchInputPlace
	}
	
	return "@lh" + url + "," + fetchScriptStr + fetchInputPlaceValue
}

func (f Fetch) LoadLine(url string, line int) string {
	return "@ll" + url + "," + strconv.Itoa(line)
}

func (f Fetch) LoadINI(url, name string, isINILike bool) string {
	isINILikeStr := "0"
	if isINILike {
		isINILikeStr = ",1"
	}
	return "@li" + url + "," + name + isINILikeStr
}

func (f Fetch) LoadJSON(url, name string) string {
	return "@lj" + url + "," + name
}

func (f Fetch) LoadXML(url, name string) string {
	return "@lx" + url + "," + name
}

func (f Fetch) HasMethod(methodName string) string {
	return "@hm" + methodName
}

func (f Fetch) HasModuleMethod(methodName string) string {
	return "@hM" + methodName
}

func (f Fetch) GetModifierState(modifier string) string {
	return "@ms" + modifier
}

func (f Fetch) Math(methodName string, args []string) string {
	returnValue := "@M#" + methodName
	
	if args != nil && len(args) > 0 {
		returnValue += "," + strings.Join(args, ",")
	}
	
	return returnValue
}

// Fetch constants
const (
	DateYear         = "@dy"
	DateMonth        = "@dm"
	DateDay          = "@dd"
	DateHours        = "@dh"
	DateMinutes      = "@di"
	DateSeconds      = "@ds"
	DateMilliseconds = "@dl"
	Space            = "@sp"
	AtSign           = "@sa"
	TabIsActive      = "@da"
	Href             = "@wf"
	PathName         = "@wP"
	Query            = "@wq"
	Hash             = "@wh"
	Host             = "@wH"
	HostName         = "@wn"
	Port             = "@wT"
	Origin           = "@wo"
	GetSelection     = "@ws"
	ScrollX          = "@wx"
	ScrollY          = "@wy"
	ClipboardText    = "@nC"
	GeoLatitude      = "@nW"
	GeoLongitude     = "@nO"
	Language         = "@nL"
	IsOnLine         = "@no"
	UserAgent        = "@na"
	ScreenWidth      = "@sw"
	ScreenHeight     = "@sh"
	ScreenOrientationType  = "@so"
	ScreenOrientationAngle = "@sr"
	TimeOrigin       = "@pt"
	PerformanceNow   = "@pn"
	Event            = "@EV"
	EventSerialize   = "@Es"
	EventKey         = "@ek"
	EventWhich       = "@ew"
	EventClientX     = "@ex"
	EventClientY     = "@ey"
	EventPageX       = "@eX"
	EventPageY       = "@eY"
	EventOffsetX     = "@Ex"
	EventOffsetY     = "@Ey"
	EventDeltaY      = "@ed"
)

// Fetch tag methods
func (f Fetch) GetId(inputPlace string) string {
	return "@$i" + inputPlace
}

func (f Fetch) GetName(inputPlace string) string {
	return "@$n" + inputPlace
}

func (f Fetch) GetValue(inputPlace string) string {
	return "@$v" + inputPlace
}

func (f Fetch) GetValueLength(inputPlace string) string {
	return "@$e" + inputPlace
}

func (f Fetch) GetClass(inputPlace string) string {
	return "@$c" + inputPlace
}

func (f Fetch) GetStyle(inputPlace string) string {
	return "@$s" + inputPlace
}

func (f Fetch) GetTitle(inputPlace string) string {
	return "@$l" + inputPlace
}

func (f Fetch) GetLabel(inputPlace string) string {
	return "@$A" + inputPlace
}

func (f Fetch) GetText(inputPlace string) string {
	return "@$t" + inputPlace
}

func (f Fetch) GetOuterText(inputPlace string) string {
	return "@$o" + inputPlace
}

func (f Fetch) GetTextLength(inputPlace string) string {
	return "@$g" + inputPlace
}

func (f Fetch) GetAttribute(inputPlace, attribute string) string {
	return "@$a" + inputPlace + "," + attribute
}

func (f Fetch) GetWidth(inputPlace string) string {
	return "@$w" + inputPlace
}

func (f Fetch) GetHeight(inputPlace string) string {
	return "@$h" + inputPlace
}

func (f Fetch) GetIsReadOnly(inputPlace string) string {
	return "@$r" + inputPlace
}

func (f Fetch) GetSelectedIndex(inputPlace string) string {
	return "@$x" + inputPlace
}

func (f Fetch) GetIndex(inputPlace string) string {
	return "@$I" + inputPlace
}

func (f Fetch) GetTextAlign(inputPlace string) string {
	return "@$T" + inputPlace
}

func (f Fetch) GetNodeLength(inputPlace string) string {
	return "@$L" + inputPlace
}

func (f Fetch) GetIsVisible(inputPlace string) string {
	return "@$V" + inputPlace
}

// Fetch save methods
func (f Fetch) HasHash(hash string) string {
	return "@HH" + hash
}

func (f Fetch) Cookie(key string) string {
	return "@co" + key
}

func (f Fetch) Session(key string) string {
	return "@cs" + key
}

func (f Fetch) SessionWithReplace(key, replaceValue string) string {
	return "@cs" + key + "," + replaceValue
}

func (f Fetch) SessionAndRemove(key string) string {
	return "@cl" + key
}

func (f Fetch) Saved(key string) string {
	return f.Session(key)
}

func (f Fetch) Cache(key string) string {
	return "@cd" + key
}

func (f Fetch) CacheWithReplace(key, replaceValue string) string {
	return "@cd" + key + "," + replaceValue
}

func (f Fetch) CacheAndRemove(key string) string {
	return "@ct" + key
}

func (f Fetch) SavedLine(key string, line int) string {
	return "@lL" + key + "[" + strconv.Itoa(line)
}

func (f Fetch) SavedLineConsume(key string) string {
	return "@lL" + key
}

func (f Fetch) SavedINI(key, iniKey string) string {
	return "@lI" + key + "[" + iniKey
}

func (f Fetch) CacheLine(key string, line int) string {
	return "@dL" + key + "[" + strconv.Itoa(line)
}

func (f Fetch) CacheLineConsume(key string) string {
	return "@dL" + key
}

func (f Fetch) CacheINI(key, iniKey string) string {
	return "@dI" + key + "[" + iniKey
}

// Fetch format storage methods
func (f Fetch) FormatStore(key string) string {
	return "@fr" + key
}

func (f Fetch) FormatStoreByXMLQuery(key, xpath string) string {
	return "@fx" + key + "," + xpath
}

func (f Fetch) FormatStoreByJSONQuery(key, query string) string {
	return "@fj" + key + "," + query
}

func (f Fetch) FormatStoreByINI(key, name string) string {
	return "@fi" + key + "," + name
}

func (f Fetch) FormatStoreByText(key string, line int) string {
	return "@ft" + key + "," + strconv.Itoa(line)
}

func (f Fetch) FormatStoreByVariable(key string) string {
	return "@fv" + key
}

// WasmLanguage struct
type WasmLanguage struct{}

const (
	C              = "c"
	CPP            = "c"
	Rust           = "rust"
	CSharp         = "csharp"
	GO             = "go"
	JAVA           = "java"
	AssemblyScript = "as"
)

// HtmlEvent struct
type HtmlEvent struct{}

const (
	OnAbort            = "onabort"
	OnAfterPrint       = "onafterprint"
	OnBeforePrint      = "onbeforeprint"
	OnBeforeUnload     = "onbeforeunload"
	OnBlur             = "onblur"
	OnCanPlay          = "oncanplay"
	OnCanPlayThrough   = "oncanplaythrough"
	OnChange           = "onchange"
	OnClick            = "onclick"
	OnCopy             = "oncopy"
	OnCut              = "oncut"
	OnDoubleClick      = "ondblclick"
	OnDrag             = "ondrag"
	OnDragEnd          = "ondragend"
	OnDragEnter        = "ondragenter"
	OnDragLeave        = "ondragleave"
	OnDragOver         = "ondragover"
	OnDragStart        = "ondragstart"
	OnDrop             = "ondrop"
	OnDurationChange   = "ondurationchange"
	OnEnded            = "onended"
	OnError            = "onerror"
	OnFocus            = "onfocus"
	OnFocusin          = "onfocusin"
	OnFocusOut         = "onfocusout"
	OnHashChange       = "onhashchange"
	OnInput            = "oninput"
	OnInvalid          = "oninvalid"
	OnKeyDown          = "onkeydown"
	OnKeyPress         = "onkeypress"
	OnKeyUp            = "onkeyup"
	OnLoad             = "onload"
	OnLoadedData       = "onloadeddata"
	OnLoadedMetaData   = "onloadedmetadata"
	OnLoadStart        = "onloadstart"
	OnMouseDown        = "onmousedown"
	OnMouseEnter       = "onmouseenter"
	OnMouseLeave       = "onmouseleave"
	OnMouseMove        = "onmousemove"
	OnMouseOver        = "onmouseover"
	OnMouseOut         = "onmouseout"
	OnMouseUp          = "onmouseup"
	OnOffline          = "onoffline"
	OnOnline           = "ononline"
	OnPageHide         = "onpagehide"
	OnPageShow         = "onpageshow"
	OnPaste            = "onpaste"
	OnPause            = "onpause"
	OnPlay             = "onplay"
	OnPlaying          = "onplaying"
	OnProgress         = "onprogress"
	OnRateChange       = "onratechange"
	OnResize           = "onresize"
	OnReset            = "onreset"
	OnScroll           = "onscroll"
	OnSearch           = "onsearch"
	OnSeeked           = "onseeked"
	OnSeeking          = "onseeking"
	OnSelect           = "onselect"
	OnStalled          = "onstalled"
	OnSubmit           = "onsubmit"
	OnSuspend          = "onsuspend"
	OnTimeUpdate       = "ontimeupdate"
	OnToggle           = "ontoggle"
	OnTouchCancel      = "ontouchcancel"
	OnTouchend         = "ontouchend"
	OnTouchMove        = "ontouchmove"
	OnTouchStart       = "ontouchstart"
	OnUnload           = "onunload"
	OnVolumeChange     = "onvolumechange"
	OnWaiting          = "onwaiting"
	OnWheel            = "onwheel"
)

// HtmlEventListener struct
type HtmlEventListener struct{}

const (
	Abort            = "abort"
	AfterPrint       = "afterprint"
	BeforePrint      = "beforeprint"
	BeforeUnload     = "beforeunload"
	Blur             = "blur"
	CanPlay          = "canplay"
	CanPlayThrough   = "canplaythrough"
	Change           = "change"
	Click            = "click"
	Copy             = "copy"
	Cut              = "cut"
	DoubleClick      = "dblclick"
	Drag             = "drag"
	DragEnd          = "dragend"
	DragEnter        = "dragenter"
	DragLeave        = "dragleave"
	DragOver         = "dragover"
	DragStart        = "dragstart"
	Drop             = "drop"
	DurationChange   = "durationchange"
	Ended            = "ended"
	Error            = "error"
	Focus            = "focus"
	Focusin          = "focusin"
	FocusOut         = "focusout"
	HashChange       = "hashchange"
	Input            = "input"
	Invalid          = "invalid"
	KeyDown          = "keydown"
	KeyPress         = "keypress"
	KeyUp            = "keyup"
	Load             = "load"
	LoadedData       = "loadeddata"
	LoadedMetaData   = "loadedmetadata"
	LoadStart        = "loadstart"
	MouseDown        = "mousedown"
	MouseEnter       = "mouseenter"
	MouseLeave       = "mouseleave"
	MouseMove        = "mousemove"
	MouseOver        = "mouseover"
	MouseOut         = "mouseout"
	MouseUp          = "mouseup"
	Offline          = "offline"
	Online           = "online"
	PageHide         = "pagehide"
	PageShow         = "pageshow"
	Paste            = "paste"
	Pause            = "pause"
	Play             = "play"
	Playing          = "playing"
	Progress         = "progress"
	RateChange       = "ratechange"
	Resize           = "resize"
	Reset            = "reset"
	Scroll           = "scroll"
	Search           = "search"
	Seeked           = "seeked"
	Seeking          = "seeking"
	Select           = "select"
	Stalled          = "stalled"
	Submit           = "submit"
	Suspend          = "suspend"
	TimeUpdate       = "timeupdate"
	Toggle           = "toggle"
	TouchCancel      = "touchcancel"
	Touchend         = "touchend"
	TouchMove        = "touchmove"
	TouchStart       = "touchstart"
	Unload           = "unload"
	VolumeChange     = "volumechange"
	Waiting          = "waiting"
	Wheel            = "wheel"
	
	AnimationEnd     = "animationend"
	AnimationIteration = "animationiteration"
	AnimationStart   = "animationstart"
	ContextMenu      = "contextmenu"
	FullScreenChange = "fullscreenchange"
	FullScreenError  = "fullscreenerror"
	PopState         = "popstate"
	TransitionEnd    = "transitionend"
	Storage          = "storage"
	
	// Custom
	ScrollBottom     = "scrollbottom"
	ElementReached   = "elementreached"
)

// Extension methods
func AppendPlace(text, value string) string {
	if len(text) < 1 {
		return value
	}
	return text + "|" + value
}

func AppendParent(text string) string {
	return "/" + text
}

func ExportActionControlsToWebFormsTag(actionControls string, addLine bool) string {
	prefix := ""
	if addLine {
		prefix = "\n"
	}
	return prefix + "<web-forms ac=\"" + actionControls + "\"></web-forms>"
}

func ExportActionControlsToHtmlComment(actionControls string, addLine bool) string {
	prefix := ""
	if addLine {
		prefix = "\n"
	}
	return prefix + "<!--[web-forms]\n" + actionControls + "-->"
}

func ExportActionControlsToResponse(actionControls string) string {
	return "[web-forms]\n" + actionControls
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

func LineBreak(text string) string {
	return strings.ReplaceAll(text, "\n", "$[sln]")
}

// NameValue and NameValueCollection structs (for backward compatibility)
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

func (nvc *NameValueCollection) GetList() []NameValue {
	return nvc.NameValueList
}
