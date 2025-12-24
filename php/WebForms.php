<?php

// WebForms.php 2.0 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.0

namespace WebFormsCore;

class WebForms
{
    private $webFormsData = '';
    private $security;

    public function __construct()
    {
        $this->security = new Security();
    }

    private function add($name, $value = '')
    {
        if (!empty($this->webFormsData)) {
            $this->webFormsData .= "\n";
        }

        $this->webFormsData .= $name;
        if ($value !== '') {
            $this->webFormsData .= '=' . $value;
        }
    }

    private function getLineByIndex($index)
    {
        if (empty($this->webFormsData)) {
            return '';
        }

        $lines = explode("\n", $this->webFormsData);

        if ($index < 0) {
            $index = count($lines) + $index;
        }

        if ($index < 0 || $index >= count($lines)) {
            return '';
        }

        return $lines[$index];
    }

    private function updateLineByIndex($index, $name, $value = '')
    {
        if (empty($this->webFormsData)) {
            return;
        }

        $lines = explode("\n", $this->webFormsData);

        if ($index < 0) {
            $index = count($lines) + $index;
        }

        if ($index < 0 || $index >= count($lines)) {
            return;
        }

        $lines[$index] = $name . ($value !== '' ? '=' . $value : '');

        $this->webFormsData = implode("\n", $lines);
    }

    // For Extension
    public function addLine($name, $value)
    {
        $this->add($name, $value);
    }

    // Add
    public function addId($inputPlace, $id)
    {
        $this->add("ai" . $inputPlace, $id);
    }

    public function addName($inputPlace, $name)
    {
        $this->add("an" . $inputPlace, $name);
    }

    public function addValue($inputPlace, $value)
    {
        $this->add("av" . $inputPlace, $value);
    }

    public function addClass($inputPlace, $class)
    {
        $this->add("ac" . $inputPlace, $class);
    }

    public function addStyle($inputPlace, $style)
    {
        $this->add("as" . $inputPlace, $style);
    }

    public function addStyleWithNameValue($inputPlace, $name, $value)
    {
        $this->add("as" . $inputPlace, $name . ':' . $value);
    }

    public function addOptionTag($inputPlace, $text, $value, $selected = false)
    {
        $this->add("ao" . $inputPlace, $value . '|' . $text . ($selected ? '|1' : ''));
    }

    public function addCheckBoxTag($inputPlace, $text, $value, $checked = false)
    {
        $this->add("ak" . $inputPlace, $value . '|' . $text . ($checked ? '|1' : ''));
    }

    public function addTitle($inputPlace, $title)
    {
        $this->add("al" . $inputPlace, $title);
    }

    public function addLabel($inputPlace, $label)
    {
        $this->add("aA" . $inputPlace, $label);
    }

    public function addText($inputPlace, $text)
    {
        $this->add("at" . $inputPlace, str_replace("\n", "$[ln];", $text));
    }

    public function addTextToUp($inputPlace, $text)
    {
        $this->add("pt" . $inputPlace, str_replace("\n", "$[ln];", $text));
    }

    public function addAttribute($inputPlace, $attribute, $value = "", $splitter = "\0")
    {
        $splitterStr = ($splitter != "\0") ? $splitter : "";
        $this->add("aa" . $inputPlace, $attribute . '|' . $splitterStr . (!empty($value) ? '|' . $value : ''));
    }

    public function addTag($inputPlace, $tagName, $id = "")
    {
        $this->add("nt" . $inputPlace, $tagName . (!empty($id) ? '|' . $id : ''));
    }

    public function addTagToUp($inputPlace, $tagName, $id = "")
    {
        $this->add("ut" . $inputPlace, $tagName . (!empty($id) ? '|' . $id : ''));
    }

    public function addTagBefore($inputPlace, $tagName, $id = "")
    {
        $this->add("bt" . $inputPlace, $tagName . (!empty($id) ? '|' . $id : ''));
    }

    public function addTagAfter($inputPlace, $tagName, $id = "")
    {
        $this->add("ft" . $inputPlace, $tagName . (!empty($id) ? '|' . $id : ''));
    }

    public function addHidden($inputPlace, $value, $id = "")
    {
        $this->add("ah" . $inputPlace, $value . (!empty($id) ? '|' . $id : ''));
    }

    // Set
    public function setId($inputPlace, $id)
    {
        $this->add("si" . $inputPlace, $id);
    }

    public function setName($inputPlace, $name)
    {
        $this->add("sn" . $inputPlace, $name);
    }

    public function setValue($inputPlace, $value)
    {
        $this->add("sv" . $inputPlace, $value);
    }

    public function setClass($inputPlace, $class)
    {
        $this->add("sc" . $inputPlace, $class);
    }

    public function setStyle($inputPlace, $style)
    {
        $this->add("ss" . $inputPlace, $style);
    }

    public function setStyleWithNameValue($inputPlace, $name, $value)
    {
        $this->add("ss" . $inputPlace, $name . ':' . $value);
    }

    public function setOptionTag($inputPlace, $text, $value, $selected = false)
    {
        $this->add("so" . $inputPlace, $value . '|' . $text . ($selected ? '|1' : ''));
    }

    public function setChecked($inputPlace, $checked = false)
    {
        $this->add("sk" . $inputPlace, $checked ? "1" : "0");
    }

    public function setCheckBoxTag($inputPlace, $text, $value, $checked = false)
    {
        $this->add("sk" . $inputPlace, $value . '|' . $text . ($checked ? '|1' : ''));
    }

    public function setTitle($inputPlace, $title)
    {
        $this->add("sl" . $inputPlace, $title);
    }

    public function setLabel($inputPlace, $label)
    {
        $this->add("sA" . $inputPlace, $label);
    }

    public function setText($inputPlace, $text)
    {
        $this->add("st" . $inputPlace, str_replace("\n", "$[ln];", $text));
    }

    public function setAttribute($inputPlace, $attribute, $value = "")
    {
        $this->add("sa" . $inputPlace, $attribute . '|' . (!empty($value) ? '|' . $value : ''));
    }

    public function setWidth($inputPlace, $width)
    {
        $this->add("sw" . $inputPlace, $width);
    }

    public function setHeight($inputPlace, $height)
    {
        $this->add("sh" . $inputPlace, $height);
    }

    public function setBackgroundColor($inputPlace, $color)
    {
        $this->add("bc" . $inputPlace, $color);
    }

    public function setTextColor($inputPlace, $color)
    {
        $this->add("tc" . $inputPlace, $color);
    }

    public function setFontName($inputPlace, $name)
    {
        $this->add("fn" . $inputPlace, $name);
    }

    public function setFontSize($inputPlace, $size)
    {
        $this->add("fs" . $inputPlace, $size);
    }

    public function setFontBold($inputPlace, $bold)
    {
        $this->add("fb" . $inputPlace, $bold ? "1" : "0");
    }

    public function setVisible($inputPlace, $visible)
    {
        $this->add("vi" . $inputPlace, $visible ? "1" : "0");
    }

    public function setTextAlign($inputPlace, $align)
    {
        $this->add("ta" . $inputPlace, $align);
    }

    public function setReadOnly($inputPlace, $readOnly)
    {
        $this->add("sr" . $inputPlace, $readOnly ? "1" : "0");
    }

    public function setDisabled($inputPlace, $disabled)
    {
        $this->add("sd" . $inputPlace, $disabled ? "1" : "0");
    }

    public function setFocus($inputPlace, $focus)
    {
        $this->add("sf" . $inputPlace, $focus ? "1" : "0");
    }

    public function setMinLength($inputPlace, $length)
    {
        $this->add("mn" . $inputPlace, (string)$length);
    }

    public function setMaxLength($inputPlace, $length)
    {
        $this->add("mx" . $inputPlace, (string)$length);
    }

    public function setSelectedValue($inputPlace, $value)
    {
        $this->add("ts" . $inputPlace, $value);
    }

    public function setSelectedIndex($inputPlace, $index)
    {
        $this->add("ti" . $inputPlace, (string)$index);
    }

    public function setCheckedValue($inputPlace, $value, $selected)
    {
        $this->add("ks" . $inputPlace, $value . "|" . ($selected ? "1" : "0"));
    }

    public function setCheckedIndex($inputPlace, $index, $selected)
    {
        $this->add("ki" . $inputPlace, $index . "|" . ($selected ? "1" : "0"));
    }

    // Insert
    public function insertId($inputPlace, $id)
    {
        $this->add("ii" . $inputPlace, $id);
    }

    public function insertName($inputPlace, $name)
    {
        $this->add("in" . $inputPlace, $name);
    }

    public function insertValue($inputPlace, $value)
    {
        $this->add("iv" . $inputPlace, $value);
    }

    public function insertClass($inputPlace, $class)
    {
        $this->add("ic" . $inputPlace, $class);
    }

    public function insertStyle($inputPlace, $style)
    {
        $this->add("is" . $inputPlace, $style);
    }

    public function insertStyleWithNameValue($inputPlace, $name, $value)
    {
        $this->add("is" . $inputPlace, $name . ':' . $value);
    }

    public function insertOptionTag($inputPlace, $text, $value, $selected = false)
    {
        $this->add("io" . $inputPlace, $value . '|' . $text . ($selected ? '|1' : ''));
    }

    public function insertCheckBoxTag($inputPlace, $text, $value, $checked = false)
    {
        $this->add("ik" . $inputPlace, $value . '|' . $text . ($checked ? '|1' : ''));
    }

    public function insertTitle($inputPlace, $title)
    {
        $this->add("il" . $inputPlace, $title);
    }

    public function insertLabel($inputPlace, $label)
    {
        $this->add("iA" . $inputPlace, $label);
    }

    public function insertText($inputPlace, $text)
    {
        $this->add("it" . $inputPlace, str_replace("\n", "$[ln];", $text));
    }

    public function insertAttribute($inputPlace, $attribute, $value = "", $splitter = "\0")
    {
        $splitterStr = ($splitter != "\0") ? $splitter : "";
        $this->add("ia" . $inputPlace, $attribute . '|' . $splitterStr . (!empty($value) ? '|' . $value : ''));
    }

