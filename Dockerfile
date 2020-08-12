### for this example isn't necessary an extra layer, 
### but on original dockerfile that have a problem is neeeded.
### using the same image on both stages.

FROM gcr.io/google.com/cloudsdktool/cloud-sdk:alpine as artifacts

    ARG BUILD_VERSION

    WORKDIR /build

    COPY /config/my-app.conf /build

    RUN echo APP_VERSION="${BUILD_VERSION}" >> /build/my-app.conf


FROM registry.access.redhat.com/ubi8/ubi-minimal:8.2

    WORKDIR /build

    ADD script.sh /build

    COPY --from=artifacts /build/my-app.conf /build

    ENTRYPOINT [ "/build/script.sh" ]