<?php

// WebForms.php 2.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.1

namespace WebFormsCore;

class WebForms
{
    private const GS = "\x1D";  // (char)29
    private const US = "\x1F";  // (char)31

    private string $webFormsData = '';

    private function add(string $Name, ?string $Value = null): void
    {
        if (strlen($this->webFormsData) > 0) {
            $this->webFormsData .= "\n";
        }

        $this->webFormsData .= $Name;
        if ($Value !== null) {
            $this->webFormsData .= '=' . $Value;
        }
    }

    private function addToUp(string $name, ?string $value = null): void
    {
        $line = $name . ($value !== null ? '=' . $value : '');
        if (strlen($this->webFormsData) > 0) {
            $line .= "\n";
        }
        $this->webFormsData = $line . $this->webFormsData;
    }

    private function getLineByIndex(int $Index): string
    {
        if (strlen($this->webFormsData) === 0) {
            return '';
        }

        $lines = explode("\n", $this->webFormsData);

        if ($Index < 0) {
            $Index = count($lines) + $Index;
        }

        if ($Index < 0 || $Index >= count($lines)) {
            return '';
        }

        return $lines[$Index];
    }

    private function updateLineByIndex(int $Index, string $Name, ?string $Value = null): void
    {
        if (strlen($this->webFormsData) === 0) {
            return;
        }

        $lines = explode("\n", $this->webFormsData);

        if ($Index < 0) {
            $Index = count($lines) + $Index;
        }

        if ($Index < 0 || $Index >= count($lines)) {
            return;
        }

        $lines[$Index] = $Name . (($Value !== null && $Value !== '') ? '=' . $Value : '');

        $this->webFormsData = implode("\n", $lines);
    }

    // For Extension
    public function addLine(string $Name, string $Value): void
    {
        $this->add($Name, $Value);
    }

    // Add
    // Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.
    public function addId(string $InputPlace, string $Id): void
    {
        $this->add('ai' . $InputPlace, $Id);
    }

    public function addName(string $InputPlace, string $Name): void
    {
        $this->add('an' . $InputPlace, $Name);
    }

    public function addValue(string $InputPlace, string $Value): void
    {
        $this->add('av' . $InputPlace, $Value);
    }

    public function addClass(string $InputPlace, string $Class): void
    {
        $this->add('ac' . $InputPlace, $Class);
    }

    public function addStyle(string $InputPlace, string $Style): void
    {
        $this->add('as' . $InputPlace, $Style);
    }

    public function addStyleNameValue(string $InputPlace, string $Name, string $Value): void
    {
        $this->add('as' . $InputPlace, $Name . ':' . $Value);
    }

    public function addOptionTag(string $InputPlace, string $Text, string $Value, bool $Selected = false): void
    {
        $this->add('ao' . $InputPlace, $Value . self::GS . $Text . ($Selected ? self::GS . '1' : ''));
    }

    public function addCheckBoxTag(string $InputPlace, string $Text, string $Value, bool $Checked = false): void
    {
        $this->add('ak' . $InputPlace, $Value . self::GS . $Text . ($Checked ? self::GS . '1' : ''));
    }

    public function addTitle(string $InputPlace, string $Title): void
    {
        $this->add('al' . $InputPlace, $Title);
    }

    public function addLabel(string $InputPlace, string $Label): void
    {
        $this->add('aA' . $InputPlace, $Label);
    }

    public function addText(string $InputPlace, string $Text): void
    {
        $this->add('at' . $InputPlace, str_replace("\n", '$[ln];', $Text));
    }

    public function addTextToUp(string $InputPlace, string $Text): void
    {
        $this->add('pt' . $InputPlace, str_replace("\n", '$[ln];', $Text));
    }

    public function addAttribute(string $InputPlace, string $Attribute, string $Value = '', string $Splitter = ''): void
    {
        $this->add('aa' . $InputPlace, $Attribute . self::GS . ($Splitter !== '' ? $Splitter : '') . ($Value !== '' ? self::GS . $Value : ''));
    }

    public function addTag(string $InputPlace, string $TagName, string $Id = ''): void
    {
        $this->add('nt' . $InputPlace, $TagName . ($Id !== '' ? self::GS . $Id : ''));
    }

    public function addTagToUp(string $InputPlace, string $TagName, string $Id = ''): void
    {
        $this->add('ut' . $InputPlace, $TagName . ($Id !== '' ? self::GS . $Id : ''));
    }

    public function addTagBefore(string $InputPlace, string $TagName, string $Id = ''): void
    {
        $this->add('bt' . $InputPlace, $TagName . ($Id !== '' ? self::GS . $Id : ''));
    }

    public function addTagAfter(string $InputPlace, string $TagName, string $Id = ''): void
    {
        $this->add('ft' . $InputPlace, $TagName . ($Id !== '' ? self::GS . $Id : ''));
    }

    public function addHidden(string $InputPlace, string $Name, string $Value, string $Id = ''): void
    {
        $this->add('ah' . $InputPlace, $Name . self::GS . $Value . ($Id !== '' ? self::GS . $Id : ''));
    }

    // Set
    // Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.
    public function setId(string $InputPlace, string $Id): void
    {
        $this->add('si' . $InputPlace, $Id);
    }

    public function setName(string $InputPlace, string $Name): void
    {
        $this->add('sn' . $InputPlace, $Name);
    }

    public function setValue(string $InputPlace, string $Value): void
    {
        $this->add('sv' . $InputPlace, $Value);
    }

    public function setClass(string $InputPlace, string $Class): void
    {
        $this->add('sc' . $InputPlace, $Class);
    }

    public function setStyle(string $InputPlace, string $Style): void
    {
        $this->add('ss' . $InputPlace, $Style);
    }

    public function setStyleNameValue(string $InputPlace, string $Name, string $Value): void
    {
        $this->add('ss' . $InputPlace, $Name . ':' . $Value);
    }

    public function setOptionTag(string $InputPlace, string $Text, string $Value, bool $Selected = false): void
    {
        $this->add('so' . $InputPlace, $Value . self::GS . $Text . ($Selected ? self::GS . '1' : ''));
    }

    public function setChecked(string $InputPlace, bool $Checked = false): void
    {
        $this->add('sk' . $InputPlace, $Checked ? '1' : '0');
    }

    public function setCheckBoxTag(string $InputPlace, string $Text, string $Value, bool $Checked = false): void
    {
        $this->add('sk' . $InputPlace, $Value . self::GS . $Text . ($Checked ? self::GS . '1' : ''));
    }

    public function setTitle(string $InputPlace, string $Title): void
    {
        $this->add('sl' . $InputPlace, $Title);
    }

    public function setLabel(string $InputPlace, string $Label): void
    {
        $this->add('sA' . $InputPlace, $Label);
    }

    public function setText(string $InputPlace, string $Text): void
    {
        $this->add('st' . $InputPlace, str_replace("\n", '$[ln];', $Text));
    }

    public function setAttribute(string $InputPlace, string $Attribute, string $Value = ''): void
    {
        $this->add('sa' . $InputPlace, $Attribute . self::GS . ($Value !== '' ? self::GS . $Value : ''));
    }

    public function setWidth(string $InputPlace, string $Width): void
    {
        $this->add('sw' . $InputPlace, $Width);
    }

    public function setWidthPx(string $InputPlace, int $Width): void
    {
        $this->setWidth($InputPlace, $Width . 'px');
    }

    public function setHeight(string $InputPlace, string $Height): void
    {
        $this->add('sh' . $InputPlace, $Height);
    }

    public function setHeightPx(string $InputPlace, int $Height): void
    {
        $this->setHeight($InputPlace, $Height . 'px');
    }

    public function setBackgroundColor(string $InputPlace, string $Color): void
    {
        $this->add('bc' . $InputPlace, $Color);
    }

    public function setTextColor(string $InputPlace, string $Color): void
    {
        $this->add('tc' . $InputPlace, $Color);
    }

    public function setFontName(string $InputPlace, string $Name): void
    {
        $this->add('fn' . $InputPlace, $Name);
    }

    public function setFontSize(string $InputPlace, string $Size): void
    {
        $this->add('fs' . $InputPlace, $Size);
    }

    public function setFontSizePx(string $InputPlace, int $Size): void
    {
        $this->add('fs' . $InputPlace, $Size . 'px');
    }

    public function setFontBold(string $InputPlace, bool $Bold): void
    {
        $this->add('fb' . $InputPlace, $Bold ? '1' : '0');
    }

    public function setVisible(string $InputPlace, bool $Visible): void
    {
        $this->add('vi' . $InputPlace, $Visible ? '1' : '0');
    }

    public function setTextAlign(string $InputPlace, string $Align): void
    {
        $this->add('ta' . $InputPlace, $Align);
    }

    public function setReadOnly(string $InputPlace, bool $ReadOnly): void
    {
        $this->add('sr' . $InputPlace, $ReadOnly ? '1' : '0');
    }

    public function setDisabled(string $InputPlace, bool $Disabled): void
    {
        $this->add('sd' . $InputPlace, $Disabled ? '1' : '0');
    }

    public function setFocus(string $InputPlace, bool $Focus): void
    {
        $this->add('sf' . $InputPlace, $Focus ? '1' : '0');
    }

    public function setMinLength(string $InputPlace, string $Length): void
    {
        $this->add('mn' . $InputPlace, $Length);
    }

    public function setMinLengthInt(string $InputPlace, int $Length): void
    {
        $this->setMinLength($InputPlace, (string)$Length);
    }

    public function setMaxLength(string $InputPlace, string $Length): void
    {
        $this->add('mx' . $InputPlace, $Length);
    }

	public function setMaxLengthInt(string $InputPlace, int $Length): void
	{
		$this->setMaxLength($InputPlace, (string)$Length);
	}

    public function setSelectedValue(string $InputPlace, string $Value): void
    {
        $this->add('ts' . $InputPlace, $Value);
    }

    public function setSelectedIndex(string $InputPlace, string $Index): void
    {
        $this->add('ti' . $InputPlace, $Index);
    }

    public function setSelectedIndexInt(string $InputPlace, int $Index): void
    {
        $this->setSelectedIndex($InputPlace, (string)$Index);
    }

    public function setCheckedValue(string $InputPlace, string $Value, bool $Checked): void
    {
        $this->add('ks' . $InputPlace, $Value . self::GS . ($Checked ? '1' : '0'));
    }

    public function setCheckedIndex(string $InputPlace, string $Index, bool $Checked): void
    {
        $this->add('ki' . $InputPlace, $Index . self::GS . ($Checked ? '1' : '0'));
    }

    public function setCheckedIndexInt(string $InputPlace, int $Index, bool $Checked): void
    {
        $this->setCheckedIndex($InputPlace, (string)$Index, $Checked);
    }

    // Insert
    // Creates the Data only if it does not exist; otherwise, does nothing.
    public function insertId(string $InputPlace, string $Id): void
    {
        $this->add('ii' . $InputPlace, $Id);
    }

    public function insertName(string $InputPlace, string $Name): void
    {
        $this->add('in' . $InputPlace, $Name);
    }

    public function insertValue(string $InputPlace, string $Value): void
    {
        $this->add('iv' . $InputPlace, $Value);
    }

    public function insertClass(string $InputPlace, string $Class): void
    {
        $this->add('ic' . $InputPlace, $Class);
    }

    public function insertStyle(string $InputPlace, string $Style): void
    {
        $this->add('is' . $InputPlace, $Style);
    }

    public function insertStyleNameValue(string $InputPlace, string $Name, string $Value): void
    {
        $this->add('is' . $InputPlace, $Name . ':' . $Value);
    }

    public function insertOptionTag(string $InputPlace, string $Text, string $Value, bool $Selected = false): void
    {
        $this->add('io' . $InputPlace, $Value . self::GS . $Text . ($Selected ? self::GS . '1' : ''));
    }

    public function insertCheckBoxTag(string $InputPlace, string $Text, string $Value, bool $Checked = false): void
    {
        $this->add('ik' . $InputPlace, $Value . self::GS . $Text . ($Checked ? self::GS . '1' : ''));
    }

    public function insertTitle(string $InputPlace, string $Title): void
    {
        $this->add('il' . $InputPlace, $Title);
    }

    public function insertLabel(string $InputPlace, string $Label): void
    {
        $this->add('iA' . $InputPlace, $Label);
    }

    public function insertText(string $InputPlace, string $Text): void
    {
        $this->add('it' . $InputPlace, str_replace("\n", '$[ln];', $Text));
    }

    public function insertAttribute(string $InputPlace, string $Attribute, string $Value = '', string $Splitter = ''): void
    {
        $this->add('ia' . $InputPlace, $Attribute . self::GS . ($Splitter !== '' ? $Splitter : '') . ($Value !== '' ? self::GS . $Value : ''));
    }