    // Delete
    public function deleteId($inputPlace)
    {
        $this->add("di" . $inputPlace);
    }

    public function deleteName($inputPlace)
    {
        $this->add("dn" . $inputPlace);
    }

    public function deleteValue($inputPlace)
    {
        $this->add("dv" . $inputPlace);
    }

    public function deleteClass($inputPlace, $className)
    {
        $this->add("dc" . $inputPlace, $className);
    }

    public function deleteStyle($inputPlace, $styleName)
    {
        $this->add("ds" . $inputPlace, $styleName);
    }

    public function deleteOptionTag($inputPlace, $value)
    {
        $this->add("do" . $inputPlace, $value);
    }

    public function deleteAllOptionTag($inputPlace)
    {
        $this->add("do" . $inputPlace, "*");
    }

    public function deleteCheckBoxTag($inputPlace, $value)
    {
        $this->add("dk" . $inputPlace, $value);
    }

    public function deleteAllCheckBoxTag($inputPlace)
    {
        $this->add("dk" . $inputPlace, "*");
    }

    public function deleteTitle($inputPlace)
    {
        $this->add("dl" . $inputPlace);
    }

    public function deleteLabel($inputPlace)
    {
        $this->add("dA" . $inputPlace);
    }

    public function deleteText($inputPlace)
    {
        $this->add("dt" . $inputPlace);
    }

    public function deleteAttribute($inputPlace, $attribute)
    {
        $this->add("da" . $inputPlace, $attribute);
    }

    public function delete($inputPlace)
    {
        $this->add("de" . $inputPlace);
    }

    public function deleteParent($inputPlace)
    {
        $this->add("dp" . $inputPlace);
    }

    // Tag
    public function swapTag($inputPlace, $outputPlace)
    {
        $this->add("sp" . $inputPlace, $outputPlace);
    }

    public function setReflection($inputPlace, $tag)
    {
        $this->add("sR" . $inputPlace, $tag);
    }

    public function setReflectionByOutputPlace($inputPlace, $outputPlace)
    {
        $this->add("iR" . $inputPlace, $outputPlace);
    }

    // Browser
    public function changeUrl($url)
    {
        $this->add("cu", $url);
    }

    public function setHeadTitle($title)
    {
        $this->add("ht", $title);
    }

    public function clipboardWriteText($text)
    {
        $this->add("nw", $text);
    }

    public function scrollTo($x, $y)
    {
        $this->add("ws", $x . "|" . $y);
    }

    public function historyGo($steps)
    {
        $this->add("wg", (string)$steps);
    }

    public function reloadPage()
    {
        $this->add("lr");
    }

    public function redirect($path)
    {
        $this->add("lh", $path);
    }

    // Increase
    public function increaseMinLength($inputPlace, $value)
    {
        $this->add("+n" . $inputPlace, (string)$value);
    }

    public function increaseMaxLength($inputPlace, $value)
    {
        $this->add("+x" . $inputPlace, (string)$value);
    }

    public function increaseFontSize($inputPlace, $value)
    {
        $this->add("+f" . $inputPlace, (string)$value);
    }

    public function increaseWidth($inputPlace, $value)
    {
        $this->add("+w" . $inputPlace, (string)$value);
    }

    public function increaseHeight($inputPlace, $value)
    {
        $this->add("+h" . $inputPlace, (string)$value);
    }

    public function increaseValue($inputPlace, $value)
    {
        $this->add("+v" . $inputPlace, (string)$value);
    }

    // Decrease
    public function decreaseMinLength($inputPlace, $value)
    {
        $this->add("-n" . $inputPlace, (string)$value);
    }

    public function decreaseMaxLength($inputPlace, $value)
    {
        $this->add("-x" . $inputPlace, (string)$value);
    }

    public function decreaseFontSize($inputPlace, $value)
    {
        $this->add("-f" . $inputPlace, (string)$value);
    }

    public function decreaseWidth($inputPlace, $value)
    {
        $this->add("-w" . $inputPlace, (string)$value);
    }

    public function decreaseHeight($inputPlace, $value)
    {
        $this->add("-h" . $inputPlace, (string)$value);
    }

    public function decreaseValue($inputPlace, $value)
    {
        $this->add("-v" . $inputPlace, (string)$value);
    }

    // Event - Trigger
    public function triggerEvent($inputPlace, $htmlEventListener, $constructorName = null)
    {
        $this->add("TE" . $inputPlace, $htmlEventListener . (!empty($constructorName) ? "|" . $constructorName : ""));
    }

    // Event - Set
    public function setPostEvent($inputPlace, $htmlEvent)
    {
        $this->add("Ep" . $inputPlace, $htmlEvent);
    }

    public function setPostEventView($inputPlace, $htmlEvent)
    {
        $this->add("Ep" . $inputPlace, $htmlEvent . "|+");
    }

    public function setPostEventTo($inputPlace, $htmlEvent, $outputPlace)
    {
        $this->add("Ep" . $inputPlace, $htmlEvent . "|" . $outputPlace);
    }

