package WebForms;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {
        WebFormsData => {},
    };
    bless $self, $class;
    return $self;
}

# For Extension
sub AddLine {
    my ($self, $Name, $Value) = @_;
    push @{$self->{WebFormsData}{$Name}}, $Value;
}

# Add
sub AddId {
    my ($self, $InputPlace, $Id) = @_;
    $self->AddLine("ai$InputPlace", $Id);
}

sub AddName {
    my ($self, $InputPlace, $Name) = @_;
    $self->AddLine("an$InputPlace", $Name);
}

sub AddValue {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("av$InputPlace", $Value);
}

sub AddClass {
    my ($self, $InputPlace, $Class) = @_;
    $self->AddLine("ac$InputPlace", $Class);
}

sub AddStyle {
    my ($self, $InputPlace, $Style) = @_;
    $self->AddLine("as$InputPlace", $Style);
}

sub AddStyleWithNameValue {
    my ($self, $InputPlace, $Name, $Value) = @_;
    $self->AddLine("as$InputPlace", "$Name:$Value");
}

sub AddOptionTag {
    my ($self, $InputPlace, $Text, $Value, $Selected) = @_;
    my $option = "$Value|$Text" . ($Selected ? "|1" : "");
    $self->AddLine("ao$InputPlace", $option);
}

sub AddCheckBoxTag {
    my ($self, $InputPlace, $Text, $Value, $Checked) = @_;
    my $checkbox = "$Value|$Text" . ($Checked ? "|1" : "");
    $self->AddLine("ak$InputPlace", $checkbox);
}

sub AddTitle {
    my ($self, $InputPlace, $Title) = @_;
    $self->AddLine("al$InputPlace", $Title);
}

sub AddText {
    my ($self, $InputPlace, $Text) = @_;
    $Text =~ s/\n/\$[ln];/g;
    $self->AddLine("at$InputPlace", $Text);
}

sub AddTextToUp {
    my ($self, $InputPlace, $Text) = @_;
    $Text =~ s/\n/\$[ln];/g;
    $self->AddLine("pt$InputPlace", $Text);
}

sub AddAttribute {
    my ($self, $InputPlace, $Attribute, $Value) = @_;
    $self->AddLine("aa$InputPlace", "$Attribute|$Value");
}

sub AddTag {
    my ($self, $InputPlace, $TagName, $Id) = @_;
    my $tag = $TagName . ($Id ? "|$Id" : "");
    $self->AddLine("nt$InputPlace", $tag);
}

sub AddTagToUp {
    my ($self, $InputPlace, $TagName, $Id) = @_;
    my $tag = $TagName . ($Id ? "|$Id" : "");
    $self->AddLine("ut$InputPlace", $tag);
}

sub AddTagBefore {
    my ($self, $InputPlace, $TagName, $Id) = @_;
    my $tag = $TagName . ($Id ? "|$Id" : "");
    $self->AddLine("bt$InputPlace", $tag);
}

sub AddTagAfter {
    my ($self, $InputPlace, $TagName, $Id) = @_;
    my $tag = $TagName . ($Id ? "|$Id" : "");
    $self->AddLine("ft$InputPlace", $tag);
}

# Set
sub SetId {
    my ($self, $InputPlace, $Id) = @_;
    $self->AddLine("si$InputPlace", $Id);
}

sub SetName {
    my ($self, $InputPlace, $Name) = @_;
    $self->AddLine("sn$InputPlace", $Name);
}

sub SetValue {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("sv$InputPlace", $Value);
}

sub SetClass {
    my ($self, $InputPlace, $Class) = @_;
    $self->AddLine("sc$InputPlace", $Class);
}

sub SetStyle {
    my ($self, $InputPlace, $Style) = @_;
    $self->AddLine("ss$InputPlace", $Style);
}

sub SetStyleWithNameValue {
    my ($self, $InputPlace, $Name, $Value) = @_;
    $self->AddLine("ss$InputPlace", "$Name:$Value");
}

sub SetOptionTag {
    my ($self, $InputPlace, $Text, $Value, $Selected) = @_;
    my $option = "$Value|$Text" . ($Selected ? "|1" : "");
    $self->AddLine("so$InputPlace", $option);
}

