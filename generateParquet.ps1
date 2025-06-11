# Sample pixel blend function map
$data = @(
    @{ x = 0; y = 0; blendFn = "average" }
    @{ x = 1; y = 0; blendFn = "min" }
    @{ x = 2; y = 0; blendFn = "max" }
    @{ x = 0; y = 1; blendFn = "max" }
    @{ x = 1; y = 1; blendFn = "average" }
    @{ x = 2; y = 1; blendFn = "min" }
    @{ x = 0; y = 2; blendFn = "min" }
    @{ x = 1; y = 2; blendFn = "max" }
    @{ x = 2; y = 2; blendFn = "average" }
)

# Get script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Output paths
$csvPath = Join-Path $scriptDir "blendMap.csv"
$parquetPath = Join-Path $scriptDir "blendMap.parquet"

# Write to CSV
$data | Export-Csv -Path $csvPath -NoTypeInformation

# Convert CSV to Parquet using DuckDB
duckdb -c "COPY (SELECT * FROM read_csv_auto('$csvPath')) TO '$parquetPath' (FORMAT 'parquet');"

Write-Host "Generated $parquetPath from $csvPath"