    public function setPostEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("EP" . $inputPlace, $htmlEventListener);
    }

    public function setPostEventListenerView($inputPlace, $htmlEventListener)
    {
        $this->add("EP" . $inputPlace, $htmlEventListener . "|+");
    }

    public function setPostEventListenerTo($inputPlace, $htmlEventListener, $outputPlace)
    {
        $this->add("EP" . $inputPlace, $htmlEventListener . "|" . $outputPlace);
    }

    public function setGetEvent($inputPlace, $htmlEvent, $path = null)
    {
        $this->add("Eg" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#"));
    }

    public function setGetEventWithOutputPlace($inputPlace, $htmlEvent, $outputPlace, $path = null)
    {
        $this->add("Eg" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#") . "|" . $outputPlace);
    }

    public function setGetEventListener($inputPlace, $htmlEventListener, $path = null)
    {
        $this->add("EG" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#"));
    }

    public function setGetEventListenerWithOutputPlace($inputPlace, $htmlEventListener, $outputPlace, $path = null)
    {
        $this->add("EG" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#") . "|" . $outputPlace);
    }

    public function setPatchEvent($inputPlace, $htmlEvent, $path = null)
    {
        $this->add("Ea" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#"));
    }

    public function setPatchEventWithOutputPlace($inputPlace, $htmlEvent, $outputPlace, $path = null)
    {
        $this->add("Ea" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#") . "|" . $outputPlace);
    }

    public function setPatchEventListener($inputPlace, $htmlEventListener, $path = null)
    {
        $this->add("EA" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#"));
    }

    public function setPatchEventListenerWithOutputPlace($inputPlace, $htmlEventListener, $outputPlace, $path = null)
    {
        $this->add("EA" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#") . "|" . $outputPlace);
    }

    public function setDeleteEvent($inputPlace, $htmlEvent, $path = null)
    {
        $this->add("El" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#"));
    }

    public function setDeleteEventWithOutputPlace($inputPlace, $htmlEvent, $outputPlace, $path = null)
    {
        $this->add("El" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#") . "|" . $outputPlace);
    }

    public function setDeleteEventListener($inputPlace, $htmlEventListener, $path = null)
    {
        $this->add("EL" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#"));
    }

    public function setDeleteEventListenerWithOutputPlace($inputPlace, $htmlEventListener, $outputPlace, $path = null)
    {
        $this->add("EL" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#") . "|" . $outputPlace);
    }

    public function setOptionsEvent($inputPlace, $htmlEvent, $path = null)
    {
        $this->add("Eo" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#"));
    }

    public function setOptionsEventWithOutputPlace($inputPlace, $htmlEvent, $outputPlace, $path = null)
    {
        $this->add("Eo" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#") . "|" . $outputPlace);
    }

    public function setOptionsEventListener($inputPlace, $htmlEventListener, $path = null)
    {
        $this->add("EO" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#"));
    }

    public function setOptionsEventListenerWithOutputPlace($inputPlace, $htmlEventListener, $outputPlace, $path = null)
    {
        $this->add("EO" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#") . "|" . $outputPlace);
    }

    public function setTraceEvent($inputPlace, $htmlEvent, $path = null)
    {
        $this->add("Er" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#"));
    }

    public function setTraceEventWithOutputPlace($inputPlace, $htmlEvent, $outputPlace, $path = null)
    {
        $this->add("Er" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#") . "|" . $outputPlace);
    }

    public function setTraceEventListener($inputPlace, $htmlEventListener, $path = null)
    {
        $this->add("ER" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#"));
    }

    public function setTraceEventListenerWithOutputPlace($inputPlace, $htmlEventListener, $outputPlace, $path = null)
    {
        $this->add("ER" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#") . "|" . $outputPlace);
    }

    public function setConnectEvent($inputPlace, $htmlEvent, $path = null)
    {
        $this->add("Ec" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#"));
    }

    public function setConnectEventWithOutputPlace($inputPlace, $htmlEvent, $outputPlace, $path = null)
    {
        $this->add("Ec" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#") . "|" . $outputPlace);
    }

    public function setConnectEventListener($inputPlace, $htmlEventListener, $path = null)
    {
        $this->add("EC" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#"));
    }

    public function setConnectEventListenerWithOutputPlace($inputPlace, $htmlEventListener, $outputPlace, $path = null)
    {
        $this->add("EC" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#") . "|" . $outputPlace);
    }

    public function setHeadEvent($inputPlace, $htmlEvent, $path = null)
    {
        $this->add("Eh" . $inputPlace, $htmlEvent . "|" . (!empty($path) ? $path : "#"));
    }

    public function setHeadEventListener($inputPlace, $htmlEventListener, $path = null)
    {
        $this->add("EH" . $inputPlace, $htmlEventListener . "|" . (!empty($path) ? $path : "#"));
    }

    public function setTagEvent($inputPlace, $htmlEvent, $outputPlace)
    {
        $this->add("Et" . $inputPlace, $htmlEvent . "|" . $outputPlace);
    }

    public function setTagEventListener($inputPlace, $htmlEventListener, $outputPlace)
    {
        $this->add("ET" . $inputPlace, $htmlEventListener . "|" . $outputPlace);
    }

    public function setCommentEvent($inputPlace, $htmlEvent, $index = null, $outputPlace = null)
    {
        $this->add("Eb" . $inputPlace, $htmlEvent . "|" . $index . "|" . $outputPlace);
    }

    public function setCommentEventListener($inputPlace, $htmlEventListener, $index = null, $outputPlace = null)
    {
        $this->add("EB" . $inputPlace, $htmlEventListener . "|" . $index . "|" . $outputPlace);
    }

    public function setWasmEvent($inputPlace, $htmlEvent, $wasmLanguage, $wasmUrl, $methodName, $args = null, $outputPlace = null)
    {
        $argsJoin = "";
        if ($args !== null && count($args) > 0) {
            $argsJoin = implode(",", $args);
        }
        $this->add("Ey" . $inputPlace, $htmlEvent . "|" . $wasmLanguage . "|" . $wasmUrl . "|" . $methodName . "|" . $argsJoin . "|" . $outputPlace);
    }

    public function setWasmEventListener($inputPlace, $htmlEventListener, $wasmLanguage, $wasmUrl, $methodName, $args = null, $outputPlace = null)
    {
        $argsJoin = "";
        if ($args !== null && count($args) > 0) {
            $argsJoin = implode(",", $args);
        }
        $this->add("EY" . $inputPlace, $htmlEventListener . "|" . $wasmLanguage . "|" . $wasmUrl . "|" . $methodName . "|" . $argsJoin . "|" . $outputPlace);
    }

    public function setWebSocketEvent($inputPlace, $htmlEvent, $path)
    {
        $this->add("Ew" . $inputPlace, $htmlEvent . "|" . $path);
    }

    public function setWebSocketEventListener($inputPlace, $htmlEventListener, $path)
    {
        $this->add("EW" . $inputPlace, $htmlEventListener . "|" . $path);
    }

    public function setSSEEvent($inputPlace, $htmlEvent, $path, $shouldReconnect = true, $reconnectTryTimeout = 3000)
    {
        $this->add("Ee" . $inputPlace, $htmlEvent . "|" . $path . "|" . ($shouldReconnect ? "1" : "0") . "|" . $reconnectTryTimeout);
    }

    public function setSSEEventWithOutputPlace($inputPlace, $htmlEvent, $path, $outputPlace, $shouldReconnect = true, $reconnectTryTimeout = 3000)
    {
        $this->add("Ee" . $inputPlace, $htmlEvent . "|" . $path . "|" . ($shouldReconnect ? "1" : "0") . "|" . $reconnectTryTimeout . "|" . $outputPlace);
    }

    public function setSSEEventListener($inputPlace, $htmlEventListener, $path, $shouldReconnect = true, $reconnectTryTimeout = 3000)
    {
        $this->add("EE" . $inputPlace, $htmlEventListener . "|" . $path . "|" . ($shouldReconnect ? "1" : "0") . "|" . $reconnectTryTimeout);
    }

    public function setSSEEventListenerWithOutputPlace($inputPlace, $htmlEventListener, $path, $outputPlace, $shouldReconnect = true, $reconnectTryTimeout = 3000)
    {
        $this->add("EE" . $inputPlace, $htmlEventListener . "|" . $path . "|" . ($shouldReconnect ? "1" : "0") . "|" . $reconnectTryTimeout . "|" . $outputPlace);
    }

    public function setFrontEvent($inputPlace, $htmlEvent, $modulePath, $args = null, $outputPlace = null)
    {
        $argsJoin = "";
        if ($args !== null && count($args) > 0) {
            $argsJoin = "|" . implode("|", $args);
        }
        $this->add("Ej" . $inputPlace, $htmlEvent . "|" . $modulePath . "|" . $outputPlace . $argsJoin);
    }

    public function setFrontEventListener($inputPlace, $htmlEventListener, $modulePath, $args = null, $outputPlace = null)
    {
        $argsJoin = "";
        if ($args !== null && count($args) > 0) {
            $argsJoin = "|" . implode("|", $args);
        }
        $this->add("EJ" . $inputPlace, $htmlEventListener . "|" . $modulePath . "|" . $outputPlace . $argsJoin);
    }

    public function setSendEvent($inputPlace, $htmlEvent, $data, $path = null, $method = "POST", $isMultiPart = false, $contentType = "text/plain", $outputPlace = null)
    {
        $safeData = str_replace(["\n", "\"", "'"], ["$[ln];", "$[dq];", "$[sq];"], $data);
        $this->add("En" . $inputPlace, $htmlEvent . "|" . $safeData . "|" . (!empty($path) ? $path : "#") . "|" . $method . "|" . ($isMultiPart ? "1" : "0") . "|" . $contentType . "|" . $outputPlace);
    }

    public function setSendEventListener($inputPlace, $htmlEventListener, $data, $path = null, $method = "POST", $isMultiPart = false, $contentType = "text/plain", $outputPlace = null)
    {
        $this->add("EN" . $inputPlace, $htmlEventListener . "|" . str_replace("\n", "$[ln];", $data) . "|" . (!empty($path) ? $path : "#") . "|" . $method . "|" . ($isMultiPart ? "1" : "0") . "|" . $contentType . "|" . $outputPlace);
    }

    public function setMasterPagesEvent($inputPlace, $htmlEvent, $outputPlace = null)
    {
        $this->add("Eu" . $inputPlace, $htmlEvent . "|" . $outputPlace);
    }

    public function setMasterPagesEventListener($inputPlace, $htmlEventListener, $outputPlace = null)
    {
        $this->add("EU" . $inputPlace, $htmlEventListener . "|" . $outputPlace);
    }

    public function setPreventDefaultEvent($inputPlace, $htmlEvent)
    {
        $this->add("Ed" . $inputPlace, $htmlEvent);
    }

    public function setPreventDefaultEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("ED" . $inputPlace, $htmlEventListener);
    }

    public function setStopPropagationEvent($inputPlace, $htmlEvent)
    {
        $this->add("Es" . $inputPlace, $htmlEvent);
    }

    public function setStopPropagationEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("ES" . $inputPlace, $htmlEventListener);
    }

    public function setMethodEvent($inputPlace, $htmlEvent, $methodName, $args = null)
    {
        $argsJoin = "";
        if ($args !== null && count($args) > 0) {
            $argsJoin = "|" . implode("|", $args);
        }
        $this->add("Em" . $inputPlace, $htmlEvent . "|" . $methodName . $argsJoin);
    }

    public function setMethodEventListener($inputPlace, $htmlEventListener, $methodName, $args = null)
    {
        $argsJoin = "";
        if ($args !== null && count($args) > 0) {
            $argsJoin = "|" . implode("|", $args);
        }
        $this->add("EM" . $inputPlace, $htmlEventListener . "|" . $methodName . $argsJoin);
    }

    public function setModuleMethodEvent($inputPlace, $htmlEvent, $methodName, $args = null)
    {
        $argsJoin = "";
        if ($args !== null && count($args) > 0) {
            $argsJoin = "|" . implode("|", $args);
        }
        $this->add("Ex" . $inputPlace, $htmlEvent . "|" . $methodName . $argsJoin);
    }

    public function setModuleMethodEventListener($inputPlace, $htmlEventListener, $methodName, $args = null)
    {
        $argsJoin = "";
        if ($args !== null && count($args) > 0) {
            $argsJoin = "|" . implode("|", $args);
        }
        $this->add("EX" . $inputPlace, $htmlEventListener . "|" . $methodName . $argsJoin);
    }

    public function assignConfirmEvent($inputPlace, $htmlEvent, $text = "Are you sure you want to proceed?", $type = "none", $title = "Confirm", $okText = "OK", $cancelText = "Cancel")
    {
        $textParam = ($text == "Are you sure you want to proceed?") ? "" : $text;
        $typeParam = ($type == "none") ? "" : $type;
        $titleParam = ($title == "Confirm") ? "" : $title;
        $okTextParam = ($okText == "OK") ? "" : $okText;
        $cancelTextParam = ($cancelText == "Cancel") ? "" : $cancelText;
        $this->add("Ef" . $inputPlace, $htmlEvent . "|" . $textParam . "|" . $typeParam . "|" . $titleParam . "|" . $okTextParam . "|" . $cancelTextParam);
    }

    // Event - Remove
    public function removePostEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rp" . $inputPlace, $htmlEvent);
    }

    public function removePostEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RP" . $inputPlace, $htmlEventListener);
    }

    public function removeGetEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rg" . $inputPlace, $htmlEvent);
    }

    public function removeGetEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RG" . $inputPlace, $htmlEventListener);
    }

    public function removePatchEvent($inputPlace, $htmlEvent)
    {
        $this->add("Ra" . $inputPlace, $htmlEvent);
    }

    public function removePatchEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RA" . $inputPlace, $htmlEventListener);
    }

    public function removeDeleteEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rl" . $inputPlace, $htmlEvent);
    }

    public function removeDeleteEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RL" . $inputPlace, $htmlEventListener);
    }

    public function removeHeadEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rh" . $inputPlace, $htmlEvent);
    }

    public function removeHeadEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RH" . $inputPlace, $htmlEventListener);
    }

    public function removeOptionsEvent($inputPlace, $htmlEvent)
    {
        $this->add("Ro" . $inputPlace, $htmlEvent);
    }

    public function removeOptionsEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RO" . $inputPlace, $htmlEventListener);
    }

    public function removeTraceEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rr" . $inputPlace, $htmlEvent);
    }

    public function removeTraceEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RR" . $inputPlace, $htmlEventListener);
    }

    public function removeConnectEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rc" . $inputPlace, $htmlEvent);
    }

    public function removeConnectEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RC" . $inputPlace, $htmlEventListener);
    }

    public function removeTagEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rt" . $inputPlace, $htmlEvent);
    }

    public function removeTagEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RT" . $inputPlace, $htmlEventListener);
    }

    public function removeCommentEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rb" . $inputPlace, $htmlEvent);
    }

    public function removeCommentEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RB" . $inputPlace, $htmlEventListener);
    }

    public function removeWasmEvent($inputPlace, $htmlEvent)
    {
        $this->add("Ry" . $inputPlace, $htmlEvent);
    }

    public function removeWasmEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RY" . $inputPlace, $htmlEventListener);
    }

    public function removeWebSocketEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rw" . $inputPlace, $htmlEvent);
    }

    public function removeWebSocketEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RW" . $inputPlace, $htmlEventListener);
    }

    public function removeSSEEvent($inputPlace, $htmlEvent)
    {
        $this->add("Re" . $inputPlace, $htmlEvent);
    }

    public function removeSSEEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RE" . $inputPlace, $htmlEventListener);
    }

    public function removeFrontEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rj" . $inputPlace, $htmlEvent);
    }

    public function removeFrontEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RJ" . $inputPlace, $htmlEventListener);
    }

    public function removeSendEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rn" . $inputPlace, $htmlEvent);
    }

    public function removeSendEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RN" . $inputPlace, $htmlEventListener);
    }

    public function removePreventDefaultEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rd" . $inputPlace, $htmlEvent);
    }

    public function removePreventDefaultEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RD" . $inputPlace, $htmlEventListener);
    }

    public function removeMasterPagesEvent($inputPlace, $htmlEvent)
    {
        $this->add("Ru" . $inputPlace, $htmlEvent);
    }

    public function removeMasterPagesEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RU" . $inputPlace, $htmlEventListener);
    }

    public function removeStopPropagationEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rs" . $inputPlace, $htmlEvent);
    }

    public function removeStopPropagationEventListener($inputPlace, $htmlEventListener)
    {
        $this->add("RS" . $inputPlace, $htmlEventListener);
    }

    public function removeMethodEvent($inputPlace, $htmlEvent, $methodName)
    {
        $this->add("Rm" . $inputPlace, $htmlEvent . "|" . $methodName);
    }

    public function removeMethodEventListener($inputPlace, $htmlEventListener, $methodName)
    {
        $this->add("RM" . $inputPlace, $htmlEventListener . "|" . $methodName);
    }

    public function removeModuleMethodEvent($inputPlace, $htmlEvent, $methodName)
    {
        $this->add("Rx" . $inputPlace, $htmlEvent . "|" . $methodName);
    }

    public function removeModuleMethodEventListener($inputPlace, $htmlEventListener, $methodName)
    {
        $this->add("RX" . $inputPlace, $htmlEventListener . "|" . $methodName);
    }

    public function removeConfirmEvent($inputPlace, $htmlEvent)
    {
        $this->add("Rf" . $inputPlace, $htmlEvent);
    }

    // Custom Event
    public function createCustomDOMEvent($inputPlace, $eventName, $watch, $key, $compare, $value, $range, $immediate = false, $delay = 0)
    {
        $this->add("eC" . $inputPlace, $eventName . "|" . $watch . "|" . $key . "|" . $compare . "|" . $value . "|" . $range . "|" . ($immediate ? "1" : "0") . "|" . $delay);
    }

    public function enableScrollBottomEvent($enable = true)
    {
        $this->add("eb", $enable ? "1" : "0");
    }

    public function enableReachedElementEvent($inputPlace, $once, $enable = true)
    {
        $this->add("er" . $inputPlace, ($once ? "1" : "0") . "|" . ($enable ? "1" : "0"));
    }

    // Module
    public function loadModule($modulePath, $methods)
    {
        $methodsStr = (count($methods) > 0) ? "|" . implode("|", $methods) : "";
        $this->add("Ml", $modulePath . $methodsStr);
    }

    public function unloadModule($modulePath)
    {
        $this->add("Mu", $modulePath);
    }

    public function deleteModuleMethod($methodName)
    {
        $this->add("Md", $methodName);
    }

    // Unit Testing
    public function assertEqual($inputPlace, $tag)
    {
        $this->add("At" . $inputPlace, str_replace("\n", "$[ln];", $tag));
    }

    public function assertEqualByOutputPlace($inputPlace, $outputPlace)
    {
        $this->add("Ao" . $inputPlace, $outputPlace);
    }

    // Service Worker
    public function serviceWorkerRegister($path = null, $scopePath = null)
    {
        $this->add("wR", $path . "|" . $scopePath);
    }

    public function serviceWorkerPreCacheStatic($pathList)
    {
        $this->add("wp", implode("|", $pathList));
    }

    public function serviceWorkerDynamicCache($path, $seconds = 0)
    {
        $this->add("wc", $path . ($seconds > 0 ? "|" . $seconds : ""));
    }

    public function serviceWorkerDeleteDynamicCache($path = null)
    {
        $this->add("wd", $path);
    }

    public function serviceWorkerDynamicCacheTTLUpdate($path, $seconds = 0)
    {
        $this->add("wt", $path . ($seconds > 0 ? "|" . $seconds : ""));
    }

    public function serviceWorkerRouteSet($path, $type, $cacheDynamic = false)
    {
        $this->add("wr", $path . "|" . $type . ($cacheDynamic ? "|1" : ""));
    }

    public function serviceWorkerRouteAlias($path, $to)
    {
        $this->add("wa", $path . "|" . $to);
    }

    public function serviceWorkerDeleteRouteAlias($path = null)
    {
        $this->add("wC", $path);
    }

    public function serviceWorkerDeleteRoute($path = null)
    {
        $this->add("wD", $path);
    }

    // SSE
    public function disconnectSSE($path = null)
    {
        $this->add("Ds", $path);
    }

    public function disconnectAllSSE()
    {
        $this->add("Ds");
    }

    // State
    public function addState($path = null, $title = null)
    {
        $this->add("AS", $path . "|" . $title);
    }

    public function deleteState($path = null)
    {
        $this->add("DS", $path);
    }

    public function deleteAllState()
    {
        $this->add("DS", "*");
    }

    // Cookie
    public function setCookie($key, $value, $seconds, $path = null)
    {
        $this->add("sC", $key . "|" . $value . "|" . $seconds . (!empty($path) ? "|" . $path : ""));
    }

    // Save/Session Cache
    public function saveId($inputPlace, $key = ".")
    {
        $this->add("@gi" . $inputPlace, $key);
    }

    public function saveName($inputPlace, $key = ".")
    {
        $this->add("@gn" . $inputPlace, $key);
    }

    public function saveValue($inputPlace, $key = ".")
    {
        $this->add("@gv" . $inputPlace, $key);
    }

    public function saveValueLength($inputPlace, $key = ".")
    {
        $this->add("@ge" . $inputPlace, $key);
    }

    public function saveClass($inputPlace, $key = ".")
    {
        $this->add("@gc" . $inputPlace, $key);
    }

    public function saveStyle($inputPlace, $key = ".")
    {
        $this->add("@gs" . $inputPlace, $key);
    }

    public function saveTitle($inputPlace, $key = ".")
    {
        $this->add("@gl" . $inputPlace, $key);
    }

    public function saveLabel($inputPlace, $key = ".")
    {
        $this->add("@gA" . $inputPlace, $key);
    }

    public function saveText($inputPlace, $key = ".")
    {
        $this->add("@gt" . $inputPlace, $key);
    }

    public function saveOuterText($inputPlace, $key = ".")
    {
        $this->add("@go" . $inputPlace, $key);
    }

    public function saveTextLength($inputPlace, $key = ".")
    {
        $this->add("@gg" . $inputPlace, $key);
    }

    public function saveAttribute($inputPlace, $attribute, $key = ".")
    {
        $this->add("@ga" . $inputPlace, $key . '|' . $attribute);
    }

    public function saveWidth($inputPlace, $key = ".")
    {
        $this->add("@gw" . $inputPlace, $key);
    }

    public function saveHeight($inputPlace, $key = ".")
    {
        $this->add("@gh" . $inputPlace, $key);
    }

    public function saveReadOnly($inputPlace, $key = ".")
    {
        $this->add("@gr" . $inputPlace, $key);
    }

    public function saveSelectedIndex($inputPlace, $key = ".")
    {
        $this->add("@gx" . $inputPlace, $key);
    }

    public function saveTextAlign($inputPlace, $key = ".")
    {
        $this->add("@gT" . $inputPlace, $key);
    }

    public function saveNodeLength($inputPlace, $key = ".")
    {
        $this->add("@gL" . $inputPlace, $key);
    }

    public function saveVisible($inputPlace, $key = ".")
    {
        $this->add("@gV" . $inputPlace, $key);
    }

    public function saveUrl($url, $fetchScript = false, $key = ".")
    {
        $this->add("@gu", $key . "|" . $url . ($fetchScript ? "|1" : ""));
    }

    public function saveIndex($inputPlace, $key = ".")
    {
        $this->add("@gI" . $inputPlace, $key);
    }

    public function removeSessionCache($cacheKey)
    {
        $this->add("rs", $cacheKey);
    }

    public function removeAllSessionCache()
    {
        $this->add("rs", "*");
    }

    public function setSessionCache()
    {
        $this->add("cs", "*");
    }

    public function addSessionCacheValue($cacheKey, $value)
    {
        $this->add("SA", $cacheKey . "|" . str_replace("\n", "$[ln];", $value));
    }

    public function insertSessionCacheValue($cacheKey, $value)
    {
        $this->add("SI", $cacheKey . "|" . str_replace("\n", "$[ln];", $value));
    }

    // Cache
    public function cacheId($inputPlace, $key = ".")
    {
        $this->add("@ci" . $inputPlace, $key);
    }

    public function cacheName($inputPlace, $key = ".")
    {
        $this->add("@cn" . $inputPlace, $key);
    }

    public function cacheValue($inputPlace, $key = ".")
    {
        $this->add("@cv" . $inputPlace, $key);
    }

    public function cacheValueLength($inputPlace, $key = ".")
    {
        $this->add("@ce" . $inputPlace, $key);
    }

    public function cacheClass($inputPlace, $key = ".")
    {
        $this->add("@cc" . $inputPlace, $key);
    }

    public function cacheStyle($inputPlace, $key = ".")
    {
        $this->add("@cs" . $inputPlace, $key);
    }

    public function cacheTitle($inputPlace, $key = ".")
    {
        $this->add("@cl" . $inputPlace, $key);
    }

    public function cacheLabel($inputPlace, $key = ".")
    {
        $this->add("@cA" . $inputPlace, $key);
    }

    public function cacheText($inputPlace, $key = ".")
    {
        $this->add("@ct" . $inputPlace, $key);
    }

    public function cacheOuterText($inputPlace, $key = ".")
    {
        $this->add("@co" . $inputPlace, $key);
    }

    public function cacheTextLength($inputPlace, $key = ".")
    {
        $this->add("@cg" . $inputPlace, $key);
    }

    public function cacheAttribute($inputPlace, $attribute, $key = ".")
    {
        $this->add("@ca" . $inputPlace, $key . '|' . $attribute);
    }

    public function cacheWidth($inputPlace, $key = ".")
    {
        $this->add("@cw" . $inputPlace, $key);
    }

    public function cacheHeight($inputPlace, $key = ".")
    {
        $this->add("@ch" . $inputPlace, $key);
    }

    public function cacheReadOnly($inputPlace, $key = ".")
    {
        $this->add("@cr" . $inputPlace, $key);
    }

    public function cacheSelectedIndex($inputPlace, $key = ".")
    {
        $this->add("@cx" . $inputPlace, $key);
    }

    public function cacheTextAlign($inputPlace, $key = ".")
    {
        $this->add("@cT" . $inputPlace, $key);
    }

    public function cacheNodeLength($inputPlace, $key = ".")
    {
        $this->add("@cL" . $inputPlace, $key);
    }

    public function cacheVisible($inputPlace, $key = ".")
    {
        $this->add("@cV" . $inputPlace, $key);
    }

    public function cacheUrl($url, $fetchScript = false, $key = ".")
    {
        $this->add("@cu", $key . "|" . $url . ($fetchScript ? "|1" : ""));
    }

    public function cacheIndex($inputPlace, $key = ".")
    {
        $this->add("@cI" . $inputPlace, $key);
    }

    public function removeCache($cacheKey)
    {
        $this->add("rd", $cacheKey);
    }

    public function removeAllCache()
    {
        $this->add("rd", "*");
    }

    public function setCache($second)
    {
        $this->add("cd", (string)$second);
    }

    public function setCacheNoTime()
    {
        $this->add("cd", "*");
    }

    public function addCacheValue($cacheKey, $value)
    {
        $this->add("CA", $cacheKey . "|" . str_replace("\n", "$[ln];", $value));
    }

    public function insertCacheValue($cacheKey, $value)
    {
        $this->add("CI", $cacheKey . "|" . str_replace("\n", "$[ln];", $value));
    }

    // Call
    public function loadUrl($inputPlace, $url)
    {
        $this->add("lu" . $inputPlace, $url);
    }

    public function runActionControls($actionControls, $index = null, $withoutWebFormsSection = false, $useCurrentEvent = true)
    {
        $this->add("lA", ($useCurrentEvent ? "1" : "0") . "|" . ($withoutWebFormsSection ? "1" : "0") . "|" . $index . "|" . $actionControls);
    }

    public function callScript($scriptText)
    {
        $this->add("_", str_replace("\n", "$[ln];", $scriptText));
    }

    public function callMethod($methodName, $args = null)
    {
        $argsJoin = "";
        if ($args !== null && count($args) > 0) {
            $argsJoin = "|" . implode("|", $args);
        }
        $this->add("lm", $methodName . $argsJoin);
    }

    public function callModuleMethod($methodName, $args = null)
    {
        $argsJoin = "";
        if ($args !== null && count($args) > 0) {
            $argsJoin = "|" . implode("|", $args);
        }
        $this->add("lM", $methodName . $argsJoin);
    }

    public function callPostBack($formInputPlace, $outputPlace = null)
    {
        $this->add("Lp", "1" . "|" . $formInputPlace . (!empty($outputPlace) ? "|" . $outputPlace : ""));
    }

    public function callTagBack($outputPlace = null, $useCurrentEvent = true)
    {
        $this->add("Lt", ($useCurrentEvent ? "1" : "0") . (!empty($outputPlace) ? "|" . $outputPlace : ""));
    }

    public function callCommentBack($index = null, $outputPlace = null, $useCurrentEvent = true)
    {
        $this->add("LC", ($useCurrentEvent ? "1" : "0") . "|" . $index . "|" . $outputPlace);
    }

    public function callWasmBack($wasmLanguage, $wasmUrl, $methodName, $args = null, $outputPlace = null, $useCurrentEvent = true)
    {
        $argsJoin = "";
        if ($args !== null && count($args) > 0) {
            $argsJoin = implode(",", $args);
        }
        $this->add("Ly", ($useCurrentEvent ? "1" : "0") . "|" . $wasmLanguage . "|" . $wasmUrl . "|" . $methodName . "|" . $argsJoin . "|" . $outputPlace);
    }

    public function callWebSocketBack($path, $useCurrentEvent = true)
    {
        $this->add("Lw", ($useCurrentEvent ? "1" : "0") . "|" . $path);
    }

    public function callSSEBack($path, $outputPlace = null, $useCurrentEvent = true, $shouldReconnect = true, $reconnectTryTimeout = 3000)
    {
        $this->add("Ls", ($useCurrentEvent ? "1" : "0") . "|" . $path . "|" . ($shouldReconnect ? "1" : "0") . "|" . $reconnectTryTimeout . (!empty($outputPlace) ? "|" . $outputPlace : ""));
    }

    public function callFront($modulePath, $args = null, $outputPlace = null, $useCurrentEvent = true)
    {
        $argsJoin = "";
        if ($args !== null && count($args) > 0) {
            $argsJoin = "|" . implode("|", $args);
        }
        $this->add("Lj", ($useCurrentEvent ? "1" : "0") . "|" . $modulePath . "|" . $outputPlace . $argsJoin);
    }

    public function callGetBack($path, $outputPlace = null, $useCurrentEvent = true)
    {
        $this->add("Lg", ($useCurrentEvent ? "1" : "0") . "|" . $path . (!empty($outputPlace) ? "|" . $outputPlace : ""));
    }

    public function callPutBack($path, $outputPlace = null, $useCurrentEvent = true)
    {
        $this->add("Lu", ($useCurrentEvent ? "1" : "0") . "|" . $path . (!empty($outputPlace) ? "|" . $outputPlace : ""));
    }

    public function callPatchBack($path, $outputPlace = null, $useCurrentEvent = true)
    {
        $this->add("LP", ($useCurrentEvent ? "1" : "0") . "|" . $path . (!empty($outputPlace) ? "|" . $outputPlace : ""));
    }

    public function callDeleteBack($path, $outputPlace = null, $useCurrentEvent = true)
    {
        $this->add("Ld", ($useCurrentEvent ? "1" : "0") . "|" . $path . (!empty($outputPlace) ? "|" . $outputPlace : ""));
    }

    public function callHeadBack($path, $outputPlace = null, $useCurrentEvent = true)
    {
        $this->add("Lh", ($useCurrentEvent ? "1" : "0") . "|" . $path . (!empty($outputPlace) ? "|" . $outputPlace : ""));
    }

    public function callOptionsBack($path, $outputPlace = null, $useCurrentEvent = true)
    {
        $this->add("Lo", ($useCurrentEvent ? "1" : "0") . "|" . $path . (!empty($outputPlace) ? "|" . $outputPlace : ""));
    }

    public function callTraceBack($path, $outputPlace = null, $useCurrentEvent = true)
    {
        $this->add("LT", ($useCurrentEvent ? "1" : "0") . "|" . $path . (!empty($outputPlace) ? "|" . $outputPlace : ""));
    }

    public function callConnectBack($path, $outputPlace = null, $useCurrentEvent = true)
    {
        $this->add("Lc", ($useCurrentEvent ? "1" : "0") . "|" . $path . (!empty($outputPlace) ? "|" . $outputPlace : ""));
    }

    public function callSendBack($path, $method, $isMultiPart, $contentType, $data, $outputPlace = null, $useCurrentEvent = true)
    {
        $this->add("LS", ($useCurrentEvent ? "1" : "0") . "|" . $path . "|" . $method . "|" . ($isMultiPart ? "1" : "0") . "|" . $contentType . "|" . str_replace(["\\n", "|"], ["$[ln];", "$[vb];"], $data) . (!empty($outputPlace) ? "|" . $outputPlace : ""));
    }

    // Update
    public function increase($inputPlace, $value)
    {
        $this->add("gt" . $inputPlace, "i|" . $value);
    }

    public function decrease($inputPlace, $value)
    {
        $this->add("gt" . $inputPlace, "i|" . ($value * -1));
    }

    public function replace($inputPlace, $value, $newValue, $alsoStartTag = false, $deep = false)
    {
        if (!empty($value) && $value[0] == '@') {
            $value = substr($value, 1);
            $value = "$[at];" . $value;
        }

        if (!empty($newValue) && $newValue[0] == '@') {
            $newValue = substr($newValue, 1);
            $newValue = "$[at];" . $newValue;
        }

        $this->add("gt" . $inputPlace, "r|" . $value . "|" . $newValue . "|" . ($alsoStartTag ? "1" : "0") . "|" . ($deep ? "1" : "0"));
    }

    public function replaceStartTag($inputPlace, $value, $newValue)
    {
        if (!empty($value) && $value[0] == '@') {
            $value = substr($value, 1);
            $value = "$[at];" . $value;
        }

        if (!empty($newValue) && $newValue[0] == '@') {
            $newValue = substr($newValue, 1);
            $newValue = "$[at];" . $newValue;
        }

        $this->add("gt" . $inputPlace, "s|" . $value . "|" . $newValue);
    }

    // Pre Runner
    public function assignDelay($miliSecond, $index = -1)
    {
        $currentLine = $this->getLineByIndex($index);
        if (empty($currentLine)) {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $newName = ":" . $miliSecond . ")" . $parts[0];
        $newValue = count($parts) > 1 ? $parts[1] : "";

        $this->updateLineByIndex($index, $newName, $newValue);
    }

    public function assignDelayChange($miliSecond, $index = -1)
    {
        $currentLine = $this->getLineByIndex($index);
        if (empty($currentLine)) {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $currentName = $parts[0];

        if (strpos($currentName, ':') === 0 && strpos($currentName, ')') !== false) {
            $closingBracket = strpos($currentName, ')');
            $currentName = substr($currentName, $closingBracket + 1);
        }

        $newName = ":" . $miliSecond . ")" . $currentName;
        $newValue = count($parts) > 1 ? $parts[1] : "";

        $this->updateLineByIndex($index, $newName, $newValue);
    }

    public function assignInterval($miliSecond, $id = null, $index = -1)
    {
        $currentLine = $this->getLineByIndex($index);
        if (empty($currentLine)) {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $newName = "(" . $miliSecond . (!empty($id) ? "|" . $id : "") . ")" . $parts[0];
        $newValue = count($parts) > 1 ? $parts[1] : "";

        $this->updateLineByIndex($index, $newName, $newValue);
    }

    public function assignIntervalChange($miliSecond, $id = null, $index = -1)
    {
        $currentLine = $this->getLineByIndex($index);
        if (empty($currentLine)) {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $currentName = $parts[0];

        if (strpos($currentName, '(') === 0 && strpos($currentName, ')') !== false) {
            $closingBracket = strpos($currentName, ')');
            $currentName = substr($currentName, $closingBracket + 1);
        }

        $newName = "(" . $miliSecond . (!empty($id) ? "|" . $id : "") . ")" . $currentName;
        $newValue = count($parts) > 1 ? $parts[1] : "";

        $this->updateLineByIndex($index, $newName, $newValue);
    }

    public function deleteInterval($id)
    {
        $this->add("Di", $id);
    }

    public function assignRepeat($count, $index = -1)
    {
        $currentLine = $this->getLineByIndex($index);
        if (empty($currentLine)) {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $newName = "," . $count . ")" . $parts[0];
        $newValue = count($parts) > 1 ? $parts[1] : "";

        $this->updateLineByIndex($index, $newName, $newValue);
    }

    public function assignRepeatChange($count, $index = -1)
    {
        $currentLine = $this->getLineByIndex($index);
        if (empty($currentLine)) {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $currentName = $parts[0];

        if (strpos($currentName, ',') === 0 && strpos($currentName, ')') !== false) {
            $closingBracket = strpos($currentName, ')');
            $currentName = substr($currentName, $closingBracket + 1);
        }

        $newName = "," . $count . ")" . $currentName;
        $newValue = count($parts) > 1 ? $parts[1] : "";

        $this->updateLineByIndex($index, $newName, $newValue);
    }

    // Index
    public function startIndex($name = "")
    {
        $this->add("#", $name);
    }

    public function goToLine($line, $repeat = 1)
    {
        $this->add("&", $line . "|" . $repeat);
    }

    public function goToIndex($index, $repeat = 1)
    {
        $this->add("&", "#" . $index . "|" . $repeat);
    }

    // Start
    public function startTransientDOM($inputPlace)
    {
        $this->add("td", $inputPlace);
    }

    public function endTransientDOM()
    {
        $this->add("td", ";");
    }

    // Message
    public function alert($text, $type = "none", $title = "Alert", $okText = "OK")
    {
        $typeParam = ($type == "none") ? "" : $type;
        $titleParam = ($title == "Alert") ? "" : $title;
        $okTextParam = ($okText == "OK") ? "" : $okText;
        $this->add("Al", $text . "|" . $typeParam . "|" . $titleParam . "|" . $okTextParam);
    }

    public function message($text, $type = "none", $duration = 0)
    {
        $typeParam = ($type == "none") ? "" : $type;
        $durationParam = ($duration == 0) ? "" : $duration;
        $this->add("me", $text . "|" . $typeParam . "|" . $durationParam);
    }

    public function consoleMessage($text, $type = "log")
    {
        $typeParam = ($type == "log") ? "" : $type;
        $this->add("mc", str_replace("\n", "$[ln];", $text) . $typeParam);
    }

    public function consoleMessageAssert($text, $condition)
    {
        $this->add("ma", str_replace("\n", "$[ln];", $text) . "|" . $condition);
    }

    // Enable
    public function enableWebSocket($enable = true)
    {
        $this->add("ew", $enable ? "1" : "0");
    }

    public function enableWebSocketOnce()
    {
        $this->add("ew", "$");
    }

    public function addWebSocket($path)
    {
        $this->add("aw" . $path);
    }

    // Use
    public function useWebSocket($inputPlace)
    {
        $this->add("uw" . $inputPlace);
    }

    public function useOnlyChangeUpdate($inputPlace)
    {
        $this->add("uo" . $inputPlace);
    }

    // Condition
    public function confirmIsTrueAccept($text = "Are you sure you want to proceed?", $type = "none", $title = "Confirm", $okText = "OK", $cancelText = "Cancel", $interval = 100)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $textParam = ($text == "Are you sure you want to proceed?") ? "" : $text;
        $typeParam = ($type == "none") ? "" : $type;
        $titleParam = ($title == "Confirm") ? "" : $title;
        $okTextParam = ($okText == "OK") ? "" : $okText;
        $cancelTextParam = ($cancelText == "Cancel") ? "" : $cancelText;
        $this->add($prefix . "ct", $textParam . "|" . $typeParam . "|" . $titleParam . "|" . $okTextParam . "|" . $cancelTextParam);
    }

    public function confirmIsFalseAccept($text = "Are you sure you want to proceed?", $type = "none", $title = "Confirm", $okText = "OK", $cancelText = "Cancel", $interval = 100)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $textParam = ($text == "Are you sure you want to proceed?") ? "" : $text;
        $typeParam = ($type == "none") ? "" : $type;
        $titleParam = ($title == "Confirm") ? "" : $title;
        $okTextParam = ($okText == "OK") ? "" : $okText;
        $cancelTextParam = ($cancelText == "Cancel") ? "" : $cancelText;
        $this->add($prefix . "cf", $textParam . "|" . $typeParam . "|" . $titleParam . "|" . $okTextParam . "|" . $cancelTextParam);
    }

    public function isGreaterThan($firstValue, $secondValue, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "gt", $firstValue . "|" . $secondValue);
    }

    public function isLessThan($firstValue, $secondValue, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "lt", $firstValue . "|" . $secondValue);
    }

    public function isEqualTo($firstValue, $secondValue, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "et", $firstValue . "|" . $secondValue);
    }

    public function isNotEqualTo($firstValue, $secondValue, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "Nt", $firstValue . "|" . $secondValue);
    }

    public function exist($value, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "ex", $value);
    }

    public function notExist($value, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "nx", $value);
    }

    public function isTrue($value, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "tr", $value);
    }

    public function isFalse($value, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "fa", $value);
    }

    public function isMatchMedia($value, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "mm", $value);
    }

    public function isNotMatchMedia($value, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "nm", $value);
    }

    public function includeText($text, $value, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "In", $value . "|" . $text);
    }

    public function notInclude($text, $value, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "Nn", $value . "|" . $text);
    }

    public function elementExists($inputPlace, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "eE", $inputPlace);
    }

    public function elementNotExists($inputPlace, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "nE", $inputPlace);
    }

    public function isRegexMatch($value, $pattern, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "re", $value . "|" . $pattern);
    }

    public function isRegexNotMatch($value, $pattern, $interval = -1)
    {
        $prefix = ($interval >= 0) ? "{(" . $interval . ")" : "{";
        $this->add($prefix . "rn", $value . "|" . $pattern);
    }

    public function breakIt()
    {
        $this->add(";");
    }

    public function startBracket()
    {
        $this->add("{");
    }

    public function endBracket()
    {
        $this->add("}");
    }

    // Async
    public function async()
    {
        $this->add("{(a)");
    }

    public function delay($miliSecond)
    {
        $this->add("De", (string)$miliSecond);
    }

    // Format Storage
    public function createFormatStorage($key, $data)
    {
        $this->add(".C", $key . "|" . $data);
    }

    public function deleteFormatStorage($key)
    {
        $this->add(".D", $key);
    }

    public function addJSON($key, $path, $value)
    {
        $this->add(".a", $key . "|j|" . $value . "|" . $path);
    }

    public function addXML($key, $path, $name, $value = null)
    {
        if (!empty($name) && $name[0] == '@') {
            $name = substr($name, 1);
            $name = "$[at];" . $name;
        }
        $this->add(".a", $key . "|x|" . str_replace("@", "$[at];", $name) . "|" . $value . "|" . $path);
    }

    public function addINI($key, $path, $value, $isINILike = false)
    {
        $this->add(".a", $key . "|i|" . ($isINILike ? "1" : "0") . "|" . $value . "|" . $path);
    }

    public function addTextLine($key, $line, $text)
    {
        $this->add(".a", $key . "|t|" . $text . "|" . $line);
    }

    public function addVariable($key, $value)
    {
        $this->add(".a", $key . "|v|" . $value);
    }

    public function updateJSON($key, $path, $value)
    {
        $this->add(".u", $key . "|j|" . $value . "|" . $path);
    }

    public function updateXML($key, $path, $value)
    {
        $this->add(".u", $key . "|x|" . $value . "|" . $path);
    }

    public function updateINI($key, $path, $value, $isINILike = false)
    {
        $this->add(".u", $key . "|i|" . ($isINILike ? "1" : "0") . "|" . $value . "|" . $path);
    }

    public function updateTexLine($key, $line, $text)
    {
        $this->add(".u", $key . "|t|" . $text . "|" . $line);
    }

    public function updateVariable($key, $value)
    {
        $this->add(".u", $key . "|v|" . $value);
    }

    public function increaseVariable($key, $value)
    {
        $this->add(".i", $key . "|v|" . $value);
    }

    public function decreaseVariable($key, $value)
    {
        $this->increaseVariable($key, $value * -1);
    }

    public function deleteJSON($key, $path)
    {
        $this->add(".d", $key . "|j|" . $path);
    }

    public function deleteXML($key, $path)
    {
        $this->add(".d", $key . "|x|" . $path);
    }

    public function deleteINI($key, $path, $isINILike = false)
    {
        $this->add(".d", $key . "|i|" . ($isINILike ? "1" : "0") . "|" . $path);
    }

    public function deleteTextLine($key, $line)
    {
        $this->add(".d", $key . "|t|" . $line);
    }

    public function deleteVariable($key)
    {
        $this->add(".d", $key . "|v");
    }

    // Inject
    public function inject($value)
    {
        return "$[" . $value . "];";
    }

    // Hash And Checksum
    public function setHash()
    {
        $this->add("SH");
    }

    public function setChecksum()
    {
        $this->add("CS");
    }

    public function checksumCalculation($text)
    {
        $sum = 0;
        $mod = 65536;
        $shift = 5;

        for ($i = 0; $i < strlen($text); $i++) {
            $c = ord($text[$i]);
            $sum = (($sum << $shift) | ($sum >> (16 - $shift))) ^ $c;
            $sum %= $mod;
        }

        return (string)$sum;
    }

    public function getChecksum()
    {
        return $this->checksumCalculation($this->getFormsActionData());
    }

    // Get
    public function getFormsActionData()
    {
        return $this->webFormsData;
    }

    public function response()
    {
        return "[web-forms]\n" . $this->getFormsActionData();
    }

    public function getFormsActionDataLineBreak()
    {
        if (empty($this->webFormsData)) {
            return "";
        }

        $processedData = str_replace("\"", "$[dq];", $this->webFormsData);
        return str_replace("\n", "$[sln];", $processedData);
    }

    // Export
    public function exportToWebFormsTag($src = null)
    {
        return "<web-forms ac=\"" . $this->getFormsActionDataLineBreak() . "\"" . (!empty($src) ? " src=\"" . $src . "\"" : "") . "></web-forms>";
    }

    public function exportToLineBreak($src = null)
    {
        return "[web-forms]$[sln];" . $this->getFormsActionDataLineBreak();
    }

    public function exportToWebFormsTagWithDimensions($width, $height, $src = null)
    {
        return "<web-forms ac=\"" . $this->getFormsActionDataLineBreak() . "\" width=\"" . $width . "\" height=\"" . $height . "\"" . (!empty($src) ? " src=\"" . $src . "\"" : "") . "></web-forms>";
    }

    public function exportToWebFormsTagWithDimensionsInt($width, $height, $src = null)
    {
        return $this->exportToWebFormsTagWithDimensions($width . "px", $height . "px", $src);
    }

    public function doneToWebFormsTag($id = null)
    {
        return "<web-forms ac=\"" . $this->getFormsActionDataLineBreak() . "\"" . (!empty($id) ? " id=\"" . $id . "\" done=\"true\"" : "") . "></web-forms>";
    }

    public function exportToHtmlComment($addLine = false)
    {
        return ($addLine ? "\n" : "") . "<!--" . $this->response() . "-->";
    }

    public function getWebFormsData()
    {
        return $this->webFormsData;
    }

    public function appendForm($form)
    {
        if ($form == null) return;

        $otherData = $form->getWebFormsData();
        if (!empty($otherData)) {
            if (!empty($this->webFormsData)) {
                $this->webFormsData .= "\n";
            }
            $this->webFormsData .= $otherData;
        }
    }

    public function clean()
    {
        $this->webFormsData = '';
    }
}