    // Delete
    public function deleteId(string $InputPlace): void
    {
        $this->add('di' . $InputPlace);
    }

    public function deleteName(string $InputPlace): void
    {
        $this->add('dn' . $InputPlace);
    }

    public function deleteValue(string $InputPlace): void
    {
        $this->add('dv' . $InputPlace);
    }

    public function deleteClass(string $InputPlace, string $ClassName): void
    {
        $this->add('dc' . $InputPlace, $ClassName);
    }

    public function deleteStyle(string $InputPlace, string $StyleName): void
    {
        $this->add('ds' . $InputPlace, $StyleName);
    }

    public function deleteOptionTag(string $InputPlace, string $Value): void
    {
        $this->add('do' . $InputPlace, $Value);
    }

    public function deleteAllOptionTag(string $InputPlace): void
    {
        $this->add('do' . $InputPlace, '*');
    }

    public function deleteCheckBoxTag(string $InputPlace, string $Value): void
    {
        $this->add('dk' . $InputPlace, $Value);
    }

    public function deleteAllCheckBoxTag(string $InputPlace): void
    {
        $this->add('dk' . $InputPlace, '*');
    }

    public function deleteTitle(string $InputPlace): void
    {
        $this->add('dl' . $InputPlace);
    }

    public function deleteLabel(string $InputPlace): void
    {
        $this->add('dA' . $InputPlace);
    }

    public function deleteText(string $InputPlace): void
    {
        $this->add('dt' . $InputPlace);
    }

    public function deleteAttribute(string $InputPlace, string $Attribute): void
    {
        $this->add('da' . $InputPlace, $Attribute);
    }

    public function delete(string $InputPlace): void
    {
        $this->add('de' . $InputPlace);
    }

    public function deleteParent(string $InputPlace): void
    {
        $this->add('dp' . $InputPlace);
    }

    // Tag
    public function swapTag(string $InputPlace, string $OutputPlace): void
    {
        $this->add('sp' . $InputPlace, $OutputPlace);
    }

    public function setReflection(string $InputPlace, string $Tag): void
    {
        $this->add('sR' . $InputPlace, $Tag);
    }

    public function setReflectionByOutputPlace(string $InputPlace, string $OutputPlace): void
    {
        $this->add('iR' . $InputPlace, $OutputPlace);
    }

    public function setMorph(string $InputPlace, string $Tag): void
    {
        $this->add('sM' . $InputPlace, $Tag);
    }

    public function setMorphByOutputPlace(string $InputPlace, string $OutputPlace): void
    {
        $this->add('iM' . $InputPlace, $OutputPlace);
    }

    // Browser
    public function changeUrl(string $Url): void
    {
        $this->add('cu', $Url);
    }

    public function setHeadTitle(string $Title): void
    {
        $this->add('ht', $Title);
    }

    public function clipboardWriteText(string $Text): void
    {
        $this->add('nw', $Text);
    }

    public function scrollTo(string $X, string $Y): void
    {
        $this->add('ws', $X . self::GS . $Y);
    }

    public function scrollToInt(int $X, int $Y): void
    {
        $this->scrollTo((string)$X, (string)$Y);
    }

    public function historyGo(string $Steps): void
    {
        $this->add('wg', $Steps);
    }

    public function historyGoInt(int $Steps): void
    {
        $this->historyGo((string)$Steps);
    }

    public function reloadPage(): void
    {
        $this->add('lr');
    }

    public function redirect(string $Path): void
    {
        $this->add('lh', $Path);
    }

    // Increase
    public function increaseMinLength(string $InputPlace, string $Value): void
    {
        $this->add('+n' . $InputPlace, $Value);
    }

    public function increaseMinLengthInt(string $InputPlace, int $Value): void
    {
        $this->increaseMinLength($InputPlace, (string)$Value);
    }

    public function increaseMaxLength(string $InputPlace, string $Value): void
    {
        $this->add('+x' . $InputPlace, $Value);
    }

    public function increaseMaxLengthInt(string $InputPlace, int $Value): void
    {
        $this->increaseMaxLength($InputPlace, (string)$Value);
    }

    public function increaseFontSize(string $InputPlace, string $Value): void
    {
        $this->add('+f' . $InputPlace, $Value);
    }

    public function increaseFontSizeInt(string $InputPlace, int $Value): void
    {
        $this->increaseFontSize($InputPlace, (string)$Value);
    }

    public function increaseWidth(string $InputPlace, string $Value): void
    {
        $this->add('+w' . $InputPlace, $Value);
    }

    public function increaseWidthInt(string $InputPlace, int $Value): void
    {
        $this->increaseWidth($InputPlace, (string)$Value);
    }

    public function increaseHeight(string $InputPlace, string $Value): void
    {
        $this->add('+h' . $InputPlace, $Value);
    }

    public function increaseHeightInt(string $InputPlace, int $Value): void
    {
        $this->increaseHeight($InputPlace, (string)$Value);
    }

    public function increaseValue(string $InputPlace, string $Value): void
    {
        $this->add('+v' . $InputPlace, $Value);
    }

    public function increaseValueInt(string $InputPlace, int $Value): void
    {
        $this->increaseValue($InputPlace, (string)$Value);
    }

    // Decrease
    public function decreaseMinLength(string $InputPlace, string $Value): void
    {
        $this->add('-n' . $InputPlace, $Value);
    }

    public function decreaseMinLengthInt(string $InputPlace, int $Value): void
    {
        $this->decreaseMinLength($InputPlace, (string)$Value);
    }

    public function decreaseMaxLength(string $InputPlace, string $Value): void
    {
        $this->add('-x' . $InputPlace, $Value);
    }

    public function decreaseMaxLengthInt(string $InputPlace, int $Value): void
    {
        $this->decreaseMaxLength($InputPlace, (string)$Value);
    }

    public function decreaseFontSize(string $InputPlace, string $Value): void
    {
        $this->add('-f' . $InputPlace, $Value);
    }

    public function decreaseFontSizeInt(string $InputPlace, int $Value): void
    {
        $this->decreaseFontSize($InputPlace, (string)$Value);
    }

    public function decreaseWidth(string $InputPlace, string $Value): void
    {
        $this->add('-w' . $InputPlace, $Value);
    }

    public function decreaseWidthInt(string $InputPlace, int $Value): void
    {
        $this->decreaseWidth($InputPlace, (string)$Value);
    }

    public function decreaseHeight(string $InputPlace, string $Value): void
    {
        $this->add('-h' . $InputPlace, $Value);
    }

    public function decreaseHeightInt(string $InputPlace, int $Value): void
    {
        $this->decreaseHeight($InputPlace, (string)$Value);
    }

    public function decreaseValue(string $InputPlace, string $Value): void
    {
        $this->add('-v' . $InputPlace, $Value);
    }

    public function decreaseValueInt(string $InputPlace, int $Value): void
    {
        $this->decreaseValue($InputPlace, (string)$Value);
    }

    // Event
    // ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
    // All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.
    public function triggerEvent(string $InputPlace, string $HtmlEventListener, ?string $ConstructorName = null): void
    {
        $this->add('TE' . $InputPlace, $HtmlEventListener . ($ConstructorName !== null ? self::GS . $ConstructorName : ''));
    }

    public function setPostEvent(string $InputPlace, string $HtmlEvent, ?string $OutputPlace = null): void
    {
        if ($OutputPlace !== null) {
            $this->add('Ep' . $InputPlace, $HtmlEvent . self::GS . $OutputPlace);
        } else {
            $this->add('Ep' . $InputPlace, $HtmlEvent);
        }
    }

    public function setPostEventAddView(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Ep' . $InputPlace, $HtmlEvent . self::GS . '+');
    }

    public function setPostEventListener(string $InputPlace, string $HtmlEventListener, ?string $OutputPlace = null): void
    {
        if ($OutputPlace !== null) {
            $this->add('EP' . $InputPlace, $HtmlEventListener . self::GS . $OutputPlace);
        } else {
            $this->add('EP' . $InputPlace, $HtmlEventListener);
        }
    }

    public function setPostEventListenerAddView(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('EP' . $InputPlace, $HtmlEventListener . self::GS . '+');
    }

    public function setGetEvent(string $InputPlace, string $HtmlEvent, ?string $Path = null, ?string $OutputPlace = null): void
    {
        $path = ($Path !== null) ? $Path : '#';
        if ($OutputPlace !== null) {
            $this->add('Eg' . $InputPlace, $HtmlEvent . self::GS . $path . self::GS . $OutputPlace);
        } else {
            $this->add('Eg' . $InputPlace, $HtmlEvent . self::GS . $path);
        }
    }

    public function setGetEventListener(string $InputPlace, string $HtmlEventListener, ?string $Path = null, ?string $OutputPlace = null): void
    {
        $path = ($Path !== null) ? $Path : '#';
        if ($OutputPlace !== null) {
            $this->add('EG' . $InputPlace, $HtmlEventListener . self::GS . $path . self::GS . $OutputPlace);
        } else {
            $this->add('EG' . $InputPlace, $HtmlEventListener . self::GS . $path);
        }
    }

    public function setPutEvent(string $InputPlace, string $HtmlEvent, ?string $Path = null, ?string $OutputPlace = null): void
    {
        $path = ($Path !== null) ? $Path : '#';
        if ($OutputPlace !== null) {
            $this->add('Et' . $InputPlace, $HtmlEvent . self::GS . $path . self::GS . $OutputPlace);
        } else {
            $this->add('Et' . $InputPlace, $HtmlEvent . self::GS . $path);
        }
    }

    public function setPutEventListener(string $InputPlace, string $HtmlEventListener, ?string $Path = null, ?string $OutputPlace = null): void
    {
        $path = ($Path !== null) ? $Path : '#';
        if ($OutputPlace !== null) {
            $this->add('ET' . $InputPlace, $HtmlEventListener . self::GS . $path . self::GS . $OutputPlace);
        } else {
            $this->add('ET' . $InputPlace, $HtmlEventListener . self::GS . $path);
        }
    }

    public function setPatchEvent(string $InputPlace, string $HtmlEvent, ?string $Path = null, ?string $OutputPlace = null): void
    {
        $path = ($Path !== null) ? $Path : '#';
        if ($OutputPlace !== null) {
            $this->add('Ea' . $InputPlace, $HtmlEvent . self::GS . $path . self::GS . $OutputPlace);
        } else {
            $this->add('Ea' . $InputPlace, $HtmlEvent . self::GS . $path);
        }
    }

    public function setPatchEventListener(string $InputPlace, string $HtmlEventListener, ?string $Path = null, ?string $OutputPlace = null): void
    {
        $path = ($Path !== null) ? $Path : '#';
        if ($OutputPlace !== null) {
            $this->add('EA' . $InputPlace, $HtmlEventListener . self::GS . $path . self::GS . $OutputPlace);
        } else {
            $this->add('EA' . $InputPlace, $HtmlEventListener . self::GS . $path);
        }
    }

    public function setDeleteEvent(string $InputPlace, string $HtmlEvent, ?string $Path = null, ?string $OutputPlace = null): void
    {
        $path = ($Path !== null) ? $Path : '#';
        if ($OutputPlace !== null) {
            $this->add('El' . $InputPlace, $HtmlEvent . self::GS . $path . self::GS . $OutputPlace);
        } else {
            $this->add('El' . $InputPlace, $HtmlEvent . self::GS . $path);
        }
    }

    public function setDeleteEventListener(string $InputPlace, string $HtmlEventListener, ?string $Path = null, ?string $OutputPlace = null): void
    {
        $path = ($Path !== null) ? $Path : '#';
        if ($OutputPlace !== null) {
            $this->add('EL' . $InputPlace, $HtmlEventListener . self::GS . $path . self::GS . $OutputPlace);
        } else {
            $this->add('EL' . $InputPlace, $HtmlEventListener . self::GS . $path);
        }
    }

    public function setOptionsEvent(string $InputPlace, string $HtmlEvent, ?string $Path = null, ?string $OutputPlace = null): void
    {
        $path = ($Path !== null) ? $Path : '#';
        if ($OutputPlace !== null) {
            $this->add('Eo' . $InputPlace, $HtmlEvent . self::GS . $path . self::GS . $OutputPlace);
        } else {
            $this->add('Eo' . $InputPlace, $HtmlEvent . self::GS . $path);
        }
    }

    public function setOptionsEventListener(string $InputPlace, string $HtmlEventListener, ?string $Path = null, ?string $OutputPlace = null): void
    {
        $path = ($Path !== null) ? $Path : '#';
        if ($OutputPlace !== null) {
            $this->add('EO' . $InputPlace, $HtmlEventListener . self::GS . $path . self::GS . $OutputPlace);
        } else {
            $this->add('EO' . $InputPlace, $HtmlEventListener . self::GS . $path);
        }
    }