sub SetChecked {
    my ($self, $InputPlace, $Checked) = @_;
    $self->AddLine("sk$InputPlace", $Checked ? "1" : "0");
}

sub SetCheckBoxTagToList {
    my ($self, $InputPlace, $Text, $Value, $Checked) = @_;
    my $checkbox = "$Value|$Text" . ($Checked ? "|1" : "");
    $self->AddLine("sk$InputPlace", $checkbox);
}

sub SetTitle {
    my ($self, $InputPlace, $Title) = @_;
    $self->AddLine("sl$InputPlace", $Title);
}

sub SetText {
    my ($self, $InputPlace, $Text) = @_;
    $Text =~ s/\n/\$[ln];/g;
    $self->AddLine("st$InputPlace", $Text);
}

sub SetAttribute {
    my ($self, $InputPlace, $Attribute, $Value) = @_;
    $self->AddLine("sa$InputPlace", "$Attribute|$Value");
}

sub SetWidth {
    my ($self, $InputPlace, $Width) = @_;
    $self->AddLine("sw$InputPlace", $Width);
}

sub SetHeight {
    my ($self, $InputPlace, $Height) = @_;
    $self->AddLine("sh$InputPlace", $Height);
}

# Insert
sub InsertId {
    my ($self, $InputPlace, $Id) = @_;
    $self->AddLine("ii$InputPlace", $Id);
}

sub InsertName {
    my ($self, $InputPlace, $Name) = @_;
    $self->AddLine("in$InputPlace", $Name);
}

sub InsertValue {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("iv$InputPlace", $Value);
}

sub InsertClass {
    my ($self, $InputPlace, $Class) = @_;
    $self->AddLine("ic$InputPlace", $Class);
}

sub InsertStyle {
    my ($self, $InputPlace, $Style) = @_;
    $self->AddLine("is$InputPlace", $Style);
}

sub InsertStyleWithNameValue {
    my ($self, $InputPlace, $Name, $Value) = @_;
    $self->AddLine("is$InputPlace", "$Name:$Value");
}

sub InsertOptionTag {
    my ($self, $InputPlace, $Text, $Value, $Selected) = @_;
    my $option = "$Value|$Text" . ($Selected ? "|1" : "");
    $self->AddLine("io$InputPlace", $option);
}

sub InsertCheckBoxTag {
    my ($self, $InputPlace, $Text, $Value, $Checked) = @_;
    my $checkbox = "$Value|$Text" . ($Checked ? "|1" : "");
    $self->AddLine("ik$InputPlace", $checkbox);
}

sub InsertTitle {
    my ($self, $InputPlace, $Title) = @_;
    $self->AddLine("il$InputPlace", $Title);
}

sub InsertText {
    my ($self, $InputPlace, $Text) = @_;
    $Text =~ s/\n/\$[ln];/g;
    $self->AddLine("it$InputPlace", $Text);
}

sub InsertAttribute {
    my ($self, $InputPlace, $Attribute, $Value) = @_;
    $self->AddLine("ia$InputPlace", "$Attribute|$Value");
}

# Delete
sub DeleteId {
    my ($self, $InputPlace) = @_;
    $self->AddLine("di$InputPlace", "1");
}

sub DeleteName {
    my ($self, $InputPlace) = @_;
    $self->AddLine("dn$InputPlace", "1");
}

sub DeleteValue {
    my ($self, $InputPlace) = @_;
    $self->AddLine("dv$InputPlace", "1");
}

sub DeleteClass {
    my ($self, $InputPlace, $ClassName) = @_;
    $self->AddLine("dc$InputPlace", $ClassName);
}

sub DeleteStyle {
    my ($self, $InputPlace, $StyleName) = @_;
    $self->AddLine("ds$InputPlace", $StyleName);
}

sub DeleteOptionTag {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("do$InputPlace", $Value);
}

sub DeleteAllOptionTag {
    my ($self, $InputPlace) = @_;
    $self->AddLine("do$InputPlace", "*");
}

sub DeleteCheckBoxTag {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("dk$InputPlace", $Value);
}