class Security
{
    public function safeValue($value)
    {
        if (empty($value)) {
            return $value;
        }

        if ($value[0] == '@') {
            $value = substr($value, 1);
            $value = "$[at];" . $value;
        }

        $value = str_replace("\n", "$[ln];", $value);
        $value = str_replace("|", "$[vb];", $value);
        $value = str_replace(",@", "$[co];@", $value);

        return $value;
    }
}

class InputPlace
{
    const Window = "`";
    const Root = "~";
    const Current = "$";
    const Target = "!";
    const Upper = "-";
    const Head = "^";
    const ScreenOrientation = "%";

    public static function id($id)
    {
        return $id;
    }

    public static function name($name)
    {
        return '(' . $name . ')';
    }

    public static function nameWithIndex($name, $index)
    {
        return '(' . $name . ')' . $index;
    }

    public static function tag($tag)
    {
        return '<' . $tag . '>';
    }

    public static function tagWithIndex($tag, $index)
    {
        return '<' . $tag . '>' . $index;
    }

    public static function mediaClass($class)
    {
        return '{' . $class . '}';
    }

    public static function mediaClassWithIndex($class, $index)
    {
        return '{' . $class . '}' . $index;
    }

    public static function query($query)
    {
        return "*" . str_replace("=", "$[eq];", $query);
    }

