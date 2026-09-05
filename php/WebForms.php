<?php
// WebForms.php 2.1.1 - The Back-End Part of WebForms Core Technology, Owned by Elanat (https://elanat.net)
// Compatible with WebFormsJS version 2.1

namespace WebFormsCore;

class WebForms
{
    private const GS = "\x1D"; // (char)29
    private const US = "\x1F"; // (char)31
    private string $webFormsData = '';

    private function add(string $name, ?string $value = null): void
    {
        if (strlen($this->webFormsData) > 0) {
            $this->webFormsData .= "\n";
        }
        $this->webFormsData .= $name;
        if ($value !== null) {
            $this->webFormsData .= '=' . $value;
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

    private function getLineByIndex(int $index): string
    {
        if (strlen($this->webFormsData) === 0) {
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

    private function updateLineByIndex(int $index, string $name, ?string $value = null): void
    {
        if (strlen($this->webFormsData) === 0) {
            return;
        }
        $lines = explode("\n", $this->webFormsData);
        if ($index < 0) {
            $index = count($lines) + $index;
        }
        if ($index < 0 || $index >= count($lines)) {
            return;
        }
        $lines[$index] = $name . (($value !== null && $value !== '') ? '=' . $value : '');
        $this->webFormsData = implode("\n", $lines);
    }

	// For Extension
    public function addLine(string $name, string $value): void { $this->add($name, $value); }

    // Add
	// Creates the Data if it does not exist; otherwise, Appends the New Value to the Existing Value.
    public function addId(string $inputPlace, string $id): void { $this->add('ai' . $inputPlace, $id); }
    public function addName(string $inputPlace, string $name): void { $this->add('an' . $inputPlace, $name); }
    public function addValue(string $inputPlace, string $value): void { $this->add('av' . $inputPlace, $value); }
    public function addClass(string $inputPlace, string $class): void { $this->add('ac' . $inputPlace, $class); }
    public function addStyle(string $inputPlace, string $style): void { $this->add('as' . $inputPlace, $style); }
    public function addStyleNameValue(string $inputPlace, string $name, string $value): void { $this->add('as' . $inputPlace, $name . ':' . $value); }
    public function addOptionTag(string $inputPlace, string $text, string $value, bool $selected = false): void { $this->add('ao' . $inputPlace, $value . self::GS . $text . ($selected ? self::GS . '1' : '')); }
    public function addCheckBoxTag(string $inputPlace, string $text, string $value, bool $checked = false): void { $this->add('ak' . $inputPlace, $value . self::GS . $text . ($checked ? self::GS . '1' : '')); }
    public function addTitle(string $inputPlace, string $title): void { $this->add('al' . $inputPlace, $title); }
    public function addLabel(string $inputPlace, string $label): void { $this->add('aA' . $inputPlace, $label); }
    public function addText(string $inputPlace, string $text): void { $this->add('at' . $inputPlace, str_replace("\n", '$[ln];', $text)); }
    public function addTextToUp(string $inputPlace, string $text): void { $this->add('pt' . $inputPlace, str_replace("\n", '$[ln];', $text)); }
    public function addAttribute(string $inputPlace, string $attribute, string $value = '', string $splitter = ''): void { $this->add('aa' . $inputPlace, $attribute . self::GS . ($splitter !== '' ? $splitter : '') . ($value !== '' ? self::GS . $value : '')); }
    public function addTag(string $inputPlace, string $tagName, string $id = ''): void { $this->add('nt' . $inputPlace, $tagName . ($id !== '' ? self::GS . $id : '')); }
    public function addTagToUp(string $inputPlace, string $tagName, string $id = ''): void { $this->add('ut' . $inputPlace, $tagName . ($id !== '' ? self::GS . $id : '')); }
    public function addTagBefore(string $inputPlace, string $tagName, string $id = ''): void { $this->add('bt' . $inputPlace, $tagName . ($id !== '' ? self::GS . $id : '')); }
    public function addTagAfter(string $inputPlace, string $tagName, string $id = ''): void { $this->add('ft' . $inputPlace, $tagName . ($id !== '' ? self::GS . $id : '')); }
    public function addHidden(string $inputPlace, string $name, string $value, string $id = ''): void { $this->add('ah' . $inputPlace, $name . self::GS . $value . ($id !== '' ? self::GS . $id : '')); }

    // Set
	// Creates the Data if it does not exist; otherwise, Replaces the Existing Value with the New Value.
    public function setId(string $inputPlace, string $id): void { $this->add('si' . $inputPlace, $id); }
    public function setName(string $inputPlace, string $name): void { $this->add('sn' . $inputPlace, $name); }
    public function setValue(string $inputPlace, string $value): void { $this->add('sv' . $inputPlace, $value); }
    public function setClass(string $inputPlace, string $class): void { $this->add('sc' . $inputPlace, $class); }
    public function setStyle(string $inputPlace, string $style): void { $this->add('ss' . $inputPlace, $style); }
    public function setStyleNameValue(string $inputPlace, string $name, string $value): void { $this->add('ss' . $inputPlace, $name . ':' . $value); }
    public function setOptionTag(string $inputPlace, string $text, string $value, bool $selected = false): void { $this->add('so' . $inputPlace, $value . self::GS . $text . ($selected ? self::GS . '1' : '')); }
    public function setChecked(string $inputPlace, bool $checked = false): void { $this->add('sk' . $inputPlace, $checked ? '1' : '0'); }
    public function setCheckBoxTag(string $inputPlace, string $text, string $value, bool $checked = false): void { $this->add('sk' . $inputPlace, $value . self::GS . $text . ($checked ? self::GS . '1' : '')); }
    public function setTitle(string $inputPlace, string $title): void { $this->add('sl' . $inputPlace, $title); }
    public function setLabel(string $inputPlace, string $label): void { $this->add('sA' . $inputPlace, $label); }
    public function setText(string $inputPlace, string $text): void { $this->add('st' . $inputPlace, str_replace("\n", '$[ln];', $text)); }
    public function setAttribute(string $inputPlace, string $attribute, string $value = ''): void { $this->add('sa' . $inputPlace, $attribute . self::GS . ($value !== '' ? self::GS . $value : '')); }
    public function setWidth(string $inputPlace, string|int $width): void { $this->add('sw' . $inputPlace, is_int($width) ? $width . 'px' : (string)$width); }
    public function setHeight(string $inputPlace, string|int $height): void { $this->add('sh' . $inputPlace, is_int($height) ? $height . 'px' : (string)$height); }
    public function setFontSize(string $inputPlace, string|int $size): void { $this->add('fs' . $inputPlace, is_int($size) ? $size . 'px' : (string)$size); }
    public function setMinLength(string $inputPlace, string|int $length): void { $this->add('mn' . $inputPlace, (string)$length); }
    public function setMaxLength(string $inputPlace, string|int $length): void { $this->add('mx' . $inputPlace, (string)$length); }
    public function setSelectedIndex(string $inputPlace, string|int $index): void { $this->add('ti' . $inputPlace, (string)$index); }
    public function setCheckedIndex(string $inputPlace, string|int $index, bool $checked): void { $this->add('ki' . $inputPlace, (string)$index . self::GS . ($checked ? '1' : '0')); }
    public function setBackgroundColor(string $inputPlace, string $color): void { $this->add('bc' . $inputPlace, $color); }
    public function setTextColor(string $inputPlace, string $color): void { $this->add('tc' . $inputPlace, $color); }
    public function setFontName(string $inputPlace, string $name): void { $this->add('fn' . $inputPlace, $name); }
    public function setFontBold(string $inputPlace, bool $bold): void { $this->add('fb' . $inputPlace, $bold ? '1' : '0'); }
    public function setVisible(string $inputPlace, bool $visible): void { $this->add('vi' . $inputPlace, $visible ? '1' : '0'); }
    public function setTextAlign(string $inputPlace, string $align): void { $this->add('ta' . $inputPlace, $align); }
    public function setReadOnly(string $inputPlace, bool $readOnly): void { $this->add('sr' . $inputPlace, $readOnly ? '1' : '0'); }
    public function setDisabled(string $inputPlace, bool $disabled): void { $this->add('sd' . $inputPlace, $disabled ? '1' : '0'); }
    public function setFocus(string $inputPlace, bool $focus): void { $this->add('sf' . $inputPlace, $focus ? '1' : '0'); }
    public function setSelectedValue(string $inputPlace, string $value): void { $this->add('ts' . $inputPlace, $value); }
    public function setCheckedValue(string $inputPlace, string $value, bool $checked): void { $this->add('ks' . $inputPlace, $value . self::GS . ($checked ? '1' : '0')); }

    // Insert
	// Creates the Data only if it does not exist; otherwise, does nothing.
    public function insertId(string $inputPlace, string $id): void { $this->add('ii' . $inputPlace, $id); }
    public function insertName(string $inputPlace, string $name): void { $this->add('in' . $inputPlace, $name); }
    public function insertValue(string $inputPlace, string $value): void { $this->add('iv' . $inputPlace, $value); }
    public function insertClass(string $inputPlace, string $class): void { $this->add('ic' . $inputPlace, $class); }
    public function insertStyle(string $inputPlace, string $style): void { $this->add('is' . $inputPlace, $style); }
    public function insertStyleNameValue(string $inputPlace, string $name, string $value): void { $this->add('is' . $inputPlace, $name . ':' . $value); }
    public function insertOptionTag(string $inputPlace, string $text, string $value, bool $selected = false): void { $this->add('io' . $inputPlace, $value . self::GS . $text . ($selected ? self::GS . '1' : '')); }
    public function insertCheckBoxTag(string $inputPlace, string $text, string $value, bool $checked = false): void { $this->add('ik' . $inputPlace, $value . self::GS . $text . ($checked ? self::GS . '1' : '')); }
    public function insertTitle(string $inputPlace, string $title): void { $this->add('il' . $inputPlace, $title); }
    public function insertLabel(string $inputPlace, string $label): void { $this->add('iA' . $inputPlace, $label); }
    public function insertText(string $inputPlace, string $text): void { $this->add('it' . $inputPlace, str_replace("\n", '$[ln];', $text)); }
    public function insertAttribute(string $inputPlace, string $attribute, string $value = '', string $splitter = ''): void { $this->add('ia' . $inputPlace, $attribute . self::GS . ($splitter !== '' ? $splitter : '') . ($value !== '' ? self::GS . $value : '')); }

    // Delete
    public function deleteId(string $inputPlace): void { $this->add('di' . $inputPlace); }
    public function deleteName(string $inputPlace): void { $this->add('dn' . $inputPlace); }
    public function deleteValue(string $inputPlace): void { $this->add('dv' . $inputPlace); }
    public function deleteClass(string $inputPlace, string $className): void { $this->add('dc' . $inputPlace, $className); }
    public function deleteStyle(string $inputPlace, string $styleName): void { $this->add('ds' . $inputPlace, $styleName); }
    public function deleteOptionTag(string $inputPlace, string $value): void { $this->add('do' . $inputPlace, $value); }
    public function deleteAllOptionTag(string $inputPlace): void { $this->add('do' . $inputPlace, '*'); }
    public function deleteCheckBoxTag(string $inputPlace, string $value): void { $this->add('dk' . $inputPlace, $value); }
    public function deleteAllCheckBoxTag(string $inputPlace): void { $this->add('dk' . $inputPlace, '*'); }
    public function deleteTitle(string $inputPlace): void { $this->add('dl' . $inputPlace); }
    public function deleteLabel(string $inputPlace): void { $this->add('dA' . $inputPlace); }
    public function deleteText(string $inputPlace): void { $this->add('dt' . $inputPlace); }
    public function deleteAttribute(string $inputPlace, string $attribute): void { $this->add('da' . $inputPlace, $attribute); }
    public function delete(string $inputPlace): void { $this->add('de' . $inputPlace); }
    public function deleteParent(string $inputPlace): void { $this->add('dp' . $inputPlace); }

    // Tag
    public function swapTag(string $inputPlace, string $outputPlace): void { $this->add('sp' . $inputPlace, $outputPlace); }
    public function setReflection(string $inputPlace, string $tag): void { $this->add('sR' . $inputPlace, $tag); }
    public function setReflectionByOutputPlace(string $inputPlace, string $outputPlace): void { $this->add('iR' . $inputPlace, $outputPlace); }
    public function setMorph(string $inputPlace, string $tag): void { $this->add('sM' . $inputPlace, $tag); }
    public function setMorphByOutputPlace(string $inputPlace, string $outputPlace): void { $this->add('iM' . $inputPlace, $outputPlace); }

    // Browser
    public function changeUrl(string $url): void { $this->add('cu', $url); }
    public function setHeadTitle(string $title): void { $this->add('ht', $title); }
    public function clipboardWriteText(string $text): void { $this->add('nw', $text); }
    public function scrollTo(string|int $x, string|int $y): void { $this->add('ws', (string)$x . self::GS . (string)$y); }
    public function historyGo(string|int $steps): void { $this->add('wg', (string)$steps); }
    public function reloadPage(): void { $this->add('lr'); }
    public function redirect(string $path): void { $this->add('lh', $path); }

    // Increase
    public function increaseMinLength(string $inputPlace, string|int $value): void { $this->add('+n' . $inputPlace, (string)$value); }
    public function increaseMaxLength(string $inputPlace, string|int $value): void { $this->add('+x' . $inputPlace, (string)$value); }
    public function increaseFontSize(string $inputPlace, string|int $value): void { $this->add('+f' . $inputPlace, (string)$value); }
    public function increaseWidth(string $inputPlace, string|int $value): void { $this->add('+w' . $inputPlace, (string)$value); }
    public function increaseHeight(string $inputPlace, string|int $value): void { $this->add('+h' . $inputPlace, (string)$value); }
    public function increaseValue(string $inputPlace, string|int $value): void { $this->add('+v' . $inputPlace, (string)$value); }
    
	// Decrease
    public function decreaseMinLength(string $inputPlace, string|int $value): void { $this->add('-n' . $inputPlace, (string)$value); }
    public function decreaseMaxLength(string $inputPlace, string|int $value): void { $this->add('-x' . $inputPlace, (string)$value); }
    public function decreaseFontSize(string $inputPlace, string|int $value): void { $this->add('-f' . $inputPlace, (string)$value); }
    public function decreaseWidth(string $inputPlace, string|int $value): void { $this->add('-w' . $inputPlace, (string)$value); }
    public function decreaseHeight(string $inputPlace, string|int $value): void { $this->add('-h' . $inputPlace, (string)$value); }
    public function decreaseValue(string $inputPlace, string|int $value): void { $this->add('-v' . $inputPlace, (string)$value); }

	// Event
	// ConstructorName: mouseevent, keyboardevent, uievent, focusevent, inputevent, event
	// All Method in "Event" Section Only Support Dynamic Args Once. To Support Invoking Dynamic Arguments on a Momentary Basis, Use "EventListener" Section Methods.
    public function triggerEvent(string $inputPlace, string $htmlEventListener, ?string $constructorName = null): void { $this->add('TE' . $inputPlace, $htmlEventListener . ($constructorName !== null ? self::GS . $constructorName : '')); }
    public function setPostEvent(string $inputPlace, string $htmlEvent, ?string $outputPlace = null): void { $this->add('Ep' . $inputPlace, $htmlEvent . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setPostEventAddView(string $inputPlace, string $htmlEvent): void { $this->add('Ep' . $inputPlace, $htmlEvent . self::GS . '+'); }
    public function setPostEventListener(string $inputPlace, string $htmlEventListener, ?string $outputPlace = null): void { $this->add('EP' . $inputPlace, $htmlEventListener . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setPostEventListenerAddView(string $inputPlace, string $htmlEventListener): void { $this->add('EP' . $inputPlace, $htmlEventListener . self::GS . '+'); }
    
    public function setGetEvent(string $inputPlace, string $htmlEvent, ?string $path = null, ?string $outputPlace = null): void { $this->add('Eg' . $inputPlace, $htmlEvent . self::GS . ($path ?? '#') . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setGetEventListener(string $inputPlace, string $htmlEventListener, ?string $path = null, ?string $outputPlace = null): void { $this->add('EG' . $inputPlace, $htmlEventListener . self::GS . ($path ?? '#') . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setPutEvent(string $inputPlace, string $htmlEvent, ?string $path = null, ?string $outputPlace = null): void { $this->add('Et' . $inputPlace, $htmlEvent . self::GS . ($path ?? '#') . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setPutEventListener(string $inputPlace, string $htmlEventListener, ?string $path = null, ?string $outputPlace = null): void { $this->add('ET' . $inputPlace, $htmlEventListener . self::GS . ($path ?? '#') . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setPatchEvent(string $inputPlace, string $htmlEvent, ?string $path = null, ?string $outputPlace = null): void { $this->add('Ea' . $inputPlace, $htmlEvent . self::GS . ($path ?? '#') . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setPatchEventListener(string $inputPlace, string $htmlEventListener, ?string $path = null, ?string $outputPlace = null): void { $this->add('EA' . $inputPlace, $htmlEventListener . self::GS . ($path ?? '#') . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setDeleteEvent(string $inputPlace, string $htmlEvent, ?string $path = null, ?string $outputPlace = null): void { $this->add('El' . $inputPlace, $htmlEvent . self::GS . ($path ?? '#') . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setDeleteEventListener(string $inputPlace, string $htmlEventListener, ?string $path = null, ?string $outputPlace = null): void { $this->add('EL' . $inputPlace, $htmlEventListener . self::GS . ($path ?? '#') . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setOptionsEvent(string $inputPlace, string $htmlEvent, ?string $path = null, ?string $outputPlace = null): void { $this->add('Eo' . $inputPlace, $htmlEvent . self::GS . ($path ?? '#') . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setOptionsEventListener(string $inputPlace, string $htmlEventListener, ?string $path = null, ?string $outputPlace = null): void { $this->add('EO' . $inputPlace, $htmlEventListener . self::GS . ($path ?? '#') . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setHeadEvent(string $inputPlace, string $htmlEvent, ?string $path = null): void { $this->add('Eh' . $inputPlace, $htmlEvent . self::GS . ($path ?? '#')); }
    public function setHeadEventListener(string $inputPlace, string $htmlEventListener, ?string $path = null): void { $this->add('EH' . $inputPlace, $htmlEventListener . self::GS . ($path ?? '#')); }
	// IsMultiPart: If this value is true, the data will be sent based on the Form and with the "content" key.
    public function setSendEvent(string $inputPlace, string $htmlEvent, string $data, ?string $path = null, string $method = 'POST', bool $isMultiPart = false, string $contentType = 'text/plain', ?string $outputPlace = null): void { $this->add('En' . $inputPlace, $htmlEvent . self::GS . str_replace(["\n", '"', "'"], ['$[ln];', '$[dq];', '$[sq];'], $data) . self::GS . ($path ?? '#') . self::GS . $method . self::GS . ($isMultiPart ? '1' : '0') . self::GS . $contentType . self::GS . $outputPlace); }
    public function setSendEventListener(string $inputPlace, string $htmlEventListener, string $data, ?string $path = null, string $method = 'POST', bool $isMultiPart = false, string $contentType = 'text/plain', ?string $outputPlace = null): void { $this->add('EN' . $inputPlace, $htmlEventListener . self::GS . str_replace("\n", '$[ln];', $data) . self::GS . ($path ?? '#') . self::GS . $method . self::GS . ($isMultiPart ? '1' : '0') . self::GS . $contentType . self::GS . $outputPlace); }
    
    public function setCommentEvent(string $inputPlace, string $htmlEvent, string|int|null $index = null, ?string $outputPlace = null): void { $this->add('Eb' . $inputPlace, $htmlEvent . self::GS . ($index !== null ? (string)$index : '') . self::GS . $outputPlace); }
    public function setCommentEventListener(string $inputPlace, string $htmlEventListener, string|int|null $index = null, ?string $outputPlace = null): void { $this->add('EB' . $inputPlace, $htmlEventListener . self::GS . ($index !== null ? (string)$index : '') . self::GS . $outputPlace); }
    
    private function buildArgsJoin(?array $args, string $prefix = ''): string {
        return ($args !== null && count($args) > 0) ? $prefix . '[' . implode(self::US, array_map('strval', $args)) : '';
    }

    public function setWasmEvent(string $inputPlace, string $htmlEvent, string $wasmLanguage, string $wasmUrl, string $methodName, ?array $args = null, ?string $outputPlace = null): void { $this->add('Ey' . $inputPlace, $htmlEvent . self::GS . $wasmLanguage . self::GS . $wasmUrl . self::GS . $methodName . self::GS . $this->buildArgsJoin($args) . self::GS . $outputPlace); }
    public function setWasmEventListener(string $inputPlace, string $htmlEventListener, string $wasmLanguage, string $wasmUrl, string $methodName, ?array $args = null, ?string $outputPlace = null): void { $this->add('EY' . $inputPlace, $htmlEventListener . self::GS . $wasmLanguage . self::GS . $wasmUrl . self::GS . $methodName . self::GS . $this->buildArgsJoin($args) . self::GS . $outputPlace); }
    
    public function setWebSocketEvent(string $inputPlace, string $htmlEvent, string $path): void { $this->add('Ew' . $inputPlace, $htmlEvent . self::GS . $path); }
    public function setWebSocketEventListener(string $inputPlace, string $htmlEventListener, string $path): void { $this->add('EW' . $inputPlace, $htmlEventListener . self::GS . $path); }
    
    public function setSSEEvent(string $inputPlace, string $htmlEvent, string $path, ?string $outputPlace = null, bool $shouldReconnect = true, int $reconnectTryTimeout = 3000): void { $this->add('Ee' . $inputPlace, $htmlEvent . self::GS . $path . self::GS . ($shouldReconnect ? '1' : '0') . self::GS . (string)$reconnectTryTimeout . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function setSSEEventListener(string $inputPlace, string $htmlEventListener, string $path, ?string $outputPlace = null, bool $shouldReconnect = true, int $reconnectTryTimeout = 3000): void { $this->add('EE' . $inputPlace, $htmlEventListener . self::GS . $path . self::GS . ($shouldReconnect ? '1' : '0') . self::GS . (string)$reconnectTryTimeout . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    
    public function setFrontEvent(string $inputPlace, string $htmlEvent, string $modulePath, ?array $args = null, ?string $outputPlace = null): void { $this->add('Ej' . $inputPlace, $htmlEvent . self::GS . $modulePath . self::GS . $outputPlace . $this->buildArgsJoin($args, self::GS)); }
    public function setFrontEventListener(string $inputPlace, string $htmlEventListener, string $modulePath, ?array $args = null, ?string $outputPlace = null): void { $this->add('EJ' . $inputPlace, $htmlEventListener . self::GS . $modulePath . self::GS . $outputPlace . $this->buildArgsJoin($args, self::GS)); }
    
    public function setMasterPagesEvent(string $inputPlace, string $htmlEvent, ?string $outputPlace = null): void { $this->add('Eu' . $inputPlace, $htmlEvent . self::GS . $outputPlace); }
    public function setMasterPagesEventListener(string $inputPlace, string $htmlEventListener, ?string $outputPlace = null): void { $this->add('EU' . $inputPlace, $htmlEventListener . self::GS . $outputPlace); }
    public function setPreventDefaultEvent(string $inputPlace, string $htmlEvent): void { $this->add('Ed' . $inputPlace, $htmlEvent); }
    public function setPreventDefaultEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('ED' . $inputPlace, $htmlEventListener); }
    public function setStopPropagationEvent(string $inputPlace, string $htmlEvent): void { $this->add('Es' . $inputPlace, $htmlEvent); }
    public function setStopPropagationEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('ES' . $inputPlace, $htmlEventListener); }
    
    public function setMethodEvent(string $inputPlace, string $htmlEvent, string $methodName, ?array $args = null): void { $this->add('Em' . $inputPlace, $htmlEvent . self::GS . $methodName . $this->buildArgsJoin($args, self::GS)); }
    public function setMethodEventListener(string $inputPlace, string $htmlEventListener, string $methodName, ?array $args = null): void { $this->add('EM' . $inputPlace, $htmlEventListener . self::GS . $methodName . $this->buildArgsJoin($args, self::GS)); }
    public function setModuleMethodEvent(string $inputPlace, string $htmlEvent, string $methodName, ?array $args = null): void { $this->add('Ex' . $inputPlace, $htmlEvent . self::GS . $methodName . $this->buildArgsJoin($args, self::GS)); }
    public function setModuleMethodEventListener(string $inputPlace, string $htmlEventListener, string $methodName, ?array $args = null): void { $this->add('EX' . $inputPlace, $htmlEventListener . self::GS . $methodName . $this->buildArgsJoin($args, self::GS)); }
    
    public function assignConfirmEvent(string $inputPlace, string $htmlEvent, string $text = 'Are you sure you want to proceed?', string $type = 'none', string $title = 'Confirm', string $okText = 'OK', string $cancelText = 'Cancel'): void { $this->add('Ef' . $inputPlace, $htmlEvent . self::GS . ($text === 'Are you sure you want to proceed?' ? '' : $text) . self::GS . ($type === 'none' ? '' : $type) . self::GS . ($title === 'Confirm' ? '' : $title) . self::GS . ($okText === 'OK' ? '' : $okText) . self::GS . ($cancelText === 'Cancel' ? '' : $cancelText)); }

    public function removePostEvent(string $inputPlace, string $htmlEvent): void { $this->add('Rp' . $inputPlace, $htmlEvent); }
    public function removePostEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RP' . $inputPlace, $htmlEventListener); }
    public function removeGetEvent(string $inputPlace, string $htmlEvent): void { $this->add('Rg' . $inputPlace, $htmlEvent); }
    public function removeGetEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RG' . $inputPlace, $htmlEventListener); }
    public function removePutEvent(string $inputPlace, string $htmlEvent): void { $this->add('Rt' . $inputPlace, $htmlEvent); }
    public function removePutEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RT' . $inputPlace, $htmlEventListener); }
    public function removePatchEvent(string $inputPlace, string $htmlEvent): void { $this->add('Ra' . $inputPlace, $htmlEvent); }
    public function removePatchEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RA' . $inputPlace, $htmlEventListener); }
    public function removeDeleteEvent(string $inputPlace, string $htmlEvent): void { $this->add('Rl' . $inputPlace, $htmlEvent); }
    public function removeDeleteEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RL' . $inputPlace, $htmlEventListener); }
    public function removeOptionsEvent(string $inputPlace, string $htmlEvent): void { $this->add('Ro' . $inputPlace, $htmlEvent); }
    public function removeOptionsEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RO' . $inputPlace, $htmlEventListener); }
    public function removeHeadEvent(string $inputPlace, string $htmlEvent): void { $this->add('Rh' . $inputPlace, $htmlEvent); }
    public function removeHeadEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RH' . $inputPlace, $htmlEventListener); }
    public function removeSendEvent(string $inputPlace, string $htmlEvent): void { $this->add('Rn' . $inputPlace, $htmlEvent); }
    public function removeSendEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RN' . $inputPlace, $htmlEventListener); }
    public function removeCommentEvent(string $inputPlace, string $htmlEvent): void { $this->add('Rb' . $inputPlace, $htmlEvent); }
    public function removeCommentEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RB' . $inputPlace, $htmlEventListener); }
    public function removeWasmEvent(string $inputPlace, string $htmlEvent): void { $this->add('Ry' . $inputPlace, $htmlEvent); }
    public function removeWasmEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RY' . $inputPlace, $htmlEventListener); }
    public function removeWebSocketEvent(string $inputPlace, string $htmlEvent): void { $this->add('Rw' . $inputPlace, $htmlEvent); }
    public function removeWebSocketEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RW' . $inputPlace, $htmlEventListener); }
    public function removeSSEEvent(string $inputPlace, string $htmlEvent): void { $this->add('Re' . $inputPlace, $htmlEvent); }
    public function removeSSEEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RE' . $inputPlace, $htmlEventListener); }
    public function removeFrontEvent(string $inputPlace, string $htmlEvent): void { $this->add('Rj' . $inputPlace, $htmlEvent); }
    public function removeFrontEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RJ' . $inputPlace, $htmlEventListener); }
    public function removePreventDefaultEvent(string $inputPlace, string $htmlEvent): void { $this->add('Rd' . $inputPlace, $htmlEvent); }
    public function removePreventDefaultEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RD' . $inputPlace, $htmlEventListener); }
    public function removeMasterPagesEvent(string $inputPlace, string $htmlEvent): void { $this->add('Ru' . $inputPlace, $htmlEvent); }
    public function removeMasterPagesEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RU' . $inputPlace, $htmlEventListener); }
    public function removeStopPropagationEvent(string $inputPlace, string $htmlEvent): void { $this->add('Rs' . $inputPlace, $htmlEvent); }
    public function removeStopPropagationEventListener(string $inputPlace, string $htmlEventListener): void { $this->add('RS' . $inputPlace, $htmlEventListener); }
    public function removeMethodEvent(string $inputPlace, string $htmlEvent, string $methodName): void { $this->add('Rm' . $inputPlace, $htmlEvent . self::GS . $methodName); }
    public function removeMethodEventListener(string $inputPlace, string $htmlEventListener, string $methodName): void { $this->add('RM' . $inputPlace, $htmlEventListener . self::GS . $methodName); }
    public function removeModuleMethodEvent(string $inputPlace, string $htmlEvent, string $methodName): void { $this->add('Rx' . $inputPlace, $htmlEvent . self::GS . $methodName); }
    public function removeModuleMethodEventListener(string $inputPlace, string $htmlEventListener, string $methodName): void { $this->add('RX' . $inputPlace, $htmlEventListener . self::GS . $methodName); }
    public function removeConfirmEvent(string $inputPlace, string $htmlEvent): void { $this->add('Rf' . $inputPlace, $htmlEvent); }

	// Custom Event
	// This Method Is Compatible With EventListener And May Not Be Compatible With Events Written As Attributes In Some Browsers.
	// Watch: attribute, style, text, children, value
	// Compare: greater, less, equal, notequal, includes, startswith, endswith, matches, changed, inrange, lengthgreater, lengthless, lengthequal
	// Range: Only Use For Compare With inrange Value. Split By Comma ","
	// Key: Only Use For Watch With attribute And style Value
    public function createCustomDOMEvent(string $inputPlace, string $eventName, string $watch, string $key, string $compare, string $value, string $range, bool $immediate = false, string|int $delay = '0'): void { $this->add('eC' . $inputPlace, $eventName . self::GS . $watch . self::GS . $key . self::GS . $compare . self::GS . $value . self::GS . $range . self::GS . ($immediate ? '1' : '0') . self::GS . (string)$delay); }
    public function enableScrollBottomEvent(bool $enable = true): void { $this->add('eb', $enable ? '1' : '0'); }
    public function enableReachedElementEvent(string $inputPlace, bool $once, bool $enable = true): void { $this->add('er' . $inputPlace, ($once ? '1' : '0') . self::GS . ($enable ? '1' : '0')); }

    // Module
    public function loadModule(string $modulePath, ?array $methods = null): void { $this->add('Ml', $modulePath . ($methods !== null && count($methods) > 0 ? self::GS . '[' . implode(self::US, $methods) : '')); }
    public function unloadModule(string $modulePath): void { $this->add('Mu', $modulePath); }
    public function deleteModuleMethod(string $methodName): void { $this->add('Md', $methodName); }

    // Unit Testing
    public function assertEqual(string $inputPlace, string $tag): void { $this->add('At' . $inputPlace, str_replace("\n", '$[ln];', $tag)); }
    public function assertEqualByOutputPlace(string $inputPlace, string $outputPlace): void { $this->add('Ao' . $inputPlace, $outputPlace); }
    
	// Debug
	public function createDebugger(bool $pause = false): void { $this->add('Dc', $pause ? '1' : '0'); }

    // Service Worker
	// To Use Service Worker, You Need To Add The Elanat Dedicated Module (service-worker.js) On The Client Side
    public function serviceWorkerRegister(?string $path = null, ?string $scopePath = null): void { $this->add('wR', ($path ?? '') . self::GS . ($scopePath ?? '')); }
    public function serviceWorkerPreCacheStatic(array $pathList): void { $this->add('wp', implode(self::GS, $pathList)); }
    public function serviceWorkerDynamicCache(string $path, string|int $seconds = ''): void { $this->add('wc', $path . ((string)$seconds !== '' ? self::GS . (string)$seconds : '')); }
    public function serviceWorkerDeleteDynamicCache(?string $path = null): void { $this->add('wd', $path ?? ''); }
    public function serviceWorkerDynamicCacheTTLUpdate(string $path, string|int $seconds = ''): void { $this->add('wt', $path . ((string)$seconds !== '' ? self::GS . (string)$seconds : '')); }
	// Path: Support Wildcard Automatically And Also Support Regex If Use "re:" Before Pattern
	// Type: Type Is Cache Strategy. cachefirst, networkfirst, cacheonly, networkonly, stalerevalidate (Fast From Cache, Updates Simultaneously From The Network)
	// CacheDynamic: If True, Any Successful Network Response For That Route Will Be Stored In The Dynamic Cache
	public function serviceWorkerRouteSet(string $path, string $type, bool $cacheDynamic = false): void { $this->add('wr', $path . self::GS . $type . ($cacheDynamic ? self::GS . '1' : '')); }
    public function serviceWorkerRouteAlias(string $path, string $to): void { $this->add('wa', $path . self::GS . $to); }
	// Delete All Route And Alias
	public function serviceWorkerDeleteRouteAlias(?string $path = null): void { $this->add('wC', $path ?? ''); }
    public function serviceWorkerDeleteRoute(?string $path = null): void { $this->add('wD', $path ?? ''); }

    // SSE
    public function disconnectSSE(?string $path = null): void { $this->add('Ds', $path ?? ''); }
    public function disconnectAllSSE(): void { $this->add('Ds'); }
    
	// State
	public function addState(?string $path = null, ?string $title = null): void { $this->add('AS', ($path ?? '') . self::GS . ($title ?? '')); }
    public function saveState(?string $path = null, ?string $title = null): void { $this->add('As', ($path ?? '') . self::GS . ($title ?? '')); }
    public function loadState(string $path): void { $this->add('ls', $path); }
    public function deleteState(?string $path = null): void { $this->add('DS', $path ?? ''); }
    public function deleteAllState(): void { $this->add('DS', '*'); }

    // Cookie
    public function setCookie(string $key, string $value, string|int $seconds, ?string $path = null): void { $this->add('sC', $key . self::GS . $value . self::GS . (string)$seconds . ($path !== null ? self::GS . $path : '')); }

    // Save (Session Cache)
    public function saveId(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gi' . $inputPlace, $key);
    }

    public function saveName(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gn' . $inputPlace, $key);
    }

    public function saveValue(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gv' . $inputPlace, $key);
    }

    public function saveValueLength(string $inputPlace, string $key = '.'): void
    {
        $this->add('@ge' . $inputPlace, $key);
    }

    public function saveClass(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gc' . $inputPlace, $key);
    }

    public function saveStyle(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gs' . $inputPlace, $key);
    }

    public function saveTitle(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gl' . $inputPlace, $key);
    }

    public function saveLabel(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gA' . $inputPlace, $key);
    }

    public function saveText(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gt' . $inputPlace, $key);
    }

    public function saveOuterText(string $inputPlace, string $key = '.'): void
    {
        $this->add('@go' . $inputPlace, $key);
    }

    public function saveTextLength(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gg' . $inputPlace, $key);
    }

    public function saveAttribute(string $inputPlace, string $attribute, string $key = '.'): void
    {
        $this->add('@ga' . $inputPlace, $key . self::GS . $attribute);
    }

    public function saveWidth(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gw' . $inputPlace, $key);
    }

    public function saveHeight(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gh' . $inputPlace, $key);
    }

    public function saveReadOnly(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gr' . $inputPlace, $key);
    }

    public function saveSelectedIndex(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gx' . $inputPlace, $key);
    }

    public function saveTextAlign(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gT' . $inputPlace, $key);
    }

    public function saveNodeLength(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gL' . $inputPlace, $key);
    }

    public function saveVisible(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gV' . $inputPlace, $key);
    }

    public function saveUrl(string $url, bool $fetchScript = false, string $key = '.'): void
    {
        $this->add('@gu', $key . self::GS . $url . ($fetchScript ? self::GS . '1' : ''));
    }

    public function saveIndex(string $inputPlace, string $key = '.'): void
    {
        $this->add('@gI' . $inputPlace, $key);
    }

    public function removeSave(string $cacheKey): void
    {
        $this->add('rs', $cacheKey);
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

    public function addSaveValue(string $cacheKey, string $value): void
    {
        $this->add('SA', $cacheKey . self::GS . str_replace("\n", '$[ln];', $value));
    }

    public function insertSaveValue(string $cacheKey, string $value): void
    {
        $this->add('SI', $cacheKey . self::GS . str_replace("\n", '$[ln];', $value));
    }

    public function appendSaveValue(string $cacheKey, string $value): void
    {
        $this->add('SP', $cacheKey . self::GS . str_replace("\n", '$[ln];', $value));
    }

    public function replaceSaveValue(string $cacheKey, string $searchValue, string $value): void
    {
        $this->add('SR', $cacheKey . self::GS . str_replace("\n", '$[ln];', $value) . self::GS . str_replace("\n", '$[ln];', $searchValue));
    }

    // Cache
    public function cacheId(string $inputPlace, string $key = '.'): void
    {
        $this->add('@ci' . $inputPlace, $key);
    }

    public function cacheName(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cn' . $inputPlace, $key);
    }

    public function cacheValue(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cv' . $inputPlace, $key);
    }

    public function cacheValueLength(string $inputPlace, string $key = '.'): void
    {
        $this->add('@ce' . $inputPlace, $key);
    }

    public function cacheClass(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cc' . $inputPlace, $key);
    }

    public function cacheStyle(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cs' . $inputPlace, $key);
    }

    public function cacheTitle(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cl' . $inputPlace, $key);
    }

    public function cacheLabel(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cA' . $inputPlace, $key);
    }

    public function cacheText(string $inputPlace, string $key = '.'): void
    {
        $this->add('@ct' . $inputPlace, $key);
    }

    public function cacheOuterText(string $inputPlace, string $key = '.'): void
    {
        $this->add('@co' . $inputPlace, $key);
    }

    public function cacheTextLength(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cg' . $inputPlace, $key);
    }

    public function cacheAttribute(string $inputPlace, string $attribute, string $key = '.'): void
    {
        $this->add('@ca' . $inputPlace, $key . self::GS . $attribute);
    }

    public function cacheWidth(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cw' . $inputPlace, $key);
    }

    public function cacheHeight(string $inputPlace, string $key = '.'): void
    {
        $this->add('@ch' . $inputPlace, $key);
    }

    public function cacheReadOnly(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cr' . $inputPlace, $key);
    }

    public function cacheSelectedIndex(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cx' . $inputPlace, $key);
    }

    public function cacheTextAlign(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cT' . $inputPlace, $key);
    }

    public function cacheNodeLength(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cL' . $inputPlace, $key);
    }

    public function cacheVisible(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cV' . $inputPlace, $key);
    }

    public function cacheUrl(string $url, bool $fetchScript = false, string $key = '.'): void
    {
        $this->add('@cu', $key . self::GS . $url . ($fetchScript ? self::GS . '1' : ''));
    }

    public function cacheIndex(string $inputPlace, string $key = '.'): void
    {
        $this->add('@cI' . $inputPlace, $key);
    }

    public function removeCache(string $cacheKey): void
    {
        $this->add('rd', $cacheKey);
    }

    public function removeAllCache(): void
    {
        $this->add('rd', '*');
    }

    // Calling the SetCache Method Causes Action Control Requests Triggered by events using the GET, POST, PUT, PATCH, DELETE, and OPTIONS Methods, as well as Requests Triggered by the Send event, to be Cached, so the Request will not be Sent to the Server Again.
	public function setCache(string|int|null $second = null): void
    {
        $this->add('cd', $second !== null ? (string)$second : '*');
    }

    public function addCacheValue(string $cacheKey, string $value): void
    {
        $this->add('CA', $cacheKey . self::GS . str_replace("\n", '$[ln];', $value));
    }

    public function insertCacheValue(string $cacheKey, string $value): void
    {
        $this->add('CI', $cacheKey . self::GS . str_replace("\n", '$[ln];', $value));
    }

    public function appendCacheValue(string $cacheKey, string $value): void
    {
        $this->add('CP', $cacheKey . self::GS . str_replace("\n", '$[ln];', $value));
    }

    public function replaceCacheValue(string $cacheKey, string $searchValue, string $value): void
    {
        $this->add('CR', $cacheKey . self::GS . str_replace("\n", '$[ln];', $value) . self::GS . str_replace("\n", '$[ln];', $searchValue));
    }

    // Call
    public function loadUrl(string $inputPlace, string $url): void { $this->add('lu' . $inputPlace, $url); }
    public function runActionControls(string $actionControls, bool $withoutWebFormsSection = true, ?string $index = null, bool $useCurrentEvent = true): void { $this->add('lA', ($useCurrentEvent ? '1' : '0') . self::GS . ($withoutWebFormsSection ? '1' : '0') . self::GS . $index . self::GS . $actionControls); }
    public function callScript(string $scriptText): void { $this->add('_', str_replace("\n", '$[ln];', $scriptText)); }
    public function callMethod(string $methodName, ?array $args = null): void { $this->add('lm', $methodName . $this->buildArgsJoin($args, self::GS)); }
    public function callModuleMethod(string $methodName, ?array $args = null): void { $this->add('lM', $methodName . $this->buildArgsJoin($args, self::GS)); }
    public function callPostBack(string $formInputPlace, ?string $outputPlace = null): void { $this->add('Lp', '1' . self::GS . $formInputPlace . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function callCommentBack(string|int|null $index = null, ?string $inputPlace = null, bool $useCurrentEvent = true): void { $this->add('LC', ($useCurrentEvent ? '1' : '0') . self::GS . ($index !== null ? (string)$index : '') . self::GS . $inputPlace); }
    public function callWasmBack(string $wasmLanguage, string $wasmUrl, string $methodName, ?array $args = null, ?string $outputPlace = null, bool $useCurrentEvent = true): void { $this->add('Ly', ($useCurrentEvent ? '1' : '0') . self::GS . $wasmLanguage . self::GS . $wasmUrl . self::GS . $methodName . self::GS . $this->buildArgsJoin($args) . self::GS . $outputPlace); }
    public function callWebSocketBack(string $path, bool $useCurrentEvent = true): void { $this->add('Lw', ($useCurrentEvent ? '1' : '0') . self::GS . $path); }
    public function callSSEBack(string $path, ?string $outputPlace = null, bool $useCurrentEvent = true, bool $shouldReconnect = true, string|int $reconnectTryTimeout = '3000'): void { $this->add('Ls', ($useCurrentEvent ? '1' : '0') . self::GS . $path . self::GS . ($shouldReconnect ? '1' : '0') . self::GS . (string)$reconnectTryTimeout . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function callFront(string $modulePath, ?array $args = null, ?string $outputPlace = null, bool $useCurrentEvent = true): void { $this->add('Lj', ($useCurrentEvent ? '1' : '0') . self::GS . $modulePath . self::GS . $outputPlace . $this->buildArgsJoin($args, self::GS)); }
    public function callGetBack(string $path, ?string $outputPlace = null, bool $useCurrentEvent = true): void { $this->add('Lg', ($useCurrentEvent ? '1' : '0') . self::GS . $path . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function callPutBack(string $path, ?string $outputPlace = null, bool $useCurrentEvent = true): void { $this->add('Lt', ($useCurrentEvent ? '1' : '0') . self::GS . $path . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function callPatchBack(string $path, ?string $outputPlace = null, bool $useCurrentEvent = true): void { $this->add('LP', ($useCurrentEvent ? '1' : '0') . self::GS . $path . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function callDeleteBack(string $path, ?string $outputPlace = null, bool $useCurrentEvent = true): void { $this->add('Ld', ($useCurrentEvent ? '1' : '0') . self::GS . $path . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function callHeadBack(string $path, bool $useCurrentEvent = true): void { $this->add('Lh', ($useCurrentEvent ? '1' : '0') . self::GS . $path); }
    public function callOptionsBack(string $path, ?string $outputPlace = null, bool $useCurrentEvent = true): void { $this->add('Lo', ($useCurrentEvent ? '1' : '0') . self::GS . $path . ($outputPlace !== null ? self::GS . $outputPlace : '')); }
    public function callSendBack(string $path, string $method, bool $isMultiPart, string $contentType, string $data, ?string $outputPlace = null, bool $useCurrentEvent = true): void { $this->add('LS', ($useCurrentEvent ? '1' : '0') . self::GS . $path . self::GS . $method . self::GS . ($isMultiPart ? '1' : '0') . self::GS . $contentType . self::GS . str_replace("\n", '$[ln];', $data) . ($outputPlace !== null ? self::GS . $outputPlace : '')); }

    // Update
    public function increase(string $inputPlace, float $value): void { $this->add('gt' . $inputPlace, 'i' . self::GS . (string)$value); }
    public function decrease(string $inputPlace, float $value): void { $this->add('gt' . $inputPlace, 'i' . self::GS . (string)($value * -1)); }
    public function replace(string $inputPlace, string $value, string $newValue, bool $alsoStartTag = false, bool $deep = true): void { $this->add('gt' . $inputPlace, 'r' . self::GS . $value . self::GS . $newValue . self::GS . ($alsoStartTag ? '1' : '0') . self::GS . ($deep ? '1' : '0')); }
    public function replaceStartTag(string $inputPlace, string $value, string $newValue): void { $this->add('gt' . $inputPlace, 's' . self::GS . $value . self::GS . $newValue); }

    // Pre Runner
    public function assignDelay(int $miliSecond, int $index = -1): void { $this->modifyLine($index, ':' . (string)$miliSecond . ')', false); }
    public function assignDelayChange(int $miliSecond, int $index = -1): void { $this->modifyLine($index, ':' . (string)$miliSecond . ')', true); }
    public function assignInterval(int $miliSecond, ?string $id = null, int $index = -1): void { $this->modifyLine($index, '(' . (string)$miliSecond . ($id !== null ? '|' . $id : '') . ')', false); }
    public function assignIntervalChange(int $miliSecond, ?string $id = null, int $index = -1): void { $this->modifyLine($index, '(' . (string)$miliSecond . ($id !== null ? '|' . $id : '') . ')', true); }
    public function deleteInterval(string $id): void { $this->add('Di', $id); }
    public function assignRepeat(int $count, int $index = -1): void { $this->modifyLine($index, ',' . (string)$count . ')', false); }
    public function assignRepeatChange(int $count, int $index = -1): void { $this->modifyLine($index, ',' . (string)$count . ')', true); }

    private function modifyLine(int $index, string $prefix, bool $changeMode): void {
        $currentLine = $this->getLineByIndex($index);
        if ($currentLine === '') return;
        $parts = explode('=', $currentLine, 2);
        $currentName = $parts[0];
        
        if ($changeMode) {
            $firstChar = $prefix[0];
            $pos = strpos($currentName, $firstChar);
            $bracketPos = strpos($currentName, ')');
            if ($pos === 0 && $bracketPos !== false) {
                $currentName = substr($currentName, $bracketPos + 1);
            }
        }
        
        $this->updateLineByIndex($index, $prefix . $currentName, count($parts) > 1 ? $parts[1] : '');
    }

    // Index
    public function startIndex(?string $name = null): void { $this->add('#', $name ?? ''); }
    // This Index Is Automatically Run After Changing The Browser History (Back And Forward Buttons)
	public function startState(): void { $this->startIndex('$'); }
    public function goTo(string|int $line, string|int $repeat = 1): void { $this->add('&', (string)$line . self::GS . (string)$repeat); }
    public function goToIndex(string $index, int $repeat = 1): void { $this->add('&', '#' . $index . self::GS . (string)$repeat); }
    
	// Start
	public function startTransientDOM(string $inputPlace): void { $this->add('td', $inputPlace); }
    public function endTransientDOM(): void { $this->add('td', ';'); }

    // Message
	// Type: warning, problem, help, success, none
    public function alert(string $text, string $type = 'none', string $title = 'Alert', string $okText = 'OK'): void { $this->add('Al', $text . self::GS . ($type === 'none' ? '' : $type) . self::GS . ($title === 'Alert' ? '' : $title) . self::GS . ($okText === 'OK' ? '' : $okText)); }
    public function message(string $text, string $type = 'none', string|int $duration = '0'): void { $this->add('me', $text . self::GS . ($type === 'none' ? '' : $type) . self::GS . ((string)$duration === '0' ? '' : (string)$duration)); }
    
	// Type: log, info, warn, error, debug, trace, group, groupend, table
	public function consoleMessage(string $text, string $type = 'log'): void { $this->add('mc', str_replace("\n", '$[ln];', $text) . ($type === 'log' ? '' : self::GS . $type)); }
    public function consoleMessageAssert(string $text, string $condition): void { $this->add('ma', str_replace("\n", '$[ln];', $text) . self::GS . $condition); }

	// Enable
	//Calling The EnableWebSocket Or EnableWebSocketOnce Or AddWebSocket Methods Will Cause Any Subsequent Requests (Under WebForms Core Technology) To Operate Under The WebSocket Protocol.
    public function enableWebSocket(bool $enable = true): void { $this->add('ew', $enable ? '1' : '0'); }
    public function enableWebSocketOnce(): void { $this->add('ew', '$'); }
    public function addWebSocket(string $path): void { $this->add('aw' . $path); }
    // Disconnected WebSocket
	public function deleteWebSocket(string $path): void { $this->add('dw' . $path); }
	
	// Use
	// InputPlace Using Only For form Element
    public function useWebSocket(string $inputPlace): void { $this->add('uw' . $inputPlace); }
    public function useOnlyChangeUpdate(string $inputPlace): void { $this->add('uo' . $inputPlace); }

	// Condition And Loop
	// Condition And Loop Supports Brackets and Then
	// Type: warning, problem, help, success, none
	// Interval: Value 0 is Await (if is not True, all Next Action Controls Waiting for it), Value -1 is Sync Check Once (is Support Bracket or Next Action Control), Value > 0 is Async and is Wait Based on Time Repetition Until it Becomes True (Is Support Bracket or Next Action Control, but is not Support Else).
	// Nested Conditions and Nested Loops are Possible.
    private function buildConditionPrefix(string $code, int $interval): string { return (($interval >= 0) ? '{(' . (string)$interval . ')' : '{') . $code; }
    public function confirmIsTrueAccept(string $text = 'Are you sure you want to proceed?', string $type = 'none', string $title = 'Confirm', string $okText = 'OK', string $cancelText = 'Cancel', int $interval = 100): WebForms { $this->add($this->buildConditionPrefix('ct', $interval), ($text === 'Are you sure you want to proceed?' ? '' : $text) . self::GS . ($type === 'none' ? '' : $type) . self::GS . ($title === 'Confirm' ? '' : $title) . self::GS . ($okText === 'OK' ? '' : $okText) . self::GS . ($cancelText === 'Cancel' ? '' : $cancelText)); return $this; }
    public function confirmIsFalseAccept(string $text = 'Are you sure you want to proceed?', string $type = 'none', string $title = 'Confirm', string $okText = 'OK', string $cancelText = 'Cancel', int $interval = 100): WebForms { $this->add($this->buildConditionPrefix('cf', $interval), ($text === 'Are you sure you want to proceed?' ? '' : $text) . self::GS . ($type === 'none' ? '' : $type) . self::GS . ($title === 'Confirm' ? '' : $title) . self::GS . ($okText === 'OK' ? '' : $okText) . self::GS . ($cancelText === 'Cancel' ? '' : $cancelText)); return $this; }
    public function isGreaterThan(string $firstValue, string $secondValue, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('gt', $interval), $firstValue . self::GS . $secondValue); return $this; }
    public function isLessThan(string $firstValue, string $secondValue, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('lt', $interval), $firstValue . self::GS . $secondValue); return $this; }
    public function isEqualTo(string $firstValue, string $secondValue, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('et', $interval), $firstValue . self::GS . $secondValue); return $this; }
    public function isNotEqualTo(string $firstValue, string $secondValue, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('Nt', $interval), $firstValue . self::GS . $secondValue); return $this; }
    public function exist(string $value, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('ex', $interval), $value); return $this; }
    public function notExist(string $value, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('nx', $interval), $value); return $this; }
    public function isTrue(string $value, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('tr', $interval), $value); return $this; }
    public function isFalse(string $value, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('fa', $interval), $value); return $this; }
    public function isMatchMedia(string $value, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('mm', $interval), $value); return $this; }
    public function isNotMatchMedia(string $value, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('nm', $interval), $value); return $this; }
    public function include(string $text, string $value, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('In', $interval), $value . self::GS . $text); return $this; }
    public function notInclude(string $text, string $value, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('Nn', $interval), $value . self::GS . $text); return $this; }
    public function elementExists(string $inputPlace, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('eE', $interval), $inputPlace); return $this; }
    public function elementNotExists(string $inputPlace, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('nE', $interval), $inputPlace); return $this; }
    public function isRegexMatch(string $value, string $pattern, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('re', $interval), $value . self::GS . $pattern); return $this; }
    public function isRegexNotMatch(string $value, string $pattern, int $interval = -1): WebForms { $this->add($this->buildConditionPrefix('rn', $interval), $value . self::GS . $pattern); return $this; }
	// In: Everything Becomes A JSON List.
	// Key: Creates A Temporary Data In The Browser IndexedDB.
	// Key + "i" Creates A Temporary Data To Maintain The Loop Counter In The Browser IndexedDB.
	public function forEach(string $path, string $in, string $key = '.'): WebForms { $this->add('{fe', $path . self::GS . $in . self::GS . $key); return $this; }
    public function break(): void { $this->add(';'); }
    public function else(): WebForms { $this->add('}e'); return $this; }
    public function startBracket(): void { $this->add('{'); }
    public function endBracket(): void { $this->add('}'); }
	// Used Then In Condition And Loop Methods
    public function then(?WebForms $newForm): WebForms { if ($newForm === null) return $this; $data = $newForm->getWebFormsData(); if ($data !== '' && strpos($data, "\n") !== false) { $newForm->addToUp('{'); $newForm->add('}'); } $this->appendForm($newForm); return $this; }
    public function thenClosure(callable $configure): WebForms { $newForm = new WebForms(); $configure($newForm); $data = $newForm->getWebFormsData(); if ($data !== '' && strpos($data, "\n") !== false) { $newForm->addToUp('{'); $newForm->add('}'); } $this->appendForm($newForm); return $this; }
    public function repeat(WebForms $newForm, int $repeat): WebForms { if ($newForm === null || $newForm->getWebFormsData() === '') return $this; $startLine = -count(explode("\n", $newForm->getWebFormsData())); $this->appendForm($newForm); $this->goTo($startLine, $repeat - 1); return $this; }
    public function repeatWithIndex(WebForms $newForm, int $repeat, string $index): WebForms { if ($newForm === null || $newForm->getWebFormsData() === '') return $this; $this->goToIndex($index); $this->startIndex($index); $this->appendForm($newForm); if ($index === '') { $indexNumber = -1; foreach (explode("\n", $this->getWebFormsData()) as $x) { if (strpos($x, '#') === 0) $indexNumber++; } $this->goTo($indexNumber, $repeat - 1); } else { $this->goToIndex($index, $repeat - 1); } return $this; }
    public function repeatClosure(callable $configure, int $repeat): WebForms { $newForm = new WebForms(); $configure($newForm); return $this->repeat($newForm, $repeat); }
    public function repeatClosureWithIndex(callable $configure, int $repeat, string $index): WebForms { $newForm = new WebForms(); $configure($newForm); return $this->repeatWithIndex($newForm, $repeat, $index); }

    // Async
	// It Supports Brackets and Then
    public function async(): WebForms { $this->add('{(a)'); return $this; }
    public function delay(string|int $miliSecond): void { $this->add('De', (string)$miliSecond); }
	
	// Option
    public function changeOption(string $name, string $value): void { $this->add('co', $name . self::GS . $value); }
    public function resetOption(?string $name = null): void { $this->add('ro', $name ?? ''); }

    // Format Storage
    public function createFormatStorage(string $key, string $data): void { $this->add('.C', $key . self::GS . $data); }
    public function deleteFormatStorage(string $key): void { $this->add('.D', $key); }
    public function addJSON(string $key, string $path, string $value): void { $this->add('.a', $key . self::GS . 'j' . self::GS . $value . self::GS . $path); }
	// Name: For Support Attribute, Set Double At Sign (@@) Before Name.
	public function addXML(string $key, string $path, string $name, ?string $value = null): void { $this->add('.a', $key . self::GS . 'x' . self::GS . $name . self::GS . $value . self::GS . $path); }
    public function addINI(string $key, string $path, string $value, bool $isINILike = false): void { $this->add('.a', $key . self::GS . 'i' . self::GS . ($isINILike ? '1' : '0') . self::GS . $value . self::GS . $path); }
    public function addTextLine(string $key, string|int $line, string $text): void { $this->add('.a', $key . self::GS . 't' . self::GS . $text . self::GS . (string)$line); }
    public function addVariable(string $key, string $value): void { $this->add('.a', $key . self::GS . 'v' . self::GS . $value); }
    public function updateJSON(string $key, string $path, string $value): void { $this->add('.u', $key . self::GS . 'j' . self::GS . $value . self::GS . $path); }
    public function updateXML(string $key, string $path, string $value): void { $this->add('.u', $key . self::GS . 'x' . self::GS . $value . self::GS . $path); }
    public function updateINI(string $key, string $path, string $value, bool $isINILike = false): void { $this->add('.u', $key . self::GS . 'i' . self::GS . ($isINILike ? '1' : '0') . self::GS . $value . self::GS . $path); }
    public function updateTexLine(string $key, string|int $line, string $text): void { $this->add('.u', $key . self::GS . 't' . self::GS . $text . self::GS . (string)$line); }
    public function updateVariable(string $key, string $value): void { $this->add('.u', $key . self::GS . 'v' . self::GS . $value); }
    public function increaceVariable(string $key, string|int $value): void { $this->add('.i', $key . self::GS . 'v' . self::GS . (string)$value); }
    public function decreaseVariable(string $key, int $value): void { $this->increaceVariable($key, (string)($value * -1)); }
    public function deleteJSON(string $key, string $path): void { $this->add('.d', $key . self::GS . 'j' . self::GS . $path); }
    public function deleteXML(string $key, string $path): void { $this->add('.d', $key . self::GS . 'x' . self::GS . $path); }
    public function deleteINI(string $key, string $path, bool $isINILike = false): void { $this->add('.d', $key . self::GS . 'i' . self::GS . ($isINILike ? '1' : '0') . self::GS . $path); }
    public function deleteTextLine(string $key, string|int $line): void { $this->add('.d', $key . self::GS . 't' . self::GS . (string)$line); }
    public function deleteVariable(string $key): void { $this->add('.d', $key . self::GS . 'v'); }

    // Template Engine
	// Pattern Example: {{value}}, ((value)), *value*, $value;
    public function bindJSONToTemplate(string $inputPlace, string $jSONText, string $path, string $pattern, bool $alsoStartTag = true): void { $this->add('Tj' . $inputPlace, $jSONText . self::GS . $path . self::GS . $pattern . self::GS . ($alsoStartTag ? '1' : '0')); }
    // Because XML Elements Are Lowercased, Placeholders Must Use Lowercase Names.
	public function bindXMLToTemplate(string $inputPlace, string $xMLText, string $path, string $pattern, bool $alsoStartTag = true): void { $this->add('Tx' . $inputPlace, $xMLText . self::GS . $path . self::GS . $pattern . self::GS . ($alsoStartTag ? '1' : '0')); }
    public function bindINIToTemplate(string $inputPlace, string $iNIText, string $path, string $pattern, bool $alsoStartTag = true): void { $this->add('Ti' . $inputPlace, $iNIText . self::GS . $path . self::GS . $pattern . self::GS . ($alsoStartTag ? '1' : '0')); }

    // Inject
	// Need Add @: to First of String
    public function inject(string $value): string { return '$[' . $value . '];'; }
    
	// Action Control
	public function replaceActionControl(string $searchValue, string $value, bool $addingToUp = false): void { if ($addingToUp) { $this->addToUp('rE', $searchValue . self::GS . $value); } else { $this->add('rE', $searchValue . self::GS . $value); } }
    
	public function assignReplace(string $searchValue, string $value, int $index = -1): void { $this->modifyReplaceLine($index, $searchValue, $value); }
    
    private function modifyReplaceLine(int $index, string $searchValue, string $value): void {
        $currentLine = $this->getLineByIndex($index);
        if ($currentLine === '') return;
        $parts = explode('=', $currentLine, 2);
        $this->updateLineByIndex($index, ';' . $searchValue . self::GS . $value . self::GS . $parts[0], count($parts) > 1 ? $parts[1] : '');
    }

    // Hash And Checksum
    public function setHash(): void { $this->add('SH'); }
    public function setChecksum(): void { $this->add('CS'); }
    public function checksumCalculation(string $text): string {
        $sum = 0; $mod = 65536; $shift = 5;
        for ($i = 0; $i < strlen($text); $i++) {
            $sum = (($sum << $shift) | ($sum >> (16 - $shift))) ^ ord($text[$i]);
            $sum %= $mod;
        }
        return (string)$sum;
    }
    public function getChecksum(): string { return $this->checksumCalculation($this->getWebFormsData()); }

    // Get
    public function getFormsActionData(): string { return $this->webFormsData; }
    public function response(): string { return "[web-forms]\n" . $this->getFormsActionData(); }
    public function getFormsActionDataLineBreak(): string { if (strlen($this->webFormsData) === 0) return ''; return str_replace("\n", '$[sln];', str_replace('"', '$[dq];', $this->webFormsData)); }
    // Export
	public function exportToHtmlComment(bool $addLine = false): string {
        $response = str_replace('--', '$[dd];', $this->response());
        if (substr($response, -1) === '-') $response = substr($response, 0, -1) . '$[da];';
        return ($addLine ? "\n" : '') . '<!--' . $response . '-->';
    }
	// Using it for SSE Response
    public function exportToLineBreak(?string $src = null): string { return '[web-forms]$[sln];' . $this->getFormsActionDataLineBreak(); }
    public function getWebFormsData(): string { return $this->webFormsData; }
    public function appendForm(?WebForms $form): void {
        if ($form === null) return;
        $otherData = $form->getWebFormsData();
        if ($otherData !== '') {
            if (strlen($this->webFormsData) > 0) $this->webFormsData .= "\n";
            $this->webFormsData .= $otherData;
        }
    }
    public function clean(): void { $this->webFormsData = ''; }
}

class Security
{
    public function safeValue(string $value): string
    {
        if (strlen($value) < 1) return $value;
        if ($value[0] === '@') $value = '@' . $value;
        return str_replace(["\n", ",@", "\x1C", "\x1D", "\x1E", "\x1F"], ['$[ln];', '$[co];@', '', '', '', ''], $value);
    }
}

// WebForms Place Criteria (WPC) DSL
class InputPlace
{
    public const string Document = ',';
    public const string Window = '`';
	// When Calling TransientDOM, Using Root will Result in the Selection of the Transient Tag.
    public const string Root = '~';
    public const string HTML = '.';
    public const string Head = '^';
    public const string ScreenOrientation = '%';
    public const string All = '*';
    public const string Parent = '/';
    public const string Current = '$';
    public const string Target = '!';
    public const string Upper = '-';

    public static function id(string $id): string { return $id; }
    
    public static function name(string $name, ?int $index = null): string { return '(' . $name . ')' . ($index !== null ? (string)$index : ''); }
    public static function allNames(string $name): string { return '(' . $name . ')*'; }
    
    public static function tag(string $tag, ?int $index = null): string { return '<' . $tag . '>' . ($index !== null ? (string)$index : ''); }
    public static function allTags(string $tag): string { return '<' . $tag . '>*'; }
    
    public static function child(?int $index = null): string { return '<>' . ($index !== null ? (string)$index : ''); }
    public static function allChild(): string { return '<>*'; }
    
    public static function class(string $class, ?int $index = null): string { return '{' . $class . '}' . ($index !== null ? (string)$index : ''); }
    public static function allClasses(string $class): string { return '{' . $class . '}*'; }
	// Operator: '^', '$', '*', '~'
    public static function attribute(string $name, string|int|null $indexOrValue = null, string|int $valueOrIndex = 0, string $operator = ''): string {
        if ($indexOrValue === null) {
            return '"' . $name . '"';
        }
        if (is_int($indexOrValue)) {
            return '"' . $name . '"' . (string)$indexOrValue;
        }
        if (is_int($valueOrIndex)) {
            $op = $operator !== '' ? substr($operator, 0, 1) : '';
            return '"' . $name . $op . "'" . $indexOrValue . '"' . (string)$valueOrIndex;
        }
        $op = $valueOrIndex !== '' ? substr((string)$valueOrIndex, 0, 1) : '';
        return '"' . $name . $op . "'" . $indexOrValue . '"';
    }
    
    public static function allAttributes(string $name, ?string $value = null, string $operator = ''): string {
        if ($value === null) return '"' . $name . '"*';
        $op = $operator !== '' ? substr($operator, 0, 1) : '';
        return '"' . $name . $op . "'" . $value . '"*';
    }

    public static function query(string $query): string { return '*' . str_replace(['=', '|', '?'], ['$[eq];', '$[vb];', '$[qu];'], $query); }
    public static function queryAll(string $query): string { return '[' . str_replace(['=', '|', '?'], ['$[eq];', '$[vb];', '$[qu];'], $query); }
}

class OutputPlace extends InputPlace {}

// Do not Add any Data Before or After it
class Fetch
{
    private const string RS = "\x1E"; // (char)30
    private const string US = "\x1F";// (char)31

    public static function random(int $first, ?int $second = null): string {
        if ($second === null) return '@mr' . (string)$first;
        return '@mr' . (string)$second . self::RS . (string)$first; // First=Min, Second=Max
    }

    public static function spaceToChar(string $text, string $character = '-'): string { return '@sc' . $character . self::RS . $text; }
    public static function encodeURI(string $text): string { return '@ue' . $text; }
    public static function decodeURI(string $text): string { return '@ud' . $text; }

    private static function buildArgs(?array $args): string {
        return ($args !== null && count($args) > 0) ? self::RS . implode(self::US, array_map('strval', $args)) : '';
    }
	// Method
    public static function method(string $methodName, ?array $args = null): string { return '@cm' . $methodName . self::buildArgs($args); }
    public static function moduleMethod(string $methodName, ?array $args = null): string { return '@cM' . $methodName . self::buildArgs($args); }
    // MethodName: The Method Name May Need to Include the Class Name, Separated by a Period. Example: MyClassName.MyMethodName
	public static function wasmMethod(string $wasmLanguage, string $wasmUrl, string $methodName, ?array $args = null, string $key = '.'): string { return '@wA' . $wasmLanguage . self::RS . $wasmUrl . self::RS . $methodName . self::buildArgs($args); }
    
	// Math
	public static function math(string $methodName, ?array $args = null): string { return '@M#' . $methodName . self::buildArgs($args); }

    public static function script(string $scriptText): string { return '@_' . str_replace("\n", '$[ln];', $scriptText); }
    public static function loadUrl(string $url, bool $fetchScript = false): string { return '@lu' . $url . ($fetchScript ? self::RS . '1' : ''); }
    public static function loadHtml(string $url, string $fetchInputPlace = '', bool $fetchScript = false): string { return '@lh' . $url . self::RS . ($fetchScript ? '1' : '0') . ($fetchInputPlace !== '' ? self::RS . $fetchInputPlace : ''); }
    public static function loadLine(string $url, int $line): string { return '@ll' . $url . self::RS . (string)$line; }
    public static function loadINI(string $url, string $name, bool $isINILike = false): string { return '@li' . $url . self::RS . $name . ($isINILike ? self::RS . '1' : ''); }
    // Name: Name Or Nested Paths. Is Supprt Index (Student[8].Name). Nested Paths Index Starts At 0
	public static function loadJSON(string $url, string $name): string { return '@lj' . $url . self::RS . $name; }
    // Name: Name Or XPath; XPath Index Starts At 1
	public static function loadXML(string $url, string $name): string { return '@lx' . $url . self::RS . $name; }
    // MethodName: It's Check Function Or Variable
	public static function hasMethod(string $methodName): string { return '@hm' . $methodName; }
    public static function hasModuleMethod(string $methodName): string { return '@hM' . $methodName; }
	// This Method Return True Or False If Key Pressed
	// Modifier: Alt, AltGraph, Control, Meta, Shift, CapsLock, NumLock, ScrollLock
    public static function getModifierState(string $modifier): string { return '@ms' . $modifier; }

	// Data
    public const string DateYear = '@dy';
	// Month In JavaScript Is Start From Index 0, Month In WebForms Core Is Start From Index 1 
    public const string DateMonth = '@dm';
    public const string DateDay = '@dd';
    public const string DateDate = '@dD';
    public const string DateHours = '@dh';
    public const string DateMinutes = '@di';
    public const string DateSeconds = '@ds';
    public const string DateMilliseconds = '@dl';
	
	// String
    public const string Space = '@sp';
    public const string AtSign = '@sa';
	
	// Tag
    public static function getId(string $inputPlace): string { return '@$i' . $inputPlace; }
    public static function getName(string $inputPlace): string { return '@$n' . $inputPlace; }
    public static function getValue(string $inputPlace): string { return '@$v' . $inputPlace; }
    public static function getValueLength(string $inputPlace): string { return '@$e' . $inputPlace; }
    public static function getClass(string $inputPlace): string { return '@$c' . $inputPlace; }
    public static function getStyle(string $inputPlace): string { return '@$s' . $inputPlace; }
    public static function getTitle(string $inputPlace): string { return '@$l' . $inputPlace; }
    public static function getLabel(string $inputPlace): string { return '@$a' . $inputPlace; }
    public static function getText(string $inputPlace): string { return '@$t' . $inputPlace; }
    public static function getOuterText(string $inputPlace): string { return '@$o' . $inputPlace; }
    public static function getTextLength(string $inputPlace): string { return '@$g' . $inputPlace; }
    public static function getAttribute(string $inputPlace, string $attribute): string { return '@$a' . $inputPlace . self::RS . $attribute; }
    public static function getWidth(string $inputPlace): string { return '@$w' . $inputPlace; }
    public static function getHeight(string $inputPlace): string { return '@$h' . $inputPlace; }
    public static function getIsReadOnly(string $inputPlace): string { return '@$r' . $inputPlace; }
    public static function getSelectedIndex(string $inputPlace): string { return '@$x' . $inputPlace; }
    public static function getIndex(string $inputPlace): string { return '@$i' . $inputPlace; }
    public static function getTextAlign(string $inputPlace): string { return '@$t' . $inputPlace; }
    public static function getNodeLength(string $inputPlace): string { return '@$l' . $inputPlace; }
    public static function getIsVisible(string $inputPlace): string { return '@$v' . $inputPlace; }

	// Save
    public static function hasHash(string $hash): string { return '@HH' . $hash; }
    public static function cookie(string $key): string { return '@co' . $key; }
    public static function save(string $key = '.', ?string $replaceValue = null): string { return '@cs' . $key . ($replaceValue !== null ? self::RS . $replaceValue : ''); }
    public static function saveThenRemove(string $key): string { return '@cl' . $key; }
    public static function saveLength(string $key = '.'): string { return '@cg' . $key; }
    public static function cache(string $key = '.', ?string $replaceValue = null): string { return '@cd' . $key . ($replaceValue !== null ? self::RS . $replaceValue : ''); }
    public static function cacheThenRemove(string $key): string { return '@ct' . $key; }
    public static function cacheLength(string $key = '.'): string { return '@cG' . $key; }
    public static function saveLine(string $key = '.', int $line = 0): string { return '@lL' . $key . '[' . (string)$line; }
    public static function saveLineConsume(string $key = '.'): string { return '@lL' . $key; }
    // INIKey: Only Direct Key is Supported
	public static function saveINI(string $key, string $iNIKey): string { return '@lI' . $key . '[' . $iNIKey; }
    public static function cacheLine(string $key = '.', int $line = 0): string { return '@dL' . $key . '[' . (string)$line; }
    public static function cacheLineConsume(string $key = '.'): string { return '@dL' . $key; }
    // INIKey: Only Direct Key is Supported
	public static function cacheINI(string $key, string $iNIKey): string { return '@dI' . $key . '[' . $iNIKey; }
	
	// Format Storage
    public static function formatStore(string $key): string { return '@fr' . $key; }
    public static function formatStoreByXMLQuery(string $key, string $xPath): string { return '@fx' . $key . self::RS . $xPath; }
    public static function formatStoreByJSONQuery(string $key, string $query): string { return '@fj' . $key . self::RS . $query; }
    public static function formatStoreByINI(string $key, string $name): string { return '@fi' . $key . self::RS . $name; }
    public static function formatStoreByText(string $key, int $line): string { return '@ft' . $key . self::RS . (string)$line; }
    public static function formatStoreByVariable(string $key): string { return '@fv' . $key; }
    
	// State
	public static function hasState(string $path): string { return '@hs' . $path; }
    
	// SSE
	public static function sSEIsConnected(string $path): string { return '@Sc' . $path; }
    
	// WebSockets
	public static function webSocketsIsConnected(string $path = ''): string { return '@Wc' . $path; }
    
	// Document
	public const string TabIsActive = '@da';
	
	// Window
	public const string Href = '@wf';
    public const string PathName = '@wP';
    public static function query(string $name = '*'): string { return '@wq' . $name; }
    public const string Hash = '@wh';
    public const string Host = '@wH';
    public const string HostName = '@wn';
    public const string Port = '@wT';
    public const string Origin = '@wo';
    public const string GetSelection = '@ws';
    public const string ScrollX = '@wx';
    public const string ScrollY = '@wy';
    public static function segment(int $index): string { return '@wS' . (string)$index; }
    // It Only Works when the String Starts with the Tilde Character (~). The Path is Also Separated by the Slash Character (/). #~/Segment1/Segment2/Segment3
	public static function hashSegment(int $index): string { return '@wt' . (string)$index; }
    
	// Navigator
	public const string ClipboardText = '@nC';
    public const string GeoLatitude = '@nW';
    public const string GeoLongitude = '@nO';
    public const string Language = '@nL';
    public const string IsOnLine = '@no';
    public const string UserAgent = '@na';
	
    // Screen
	public const string ScreenWidth = '@sw';
    public const string ScreenHeight = '@sh';
    public const string ScreenOrientationType = '@so';
    public const string ScreenOrientationAngle = '@sr';
	
	// Performance
    public const string TimeOrigin = '@pt';
    public const string PerformanceNow = '@pn';
	
	// Event
    public const string Event = '@EV';
    public const string EventSerialize = '@Es';
    public const string EventKey = '@ek';
    public const string EventWhich = '@ew';
    public const string EventClientX = '@ex';
    public const string EventClientY = '@ey';
    public const string EventPageX = '@eX';
    public const string EventPageY = '@eY';
    public const string EventOffsetX = '@Ex';
    public const string EventOffsetY = '@Ey';
    public const string EventDeltaY = '@ed';
}

class WasmLanguage
{
	// The Suffix "Mediator" Means You Must Call the JavaScript Interface. In Other Cases, the WASM File Should Be Called Directly.
    public const string C = 'c';
    public const string CPP = 'c';
    public const string Rust = 'rust';
    public const string CSharp = 'csharp';
	// .NET WebCIL Container. The "dotnet.js" File Should Be Invoked.
    public const string CSharpMediator = 'csharp-m';
    public const string GO = 'go';
    public const string JAVA = 'java';
    public const string AssemblyScript = 'as';
}

class HtmlEvent
{
    public const string OnAbort = 'onabort';
    public const string OnAfterPrint = 'onafterprint';
    public const string OnBeforePrint = 'onbeforeprint';
    public const string OnBeforeUnload = 'onbeforeunload';
    public const string OnBlur = 'onblur';
    public const string OnCanPlay = 'oncanplay';
    public const string OnCanPlayThrough = 'oncanplaythrough';
    public const string OnChange = 'onchange';
    public const string OnClick = 'onclick';
    public const string OnCopy = 'oncopy';
    public const string OnCut = 'oncut';
    public const string OnDoubleClick = 'ondblclick';
    public const string OnDrag = 'ondrag';
    public const string OnDragEnd = 'ondragend';
    public const string OnDragEnter = 'ondragenter';
    public const string OnDragLeave = 'ondragleave';
    public const string OnDragOver = 'ondragover';
    public const string OnDragStart = 'ondragstart';
    public const string OnDrop = 'ondrop';
    public const string OnDurationChange = 'ondurationchange';
    public const string OnEnded = 'onended';
    public const string OnError = 'onerror';
    public const string OnFocus = 'onfocus';
    public const string OnFocusin = 'onfocusin';
    public const string OnFocusOut = 'onfocusout';
    public const string OnHashChange = 'onhashchange';
    public const string OnInput = 'oninput';
    public const string OnInvalid = 'oninvalid';
    public const string OnKeyDown = 'onkeydown';
    public const string OnKeyPress = 'onkeypress';
    public const string OnKeyUp = 'onkeyup';
    public const string OnLoad = 'onload';
    public const string OnLoadedData = 'onloadeddata';
    public const string OnLoadedMetaData = 'onloadedmetadata';
    public const string OnLoadStart = 'onloadstart';
    public const string OnMouseDown = 'onmousedown';
    public const string OnMouseEnter = 'onmouseenter';
    public const string OnMouseLeave = 'onmouseleave';
    public const string OnMouseMove = 'onmousemove';
    public const string OnMouseOver = 'onmouseover';
    public const string OnMouseOut = 'onmouseout';
    public const string OnMouseUp = 'onmouseup';
    public const string OnOffline = 'onoffline';
    public const string OnOnline = 'ononline';
    public const string OnPageHide = 'onpagehide';
    public const string OnPageShow = 'onpageshow';
    public const string OnPaste = 'onpaste';
    public const string OnPause = 'onpause';
    public const string OnPlay = 'onplay';
    public const string OnPlaying = 'onplaying';
    public const string OnProgress = 'onprogress';
    public const string OnRateChange = 'onratechange';
    public const string OnResize = 'onresize';
    public const string OnReset = 'onreset';
    public const string OnScroll = 'onscroll';
    public const string OnSearch = 'onsearch';
    public const string OnSeeked = 'onseeked';
    public const string OnSeeking = 'onseeking';
    public const string OnSelect = 'onselect';
    public const string OnStalled = 'onstalled';
    public const string OnSubmit = 'onsubmit';
    public const string OnSuspend = 'onsuspend';
    public const string OnTimeUpdate = 'ontimeupdate';
    public const string OnToggle = 'ontoggle';
    public const string OnTouchCancel = 'ontouchcancel';
    public const string OnTouchend = 'ontouchend';
    public const string OnTouchMove = 'ontouchmove';
    public const string OnTouchStart = 'ontouchstart';
    public const string OnUnload = 'onunload';
    public const string OnVolumeChange = 'onvolumechange';
    public const string OnWaiting = 'onwaiting';
    public const string OnWheel = 'onwheel';
}

class HtmlEventListener
{
    public const string Abort = 'abort';
    public const string AfterPrint = 'afterprint';
    public const string BeforePrint = 'beforeprint';
    public const string BeforeUnload = 'beforeunload';
    public const string Blur = 'blur';
    public const string CanPlay = 'canplay';
    public const string CanPlayThrough = 'canplaythrough';
    public const string Change = 'change';
    public const string Click = 'click';
    public const string Copy = 'copy';
    public const string Cut = 'cut';
    public const string DoubleClick = 'dblclick';
    public const string Drag = 'drag';
    public const string DragEnd = 'dragend';
    public const string DragEnter = 'dragenter';
    public const string DragLeave = 'dragleave';
    public const string DragOver = 'dragover';
    public const string DragStart = 'dragstart';
    public const string Drop = 'drop';
    public const string DurationChange = 'durationchange';
    public const string Ended = 'ended';
    public const string Error = 'error';
    public const string Focus = 'focus';
    public const string Focusin = 'focusin';
    public const string FocusOut = 'focusout';
    public const string HashChange = 'hashchange';
    public const string Input = 'input';
    public const string Invalid = 'invalid';
    public const string KeyDown = 'keydown';
    public const string KeyPress = 'keypress';
    public const string KeyUp = 'keyup';
    public const string Load = 'load';
    public const string LoadedData = 'loadeddata';
    public const string LoadedMetaData = 'loadedmetadata';
    public const string LoadStart = 'loadstart';
    public const string MouseDown = 'mousedown';
    public const string MouseEnter = 'mouseenter';
    public const string MouseLeave = 'mouseleave';
    public const string MouseMove = 'mousemove';
    public const string MouseOver = 'mouseover';
    public const string MouseOut = 'mouseout';
    public const string MouseUp = 'mouseup';
    public const string Offline = 'offline';
    public const string Online = 'online';
    public const string PageHide = 'pagehide';
    public const string PageShow = 'pageshow';
    public const string Paste = 'paste';
    public const string Pause = 'pause';
    public const string Play = 'play';
    public const string Playing = 'playing';
    public const string Progress = 'progress';
    public const string RateChange = 'ratechange';
    public const string Resize = 'resize';
    public const string Reset = 'reset';
    public const string Scroll = 'scroll';
    public const string Search = 'search';
    public const string Seeked = 'seeked';
    public const string Seeking = 'seeking';
    public const string Select = 'select';
    public const string Stalled = 'stalled';
    public const string Submit = 'submit';
    public const string Suspend = 'suspend';
    public const string TimeUpdate = 'timeupdate';
    public const string Toggle = 'toggle';
    public const string TouchCancel = 'touchcancel';
    public const string Touchend = 'touchend';
    public const string TouchMove = 'touchmove';
    public const string TouchStart = 'touchstart';
    public const string Unload = 'unload';
    public const string VolumeChange = 'volumechange';
    public const string Waiting = 'waiting';
    public const string Wheel = 'wheel';
    public const string AnimationEnd = 'animationend';
    public const string AnimationIteration = 'animationiteration';
    public const string AnimationStart = 'animationstart';
    public const string ContextMenu = 'contextmenu';
    public const string FullScreenChange = 'fullscreenchange';
    public const string FullScreenError = 'fullscreenerror';
    public const string PopState = 'popstate';
    public const string TransitionEnd = 'transitionend';
    public const string Storage = 'storage';
	
	// Custom
    public const string ScrollBottom = 'scrollbottom'; // Need Call enableScrollBottomEvent Method Before
    public const string ElementReached = 'elementreached'; // Need Call enableReachedElementEvent Method Before
}

class ExtensionWebFormsMethods
{
    public static function child(string $text, string $value): string { return strlen($text) < 1 ? $value : $text . '|' . $value; }
    public static function parent(string $text): string {
        if (strlen($text) < 1) return $text;
        if (str_ends_with($text, '|/') || str_ends_with($text, '//')) return $text . '/';
        return $text . '|/';
    }
    public static function criteria(string $text, string $value): string { return strlen($text) < 1 ? $value : $text . '?' . str_replace(['|', '?'], ['$[vb];', '$[qu];'], $value); }
    public static function appendFetchReplace(string $text, string $searchValue, string $value): string { return '@;' . $searchValue . "\x1C" . $value . "\x1C" . substr($text, 1); }
    public static function lineBreak(string $text, bool $encodeLine = false): string { $encode = $encodeLine ? '$[sln];' : ''; return str_replace(["\r\n", "\n", "\r"], $encode, $text); }
    // Converts Numbers to Strings
	public static function toJSString(string $text): string { return '"' . $text . '"'; }
	// Get JS Object Momentary 
    public static function toJSObject(string $text): string { return '$' . $text; }
	// Get JS Object Returned Value Once
    public static function toJSReturnObject(string $text): string { return '$@' . $text; }
}