    public function setHeadEvent(string $InputPlace, string $HtmlEvent, ?string $Path = null): void
    {
        $this->add('Eh' . $InputPlace, $HtmlEvent . self::GS . (($Path !== null) ? $Path : '#'));
    }

    public function setHeadEventListener(string $InputPlace, string $HtmlEventListener, ?string $Path = null): void
    {
        $this->add('EH' . $InputPlace, $HtmlEventListener . self::GS . (($Path !== null) ? $Path : '#'));
    }

    // IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
    public function setSendEvent(string $InputPlace, string $HtmlEvent, string $Data, ?string $Path = null, string $Method = 'POST', bool $IsMultiPart = false, string $ContentType = 'text/plain', ?string $OutputPlace = null): void
    {
        $this->add('En' . $InputPlace, $HtmlEvent . self::GS . str_replace("\n", '$[ln];', str_replace('"', '$[dq];', str_replace("'", '$[sq];', $Data))) . self::GS . (($Path !== null) ? $Path : '#') . self::GS . $Method . self::GS . ($IsMultiPart ? '1' : '0') . self::GS . $ContentType . self::GS . $OutputPlace);
    }

    public function setSendEventListener(string $InputPlace, string $HtmlEventListener, string $Data, ?string $Path = null, string $Method = 'POST', bool $IsMultiPart = false, string $ContentType = 'text/plain', ?string $OutputPlace = null): void
    {
        $this->add('EN' . $InputPlace, $HtmlEventListener . self::GS . str_replace("\n", '$[ln];', $Data) . self::GS . (($Path !== null) ? $Path : '#') . self::GS . $Method . self::GS . ($IsMultiPart ? '1' : '0') . self::GS . $ContentType . self::GS . $OutputPlace);
    }

    public function setCommentEvent(string $InputPlace, string $HtmlEvent, ?string $Index = null, ?string $OutputPlace = null): void
    {
        $this->add('Eb' . $InputPlace, $HtmlEvent . self::GS . $Index . self::GS . $OutputPlace);
    }

    public function setCommentEventInt(string $InputPlace, string $HtmlEvent, int $Index, ?string $OutputPlace = null): void
    {
        $this->setCommentEvent($InputPlace, $HtmlEvent, (string)$Index, $OutputPlace);
    }

    public function setCommentEventListener(string $InputPlace, string $HtmlEventListener, ?string $Index = null, ?string $OutputPlace = null): void
    {
        $this->add('EB' . $InputPlace, $HtmlEventListener . self::GS . $Index . self::GS . $OutputPlace);
    }

    public function setCommentEventListenerInt(string $InputPlace, string $HtmlEventListener, int $Index, ?string $OutputPlace = null): void
    {
        $this->setCommentEventListener($InputPlace, $HtmlEventListener, (string)$Index, $OutputPlace);
    }

	public function setWasmEvent(string $InputPlace, string $HtmlEvent, string $WasmLanguage, string $WasmUrl, string $MethodName, ?array $Args = null, ?string $OutputPlace = null): void
	{
		$argsJoin = '';
		if ($Args !== null && count($Args) > 0) {
			$argsJoin = '[' . implode(self::US, array_map('strval', $Args));
		}
		$this->add('Ey' . $InputPlace, $HtmlEvent . self::GS . $WasmLanguage . self::GS . $WasmUrl . self::GS . $MethodName . self::GS . $argsJoin . self::GS . $OutputPlace);
	}

	public function setWasmEventListener(string $InputPlace, string $HtmlEventListener, string $WasmLanguage, string $WasmUrl, string $MethodName, ?array $Args = null, ?string $OutputPlace = null): void
	{
		$argsJoin = '';
		if ($Args !== null && count($Args) > 0) {
			$argsJoin = '[' . implode(self::US, array_map('strval', $Args));
		}
		$this->add('EY' . $InputPlace, $HtmlEventListener . self::GS . $WasmLanguage . self::GS . $WasmUrl . self::GS . $MethodName . self::GS . $argsJoin . self::GS . $OutputPlace);
	}

    public function setWebSocketEvent(string $InputPlace, string $HtmlEvent, string $Path): void
    {
        $this->add('Ew' . $InputPlace, $HtmlEvent . self::GS . $Path);
    }

    public function setWebSocketEventListener(string $InputPlace, string $HtmlEventListener, string $Path): void
    {
        $this->add('EW' . $InputPlace, $HtmlEventListener . self::GS . $Path);
    }

    public function setSSEEvent(string $InputPlace, string $HtmlEvent, string $Path, ?string $OutputPlace = null, bool $ShouldReconnect = true, int $ReconnectTryTimeout = 3000): void
    {
        $value = $HtmlEvent . self::GS . $Path . self::GS . ($ShouldReconnect ? '1' : '0') . self::GS . (string)$ReconnectTryTimeout;
        if ($OutputPlace !== null) {
            $value .= self::GS . $OutputPlace;
        }
        $this->add('Ee' . $InputPlace, $value);
    }

    public function setSSEEventListener(string $InputPlace, string $HtmlEventListener, string $Path, ?string $OutputPlace = null, bool $ShouldReconnect = true, int $ReconnectTryTimeout = 3000): void
    {
        $value = $HtmlEventListener . self::GS . $Path . self::GS . ($ShouldReconnect ? '1' : '0') . self::GS . (string)$ReconnectTryTimeout;
        if ($OutputPlace !== null) {
            $value .= self::GS . $OutputPlace;
        }
        $this->add('EE' . $InputPlace, $value);
    }

	public function setFrontEvent(string $InputPlace, string $HtmlEvent, string $ModulePath, ?array $Args = null, ?string $OutputPlace = null): void
	{
		$argsJoin = '';
		if ($Args !== null && count($Args) > 0) {
			$argsJoin = self::GS . '[' . implode(self::US, array_map('strval', $Args));
		}
		$this->add('Ej' . $InputPlace, $HtmlEvent . self::GS . $ModulePath . self::GS . $OutputPlace . $argsJoin);
	}

	public function setFrontEventListener(string $InputPlace, string $HtmlEventListener, string $ModulePath, ?array $Args = null, ?string $OutputPlace = null): void
	{
		$argsJoin = '';
		if ($Args !== null && count($Args) > 0) {
			$argsJoin = self::GS . '[' . implode(self::US, array_map('strval', $Args));
		}
		$this->add('EJ' . $InputPlace, $HtmlEventListener . self::GS . $ModulePath . self::GS . $OutputPlace . $argsJoin);
	}

    public function setMasterPagesEvent(string $InputPlace, string $HtmlEvent, ?string $OutputPlace = null): void
    {
        $this->add('Eu' . $InputPlace, $HtmlEvent . self::GS . $OutputPlace);
    }

    public function setMasterPagesEventListener(string $InputPlace, string $HtmlEventListener, ?string $OutputPlace = null): void
    {
        $this->add('EU' . $InputPlace, $HtmlEventListener . self::GS . $OutputPlace);
    }

