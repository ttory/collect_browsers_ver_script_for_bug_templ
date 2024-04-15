$browsersNames = "*chrome*","*firefox*","*opera*"
$file = "Draft_bug_template.txt"

$draftContentToAdd1=@"
### Environment

<a href="https:/https://www.google.com/" style="color: red">Prod</a>

Browsers:
"@
$draftContentToAdd2=@"

### Steps to Reproduce


### Actual Result


### Expected Result


### Comments
"@

if(!(Test-Path -Path $file)){
	New-Item -Path . -ItemType File -Name $file
	$created = $true
	Add-Content $file $draftContentToAdd1
	ForEach ($browser in $browsersNames)
	{
		$br = (Get-Package -Name $browser)
		if($br -ne $null)
		{
			Add-Content $file (($br.name -split ' ' | select -First 2) -join ' ')
		}
	}
	Add-Content $file $draftContentToAdd2
}

ForEach ($browser in $browsersNames){
	$br = (Get-Package -Name $browser)
	if($br -ne $null)
	{
		$h = (($br.name -split ' ' | select -First 2) -join ' ')
		$w = $br.version
		((Get-Content $file -Raw) -replace "$h[0-9a-zA-Z\ \.]*", "$h $w") | Set-Content $file
	}
	
}
