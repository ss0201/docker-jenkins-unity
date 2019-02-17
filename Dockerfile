FROM jenkins/jenkins:lts
USER root

RUN cd ~ && \
    wget -q https://beta.unity3d.com/download/dad990bf2728/UnitySetup-2018.2.7f1 && \
    chmod 755 ./UnitySetup-2018.2.7f1 && \
    apt-get update && \
    apt-get -y install libarchive13 && \
    apt-get -y install libgtk2.0 && \
    apt-get -y install libsoup2.4 && \
    yes | ./UnitySetup-2018.2.7f1 --unattended --components=Unity --install-location=/opt/Unity && \
    apt-get -y install libglu1-mesa && \
    apt-get -y install libgconf2-4

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]