    public function setPreventDefaultEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Ed' . $InputPlace, $HtmlEvent);
    }

    public function setPreventDefaultEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('ED' . $InputPlace, $HtmlEventListener);
    }

    public function setStopPropagationEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Es' . $InputPlace, $HtmlEvent);
    }

    public function setStopPropagationEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('ES' . $InputPlace, $HtmlEventListener);
    }

	public function setMethodEvent(string $InputPlace, string $HtmlEvent, string $MethodName, ?array $Args = null): void
	{
		$argsJoin = '';
		if ($Args !== null && count($Args) > 0) {
			$argsJoin = self::GS . '[' . implode(self::US, array_map('strval', $Args));
		}
		$this->add('Em' . $InputPlace, $HtmlEvent . self::GS . $MethodName . $argsJoin);
	}

	public function setMethodEventListener(string $InputPlace, string $HtmlEventListener, string $MethodName, ?array $Args = null): void
	{
		$argsJoin = '';
		if ($Args !== null && count($Args) > 0) {
			$argsJoin = self::GS . '[' . implode(self::US, array_map('strval', $Args));
		}
		$this->add('EM' . $InputPlace, $HtmlEventListener . self::GS . $MethodName . $argsJoin);
	}

	public function setModuleMethodEvent(string $InputPlace, string $HtmlEvent, string $MethodName, ?array $Args = null): void
	{
		$argsJoin = '';
		if ($Args !== null && count($Args) > 0) {
			$argsJoin = self::GS . '[' . implode(self::US, array_map('strval', $Args));
		}
		$this->add('Ex' . $InputPlace, $HtmlEvent . self::GS . $MethodName . $argsJoin);
	}

	public function setModuleMethodEventListener(string $InputPlace, string $HtmlEventListener, string $MethodName, ?array $Args = null): void
	{
		$argsJoin = '';
		if ($Args !== null && count($Args) > 0) {
			$argsJoin = self::GS . '[' . implode(self::US, array_map('strval', $Args));
		}
		$this->add('EX' . $InputPlace, $HtmlEventListener . self::GS . $MethodName . $argsJoin);
	}

    public function assignConfirmEvent(string $InputPlace, string $HtmlEvent, string $Text = 'Are you sure you want to proceed?', string $Type = 'none', string $Title = 'Confirm', string $OkText = 'OK', string $CancelText = 'Cancel'): void
    {
        $this->add('Ef' . $InputPlace, $HtmlEvent . self::GS . ($Text === 'Are you sure you want to proceed?' ? '' : $Text) . self::GS . ($Type === 'none' ? '' : $Type) . self::GS . ($Title === 'Confirm' ? '' : $Title) . self::GS . ($OkText === 'OK' ? '' : $OkText) . self::GS . ($CancelText === 'Cancel' ? '' : $CancelText));
    }

    public function removePostEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Rp' . $InputPlace, $HtmlEvent);
    }

    public function removePostEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RP' . $InputPlace, $HtmlEventListener);
    }

    public function removeGetEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Rg' . $InputPlace, $HtmlEvent);
    }

    public function removeGetEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RG' . $InputPlace, $HtmlEventListener);
    }

    public function removePutEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Rt' . $InputPlace, $HtmlEvent);
    }

    public function removePutEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RT' . $InputPlace, $HtmlEventListener);
    }

    public function removePatchEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Ra' . $InputPlace, $HtmlEvent);
    }

    public function removePatchEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RA' . $InputPlace, $HtmlEventListener);
    }

    public function removeDeleteEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Rl' . $InputPlace, $HtmlEvent);
    }

    public function removeDeleteEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RL' . $InputPlace, $HtmlEventListener);
    }

    public function removeOptionsEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Ro' . $InputPlace, $HtmlEvent);
    }

    public function removeOptionsEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RO' . $InputPlace, $HtmlEventListener);
    }

    public function removeHeadEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Rh' . $InputPlace, $HtmlEvent);
    }

    public function removeHeadEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RH' . $InputPlace, $HtmlEventListener);
    }

    public function removeSendEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Rn' . $InputPlace, $HtmlEvent);
    }

    public function removeSendEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RN' . $InputPlace, $HtmlEventListener);
    }

    public function removeCommentEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Rb' . $InputPlace, $HtmlEvent);
    }

    public function removeCommentEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RB' . $InputPlace, $HtmlEventListener);
    }

    public function removeWasmEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Ry' . $InputPlace, $HtmlEvent);
    }

    public function removeWasmEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RY' . $InputPlace, $HtmlEventListener);
    }

    public function removeWebSocketEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Rw' . $InputPlace, $HtmlEvent);
    }

    public function removeWebSocketEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RW' . $InputPlace, $HtmlEventListener);
    }

    public function removeSSEEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Re' . $InputPlace, $HtmlEvent);
    }

    public function removeSSEEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RE' . $InputPlace, $HtmlEventListener);
    }

    public function removeFrontEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Rj' . $InputPlace, $HtmlEvent);
    }

    public function removeFrontEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RJ' . $InputPlace, $HtmlEventListener);
    }

    public function removePreventDefaultEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Rd' . $InputPlace, $HtmlEvent);
    }

    public function removePreventDefaultEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RD' . $InputPlace, $HtmlEventListener);
    }

    public function removeMasterPagesEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Ru' . $InputPlace, $HtmlEvent);
    }

    public function removeMasterPagesEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RU' . $InputPlace, $HtmlEventListener);
    }

    public function removeStopPropagationEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Rs' . $InputPlace, $HtmlEvent);
    }

    public function removeStopPropagationEventListener(string $InputPlace, string $HtmlEventListener): void
    {
        $this->add('RS' . $InputPlace, $HtmlEventListener);
    }

    public function removeMethodEvent(string $InputPlace, string $HtmlEvent, string $MethodName): void
    {
        $this->add('Rm' . $InputPlace, $HtmlEvent . self::GS . $MethodName);
    }

    public function removeMethodEventListener(string $InputPlace, string $HtmlEventListener, string $MethodName): void
    {
        $this->add('RM' . $InputPlace, $HtmlEventListener . self::GS . $MethodName);
    }

    public function removeModuleMethodEvent(string $InputPlace, string $HtmlEvent, string $MethodName): void
    {
        $this->add('Rx' . $InputPlace, $HtmlEvent . self::GS . $MethodName);
    }

    public function removeModuleMethodEventListener(string $InputPlace, string $HtmlEventListener, string $MethodName): void
    {
        $this->add('RX' . $InputPlace, $HtmlEventListener . self::GS . $MethodName);
    }

    public function removeConfirmEvent(string $InputPlace, string $HtmlEvent): void
    {
        $this->add('Rf' . $InputPlace, $HtmlEvent);
    }

    // Custom Event
    // This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
    // Watch: attribute, style, text, children, value
    // Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
    // Range: Only Use For Compare With inrange Value. Split By Comma ","
    // Key: Only Use For Watch With attribute And style Value
    public function createCustomDOMEvent(string $InputPlace, string $EventName, string $Watch, string $Key, string $Compare, string $Value, string $Range, bool $Immediate = false, string $Delay = '0'): void
    {
        $this->add('eC' . $InputPlace, $EventName . self::GS . $Watch . self::GS . $Key . self::GS . $Compare . self::GS . $Value . self::GS . $Range . self::GS . ($Immediate ? '1' : '0') . self::GS . $Delay);
    }

    public function createCustomDOMEventDelayInt(string $InputPlace, string $EventName, string $Watch, string $Key, string $Compare, string $Value, string $Range, bool $Immediate, int $Delay): void
    {
        $this->createCustomDOMEvent($InputPlace, $EventName, $Watch, $Key, $Compare, $Value, $Range, $Immediate, (string)$Delay);
    }

    public function enableScrollBottomEvent(bool $Enable = true): void
    {
        $this->add('eb', $Enable ? '1' : '0');
    }

    public function enableReachedElementEvent(string $InputPlace, bool $Once, bool $Enable = true): void
    {
        $this->add('er' . $InputPlace, ($Once ? '1' : '0') . self::GS . ($Enable ? '1' : '0'));
    }

    // Module
    public function loadModule(string $ModulePath, ?array $Methods = null): void
    {
        if ($Methods === null) {
            $Methods = [];
        }
        $this->add('Ml', $ModulePath . (count($Methods) > 0 ? self::GS . '[' . implode(self::US, $Methods) : ''));
    }

    public function unloadModule(string $ModulePath): void
    {
        $this->add('Mu', $ModulePath);
    }

    public function deleteModuleMethod(string $MethodName): void
    {
        $this->add('Md', $MethodName);
    }

    // Unit Testing
    // InputPlace Is Actual, Expected Is Tag/OutputPlace
    public function assertEqual(string $InputPlace, string $Tag): void
    {
        $this->add('At' . $InputPlace, str_replace("\n", '$[ln];', $Tag));
    }

    public function assertEqualByOutputPlace(string $InputPlace, string $OutputPlace): void
    {
        $this->add('Ao' . $InputPlace, $OutputPlace);
    }

    // Debug
    public function createDebugger(bool $Pause = false): void
    {
        $this->add('Dc', $Pause ? '1' : '0');
    }

    // Service Worker
    // To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
    public function serviceWorkerRegister(?string $Path = null, ?string $ScopePath = null): void
    {
        $this->add('wR', $Path . self::GS . $ScopePath);
    }

    public function serviceWorkerPreCacheStatic(array $PathList): void
    {
        $this->add('wp', implode(self::GS, $PathList));
    }

    public function serviceWorkerDynamicCache(string $Path, ?string $Seconds = null): void
    {
        $this->add('wc', $Path . ($Seconds !== null && $Seconds !== '' ? self::GS . $Seconds : ''));
    }

    public function serviceWorkerDynamicCacheInt(string $Path, int $Seconds): void
    {
        $this->serviceWorkerDynamicCache($Path, $Seconds > 0 ? (string)$Seconds : '');
    }

	public function serviceWorkerDeleteDynamicCache(?string $Path = null): void
	{
		$this->add('wd', $Path ?? '');
	}

    public function serviceWorkerDynamicCacheTTLUpdate(string $Path, ?string $Seconds = null): void
    {
        $this->add('wt', $Path . ($Seconds !== null && $Seconds !== '' ? self::GS . $Seconds : ''));
    }

    public function serviceWorkerDynamicCacheTTLUpdateInt(string $Path, int $Seconds): void
    {
        $this->serviceWorkerDynamicCacheTTLUpdate($Path, $Seconds > 0 ? (string)$Seconds : '');
    }

    // Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
    // Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
    // CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
    public function serviceWorkerRouteSet(string $Path, string $Type, bool $CacheDynamic = false): void
    {
        $this->add('wr', $Path . self::GS . $Type . ($CacheDynamic ? self::GS . '1' : ''));
    }

    public function serviceWorkerRouteAlias(string $Path, string $To): void
    {
        $this->add('wa', $Path . self::GS . $To);
    }

	public function serviceWorkerDeleteRouteAlias(?string $Path = null): void
	{
		$this->add('wC', $Path ?? '');
	}

    // Delete All Route And Alias
	public function serviceWorkerDeleteRoute(?string $Path = null): void
	{
		$this->add('wD', $Path ?? '');
	}

    // SSE
	public function disconnectSSE(?string $Path = null): void
	{
		$this->add('Ds', $Path ?? '');
	}

    public function disconnectAllSSE(): void
    {
        $this->add('Ds');
    }

    // State
    public function addState(?string $Path = null, ?string $Title = null): void
    {
        $this->add('AS', $Path . self::GS . $Title);
    }

    public function saveState(?string $Path = null, ?string $Title = null): void
    {
        $this->add('As', $Path . self::GS . $Title);
    }

    public function loadState(string $Path): void
    {
        $this->add('ls', $Path);
    }

	public function deleteState(?string $Path = null): void
	{
		$this->add('DS', $Path ?? '');
	}

    public function deleteAllState(): void
    {
        $this->add('DS', '*');
    }

    // Cookie
    public function setCookie(string $Key, string $Value, string $Seconds, ?string $Path = null): void
    {
        $this->add('sC', $Key . self::GS . $Value . self::GS . $Seconds . ($Path !== null ? self::GS . $Path : ''));
    }

    public function setCookieInt(string $Key, string $Value, int $Seconds, ?string $Path = null): void
    {
        $this->setCookie($Key, $Value, (string)$Seconds, $Path);
    }

    // Save (Session Cache)
    public function saveId(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gi' . $InputPlace, $Key);
    }

    public function saveName(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gn' . $InputPlace, $Key);
    }

    public function saveValue(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gv' . $InputPlace, $Key);
    }

    public function saveValueLength(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@ge' . $InputPlace, $Key);
    }

    public function saveClass(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gc' . $InputPlace, $Key);
    }

    public function saveStyle(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gs' . $InputPlace, $Key);
    }

    public function saveTitle(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gl' . $InputPlace, $Key);
    }

    public function saveLabel(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gA' . $InputPlace, $Key);
    }

    public function saveText(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gt' . $InputPlace, $Key);
    }

    public function saveOuterText(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@go' . $InputPlace, $Key);
    }

    public function saveTextLength(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gg' . $InputPlace, $Key);
    }

    public function saveAttribute(string $InputPlace, string $Attribute, string $Key = '.'): void
    {
        $this->add('@ga' . $InputPlace, $Key . self::GS . $Attribute);
    }

    public function saveWidth(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gw' . $InputPlace, $Key);
    }

    public function saveHeight(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gh' . $InputPlace, $Key);
    }

    public function saveReadOnly(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gr' . $InputPlace, $Key);
    }

    public function saveSelectedIndex(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gx' . $InputPlace, $Key);
    }

    public function saveTextAlign(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gT' . $InputPlace, $Key);
    }

    public function saveNodeLength(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gL' . $InputPlace, $Key);
    }

    public function saveVisible(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gV' . $InputPlace, $Key);
    }

    public function saveUrl(string $Url, bool $FetchScript = false, string $Key = '.'): void
    {
        $this->add('@gu', $Key . self::GS . $Url . ($FetchScript ? self::GS . '1' : ''));
    }

    public function saveIndex(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@gI' . $InputPlace, $Key);
    }

    public function removeSave(string $CacheKey): void
    {
        $this->add('rs', $CacheKey);
    }

    public function removeAllSave(): void
    {
        $this->add('rs', '*');
    }

    // Calling the SetSave Method Causes Action Control Requests Triggered by Events Using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send Event, to be Temporarily Saved on the Active Page, so the Request will not be Sent to the Server Again.
    public function setSave(): void
    {
        $this->add('cs', '*');
    }

    public function addSaveValue(string $CacheKey, string $Value): void
    {
        $this->add('SA', $CacheKey . self::GS . str_replace("\n", '$[ln];', $Value));
    }

    public function insertSaveValue(string $CacheKey, string $Value): void
    {
        $this->add('SI', $CacheKey . self::GS . str_replace("\n", '$[ln];', $Value));
    }

    public function appendSaveValue(string $CacheKey, string $Value): void
    {
        $this->add('SP', $CacheKey . self::GS . str_replace("\n", '$[ln];', $Value));
    }

    public function replaceSaveValue(string $CacheKey, string $SearchValue, string $Value): void
    {
        $this->add('SR', $CacheKey . self::GS . str_replace("\n", '$[ln];', $Value) . self::GS . str_replace("\n", '$[ln];', $SearchValue));
    }

    // Cache
    public function cacheId(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@ci' . $InputPlace, $Key);
    }

    public function cacheName(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cn' . $InputPlace, $Key);
    }

    public function cacheValue(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cv' . $InputPlace, $Key);
    }

    public function cacheValueLength(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@ce' . $InputPlace, $Key);
    }

    public function cacheClass(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cc' . $InputPlace, $Key);
    }

    public function cacheStyle(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cs' . $InputPlace, $Key);
    }

    public function cacheTitle(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cl' . $InputPlace, $Key);
    }

    public function cacheLabel(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cA' . $InputPlace, $Key);
    }

    public function cacheText(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@ct' . $InputPlace, $Key);
    }

    public function cacheOuterText(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@co' . $InputPlace, $Key);
    }

    public function cacheTextLength(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cg' . $InputPlace, $Key);
    }

    public function cacheAttribute(string $InputPlace, string $Attribute, string $Key = '.'): void
    {
        $this->add('@ca' . $InputPlace, $Key . self::GS . $Attribute);
    }

    public function cacheWidth(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cw' . $InputPlace, $Key);
    }

    public function cacheHeight(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@ch' . $InputPlace, $Key);
    }

    public function cacheReadOnly(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cr' . $InputPlace, $Key);
    }

    public function cacheSelectedIndex(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cx' . $InputPlace, $Key);
    }

    public function cacheTextAlign(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cT' . $InputPlace, $Key);
    }

    public function cacheNodeLength(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cL' . $InputPlace, $Key);
    }

    public function cacheVisible(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cV' . $InputPlace, $Key);
    }

    public function cacheUrl(string $Url, bool $FetchScript = false, string $Key = '.'): void
    {
        $this->add('@cu', $Key . self::GS . $Url . ($FetchScript ? self::GS . '1' : ''));
    }

    public function cacheIndex(string $InputPlace, string $Key = '.'): void
    {
        $this->add('@cI' . $InputPlace, $Key);
    }

    public function removeCache(string $CacheKey): void
    {
        $this->add('rd', $CacheKey);
    }

    public function removeAllCache(): void
    {
        $this->add('rd', '*');
    }

    // Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
    public function setCache(string $Second): void
    {
        $this->add('cd', $Second);
    }

    public function setCacheInt(int $Second): void
    {
        $this->setCache((string)$Second);
    }

    public function setCacheNoTime(): void
    {
        $this->add('cd', '*');
    }

    public function addCacheValue(string $CacheKey, string $Value): void
    {
        $this->add('CA', $CacheKey . self::GS . str_replace("\n", '$[ln];', $Value));
    }

    public function insertCacheValue(string $CacheKey, string $Value): void
    {
        $this->add('CI', $CacheKey . self::GS . str_replace("\n", '$[ln];', $Value));
    }

    public function appendCacheValue(string $CacheKey, string $Value): void
    {
        $this->add('CP', $CacheKey . self::GS . str_replace("\n", '$[ln];', $Value));
    }

    public function replaceCacheValue(string $CacheKey, string $SearchValue, string $Value): void
    {
        $this->add('CR', $CacheKey . self::GS . str_replace("\n", '$[ln];', $Value) . self::GS . str_replace("\n", '$[ln];', $SearchValue));
    }

    // Call
    public function loadUrl(string $InputPlace, string $Url): void
    {
        $this->add('lu' . $InputPlace, $Url);
    }

    public function runActionControls(string $ActionControls, bool $WithoutWebFormsSection = true, ?string $Index = null, bool $UseCurrentEvent = true): void
    {
        $this->add('lA', ($UseCurrentEvent ? '1' : '0') . self::GS . ($WithoutWebFormsSection ? '1' : '0') . self::GS . $Index . self::GS . $ActionControls);
    }

    public function callScript(string $ScriptText): void
    {
        $this->add('_', str_replace("\n", '$[ln];', $ScriptText));
    }

	public function callMethod(string $MethodName, ?array $Args = null): void
	{
		$argsJoin = '';
		if ($Args !== null && count($Args) > 0) {
			$argsJoin = self::GS . '[' . implode(self::US, array_map('strval', $Args));
		}
		$this->add('lm', $MethodName . $argsJoin);
	}

	public function callModuleMethod(string $MethodName, ?array $Args = null): void
	{
		$argsJoin = '';
		if ($Args !== null && count($Args) > 0) {
			$argsJoin = self::GS . '[' . implode(self::US, array_map('strval', $Args));
		}
		$this->add('lM', $MethodName . $argsJoin);
	}

    public function callPostBack(string $FormInputPlace, ?string $OutputPlace = null): void
    {
        $this->add('Lp', '1' . self::GS . $FormInputPlace . ($OutputPlace !== null ? self::GS . $OutputPlace : ''));
    }

    public function callCommentBack(?string $Index = null, ?string $InputPlace = null, bool $UseCurrentEvent = true): void
    {
        $this->add('LC', ($UseCurrentEvent ? '1' : '0') . self::GS . $Index . self::GS . $InputPlace);
    }

    public function callCommentBackInt(int $Index, ?string $InputPlace = null, bool $UseCurrentEvent = true): void
    {
        $this->callCommentBack((string)$Index, $InputPlace, $UseCurrentEvent);
    }

	public function callWasmBack(string $WasmLanguage, string $WasmUrl, string $MethodName, ?array $Args = null, ?string $OutputPlace = null, bool $UseCurrentEvent = true): void
	{
		$argsJoin = '';
		if ($Args !== null && count($Args) > 0) {
			$argsJoin = '[' . implode(self::US, array_map('strval', $Args));
		}
		$this->add('Ly', ($UseCurrentEvent ? '1' : '0') . self::GS . $WasmLanguage . self::GS . $WasmUrl . self::GS . $MethodName . self::GS . $argsJoin . self::GS . $OutputPlace);
	}

    public function callWebSocketBack(string $Path, bool $UseCurrentEvent = true): void
    {
        $this->add('Lw', ($UseCurrentEvent ? '1' : '0') . self::GS . $Path);
    }

    public function callSSEBack(string $Path, ?string $OutputPlace = null, bool $UseCurrentEvent = true, bool $ShouldReconnect = true, string $ReconnectTryTimeout = '3000'): void
    {
        $value = ($UseCurrentEvent ? '1' : '0') . self::GS . $Path . self::GS . ($ShouldReconnect ? '1' : '0') . self::GS . $ReconnectTryTimeout;
        if ($OutputPlace !== null) {
            $value .= self::GS . $OutputPlace;
        }
        $this->add('Ls', $value);
    }

    public function callSSEBackInt(string $Path, ?string $OutputPlace, bool $UseCurrentEvent, bool $ShouldReconnect, int $ReconnectTryTimeout): void
    {
        $this->callSSEBack($Path, $OutputPlace, $UseCurrentEvent, $ShouldReconnect, (string)$ReconnectTryTimeout);
    }

	public function callFront(string $ModulePath, ?array $Args = null, ?string $OutputPlace = null, bool $UseCurrentEvent = true): void
	{
		$argsJoin = '';
		if ($Args !== null && count($Args) > 0) {
			$argsJoin = self::GS . '[' . implode(self::US, array_map('strval', $Args));
		}
		$this->add('Lj', ($UseCurrentEvent ? '1' : '0') . self::GS . $ModulePath . self::GS . $OutputPlace . $argsJoin);
	}

    public function callGetBack(string $Path, ?string $OutputPlace = null, bool $UseCurrentEvent = true): void
    {
        $this->add('Lg', ($UseCurrentEvent ? '1' : '0') . self::GS . $Path . ($OutputPlace !== null ? self::GS . $OutputPlace : ''));
    }

    public function callPutBack(string $Path, ?string $OutputPlace = null, bool $UseCurrentEvent = true): void
    {
        $this->add('Lt', ($UseCurrentEvent ? '1' : '0') . self::GS . $Path . ($OutputPlace !== null ? self::GS . $OutputPlace : ''));
    }

    public function callPatchBack(string $Path, ?string $OutputPlace = null, bool $UseCurrentEvent = true): void
    {
        $this->add('LP', ($UseCurrentEvent ? '1' : '0') . self::GS . $Path . ($OutputPlace !== null ? self::GS . $OutputPlace : ''));
    }

    public function callDeleteBack(string $Path, ?string $OutputPlace = null, bool $UseCurrentEvent = true): void
    {
        $this->add('Ld', ($UseCurrentEvent ? '1' : '0') . self::GS . $Path . ($OutputPlace !== null ? self::GS . $OutputPlace : ''));
    }

    public function callHeadBack(string $Path, bool $UseCurrentEvent = true): void
    {
        $this->add('Lh', ($UseCurrentEvent ? '1' : '0') . self::GS . $Path);
    }

    public function callOptionsBack(string $Path, ?string $OutputPlace = null, bool $UseCurrentEvent = true): void
    {
        $this->add('Lo', ($UseCurrentEvent ? '1' : '0') . self::GS . $Path . ($OutputPlace !== null ? self::GS . $OutputPlace : ''));
    }

    public function callSendBack(string $Path, string $Method, bool $IsMultiPart, string $ContentType, string $Data, ?string $OutputPlace = null, bool $UseCurrentEvent = true): void
    {
        $this->add('LS', ($UseCurrentEvent ? '1' : '0') . self::GS . $Path . self::GS . $Method . self::GS . ($IsMultiPart ? '1' : '0') . self::GS . $ContentType . self::GS . str_replace("\n", '$[ln];', $Data) . ($OutputPlace !== null ? self::GS . $OutputPlace : ''));
    }

    // Update
    public function increase(string $InputPlace, float $Value): void
    {
        $this->add('gt' . $InputPlace, 'i' . self::GS . (string)$Value);
    }

    public function decrease(string $InputPlace, float $Value): void
    {
        $this->add('gt' . $InputPlace, 'i' . self::GS . (string)($Value * -1));
    }

    // If You Don't Use Deep Mode, any Tags Inside the Current Tag Will Simply Be Treated as Strings. Deep Mode Does not Remove Inner Elements.
    public function replace(string $InputPlace, string $Value, string $NewValue, bool $AlsoStartTag = false, bool $Deep = true): void
    {
        $this->add('gt' . $InputPlace, 'r' . self::GS . $Value . self::GS . $NewValue . self::GS . ($AlsoStartTag ? '1' : '0') . self::GS . ($Deep ? '1' : '0'));
    }

    // HTML Converts Attribute Names to Lowercase, so they Need to Be Written in Lowercase.
    public function replaceStartTag(string $InputPlace, string $Value, string $NewValue): void
    {
        $this->add('gt' . $InputPlace, 's' . self::GS . $Value . self::GS . $NewValue);
    }

    // Pre Runner
    public function assignDelay(int $MiliSecond, int $Index = -1): void
    {
        $currentLine = $this->getLineByIndex($Index);
        if ($currentLine === '') {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $newName = ':' . (string)$MiliSecond . ')' . $parts[0];
        $newValue = count($parts) > 1 ? $parts[1] : '';

        $this->updateLineByIndex($Index, $newName, $newValue);
    }

    public function assignDelayChange(int $MiliSecond, int $Index = -1): void
    {
        $currentLine = $this->getLineByIndex($Index);
        if ($currentLine === '') {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $currentName = $parts[0];

        if (strpos($currentName, ':') === 0 && strpos($currentName, ')') !== false) {
            $closingBracket = strpos($currentName, ')');
            $currentName = substr($currentName, $closingBracket + 1);
        }

        $newName = ':' . (string)$MiliSecond . ')' . $currentName;
        $newValue = count($parts) > 1 ? $parts[1] : '';

        $this->updateLineByIndex($Index, $newName, $newValue);
    }

    public function assignInterval(int $MiliSecond, ?string $Id = null, int $Index = -1): void
    {
        $currentLine = $this->getLineByIndex($Index);
        if ($currentLine === '') {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $newName = '(' . (string)$MiliSecond . ($Id !== null ? '|' . $Id : '') . ')' . $parts[0];
        $newValue = count($parts) > 1 ? $parts[1] : '';

        $this->updateLineByIndex($Index, $newName, $newValue);
    }

    public function assignIntervalChange(int $MiliSecond, ?string $Id = null, int $Index = -1): void
    {
        $currentLine = $this->getLineByIndex($Index);
        if ($currentLine === '') {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $currentName = $parts[0];

        if (strpos($currentName, '(') === 0 && strpos($currentName, ')') !== false) {
            $closingBracket = strpos($currentName, ')');
            $currentName = substr($currentName, $closingBracket + 1);
        }

        $newName = '(' . (string)$MiliSecond . ($Id !== null ? '|' . $Id : '') . ')' . $currentName;
        $newValue = count($parts) > 1 ? $parts[1] : '';

        $this->updateLineByIndex($Index, $newName, $newValue);
    }

    public function deleteInterval(string $Id): void
    {
        $this->add('Di', $Id);
    }

    public function assignRepeat(int $Count, int $Index = -1): void
    {
        $currentLine = $this->getLineByIndex($Index);
        if ($currentLine === '') {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $newName = ',' . (string)$Count . ')' . $parts[0];
        $newValue = count($parts) > 1 ? $parts[1] : '';

        $this->updateLineByIndex($Index, $newName, $newValue);
    }

    public function assignRepeatChange(int $Count, int $Index = -1): void
    {
        $currentLine = $this->getLineByIndex($Index);
        if ($currentLine === '') {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $currentName = $parts[0];

        if (strpos($currentName, ',') === 0 && strpos($currentName, ')') !== false) {
            $closingBracket = strpos($currentName, ')');
            $currentName = substr($currentName, $closingBracket + 1);
        }

        $newName = ',' . (string)$Count . ')' . $currentName;
        $newValue = count($parts) > 1 ? $parts[1] : '';

        $this->updateLineByIndex($Index, $newName, $newValue);
    }

    // Index
    public function startIndex(?string $Name = null): void
    {
        if ($Name !== null) {
            $this->add('#', $Name);
        } else {
            $this->add('#', '');
        }
    }

    // This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
    public function startState(): void
    {
        $this->startIndex('$');
    }

    public function goTo(string $Line, string $Repeat): void
    {
        $this->add('&', $Line . self::GS . $Repeat);
    }

    public function goToInt(int $Line, int $Repeat = 1): void
    {
        $this->goTo((string)$Line, (string)$Repeat);
    }

    public function goToIndex(string $Index, int $Repeat = 1): void
    {
        $this->add('&', '#' . $Index . self::GS . (string)$Repeat);
    }

    // Start
    public function startTransientDOM(string $InputPlace): void
    {
        $this->add('td', $InputPlace);
    }

    public function endTransientDOM(): void
    {
        $this->add('td', ';');
    }

    // Message
    // Type: warning, problem, help, success, none
    public function alert(string $Text, string $Type = 'none', string $Title = 'Alert', string $OkText = 'OK'): void
    {
        $this->add('Al', $Text . self::GS . ($Type === 'none' ? '' : $Type) . self::GS . ($Title === 'Alert' ? '' : $Title) . self::GS . ($OkText === 'OK' ? '' : $OkText));
    }

    public function message(string $Text, string $Type = 'none', string $Duration = '0'): void
    {
        $this->add('me', $Text . self::GS . ($Type === 'none' ? '' : $Type) . self::GS . ($Duration === '0' ? '' : $Duration));
    }

    public function messageInt(string $Text, string $Type, int $Duration): void
    {
        $this->message($Text, $Type, (string)$Duration);
    }

    public function messageDurationInt(string $Text, int $Duration): void
    {
        $this->message($Text, '', (string)$Duration);
    }

    // Type: log, info, warn, error, debug, trace, group, groupend, table
    public function consoleMessage(string $Text, string $Type = 'log'): void
    {
        $this->add('mc', str_replace("\n", '$[ln];', $Text) . ($Type === 'log' ? '' : self::GS . $Type));
    }

    public function consoleMessageAssert(string $Text, string $Condition): void
    {
        $this->add('ma', str_replace("\n", '$[ln];', $Text) . self::GS . $Condition);
    }

    // Enable
    //Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
    public function enableWebSocket(bool $Enable = true): void
    {
        $this->add('ew', $Enable ? '1' : '0');
    }

    public function enableWebSocketOnce(): void
    {
        $this->add('ew', '$');
    }

    public function addWebSocket(string $Path): void
    {
        $this->add('aw' . $Path);
    }

    // Disconnected WebSocket
    public function deleteWebSocket(string $Path): void
    {
        $this->add('dw' . $Path);
    }

    // Use
    // InputPlace Using Only For form Element
    public function useWebSocket(string $InputPlace): void
    {
        $this->add('uw' . $InputPlace);
    }

    public function useOnlyChangeUpdate(string $InputPlace): void
    {
        $this->add('uo' . $InputPlace);
    }

    // Condition And Loop
    // Condition And Loop Supports Brackets and Then
    // Type: warning, problem, help, success, none
    // Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
    // Nested Conditions and Nested Loops are Possible.
    public function confirmIsTrueAccept(string $Text = 'Are you sure you want to proceed?', string $Type = 'none', string $Title = 'Confirm', string $OkText = 'OK', string $CancelText = 'Cancel', int $Interval = 100): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'ct', ($Text === 'Are you sure you want to proceed?' ? '' : $Text) . self::GS . ($Type === 'none' ? '' : $Type) . self::GS . ($Title === 'Confirm' ? '' : $Title) . self::GS . ($OkText === 'OK' ? '' : $OkText) . self::GS . ($CancelText === 'Cancel' ? '' : $CancelText));
        return $this;
    }

    public function confirmIsFalseAccept(string $Text = 'Are you sure you want to proceed?', string $Type = 'none', string $Title = 'Confirm', string $OkText = 'OK', string $CancelText = 'Cancel', int $Interval = 100): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'cf', ($Text === 'Are you sure you want to proceed?' ? '' : $Text) . self::GS . ($Type === 'none' ? '' : $Type) . self::GS . ($Title === 'Confirm' ? '' : $Title) . self::GS . ($OkText === 'OK' ? '' : $OkText) . self::GS . ($CancelText === 'Cancel' ? '' : $CancelText));
        return $this;
    }

    public function isGreaterThan(string $FirstValue, string $SecondValue, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'gt', $FirstValue . self::GS . $SecondValue);
        return $this;
    }

    public function isLessThan(string $FirstValue, string $SecondValue, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'lt', $FirstValue . self::GS . $SecondValue);
        return $this;
    }

    public function isEqualTo(string $FirstValue, string $SecondValue, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'et', $FirstValue . self::GS . $SecondValue);
        return $this;
    }

    public function isNotEqualTo(string $FirstValue, string $SecondValue, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'Nt', $FirstValue . self::GS . $SecondValue);
        return $this;
    }

    public function exist(string $Value, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'ex', $Value);
        return $this;
    }

    public function notExist(string $Value, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'nx', $Value);
        return $this;
    }

    public function isTrue(string $Value, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'tr', $Value);
        return $this;
    }

    public function isFalse(string $Value, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'fa', $Value);
        return $this;
    }

    public function isMatchMedia(string $Value, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'mm', $Value);
        return $this;
    }

    public function isNotMatchMedia(string $Value, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'nm', $Value);
        return $this;
    }

    public function include(string $Text, string $Value, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'In', $Value . self::GS . $Text);
        return $this;
    }

    public function notInclude(string $Text, string $Value, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'Nn', $Value . self::GS . $Text);
        return $this;
    }

    public function elementExists(string $InputPlace, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'eE', $InputPlace);
        return $this;
    }

    public function elementNotExists(string $InputPlace, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'nE', $InputPlace);
        return $this;
    }

    public function isRegexMatch(string $Value, string $Pattern, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 're', $Value . self::GS . $Pattern);
        return $this;
    }

    public function isRegexNotMatch(string $Value, string $Pattern, int $Interval = -1): WebForms
    {
        $this->add((($Interval >= 0) ? '{(' . (string)$Interval . ')' : '{') . 'rn', $Value . self::GS . $Pattern);
        return $this;
    }

    // In: Everything Becomes A JSON List.
    // Key: Creates A Temporary Data In The Browser IndexedDB.
    // Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
    public function forEach(string $Path, string $In, string $Key = '.'): WebForms
    {
        $this->add('{fe', $Path . self::GS . $In . self::GS . $Key);
        return $this;
    }

    public function break(): void
    {
        $this->add(';');
    }

    public function else(): WebForms
    {
        $this->add('}e');
        return $this;
    }

    public function startBracket(): void
    {
        $this->add('{');
    }

    public function endBracket(): void
    {
        $this->add('}');
    }

    // Used Then In Condition And Loop Methods
    public function then(?WebForms $newForm): WebForms
    {
        if ($newForm === null) {
            return $this;
        }

        $data = $newForm->getWebFormsData();

        if ($data !== '') {
            if (strpos($data, "\n") !== false) {
                $newForm->addToUp('{');
                $newForm->add('}');
            }
        }

        $this->appendForm($newForm);
        return $this;
    }

    public function thenClosure(callable $configure): WebForms
    {
        $newForm = new WebForms();
        $configure($newForm);

        $data = $newForm->getWebFormsData();

        if ($data !== '') {
            if (strpos($data, "\n") !== false) {
                $newForm->addToUp('{');
                $newForm->add('}');
            }
        }

        $this->appendForm($newForm);
        return $this;
    }

    public function repeat(WebForms $newForm, int $repeat): WebForms
    {
        if ($newForm === null) {
            return $this;
        }

        $bodyData = $newForm->getWebFormsData();

        if ($bodyData === '') {
            return $this;
        }

        $startLine = -count(explode("\n", $bodyData));

        $this->appendForm($newForm);
        $this->goToInt($startLine, $repeat - 1);

        return $this;
    }

    public function repeatWithIndex(WebForms $newForm, int $repeat, string $index): WebForms
    {
        if ($newForm === null) {
            return $this;
        }

        $this->goToIndex($index);
        $this->startIndex($index);

        $bodyData = $newForm->getWebFormsData();

        if ($bodyData === '') {
            return $this;
        }

        $this->appendForm($newForm);

        if ($index === '') {
            $indexNumber = -1;
            foreach (explode("\n", $this->getWebFormsData()) as $x) {
                if (strpos($x, '#') === 0) {
                    $indexNumber++;
                }
            }
            $this->goToInt($indexNumber, $repeat - 1);
        } else {
            $this->goToIndex($index, $repeat - 1);
        }

        return $this;
    }

    public function repeatClosure(callable $configure, int $repeat): WebForms
    {
        $newForm = new WebForms();
        $configure($newForm);
        return $this->repeat($newForm, $repeat);
    }

    public function repeatClosureWithIndex(callable $configure, int $repeat, string $index): WebForms
    {
        $newForm = new WebForms();
        $configure($newForm);
        return $this->repeatWithIndex($newForm, $repeat, $index);
    }

    // Async
    // It Supports Brackets and Then
    public function async(): WebForms
    {
        $this->add('{(a)');
        return $this;
    }

    public function delay(string $MiliSecond): void
    {
        $this->add('De', $MiliSecond);
    }

    public function delayInt(int $MiliSecond): void
    {
        $this->delay((string)$MiliSecond);
    }

    // Option
    public function changeOption(string $Name, string $Value): void
    {
        $this->add('co', $Name . self::GS . $Value);
    }

    public function resetOption(?string $Name = null): void
    {
        if ($Name !== null) {
            $this->add('ro', $Name);
        } else {
            $this->add('ro');
        }
    }

    // Format Storage
    public function createFormatStorage(string $Key, string $Data): void
    {
        $this->add('.C', $Key . self::GS . $Data);
    }

    public function deleteFormatStorage(string $Key): void
    {
        $this->add('.D', $Key);
    }

    public function addJSON(string $Key, string $Path, string $Value): void
    {
        $this->add('.a', $Key . self::GS . 'j' . self::GS . $Value . self::GS . $Path);
    }

    // Name: For Support Attribute, Set Double At Sign (@@) Before Name.
    public function addXML(string $Key, string $Path, string $Name, ?string $Value = null): void
    {
        $this->add('.a', $Key . self::GS . 'x' . self::GS . $Name . self::GS . $Value . self::GS . $Path);
    }

    public function addINI(string $Key, string $Path, string $Value, bool $IsINILike = false): void
    {
        $this->add('.a', $Key . self::GS . 'i' . self::GS . ($IsINILike ? '1' : '0') . self::GS . $Value . self::GS . $Path);
    }

    public function addTextLine(string $Key, string $Line, string $Text): void
    {
        $this->add('.a', $Key . self::GS . 't' . self::GS . $Text . self::GS . $Line);
    }

    public function addTextLineInt(string $Key, int $Line, string $Text): void
    {
        $this->addTextLine($Key, (string)$Line, $Text);
    }

    public function addVariable(string $Key, string $Value): void
    {
        $this->add('.a', $Key . self::GS . 'v' . self::GS . $Value);
    }

    public function updateJSON(string $Key, string $Path, string $Value): void
    {
        $this->add('.u', $Key . self::GS . 'j' . self::GS . $Value . self::GS . $Path);
    }

    public function updateXML(string $Key, string $Path, string $Value): void
    {
        $this->add('.u', $Key . self::GS . 'x' . self::GS . $Value . self::GS . $Path);
    }

    public function updateINI(string $Key, string $Path, string $Value, bool $IsINILike = false): void
    {
        $this->add('.u', $Key . self::GS . 'i' . self::GS . ($IsINILike ? '1' : '0') . self::GS . $Value . self::GS . $Path);
    }

    public function updateTexLine(string $Key, string $Line, string $Text): void
    {
        $this->add('.u', $Key . self::GS . 't' . self::GS . $Text . self::GS . $Line);
    }

    public function updateTexLineInt(string $Key, int $Line, string $Text): void
    {
        $this->updateTexLine($Key, (string)$Line, $Text);
    }

    public function updateVariable(string $Key, string $Value): void
    {
        $this->add('.u', $Key . self::GS . 'v' . self::GS . $Value);
    }

    public function increaceVariable(string $Key, string $Value): void
    {
        $this->add('.i', $Key . self::GS . 'v' . self::GS . $Value);
    }

    public function increaceVariableInt(string $Key, int $Value): void
    {
        $this->increaceVariable($Key, (string)$Value);
    }

    public function decreaseVariable(string $Key, int $Value): void
    {
        $this->increaceVariable($Key, (string)($Value * -1));
    }

    public function deleteJSON(string $Key, string $Path): void
    {
        $this->add('.d', $Key . self::GS . 'j' . self::GS . $Path);
    }

    public function deleteXML(string $Key, string $Path): void
    {
        $this->add('.d', $Key . self::GS . 'x' . self::GS . $Path);
    }

    public function deleteINI(string $Key, string $Path, bool $IsINILike = false): void
    {
        $this->add('.d', $Key . self::GS . 'i' . self::GS . ($IsINILike ? '1' : '0') . self::GS . $Path);
    }

    public function deleteTextLine(string $Key, string $Line): void
    {
        $this->add('.d', $Key . self::GS . 't' . self::GS . $Line);
    }

    public function deleteTextLineInt(string $Key, int $Line): void
    {
        $this->deleteTextLine($Key, (string)$Line);
    }

    public function deleteVariable(string $Key): void
    {
        $this->add('.d', $Key . self::GS . 'v');
    }

    // Template Engine
    // Pattern Example: {{value}}, ((value)), *value*, $value;
    public function bindJSONToTemplate(string $InputPlace, string $JSONText, string $Path, string $Pattern, bool $AlsoStartTag = true): void
    {
        $this->add('Tj' . $InputPlace, $JSONText . self::GS . $Path . self::GS . $Pattern . self::GS . ($AlsoStartTag ? '1' : '0'));
    }

    // Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
    public function bindXMLToTemplate(string $InputPlace, string $XMLText, string $Path, string $Pattern, bool $AlsoStartTag = true): void
    {
        $this->add('Tx' . $InputPlace, $XMLText . self::GS . $Path . self::GS . $Pattern . self::GS . ($AlsoStartTag ? '1' : '0'));
    }

    public function bindINIToTemplate(string $InputPlace, string $INIText, string $Path, string $Pattern, bool $AlsoStartTag = true): void
    {
        $this->add('Ti' . $InputPlace, $INIText . self::GS . $Path . self::GS . $Pattern . self::GS . ($AlsoStartTag ? '1' : '0'));
    }

    // Inject
    // Need Add @: to First of String
    public function inject(string $Value): string
    {
        return '$[' . $Value . '];';
    }

    // Action Control
    public function replaceActionControl(string $SearchValue, string $Value, bool $AddingToUp = false): void
    {
        if ($AddingToUp) {
            $this->addToUp('rE', $SearchValue . self::GS . $Value);
        } else {
            $this->add('rE', $SearchValue . self::GS . $Value);
        }
    }

    public function assignReplace(string $SearchValue, string $Value, int $Index = -1): void
    {
        $currentLine = $this->getLineByIndex($Index);
        if ($currentLine === '') {
            return;
        }

        $parts = explode('=', $currentLine, 2);
        $newName = ';' . $SearchValue . self::GS . $Value . self::GS . $parts[0];
        $newValue = count($parts) > 1 ? $parts[1] : '';

        $this->updateLineByIndex($Index, $newName, $newValue);
    }

    // Hash And Checksum
    public function setHash(): void
    {
        $this->add('SH');
    }

    public function setChecksum(): void
    {
        $this->add('CS');
    }

    public function checksumCalculation(string $Text): string
    {
        $sum = 0;
        $mod = 65536;
        $shift = 5;

        for ($i = 0; $i < strlen($Text); $i++) {
            $charCode = ord($Text[$i]);
            $sum = (($sum << $shift) | ($sum >> (16 - $shift))) ^ $charCode;
            $sum %= $mod;
        }

        return (string)$sum;
    }

    public function getChecksum(): string
    {
        return $this->checksumCalculation($this->getWebFormsData());
    }

    // Get
    public function getFormsActionData(): string
    {
        if (strlen($this->webFormsData) === 0) {
            return '';
        }

        return $this->webFormsData;
    }

    public function response(): string
    {
        return "[web-forms]\n" . $this->getFormsActionData();
    }

    public function getFormsActionDataLineBreak(): string
    {
        if (strlen($this->webFormsData) === 0) {
            return '';
        }

        $data = $this->webFormsData;
        $processedData = str_replace('"', '$[dq];', $data);
        return str_replace("\n", '$[sln];', $processedData);
    }

    // Export
    public function exportToHtmlComment(bool $AddLine = false): string
    {
        $response = str_replace('--', '$[dd];', $this->response());
        if (substr($response, -1) === '-') {
            $response = substr($response, 0, -1) . '$[da];';
        }

        return ($AddLine ? "\n" : '') . '<!--' . $response . '-->';
    }

    // Using it for SSE Response
    public function exportToLineBreak(?string $src = null): string
    {
        return '[web-forms]$[sln];' . $this->getFormsActionDataLineBreak();
    }

    public function getWebFormsData(): string
    {
        return $this->webFormsData;
    }

    public function appendForm(?WebForms $form): void
    {
        if ($form === null) {
            return;
        }

        $otherData = $form->getWebFormsData();
        if ($otherData !== '') {
            if (strlen($this->webFormsData) > 0) {
                $this->webFormsData .= "\n";
            }
            $this->webFormsData .= $otherData;
        }
    }

    public function clean(): void
    {
        $this->webFormsData = '';
    }
}


