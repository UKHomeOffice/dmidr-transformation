FROM amd64/alpine:3.16

RUN mkdir transformations
RUN mkdir root/.dbt

COPY transformations transformations/
COPY transformations/profiles /root/.dbt/


RUN apk update && \
    apk upgrade && \
    apk add py-pip && \
    apk add bash

RUN pip install dbt-postgres

RUN dbt --version

RUN adduser -D -u 1001 dbt

USER 1001

WORKDIR /transformations
CMD [ "sleep", "100" ]
