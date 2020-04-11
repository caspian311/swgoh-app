# Docker Compose Examples

This purpose of the repo is to create a space to work with `docker-compose`. So this will spin up 3 docker container that need to talk with each other for everything to work. We have a web server (Nginx), an app server (Sinatra), and a database (MySQL). When all is working well, you can visit [localhost](http://localhost) and see data pulled from the database and rendered to the screen.

## Local Development

To do local development, you need to start up the containers using *docker-compose*. Once they're up, from the checked out git repo, they'll be using mount points that are allow file manipulation outside of the container to trigger updates in the running services.

### Up and running

So to get everything up and going, run this command...

```
 $ docker-compose up 
```

It should build all 3 docker containers and start them up. You can add a `-d` to the end to have it run in the background as a daemon.

There is one caveat. Sinatra is using `activerecord` which will need to migrate and seed your database before you'll have anything to show. To do that, you'll need to jump into the running docker container and run the migrate and seed commands.

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                      NAMES
...
9a9e91064bf1        mysql:5.7.22        "docker-entrypoint.s…"   11 seconds ago      Up 3 seconds        0.0.0.0:3306->3306/tcp                     db
b1e0e2c52dce        foo_app             "bundle exec rackup"     11 seconds ago      Up 3 seconds        0.0.0.0:4567->4567/tcp                     app
6bdf11948aab        nginx:alpine        "nginx -g 'daemon of…"   11 seconds ago      Up 3 seconds        0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   web
...

$ docker exec -it b1e0e2c52dce /bin/bash
root@b1e0e2c52dce:/app# bundle exec rake db:migrate db:seed
...
```
Now you should be able to visit [localhost](http://localhost) and see the site.

### Making edits/developing

Once everything is running, you can make edits to the app server by modifying the files in the *app/* directory. This will cause the *Sinatra* application to reload and your changes will be available in the deployed instance.

For the React app, it's a little more tricky. The *Nginx* server is pointing to the *web/build* directory as a mounted volume, so you can make edits there but it won't be immediately available in the app because the app needs to be compiled. So I added an *npm-watch* script to the *package.json* so you can run the following command and have the React app build as you make file changes and have that be reflected in the running application.

```
$ npm run watch
```

### Shutting it down

So at some point you'll want to shut it down. If you started it without the `-d` optional, you can just type `CTR-C`. But if you did use the `-d` option, it's running in the background, so you'll need to run this...

```
$ docker-compose down
```

### Rebuilding

Auto-reload **should work** all the time, but when it doesn't, you need to do a hard-rebuild when files change and they are mounted as volumes to the running container. To do this, run the following command.

```
$ docker-compose up --force-recreate --build
```

## Future Things

So since this is a place for learning, I thought I'd start a list of things I'd like to explore in the future...

 - [x] Enabling a better local development model (restarting all the containers everytime there's a change is not ideal)
 - [ ] Do the migration/seeding of the database automatically
 - [ ] Unit tests
 - [ ] E2E testing with running containers
 - [x] Throw in a more interesting JS example (React or Angular or something)
 - [ ] Migrate to Kubernetes for hosted environments
 - [ ] Using Terraform to push this out to AWS