sub DeleteAllCheckBoxTag {
    my ($self, $InputPlace) = @_;
    $self->AddLine("dk$InputPlace", "*");
}

sub DeleteTitle {
    my ($self, $InputPlace) = @_;
    $self->AddLine("dl$InputPlace", "1");
}

sub DeleteText {
    my ($self, $InputPlace) = @_;
    $self->AddLine("dt$InputPlace", "1");
}

sub DeleteAttribute {
    my ($self, $InputPlace, $Attribute) = @_;
    $self->AddLine("da$InputPlace", $Attribute);
}

sub Delete {
    my ($self, $InputPlace) = @_;
    $self->AddLine("de$InputPlace", "1");
}

sub DeleteParent {
    my ($self, $InputPlace) = @_;
    $self->AddLine("dp$InputPlace", "1");
}

# Other
sub SetBackgroundColor {
    my ($self, $InputPlace, $Color) = @_;
    $self->AddLine("bc$InputPlace", $Color);
}

sub SetTextColor {
    my ($self, $InputPlace, $Color) = @_;
    $self->AddLine("tc$InputPlace", $Color);
}

sub SetFontName {
    my ($self, $InputPlace, $Name) = @_;
    $self->AddLine("fn$InputPlace", $Name);
}

sub SetFontSize {
    my ($self, $InputPlace, $Size) = @_;
    $self->AddLine("fs$InputPlace", $Size);
}

sub SetFontBold {
    my ($self, $InputPlace, $Bold) = @_;
    $self->AddLine("fb$InputPlace", $Bold ? "1" : "0");
}

sub SetVisible {
    my ($self, $InputPlace, $Visible) = @_;
    $self->AddLine("vi$InputPlace", $Visible ? "1" : "0");
}

sub SetTextAlign {
    my ($self, $InputPlace, $Align) = @_;
    $self->AddLine("ta$InputPlace", $Align);
}

sub SetReadOnly {
    my ($self, $InputPlace, $ReadOnly) = @_;
    $self->AddLine("sr$InputPlace", $ReadOnly ? "1" : "0");
}

sub SetDisabled {
    my ($self, $InputPlace, $Disabled) = @_;
    $self->AddLine("sd$InputPlace", $Disabled ? "1" : "0");
}

sub SetFocus {
    my ($self, $InputPlace, $Focus) = @_;
    $self->AddLine("sf$InputPlace", $Focus ? "1" : "0");
}

sub SetMinLength {
    my ($self, $InputPlace, $Length) = @_;
    $self->AddLine("mn$InputPlace", $Length);
}

sub SetMaxLength {
    my ($self, $InputPlace, $Length) = @_;
    $self->AddLine("mx$InputPlace", $Length);
}

sub SetSelectedValue {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("ts$InputPlace", $Value);
}

sub SetSelectedIndex {
    my ($self, $InputPlace, $Index) = @_;
    $self->AddLine("ti$InputPlace", $Index);
}

sub SetCheckedValue {
    my ($self, $InputPlace, $Value, $Selected) = @_;
    $self->AddLine("ks$InputPlace", "$Value|" . ($Selected ? "1" : "0"));
}

sub SetCheckedIndex {
    my ($self, $InputPlace, $Index, $Selected) = @_;
    $self->AddLine("ki$InputPlace", "$Index|" . ($Selected ? "1" : "0"));
}

sub CallScript {
    my ($self, $ScriptText) = @_;
    $ScriptText =~ s/\n/\$[ln];/g;
    $self->AddLine("_", $ScriptText);
}

sub LoadUrl {
    my ($self, $InputPlace, $Url) = @_;
    $self->AddLine("lu$InputPlace", $Url);
}

sub ChangeUrl {
    my ($self, $Url) = @_;
    $self->AddLine("cu", $Url);
}

sub RemoveSessionCache {
    my ($self, $CacheKey) = @_;
    $self->AddLine("rs", $CacheKey);
}

sub RemoveAllSessionCache {
    my ($self) = @_;
    $self->AddLine("rs", "*");
}

sub RemoveCache {
    my ($self, $CacheKey) = @_;
    $self->AddLine("rd", $CacheKey);
}

