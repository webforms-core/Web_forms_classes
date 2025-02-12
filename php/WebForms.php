<?php

// Compatible with WebFormsJS version 1.6

class WebForms
{
    private $webFormsData;

    public function __construct()
    {
        $this->webFormsData = new NameValueCollection();
    }

    // Add
    public function addId($inputPlace, $id)
    {
        $this->webFormsData->add("ai" . $inputPlace, $id);
    }

    public function addName($inputPlace, $name)
    {
        $this->webFormsData->add("an" . $inputPlace, $name);
    }

    public function addValue($inputPlace, $value)
    {
        $this->webFormsData->add("av" . $inputPlace, $value);
    }

    public function addClass($inputPlace, $class)
    {
        $this->webFormsData->add("ac" . $inputPlace, $class);
    }

    public function addStyle($inputPlace, $style)
    {
        $this->webFormsData->add("as" . $inputPlace, $style);
    }

    public function addStyleWithNameValue($inputPlace, $name, $value)
    {
        $this->webFormsData->add("as" . $inputPlace, $name . ':' . $value);
    }

    public function addOptionTag($inputPlace, $text, $value, $selected = false)
    {
        $this->webFormsData->add("ao" . $inputPlace, $value . '|' . $text . ($selected ? '|1' : ''));
    }

    public function addCheckBoxTag($inputPlace, $text, $value, $checked = false)
    {
        $this->webFormsData->add("ak" . $inputPlace, $value . '|' . $text . ($checked ? '|1' : ''));
    }

    public function addTitle($inputPlace, $title)
    {
        $this->webFormsData->add("al" . $inputPlace, $title);
    }

    public function addText($inputPlace, $text)
    {
        $this->webFormsData->add("at" . $inputPlace, str_replace("\n", "$[ln];", $text));
    }

    public function addTextToUp($inputPlace, $text)
    {
        $this->webFormsData->add("pt" . $inputPlace, str_replace("\n", "$[ln];", $text));
    }

    public function addAttribute($inputPlace, $attribute, $value = "")
    {
        $this->webFormsData->add("aa" . $inputPlace, $attribute . '|' . $value);
    }

    public function addTag($inputPlace, $tagName, $id = "")
    {
        $this->webFormsData->add("nt" . $inputPlace, $tagName . (!empty($id) ? '|' . $id : ''));
    }

    public function addTagToUp($inputPlace, $tagName, $id = "")
    {
        $this->webFormsData->add("ut" . $inputPlace, $tagName . (!empty($id) ? '|' . $id : ''));
    }

    public function addTagBefore($inputPlace, $tagName, $id = "")
    {
        $this->webFormsData->add("bt" . $inputPlace, $tagName . (!empty($id) ? '|' . $id : ''));
    }

    public function addTagAfter($inputPlace, $tagName, $id = "")
    {
        $this->webFormsData->add("ft" . $inputPlace, $tagName . (!empty($id) ? '|' . $id : ''));
    }

    // Set
    public function setId($inputPlace, $id)
    {
        $this->webFormsData->add("si" . $inputPlace, $id);
    }

    public function setName($inputPlace, $name)
    {
        $this->webFormsData->add("sn" . $inputPlace, $name);
    }

    public function setValue($inputPlace, $value)
    {
        $this->webFormsData->add("sv" . $inputPlace, $value);
    }

    public function setClass($inputPlace, $class)
    {
        $this->webFormsData->add("sc" . $inputPlace, $class);
    }

    public function setStyle($inputPlace, $style)
    {
        $this->webFormsData->add("ss" . $inputPlace, $style);
    }

    public function setStyleWithNameValue($inputPlace, $name, $value)
    {
        $this->webFormsData->add("ss" . $inputPlace, $name . ':' . $value);
    }

    public function setOptionTag($inputPlace, $text, $value, $selected = false)
    {
        $this->webFormsData->add("so" . $inputPlace, $value . '|' . $text . ($selected ? '|1' : ''));
    }

    public function setChecked($inputPlace, $checked = false)
    {
        $this->webFormsData->add("sk" . $inputPlace, $checked ? "1" : "0");
    }

    public function setCheckBoxTagToList($inputPlace, $text, $value, $checked = false)
    {
        $this->webFormsData->add("sk" . $inputPlace, $value . '|' . $text . ($checked ? '|1' : ''));
    }

