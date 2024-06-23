$versionUrl = "https://pr2hub.com/version.txt"
$ffdec = "C:\Users\oxyge\Downloads\ffdec_20.1.0_nightly2780\ffdec-cli.exe"
$projectName = "pr2"
$exportPath = (Get-Location).ToString() + "\clientsrc\"

$animatePath = $env:ANIMATE_PATH
if ([string]::IsNullOrWhiteSpace($animatePath)) {
    $animatePath = "C:/Program Files/Adobe/Adobe Animate 2021/Animate.exe"
    Write-Host "%ANIMATE_PATH% was not set, using default: $animatePath"
}


function ConvertTo-DecryptedSwf {
    param (
        [byte[]] $bytes
    )

    $newSwc = New-Object byte[] $bytes.Length
    [System.Array]::Copy($bytes, $newSwc, $bytes.Length)

    $i = 9991
    while ($i-- -ne 0) {
        $newSwc[$i] = $bytes[9990 - $i]
    }

    return $newSwc
}

function Export-Fla {
    param (
        [string] $OutPath,
        [string] $InSwf
    )
    
    New-Item -Path $exportPath -ItemType "directory"
    Start-Process -Wait -NoNewWindow -ErrorAction Stop -FilePath $ffdec -ArgumentList "-cli", "-export xfl", $OutPath, $InSwf 
    Copy-Item -Force -Path ".\templates\PublishSettings.xml" -Dest "clientsrc\$projectName\PublishSettings.xml"

    Remove-Item "$OutPath\com\hurlant\util\Memory.as" # never used/import conflict
    Remove-Item -Recurse "$OutPath\fl" # bad decompilation
}

function Edit-Scripts {
    param (
        [string] $SrcFolder
    )

    # Testing mode allows the game to actually initialize in the debugger.
    # $main = "$SrcFolder\Main.as"
    # (Get-Content $main) -replace "testing:Boolean = false","testing:Boolean = true" | Set-Content $main

    # "private" -> "protected" so we can hook classes properly.
    $excludeFiles = @("ShotEffect.as", "BlockBackground.as", "class_229.as", "PlayersTabListHolder.as", "Removable.as")
    $files = Get-ChildItem "clientsrc" *.as -rec
    foreach ($file in $files)
    {
        if ($excludeFiles -notcontains $file.Name) {
            $content = Get-Content $file.PSPath
            $updatedContent = $content | ForEach-Object {
                $_ -replace "\b(private|protected)\b", "public"
            }
            $updatedContent | Set-Content $file.PSPath
        }
    }
}

function Publish-App {
    Start-Process -Wait -NoNewWindow -FilePath $animatePath -ArgumentList ((Get-Location).ToString()+"/publish.jsfl"), "-AlwaysRunJSFL"
}

Write-Host "Fetching version info"
Invoke-WebRequest $versionUrl -OutFile version.txt
$version = Get-Content .\version.txt | ConvertFrom-Json

if (-not (Test-Path ".\pr2.swf")) {
    Write-Host "Downloading SWF file"
    $response = Invoke-WebRequest $version.url -ContentType "application/octet-stream"

    if ($response.StatusCode -ne 200) {
        Write-Host "Failed to download SWF: $($response.StatusDescription)"
        exit
    }

    $swf = ConvertTo-DecryptedSwf $response.Content

    [IO.File]::WriteAllBytes("pr2.swf", $swf)
}

Export-Fla $exportPath ((Get-Location).ToString()+"\pr2.swf")
Edit-Scripts $exportPath
Publish-App



# trustedPaths "%AppData%\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys\settings.sol"