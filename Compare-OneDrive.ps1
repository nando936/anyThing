# Define the directories to compare
$directory1 = "D:\OneDrive"
$directory2 = "E:\old D OneDrive"
$v2Directory = "E:\v2"
$duplicatesDirectory = Join-Path -Path $v2Directory -ChildPath "duplicates"
$differentSizeSubfolder = Join-Path -Path $v2Directory -ChildPath "duplicates different size"

# Ensure the v2 directory and subfolders exist
if (-not (Test-Path -Path $v2Directory)) {
    New-Item -ItemType Directory -Path $v2Directory | Out-Null
}
if (-not (Test-Path -Path $duplicatesDirectory)) {
    New-Item -ItemType Directory -Path $duplicatesDirectory | Out-Null
}
if (-not (Test-Path -Path $differentSizeSubfolder)) {
    New-Item -ItemType Directory -Path $differentSizeSubfolder | Out-Null
}

# Get the list of files from both directories, including their sizes
Write-Host "Gathering files from $directory2..."
$filesInDirectory2 = Get-ChildItem -Path $directory2 -Recurse -File | Select-Object FullName, Name, Length
Write-Host "Found $($filesInDirectory2.Count) files in $directory2."

Write-Host "Gathering files from $directory1..."
$filesInDirectory1 = Get-ChildItem -Path $directory1 -Recurse -File | Select-Object FullName, Name, Length
Write-Host "Found $($filesInDirectory1.Count) files in $directory1."

# Find duplicates by looping through dir2 and comparing with dir1
$progressIndex = 0
foreach ($file2 in $filesInDirectory2) {
    $progressIndex++
    Write-Progress -Activity "Comparing Files" -Status "Processing file $progressIndex of $($filesInDirectory2.Count): $($file2.FullName)"

    $matchingFiles = $filesInDirectory1 | Where-Object {
        $_.Name -eq $file2.Name
    }

    if ($matchingFiles.Count -gt 0) {
        foreach ($match in $matchingFiles) {
            if ($match.Length -eq $file2.Length) {
                Write-Host "Duplicate found: $($file2.FullName) matches $($match.FullName)"

                # Create the same folder structure in the duplicates directory
                $relativePath = $file2.FullName.Substring($directory2.Length).TrimStart("\")
                $destinationPath = Join-Path -Path $duplicatesDirectory -ChildPath $relativePath
                $destinationFolder = Split-Path -Path $destinationPath -Parent

                if (-not (Test-Path -Path $destinationFolder)) {
                    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
                }

                try {
                    Move-Item -Path $file2.FullName -Destination $destinationPath -Force
                    Write-Host "Moved duplicate: $($file2.FullName) to $destinationPath"
                } catch {
                    Write-Host "Failed to move duplicate: $($file2.FullName). Error: $_"
                }
            } else {
                Write-Host "Duplicate with different size found: $($file2.FullName) (Size: $($file2.Length)) does not match $($match.FullName) (Size: $($match.Length))"

                # Handle duplicates with different sizes
                $relativePath = $file2.FullName.Substring($directory2.Length).TrimStart("\")
                $destinationPath = Join-Path -Path $differentSizeSubfolder -ChildPath $relativePath
                $destinationFolder = Split-Path -Path $destinationPath -Parent

                if (-not (Test-Path -Path $destinationFolder)) {
                    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
                }

                try {
                    Move-Item -Path $file2.FullName -Destination $destinationPath -Force
                    Write-Host "Moved duplicate with different size: $($file2.FullName) to $destinationPath"
                } catch {
                    Write-Host "Failed to move duplicate with different size: $($file2.FullName). Error: $_"
                }
            }
        }
    }
}
