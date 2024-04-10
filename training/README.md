# Training Exercises

## Linux Basics

### Download CSV files with `curl`

```shell
curl https://data.neo4j.com/northwind/products.csv > products.csv
curl https://data.neo4j.com/northwind/categories.csv > categories.csv
curl https://data.neo4j.com/northwind/suppliers.csv > suppliers.csv
```

```shell
curl https://media.githubusercontent.com/media/datablist/sample-csv-files/main/files/organizations/organizations-100.csv > organizations-100.csv
curl https://media.githubusercontent.com/media/datablist/sample-csv-files/main/files/organizations/organizations-1000.csv > organizations-1000.csv
curl https://media.githubusercontent.com/media/datablist/sample-csv-files/main/files/organizations/organizations-10000.csv > organizations-10000.csv
curl https://media.githubusercontent.com/media/datablist/sample-csv-files/main/files/organizations/organizations-100000.csv > organizations-100000.csv
curl https://media.githubusercontent.com/media/datablist/sample-csv-files/main/files/organizations/organizations-1000000.csv > organizations-1000000.csv
```

### Get line count using `wc`

### Get list of category names using `awk`

Get the list of category names, removing the header row, and store in `categories.txt`

```shell
awk -F, '{OFS=",";print $2}' categories.csv > categories.txt
awk -F, '{OFS=",";print $2}' categories.csv | awk '{if(NR > 1) print $0}' > categories.txt
```

### Download JSON files with `curl`

```shell
curl https://89.242.5.222/api/films > films.json
```