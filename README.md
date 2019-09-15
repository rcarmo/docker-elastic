# docker-elastic

This is a quick and dirty container to allow me to test the linux version of Elasticsearch on my MacBook and figure out bits of the internals from first principles.

If you need a _real_ Elasticsearch container, please use [the official images](https://www.docker.elastic.co/) instead.

## ToDo/Improvements

Things that can be improved here, since right now the container is used as a volatile test fixture (i.e., I don't persist data outside it) and runs internally under the `www-data` UID:

* [ ] Move to `s6-init` for nicer management, proper UIDs, etc.
* [ ] Override default configuration
* [ ] Expose sane volumes for data, config, etc.
