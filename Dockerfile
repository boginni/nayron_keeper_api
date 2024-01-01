# Use the official Dart image as a parent image
FROM dart:stable AS build

# Set the working directory
WORKDIR /app

# Copy only files required by pubspec.* to download dependencies
COPY pubspec.* ./
RUN dart pub get

# Copy the rest of the application code
COPY lib .


# Build the application
RUN dart compile exe bin/game_server.dart -o bin/game_server

# Build minimal serving image from AOT-compiled `/server` and required system libraries and certificates
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

# Include any assets or static files if needed
# COPY --from=build /app/assets/ /app/assets/

# Expose the port used by your application
EXPOSE 8080

# Run the server
CMD ["/app/bin/server"]
