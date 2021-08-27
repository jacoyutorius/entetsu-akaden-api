# Entetsu Akaden API

## /info/:station

赤電の各駅の情報を返します。

|param|description||
|:-|:-|:-|
|station|駅ID|必須|

https://kri4wdscma.ap-northeast-1.awsapprunner.com/info/sukenobu
```
{
  staff: true,
  public_telephone: true,
  version: 2021,
  address: "浜松市中区助信町52-1",
  toilet: true,
  toilet_multipurpose: true,
  elevator: true,
  pass: true,
  daily_parking: false,
  bycicle_parking: true,
  coin_locker: false,
  business_hours: "7:10-19:40（日祝日8:10-19:40） 窓口締切り時間（11:54-12:26） ※2020年4月15日（水）より当面の間、窓口閉鎖",
  taxi: "駅東側乗り場有り",
  wheelchair: true,
  monthly_parking: false,
  phone: "053-461-7730 ※電車到着時等電話に出られない場合もございます。",
  aed: false
}
```

## /timetables/:station/:detection/:week

赤電の時刻表を返します。

|param|description||
|:-|:-|:-|
|station|駅ID|必須|
|detection|進行方向。上り(upto)、下り(downto)|必須|
|week|平日(weekday)または土日祝(weekend)|必須|

https://kri4wdscma.ap-northeast-1.awsapprunner.com/timetables/hachiman/upto/weekday
```
[
  {
    version: 2021,
    formation: 2,
    detection: "upto",
    time: "10:04",
    type: "weekday"
  },
  {
    version: 2021,
    formation: 2,
    detection: "upto",
    time: "10:16",
    type: "weekday"
  },
  {
    version: 2021,
    formation: 2,
    detection: "upto",
    time: "10:28",
    type: "weekday"
  },
```

## /fare/:station/:to

指定した駅間の乗車料金と乗車時間を返します。

|param|description||
|:-|:-|:-|
|station|駅ID|必須|
|to|駅ID|必須|

https://kri4wdscma.ap-northeast-1.awsapprunner.com/fare/sukenobu/hamakita

```
{
  version: 2021,
  required: "16分",
  fare_adult: "280円",
  fare_child: "140円"
}
```

--

# usage

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