import pandas as pd
import os
from io import StringIO
from fpdf import FPDF

def loadfile(filepath):
    """
    Loads a CSV, Excel, or JSON file into a pandas DataFrame.
    """
    if not os.path.exists(filepath):
        raise FileNotFoundError("The specified file does not exist.")
    
    extension = os.path.splitext(filepath)[-1].lower()
    encodings = ["utf-8", "cp1252", "latin-1", "ISO-8859-1"]

    if extension == ".csv":     # Reading .csv files
        for enc in encodings:
            try:
                df = pd.read_csv(filepath, encoding=enc)
                print(f"✅ Loaded successfully using encoding: {enc}")
                return df
            except UnicodeDecodeError:
                continue
        raise UnicodeDecodeError("❌ Failed to read the file with utf-8, cp1252, ISO-8859-1 or latin-1 encoding.")

    elif extension in [".xlsx", ".xls"]:    # Reading .xlsx files
        df = pd.read_excel(filepath)
    elif extension == ".json":      # Reading .json files
        df = pd.read_json(filepath)
    else:
        raise ValueError("Unsupported file type. Please use CSV, Excel, or JSON.")
    
    return df

# filepath = input(r"")
filepath = input(r"📂 Enter the full path to your data file: ").strip()
df = loadfile(filepath)

# Buffer to store all printed output for PDF later
output = StringIO()

# Shape of the DataFrame
print("👇👇👇👇👇")
output.write("----------------------------------------------------------------------------------------\n")

print(f"\n👉 The file has {df.shape[0]} rows and {df.shape[1]} columns.")
output.write(f"\nThe file has {df.shape[0]} rows and {df.shape[1]} columns.\n")
output.write("----------------------------------------------------------------------------------------\n")

# Column names
print(f"\n🧾 Column names in the file are:")
print(df.columns.to_list())
output.write(f"\nColumn names in the file are:\n{df.columns.to_list()}\n")
output.write("----------------------------------------------------------------------------------------\n")

# Data types of each column
print(f"\n🔢 Data types of each column:")
print(df.dtypes)
output.write(f"\nData types of each column:\n{df.dtypes}\n")
output.write("----------------------------------------------------------------------------------------\n")

# Unique values in each column
print(f"\n🔍 Number of unique values in each columns:")
print(df.nunique())
output.write(f"\nNumber of unique values in each column:\n{df.nunique()}\n")
output.write("----------------------------------------------------------------------------------------\n")

# Null values in each column
print(f"\n0️⃣ Number of null values in each columns:")
print(df.isnull().sum())
output.write(f"\nNumber of null values in each column:\n{df.isnull().sum()}\n")
output.write("----------------------------------------------------------------------------------------\n")

# Percentage of missing values in each column
print(f"\n📉 Percentage of missing values in each column:")
print((df.isnull().sum() / len(df) * 100).round(2))
output.write(f"\nPercentage of missing values in each column:\n{(df.isnull().sum() / len(df) * 100).round(2)}\n")
output.write("----------------------------------------------------------------------------------------\n")

# Duplicate rows
print(f"\n🟡 Total duplicate rows in the dataset: {df.duplicated().sum()}")
output.write(f"\nTotal duplicate rows in the dataset: {df.duplicated().sum()}\n")
output.write("----------------------------------------------------------------------------------------\n")

# Statistics Summary of the Dataframe
print(f"\n📊 Summary statistics for numeric columns:")
print(df.describe().round(2))
output.write(f"\nSummary statistics for numeric columns:\n{df.describe().round(2)}\n")
output.write("----------------------------------------------------------------------------------------\n")

# Correlation Matrix
print(f"\n🔗 Correlation matrix (numeric columns only):")
print(df.corr(numeric_only=True).round(2))
output.write(f"\nCorrelation matrix (numeric columns only):\n{df.corr(numeric_only=True).round(2)}\n")
output.write("----------------------------------------------------------------------------------------\n")

# Outlier Detection Report
def detect_outliers_iqr(data):
    outlier_summary = {}

    for column in data.select_dtypes(include="number").columns:
            Q1 = data[column].quantile(0.25)
            Q3 = data[column].quantile(0.75)
            IQR = Q3 - Q1

            outliers = data[(data[column] < Q1 - 1.5 * IQR) | (data[column] < Q3 + 1.5 * IQR)]
            outlier_summary[column] = len(outliers)
    return outlier_summary

outliers = detect_outliers_iqr(df)
print("\n⚠️  Number of outliers detected in each numeric column (IQR method):")
print(outliers)
output.write(f"\nNumber of outliers detected in each numeric column (IQR method):\n{outliers}\n")
output.write("----------------------------------------------------------------------------------------\n")


# Ask user to export PDF
choice = input("\n📄 Do you want to export this report to PDF? (yes/no): ").strip().lower()

if choice == "yes": 
    class PDF(FPDF):
        def header(self):
            self.set_font("Arial", "B", 12)
            self.cell(0, 10, "Automated EDA Report", ln=True, align='C')
            self.ln(5)

        def chapter_body(self, body):
            self.set_font("Courier", "", 9)
            self.multi_cell(0, 4, body)
            self.ln()

    pdf = PDF()
    pdf.set_auto_page_break(auto=True, margin=10)
    pdf.add_page()
    content = output.getvalue()
    pdf.chapter_body(content)

    output_filename = "EDA_Report.pdf"
    pdf.output(output_filename)
    print(f"\n✅ Report successfully saved as {output_filename}")

else:
    print("\n🙂 PDF export skipped.")