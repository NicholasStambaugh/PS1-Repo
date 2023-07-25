function Show-RocketAnimation {
    $rocket = @'
     /\\
    |==|
   /==/\\
  /=/  \ \
 /=/    \ \
 |''''''''''|
 |''''''''''|
  \(\\|\\|\\)/
'@

    $clearScreen = {
        cls
        Write-Host ""
    }

    $animateRocket = {
        $rocketFrames = @(
            $rocket,
            $rocket -replace '/\\', '//',
            $rocket -replace '/\\', '\\\\',
            $rocket -replace '/\\', 'XX',
            $rocket -replace '/\\', '  ',
            ""
        )

        foreach ($frame in $rocketFrames) {
            $clearScreen.Invoke()
            Write-Host $frame
            Start-Sleep -Milliseconds 150
        }
    }

    $animateRocket.Invoke()
}

Show-RocketAnimation