    public function setTitle($inputPlace, $title)
    {
        $this->webFormsData->add("sl" . $inputPlace, $title);
    }

    public function setText($inputPlace, $text)
    {
        $this->webFormsData->add("st" . $inputPlace, str_replace("\n", "$[ln];", $text));
    }

    public function setAttribute($inputPlace, $attribute, $value = "")
    {
        $this->webFormsData->add("sa" . $inputPlace, $attribute . (!empty($value) ? '|' . $value : ''));
    }

    public function setWidth($inputPlace, $width)
    {
        $this->webFormsData->add("sw" . $inputPlace, $width);
    }

    public function setHeight($inputPlace, $height)
    {
        $this->webFormsData->add("sh" . $inputPlace, $height);
    }

    // Insert
    public function insertId($inputPlace, $id)
    {
        $this->webFormsData->add("ii" . $inputPlace, $id);
    }

    public function insertName($inputPlace, $name)
    {
        $this->webFormsData->add("in" . $inputPlace, $name);
    }

    public function insertValue($inputPlace, $value)
    {
        $this->webFormsData->add("iv" . $inputPlace, $value);
    }

    public function insertClass($inputPlace, $class)
    {
        $this->webFormsData->add("ic" . $inputPlace, $class);
    }

    public function insertStyle($inputPlace, $style)
    {
        $this->webFormsData->add("is" . $inputPlace, $style);
    }

    public function insertStyleWithNameValue($inputPlace, $name, $value)
    {
        $this->webFormsData->add("is" . $inputPlace, $name . ':' . $value);
    }

    public function insertOptionTag($inputPlace, $text, $value, $selected = false)
    {
        $this->webFormsData->add("io" . $inputPlace, $value . '|' . $text . ($selected ? '|1' : ''));
    }

    public function insertCheckBoxTag($inputPlace, $text, $value, $checked = false)
    {
        $this->webFormsData->add("ik" . $inputPlace, $value . '|' . $text . ($checked ? '|1' : ''));
    }

    public function insertTitle($inputPlace, $title)
    {
        $this->webFormsData->add("il" . $inputPlace, $title);
    }

    public function insertText($inputPlace, $text)
    {
        $this->webFormsData->add("it" . $inputPlace, str_replace("\n", "$[ln];", $text));
    }

    public function insertAttribute($inputPlace, $attribute, $value = "")
    {
        $this->webFormsData->add("ia" . $inputPlace, $attribute . (!empty($value) ? '|' . $value : ''));
    }

    // Delete
    public function deleteId($inputPlace)
    {
        $this->webFormsData->add("di" . $inputPlace, "1");
    }

    public function deleteName($inputPlace)
    {
        $this->webFormsData->add("dn" . $inputPlace, "1");
    }

    public function deleteValue($inputPlace)
    {
        $this->webFormsData->add("dv" . $inputPlace, "1");
    }

    public function deleteClass($inputPlace, $className)
    {
        $this->webFormsData->add("dc" . $inputPlace, $className);
    }

    public function deleteStyle($inputPlace, $styleName)
    {
        $this->webFormsData->add("ds" . $inputPlace, $styleName);
    }

    public function deleteOptionTag($inputPlace, $value)
    {
        $this->webFormsData->add("do" . $inputPlace, $value);
    }

    public function deleteAllOptionTag($inputPlace)
    {
        $this->webFormsData->add("do" . $inputPlace, "*");
    }

    public function deleteCheckBoxTag($inputPlace, $value)
    {
        $this->webFormsData->add("dk" . $inputPlace, $value);
    }

    public function deleteAllCheckBoxTag($inputPlace)
    {
        $this->webFormsData->add("dk" . $inputPlace, "*");
    }

    public function deleteTitle($inputPlace)
    {
        $this->webFormsData->add("dl" . $inputPlace, "1");
    }

    public function deleteText($inputPlace)
    {
        $this->webFormsData->add("dt" . $inputPlace, "1");
    }

    public function deleteAttribute($inputPlace, $attribute)
    {
        $this->webFormsData->add("da" . $inputPlace, $attribute);
    }

    public function delete($inputPlace)
    {
        $this->webFormsData->add("de" . $inputPlace, "1");
    }

