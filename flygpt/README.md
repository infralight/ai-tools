# FlyGPT

FlyGPT is an API that enables you to ask Firefly any questions based on the trained PDF files. Firefly is a large language model trained by OpenAI based on the GPT-3.5 architecture, and is capable of answering a wide range of questions.

## Installation

To use FlyGPT, you can either build the Docker image from source or use the pre-built Docker image from Docker Hub.

### Building the Docker Image

To build the Docker image for FlyGPT, you can use the following command:

```
docker build --build-arg OPENAI_API_KEY=my_api_key -t flygpt:latest --memory=8g --cpu-shares=2048 .
```


Replace `my_api_key` with your actual OpenAI API key.

### Using the Pre-built Docker Image

To use the pre-built Docker image from Docker Hub, you can use the following command:

```
docker run -p 8200:8200 flygpt:latest
```

Replace `my_api_key` with your actual OpenAI API key.

## Usage

Once you have the FlyGPT API running, you can ask Firefly any question by sending a POST request to the following endpoint:

```
http://localhost:8200/ask
YOUR QUESTION
```


## Stopping the Docker Container

To stop the running FlyGPT Docker container, use the `docker stop` command:

```
docker ps
```

This command will display a list of running Docker containers, along with their container IDs.

```
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
123456789abc flygpt "python server.py" 1 minute ago Up 1 minute 0.0.0.0:8200->8200/tcp friendly_newton
```

Copy the container ID of the running container, and use it to stop the container:

```
docker stop 123456789abc
```


## Conclusion

That's it! You should now have a working FlyGPT API that enables you to ask Firefly any question based on the trained PDF files. If you have any issues or questions, feel free to contact us.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

--------

Disclaimer: This README was created by an AI, and we can't guarantee that it won't take over the world someday. But for now, it's just a humble API for asking Firefly some questions. 😉