sub RemoveAllCache {
    my ($self) = @_;
    $self->AddLine("rd", "*");
}

sub SetSessionCache {
    my ($self) = @_;
    $self->AddLine("cs", "1");
}

sub SetCache {
    my ($self, $Second) = @_;
    $self->AddLine("cd", $Second);
}

# Increase
sub IncreaseMinLength {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("+n$InputPlace", $Value);
}

sub IncreaseMaxLength {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("+x$InputPlace", $Value);
}

sub IncreaseFontSize {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("+f$InputPlace", $Value);
}

sub IncreaseWidth {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("+w$InputPlace", $Value);
}

sub IncreaseHeight {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("+h$InputPlace", $Value);
}

sub IncreaseValue {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("+v$InputPlace", $Value);
}

# Decrease
sub DecreaseMinLength {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("-n$InputPlace", $Value);
}

sub DecreaseMaxLength {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("-x$InputPlace", $Value);
}

sub DecreaseFontSize {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("-f$InputPlace", $Value);
}

sub DecreaseWidth {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("-w$InputPlace", $Value);
}

sub DecreaseHeight {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("-h$InputPlace", $Value);
}

sub DecreaseValue {
    my ($self, $InputPlace, $Value) = @_;
    $self->AddLine("-v$InputPlace", $Value);
}

# Event
sub SetPostEvent {
    my ($self, $InputPlace, $HtmlEvent) = @_;
    $self->AddLine("Ep$InputPlace", $HtmlEvent);
}

sub SetPostEventAdding {
    my ($self, $InputPlace, $HtmlEvent) = @_;
    $self->AddLine("Ep$InputPlace", "$HtmlEvent|+");
}

sub SetPostEventTo {
    my ($self, $InputPlace, $HtmlEvent, $OutputPlace) = @_;
    $self->AddLine("Ep$InputPlace", "$HtmlEvent|$OutputPlace");
}

sub SetPostEventListener {
    my ($self, $InputPlace, $HtmlEventListener) = @_;
    $self->AddLine("EP$InputPlace", $HtmlEventListener);
}

sub SetPostEventListenerAdding {
    my ($self, $InputPlace, $HtmlEventListener) = @_;
    $self->AddLine("EP$InputPlace", "$HtmlEventListener|+");
}

sub SetPostEventListenerTo {
    my ($self, $InputPlace, $HtmlEventListener, $OutputPlace) = @_;
    $self->AddLine("EP$InputPlace", "$HtmlEventListener|$OutputPlace");
}

sub SetGetEvent {
    my ($self, $InputPlace, $HtmlEvent, $Path) = @_;
    $Path //= "#";
    $self->AddLine("Eg$InputPlace", "$HtmlEvent|$Path");
}

sub SetGetEventWithOutputPlace {
    my ($self, $InputPlace, $HtmlEvent, $OutputPlace, $Path) = @_;
    $Path //= "#";
    $self->AddLine("Eg$InputPlace", "$HtmlEvent|$Path|$OutputPlace");
}

sub SetGetEventInForm {
    my ($self, $InputPlace, $HtmlEvent) = @_;
    $self->AddLine("Eg$InputPlace", $HtmlEvent);
}

sub SetGetEventInFormWithOutputPlace {
    my ($self, $InputPlace, $HtmlEvent, $OutputPlace) = @_;
    $self->AddLine("Eg$InputPlace", "$HtmlEvent|$OutputPlace");
}

sub SetGetEventListener {
    my ($self, $InputPlace, $HtmlEventListener, $Path) = @_;
    $Path //= "#";
    $self->AddLine("EG$InputPlace", "$HtmlEventListener|$Path");
}

sub SetGetEventListenerWithOutputPlace {
    my ($self, $InputPlace, $HtmlEventListener, $OutputPlace, $Path) = @_;
    $Path //= "#";
    $self->AddLine("EG$InputPlace", "$HtmlEventListener|$Path|$OutputPlace");
}

sub SetGetEventInFormListener {
    my ($self, $InputPlace, $HtmlEventListener) = @_;
    $self->AddLine("EG$InputPlace", $HtmlEventListener);
}

