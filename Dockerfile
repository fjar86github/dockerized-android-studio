FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y openjdk-8-jdk wget unzip lib32z1 lib32ncurses6 lib32stdc++6

# Download Android Studio
RUN wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2021.3.1.16/android-studio-2021.3.1.16-linux.tar.gz && \
    tar -xvzf android-studio-2021.3.1.16-linux.tar.gz && \
    mv android-studio /usr/local/

 # Install necessary packages
RUN apt-get update && apt-get install -y \
xfce4 \
xfce4-goodies \
tightvncserver \
xvfb \
x11vnc \
&& apt-get clean

# Optionally expose port for VNC
EXPOSE 5901


# Set environment variables
ENV ANDROID_HOME /usr/local/android-studio

# Install additional tools if needed (SDK, AVD tools, etc.)
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip sdk-tools-linux-4333796.zip -d /usr/local/android-sdk && \
    yes | /usr/local/android-sdk/tools/bin/sdkmanager --licenses

# Set entrypoint
ENTRYPOINT ["/usr/local/android-studio/bin/studio.sh"]
