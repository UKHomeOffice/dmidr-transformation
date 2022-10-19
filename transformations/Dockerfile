FROM amd64/alpine:3.16

RUN mkdir transformations
RUN mkdir root/.dbt

COPY . transformations/
COPY ./profiles /root/.dbt/


RUN apk update && \
    apk upgrade && \
    apk add py-pip && \
    apk add bash

RUN pip install dbt-postgres

RUN dbt --version

WORKDIR /transformations
ENTRYPOINT [ "dbt" ]