// Security class
class Security
{
    public function safeValue(string $Value): string
    {
        if (strlen($Value) < 1) {
            return $Value;
        }

        if ($Value[0] === '@') {
            $Value = '@' . $Value;
        }

        $Value = str_replace("\n", '$[ln];', $Value);
        $Value = str_replace(',@', '$[co];@', $Value);
        $Value = str_replace("\x1C", '', $Value); // char 28
        $Value = str_replace("\x1D", '', $Value); // char 29
        $Value = str_replace("\x1E", '', $Value); // char 30
        $Value = str_replace("\x1F", '', $Value); // char 31

        return $Value;
    }
}

// WebForms Place Criteria (WPC) DSL
class InputPlace
{
    public const Document = ',';
    public const Window = '`';
    // When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
    public const Root = '~';
    public const HTML = '.';
    public const Head = '^';
    public const ScreenOrientation = '%';
    public const All = '*';
    public const Parent = '/';
    public const Current = '$';
    public const Target = '!';
    public const Upper = '-';

    public static function id(string $Id): string
    {
        return $Id;
    }

    public static function name(string $Name): string
    {
        return '(' . $Name . ')';
    }

    public static function nameIndex(string $Name, int $Index): string
    {
        return '(' . $Name . ')' . (string)$Index;
    }

