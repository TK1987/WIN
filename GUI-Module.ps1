Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Function Fenster {
	Param(
		[Alias('t')][string]$Text,
		[Alias('r')][int]$Randbreite=15
		)
	
	$Fenster=New-Object System.Windows.Forms.Form
	$Fenster.Text=$Text
	$Fenster.Size=New-Object System.Drawing.Size(100,100)
	$Fenster.StartPosition='CenterScreen'
	$Fenster.AutoSize=$True
	$Fenster.Padding=New-Object System.Windows.Forms.Padding($Randbreite)
		
	Return $Fenster
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
		[int]$X=15,
		[int]$Y,
		[Alias('i')][int]$Index,
		[Alias('s')][object]$Schrift=(Schrift)
		)
	
	$Button=New-Object System.Windows.Forms.Button
	$Button.Text=$Text
	$Button.Size=New-Object System.Drawing.Size($Breite,$Höhe)
	$Button.Location=New-Object System.Drawing.Size($X,$Y)
	$Button.TabIndex=$Index
	$Button.Font=$Schrift
	
	Return $Button
	}

Function Label {
	Param(
		[Alias('t')][string]$Text,
		[Alias('b')][int]$Breite=400,
		[Alias('h')][int]$Höhe=25,
		[int]$X=15,
		[int]$Y,
		[Alias('s')][object]$Schrift=(Schrift),
		[Alias('a')][string]$Anker='MiddleLeft'
		)
		
	$Label=New-Object System.Windows.Forms.Label
	$Label.Text=$Text
	$Label.Size=New-Object System.Drawing.Size($Breite,$Höhe)
	$Label.Location=New-Object System.Drawing.Size($X,$Y)
	$Label.TextAlign=$Anker
	$Label.Font=$Schrift
	
	Return $Label
	}

Function TextBox {
	Param(
		[Alias('t')][string]$Text,
		[Alias('b')][int]$Breite=400,
		[Alias('h')][int]$Höhe=25,
		[int]$X=15,
		[int]$Y,
		[Alias('i')][int]$Index,
		[Alias('s')][object]$Schrift=(Schrift),
		[Alias('p')][switch]$Password
		)
	
	$TextBox=New-Object System.Windows.Forms.TextBox
	$TextBox.Text=$Text
	$TextBox.Size=New-Object System.Drawing.Size($Breite,$Höhe)
	$TextBox.Location=New-Object System.Drawing.Size($X,$Y)
	$TextBox.TabIndex=$Index
	$TextBox.Font=$Schrift
	if ($Password){$TextBox.PasswordChar='*'}
	
	Return $TextBox
	}

Function CheckBox {
	Param(
		[Alias('t')][string]$Text,
		[Alias('b')][int]$Breite=400,
		[Alias('h')][int]$Höhe=25,
		[int]$X=15,
		[int]$Y,
		[Alias('i')][int]$Index,
		[Alias('s')][object]$Schrift=(Schrift)
		)
	
	$CheckBox=New-Object System.Windows.Forms.CheckBox
	$CheckBox.Text=$Text
	$CheckBox.Size=New-Object System.Drawing.Size($Breite,$Höhe)
	$CheckBox.Location=New-Object System.Drawing.Size($X,$Y)
	$CheckBox.Font=$Schrift
	$CheckBox.TabIndex=$Index
	
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
		[Alias('s')][object]$Schrift=(Schrift)
		)
	
	$RadioButton=New-Object System.Windows.Forms.RadioButton
	$RadioButton.Text=$Text
	$RadioButton.Size=New-Object System.Drawing.Size($Breite,$Höhe)
	$RadioButton.Location=New-Object System.Drawing.Size($X,$Y)
	$RadioButton.Font=$Schrift
	$RadioButton.TabIndex=$Index
	
	Return $RadioButton
	}

Function Feld {
	Param(
		[Alias('t')][string]$Text,
		[Alias('te')][string]$TextEingabe,
		[Alias('bl')][int]$BreiteLabel=100,
		[Alias('be')][int]$BreiteEingabe=300,
		[Alias('h')][int]$Höhe=25,
		[int]$X=15,
		[int]$Y,
		[Alias('i')][int]$Index,
		[Alias('sl')][object]$SchriftLabel=(Schrift),
		[Alias('se')][object]$SchriftEingabe=(Schrift),
		[Alias('p')][switch]$Password
		)
	$Optionen=@{
		password=$Password
		}
	
	$Feld=New-Object PSObject -Property @{
		Label=Label -t $Text -b $BreiteLabel -h $Höhe -x $X -y $Y -s $SchriftLabel
		TextBox=TextBox -t $TextEingabe -b $BreiteEingabe -h $Höhe -i $Index -x ($X+$BreiteLabel) -y $Y -s $SchriftEingabe @Optionen
		}
	
	Return $Feld
	}
