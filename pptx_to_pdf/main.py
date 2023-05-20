import os
from pptx import Presentation

# Define the input and output folders
input_folder = './input'
output_folder = './output'

# Create the output folder if it doesn't exist
if not os.path.exists(output_folder):
    os.makedirs(output_folder)

# Loop through all files in the input folder
for filename in os.listdir(input_folder):
    if filename.endswith('.pptx'):
        # Create the full input and output paths
        input_path = os.path.join(input_folder, filename)
        output_path = os.path.join(output_folder, os.path.splitext(filename)[0] + '.pdf')

        # Open the PPTX file and save as PDF
        prs = Presentation(input_path)
        prs.save(output_path)