    public function deleteParent($inputPlace)
    {
        $this->webFormsData->add("dp" . $inputPlace, "1");
    }

    // Other
    public function setBackgroundColor($inputPlace, $color)
    {
        $this->webFormsData->add("bc" . $inputPlace, $color);
    }

    public function setTextColor($inputPlace, $color)
    {
        $this->webFormsData->add("tc" . $inputPlace, $color);
    }

    public function setFontName($inputPlace, $name)
    {
        $this->webFormsData->add("fn" . $inputPlace, $name);
    }

    public function setFontSize($inputPlace, $size)
    {
        $this->webFormsData->add("fs" . $inputPlace, $size);
    }

    public function setFontBold($inputPlace, $bold)
    {
        $this->webFormsData->add("fb" . $inputPlace, $bold ? "1" : "0");
    }

    public function setVisible($inputPlace, $visible)
    {
        $this->webFormsData->add("vi" . $inputPlace, $visible ? "1" : "0");
    }

    public function setTextAlign($inputPlace, $align)
    {
        $this->webFormsData->add("ta" . $inputPlace, $align);
    }

    public function setReadOnly($inputPlace, $readOnly)
    {
        $this->webFormsData->add("sr" . $inputPlace, $readOnly ? "1" : "0");
    }

    public function setDisabled($inputPlace, $disabled)
    {
        $this->webFormsData->add("sd" . $inputPlace, $disabled ? "1" : "0");
    }

    public function setFocus($inputPlace, $focus)
    {
        $this->webFormsData->add("sf" . $inputPlace, $focus ? "1" : "0");
    }

    public function setMinLength($inputPlace, $length)
    {
        $this->webFormsData->add("mn" . $inputPlace, (string)$length);
    }

    public function setMaxLength($inputPlace, $length)
    {
        $this->webFormsData->add("mx" . $inputPlace, (string)$length);
    }

    public function setSelectedValue($inputPlace, $value)
    {
        $this->webFormsData->add("ts" . $inputPlace, $value);
    }

    public function setSelectedIndex($inputPlace, $index)
    {
        $this->webFormsData->add("ti" . $inputPlace, (string)$index);
    }

    public function setCheckedValue($inputPlace, $value, $selected)
    {
        $this->webFormsData->add("ks" . $inputPlace, $value . "|" . ($selected ? "1" : "0"));
    }

    public function setCheckedIndex($inputPlace, $index, $selected)
    {
        $this->webFormsData->add("ki" . $inputPlace, $index . "|" . ($selected ? "1" : "0"));
    }

    public function callScript($scriptText)
    {
        $this->webFormsData->add("_", str_replace("\n", "$[ln];", $scriptText));
    }

    public function loadUrl($inputPlace, $url)
    {
        $this->webFormsData->add("lu" . $inputPlace, $url);
    }

    public function changeUrl($url)
    {
        $this->webFormsData->add("cu", $url);
    }

    public function removeSessionCache($cacheKey)
    {
        $this->webFormsData->add("rs", $cacheKey);
    }

    public function removeAllSessionCache()
    {
        $this->webFormsData->add("rs", "*");
    }

    public function removeCache($cacheKey)
    {
        $this->webFormsData->add("rd", $cacheKey);
    }

    public function removeAllCache()
    {
        $this->webFormsData->add("rd", "*");
    }

    public function setSessionCache()
    {
        $this->webFormsData->add("cs", "1");
    }

    public function setCache($second)
    {
        $this->webFormsData->add("cd", $second);
    }

    public function setCacheNoTime()
    {
        $this->webFormsData->add("cd", "*");
    }

    // Increase
    public function increaseMinLength($inputPlace, $value)
    {
        $this->webFormsData->add("+n" . $inputPlace, (string)$value);
    }

    public function increaseMaxLength($inputPlace, $value)
    {
        $this->webFormsData->add("+x" . $inputPlace, (string)$value);
    }

    public function increaseFontSize($inputPlace, $value)
    {
        $this->webFormsData->add("+f" . $inputPlace, (string)$value);
    }

    public function increaseWidth($inputPlace, $value)
    {
        $this->webFormsData->add("+w" . $inputPlace, (string)$value);
    }

    public function increaseHeight($inputPlace, $value)
    {
        $this->webFormsData->add("+h" . $inputPlace, (string)$value);
    }

