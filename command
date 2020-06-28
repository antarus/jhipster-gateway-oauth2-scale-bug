npm install -g generator-jhipster
npm install -g generator-jhipster-vuejs

mkdir -p jhipster
cd jhipster


Generate an app
gateway with oauth2 and hazelcast
```bash
jhipster 
```

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


Edit the docker-compose and replace `machine_name` file with the name of your machine which you can find in` / etc / hosts`


Start keycloak
```bash
docker-compose up -d keycloak
```
Access to the admin of keycloak (`http://keycloak:9080` if you use `docker-hoster` or `http://localhost:9080`)
Edit client to authorize redirect to localhost (Put * for tests)

Start the app
```bash
docker-compose up -d
```

Go to `http://machine_name`, we can authenticate and everything works normally.


now we will scale the gateway to 2 to see how the application reacts to scalability

```bash
docker-compose --compatibility up -d
```