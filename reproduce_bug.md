Originally the project was an oauth2 en vuejs gateway client separated from its backend. In order to determine where the bug is located, I reproduced the simplest possible case and note that the bug was also present in gateway oauth2 angular.
This project must be hosted on kubernetes with istio, in order to guarantee high availability of the product without Single Point Of Failure

This project is intended to show the bug that occurs when trying to scale an oauth2 gateway.
This project replaces the kubernetes loadbalancer with a traefik in order to facilitate the reproduction of the bug.

Build docker image

```bash
mvn package verify -Pprod jib:dockerBuild
```

```bash
jhipster docker-compose
```

For use service name in browser

```bash
docker run -d \
    -v /var/run/docker.sock:/tmp/docker.sock \
    -v /etc/hosts:/tmp/hosts \
    dvdarias/docker-hoster
```

Start keycloak

```bash
docker-compose up -d keycloak
```

Access to the admin of keycloak (`http://keycloak:9080` if you use `docker-hoster` or `http://localhost:9080`)
Edit client to authorize redirect to localhost (Put \* for tests)

Start the app

```bash
docker-compose up -d
```

Go to `http://localhost`, we can authenticate and everything works normally.

now we will scale the gateway to 2 to see how the application reacts to scalability

```bash
docker-compose --compatibility up -d
```

the behavior is now very random ... once authenticated we can be redirected to the page `not found`,