    public function increaseValue($inputPlace, $value)
    {
        $this->webFormsData->add("+v" . $inputPlace, (string)$value);
    }

    // Decrease
    public function decreaseMinLength($inputPlace, $value)
    {
        $this->webFormsData->add("-n" . $inputPlace, (string)$value);
    }

    public function decreaseMaxLength($inputPlace, $value)
    {
        $this->webFormsData->add("-x" . $inputPlace, (string)$value);
    }

    public function decreaseFontSize($inputPlace, $value)
    {
        $this->webFormsData->add("-f" . $inputPlace, (string)$value);
    }

    public function decreaseWidth($inputPlace, $value)
    {
        $this->webFormsData->add("-w" . $inputPlace, (string)$value);
    }

    public function decreaseHeight($inputPlace, $value)
    {
        $this->webFormsData->add("-h" . $inputPlace, (string)$value);
    }

    public function decreaseValue($inputPlace, $value)
    {
        $this->webFormsData->add("-v" . $inputPlace, (string)$value);
    }

    // Event
    public function setPostEvent($inputPlace, $htmlEvent)
    {
        $this->webFormsData->add("Ep" . $inputPlace, $htmlEvent);
    }

    public function setPostEventAdding($inputPlace, $htmlEvent)
    {
        $this->webFormsData->add("Ep" . $inputPlace, $htmlEvent . "|+");
    }

    public function setPostEventTo($inputPlace, $htmlEvent, $outputPlace)
    {
        $this->webFormsData->add("Ep" . $inputPlace, $htmlEvent . "|" . $outputPlace);
    }

    public function setPostEventListener($inputPlace, $htmlEventListener)
    {
        $this->webFormsData->add("EP" . $inputPlace, $htmlEventListener);
    }

    public function setPostEventListenerAdding($inputPlace, $htmlEventListener)
    {
        $this->webFormsData->add("EP" . $inputPlace, $htmlEventListener . "|+");
    }

    public function setPostEventListenerTo($inputPlace, $htmlEventListener, $outputPlace)
    {
        $this->webFormsData->add("EP" . $inputPlace, $htmlEventListener . "|" . $outputPlace);
    }

    public function setGetEvent($inputPlace, $htmlEvent, $path = null)
    {
        $this->webFormsData->add("Eg" . $inputPlace, $htmlEvent . "|" . ($path ? $path : "#"));
    }

    public function setGetEventWithOutputPlace($inputPlace, $htmlEvent, $outputPlace, $path = null)
    {
        $this->webFormsData->add("Eg" . $inputPlace, $htmlEvent . "|" . ($path ? $path : "#") . "|" . $outputPlace);
    }

    public function setGetEventInForm($inputPlace, $htmlEvent)
    {
        $this->webFormsData->add("Eg" . $inputPlace, $htmlEvent);
    }

    public function setGetEventInFormWithOutputPlace($inputPlace, $htmlEvent, $outputPlace)
    {
        $this->webFormsData->add("Eg" . $inputPlace, $htmlEvent . "|" . $outputPlace);
    }

    public function setGetEventListener($inputPlace, $htmlEventListener, $path = null)
    {
        $this->webFormsData->add("EG" . $inputPlace, $htmlEventListener . "|" . ($path ? $path : "#"));
    }

    public function setGetEventListenerWithOutputPlace($inputPlace, $htmlEventListener, $outputPlace, $path = null)
    {
        $this->webFormsData->add("EG" . $inputPlace, $htmlEventListener . "|" . ($path ? $path : "#") . "|" . $outputPlace);
    }

    public function setGetEventInFormListener($inputPlace, $htmlEventListener)
    {
        $this->webFormsData->add("EG" . $inputPlace, $htmlEventListener);
    }

    public function setGetEventInFormListenerWithOutputPlace($inputPlace, $htmlEventListener, $outputPlace)
    {
        $this->webFormsData->add("EG" . $inputPlace, $htmlEventListener . "|" . $outputPlace);
    }

    public function setTagEvent($inputPlace, $htmlEvent, $outputPlace)
    {
        $this->webFormsData->add("Et" . $inputPlace, $htmlEvent . "|" . $outputPlace);
    }

