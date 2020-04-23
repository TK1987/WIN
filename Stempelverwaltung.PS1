Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Version='0.2 Beta'

########################################################################################################################################
###################################################    GUI-Module   ####################################################################
########################################################################################################################################

Function Fenster {
	Param(
		[Alias('t')][string]$Text,
		[Alias('p')][string]$Padding='15,15,15,15',
		[Alias('m')][string]$Margin='15,15,15,15',
		[Alias('a')][switch]$AutoSize,
		[Alias('b')][int]$Breite=100,
		[Alias('h')][int]$Höhe=100,
		[Alias('s')][string]$StartPosition='Manual',
		[Alias('st')][string]$State='Normal',
		[Alias('ad')][switch]$AllowDrop,
		[Alias('i')][object]$Icon,
		[int]$X,
		[int]$Y
		)
	
	$Fenster=New-Object System.Windows.Forms.Form -Property @{
		Text=$Text
		Size="$Breite,$Höhe"
		StartPosition=$StartPosition
		Location="$X,$Y"
		AutoSize=$AutoSize
		Padding=$Padding
		Margin=$Marginithg
		WindowState=$State
		AllowDrop=$AllowDrop
		TabIndex=9999ithub.com
		Icon=$Icon
		}
	
	Return $Fenster
	} # ENDE Function Fenster

Function Panel {
	Param(
		[Alias('b')][int]$Breite=20,
		[Alias('h')][int]$Höhe=20,
		[int]$X=0,
		[int]$Y=0,
		[Alias('p')][string]$Padding='15,15,15,15',
		[Alias('m')][string]$Margin='15,15,15,15',
		[Alias('d')][string]$Dock='None',
		[Alias('a')][string]$Anker='Top,Left',
		[Alias('ad')][switch]$AllowDrop,
		[Alias('i')][object]$Image,
		[Alias('ind')][int]$Index
		)
		
	$Panel=New-Object System.Windows.Forms.Panel -Property @{
		Dock=$Dock
		Anchor=$Anker
		Location="$X,$Y"
		Size="$Breite,$Höhe"
		Padding=$Padding
		Margin=$Margin
		AllowDrop=$AllowDrop
		BackGroundImage=$Image
		BackgroundImageLayout='zoom'
		TabIndex=$Index
		}
		
	Return $Panel
	
	} # ENDE Function Panel

Function SplitContainer{
	Param(
		[Alias('o')][string]$Orientation='Vertical',
		[Alias('p')][string]$Padding='30,30,30,30',
		[Alias('m')][string]$Margin='30,30,30,30',
		[Alias('d')][string]$Dock='None',
		[Alias('s')][int]$Splitterbreite=30,
		[Alias('ad')][switch]$AllowDrop
		)
		
	$Split=New-Object System.Windows.Forms.SplitContainer -Property @{
		Orientation=$Orientation
		SplitterWidth=$Splitterbreite
		Dock=$Dock
		Padding=$Padding
		Margin=$Margin
		AllowDrop=$AllowDrop
		TabStop=$False
		}

	Return $Split

	} # ENDE Function SplitContainer

Function Gruppe {
	Param(
		[Alias('t')][string]$Text,
		[Alias('d')][string]$Dock='None',
		[int]$X,
		[int]$Y,
		[Alias('b')][int]$Breite=100,
		[Alias('h')][int]$Höhe=100,
		[Alias('p')][string]$Padding='15,15,15,15',
		[Alias('m')][string]$Margin='15,15,15,15',
		[Alias('as')][switch]$AutoSize,
		[Alias('a')][string]$Anker='Top,Left',
		[Alias('ad')][switch]$AllowDrop
		)
		
	$Gruppe=New-Object System.Windows.Forms.GroupBox -property @{
		Text=$Text
		Dock=$Dock
		Location="$X,$Y"
		Size="$Breite,$Höhe"
		AutoSize=$AutoSize
		Anchor=$Anker
		Padding=$Padding
		Margin=$Margin
		AllowDrop=$AllowDrop
	}

	Return $Gruppe
	
	} # ENDE Function Gruppe

Function Schrift {
	Param(
		[Alias('a')][string]$Art='Microsoft Sans Serif',
		[Alias('g')][int]$Größe=11,
		[Alias('f')][switch]$Fett,
		[Alias('k')][switch]$Kursiv,
		[Alias('u')][switch]$Unterschrichen
		)
	
	$Stil=[System.Drawing.Fontstyle]::Regular
	if ($Fett) {$Stil=[System.Drawing.Fontstyle]::Bold}
	if ($Kursiv) {$Stil+=[System.Drawing.Fontstyle]::Italic}
	if ($Unterschrichen) {$Stil+=[System.Drawing.Fontstyle]::Underline}
	
	$Schrift=New-Object System.Drawing.Font($Art,$Größe,$Stil)
	
	Return $Schrift

	}  # ENDE Function Schrift

Function Button {
	Param(
		[Alias('t')][string]$Text,
		[Alias('b')][int]$Breite=100,
		[Alias('h')][int]$Höhe=40,
		[int]$X,
		[int]$Y,
		[Alias('a')][string]$Anker='Top,Left',
		[Alias('d')][string]$Dock='None',
		[Alias('p')][string]$Padding='0,0,0,0',
		[Alias('m')][string]$Margin='15,15,15,15',
		[Alias('ind')][int]$Index=0,
		[Alias('s')][object]$Schrift=(Schrift),
		[Alias('i')][object]$Image
		)
	
	$Button=New-Object System.Windows.Forms.Button -Property @{
		Text=$Text
		Dock=$Dock
		Size="$Breite,$Höhe"
		Location="$X,$Y"
		TabIndex=$Index
		Font=$Schrift
		Anchor=$Anker
		Padding=$Padding
		Margin=$Margin
		BackGroundImage=$Image
		BackgroundImageLayout='zoom'
	}
	
	Return $Button

	} # ENDE Function Button

Function Label {
	Param(
		[Alias('t')][string]$Text,
		[Alias('as')][switch]$AutoSize,
		[Alias('b')][int]$Breite=400,
		[Alias('h')][int]$Höhe=25,
		[Alias('p')][string]$Padding='0,0,0,0',
		[Alias('m')][string]$Margin='15,15,15,15',
		[int]$X=15,
		[int]$Y,
		[Alias('s')][object]$Schrift=(Schrift),
		[Alias('a')][string]$Anker='MiddleLeft'
		)
	
	$Label=New-Object System.Windows.Forms.Label -Property @{
		Text=$Text
		Location="$X,$Y"
		TextAlign=$Anker
		Font=$Schrift
		Padding=$Padding
		Margin=$Margin
		AutoSize=$AutoSize
		Size="$Breite,$Höhe"
	}
	
	Return $Label

	} # ENDE Function Label

Function TextBox {
	Param(
		[Alias('t')][string]$Text,
		[Alias('a')][string]$Anker='Top,Left',
		[Alias('d')][string]$Dock='None',
		[Alias('b')][int]$Breite=400,
		[Alias('h')][int]$Höhe=25,
		[Alias('p')][string]$Padding='15,15,15,15',
		[Alias('m')][string]$Margin='15,15,15,15',
		[int]$X=15,
		[int]$Y,
		[Alias('ind')][int]$Index=0,
		[Alias('s')][object]$Schrift=(Schrift),
		[switch]$Multi,
		[Alias('g')][switch]$Gesperrt,
		[Alias('ad')][switch]$AllowDrop,
		[Alias('ta')][string]$TextAnker='Left'
		)
	
	$TextBox=New-Object System.Windows.Forms.TextBox -Property @{
		Text=$Text
		Dock=$Dock
		Size="$Breite,$Höhe"
		Multiline=$Multi
		Location=New-Object System.Drawing.Size($X,$Y)
		TabIndex=$Index
		Font=$Schrift
		Anchor=$Anker
		Padding=$Padding
		Margin=$Margin
		Readonly=$Gesperrt
		AllowDrop=$AllowDrop
		TextAlign=$TextAnker
	}
	
	if ($Gesperrt) {$TextBox.TabStop=$False}
	Return $TextBox

	} # ENDE Function TextBox