    public static function queryAll($query)
    {
        return "[" . str_replace("=", "$[eq];", $query);
    }
}

class OutputPlace extends InputPlace
{
    // Inherits all methods from InputPlace
}

class Fetch
{
    // Method
    public static function random($maxValue)
    {
        return "@mr" . $maxValue;
    }

    public static function randomRange($minValue, $maxValue)
    {
        return "@mr" . $maxValue . "," . $minValue;
    }

    public static function spaceToChar($text, $character = "-")
    {
        return "@sc" . $character . "," . $text;
    }

    public static function encodeURI($text)
    {
        return "@ue" . $text;
    }

    public static function decodeURI($text)
    {
        return "@ud" . $text;
    }

    public static function method($methodName, $args = null)
    {
        $returnValue = "@cm" . $methodName;

        if ($args !== null && count($args) > 0) {
            $returnValue .= "," . implode(",", $args);
        }

        return $returnValue;
    }

    public static function moduleMethod($methodName, $args = null)
    {
        $returnValue = "@cM" . $methodName;

        if ($args !== null && count($args) > 0) {
            $returnValue .= "," . implode(",", $args);
        }

        return $returnValue;
    }

    public static function wasmMethod($wasmLanguage, $wasmUrl, $methodName, $args = null, $key = ".")
    {
        $returnValue = "@wA" . $wasmLanguage . "," . $wasmUrl . "," . $methodName;

        if ($args !== null && count($args) > 0) {
            $returnValue .= "," . implode(",", $args);
        }

        return $returnValue;
    }

