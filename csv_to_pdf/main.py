import os
import csv
from reportlab.pdfgen import canvas

# Specify the input and output folders
input_folder = "./input"
output_folder = "./output"

# Create the output folder if it doesn't already exist
if not os.path.exists(output_folder):
    os.mkdir(output_folder)

# Loop through all the CSV files in the input folder
for filename in os.listdir(input_folder):
    if filename.endswith(".csv"):
        # Open the CSV file and read the data
        with open(os.path.join(input_folder, filename), "r") as csv_file:
            csv_reader = csv.reader(csv_file)
            data = [row for row in csv_reader]

        # Create the PDF file and write the data to it
        pdf_filename = os.path.splitext(filename)[0] + ".pdf"
        pdf_path = os.path.join(output_folder, pdf_filename)
        c = canvas.Canvas(pdf_path)
        for i, row in enumerate(data):
            for j, cell in enumerate(row):
                c.drawString(j * 100, (len(data) - i) * 20, cell)
        c.save()