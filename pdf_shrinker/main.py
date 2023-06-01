import os
# Importing the function from the previous code block
from PDFNetPython3.PDFNetPython import PDFDoc, Optimizer, SDFDoc, PDFNet

# Sefi: I'm happy to push this API Key to GitHub, because it took me ~1h to generate it
# thru apryse.com, And if this API Key will be exposed I don't fucking care... Enjoy :)
PDF_APIKEY = "demo:NOW_ITS_A_PUBLIC_REPO_AND_WE_CANT_PUSH_SECRETS"

def get_size_format(b, factor=1024, suffix="B"):
    """
    Scale bytes to its proper byte format
    e.g:
        1253656 => '1.20MB'
        1253656678 => '1.17GB'
    """
    for unit in ["", "K", "M", "G", "T", "P", "E", "Z"]:
        if b < factor:
            return f"{b:.2f}{unit}{suffix}"
        b /= factor
    return f"{b:.2f}Y{suffix}"

def compress_file(input_file: str, output_file: str):
    """Compress PDF file"""
    if not output_file:
        output_file = input_file
    initial_size = os.path.getsize(input_file)
    try:
        # Initialize the library
        PDFNet.Initialize(PDF_APIKEY)
        doc = PDFDoc(input_file)
        # Optimize PDF with the default settings
        doc.InitSecurityHandler()
        # Reduce PDF size by removing redundant information and compressing data streams
        Optimizer.Optimize(doc)
        doc.Save(output_file, SDFDoc.e_linearized)
        doc.Close()
    except Exception as e:
        print("Error compress_file=", e)
        doc.Close()
        return False
    compressed_size = os.path.getsize(output_file)
    ratio = 1 - (compressed_size / initial_size)
    summary = {
        "Input File": input_file, "Initial Size": get_size_format(initial_size),
        "Output File": output_file, f"Compressed Size": get_size_format(compressed_size),
        "Compression Ratio": "{0:.3%}.".format(ratio)
    }
    # Printing Summary
    print("## Summary ########################################################")
    print("\n".join("{}:{}".format(i, j) for i, j in summary.items()))
    print("###################################################################")
    return True

def get_all_file_paths(directory):
    """Get a list of file paths in a given directory and its subdirectories.

    Args:
        directory (str): The path of the directory.

    Returns:
        A list of file paths (str).
    """
    file_paths = []

    for root, _, files in os.walk(directory):
        for file in files:
            file_paths.append(os.path.join(root, file))

    return file_paths


# Input and output folders
input_folder = "./input"
output_folder = "./output"

# Recursively looping over all the PDF files in the input folder and its subfolders
for root, dirs, files in os.walk(input_folder):
    for filename in files:
        if filename.endswith(".pdf"):
            # Compressing the PDF file and saving it in the output folder while maintaining the same folder structure
            input_path = os.path.join(root, filename)
            output_path = os.path.join(output_folder, os.path.relpath(input_path, input_folder))
            os.makedirs(os.path.dirname(output_path), exist_ok=True)
            compress_file(input_path, output_path)
