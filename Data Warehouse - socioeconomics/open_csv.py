import pandas as pd

df = pd.read_csv("saude.csv")
df.to_csv("saude_pd.csv")
print(df)