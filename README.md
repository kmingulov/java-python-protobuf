# protobuf-example

**protobuf-example** is a simple example project demonstrating communication between Java/JavaScript/Ruby code using Protocol Buffers (protobuf).

The project consists of several components:

* `java-log-service`, a logging micro-service which allows to save and get Protobuf-encoded log messages over HTTP;
* `js-web-ui`, a web UI for the logging service;
* `ruby-client`, Ruby client for the logging service;
* `proto`, generic Protobuf files.

## Prerequisites

You need the following software installed in order to build and run this project:

* Protobuf compiler (`protoc`);
* Java SDK 8 or higher;
* Ruby 2.6;
* Node and npm.

## Build & Run

### `java-log-service`

To build the logging service, go to `java-log-service` and run:
```
./gradlew build
```

To run the service, run:
```
java -jar build/libs/java-log-service.jar
```

### `js-web-ui`

To run the web UI in, use the following command:
```
npm start
```

If the logging service `java-log-service` is up and running, the UI will display the latest log messages.

### `ruby-client`

To prepare environment for running the Ruby client, go to `ruby-client` and run:
```
# Download dependencies
bundle install
# Compile Protobuf files
rake
```

Then run the client with the following command:
```
ruby main.rb
```

The client allows to fetch and post data to the logging service.
This is done via Protobuf-powered APIs exposed by `java-log-service`.
