import os
from langchain.document_loaders import PyPDFLoader
from langchain.indexes import VectorstoreIndexCreator

import http.server
import socketserver
import urllib.parse

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


class MyServer(socketserver.TCPServer):
    """Custom TCP server that initializes its parent class with given parameters."""
    def __init__(self, server_address, RequestHandlerClass, bind_and_activate=True):
        super().__init__(server_address, RequestHandlerClass, bind_and_activate)


class MyRequestHandler(http.server.SimpleHTTPRequestHandler):
    """Custom request handler for HTTP server."""
    def __init__(self, index, *args):
        self.index = index
        super().__init__(*args)

    def do_POST(self):
        """Handle POST requests."""
        parsed_url = urllib.parse.urlparse(self.path)
        if parsed_url.path == "/ask":
            content_length = int(self.headers.get('Content-Length', 0))
            post_data = self.rfile.read(content_length)
            # Do something with post_data
            self.send_response(200)
            self.send_header("Content-type", "text/plain")
            self.end_headers()

            # Query the index with the decoded post data
            res = self.index.query(post_data.decode())
            self.wfile.write(res.encode())
        else:
            # If the requested path is not "/ask", return a 404 error
            self.send_error(404)


if __name__ == "__main__":
    # Load all PDF files in the "input" directory and create an index
    all_file_paths = get_all_file_paths("./input")
    py_pdf_loader = [PyPDFLoader(path) for path in all_file_paths]
    index = VectorstoreIndexCreator().from_loaders(py_pdf_loader)

    # Start an HTTP server on localhost port 8200 with MyRequestHandler
    server_address = ('localhost', 8200)
    httpd = http.server.HTTPServer(server_address, lambda *args: MyRequestHandler(index, *args))
    httpd.serve_forever()