    public static function allNames(string $Name): string
    {
        return '(' . $Name . ')*';
    }

    public static function tag(string $Tag): string
    {
        return '<' . $Tag . '>';
    }

    public static function tagIndex(string $Tag, int $Index): string
    {
        return '<' . $Tag . '>' . (string)$Index;
    }

    public static function allTags(string $Tag): string
    {
        return '<' . $Tag . '>*';
    }

    public static function child(): string
    {
        return '<>';
    }

    public static function childIndex(int $Index): string
    {
        return '<>' . (string)$Index;
    }

    public static function allChild(): string
    {
        return '<>*';
    }

    public static function class(string $Class): string
    {
        return '{' . $Class . '}';
    }

    public static function classIndex(string $Class, int $Index): string
    {
        return '{' . $Class . '}' . (string)$Index;
    }

    public static function allClasses(string $Class): string
    {
        return '{' . $Class . '}*';
    }

    public static function attribute(string $Name): string
    {
        return '"' . $Name . '"';
    }

    public static function attributeIndex(string $Name, int $Index): string
    {
        return '"' . $Name . '"' . (string)$Index;
    }

    public static function allAttributes(string $Name): string
    {
        return '"' . $Name . '"*';
    }

    // Operator: '^', '$', '*', '~'
    public static function attributeValue(string $Name, string $Value, string $Operator = ''): string
    {
        $op = $Operator !== '' ? substr($Operator, 0, 1) : '';
        return '"' . $Name . $op . "'" . $Value . '"';
    }