sub SetGetEventInFormListenerWithOutputPlace {
    my ($self, $InputPlace, $HtmlEventListener, $OutputPlace) = @_;
    $self->AddLine("EG$InputPlace", "$HtmlEventListener|$OutputPlace");
}

sub SetTagEvent {
    my ($self, $InputPlace, $HtmlEvent, $OutputPlace) = @_;
    $self->AddLine("Et$InputPlace", "$HtmlEvent|$OutputPlace");
}

sub SetTagEventListener {
    my ($self, $InputPlace, $HtmlEvent, $OutputPlace) = @_;
    $self->AddLine("ET$InputPlace", "$HtmlEvent|$OutputPlace");
}

sub RemovePostEvent {
    my ($self, $InputPlace, $HtmlEvent) = @_;
    $self->AddLine("Rp$InputPlace", $HtmlEvent);
}

sub RemoveGetEvent {
    my ($self, $InputPlace, $HtmlEvent) = @_;
    $self->AddLine("Rg$InputPlace", $HtmlEvent);
}

sub RemoveTagEvent {
    my ($self, $InputPlace, $HtmlEvent) = @_;
    $self->AddLine("Rt$InputPlace", $HtmlEvent);
}

sub RemovePostEventListener {
    my ($self, $InputPlace, $HtmlEventListener) = @_;
    $self->AddLine("RP$InputPlace", $HtmlEventListener);
}

sub RemoveGetEventListener {
    my ($self, $InputPlace, $HtmlEventListener) = @_;
    $self->AddLine("RG$InputPlace", $HtmlEventListener);
}

sub RemoveTagEventListener {
    my ($self, $InputPlace, $HtmlEventListener) = @_;
    $self->AddLine("RT$InputPlace", $HtmlEventListener);
}

# Save
sub SaveId {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@gi$InputPlace", $Key);
}

sub SaveName {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@gn$InputPlace", $Key);
}

sub SaveValue {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@gv$InputPlace", $Key);
}

sub SaveValueLength {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@ge$InputPlace", $Key);
}

sub SaveClass {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@gc$InputPlace", $Key);
}

sub SaveStyle {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@gs$InputPlace", $Key);
}

sub SaveTitle {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@gl$InputPlace", $Key);
}

sub SaveText {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@gt$InputPlace", $Key);
}

sub SaveTextLength {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@gg$InputPlace", $Key);
}

sub SaveAttribute {
    my ($self, $InputPlace, $Attribute, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@ga$InputPlace", "$Key|$Attribute");
}

sub SaveWidth {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@gw$InputPlace", $Key);
}

sub SaveHeight {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@gh$InputPlace", $Key);
}

sub SaveReadOnly {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@gr$InputPlace", $Key);
}

sub SaveSelectedIndex {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@gx$InputPlace", $Key);
}

sub SaveTextAlign {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@ta$InputPlace", $Key);
}

sub SaveNodeLength {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@nl$InputPlace", $Key);
}

sub SaveVisible {
    my ($self, $InputPlace, $Key) = @_;
    $Key //= ".";
    $self->AddLine("\@vi$InputPlace", $Key);
}

# Pre Runner
sub AssignDelay {
    my ($self, $Second, $Index) = @_;
    my $CurrentName = $self->GetNameByIndex($Index);
    return unless defined $CurrentName;
    $self->ChangeNameByIndex($Index, ":$Second)$CurrentName");
}

sub AssignDelayChange {
    my ($self, $Second, $Index) = @_;
    my $CurrentName = $self->GetNameByIndex($Index);
    return unless defined $CurrentName;
    $CurrentName =~ s/^:(.*?)\)//;
    $self->ChangeNameByIndex($Index, ":$Second)$CurrentName");
}

sub AssignInterval {
    my ($self, $Second, $Index) = @_;
    my $CurrentName = $self->GetNameByIndex($Index);
    return unless defined $CurrentName;
    $self->ChangeNameByIndex($Index, "($Second)$CurrentName");
}

sub AssignIntervalChange {
    my ($self, $Second, $Index) = @_;
    my $CurrentName = $self->GetNameByIndex($Index);
    return unless defined $CurrentName;
    $CurrentName =~ s/^\((.*?)\)//;
    $self->ChangeNameByIndex($Index, "($Second)$CurrentName");
}

