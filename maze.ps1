function Show-Maze {
    Clear-Host
    $maze = @"
##############
#S         E#
# ######### #
#    #      #
### ### #####
#       #   #
##### ########
#      #    #
# ######### #
#           #
##############
"@
    Write-Host $maze
}

function Play-Game {
    $playerPosition = [System.Management.Automation.Host.Coordinates]::new(1, 1)
    
    Show-Maze
    
    while ($true) {
        $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character

        $newPosition = $playerPosition.Clone()
        
        switch ($key) {
            'w' { $newPosition.Y-- }
            's' { $newPosition.Y++ }
            'a' { $newPosition.X-- }
            'd' { $newPosition.X++ }
            default { continue }
        }

        if ($maze[$newPosition.Y][$newPosition.X] -ne '#') {
            $playerPosition = $newPosition
            Show-Maze
            
            if ($maze[$playerPosition.Y][$playerPosition.X] -eq 'E') {
                Write-Host "Congratulations! You've reached the exit!"
                break
            }
        }
    }
}

Play-Game
