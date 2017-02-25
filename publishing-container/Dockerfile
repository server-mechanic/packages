FROM fedora:25

ENV USER_UID=1000

RUN dnf -y install findutils dpkg dpkg-dev createrepo
RUN dnf -y install tar
RUN adduser -u $USER_UID build

COPY assets/update-repos.sh /update-repos.sh

VOLUME /build

USER $USER_UID

CMD [ "/update-repos.sh", "/build" ]
