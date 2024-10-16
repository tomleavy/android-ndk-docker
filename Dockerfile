FROM ubuntu:20.04

RUN apt -qq update
RUN apt install -qq -y openjdk-17-jdk > /dev/null
RUN apt -qq -y install wget unzip > /dev/null
RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
RUN mkdir -p /usr/opt/android/cmdline-tools
RUN unzip commandlinetools-linux-11076708_latest.zip -d /usr/opt/android/cmdline-tools > /dev/null
RUN rm -rf commandlinetools-linux-11076708_latest.zip
RUN mv /usr/opt/android/cmdline-tools/cmdline-tools /usr/opt/android/cmdline-tools/latest
RUN update-alternatives --config java

ENV ANDROID_HOME /usr/opt/android
ENV ANDROID_NDK_HOME ${ANDROID_HOME}/ndk/27.1.12297006
ENV PATH /usr/opt/android/cmdline-tools/latest:/usr/opt/android/cmdline-tools/latest/bin:$PATH

RUN which java
RUN mkdir "$ANDROID_HOME/licenses" && echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" > "$ANDROID_HOME/licenses/android-sdk-license" && sdkmanager --licenses

RUN sdkmanager --list
RUN sdkmanager "ndk;27.1.12297006" "platform-tools" "platforms;android-33"
