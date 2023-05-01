FROM python:3.9-slim-buster
ARG OPENAI_API_KEY
WORKDIR /app
COPY server.py .
RUN pip install --upgrade pip
RUN pip install requests
RUN pip install langchain
RUN pip install openai
RUN pip install chromadb
ENV OPENAI_API_KEY=$OPENAI_API_KEY
EXPOSE 8200
CMD ["python", "server.py"]