    public function setTagEventListener($inputPlace, $htmlEvent, $outputPlace)
    {
        $this->webFormsData->add("ET" . $inputPlace, $htmlEvent . "|" . $outputPlace);
    }

    public function removePostEvent($inputPlace, $htmlEvent)
    {
        $this->webFormsData->add("Rp" . $inputPlace, $htmlEvent);
    }

    public function removeGetEvent($inputPlace, $htmlEvent)
    {
        $this->webFormsData->add("Rg" . $inputPlace, $htmlEvent);
    }

    public function removeTagEvent($inputPlace, $htmlEvent)
    {
        $this->webFormsData->add("Rt" . $inputPlace, $htmlEvent);
    }

    public function removePostEventListener($inputPlace, $htmlEventListener)
    {
        $this->webFormsData->add("RP" . $inputPlace, $htmlEventListener);
    }

    public function removeGetEventListener($inputPlace, $htmlEventListener)
    {
        $this->webFormsData->add("RG" . $inputPlace, $htmlEventListener);
    }

    public function removeTagEventListener($inputPlace, $htmlEventListener)
    {
        $this->webFormsData->add("RT" . $inputPlace, $htmlEventListener);
    }

    // Save
    public function saveId($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@gi" . $inputPlace, $key);
    }

    public function saveName($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@gn" . $inputPlace, $key);
    }

    public function saveValue($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@gv" . $inputPlace, $key);
    }

    public function saveValueLength($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@ge" . $inputPlace, $key);
    }

    public function saveClass($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@gc" . $inputPlace, $key);
    }

    public function saveStyle($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@gs" . $inputPlace, $key);
    }

    public function saveTitle($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@gl" . $inputPlace, $key);
    }

    public function saveText($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@gt" . $inputPlace, $key);
    }

    public function saveTextLength($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@gg" . $inputPlace, $key);
    }

    public function saveAttribute($inputPlace, $attribute, $key = ".")
    {
        $this->webFormsData->add("@ga" . $inputPlace, $key . '|' . $attribute);
    }

    public function saveWidth($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@gw" . $inputPlace, $key);
    }

    public function saveHeight($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@gh" . $inputPlace, $key);
    }

    public function saveReadOnly($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@gr" . $inputPlace, $key);
    }

    public function saveSelectedIndex($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@gx" . $inputPlace, $key);
    }

    public function saveTextAlign($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@ta" . $inputPlace, $key);
    }

    public function saveNodeLength($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@nl" . $inputPlace, $key);
    }

    public function saveVisible($inputPlace, $key = ".")
    {
        $this->webFormsData->add("@vi" . $inputPlace, $key);
    }

    // Pre Runner
	public function assignDelay($second, $index = -1)
    {
        $currentName = $this->webFormsData->getNameByIndex($index);

        if (empty($currentName)) {
            return;
        }

        $this->webFormsData->changeNameByIndex($index, ":" . $second . ")" . $currentName);
    }

    public function assignDelayChange($second, $index = -1)
    {
        $currentName = $this->webFormsData->getNameByIndex($index);

        if (empty($currentName)) {
            return;
        }

        $currentName = $this->removeOuter($currentName, ":", ")");
        $this->webFormsData->changeNameByIndex($index, ":" . $second . ")" . $currentName);
    }

    public function assignInterval($second, $index = -1)
    {
        $currentName = $this->webFormsData->getNameByIndex($index);

        if (empty($currentName)) {
            return;
        }

        $this->webFormsData->changeNameByIndex($index, "(" . $second . ")" . $currentName);
    }

    public function assignIntervalChange($second, $index = -1)
    {
        $currentName = $this->webFormsData->getNameByIndex($index);

        if (empty($currentName)) {
            return;
        }

        $currentName = $this->removeOuter($currentName, "(", ")");
        $this->webFormsData->changeNameByIndex($index, "(" . $second . ")" . $currentName);
    }

    // Index
    public function startIndex($name = "")
    {
        $this->webFormsData->add("#", $name);
    }

    // Get
    public function getFormsActionData()
    {
        $returnValue = "";

        $webFormsDataList = $this->webFormsData->getList();

        foreach ($webFormsDataList as $nv) {
            $returnValue .= PHP_EOL . $nv->name;

            if (!empty($nv->value)) {
                $returnValue .= "=" . $nv->value;
            }
        }

        return $returnValue;
    }

