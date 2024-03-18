param (
    [Parameter(Mandatory = $true)]
    [string]$jungleFile,

    [Parameter(Mandatory = $false)]
    # [string]$outputDirectory = (Get-Location).Path,
    [string]$outputDirectory = "./bin",

    [Parameter(Mandatory = $false)]
    [string]$version
)

function Get-ManifestFile($jungleFile) {
    $jungleContent = Get-Content $jungleFile
    $manifestLine = $jungleContent | Where-Object { $_ -match "project.manifest" }
    $manifestFile = $manifestLine -replace '.*=', '' -replace '"', '' -replace ' ', ''
    return $manifestFile
}

function Test-IfFileExistsOrExit($file, $fileDescription = $file) {
    if (-not (Test-Path $file)) {
        Write-Host "$fileDescription does not exist. Exiting."
        exit 1
    }
}

function Get-VersionFromManifest($manifestFile) {
    [xml]$manifestContent = Get-Content $manifestFile
    # Extract the version from the manifest file
    $version = $manifestContent.manifest.barrel.version
    return $version
}

function Update-ManifestFile($manifestFile, $version) {
    $manifestContent = New-Object System.Xml.XmlDocument
    $manifestContent.PreserveWhitespace = $true
    $manifestContent.Load($manifestFile)
    $manifestContent.manifest.barrel.version = $version
    # print out the updated manifest file
    Write-Host "--------Updated manifest file: $manifestContent.manifest.barrel.version"
    $manifestContent.Save($manifestFile)
}

function Get-NameFromManifest($manifestFile) {
    [xml]$manifestContent = Get-Content $manifestFile
    $name = $manifestContent.manifest.barrel.module
    return $name
}

# get the CIQ_SDK environment variable
$CIQ_SDK = [Environment]::GetEnvironmentVariable("CIQ_SDK", "User")

# check if CIQ_SDK is set
if ([string]::IsNullOrEmpty($CIQ_SDK)) {
    Write-Host "CIQ_SDK is not set. Exiting."
    exit 1
}

# print warning if fungle file is not found
Test-IfFileExistsOrExit $jungleFile "Jungle file"

# Get the directory of the jungle file
$project_dir = Split-Path -Parent $jungleFile

# !!! execute following logic in project directory
Push-Location $project_dir

$manifestFile = Get-ManifestFile $jungleFile
Test-IfFileExistsOrExit $manifestFile

if ([string]::IsNullOrEmpty($version)) {
    $version = Get-VersionFromManifest $manifestFile
    Write-Host "--------Version: $version"
}
else {
    Write-Host "--------Updating manifest file with new version: $version"
    Update-ManifestFile $manifestFile $version
}


$outputFileName = (Get-NameFromManifest $manifestFile) + "-" + $version + ".barrel"
$myBarrelbuild = $CIQ_SDK + "/bin/barrelbuild.bat"
Test-IfFileExistsOrExit $myBarrelbuild

# run the myBarrelbuild command
Write-Host "--------Running barrelbuild command: $myBarrelbuild -o $outputDirectory/$outputFileName -f $jungleFile"
& $myBarrelbuild -o $outputDirectory/$outputFileName -f $jungleFile


# Write-Host "$myBarrelbuild -o $outputDirectory/$outputFileName -f $jungleFile"

Pop-Location