    public static function attributeValueIndex(string $Name, string $Value, int $Index, string $Operator = ''): string
    {
        $op = $Operator !== '' ? substr($Operator, 0, 1) : '';
        return '"' . $Name . $op . "'" . $Value . '"' . (string)$Index;
    }

    public static function allAttributesValue(string $Name, string $Value, string $Operator = ''): string
    {
        $op = $Operator !== '' ? substr($Operator, 0, 1) : '';
        return '"' . $Name . $op . "'" . $Value . '"*';
    }

    public static function query(string $Query): string
    {
        return '*' . str_replace(['=', '|', '?'], ['$[eq];', '$[vb];', '$[qu];'], $Query);
    }

    public static function queryAll(string $Query): string
    {
        return '[' . str_replace(['=', '|', '?'], ['$[eq];', '$[vb];', '$[qu];'], $Query);
    }
}

class OutputPlace extends InputPlace { }

// Do not Add any Data Before or After it
class Fetch
{
    private const RS = "\x1E"; // (char)30
    private const US = "\x1F"; // (char)31

    // Method
    public static function random(int $MaxValue): string
    {
        return '@mr' . (string)$MaxValue;
    }

    public static function randomMinMax(int $MinValue, int $MaxValue): string
    {
        return '@mr' . (string)$MaxValue . self::RS . (string)$MinValue;
    }

    public static function spaceToChar(string $Text, string $Character = '-'): string
    {
        return '@sc' . $Character . self::RS . $Text;
    }

    public static function encodeURI(string $Text): string
    {
        return '@ue' . $Text;
    }

    public static function decodeURI(string $Text): string
    {
        return '@ud' . $Text;
    }

    public static function method(string $MethodName, ?array $Args = null): string
    {
        $returnValue = '@cm' . $MethodName;
        if ($Args !== null && count($Args) > 0) {
            // array_map('strval', $Args) دقیقاً معادل ToString() روی تمام آیتم‌ها در C# است
            $returnValue .= self::RS . implode(self::US, array_map('strval', $Args));
        }
        return $returnValue;
    }

    public static function moduleMethod(string $MethodName, ?array $Args = null): string
    {
        $returnValue = '@cM' . $MethodName;
        if ($Args !== null && count($Args) > 0) {
            $returnValue .= self::RS . implode(self::US, array_map('strval', $Args));
        }
        return $returnValue;
    }

    // MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
    public static function wasmMethod(string $WasmLanguage, string $WasmUrl, string $MethodName, ?array $Args = null, string $Key = '.'): string
    {
        $returnValue = '@wA' . $WasmLanguage . self::RS . $WasmUrl . self::RS . $MethodName;
        if ($Args !== null && count($Args) > 0) {
            $returnValue .= self::RS . implode(self::US, array_map('strval', $Args));
        }
        return $returnValue;
    }

    public static function script(string $ScriptText): string
    {
        return '@_' . str_replace("\n", '$[ln];', $ScriptText);
    }

    public static function loadUrl(string $Url, bool $FetchScript = false): string
    {
        return '@lu' . $Url . ($FetchScript ? self::RS . '1' : '');
    }

    public static function loadHtml(string $Url, string $FetchInputPlace = '', bool $FetchScript = false): string
    {
        return '@lh' . $Url . self::RS . ($FetchScript ? '1' : '0') . ($FetchInputPlace !== '' ? self::RS . $FetchInputPlace : '');
    }

    public static function loadLine(string $Url, int $Line): string
    {
        return '@ll' . $Url . self::RS . (string)$Line;
    }

    public static function loadINI(string $Url, string $Name, bool $IsINILike = false): string
    {
        return '@li' . $Url . self::RS . $Name . ($IsINILike ? self::RS . '1' : '');
    }

    // Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
    public static function loadJSON(string $Url, string $Name): string
    {
        return '@lj' . $Url . self::RS . $Name;
    }

    // Name: Name Or XPath; XPath Index Starts At 1
    public static function loadXML(string $Url, string $Name): string
    {
        return '@lx' . $Url . self::RS . $Name;
    }

    // MethodName: It's Check Function Or Variable
    public static function hasMethod(string $MethodName): string
    {
        return '@hm' . $MethodName;
    }

    public static function hasModuleMethod(string $MethodName): string
    {
        return '@hM' . $MethodName;
    }

    // This Method Return True Or False If Key Pressed
    // Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
    public static function getModifierState(string $Modifier): string
    {
        return '@ms' . $Modifier;
    }

    // Math
    public static function math(string $MethodName, ?array $Args = null): string
    {
        $returnValue = '@M#' . $MethodName;
        if ($Args !== null && count($Args) > 0) {
            $returnValue .= self::RS . implode(self::US, array_map('strval', $Args));
        }
        return $returnValue;
    }

    // Data
    public const DateYear = '@dy';
    // Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1 
    public const DateMonth = '@dm';
    public const DateDay = '@dd';
    public const DateDate = '@dD';
    public const DateHours = '@dh';
    public const DateMinutes = '@di';
    public const DateSeconds = '@ds';
    public const DateMilliseconds = '@dl';

    // String
    public const Space = '@sp';
    public const AtSign = '@sa';

    // Tag
    public static function getId(string $InputPlace): string
    {
        return '@$i' . $InputPlace;
    }

    public static function getName(string $InputPlace): string
    {
        return '@$n' . $InputPlace;
    }

    public static function getValue(string $InputPlace): string
    {
        return '@$v' . $InputPlace;
    }

    public static function getValueLength(string $InputPlace): string
    {
        return '@$e' . $InputPlace;
    }

    public static function getClass(string $InputPlace): string
    {
        return '@$c' . $InputPlace;
    }

    public static function getStyle(string $InputPlace): string
    {
        return '@$s' . $InputPlace;
    }

    public static function getTitle(string $InputPlace): string
    {
        return '@$l' . $InputPlace;
    }

    public static function getLabel(string $InputPlace): string
    {
        return '@$A' . $InputPlace;
    }

    public static function getText(string $InputPlace): string
    {
        return '@$t' . $InputPlace;
    }

    public static function getOuterText(string $InputPlace): string
    {
        return '@$o' . $InputPlace;
    }

    public static function getTextLength(string $InputPlace): string
    {
        return '@$g' . $InputPlace;
    }

    public static function getAttribute(string $InputPlace, string $Attribute): string
    {
        return '@$a' . $InputPlace . self::RS . $Attribute;
    }

    public static function getWidth(string $InputPlace): string
    {
        return '@$w' . $InputPlace;
    }

    public static function getHeight(string $InputPlace): string
    {
        return '@$h' . $InputPlace;
    }

    public static function getIsReadOnly(string $InputPlace): string
    {
        return '@$r' . $InputPlace;
    }

    public static function getSelectedIndex(string $InputPlace): string
    {
        return '@$x' . $InputPlace;
    }

    public static function getIndex(string $InputPlace): string
    {
        return '@$I' . $InputPlace;
    }

    public static function getTextAlign(string $InputPlace): string
    {
        return '@$T' . $InputPlace;
    }

    public static function getNodeLength(string $InputPlace): string
    {
        return '@$L' . $InputPlace;
    }

    public static function getIsVisible(string $InputPlace): string
    {
        return '@$V' . $InputPlace;
    }

    // Save
    public static function hasHash(string $Hash): string
    {
        return '@HH' . $Hash;
    }

    public static function cookie(string $Key): string
    {
        return '@co' . $Key;
    }

    public static function save(string $Key = '.', ?string $ReplaceValue = null): string
    {
        if ($ReplaceValue !== null) {
            return '@cs' . $Key . self::RS . $ReplaceValue;
        }
        return '@cs' . $Key;
    }

