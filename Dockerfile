FROM ubuntu:18.04

RUN apt -qq update
RUN apt install -qq -y openjdk-8-jdk > /dev/null
RUN apt -qq -y install wget unzip > /dev/null
RUN wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN mkdir -p /usr/opt/android
RUN unzip sdk-tools-linux-4333796.zip -d /usr/opt/android > /dev/null
RUN rm -rf sdk-tools-linux-4333796.zip

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV ANDROID_HOME /usr/opt/android
ENV ANDROID_NDK_HOME ${ANDROID_HOME}/ndk-bundle
ENV PATH /usr/opt/android/tools:/usr/opt/android/tools/bin:$PATH
ENV _JAVA_OPTIONS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap

RUN mkdir "$ANDROID_HOME/licenses" && echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" > "$ANDROID_HOME/licenses/android-sdk-license" && sdkmanager --licenses

RUN sdkmanager --list
RUN sdkmanager "ndk-bundle" "platform-tools" "platforms;android-28"
