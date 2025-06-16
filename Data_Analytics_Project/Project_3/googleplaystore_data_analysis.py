import pandas as pd
import numpy as np

# Change the filepath according to your 'csv' file location on laptop / computer.
filepath = r'C:\Users\tejas\VS CODE\Data_Analytics_Projects\Data_Analytics_Project\Project_3\googleplaystore.csv' 

df = pd.read_csv(filepath)

print(df.head())

# Removing unnecessary column like Genre, Current Ver & Android Ver
df = df.drop(['Genres', 'Current Ver', 'Android Ver'], axis=1)

# Converting column data types
df['Category'] = df['Category'].astype('category')
df['Reviews'] = pd.to_numeric(df['Reviews'], errors='coerce')
df['Content Rating'] = df['Content Rating'].astype('category')

# Removing Last Updated column with New columns like Date Month and Year
df['Last Updated'] = pd.to_datetime(df['Last Updated'], errors='coerce')
df['Date'] = df['Last Updated'].dt.date
df['Month'] = df['Last Updated'].dt.month_name()
df['Year'] = df['Last Updated'].dt.year
df = df.drop('Last Updated', axis=1)

# Removing a string '$' in Price column
df['Price'] = df['Price'].str.replace('$', '', regex=False)
df['Price'] = pd.to_numeric(df['Price'], errors='coerce')

# Removing a row -> string 'Free' in Installs column
df = df.drop(10472, axis=0)
df = df.reset_index(drop=True)
df['Installs'] = df['Installs'].str.replace('[+,]', '', regex=True).astype(float)

# Removing a row -> nan in Type column
df = df.drop(9148, axis=0)
df = df.reset_index(drop=True)
df['Type'] = df['Type'].astype('category')

# Clean Size Column 
def convert_size(size):
    if pd.isna(size):
        return np.nan
    size = size.strip()

    if 'M' in size:
        return float(size.replace('M', ''))
    if 'k' in size:
        return float(size.replace('k', '')) / 1024 # kB to MB
    else:
        return np.nan

df['Size'] = df['Size'].replace('Varies with device', np.nan) 
df['Size'] = df['Size'].apply(convert_size)

# print(df.dtypes)
print(df.isnull().sum())

# Filling nan values of Rating and Size columns with median values
df['Rating'] = df['Rating'].fillna(df['Rating'].median())
df['Size'] = df['Size'].fillna(df['Size'].median())

# print(df.head())

df.to_csv(r'C:\Users\tejas\VS CODE\Data_Analytics_Projects\Data_Analytics_Project\Project_3\cleaned_googleplaystore_data.csv', index=False)