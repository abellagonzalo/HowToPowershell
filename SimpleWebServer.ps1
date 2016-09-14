

$Port = '8890'
$Url = ''

if ($Url.Length -gt 0 -and -not $Url.EndsWith('/')) {
    $Url += '/'
}

$listener = New-Object System.Net.HttpListener
$prefix = "http://vdt110:$Port/$Url"
$listener.Prefixes.Add($prefix)

try {
    $listener.Start()
    while ($true) {

        $statusCode = 200
        Write-Host "Listening on $port..."

        $task = $listener.GetContextAsync()

        While (!$task.IsCompleted) { Start-Sleep -m 100 }

        $context = $task.Result
        $request = $context.Request
        $response = $context.Response

        $Url1 = $request.QueryString['FailsafeUrl'] + '?TransNo=' + $request.QueryString['TransNo']
        Write-Host "Phase 1: $Url1"
        Invoke-WebRequest -Uri $Url1

        $Url2 = $request.QueryString['ReturnUrl'] + '?TransNo=' + $request.QueryString['TransNo']
        Write-Host "Phase 2: Redirect to $Url2"
        $response.Redirect($Url2)
        $response.Close()
        
        #$returnUrl  = $request.QueryString['ReturnUrl'] + '?'
        #$returnUrl += 'response=0' # response code 0-1
        #$returnUrl += '&referenceno=' + (Get-Random)
        #$returnUrl += '&transid=' + $request.QueryString['TransNo']

        #Write-Host "Redirecting to $returnurl"

        #$response = $context.Response
        #$response.StatusCode = $statusCode
        #$response.Redirect($returnUrl)
        #$response.Close()

        #$commandOutput = "The raw url is $($request.RawUrl)"

        #$response = $context.Response
        #$response.StatusCode = $statusCode
        #$buffer = [System.Text.Encoding]::UTF8.GetBytes($commandOutput)

        #$response.ContentLength64 = $buffer.Length
        #$output = $response.OutputStream
        #$output.Write($buffer,0,$buffer.Length)
        #$output.Close()
    }
} finally {
    $listener.Stop()
    $listener.Dispose()
    $listener = $Null
}