# Index
sub StartIndex {
    my ($self, $Name) = @_;
    $self->AddLine("#", $Name // "");
}

# Get
sub GetFormsActionData {
    my ($self) = @_;
    my $ReturnValue = "";
    foreach my $key (keys %{$self->{WebFormsData}}) {
        foreach my $value (@{$self->{WebFormsData}{$key}}) {
            $ReturnValue .= "\n$key";
            $ReturnValue .= "=$value" if $value ne "";
        }
    }
    return $ReturnValue;
}

sub Response {
    my ($self) = @_;
    return "[web-forms]" . $self->GetFormsActionData();
}

sub GetFormsActionDataLineBreak {
    my ($self) = @_;
    my $ReturnValue = "";
    my @keys = keys %{$self->{WebFormsData}};
    my $i = scalar @keys;
    foreach my $key (@keys) {
        foreach my $value (@{$self->{WebFormsData}{$key}}) {
            $ReturnValue .= $key;
            $ReturnValue .= "=$value" if $value ne "";
            $ReturnValue .= "\$[sln];" if $i-- > 1;
        }
    }
    return $ReturnValue;
}

# Export
sub ExportToWebFormsTag {
    my ($self, $src) = @_;
    return "<web-forms ac=\"" . $self->GetFormsActionDataLineBreak() . "\"" . (defined $src ? " src=\"$src\"" : "") . "></web-forms>";
}

sub ExportToWebFormsTagWithSize {
    my ($self, $Width, $Height, $src) = @_;
    return "<web-forms ac=\"" . $self->GetFormsActionDataLineBreak() . "\" width=\"$Width\" height=\"$Height\"" . (defined $src ? " src=\"$src\"" : "") . "></web-forms>";
}

sub DoneToWebFormsTag {
    my ($self, $Id) = @_;
    return "<web-forms ac=\"" . $self->GetFormsActionDataLineBreak() . "\"" . (defined $Id ? " id=\"$Id\" done=\"true\"" : "") . "></web-forms>";
}

sub ExportToNameValue {
    my ($self) = @_;
    return $self->{WebFormsData};
}

sub AppendForm {
    my ($self, $form) = @_;
    foreach my $key (keys %{$form->ExportToNameValue()}) {
        push @{$self->{WebFormsData}{$key}}, @{$form->ExportToNameValue(){$key}};
    }
}

sub Clean {
    my ($self) = @_;
    $self->{WebFormsData} = {};
}

1;

package InputPlace;

use strict;
use warnings;

sub Id {
    my ($Id) = @_;
    return $Id;
}

sub Name {
    my ($Name, $Index) = @_;
    return "($Name)" . (defined $Index ? $Index : "");
}

sub Tag {
    my ($Tag, $Index) = @_;
    return "<$Tag>" . (defined $Index ? $Index : "");
}

sub Class {
    my ($Class, $Index) = @_;
    return "{$Class}" . (defined $Index ? $Index : "");
}

sub Query {
    my ($Query) = @_;
    $Query =~ s/=/\\$[eq];/g;
    return "*$Query";
}

sub QueryAll {
    my ($Query) = @_;
    $Query =~ s/=/\\$[eq];/g;
    return "[$Query";
}

1;

package OutputPlace;

use parent 'InputPlace';

1;

package Fetch;

use strict;
use warnings;

sub Random {
    my ($MinValue, $MaxValue) = @_;
    return "@mr" . (defined $MaxValue ? "$MaxValue,$MinValue" : $MinValue);
}

use constant {
    DateYear         => '@dy',
    DateMonth        => '@dm',
    DateDay          => '@dd',
    DateHours        => '@dh',
    DateMinutes      => '@di',
    DateSeconds      => '@ds',
    DateMilliseconds => '@dl',
};

sub Cookie {
    my ($Key) = @_;
    return "@co$Key";
}

sub Session {
    my ($Key, $ReplaceValue) = @_;
    return "@cs$Key" . (defined $ReplaceValue ? ",$ReplaceValue" : "");
}

sub SessionAndRemove {
    my ($Key, $ReplaceValue) = @_;
    return "@cl$Key" . (defined $ReplaceValue ? ",$ReplaceValue" : "");
}

sub Saved {
    my ($Key) = @_;
    $Key //= ".";
    return "@cl$Key";
}

sub Cache {
    my ($Key, $ReplaceValue) = @_;
    return "@cd$Key" . (defined $ReplaceValue ? ",$ReplaceValue" : "");
}

sub CacheAndRemove {
    my ($Key, $ReplaceValue) = @_;
    return "@ct$Key" . (defined $ReplaceValue ? ",$ReplaceValue" : "");
}

sub Script {
    my ($ScriptText) = @_;
    $ScriptText =~ s/\n/\$[ln];/g;
    return "@_$ScriptText";
}

1;

package HtmlEvent;

use strict;
use warnings;

use constant {
    OnAbort           => 'onabort',
    OnAfterPrint      => 'onafterprint',
    OnBeforePrint     => 'onbeforeprint',
    OnBeforeUnload    => 'onbeforeunload',
    OnBlur            => 'onblur',
    OnCanPlay         => 'oncanplay',
    OnCanPlayThrough  => 'oncanplaythrough',
    OnChange          => 'onchange',
    OnClick           => 'onclick',
    OnCopy            => 'oncopy',
    OnCut             => 'oncut',
    OnDoubleClick     => 'ondblclick',
    OnDrag            => 'ondrag',
    OnDragEnd         => 'ondragend',
    OnDragEnter       => 'ondragenter',
    OnDragLeave       => 'ondragleave',
    OnDragOver        => 'ondragover',
    OnDragStart       => 'ondragstart',
    OnDrop            => 'ondrop',
    OnDurationChange  => 'ondurationchange',
    OnEnded           => 'onended',
    OnError           => 'onerror',
    OnFocus           => 'onfocus',
    OnFocusin         => 'onfocusin',
    OnFocusOut        => 'onfocusout',
    OnHashChange      => 'onhashchange',
    OnInput           => 'oninput',
    OnInvalid         => 'oninvalid',
    OnKeyDown         => 'onkeydown',
    OnKeyPress        => 'onkeypress',
    OnKeyUp           => 'onkeyup',
    OnLoad            => 'onload',
    OnLoadedData      => 'onloadeddata',
    OnLoadedMetaData  => 'onloadedmetadata',
    OnLoadStart       => 'onloadstart',
    OnMouseDown       => 'onmousedown',
    OnMouseEnter      => 'onmouseenter',
    OnMouseLeave      => 'onmouseleave',
    OnMouseMove       => 'onmousemove',
    OnMouseOver       => 'onmouseover',
    OnMouseOut        => 'onmouseout',
    OnMouseUp         => 'onmouseup',
    OnOffline         => 'onoffline',
    OnOnline          => 'ononline',
    OnPageHide        => 'onpagehide',
    OnPageShow        => 'onpageshow',
    OnPaste           => 'onpaste',
    OnPause           => 'onpause',
    OnPlay            => 'onplay',
    OnPlaying         => 'onplaying',
    OnProgress        => 'onprogress',
    OnRateChange      => 'onratechange',
    OnResize          => 'onresize',
    OnReset           => 'onreset',
    OnScroll          => 'onscroll',
    OnSearch          => 'onsearch',
    OnSeeked          => 'onseeked',
    OnSeeking         => 'onseeking',
    OnSelect          => 'onselect',
    OnStalled         => 'onstalled',
    OnSubmit          => 'onsubmit',
    OnSuspend         => 'onsuspend',
    OnTimeUpdate      => 'ontimeupdate',
    OnToggle          => 'ontoggle',
    OnTouchCancel     => 'ontouchcancel',
    OnTouchend        => 'ontouchend',
    OnTouchMove       => 'ontouchmove',
    OnTouchStart      => 'ontouchstart',
    OnUnload          => 'onunload',
    OnVolumeChange    => 'onvolumechange',
    OnWaiting         => 'onwaiting',
};

1;

package HtmlEventListener;

use strict;
use warnings;

use constant {
    Abort             => 'abort',
    AfterPrint        => 'afterprint',
    BeforePrint       => 'beforeprint',
    BeforeUnload      => 'beforeunload',
    Blur              => 'blur',
    CanPlay           => 'canplay',
    CanPlayThrough    => 'canplaythrough',
    Change            => 'change',
    Click             => 'click',
    Copy              => 'copy',
    Cut               => 'cut',
    DoubleClick       => 'dblclick',
    Drag              => 'drag',
    DragEnd           => 'dragend',
    DragEnter         => 'dragenter',
    DragLeave         => 'dragleave',
    DragOver          => 'dragover',
    DragStart         => 'dragstart',
    Drop              => 'drop',
    DurationChange    => 'durationchange',
    Ended             => 'ended',
    Error             => 'error',
    Focus             => 'focus',
    Focusin           => 'focusin',
    FocusOut          => 'focusout',
    HashChange        => 'hashchange',
    Input             => 'input',
    Invalid           => 'invalid',
    KeyDown           => 'keydown',
    KeyPress          => 'keypress',
    KeyUp             => 'keyup',
    Load              => 'load',
    LoadedData        => 'loadeddata',
    LoadedMetaData    => 'loadedmetadata',
    LoadStart         => 'loadstart',
    MouseDown         => 'mousedown',
    MouseEnter        => 'mouseenter',
    MouseLeave        => 'mouseleave',
    MouseMove         => 'mousemove',
    MouseOver         => 'mouseover',
    MouseOut          => 'mouseout',
    MouseUp           => 'mouseup',
    Offline           => 'offline',
    Online            => 'online',
    PageHide          => 'pagehide',
    PageShow          => 'pageshow',
    Paste             => 'paste',
    Pause             => 'pause',
    Play              => 'play',
    Playing           => 'playing',
    Progress          => 'progress',
    RateChange        => 'ratechange',
    Resize            => 'resize',
    Reset             => 'reset',
    Scroll            => 'scroll',
    Search            => 'search',
    Seeked            => 'seeked',
    Seeking           => 'seeking',
    Select            => 'select',
    Stalled           => 'stalled',
    Submit            => 'submit',
    Suspend           => 'suspend',
    TimeUpdate        => 'timeupdate',
    Toggle            => 'toggle',
    TouchCancel       => 'touchcancel',
    Touchend          => 'touchend',
    TouchMove         => 'touchmove',
    TouchStart        => 'touchstart',
    Unload            => 'unload',
    VolumeChange      => 'volumechange',
    Waiting           => 'waiting',
    AnimationEnd      => 'animationend',
    AnimationIteration => 'animationiteration',
    AnimationStart    => 'animationstart',
    ContextMenu       => 'contextmenu',
    FullScreenChange  => 'fullscreenchange',
    FullScreenError   => 'fullscreenerror',
    PopState          => 'popstate',
    TransitionEnd     => 'transitionend',
    Storage           => 'storage',
    Wheel             => 'wheel',
};

1;

package ExtensionWebFormsMethods;

use strict;
use warnings;

sub AppendPlace {
    my ($Text, $Value) = @_;
    return length($Text) < 1 ? $Value : "$Text|$Value";
}

sub AppendParrent {
    my ($Text) = @_;
    return "/$Text";
}

sub ExportToWebFormsTag {
    my ($src, $Width, $Height) = @_;
    if (defined $Width && defined $Height) {
        return "<web-forms src=\"$src\" width=\"$Width\" height=\"$Height\"></web-forms>";
    } else {
        return "<web-forms src=\"$src\"></web-forms>";
    }
}

sub ExportActionControlsToWebFormsTag {
    my ($ActionControls) = @_;
    return "<web-forms ac=\"$ActionControls\"></web-forms>";
}

sub RemoveOuter {
    my ($Text, $StartString, $EndString) = @_;
    my $Start = index($Text, $StartString);
    return $Text if $Start == -1;
    my $End = index($Text, $EndString, $Start);
    return $Text if $End == -1;
    my $lengthToRemove = ($End - $Start) + length($EndString);
    return substr($Text, 0, $Start) . substr($Text, $Start + $lengthToRemove);
}

1;