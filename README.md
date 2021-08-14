# Entetsu Akaden Timetable

run this app.

```
$ docker build -t entetsu-akaden .
$ docker run -p 80:80 --name sinatra entetsu-akaden
```

## run on local

```
docker-compose build
docker-compose up -d
```

## run with AWS copliot

```
copilot init
```