$html = @"
<!DOCTYPE html>
<html>
<head>
    <title>Data Table</title>
    <style>
        table {
            border-collapse: collapse;
            width: 50%;
            margin: auto;
            margin-top: 20px;
        }
        th, td {
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
    </style>
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
$html += " <tr>"
$html += " <td>$($entry.Date)</td>"
$html += " <td>$($entry.Value)</td>"
$html += " </tr>"
}

$html += @"
</table>

   </body>
   </html>
"@
$html | Out-File -FilePath "datatable.html" -Encoding UTF8
Start-Process "datatable.html"
