$geekyJokes = @(
    "Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!",
    "Why do programmers prefer using the dark mode? Because light attracts bugs!",
    "Why did the programmer go broke? Because he used up all his cache!",
    "Why do programmers hate nature? It has too many bugs!",
    "Why did the developer go broke? Because he lost his domain in the cloud!",
    "Why don't programmers like nature? It has too many bugs!",
    "Why do Java developers wear glasses? Because they don't C#!",
    "Why did the web developer walk out of therapy? Because he had too many issues!",
    "Why do programmers always mix up Christmas and Halloween? Because Oct 31 == Dec 25!",
    "Why do programmers prefer using the dark mode? Because light attracts bugs!",
    "Why do programmers prefer using the dark mode? Because light attracts bugs!"
)

function Get-RandomJoke {
    $randomIndex = Get-Random -Minimum 0 -Maximum $geekyJokes.Length
    $geekyJokes[$randomIndex]
}

Write-Host "Geeky Joke of the Day:"
Get-RandomJoke