    public static function saveThenRemove(string $Key): string
    {
        return '@cl' . $Key;
    }

    public static function saveLength(string $Key = '.'): string
    {
        return '@cg' . $Key;
    }

    public static function cache(string $Key = '.', ?string $ReplaceValue = null): string
    {
        if ($ReplaceValue !== null) {
            return '@cd' . $Key . self::RS . $ReplaceValue;
        }
        return '@cd' . $Key;
    }

    public static function cacheThenRemove(string $Key): string
    {
        return '@ct' . $Key;
    }

    public static function cacheLength(string $Key = '.'): string
    {
        return '@cG' . $Key;
    }

    public static function savedLine(string $Key = '.', int $Line = 0): string
    {
        return '@lL' . $Key . '[' . (string)$Line;
    }

    public static function savedLineConsume(string $Key = '.'): string
    {
        return '@lL' . $Key;
    }

    // INIKey: Only Direct Key is Supported
    public static function savedINI(string $Key, string $INIKey): string
    {
        return '@lI' . $Key . '[' . $INIKey;
    }

    public static function cacheLine(string $Key = '.', int $Line = 0): string
    {
        return '@dL' . $Key . '[' . (string)$Line;
    }

    public static function cacheLineConsume(string $Key = '.'): string
    {
        return '@dL' . $Key;
    }

    // INIKey: Only Direct Key is Supported
    public static function cacheINI(string $Key, string $INIKey): string
    {
        return '@dI' . $Key . '[' . $INIKey;
    }

    // Format Storage
    public static function formatStore(string $Key): string
    {
        return '@fr' . $Key;
    }

    public static function formatStoreByXMLQuery(string $Key, string $XPath): string
    {
        return '@fx' . $Key . self::RS . $XPath;
    }

    public static function formatStoreByJSONQuery(string $Key, string $Query): string
    {
        return '@fj' . $Key . self::RS . $Query;
    }

    public static function formatStoreByINI(string $Key, string $Name): string
    {
        return '@fi' . $Key . self::RS . $Name;
    }

    public static function formatStoreByText(string $Key, int $Line): string
    {
        return '@ft' . $Key . self::RS . (string)$Line;
    }

    public static function formatStoreByVariable(string $Key): string
    {
        return '@fv' . $Key;
    }

    // State
    public static function hasState(string $Path): string
    {
        return '@hs' . $Path;
    }

    // SSE
    public static function sSEIsConnected(string $Path): string
    {
        return '@Sc' . $Path;
    }

    // WebSockets
    public static function webSocketsIsConnected(string $Path = ''): string
    {
        return '@Wc' . $Path;
    }

    // Document
    public const TabIsActive = '@da';

    // Window
    public const Href = '@wf';
    public const PathName = '@wP';
    
    public static function query(string $Name = '*'): string
    {
        return '@wq' . $Name;
    }
    
    public const Hash = '@wh';
    public const Host = '@wH';
    public const HostName = '@wn';
    public const Port = '@wT';
    public const Origin = '@wo';
    public const GetSelection = '@ws';
    public const ScrollX = '@wx';
    public const ScrollY = '@wy';
    
    public static function segment(int $Index): string
    {
        return '@wS' . (string)$Index;
    }
    
    // It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
    public static function hashSegment(int $Index): string
    {
        return '@wt' . (string)$Index;
    }

    // Navigator
    public const ClipboardText = '@nC';
    public const GeoLatitude = '@nW';
    public const GeoLongitude = '@nO';
    public const Language = '@nL';
    public const IsOnLine = '@no';
    public const UserAgent = '@na';

    // Screen
    public const ScreenWidth = '@sw';
    public const ScreenHeight = '@sh';
    public const ScreenOrientationType = '@so';
    public const ScreenOrientationAngle = '@sr';

    // Performance
    public const TimeOrigin = '@pt';
    public const PerformanceNow = '@pn';

    // Event
    public const Event = '@EV';
    public const EventSerialize = '@Es';
    public const EventKey = '@ek';
    public const EventWhich = '@ew';
    public const EventClientX = '@ex';
    public const EventClientY = '@ey';
    public const EventPageX = '@eX';
    public const EventPageY = '@eY';
    public const EventOffsetX = '@Ex';
    public const EventOffsetY = '@Ey';
    public const EventDeltaY = '@ed';
}

class WasmLanguage
{
    // The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
    public const C = 'c';
    public const CPP = 'c';
    public const Rust = 'rust';
    public const CSharp = 'csharp';
    // .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
    public const CSharpMediator = 'csharp-m';
    public const GO = 'go';
    public const JAVA = 'java';
    public const AssemblyScript = 'as';
}

class HtmlEvent
{
    public const OnAbort = 'onabort';
    public const OnAfterPrint = 'onafterprint';
    public const OnBeforePrint = 'onbeforeprint';
    public const OnBeforeUnload = 'onbeforeunload';
    public const OnBlur = 'onblur';
    public const OnCanPlay = 'oncanplay';
    public const OnCanPlayThrough = 'oncanplaythrough';
    public const OnChange = 'onchange';
    public const OnClick = 'onclick';
    public const OnCopy = 'oncopy';
    public const OnCut = 'oncut';
    public const OnDoubleClick = 'ondblclick';
    public const OnDrag = 'ondrag';
    public const OnDragEnd = 'ondragend';
    public const OnDragEnter = 'ondragenter';
    public const OnDragLeave = 'ondragleave';
    public const OnDragOver = 'ondragover';
    public const OnDragStart = 'ondragstart';
    public const OnDrop = 'ondrop';
    public const OnDurationChange = 'ondurationchange';
    public const OnEnded = 'onended';
    public const OnError = 'onerror';
    public const OnFocus = 'onfocus';
    public const OnFocusin = 'onfocusin';
    public const OnFocusOut = 'onfocusout';
    public const OnHashChange = 'onhashchange';
    public const OnInput = 'oninput';
    public const OnInvalid = 'oninvalid';
    public const OnKeyDown = 'onkeydown';
    public const OnKeyPress = 'onkeypress';
    public const OnKeyUp = 'onkeyup';
    public const OnLoad = 'onload';
    public const OnLoadedData = 'onloadeddata';
    public const OnLoadedMetaData = 'onloadedmetadata';
    public const OnLoadStart = 'onloadstart';
    public const OnMouseDown = 'onmousedown';
    public const OnMouseEnter = 'onmouseenter';
    public const OnMouseLeave = 'onmouseleave';
    public const OnMouseMove = 'onmousemove';
    public const OnMouseOver = 'onmouseover';
    public const OnMouseOut = 'onmouseout';
    public const OnMouseUp = 'onmouseup';
    public const OnOffline = 'onoffline';
    public const OnOnline = 'ononline';
    public const OnPageHide = 'onpagehide';
    public const OnPageShow = 'onpageshow';
    public const OnPaste = 'onpaste';
    public const OnPause = 'onpause';
    public const OnPlay = 'onplay';
    public const OnPlaying = 'onplaying';
    public const OnProgress = 'onprogress';
    public const OnRateChange = 'onratechange';
    public const OnResize = 'onresize';
    public const OnReset = 'onreset';
    public const OnScroll = 'onscroll';
    public const OnSearch = 'onsearch';
    public const OnSeeked = 'onseeked';
    public const OnSeeking = 'onseeking';
    public const OnSelect = 'onselect';
    public const OnStalled = 'onstalled';
    public const OnSubmit = 'onsubmit';
    public const OnSuspend = 'onsuspend';
    public const OnTimeUpdate = 'ontimeupdate';
    public const OnToggle = 'ontoggle';
    public const OnTouchCancel = 'ontouchcancel';
    public const OnTouchend = 'ontouchend';
    public const OnTouchMove = 'ontouchmove';
    public const OnTouchStart = 'ontouchstart';
    public const OnUnload = 'onunload';
    public const OnVolumeChange = 'onvolumechange';
    public const OnWaiting = 'onwaiting';
    public const OnWheel = 'onwheel';
}

class HtmlEventListener
{
    public const Abort = 'abort';
    public const AfterPrint = 'afterprint';
    public const BeforePrint = 'beforeprint';
    public const BeforeUnload = 'beforeunload';
    public const Blur = 'blur';
    public const CanPlay = 'canplay';
    public const CanPlayThrough = 'canplaythrough';
    public const Change = 'change';
    public const Click = 'click';
    public const Copy = 'copy';
    public const Cut = 'cut';
    public const DoubleClick = 'dblclick';
    public const Drag = 'drag';
    public const DragEnd = 'dragend';
    public const DragEnter = 'dragenter';
    public const DragLeave = 'dragleave';
    public const DragOver = 'dragover';
    public const DragStart = 'dragstart';
    public const Drop = 'drop';
    public const DurationChange = 'durationchange';
    public const Ended = 'ended';
    public const Error = 'error';
    public const Focus = 'focus';
    public const Focusin = 'focusin';
    public const FocusOut = 'focusout';
    public const HashChange = 'hashchange';
    public const Input = 'input';
    public const Invalid = 'invalid';
    public const KeyDown = 'keydown';
    public const KeyPress = 'keypress';
    public const KeyUp = 'keyup';
    public const Load = 'load';
    public const LoadedData = 'loadeddata';
    public const LoadedMetaData = 'loadedmetadata';
    public const LoadStart = 'loadstart';
    public const MouseDown = 'mousedown';
    public const MouseEnter = 'mouseenter';
    public const MouseLeave = 'mouseleave';
    public const MouseMove = 'mousemove';
    public const MouseOver = 'mouseover';
    public const MouseOut = 'mouseout';
    public const MouseUp = 'mouseup';
    public const Offline = 'offline';
    public const Online = 'online';
    public const PageHide = 'pagehide';
    public const PageShow = 'pageshow';
    public const Paste = 'paste';
    public const Pause = 'pause';
    public const Play = 'play';
    public const Playing = 'playing';
    public const Progress = 'progress';
    public const RateChange = 'ratechange';
    public const Resize = 'resize';
    public const Reset = 'reset';
    public const Scroll = 'scroll';
    public const Search = 'search';
    public const Seeked = 'seeked';
    public const Seeking = 'seeking';
    public const Select = 'select';
    public const Stalled = 'stalled';
    public const Submit = 'submit';
    public const Suspend = 'suspend';
    public const TimeUpdate = 'timeupdate';
    public const Toggle = 'toggle';
    public const TouchCancel = 'touchcancel';
    public const Touchend = 'touchend';
    public const TouchMove = 'touchmove';
    public const TouchStart = 'touchstart';
    public const Unload = 'unload';
    public const VolumeChange = 'volumechange';
    public const Waiting = 'waiting';
    public const Wheel = 'wheel';

    public const AnimationEnd = 'animationend';
    public const AnimationIteration = 'animationiteration';
    public const AnimationStart = 'animationstart';
    public const ContextMenu = 'contextmenu';
    public const FullScreenChange = 'fullscreenchange';
    public const FullScreenError = 'fullscreenerror';
    public const PopState = 'popstate';
    public const TransitionEnd = 'transitionend';
    public const Storage = 'storage';

    // Custom
    public const ScrollBottom = 'scrollbottom'; // Need Call EnableScrollBottomEvent Method Before
    public const ElementReached = 'elementreached'; // Need Call EnableReachedElementEvent Method Before
}

class ExtensionWebFormsMethods
{
    public static function child(string $Text, string $Value): string
    {
        if ($Text === '') {
            return $Value;
        }

        return $Text . '|' . $Value;
    }

    public static function parent(string $Text): string
    {
        if ($Text === '') {
            return $Text;
        }

        if (str_ends_with($Text, '|/') || str_ends_with($Text, '//')) {
            return $Text . '/';
        }

        return $Text . '|/';
    }

    public static function criteria(string $Text, string $Value): string
    {
        if ($Text === '') {
            return $Value;
        }

        return $Text . '?' . str_replace(['|', '?'], ['$[vb];', '$[qu];'], $Value);
    }

    public static function appendFetchReplace(string $Text, string $SearchValue, string $Value): string
    {
        $const = "\x1C";

        $Text = substr($Text, 1);
        return '@;' . $SearchValue . $const . $Value . $const . $Text;
    }

    public static function lineBreak(string $Text, bool $EncodeLine = false): string
    {
        $encode = $EncodeLine ? '$[sln];' : '';
        return str_replace(["\r\n", "\n", "\r"], $encode, $Text);
    }

    // Converts Numbers to Strings
    public static function toJSString(string $Text): string
    {
        return '"' . $Text . '"';
    }

    // Get JS Object Momentary 
    public static function toJSObject(string $Text): string
    {
        return '$' . $Text;
    }

    // Get JS Object Returned Value Once
    public static function toJSReturnObject(string $Text): string
    {
        return '$@' . $Text;
    }
}

?>
