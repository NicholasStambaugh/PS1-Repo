$html = @"
<!DOCTYPE html>
<html>
<head>
    <title>Line Graph</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
</head>
<body>
    <canvas id="lineChart" width="400" height="200"></canvas>
    <script>
        var ctx = document.getElementById('lineChart').getContext('2d');
        var data = {
            labels: [],
            datasets: [{
                label: 'Value',
                data: [],
                borderColor: 'blue',
                fill: false
            }]
        };

        var rawData = [
"@

$csvData = Import-Csv -Path "data.csv"
foreach ($entry in $csvData) {
    $html += "               { x: '$($entry.Date)', y: $($entry.Value) },`r`n"
}

$html += @"
        ];

        rawData.forEach(function(item) {
            data.labels.push(item.x);
            data.datasets[0].data.push(item.y);
        });

        var lineChart = new Chart(ctx, {
            type: 'line',
            data: data,
            options: {
                responsive: false,
                scales: {
                    x: {
                        type: 'time',
                        time: {
                            unit: 'day',
                            displayFormats: {
                                day: 'MMM D'
                            }
                        }
                    },
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
"@

$html | Out-File -FilePath "linegraph.html" -Encoding UTF8
Start-Process "linegraph.html"
