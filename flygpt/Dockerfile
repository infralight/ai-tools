FROM python:3.9-slim-buster
WORKDIR /app
COPY server.py .
RUN pip install requests
RUN pip install langchain
RUN pip install openai
RUN pip install chromadb
ENV OPENAI_API_KEY=<PUT_VALUE_HERE>
EXPOSE 8200
CMD ["python", "server.py"]