    public static function script($scriptText)
    {
        return "@_" . str_replace("\n", "$[ln];", $scriptText);
    }

    public static function loadUrl($url, $fetchScript = false)
    {
        return "@lu" . $url . ($fetchScript ? ",1" : "");
    }

    public static function loadHtml($url, $fetchInputPlace, $fetchScript = false)
    {
        return "@lh" . $url . "," . ($fetchScript ? "1" : "0") . (!empty($fetchInputPlace) ? "," . $fetchInputPlace : "");
    }

    public static function loadLine($url, $line)
    {
        return "@ll" . $url . "," . $line;
    }

    public static function loadINI($url, $name, $isINILike = false)
    {
        return "@li" . $url . "," . $name . ($isINILike ? ",1" : "");
    }

    public static function loadJSON($url, $name)
    {
        return "@lj" . $url . "," . $name;
    }

    public static function loadXML($url, $name)
    {
        return "@lx" . $url . "," . $name;
    }

    public static function hasMethod($methodName)
    {
        return "@hm" . $methodName;
    }

    public static function hasModuleMethod($methodName)
    {
        return "@hM" . $methodName;
    }

    public static function getModifierState($modifier)
    {
        return "@ms" . $modifier;
    }

    // Math
    public static function math($methodName, $args = null)
    {
        $returnValue = "@M#" . $methodName;

        if ($args !== null && count($args) > 0) {
            $returnValue .= "," . implode(",", $args);
        }

        return $returnValue;
    }

