Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

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
		[Alias('i')][string]$Icon,
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
		Margin=$Margin
		WindowState=$State
		AllowDrop=$AllowDrop
		}
	
	if ($Icon) {$Fenster.Icon=[System.Drawing.Icon]::New((gp $Icon))}
		
	Return $Fenster
}

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
		[Alias('i')][string]$Image
		)
		
	$Panel=New-Object System.Windows.Forms.Panel -Property @{
		Dock=$Dock
		Anchor=$Anker
		Location="$X,$Y"
		Size="$Breite,$Höhe"
		Padding=$Padding
		Margin=$Margin
		AllowDrop=$AllowDrop
		BackgroundImageLayout='zoom'
		}
		
	if ($Image) {$Panel.BackgroundImage=[system.drawing.image]::FromFile((gp $Image))}
	
	Return $Panel
}

Function FlowPanel {
	Param(
		[Alias('b')][int]$Breite=20,
		[Alias('h')][int]$Höhe=20,
		[int]$X=0,
		[int]$Y=0,
		[Alias('p')][string]$Padding='15,15,15,15',
		[Alias('m')][string]$Margin='15,15,15,15',
		[Alias('d')][string]$Dock='None',
		[Alias('a')][string]$Anker='Top,Left'
		)
		
	$Panel=New-Object System.Windows.Forms.FlowLayoutPanel -Property @{
		Dock=$Dock
		Anchor=$Anker
		Location="$X,$Y"
		Size="$Breite,$Höhe"
		Padding=$Padding
		Margin=$Margin
		AutoSize=$True
		}
	
	Return $Panel
}

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
		}

	Return $Split
}

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
	
}

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
}

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
		[Alias('ind')][int]$Index,
		[Alias('s')][object]$Schrift=(Schrift),
		[Alias('i')][string]$Image
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
		BackgroundImageLayout='zoom'
	}
	if ($Image) {$Button.BackgroundImage=[System.Drawing.Image]::FromFile((gp $Image))}
	
	Return $Button
}

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
}

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
		[Alias('i')][int]$Index,
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
	
	Return $TextBox
}

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
}

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
		[Alias('i')][int]$Index,
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
}

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
}

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
}

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
}

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
		[Alias('ad')][switch]$AllowDrop
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
		}
	
	if ($CheckBox) {$Grid.Columns.Add((New-Object System.Windows.Forms.DataGridViewCheckBoxColumn))}
	
	Return $Grid
}

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
}
