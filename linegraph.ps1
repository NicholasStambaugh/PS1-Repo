$html = @"
<!DOCTYPE html>
<html>
<head>
    <title>Data Table</title>
</head>
<body>
    <table border="1">
        <tr>
            <th>Date</th>
            <th>Value</th>
        </tr>
"@

$csvData = Import-Csv -Path "data.csv"
foreach ($entry in $csvData) {
$html += " <tr>rn"
$html += " <td>$($entry.Date)</td>rn"
$html += " <td>$($entry.Value)</td>rn"
$html += " </tr>rn"
}

$html += @"
</table>

   </body>
   </html>
"@
$html | Out-File -FilePath "datatable.html" -Encoding UTF8
Start-Process "datatable.html"