    public function response()
    {
        return "[web-forms]" . $this->getFormsActionData();
    }

    public function getFormsActionDataLineBreak()
    {
        $returnValue = "";

        $webFormsDataList = $this->webFormsData->getList();

        $i = count($webFormsDataList);
        foreach ($webFormsDataList as $nv) {
            $returnValue .= $nv->name;

            if (!empty($nv->value)) {
                $returnValue .= "=" . str_replace("\"", "$[dq];", $nv->value);
            }

            if ($i-- > 1) {
                $returnValue .= "$[sln];";
            }
        }

        return $returnValue;
    }

    // Export
    public function exportToWebFormsTag($src = null)
    {
        return "<web-forms ac=\"" . $this->getFormsActionDataLineBreak() . "\"" . (!empty($src) ? " src=\"" . $src . "\"" : "") . "></web-forms>";
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

    public function exportToNameValue()
    {
        return $this->webFormsData;
    }

    public function appendForm(WebForms $form)
    {
        foreach ($form->exportToNameValue() as $name => $value) {
            $this->webFormsData->addList($name, $value);
        }
    }

    public function setHeaders($context)
    {
        $context->response->headers->set("Content-Type", "text/plain");
    }

    public function clean()
    {
        $this->webFormsData = new NameValueCollection();
    }
}

class InputPlace
{
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

class OutputPlace extends InputPlace { }

class Fetch
{
    public static function random($maxValue)
    {
        return "@mr" . $maxValue;
    }

    public static function randomRange($minValue, $maxValue)
    {
        return "@mr" . $maxValue . "," . $minValue;
    }

    public static $dateYear = "@dy";
    public static $dateMonth = "@dm";
    public static $dateDay = "@dd";
    public static $dateHours = "@dh";
    public static $dateMinutes = "@di";
    public static $dateSeconds = "@ds";
    public static $dateMilliseconds = "@dl";

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

    public static function sessionAndRemoveWithReplace($key, $replaceValue)
    {
        return "@cl" . $key . "," . $replaceValue;
    }

    public static function saved($key = ".")
    {
        return "@cl" . $key;
    }

    public static function cache($key)
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

    public static function cacheAndRemoveWithReplace($key, $replaceValue)
    {
        return "@ct" . $key . "," . $replaceValue;
    }

