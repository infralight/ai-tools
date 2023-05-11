FROM python:3.9

ARG OPENAI_API_KEY
WORKDIR /app
VOLUME /app/db
VOLUME /app/input
COPY . .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

#Chromadb takes too much time, that's a workaround
RUN ["cp", "-R", "/app/bin/chromadb", "/usr/local/lib/python3.9/site-packages"]

EXPOSE 8200
#RUN pip install chromadb
ENV OPENAI_API_KEY=$OPENAI_API_KEY
CMD ["python", "server.py"]