Function RTFBox {
	Param(
		[Alias('t')][string]$Text,
		[Alias('a')][string]$Anker='Top,Left',
		[Alias('d')][string]$Dock='None',
		[Alias('b')][int]$Breite=400,
		[Alias('h')][int]$Höhe=25,
		[Alias('p')][string]$Padding='15,15,15,15',
		[Alias('m')][string]$Margin='15,15,15,15',
		[int]$X=15,
		[int]$Y,
		[Alias('i')][int]$Index,
		[Alias('s')][object]$Schrift=(Schrift),
		[switch]$Multi,
		[Alias('g')][switch]$Gesperrt,
		[Alias('ro')][switch]$Readonly,
		[Alias('ad')][switch]$AllowDrop,
		[Alias('sb')][string]$Scrollbars='none'

		)
	if ($Gesperrt) {$Gesperrt=$False} else {$Gesperrt=$True}
	$TextBox=New-Object System.Windows.Forms.RichTextBox -Property @{
		Text=$Text
		Dock=$Dock
		Size="$Breite,$Höhe"
		Multiline=$Multi
		Location=New-Object System.Drawing.Size($X,$Y)
		TabIndex=$Index
		Font=$Schrift
		Anchor=$Anker
		Padding=$Padding
		Margin=$Margin
		Readonly=$Readonly
		AllowDrop=$AllowDrop
		Enabled=$Gesperrt
		Scrollbars=$Scrollbars

	}
	
	Return $TextBox

	} # ENDE Function RTFBox

Function CheckBox {
	Param(
		[Alias('t')][string]$Text,
		[Alias('b')][int]$Breite=400,
		[Alias('h')][int]$Höhe=25,
		[int]$X=15,
		[int]$Y,
		[Alias('as')][switch]$AutoSize,
		[Alias('c')][switch]$Checked,
		[Alias('d')][string]$Dock='None',
		[Alias('a')][string]$Anker='Top,Left',
		[Alias('ind')][int]$Index=0,
		[Alias('s')][object]$Schrift=(Schrift)
		)
	
	$CheckBox=New-Object System.Windows.Forms.CheckBox -Property @{
		Text=$Text
		Checked=$Checked
		Location="$X,$Y"
		Size="$Breite,$Höhe"
		Font=$Schrift
		TabIndex=$Index
		AutoSize=$AutoSize
		Dock=$Dock
		Anchor=$Anker
		}
	
	Return $CheckBox

	} # ENDE Function CheckBox

Function RadioButton {
	Param(
		[Alias('t')][string]$Text,
		[Alias('b')][int]$Breite=400,
		[Alias('h')][int]$Höhe=25,
		[int]$X=15,
		[int]$Y,
		[Alias('i')][int]$Index,
		[Alias('s')][object]$Schrift=(Schrift),
		[Alias('c')][switch]$Checked
		)
	
	$RadioButton=New-Object System.Windows.Forms.RadioButton -Property @{
		Text=$Text
		Size=New-Object System.Drawing.Size($Breite,$Höhe)
		Location=New-Object System.Drawing.Size($X,$Y)
		Font=$Schrift
		TabIndex=$Index
		Checked=$Checked
		}
	
	Return $RadioButton

	} # ENDE Function RadioButton

Function OrdnerÖffnen {
	Param(
		[Alias('p')][string]$Pfad=(Get-Volume | ? {Test-Path ($_.DriveLetter+':\Daten')}|select -First 1|%{ls -dir ($_.DriveLetter+':\Daten\*') |select -First 1}),
		[Alias('t')][string]$Text
		)
	
	$Ordner=New-Object System.Windows.Forms.FolderBrowserDialog
	$Ordner.Description=$Text
	$Ordner.SelectedPath=$Pfad
	$Error=$Ordner.ShowDialog()
	
	if ($Error -ne 'Cancel') {Return $Ordner.SelectedPath}

	} # ENDE Function OrdnerÖffnen

Function DateiÖffnen {
	Param(
		[Alias('t')][string]$Text,
		[Alias('p')][string]$Pfad=(Get-Volume | ? {Test-Path ($_.DriveLetter+':\Daten')}|select -First 1|%{$_.DriveLetter+':\Daten'}),
		[Alias('f')][string]$Dateiformat='Alle Dateien|*.*'  # 'Beschreibung 1|*.format1|Beschreibung 2|*.format2|...'
		)
		
	$Datei=New-Object System.Windows.Forms.OpenFileDialog
	$Datei.InitialDirectory=$Pfad
	$Datei.Title=$Text
	$Datei.Filter=$Dateiformat
	[void]$Datei.ShowDialog()
	
	Return $Datei.FileName
	
	} # ENDE Function DateiÖffnen

Function Tabelle {
	Param(
		[int]$X,
		[int]$Y,
		[Alias('b')][int]$Breite=100,
		[Alias('h')][int]$Höhe=100,
		[Alias('d')][string]$Dock='None',
		[Alias('a')][string]$Anker='Top,Left',
		[Alias('c')][switch]$CheckBox,
		[Alias('z')][switch]$ZeilenKopf,
		[Alias('ar')][switch]$AutoAddRows,
		[Alias('m')][string]$Editmode='EditOnEnter',
		[switch]$Auto,
		[Alias('ad')][switch]$AllowDrop,
		[Alias('ind')][int]$Index=0
		)
	$Grid=New-Object System.Windows.Forms.DataGridView -Property @{
		Location="$X,$Y"
		Size="$Breite,$Höhe"
		Dock=$Dock
		Anchor=$Anker
		RowHeadersVisible=$ZeilenKopf
		AllowUserToAddRows=$AutoAddRows
		AllowUserToResizeRows=$False
		AutoSizeRowsMode=6
		Editmode=$Editmode
		ColumnHeadersHeightSizeMode='DisableResizing'
		AutoGenerateColumns=$Auto
		AllowDrop=$AllowDrop
		TabIndex=$Index
		}
	
	if ($CheckBox) {$Grid.Columns.Add((New-Object System.Windows.Forms.DataGridViewCheckBoxColumn))}
	
	Return $Grid

	} # ENDE Function Tabelle

Function ComboBox {
	Param(
		[Alias('i')][object]$Items,
		[Alias('a')][string]$Anker='Top,Left',
		[Alias('d')][string]$Dock='None',
		[Alias('b')][int]$Breite=400,
		[Alias('h')][int]$Höhe=25,
		[Alias('p')][string]$Padding='0,0,0,0',
		[int]$X=15,
		[int]$Y,
		[Alias('ind')][int]$Index,
		[Alias('s')][object]$Schrift=(Schrift)
		)
	
	$ComboBox=New-Object System.Windows.Forms.ComboBox -Property @{
		Dock=$Dock
		Size="$Breite,$Höhe"
		Location=New-Object System.Drawing.Size($X,$Y)
		TabIndex=$Index
		Font=$Schrift
		Anchor=$Anker
		Padding=$Padding
	}
	
	if ($Items) {$ComboBox.Items.AddRange($Items)}
	
	Return $ComboBox

	} # ENDE Function ComboBox
	
########################################################################################################################################
################################################  ENDE -   GUI-Module   ################################################################
########################################################################################################################################

# --------------------------------------------------------------------------------------------------------------------------------------

########################################################################################################################################
#######################################################   Images    ####################################################################
########################################################################################################################################