    public static function script($scriptText)
    {
        return "@_" . str_replace("\n", "$[ln];", $scriptText);
    }
}

class HtmlEvent
{
    public static $onAbort = "onabort";
    public static $onAfterPrint = "onafterprint";
    public static $onBeforePrint = "onbeforeprint";
    public static $onBeforeUnload = "onbeforeunload";
    public static $onBlur = "onblur";
    public static $onCanPlay = "oncanplay";
    public static $onCanPlayThrough = "oncanplaythrough";
    public static $onChange = "onchange";
    public static $onClick = "onclick";
    public static $onCopy = "oncopy";
    public static $onCut = "oncut";
    public static $onDoubleClick = "ondblclick";
    public static $onDrag = "ondrag";
    public static $onDragEnd = "ondragend";
    public static $onDragEnter = "ondragenter";
    public static $onDragLeave = "ondragleave";
    public static $onDragOver = "ondragover";
    public static $onDragStart = "ondragstart";
    public static $onDrop = "ondrop";
    public static $onDurationChange = "ondurationchange";
    public static $onEnded = "onended";
    public static $onError = "onerror";
    public static $onFocus = "onfocus";
    public static $onFocusin = "onfocusin";
    public static $onFocusOut = "onfocusout";
    public static $onHashChange = "onhashchange";
    public static $onInput = "oninput";
    public static $onInvalid = "oninvalid";
    public static $onKeyDown = "onkeydown";
    public static $onKeyPress = "onkeypress";
    public static $onKeyUp = "onkeyup";
    public static $onLoad = "onload";
    public static $onLoadedData = "onloadeddata";
    public static $onLoadedMetaData = "onloadedmetadata";
    public static $onLoadStart = "onloadstart";
    public static $onMouseDown = "onmousedown";
    public static $onMouseEnter = "onmouseenter";
    public static $onMouseLeave = "onmouseleave";
    public static $onMouseMove = "onmousemove";
    public static $onMouseOver = "onmouseover";
    public static $onMouseOut = "onmouseout";
    public static $onMouseUp = "onmouseup";
    public static $onOffline = "onoffline";
    public static $onOnline = "ononline";
    public static $onPageHide = "onpagehide";
    public static $onPageShow = "onpageshow";
    public static $onPaste = "onpaste";
    public static $onPause = "onpause";
    public static $onPlay = "onplay";
    public static $onPlaying = "onplaying";
    public static $onProgress = "onprogress";
    public static $onRateChange = "onratechange";
    public static $onResize = "onresize";
    public static $onReset = "onreset";
    public static $onScroll = "onscroll";
    public static $onSearch = "onsearch";
    public static $onSeeked = "onseeked";
    public static $onSeeking = "onseeking";
    public static $onSelect = "onselect";
    public static $onStalled = "onstalled";
    public static $onSubmit = "onsubmit";
    public static $onSuspend = "onsuspend";
    public static $onTimeUpdate = "ontimeupdate";
    public static $onToggle = "ontoggle";
    public static $onTouchCancel = "ontouchcancel";
    public static $onTouchend = "ontouchend";
    public static $onTouchMove = "ontouchmove";
    public static $onTouchStart = "ontouchstart";
    public static $onUnload = "onunload";
    public static $onVolumeChange = "onvolumechange";
    public static $onWaiting = "onwaiting";
}

class HtmlEventListener
{
    public static $abort = "abort";
    public static $afterPrint = "afterprint";
    public static $beforePrint = "beforeprint";
    public static $beforeUnload = "beforeunload";
    public static $blur = "blur";
    public static $canPlay = "canplay";
    public static $canPlayThrough = "canplaythrough";
    public static $change = "change";
    public static $click = "click";
    public static $copy = "copy";
    public static $cut = "cut";
    public static $doubleClick = "dblclick";
    public static $drag = "drag";
    public static $dragEnd = "dragend";
    public static $dragEnter = "dragenter";
    public static $dragLeave = "dragleave";
    public static $dragOver = "dragover";
    public static $dragStart = "dragstart";
    public static $drop = "drop";
    public static $durationChange = "durationchange";
    public static $ended = "ended";
    public static $error = "error";
    public static $focus = "focus";
    public static $focusIn = "focusin";
    public static $focusOut = "focusout";
    public static $hashChange = "hashchange";
    public static $input = "input";
    public static $invalid = "invalid";
    public static $keyDown = "keydown";
    public static $keyPress = "keypress";
    public static $keyUp = "keyup";
    public static $load = "load";
    public static $loadedData = "loadeddata";
    public static $loadedMetaData = "loadedmetadata";
    public static $loadStart = "loadstart";
    public static $mouseDown = "mousedown";
    public static $mouseEnter = "mouseenter";
    public static $mouseLeave = "mouseleave";
    public static $mouseMove = "mousemove";
    public static $mouseOver = "mouseover";
    public static $mouseOut = "mouseout";
    public static $mouseUp = "mouseup";
    public static $offline = "offline";
    public static $online = "online";
    public static $pageHide = "pagehide";
    public static $pageShow = "pageshow";
    public static $paste = "paste";
    public static $pause = "pause";
    public static $play = "play";
    public static $playing = "playing";
    public static $progress = "progress";
    public static $rateChange = "ratechange";
    public static $resize = "resize";
    public static $reset = "reset";
    public static $scroll = "scroll";
    public static $search = "search";
    public static $seeked = "seeked";
    public static $seeking = "seeking";
    public static $select = "select";
    public static $stalled = "stalled";
    public static $submit = "submit";
    public static $suspend = "suspend";
    public static $timeUpdate = "timeupdate";
    public static $toggle = "toggle";
    public static $touchCancel = "touchcancel";
    public static $touchEnd = "touchend";
    public static $touchMove = "touchmove";
    public static $touchStart = "touchstart";
    public static $unload = "unload";
    public static $volumeChange = "volumechange";
    public static $waiting = "waiting";

