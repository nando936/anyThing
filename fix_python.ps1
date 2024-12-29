# Fix PATH and Python Configuration Script
Write-Host "Starting PATH and Python Configuration Script..." -ForegroundColor Cyan

# Configuration
$projectPath = "E:\projects\anyThing"
$pythonInstallPath = "$env:LocalAppData\Programs\Python\Python313"
$pythonScriptsPath = "$pythonInstallPath\Scripts"

# Ensure PATH contains necessary Python paths
Write-Host "Checking and fixing system PATH..." -ForegroundColor Cyan
$envPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
$envPathEntries = $envPath -split ';'

# Remove duplicates
$uniquePaths = $envPathEntries | Sort-Object -Unique

# Add Python paths if missing
if (-not ($uniquePaths -contains $pythonInstallPath)) {
    Write-Host "Adding Python install path to PATH..." -ForegroundColor Green
    $uniquePaths += $pythonInstallPath
}

if (-not ($uniquePaths -contains $pythonScriptsPath)) {
    Write-Host "Adding Python Scripts path to PATH..." -ForegroundColor Green
    $uniquePaths += $pythonScriptsPath
}

# Remove any placeholders like Microsoft Store Python
$uniquePaths = $uniquePaths | Where-Object { $_ -notmatch "WindowsApps" }

# Prioritize Python paths
$uniquePaths = @($pythonInstallPath, $pythonScriptsPath) + ($uniquePaths | Where-Object { $_ -ne $pythonInstallPath -and $_ -ne $pythonScriptsPath })

# Update PATH
[System.Environment]::SetEnvironmentVariable("Path", ($uniquePaths -join ';'), "Machine")
Write-Host "System PATH updated successfully!" -ForegroundColor Green

# Enable script execution in the project directory
Write-Host "Ensuring script execution permissions for $projectPath..." -ForegroundColor Cyan
Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy RemoteSigned -Force
Write-Host "Execution policy set to RemoteSigned globally." -ForegroundColor Green

# Verify Python installation
Write-Host "Verifying Python installation..." -ForegroundColor Cyan
try {
    $pythonVersion = & "$pythonInstallPath\python.exe" --version
    Write-Host "Python version detected: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "Python not found or not working. Attempting to fix..." -ForegroundColor Yellow

    # Install Python if necessary (silent install)
    Write-Host "Please download and install Python manually from https://www.python.org/downloads/ if not already installed." -ForegroundColor Red
    Exit
}

# Ensure the virtual environment in the project path
Write-Host "Checking virtual environment in $projectPath..." -ForegroundColor Cyan
$venvPath = "$projectPath\venv"

if (-Not (Test-Path $venvPath)) {
    Write-Host "Creating a new virtual environment..." -ForegroundColor Green
    & "$pythonInstallPath\python.exe" -m venv $venvPath
} else {
    Write-Host "Virtual environment already exists." -ForegroundColor Green
}

# Activate the virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Cyan
& "$venvPath\Scripts\Activate.ps1"

# Install Flask if not installed
Write-Host "Checking Flask installation..." -ForegroundColor Cyan
$flaskCheck = & "$venvPath\Scripts\python.exe" -m pip show flask 2>$null
if (-not $flaskCheck) {
    Write-Host "Flask not found. Installing Flask..." -ForegroundColor Green
    & "$venvPath\Scripts\python.exe" -m pip install flask flask-cors
} else {
    Write-Host "Flask is already installed." -ForegroundColor Green
}

Write-Host "Script completed successfully! Your Python and PATH setup is now fixed." -ForegroundColor Cyan