$Logo=[System.Drawing.Icon]::New([System.IO.MemoryStream][convert]::FromBase64String('
AAABAAEAZGQQAAEABABPBQAAFgAAAIlQTkcNChoKAAAADUlIRFIAAABkAAAAZAgGAAAAcOKVVAAA
BRZJREFUeJztnc9LW1kUx78ODyzEYKQB80DywOLLwiyCMpZKZ2UzGRi6sVjrpkLn76idZd22YDd1
oLNz4yKuJK47mKJk0engkxEiQhJISUQFwwQ6i84L/mgcb7zn5bzkfECImnvOM997873n3pdrT/3L
P18gXAvHcfDw54f4e28PADA//xTLvy1/87mT9ybxufwZt8O3kc1+6Lluju/0XKqgCxFEEXd0UCGC
KHJneJg0vgjCDBGEGSKIIuIhzBAP6TJEEGaIIIT03upVbiOCEFI7rSm3EUGYIYIwQwQhRDyEGeIh
HYAIwgwRhBDxEGa04iEGwXU0KBQK+PjxT8oU2kkmH7Q1P5kgmcwGspub2NvbQ6VSoUqjlfHxcQBA
PD4K0zTbcg0kgjiOg+zmJl68+JUiPBnp9Brm55/iydycFkHYeEg+v4/19XWK0OS8e/e7tlisPKRU
LDUeT07ew+zsLFWqG1GtVrG1tYV0ek177FZGCKmpuzxfWIBlRWHbthfplMlkNlAul/H+/R9a49ZO
a+jr61NqQz7tdbc8uYoBAJYVxcjIiPa4bDykk1F5kVl5yFUUCgWSuO2aqjaDrYecJZPZQKlYxOHh
oda4diwGgF4UlV7fioe0ZYSsrq6iXC5rjZlIJGBZUXJBVHq9LzzE2dnRLoZLPr9PEvcsqiNEFXJB
LvYSOxbTPqMJh8OIxWKwrKjWuN+CeoR4/pZlWVE8mZsjiRsMBrXHvQm+8BDbtlnXJDrxhYd0E6w8
pJXe0WmwGiGt9I5Og1Wl3qx3OI7jyfT0//BiE4rVLKtZ78jn97GWTiOXy1GlvkS9XodhnP9Tny8s
eFLVs1ntbdY7SsWip2IAuCRGOBz2JK9vPMSrF6QZVCsFF/GFhwxGIpiamlKO19/ff25B8uL3qrG4
VfUunntIMvkA8fgoVdpr48VSPatK/arewW3fggrfeEi3IJU6M3zhIQDdFq4K4iH/kclswNnZQbVa
pUp9LWYez5CvOvtmhKysrFClvTYTd++SC+KLSr2bkFmWAl4Uhr6o1OPxUbxdftu2FV/LiiKf39ey
3RsIBK78vS88xDRNmKbZ1m1cr3KLhzBDPIQZUqkzwxce0k1buKwq9Wbk8/t4s7SEYrF4aSePgnq9
3njs5kskEgDol09YeUgzSsUiyuWyJ2IAX0Vwv1wODg48yc3KQ1wuXtRgJNL2LdyhoSFP8rDykGZY
VhTT09Nepz3HYCTiya6lLzxE7u29Grm3lxCWHtLNsBwh1Edz62J3d1d7TFarvWd5s7TkyXJ3qyy+
XNR+aADAbJY1GBlsjI50eo3k6AoKdJ7tzma1Nx4fRSqVoghNzv0f7muLxWaEmKaJmcczCIVC2N7e
BgBUKhUMDAxQpNPG2NgY7FhM2yFmrOoQ27YRDAYbH+j3A7oXHNmMEBd3d7BbYeMhwldY1iGdhu9P
cug0yE9ycBxHuVG3kt3Mkt8rYCy+XNQWLBAI4OTkpHG/kvv47M/8TC6XI18KMnSewincHPGQFrkz
PIwYQY1lUP5fvt5bvaid1jrulqBQKIRUKoXkj0ntsY3UT/5cc2o3z355RlL0Gq9ev9IeVGgd8RBm
iCCEhEIh5TYiCDNEEEJa+WCrweEjyp3G0dERAODTp78wMfG9Ulvj0fQjimvqeo6Pj1tqZ2SzHzRf
iuCiOjoAwGilkaBEj8qTDdUGAi0yy2KGCMIMEYQZIggzRBBmiCDMEEGYIYIwQwRhxr8sTalCReb5
GgAAAABJRU5ErkJggg==
'))

$Öffnen=[System.Drawing.Image]::FromStream([System.IO.MemoryStream][convert]::FromBase64String('
AAABAAEAPDwQAAEABAAHBAAAFgAAAIlQTkcNChoKAAAADUlIRFIAAAA8AAAAPAgGAAAAOvzZcgAA
A85JREFUaIHtmU9oE0EUxr+0AbVpQlkLIYmtCFZKodWqBUnpSaSgtOhFS2+CEunBm4jHXr14bYke
vJQi/kMEEfGg0lxqW9peAs1FIQ0ruOhuxnpouh7aSafbZHdms2036/4g7OzMZHa+mfdm3s4GFDkF
AEgOTCHzZRTTb6YxMjxSvjdizE8OTOHuvQaMDI9UrFOpHfqMauUA0H3mCcLhI7vyrdC0NeTldSiF
VMXyBuEW6xxfsNfxBXsdX7DX8QV7HV+w17EULMUmdfY+m9NM74313QbXDFMR7JX+AGAs9XtHuXEQ
3ESwWkE2p+lSbBKJaBDx9g0MDqf1vr7q42MsN8x0wJHeOkBVwdjspB5v38DQlVNojRUEm9YwO7tB
23ENZoLLULGRsGRZV9UURMISbt4Coq2HsDCv6FJscle9sdR2XqVyAICsmT6r82RYeDC5BPMINdaN
hCVcvqqg6XBCtE+m/Pm7htzKGrI5zZblmAnWAeDEsTb0dl1ALBoRapgQglAohKGLpJynFkuIRSMo
yCoizY228j5/+o7HT+fowujoDAewJZo+lIowpitBy9g6NMkOnmheR2cLmg6LH/1QhAKPnZ2vLnYv
EbU0I3UXaRVklSZt+bCZYK7ggRBiXclBqHuBs39GzARzjeBBmbZduLYltViCUdd+zyxdpee+/tyR
n81push+zLcPb5tRWejDR/OQV/dXNGVpWQEAW1sTl2AWtVjCi9cLePk8h7y8Lvr3vUDP5rYjskQ0
aDoAwoIn0ov48D6P/qSzEZQTzGTylnWEBBdkFfIqQU+3hNEbXTh3/mi5jPoYIcTxdEFWd13ZCCzS
3Ai1WML9Bx/x9t0PUzMXEjyRXsRMZnN2OzpbKkZRoVDI8TQNNoxX+tyCrGIivYiFeQVmYq0El/c5
tViCWlTLi1Q0Hqo54nGSSHMj5FXCtaZwxdKsuP5kAndun661jwcGl0kz4ZwrUYslmrTcorhjaeq/
QO0BvNOwfbOCO5Zm/Xe/oywzCCHc/gsIxtLUf10aP3NFXFwmvZL9VU6zYaYbYPyX6+3JctGivrG0
rODSYJvtju0FhBDWf2ueYR0A8vI6nr36hp5uyZXmLOK/gKAPu9ScAxB4Y6q7Ix4KY85CJx9cghPR
IKJxd5kyIG7OAOc+7PLtSAhuH3ap/wKCJx5168PMduSsD1P/dZM504OILf917ExLB4Des5v7L3vK
cNCwkZ8oPO/DgfHxjBu/6Dv+9RAAAltnRK7j+rXjtv7HcwDgqi/4tVK3q7RdfMFexxfsdXzBXscX
7HX+O8H/ADC+ttkKvd/mAAAAAElFTkSuQmCC
'))

$Warnung=[System.IO.MemoryStream][convert]::FromBase64String('
AAABAAEAZGQQAAEABADsAwAAFgAAAIlQTkcNChoKAAAADUlIRFIAAABkAAAAZAgGAAAAcOKVVAAA
A7NJREFUeJzt3UFu00AYxfFxxYYLVKq8QVwiK8IhWHGH9jRwB3bcAXESKqJKvUC7illYH1XsGTsz
nvm+98bzl7wgSqQ0z7+aNFLbuc61gLqxfgKty9ogYLVBwGqDgNUGAeud9RPI0DD5N/X/G9mFTMcI
3UYT8yBLLzztKMyDVBnrINcIoFTCOki1MQ4Sc+bTKWEcpOrYBvGe8X0/HjGPQY1tkFl979zxMB4L
o9DE9E7de6YfD859+Nj9v8uPn8HHUryDZxpkVt+PY9w/jFt9/9a5vh/c6WT8xDbVURyD7/j6xQ2n
RzecX8fj9DjeFro/wNexetBeQ0TH3e3bbXe3423c1xKAsyKHjlqUUArx6ZD4lQCcFbl01KCETsiS
DolbCcBZEasjJGN6MCqhEiI6ro1TCcBZUUIHqxIaIbE6JD4lAGdFKR2MSiiEhHTcvPcf07iUAJwV
KToWzvjBdbxK4IWkXjum8SgBOCvWdEzfla/p8ClhefcOLeSad+XXxvPuHeCsiNGRKoRFCayQnDok
BiUIgwQ/K5ePZnN2/zC44yHuuWiGMMisEjokdCXWg6jqkJCVWA8yq6QOCVmJ5SAmOiRUJVBCNHRI
qEqsBjHVISEqgRGiqUNCVGIxCIQOCU0JhBALHRKaEu1BoHRISErMhVjqkJCUaA4CqUNCUWIqBEGH
hKJEaxBoHRKCEjMhSDokBCUag2TXcX7Jcx9f1kpMhCDqkKyVlB6E4toxzVKJuhBkHZKlkpKDUOqQ
rJSoCmHQIVkpKTUItQ7JQomaECYdkoWSEoNUoUPSVqIihFGHpK0k9yBV6ZA0lRQXwqxD0lSSc5Aq
dUhaSooKqUGHpKUk1yBV65A0lBQTUpMOSUNJjkF2oUMqraSIkBp1SKWVbB1kVzqkkkqyC6lZh1RS
yZZBTHUsfWae+nl6TKWUZBWyBx1SKSWpg0BcO3wSNHRIJZRkE2Kl4/xyeWhWQknKIBA6UMqtJIuQ
PV07puVWEjtI0+Epp5LNQvasQ8qpJGaQpmOhXEo2CWk63sql5NpBYHWs/QJMzXIoSRaCoMM3gOUo
OZRcMwisDsS2KkkSgqADta1K1gZpOhLaoiRaCJIO6x8uhtqiZGkQCh2WP1xcKlVJlBAkHeilKgkN
EtTRiitWSfQ15M9f556eYx+1v56ex9cqts513tuDf5X58yf/A1r+fv1e/FOwsxfTNwjOFXsfXSxg
/uuZWpf5Bmnfk/SavdZNCFihi7rUridlCr7qa4O0lGvfssD6B5ncvio0WX6KAAAAAElFTkSuQmCC
')

$InfoIcon=[System.IO.Memorystream][convert]::FromBase64String('
AAABAAEAICAAAAEAIACYAwAAFgAAAIlQTkcNChoKAAAADUlIRFIAAAAgAAAAIAgGAAAAc3p69AAA
A19JREFUWIXFl81K5FgUx3+5qVTqAyQlbdF09zR271w0uJhFMxudxgdwO7Mq36DFB5B+AHHeoF0J
s/MBhLEZmIGGATfSu6EQUagIplpTViXm3lnkwxhTesvpj7O6ubnJ75+Tc849F76zGboLG0trDrAM
LACzwGJhyR7QBT4AO4PdDe+LCEjAm8CyrLWcaOopstlG1looYcUviQLE8Azhu5jnR4ih5wE7wOp9
Qu4U0FhaewusX7VeOGH7FcpqxDdUfpW6ea3ACC+w3AMq/a4HvBvsbvw2kYD0q1W12QmevSZqtK+p
98DzE6bvUj35iBH6W4zxxi0BCfwPWWvNj16+QYnqg+Dp0IgC7MM9xMjbB34uihBFAcCmDtz0e1ju
AZZ7gOn3SuGgUMJi9HwRaTvzxLF0w24IaCytvVXVZkfny4XvEmx3CLY7iEGvFJ49LixGPyygrGYn
iavbAhLXrwfPXuu7vWgl8Pgy9kTw+EeA9YQFQCW3bPOq9cLRDTjZmKH66/tk3L4TnlpUn+Fqatap
fO5uAiuQeCAtMmH7ld6XF72gAU9vh9NzAMupF9JfsCxrLUc3z0EhBj2C7RWC7ZUkBu6HAyirgbSd
tKpmAhaiqafa8FLTgKeDqPkE4pKeCZiVzfZk8HHBeA8cBbL+COL9JBOwKGutbwIHkLYDyWaWpWG6
sXxtOIAyrpOvUAl14UWYPry4NhNgRIE+XLcYjYEbMrwlYE8Mz74JHECM+hA3MJmArvDdyeAPdbsC
celC3D1lAj6Y50cPhxcfuAMOYPrHELdumYAdMfQ8I7z46nDjykcE/bRliwUkTcKO5R48EF4UXQ4H
hXX2CXJNaz4NVyv9rmemsTAJXOnBzeEplfNDD1hNZzMBiaJ31ZOPJSk5LuDKxJTDDRlS7f0DcZOa
tWVlPeF7aTud0fPFuDqOgZuXPcTgFIhre1SfuRNuH/+JCPpbg92NlfzrynrCVTHy9u3DvdgTJXBQ
RPUZwuk5wuk5Xfg+OdenZhYnwn//Hlovf/rdiIaPK+dH86rmoKzmRHmeDszhKfbJX4jwYgv4Rast
z1t2MJmadcLpufKDyZhUs84+pQE3+cGkIOL6aGY7TtR8gqw/QtpOtqsZMkSM+ohLF9M/zuf5/zua
lQj54ofT727/AUJ8LCsw6Fc4AAAAAElFTkSuQmCC
')

$WarnungIcon=[System.Drawing.Icon]::New($Warnung)
$WarnungImage=[System.Drawing.Image]::FromStream($Warnung)

########################################################################################################################################
###################################################    ENDE - Images    ################################################################
########################################################################################################################################

# --------------------------------------------------------------------------------------------------------------------------------------

########################################################################################################################################
##################################################    Stempelauswahl    ################################################################
########################################################################################################################################
Function StempelLaden {
	Param([string]$Stempeldatei)
	$Global:Optionen=@{Pfad=(gp -LiteralPath $Stempeldatei).Directory.FullName}
	if ($Global:Stempel) {rv -s global Stempel}
	[array]$Stempeldatei=cat -Encoding Default -LiteralPath $Stempeldatei
	$Global:RMIN=($Stempeldatei | sls 'RMIN').Line|% {
		New-Object PSObject -Property @{
			X=[decimal]$_.SubString(4,12)
			Y=[decimal]$_.Substring(16)
			}}
	
	# Schichten der Stempeldatei ermitteln
		[array]$Global:Schichten=$Stempeldatei|sls -Encoding Default '^INFO(.{7})(0|8)' | % {
			New-Object psobject -Property @{
				Name=$_.Line.Substring(13)
				Anfang=$_.LineNumber
				Ende=($Stempeldatei|sls -Encoding Default ('^'+$_.line.substring(0,11)+'9')).LineNumber
				}}
	
	# Wenn Stempeldatei mehr als eine Schicht enthält
		if ($Schichten.Count -gt 1) {
		
		### Warnung Anfang ###
		# Öffne Warnfenster, um zu ermitteln, wie weiter verfahren werden soll
			$Auswahl=WarnungMultilayer -s $Schichten
			# Falls eine Schicht gewählt wurde
				if ($Auswahl -is [int]) {
					$Global:StempelSchichtName=$Stempeldatei[($Schichten[$Auswahl].Anfang-1)].SubString(13)
					$Stempel=$Stempeldatei[$Schichten[$Auswahl].Anfang..($Schichten[$Auswahl].Ende-2)]
					}
			# Falls alle Schichten zusammen gefasst werden sollen
				elseif ($Auswahl -is [string]) {
					$Global:StempelSchichtName=$Auswahl
					$Stempel=$Schichten | % {$Stempeldatei | select -skip $_.Anfang | select -skiplast ($Stempeldatei.count-$_.Ende+1)}
					}
			# Falls Abgebrochen wurde
				else {
					$TextBoxStempel.Text=''
					$ButtonsMain[0].Enabled=$False
					Output -t 'abgebrochen.' -f 'red'
					Output -n -t 'Bereit.'
					$Global:Fenster.UseWaitCursor=$False
					Return 1
					}}
		### /Warnung Ende ###
				
	# Sonst (Stempel enthält nur eine Schicht)
		else {
			$Global:StempelSchichtName=$Stempeldatei[($Schichten.Anfang-1)].SubString(13)
			$Stempel=$Stempeldatei[($Schichten.Anfang)..($Schichten.Ende-2)]
					}
	
	### Texte umwandeln
		$Global:Stempel=$Stempel | % {
			if ($_ -match '^RTFT') {
				$RTF+=$_.SubString(4)
				}
			elseif ($_ -match 'RTFE') {
				'RTFT'+$RTF
				$RTF=''
				$_
				}
			elseif ($_ -match '^TEXA') {
				$Text=$_
				}
			elseif ($_ -match '^TEXT') {
				$Text+$_
				$Text=''
				}
			else {$_}
			}
	
	### Stifte erfassen
		$Global:Stifte=$Stempeldatei |? {$_ -match '^TODE'}
		
	if ($TabelleProjekt.Rows) {$ButtonsMain[0].Enabled=$True}
	Output -t 'erfolgreich geladen.' -f 'Green'
	Output -n -t 'Bereit.'
	
	} # ENDE Function StempelLaden

### ANFANG GUI - Stempelgruppe

	$StempelGruppe=Gruppe -t 'Stempelauswahl' -d 'Fill' -ad
	
	$ButtonStempelÖffnen=Button -b 30 -h 30 -i $Öffnen
	$ButtonStempelÖffnen.Add_Click({
		$Fenster.UseWaitCursor=$True
		$OutBox.Select($OutBox.Text.Indexof('Bereit'),7);$OutBox.SelectedText=''
		Output -t 'Öffne Stempel '
		$Auswahl=DateiÖffnen -t 'Stempel-Datei öffnen' -f "Vestra Plt-Datei|*.plt" @Global:Optionen
		if ($Auswahl) {
			Output -t "'$Auswahl'" -f 'blue'
			Output -t '... '
			$TextBoxStempel.Text=$Auswahl
			StempelLaden $Auswahl
			}
		else {
			if ($Global:Stempel) {rv -s Global Stempel}
			$ButtonsMain[0].Enabled=$False
			$TextBoxStempel.Text=''
			Output -t '... '
			Output -t 'abgebrochen.' -f 'Red'
			Output -n -t 'Bereit.'
			}
		$Fenster.UseWaitCursor=$False
		})
	
	$CheckBoxStempel=Checkbox -x 20 -t 'vorhandenen Stempel überschreiben' -as -c

	$TabelleStempel=Tabelle -d 'Top' -h 245
	$TabelleStempel.ColumnCount=2
	$TabelleStempel.Columns[0].HeaderText='Platzhalter'
	$TabelleStempel.Columns[0].width=150
	$TabelleStempel.Columns[1].HeaderText='Ersetzen mit'
	$TabelleStempel.Columns[1].DefaultCellStyle.BackColor='#efefef'
	$TabelleStempel.Columns[1].ReadOnly=$True
	$TabelleStempel.Columns[1].AutoSizeMode='Fill'
	$TabelleStempel.RowCount=11
	'Unterlagennummer','Blattnummer','Dateiname','Planname','Planbreite','Planhöhe','Maßstab','Bau-Km','Datum','Änderungsindex','Sonstiges'| % {$i=0} {
		$TabelleStempel.Rows[$i].Cells[1].Value=$_
		$i++
		}
	$TabelleStempel.Rows[0].Cells[0].Value='#U'
	$TabelleStempel.Rows[1].Cells[0].Value='#B'
	$TabelleStempel.Rows[2].Cells[0].Value='#Dateiname'
	$TabelleStempel.Rows[3].Cells[0].Value='#Planname'
	$TabelleStempel.Rows[4].Cells[0].Value='#Breite'
	$TabelleStempel.Rows[5].Cells[0].Value='#Höhe'
	$TabelleStempel.Rows[6].Cells[0].Value='#Maßstab'
	$TabelleStempel.Rows[7].Cells[0].Value='#Km'
	$TabelleStempel.Rows[8].Cells[0].Value='#Datum'
	$TabelleStempel.Rows[9].Cells[0].Value='#Index'
	$TabelleStempel.Rows[10].Cells[0].Value='#Sonstiges'
		
	$StempelPanels=@(
		Panel -d 'Fill' -ind 2				 					# Panel[0] Tabelle
		Panel -d 'Top' -h 30 -p '0,0,0,0' -ind 1 			# Panel[1] Checkbox
		Panel -d 'Top' -h 60 -p '15,15,15,15' -ind 0		# Panel[2] Textbox + Button
		Panel -d 'Left' -b 45									# Panel[3] Button
		)
	
	$TextboxStempel=Textbox -d 'Bottom' -g
	
	$StempelGruppe.Controls.AddRange($StempelPanels)
	$StempelPanels[0].Controls.Add($TabelleStempel)
	$StempelPanels[1].Controls.Add($CheckBoxStempel)
	$StempelPanels[2].Controls.AddRange(@($TextboxStempel,$StempelPanels[3]))
	$StempelPanels[3].Controls.Add($ButtonStempelöffnen)
	
	$TexteStempel=@(
		Label -as -t 'Stempel Ecke - links, unten:' -y 300	-s (Schrift -f -u -g 12)
		label -as -t 'X = Planbreite - 18.50cm' -y 330
		Label -as -t 'Y = 1.00cm' -y 355
		Label -as -t 'Verschiebung:' -y 400 -s (Schrift -f -u -g 12)
		Label -as -t 'X' -y 435
		Label -as -t 'Y' -x 120 -y 435
		)
		
	$EingabeStempel=@(
		Textbox -t '0.00' -x 40 -b 60 -y 435 -ta 'Center'
		Textbox -t '0.00' -x 145 -b 60 -y 435 -ta 'Center'
		)
	$EingabeStempel.Add_Enter({$Global:TextVorher=$Args[0].Text})
	$EingabeStempel.Add_Leave({
		if ([decimal]::TryParse($Args[0].Text,[ref]$NULL)) {
			$Args[0].Text=([decimal]($Args[0].Text -replace ',','.')).ToString('0.00') -Replace ',','.'
			rv -s global TextVorher
		} else { 
			$Args[0].Text=$Global:TextVorher;rv -s global TextVorher
		}
	})
	
	$StempelPanels[0].Controls.AddRange($TexteStempel)
	$StempelPanels[0].Controls.AddRange($EingabeStempel)
	
	$StempelGruppe.Add_DragOver([System.Windows.Forms.DragEventHandler]{
		If ((gp -LiteralPath $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)).Extension -match 'plt') {$_.Effect='Copy'} else {$_.Effect='None'}
	})
	
	$StempelGruppe.Add_DragDrop([System.Windows.Forms.DragEventHandler]{
		$OutBox.Select($OutBox.Text.Indexof('Bereit'),7);$OutBox.SelectedText=''
		Output -t 'Öffne Stempel '
		$Auswahl=$_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)
		$TextboxStempel.Text=$Auswahl
		Output -t "'$Auswahl'" -f 'blue'
		Output -t '... '
		StempelLaden $TextboxStempel.Text
	})
	
########################################################################################################################################
############################################    ENDE - Stempelverarbeitung    ##########################################################
########################################################################################################################################
# --------------------------------------------------------------------------------------------------------------------------------------
########################################################################################################################################
##################################################    Projektauswahl    ################################################################
########################################################################################################################################

Function ProjektLaden {
	Param(
		[Alias('p')][string]$Pfad
		)
	
	$Global:Fenster.UseWaitCursor=$True
	$Global:Optionen=@{Pfad=$Pfad}
	$Option=@{Recurse=$CheckboxProjekt.Checked}
	$RTFBox=RTFBox -multi
	if ($Global:PltSchichten) {rv PltSchichten -scope global}
	
	$MultiStempel=ls @Option -LiteralPath "$Pfad" -filter '*.plt' | ? {(sls '^INFO.*Stempel.*' -Literalpath $_.FullName).count -gt 2}|%{'"'+$_.Name+'"'}
	if ($Multistempel) {
		$Info=Fenster -t 'Pläne mit mehreren Stempelschichten' -a -i ([system.drawing.icon]::new($InfoIcon)) -s 'CenterScreen' -p '30,30,30,30'
		$iY=38
		$Panel=Panel -b 40 -h 40 -x 30 -y 30
		$Panel.BackGroundImage=[system.drawing.image]::FromStream($InfoIcon)
		$Panel.BackgroundimageLayout='zoom'
		$INFOLabel=Label -t 'Pläne mit mehreren Stempelschichten' -as -x 85 -y $($iY;$iY+=50) -s (Schrift -g 13 -f)
		$InfoText=RTFBox -b 400 -multi -x 0 -y $iY -sb 'both' -a 'Top'
		$InfoText.Cursor=[System.Windows.Forms.Cursors]::Arrow
		$InfoText.TabStop=$False
		$InfoText.Text+=$MultiStempel -join [char]10
		$InfoText.ReadOnly=$True
		$InfoText.BorderStyle='none'
		$InfoText.MaximumSize='1000,700'
		$InfoText.Size=$InfoText.PreferredSize
		$InfoTextX=30+$InfoText.Width/2
		$InfoOK=Button -t 'Ok' -a 'TOP' -y ($iY+$InfoText.Height)
		$InfoOK.Add_Click({$Info.Dispose()})
	
		$Info.Controls.AddRange(@($Panel,$InfoText,$InfoLabel,$InfoOk))
		[int]$InfoMitte=$info.width/2
		$InfoOk.Location="$($InfoMitte-50),$($InfoOk.Location.y)"
		if (($InfoMitte-$InfoText.Width/2) -lt 30) {$InfoText.Location="30,$($InfoText.Location.Y)"} else {$InfoText.Location="$(15+$InfoMitte-[int]($InfoText.Width/2)),$($InfoText.Location.Y)"}
		[void]$Info.ShowDialog()
		}

	# Tabelle erstellen
		$TabelleProjekt.Rows.Clear()
		[void]$TabelleProjekt.Columns.Add((New-Object System.Windows.Forms.DataGridViewCheckBoxColumn))
		$TabelleProjekt.ColumnCount=13
		$TabelleProjekt.Columns[1].Visible=$False
		$TabelleProjekt.Columns[2]|%{$_.Readonly=$True;$_.DefaultCellStyle.BackColor='#efefef'}
		$TabelleProjekt.Columns[5].DefaultCellStyle.Wrapmode='true'
		$TabelleProjekt.Columns[5].Width=500
		$TabelleProjekt.Columns[6,7] |%{$_.DefaultCellStyle.Alignment='MiddleRight'}
		$TabelleProjekt.Columns[8..10] |%{$_.DefaultCellStyle.Alignment='MiddleCenter'}
		'Dateipfad','Dateiname','Unterlage','Blatt','Planname','Planbreite','Planhöhe','Maßstab','Bau-Km','Datum','Änderungsindex','Sonstiges' | % {$i=1} {
			$TabelleProjekt.Columns[$i].HeaderText=$_
			$i++
			}
		$TabelleProjekt.Columns[9].DefaultCellStyle.Wrapmode='true'
		$TabelleProjekt.Columns[9].Width=500
		$TabelleProjekt.Columns[12].DefaultCellStyle.Wrapmode='true'
		$TabelleProjekt.Columns[12].Width=2000
	
		# ComboBox erstellen
			$Global:ComboInd=$TabelleProjekt.Columns.Add((New-Object System.Windows.Forms.DatagridviewComboboxColumn -Property @{HeaderText='vorh. Stempel';Displayindex=9}))

		# Tabelle mit Daten füllen
			ls @Option -LiteralPath "$Pfad" -filter '*.plt' | ? {$_.Name -notmatch 'Stempel'} | % {
				$i=$TabelleProjekt.Rows.Add(
					$True,																																				# S[0]  - Checkbox
					$_.FullName,																																		# S[1]  - DateiPfad
					$_.Name,																																				# S[2]  - Dateiname
					($_.Name.Split('_')|?{$_ -match '^U(\d{1})|^A(\d{1})'}|%{$_.SubString(1) -Replace '^0'}),									# S[3]  - Unterlagennummer
					($_.Name.split('_')|?{$_ -match '^B(\d{1})'}|Select -First 1|%{$_.SubString(1).Split(' ')[0] -Replace '^0'}),		# S[4]  - Blattnummer
					'',																																					# S[5]  - Planname
					(([decimal](sls 'RMAX' -LiteralPath $_).Line.SubString(4,11)).ToString('0.00') -Replace ',','.'),						# S[6]  - Planbreite
					(([decimal](sls 'RMAX' -LiteralPath $_).Line.SubString(16,11)).ToString('0.00') -Replace ',','.'),						# S[7]  - Planhöhe
					('1:'+[int](sls 'scal' -LiteralPath $_).Line.Substring(4,11)),																		# S[8]  - Maßstab
					'',																																					# S[9]  - Bau-Km
					(get-date).ToString('dd.MM.yyyy'),																											# S[10] - Datum
					"$((($_.BaseName | ? {$_ -match '(?<!\d{4}-\d{2})(-|_)([a-z]|\d{1,2})$'}) -Split '_' -Split '-' )[-1])",				# S[11] - Änderungsindex
					''																																						# S[12] - Sonstiges
					)
				
				$Global:PltSchichten+=@(New-Object System.Data.DataTable)
				$PltSchichten[$i].Columns.AddRange(@(
					(New-Object System.Data.DataColumn 'Name',([string])),
					(New-Object System.Data.DataColumn 'Zeile',([string])),
					(New-Object System.Data.DataColumn 'Nummer',([int])))
					)
				
				$PltSchichten[$i].Rows.Add()
				$PltSchichten[$i].Rows[0].Name='--- Keiner ---'
				$PltSchichten[$i].Rows[0].Zeile='-'
				sls -Pattern '^INFO(.{7})[^9]' -LiteralPath $_.Fullname -Encoding Default | sort -Property Linenumber -Descending | % {$c=1} {
					$PltSchichten[$i].Rows.Add()
					$PltSchichten[$i].Rows[$c].Name=$_.Line.Substring(13)
					$PltSchichten[$i].Rows[$c].Zeile=$_.Line
					$PltSchichten[$i].Rows[$c].Nummer=$_.LineNumber-1
					$c++
					}
				$TabelleProjekt.Rows[$i].Cells[$ComboInd].DataSource=$PltSchichten[$i]
				$TabelleProjekt.Rows[$i].Cells[$ComboInd].DisplayMember='Name'
				$TabelleProjekt.Rows[$i].Cells[$ComboInd].ValueMember='Zeile'
				
				if ($PltSchichten[$i].Rows.Name -match 'Stempel') {
					Foreach ($Schicht in ($PltSchichten[$i].Rows | ? {$_.Name -match 'Stempel'} | Select -First 1)) {
						$TabelleProjekt.Rows[$i].Cells[$ComboInd].Value=$Schicht.Zeile
						$Anfang=$Schicht.Nummer
						$Ende=(sls -Pattern ($Schicht.Zeile -Replace '^(.{11})(\d{1})','${1}9') -LiteralPath $_.Fullname -Encoding Default).LineNumber-1
						
						# Planname und Bau-Km auslesen
						Foreach ($RTF in ((sls -Pattern '^RTF(T|E)','^TEXT' -LiteralPath $_.Fullname -Encoding Default) | ? {$_.LineNumber -ge $Anfang -and $_.Linenumber -le $Ende})) {
							if ($RTF.Line -match '^RTFT') {
								$RTFText+=$RTF.Line.Substring(4)
								}
							elseif ($RTF.Line -match 'RTFE') {
								$RTFBox.RTF=$RTFText
								[array]$Global:Texte+=$RTFBox.Text
								$RTFText=''
								}
							else {[array]$Global:Texte+=$RTF.SubString(4)}
					}}}
				else {$TabelleProjekt.Rows[$i].Cells[$ComboInd].Value='-'}
				
				$TabelleProjekt.Rows[$i].Cells[5].Value=$Texte | ? {$_ -match 'Lageplan\b|Höhenplan\b|(?<!Aus|Ab)schnitt(\b|e)\b|profil(|e)\b|detail(|plan)\b|deckenhöhenplan\b|dhp\b|übersichts((|lage)plan|karte)\b|profil\b|LP\b|HP\b|DP\b'} |select -First 1
				if ($Texte -match '\b1(:| :)') {$TabelleProjekt.Rows[$i].Cells[8].Value=($Texte -match '\b1(:| :)'| select -first 1) -replace '(.*)(1(:| : ){1})','$2'}
				$TabelleProjekt.Rows[$i].Cells[9].Value=$Texte | ? {$_ -match '(km(\b|:)\ |^)(\d{1,2})(\+|-)(\d{3})(\b|\.(\d{2,3})(\b|-))'} |select -First 1
				$TabelleProjekt.Rows[$i].Cells[12].Value=$Texte | ? {$_ -match 'Conject:'} | select -First 1
				if ($Global:Texte) {rv Texte -scope Global}
				
				} # ENDE Tabelle mit Daten füllen
			$TabelleProjekt.AutoResizeColumns(6)
			
		Output -t 'erfolgreich geladen.' -f 'green'
		if ($Stempel) {$Global:ButtonsMain[0].Enabled=$True}
	
	Output -n -t 'Bereit.'
	$Global:Fenster.UseWaitCursor=$False
	
	} # ENDE Function ProjektLaden

# Gruppe Projektauswahl
	$ProjektGruppe=Gruppe -t Projektauswahl -d 'fill' -ad
	
	$ProjektPanels=@(
		Panel -d 'Fill' -ind 5										# Panel[0] Tabelle
		Panel -d 'Top' -h 30 -p '0,0,0,0' -ind 4				# Panel[1] Checkbox
		Panel -d 'Top' -h 60 -p '15,15,15,15' -ind 3			# Panel[2] Button + Textbox
		Panel -d 'Left' -b 45										# Panel[3] Button
		)
	$ButtonProjektÖffnen=Button -b 30 -h 30 -i $Öffnen
	$ButtonProjektÖffnen.Add_Click({
		$Fenster.UseWaitCursor=$True
		$Fenster.Update()
		$OutBox.Select($OutBox.Text.Indexof('Bereit'),7);$OutBox.SelectedText=''
		Output -t 'Öffne Projektordner '
		$Auswahl=OrdnerÖffnen @Optionen
		if ($Auswahl) {
			$TextBoxProjekt.Text=$Auswahl
				Output -t "'$Auswahl'" -f 'blue'
				Output -t "... "
			ProjektLaden -p $Auswahl
		} else {
			Output -c -t 'abgebrochen.' -f 'Red'
			Output -n -t 'Bereit.'
			}
		$Fenster.UseWaitCursor=$False
	})
	
	$CheckboxProjekt=Checkbox -x 20 -t 'Unterordner einbeziehen' -as -c

	$TextBoxProjekt=Textbox -d 'Bottom' -g
	$TabelleProjekt=Tabelle -d 'fill'
		
	
	$ProjektGruppe.Controls.AddRange($ProjektPanels)
	$ProjektPanels[0].Controls.Add($TabelleProjekt)
	$ProjektPanels[1].Controls.Add($CheckboxProjekt)
	$ProjektPanels[2].Controls.AddRange(@($TextBoxProjekt,$ProjektPanels[3]))
	$ProjektPanels[3].Controls.Add($ButtonProjektÖffnen)

	$ProjektGruppe.Add_DragOver([System.Windows.Forms.DragEventHandler]{
		If ((gp -LiteralPath $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)) -is [System.IO.DirectoryInfo]) {$_.Effect='Copy'} else {$_.Effect='None'}
	})
	
	$ProjektGruppe.Add_DragDrop([System.Windows.Forms.DragEventHandler]{,
		$OutBox.Select($OutBox.Text.Indexof('Bereit'),7);$OutBox.SelectedText=''
		Output -t 'Öffne Projektordner '
		$Auswahl=$_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)
		$TextboxProjekt.Text=$Auswahl
		Output -t "'$Auswahl'" -f 'blue'
		Output -t "... "
		ProjektLaden -p $TextBoxProjekt.Text
	})

	$TabelleProjekt.Add_CellEnter({
		if ($TabelleProjekt.CurrentCell.ColumnIndex -match '6|7') {$Global:Selected=$TabelleProjekt.CurrentCell.Value}
	})
	
	$TabelleProjekt.Add_CellValueChanged({
		if ($TabelleProjekt.CurrentCell.ColumnIndex -match '6|7') {
			if (! [decimal]::TryParse($TabelleProjekt.CurrentCell.EditedformattedValue,[ref]$NULL)) {
				$TabelleProjekt.CurrentCell.Value=$Global:Selected
				}
			else {$TabelleProjekt.SelectedCells | ? {$_.ColumnIndex -eq $TabelleProjekt.CurrentCell.ColumnIndex} | % {
				$_.Value=$TabelleProjekt.CurrentCell.Value -Replace ',','.'}}}
		else {
			$TabelleProjekt.SelectedCells|? {$_.ColumnIndex -ne $ComboInd -and $_.Columnindex -eq $TabelleProjekt.CurrentCell.Columnindex} |% {
				$_.Value=$TabelleProjekt.CurrentCell.EditedFormattedValue
				}}
	})
	
	$TabelleProjekt.Add_CurrentCellDirtyStateChanged({
		if ($TabelleProjekt.CurrentCell.ColumnIndex -eq 0) {
			$TabelleProjekt.SelectedCells | ? {$_.ColumnIndex -eq $TabelleProjekt.CurrentCell.ColumnIndex} | % {
				$_.Value=$TabelleProjekt.CurrentCell.EditedFormattedValue
				}}
		})

########################################################################################################################################
###############################################    ENDE - Projektauswahl    ############################################################
########################################################################################################################################

# --------------------------------------------------------------------------------------------------------------------------------------

########################################################################################################################################
#####################################################    Warunung    ###################################################################
########################################################################################################################################

Function WarnungMultiLayer {
	Param(
		[Alias('s')][object]$Schichten
		)

	$Warnung=Fenster -t 'Warnung!' -s 'CenterScreen' -p '30,30,30,30' -b 580 -h 500 -i $WarnungIcon
	$WarnungTexte=@(
		Label -t 'Die Stempeldatei enthält mehrere Schichten.' -as -x 85  -y 45 -s (Schrift -g 14 -f)
		Label -t 'Wie soll verfahren werden?' -as -y 130 -x 40 -s (Schrift -f -g 12)
		Label -t 'Schichtname: ' -as -x 70 -y 310 -s (Schrift -g 12) 
		)
		
	$WarnungImage=Panel -b 40 -h 40 -x 40 -y 40 -i $WarnungImage
	
	$WarnungRadios=@(
		RadioButton -t 'Schicht manuell auswählen' -x 50 -y 180 -s (Schrift -g 12) -c
		RadioButton -t 'Alle Schichten zusammenführen' -x 50 -y 270 -s (Schrift -g 12)
		)
	$WarnungRadios.Add_CheckedChanged({
		if ($WarnungRadios.Checked.indexOf($True) -eq 1 -and ! $WarnungEingabe.Text) {$WarnungButtons[0].Enabled=$False}
		else {$WarnungButtons[0].Enabled=$True}
		})
	
	$WarnungButtons=@(
		Button -t 'Weiter' -a 'Bottom' -x 175 -y 390 -b 100 -h 50 -s (Schrift -f)
		Button -t 'Abbrechen' -a 'Bottom' -x 305 -y 390 -b 100 -h 50 -s (Schrift -f)
		)
	$WarnungButtons[0].Add_Click({
		if ($WarnungRadios.Checked.indexOf($True) -eq 0) {$Global:Value=$WarnungCombo.SelectedIndex} else {$Global:Value=$WarnungEingabe.Text}
		[void]$Warnung.Dispose()
		})
	$WarnungButtons[1].Add_Click({
		[void]$Warnung.Dispose()
		})
		
	$WarnungCombo=Combobox -x 70 -y 220 -i $Schichten.Name
	if ($WarnungCombo.Items -match 'Stempel') {$WarnungCombo.SelectedItem=$WarnungCombo.Items -match 'Stempel'| select -First 1} else {$WarnungCombo.SelectedIndex=0}
	
	$WarnungEingabe=TextBox -x 180 -y 310 -b 290
	$WarnungEingabe.Add_TextChanged({
		$WarnungRadios[1].Checked=$True
		if ($WarnungEingabe.Text) {$WarnungButtons[0].Enabled=$True} else {$WarnungButtons[0].Enabled=$False}
		})
	
	$Warnung.Controls.AddRange($WarnungTexte)
	$Warnung.Controls.AddRange($WarnungRadios)
	$Warnung.Controls.AddRange($WarnungButtons)
	$Warnung.Controls.Add($WarnungCombo)
	$Warnung.Controls.Add($WarnungImage)
	$Warnung.Controls.Add($WarnungEingabe)
	
	[void]$Warnung.ShowDialog()
	$Value=$Global:Value
	# Remove-Variable -Scope Global Value
	Return $Value
}

########################################################################################################################################
##################################################    ENDE - Warnung    ################################################################
########################################################################################################################################

# --------------------------------------------------------------------------------------------------------------------------------------

########################################################################################################################################
######################################################   Umsetzen   ####################################################################
########################################################################################################################################

Function Umsetzen {
	$RTFb=RTFBox -multi
	Foreach ($Row in ($TabelleProjekt.Rows | ? {$_.Cells[0].Value})) {
		Statustext -t "'$($Row.Cells[2].EditedFormattedValue)'" -f 'blue'
		Statustext -t "... "
			
		$Global:Ersetze=@(
			New-Object PSObject -Property @{Platzhalter=$TabelleStempel.Rows[0].Cells[0].EditedFormattedValue;Wert=$Row.Cells[3].EditedFormattedValue}	# Unterlage
			New-Object PSObject -Property @{Platzhalter=$TabelleStempel.Rows[1].Cells[0].EditedFormattedValue;Wert=$Row.Cells[4].EditedFormattedValue}	# Blatt
			New-Object PSObject -Property @{Platzhalter=$TabelleStempel.Rows[2].Cells[0].EditedFormattedValue;Wert=$Row.Cells[2].EditedFormattedValue}	# Dateiname
			New-Object PSObject -Property @{Platzhalter=$TabelleStempel.Rows[3].Cells[0].EditedFormattedValue;Wert=$Row.Cells[5].EditedFormattedValue}	# Planname
			New-Object PSObject -Property @{Platzhalter=$TabelleStempel.Rows[4].Cells[0].EditedFormattedValue;Wert=$Row.Cells[6].EditedFormattedValue}	# Breite
			New-Object PSObject -Property @{Platzhalter=$TabelleStempel.Rows[5].Cells[0].EditedFormattedValue;Wert=$Row.Cells[7].EditedFormattedValue}	# Höhe
			New-Object PSObject -Property @{Platzhalter=$TabelleStempel.Rows[6].Cells[0].EditedFormattedValue;Wert=$Row.Cells[8].EditedFormattedValue}	# Maßstab
			New-Object PSObject -Property @{Platzhalter=$TabelleStempel.Rows[7].Cells[0].EditedFormattedValue;Wert=$Row.Cells[9].EditedFormattedValue}	# Bau-KM
			New-Object PSObject -Property @{Platzhalter=$TabelleStempel.Rows[8].Cells[0].EditedFormattedValue;Wert=$Row.Cells[10].EditedFormattedValue}	# Datum
			New-Object PSObject -Property @{Platzhalter=$TabelleStempel.Rows[9].Cells[0].EditedFormattedValue;Wert=$Row.Cells[11].EditedFormattedValue}	# Index
			New-Object PSObject -Property @{Platzhalter=$TabelleStempel.Rows[10].Cells[0].EditedFormattedValue;Wert=$Row.Cells[12].EditedFormattedValue}	# Sonstiges
			)

		# Lade Datei
			$File=cat -Encoding Default -LiteralPath $Row.Cells[1].Value
			$Diff=New-Object PSObject -Property @{
				X=$Row.Cells[6].EditedFormattedValue-18.5-$RMIN.X+$EingabeStempel[0].Text
				Y=1.0-$RMIN.Y+$EingabeStempel[1].Text
				}
			$StifteNeu=$File|? {$_ -match '^TODE'}
			$StifteNeu+=$Global:Stifte |? {$StifteNeu.Substring(4,5) -NotContains $_.Substring(4,5)}
			$StifteNeu=$StifteNeu | sort
		
		# Falls Stempel nicht ersetzt werden soll
			if (! $CheckBoxStempel.Checked -or $Row.Cells[$ComboInd].Value -eq '-' ) {
				$File|sls '^INFO(.{7})9'| select -Last 1 | %{
					$Schichtname='INFO'+("{0:d7}" -f ([int]$_.Line.Substring(4,7)+1))+"0 $Global:StempelSchichtName"
					$Anfang=$_.LineNumber-1
					$Ende=$_.LineNumber
					}
				}
			else {
				$Schichtname=$Row.Cells[$ComboInd].Value
				$Anfang=($File| sls $Row.Cells[$ComboInd].Value).LineNumber-1
				$Ende=($File|sls ($Row.Cells[$ComboInd].Value -Replace '^INFO(.{7})(\d{1})','INFO${1}9')).LineNumber
				}
		# Neuen Stempel Generieren
			[Array]$NeuerStempel=$Schichtname
			$NeuerStempel+=Foreach ($Zeile in $Stempel) {
				if ($Zeile -match '^MOVE|^DRAW|^RTFA|^RASA|^RASE') {
					$X="{0,12}" -f ([decimal]$Zeile.Substring(4,12)+$Diff.X).ToString('0.000').Replace(',','.')
					$Y="{0,12}" -f ([decimal]$Zeile.Substring(16,12)+$Diff.Y).ToString('0.000').Replace(',','.')
					$Zeile.SubString(0,4)+$X+$Y+$Zeile.SubString(28)
					}
				elseif ($Zeile -match '^RTFT') {
					$RTFb.Rtf=$Zeile.SubString(4)
					$Ersetze | ? {$Rtfb.Text -match "$($_.Platzhalter)\b"} | % {
						$RTFb.Select($RTFb.Text.IndexOf($_.Platzhalter),$_.Platzhalter.Length)
						$RTFb.SelectedText=$_.Wert
						}
					$RTFneu=$RTFb.Rtf.replace("$([char]13+[char]10)",' ').replace('} ','}')
					$RTFOut=@()
					do {$RTFOut+='RTFT'+$RTFneu.Substring(0,66);$RTFneu=$RTFneu.Substring(66)}
					while ($RTFneu.Length -gt 66)
					if ($RTFneu) {$RTFOut+='RTFT'+$RTFneu}
					$RTFOut
					}
				elseif ($Zeile -match '^TEXA') {
					$Ersetze | ? {$Zeile -match "$($_.Platzhalter)\b"} | % {
						$Zeile=$Zeile -Replace ($_.Platzhalter,$_.Wert)
						}
					$X="{0,12}" -f ([decimal]$Zeile.Substring(4,12)+$Diff.X).ToString('0.000').Replace(',','.')
					$Y="{0,12}" -f ([decimal]$Zeile.Substring(16,12)+$Diff.Y).ToString('0.000').Replace(',','.')
					$Zeile.SubString(0,4)+$X+$Y+$Zeile.SubString(28,10)+("{0,2}" -f $Zeile.SubString(46).Length)+$Zeile.SubString(40,2)
					$Zeile.SubString(42)
					}
				else {
					$Zeile
					}
				}
			$NeuerStempel+=$Schichtname -Replace 'INFO(.{7})(\d{1})','INFO${1}9'
			# Datei Schreiben
				$Datei=$File[0..9],$StifteNeu
				# Ebenenindex nach Stiften finden	
					$NS=($File|sls '^TODE'|select -last 1).Linenumber
				$Datei+=$File[$NS..($Anfang-1)],$NeuerStempel
				$Datei+=$File | select -skip $Ende
				$Datei | Out-File -Encoding Default -LiteralPath $Row.Cells[1].Value
			
		Statustext -t 'fertig' -f 'green'
		Statustext -n
		$Counter+=$Barwert
		$Statusbar.Value=$Counter

		} # ENDE Foreach $Row

	} # ENDE Function Umsetzen

Function status {
	$Global:StatusFenster=Fenster -t 'Status' -s 'CenterScreen' -b 800 -h 180
	$StatusFenster.FormBorderStyle='none'
	$Global:StatusRTF=RTFBox -multi -g -d 'Top' -h 110
	$Global:StatusBar=New-Object System.Windows.Forms.Progressbar -Property @{dock='Bottom'}
	$StatusFenster.Controls.AddRange(@($StatusBar,$StatusRTF))
	}
	
Function Statustext {
	Param(
		[Alias('t')][string]$Text,
		[Alias('f')][string]$Farbe='#606060',
		[Alias('n')][switch]$NewLine
		)
	$StatusRTF.SelectionColor=$Farbe
	if ($NewLine) {
		$StatusRTF.AppendText("`n$Text")
		$StatusRTF.ScrollToCaret()
		}
	else {$StatusRTF.AppendText("$Text")}
	$StatusRTF.Refresh()
	}

########################################################################################################################################
#################################################    ENDE - Umsetzen    ################################################################
########################################################################################################################################

# --------------------------------------------------------------------------------------------------------------------------------------

########################################################################################################################################
########################################################   Main   ######################################################################
########################################################################################################################################

Function Output{
	Param(
		[Alias('t')][string]$Text,
		[Alias('f')][string]$Farbe='#606060',
		[Alias('n')][switch]$NewLine
		)
	$OutBox.SelectionColor=$Farbe
	if ($NewLine) {
		$OutBox.AppendText("`n$Text")
		$OutBox.ScrollToCaret()
		}
	else {$OutBox.AppendText("$Text")}
	$OutBox.Refresh()
	}

Function Main {
	$Fenster=Fenster -t "Stempelverwaltung - Version $Version" -b 1720 -h 880 -x 100 -y 100 -p '30,30,30,30' -st 'Maximized' -i $Logo
	$Fenster.MinimumSize="800,700"
	$Split=SplitContainer -o 'vertical' -d 'Fill'
	$ControlPanel=Panel -d 'Bottom' -h 220 -p '0,30,0,0'
	$Fenster.Controls.AddRange(@($Split,$ControlPanel))
	$Split.Panel1Minsize=320
	$Split.Panel2Minsize=320
	$Split.SplitterDistance=320
	$Split.Panel1.Controls.Add($StempelGruppe)
	$Split.Panel2.Controls.Add($ProjektGruppe)
		
	# Outputbox
		$Global:OutBox=RTFBox -multi -b 500 -h 100 -d "Top" -m '30,30,30,30' -g -s (Schrift -a 'Lucida Console' -g 13)
		Output -t 'Bereit.'
	
	# Kontrollfeld
		$Global:ButtonsMain=@(
			Button -t 'umsetzen' -b 150 -h 50 -a 'Bottom' -x ($ControlPanel.Width/2-75) -y 170 -s (Schrift -a 'Tahoma' -f) -ind 6
			)
		$ButtonsMain[0].Enabled=$False
		$ButtonsMain[0].Add_Click({
			$Fenster.Hide()
			status
			$Global:BarWert=100/($TabelleProjekt.Rows |?{$_.Cells[0].Value}).Count
			$StatusFenster.Show()
			umsetzen
			Statustext -t '####  FERTIG  ####' -f green
			[void](timeout 2)
			$StatusFenster.Dispose()
			})
		$ControlPanel.Controls.AddRange($ButtonsMain)
		$ControlPanel.Controls.Add($OutBox)

	Return $Fenster
}

$Fenster=Main
if (Test-Path $ENV:APPDATA\Script\Stempelverarbeitung) {
	$Optionen=@{Pfad=([array](cat $ENV:APPDATA\Script\Stempelverarbeitung\Settings.Conf))[0]}
} else {
	mkdir $ENV:APPDATA\Script\Stempelverarbeitung
	$Optionen=@{Pfad=(Get-Volume | ? {Test-Path ($_.DriveLetter+':\Daten')}|select -First 1|%{ls -dir ($_.DriveLetter+':\Daten\*') |select -First 1})}
	$Optionen.Values.FullName| Out-File -Encoding Default $ENV:APPDATA\Script\Stempelverarbeitung\Settings.Conf
}

[void]$Fenster.ShowDialog()