    public static $animationEnd = "animationend";
    public static $animationIteration = "animationiteration";
    public static $animationStart = "animationstart";
    public static $contextMenu = "contextmenu";
    public static $fullScreenChange = "fullscreenchange";
    public static $fullScreenError = "fullscreenerror";
    public static $popState = "popstate";
    public static $transitionEnd = "transitionend";
    public static $storage = "storage";
    public static $wheel = "wheel";
}

class ExtensionWebFormsMethods
{
    /**
     * This Method Does Not Support QueryAll
     */
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

    public static function exportToWebFormsTag($src)
    {
        return '<web-forms src="' . $src . '"></web-forms>';
    }

    // Overload
    public static function exportToWebFormsTagWithDimensions($src, $width, $height)
    {
        return '<web-forms src="' . $src . '" width="' . $width . '" height="' . $height . '"></web-forms>';
    }

    public static function exportActionControlsToWebFormsTag($actionControls)
    {
        return '<web-forms ac="' . $actionControls . '"></web-forms>';
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
}

class NameValue
{
    public $name;
    public $value;

    public function __construct($name = "", $value = "")
    {
        $this->name = $name;
        $this->value = $value;
    }
}

class NameValueCollection
{
    private $nameValueList = [];

    public function add($name, $value)
    {
        $this->nameValueList[] = new NameValue($name, $value);
    }

    public function set($name, $value)
    {
        if (!$this->exist($name)) {
            $this->add($name, $value);
        } else {
            $this->changeValue($name, $value);
        }
    }

    public function delete($name)
    {
        $this->nameValueList = array_filter($this->nameValueList, function ($nv) use ($name) {
            return $nv->name !== $name;
        });
    }

    public function deleteByIndex($index)
    {
        if ($index < 0) {
            $index = count($this->nameValueList) + $index;
        }

        if (isset($this->nameValueList[$index])) {
            array_splice($this->nameValueList, $index, 1);
        }
    }

    public function setEmpty()
    {
        $this->nameValueList = [];
    }

    public function exist($name)
    {
        foreach ($this->nameValueList as $nv) {
            if ($nv->name === $name) {
                return true;
            }
        }

        return false;
    }

    public function changeValue($name, $value)
    {
        foreach ($this->nameValueList as $nv) {
            if ($nv->name === $name) {
                $nv->value = $value;
                break;
            }
        }
    }

    public function changeName($name, $newName)
    {
        foreach ($this->nameValueList as $nv) {
            if ($nv->name === $name) {
                $nv->name = $newName;
                break;
            }
        }
    }

    // Overload
    public function changeValueByName($name, $newName, $value)
    {
        foreach ($this->nameValueList as $nv) {
            if ($nv->name === $name) {
                $nv->name = $newName;
                $nv->value = $value;
                break;
            }
        }
    }

    public function changeValueByIndex($index, $value)
    {
        if ($index < 0) {
            $index = count($this->nameValueList) + $index;
        }

        if (isset($this->nameValueList[$index])) {
            $this->nameValueList[$index]->value = $value;
        }
    }

    public function changeNameByIndex($index, $name)
    {
        if ($index < 0) {
            $index = count($this->nameValueList) + $index;
        }

        if (isset($this->nameValueList[$index])) {
            $this->nameValueList[$index]->name = $name;
        }
    }

    public function changeNameValueByIndex($index, $name, $value)
    {
        if ($index < 0) {
            $index = count($this->nameValueList) + $index;
        }

        if (isset($this->nameValueList[$index])) {
            $this->nameValueList[$index]->name = $name;
            $this->nameValueList[$index]->value = $value;
        }
    }

    public function addList($nameValueList)
    {
        foreach ($nameValueList as $nv) {
            $this->nameValueList[] = $nv;
        }
    }

    public function getValue($name)
    {
        foreach ($this->nameValueList as $nv) {
            if ($nv->name === $name) {
                return $nv->value;
            }
        }

        return "";
    }

    public function getNameByIndex($index)
    {
        if ($index < 0) {
            $index = count($this->nameValueList) + $index;
        }

        if (isset($this->nameValueList[$index])) {
            return $this->nameValueList[$index]->name;
        }

        return "";
    }

    public function getValueByIndex($index)
    {
        if ($index < 0) {
            $index = count($this->nameValueList) + $index;
        }

        if (isset($this->nameValueList[$index])) {
            return $this->nameValueList[$index]->value;
        }

        return "";
    }

    public function getList()
    {
        return $this->nameValueList;
    }
}