    // Data
    const DateYear = "@dy";
    const DateMonth = "@dm";
    const DateDay = "@dd";
    const DateHours = "@dh";
    const DateMinutes = "@di";
    const DateSeconds = "@ds";
    const DateMilliseconds = "@dl";

    // String
    const Space = "@sp";
    const AtSign = "@sa";

    // Tag
    public static function getId($inputPlace)
    {
        return "@\$i" . $inputPlace;
    }

    public static function getName($inputPlace)
    {
        return "@\$n" . $inputPlace;
    }

    public static function getValue($inputPlace)
    {
        return "@\$v" . $inputPlace;
    }

    public static function getValueLength($inputPlace)
    {
        return "@\$e" . $inputPlace;
    }

    public static function getClass($inputPlace)
    {
        return "@\$c" . $inputPlace;
    }

    public static function getStyle($inputPlace)
    {
        return "@\$s" . $inputPlace;
    }

    public static function getTitle($inputPlace)
    {
        return "@\$l" . $inputPlace;
    }

    public static function getLabel($inputPlace)
    {
        return "@\$A" . $inputPlace;
    }

    public static function getText($inputPlace)
    {
        return "@\$t" . $inputPlace;
    }

    public static function getOuterText($inputPlace)
    {
        return "@\$o" . $inputPlace;
    }

    public static function getTextLength($inputPlace)
    {
        return "@\$g" . $inputPlace;
    }

    public static function getAttribute($inputPlace, $attribute)
    {
        return "@\$a" . $inputPlace . "," . $attribute;
    }

    public static function getWidth($inputPlace)
    {
        return "@\$w" . $inputPlace;
    }

    public static function getHeight($inputPlace)
    {
        return "@\$h" . $inputPlace;
    }

    public static function getIsReadOnly($inputPlace)
    {
        return "@\$r" . $inputPlace;
    }

    public static function getSelectedIndex($inputPlace)
    {
        return "@\$x" . $inputPlace;
    }

    public static function getIndex($inputPlace)
    {
        return "@\$I" . $inputPlace;
    }

    public static function getTextAlign($inputPlace)
    {
        return "@\$T" . $inputPlace;
    }

    public static function getNodeLength($inputPlace)
    {
        return "@\$L" . $inputPlace;
    }

    public static function getIsVisible($inputPlace)
    {
        return "@\$V" . $inputPlace;
    }

    // Save
    public static function hasHash($hash)
    {
        return "@HH" . $hash;
    }

    public static function cookie($key)
    {
        return "@co" . $key;
    }

    public static function session($key)
    {
        return "@cs" . $key;
    }

    public static function sessionWithReplace($key, $replaceValue)
    {
        return "@cs" . $key . "," . $replaceValue;
    }

    public static function sessionAndRemove($key)
    {
        return "@cl" . $key;
    }

    public static function saved($key = ".")
    {
        return self::session($key);
    }

    public static function cache($key = ".")
    {
        return "@cd" . $key;
    }

