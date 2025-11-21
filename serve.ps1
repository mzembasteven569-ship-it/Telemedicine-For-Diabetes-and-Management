# serve.ps1 — simple helper to run a local static server
# Usage: Open PowerShell in project root and run: ./serve.ps1

$port = 8000

function Start-PythonServer {
    Write-Host "Starting Python HTTP server on port $port..."
    python -m http.server $port
}

# Check for python
$py = Get-Command python -ErrorAction SilentlyContinue
if ($py) {
    Start-PythonServer
} else {
    Write-Host "Python not found in PATH. Options:"
    Write-Host " - Install Python 3 and re-run this script"
    Write-Host " - Use Node: 'npx http-server -p 8000'"
    Write-Host " - Or run: python -m http.server 8000 from project root"
}
