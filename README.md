[![PySpark](https://img.shields.io/badge/PySpark-000?style=for-the-badge&logo=apachespark)](https://spark.apache.org/docs/latest/api/python/)

# Frequent Pattern Analysis

## Installing

1. Create and activate the virtual environment:
```bash
python3 -m venv .env && source .env/bin/activate
```

2. Install the requirements:
```bash
pip install -r requirements.txt
```

## Setting Up

1. Inside the `queries` folder, you can find the SQL files for the 5 different types of analysis.  
Run the desired one (adjusting the parameters), export the results to a CSV file and place it inside the `inputs` folder.

2. In the `main.py`, look up for ther following cell, replace the values of your input file and the output folder path (you must create one, if it doesn't exist):  
```bash
dataset_path = 'inputs/my-data.csv'
output_path = 'outputs/my-analysis'
```

3. Make a copy of the `config.sample.ini` file, renaming it to `config.ini`. Also, fill in with the database connection data.

4. In the `translate.py`, look up for the following cell and replace the `path` value with the same one used in step 2:
```bash
path = 'outputs/my-analysis'
```

## Running

1. After runnning the `main.py`, the model will create a file named `association_rules.csv` with the results (this file contains only barcodes, so it's not good for interpretation).

2. The `translate.py` notebook will do the translation from barcodes to product names, creating a file named `association_rules_translated.csv`. This file is better for the result interpretation.

**Note:**  
Not every barcode has a corresponding product name, and you might find barcodes in the translated file.  
After running the translation (step 2 of _Running_ section), the notebook will also create a file named `barcodes_not_found.csv`, listing all the barcodes that didn't had a match in the database.