    public static function cacheWithReplace($key, $replaceValue)
    {
        return "@cd" . $key . "," . $replaceValue;
    }

    public static function cacheAndRemove($key)
    {
        return "@ct" . $key;
    }

    public static function savedLine($key = ".", $line = 0)
    {
        return "@lL" . $key . "[" . $line;
    }

    public static function savedLineConsume($key = ".")
    {
        return "@lL" . $key;
    }

    public static function savedINI($key, $iniKey)
    {
        return "@lI" . $key . "[" . $iniKey;
    }

    public static function cacheLine($key = ".", $line = 0)
    {
        return "@dL" . $key . "[" . $line;
    }

    public static function cacheLineConsume($key = ".")
    {
        return "@dL" . $key;
    }

    public static function cacheINI($key, $iniKey)
    {
        return "@dI" . $key . "[" . $iniKey;
    }

    // Format Storage
    public static function formatStore($key)
    {
        return "@fr" . $key;
    }

    public static function formatStoreByXMLQuery($key, $xPath)
    {
        return "@fx" . $key . "," . $xPath;
    }

    public static function formatStoreByJSONQuery($key, $query)
    {
        return "@fj" . $key . "," . $query;
    }

    public static function formatStoreByINI($key, $name)
    {
        return "@fi" . $key . "," . $name;
    }

    public static function formatStoreByText($key, $line)
    {
        return "@ft" . $key . "," . $line;
    }

    public static function formatStoreByVariable($key)
    {
        return "@fv" . $key;
    }

    // Document
    const TabIsActive = "@da";

    // Window
    const Href = "@wf";
    const PathName = "@wP";
    const Query = "@wq";
    const Hash = "@wh";
    const Host = "@wH";
    const HostName = "@wn";
    const Port = "@wT";
    const Origin = "@wo";
    const GetSelection = "@ws";
    const ScrollX = "@wx";
    const ScrollY = "@wy";

    // Navigator
    const ClipboardText = "@nC";
    const GeoLatitude = "@nW";
    const GeoLongitude = "@nO";
    const Language = "@nL";
    const IsOnLine = "@no";
    const UserAgent = "@na";

    // Screen
    const ScreenWidth = "@sw";
    const ScreenHeight = "@sh";
    const ScreenOrientationType = "@so";
    const ScreenOrientationAngle = "@sr";

    // Performance
    const TimeOrigin = "@pt";
    const PerformanceNow = "@pn";

    // Event
    const Event = "@EV";
    const EventSerialize = "@Es";
    const EventKey = "@ek";
    const EventWhich = "@ew";
    const EventClientX = "@ex";
    const EventClientY = "@ey";
    const EventPageX = "@eX";
    const EventPageY = "@eY";
    const EventOffsetX = "@Ex";
    const EventOffsetY = "@Ey";
    const EventDeltaY = "@ed";
}

class WasmLanguage
{
    const C = "c";
    const CPP = "c";
    const Rust = "rust";
    const CSharp = "csharp";
    const GO = "go";
    const JAVA = "java";
    const AssemblyScript = "as";
}

class HtmlEvent
{
    const OnAbort = "onabort";
    const OnAfterPrint = "onafterprint";
    const OnBeforePrint = "onbeforeprint";
    const OnBeforeUnload = "onbeforeunload";
    const OnBlur = "onblur";
    const OnCanPlay = "oncanplay";
    const OnCanPlayThrough = "oncanplaythrough";
    const OnChange = "onchange";
    const OnClick = "onclick";
    const OnCopy = "oncopy";
    const OnCut = "oncut";
    const OnDoubleClick = "ondblclick";
    const OnDrag = "ondrag";
    const OnDragEnd = "ondragend";
    const OnDragEnter = "ondragenter";
    const OnDragLeave = "ondragleave";
    const OnDragOver = "ondragover";
    const OnDragStart = "ondragstart";
    const OnDrop = "ondrop";
    const OnDurationChange = "ondurationchange";
    const OnEnded = "onended";
    const OnError = "onerror";
    const OnFocus = "onfocus";
    const OnFocusin = "onfocusin";
    const OnFocusOut = "onfocusout";
    const OnHashChange = "onhashchange";
    const OnInput = "oninput";
    const OnInvalid = "oninvalid";
    const OnKeyDown = "onkeydown";
    const OnKeyPress = "onkeypress";
    const OnKeyUp = "onkeyup";
    const OnLoad = "onload";
    const OnLoadedData = "onloadeddata";
    const OnLoadedMetaData = "onloadedmetadata";
    const OnLoadStart = "onloadstart";
    const OnMouseDown = "onmousedown";
    const OnMouseEnter = "onmouseenter";
    const OnMouseLeave = "onmouseleave";
    const OnMouseMove = "onmousemove";
    const OnMouseOver = "onmouseover";
    const OnMouseOut = "onmouseout";
    const OnMouseUp = "onmouseup";
    const OnOffline = "onoffline";
    const OnOnline = "ononline";
    const OnPageHide = "onpagehide";
    const OnPageShow = "onpageshow";
    const OnPaste = "onpaste";
    const OnPause = "onpause";
    const OnPlay = "onplay";
    const OnPlaying = "onplaying";
    const OnProgress = "onprogress";
    const OnRateChange = "onratechange";
    const OnResize = "onresize";
    const OnReset = "onreset";
    const OnScroll = "onscroll";
    const OnSearch = "onsearch";
    const OnSeeked = "onseeked";
    const OnSeeking = "onseeking";
    const OnSelect = "onselect";
    const OnStalled = "onstalled";
    const OnSubmit = "onsubmit";
    const OnSuspend = "onsuspend";
    const OnTimeUpdate = "ontimeupdate";
    const OnToggle = "ontoggle";
    const OnTouchCancel = "ontouchcancel";
    const OnTouchend = "ontouchend";
    const OnTouchMove = "ontouchmove";
    const OnTouchStart = "ontouchstart";
    const OnUnload = "onunload";
    const OnVolumeChange = "onvolumechange";
    const OnWaiting = "onwaiting";
    const OnWheel = "onwheel";
}

class HtmlEventListener
{
    const Abort = "abort";
    const AfterPrint = "afterprint";
    const BeforePrint = "beforeprint";
    const BeforeUnload = "beforeunload";
    const Blur = "blur";
    const CanPlay = "canplay";
    const CanPlayThrough = "canplaythrough";
    const Change = "change";
    const Click = "click";
    const Copy = "copy";
    const Cut = "cut";
    const DoubleClick = "dblclick";
    const Drag = "drag";
    const DragEnd = "dragend";
    const DragEnter = "dragenter";
    const DragLeave = "dragleave";
    const DragOver = "dragover";
    const DragStart = "dragstart";
    const Drop = "drop";
    const DurationChange = "durationchange";
    const Ended = "ended";
    const Error = "error";
    const Focus = "focus";
    const Focusin = "focusin";
    const FocusOut = "focusout";
    const HashChange = "hashchange";
    const Input = "input";
    const Invalid = "invalid";
    const KeyDown = "keydown";
    const KeyPress = "keypress";
    const KeyUp = "keyup";
    const Load = "load";
    const LoadedData = "loadeddata";
    const LoadedMetaData = "loadedmetadata";
    const LoadStart = "loadstart";
    const MouseDown = "mousedown";
    const MouseEnter = "mouseenter";
    const MouseLeave = "mouseleave";
    const MouseMove = "mousemove";
    const MouseOver = "mouseover";
    const MouseOut = "mouseout";
    const MouseUp = "mouseup";
    const Offline = "offline";
    const Online = "online";
    const PageHide = "pagehide";
    const PageShow = "pageshow";
    const Paste = "paste";
    const Pause = "pause";
    const Play = "play";
    const Playing = "playing";
    const Progress = "progress";
    const RateChange = "ratechange";
    const Resize = "resize";
    const Reset = "reset";
    const Scroll = "scroll";
    const Search = "search";
    const Seeked = "seeked";
    const Seeking = "seeking";
    const Select = "select";
    const Stalled = "stalled";
    const Submit = "submit";
    const Suspend = "suspend";
    const TimeUpdate = "timeupdate";
    const Toggle = "toggle";
    const TouchCancel = "touchcancel";
    const Touchend = "touchend";
    const TouchMove = "touchmove";
    const TouchStart = "touchstart";
    const Unload = "unload";
    const VolumeChange = "volumechange";
    const Waiting = "waiting";
    const Wheel = "wheel";

    const AnimationEnd = "animationend";
    const AnimationIteration = "animationiteration";
    const AnimationStart = "animationstart";
    const ContextMenu = "contextmenu";
    const FullScreenChange = "fullscreenchange";
    const FullScreenError = "fullscreenerror";
    const PopState = "popstate";
    const TransitionEnd = "transitionend";
    const Storage = "storage";

    // Custom
    const ScrollBottom = "scrollbottom";
    const ElementReached = "elementreached";
}

class ExtensionWebFormsMethods
{
    public static function appendPlace($text, $value)
    {
        if (strlen($text) < 1) {
            return $value;
        }

        return $text . "|" . $value;
    }

    public static function appendParent($text)
    {
        return "/" . $text;
    }

    public static function exportActionControlsToWebFormsTag($actionControls, $addLine = false)
    {
        return ($addLine ? "\n" : "") . "<web-forms ac=\"" . $actionControls . "\"></web-forms>";
    }

    public static function exportActionControlsToHtmlComment($actionControls, $addLine = false)
    {
        return ($addLine ? "\n" : "") . "<!--[web-forms]\n" . $actionControls . "-->";
    }

    public static function exportActionControlsToResponse($actionControls)
    {
        return "[web-forms]\n" . $actionControls;
    }

    public static function removeOuter($text, $startString, $endString)
    {
        $start = strpos($text, $startString);
        if ($start === false) {
            return $text;
        }

        $end = strpos($text, $endString, $start);
        if ($end === false) {
            return $text;
        }

        $lengthToRemove = ($end - $start) + strlen($endString);

        return substr($text, 0, $start) . substr($text, $end + strlen($endString));
    }

    public static function lineBreak($text)
    {
        return str_replace("\n", "$[sln]", $text);
    }
}


