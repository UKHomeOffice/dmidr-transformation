# Deployment Process

## Pushing a new version of the Docker image

1. Create a pull request with your changes.
1. Add a label to the pull request, one of major, minor or patch, depending on your changes.
The label will determine how the version number is incremented, following `major.minor.patch`.
The pipeline will fail without this label and a new image will not be pushed to the repository.
1. After the tests have passed, merge the pull request.
1. A [Github actions workflow][push_image_workflow] will rerun the tests.
If they pass, it will build the docker image.
It will then push the image to the [quay repository][quay_repository], tagged with the new version number and create a matching tag in the github repository.
1. The creation of a tag in the github repository will trigger the [drone pipeline][drone_pipeline] to run and deploy the image to the kubernetes cluster.

# Getting started
1. Set up virtual env

```
$ make build
$ make db-setup
```

2. Run basic extraction pipeline

```
$ make serve
```

3. Examine results in Transformation Database

```
$ make shell-transform
$ psql -Upostgres
$ \c transformation
$ select * from transformation.audit_event;
```

4. Run tests. Tests are output locally to a ./transformations/targets/ directory. You can view all runs, all compiled SQL, and all error, warn, and failure exceptions within there.
```
$ make test
```