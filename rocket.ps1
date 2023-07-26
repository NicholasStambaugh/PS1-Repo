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
            Start-Sleep -Milliseconds 600  # Increase the milliseconds value to slow down the animation
        }
    }

    $animateRocket.Invoke()
}

Show-RocketAnimation
