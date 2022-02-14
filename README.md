# Entetsu Akaden API

## /info/:station

赤電の各駅の情報を返します。

|param|description||
|:-|:-|:-|
|station|駅コード|必須|

https://akaden.jacoyutorius.net/info/sukenobu
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
|station|駅コード|必須|
|detection|進行方向。上り(upto)、下り(downto)|必須|
|week|平日(weekday)または土日祝(weekend)|必須|

https://akaden.jacoyutorius.net/timetables/hachiman/upto/weekday
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
|station|駅コード|必須|
|to|駅コード|必須|

https://akaden.jacoyutorius.net/fare/sukenobu/hamakita

```
{
  version: 2021,
  required: "16分",
  fare_adult: "280円",
  fare_child: "140円"
}
```
## 駅コード

|駅コード|駅名|
|:-|:-|
|shinhamamatsu|新浜松|
|daiichi-dori|第一通り|
|enshubyoin|遠州病院|
|hachiman|八幡|
|sukenobu|助信|
|hikuma|曳馬|
|kamijima|上島|
|jidosyagakkomae|自動車学校前|
|saginomiya|さぎの宮|
|sekishi|積志|
|nishigasaki|西ヶ崎|
|komatsu|小松|
|hamakita|浜北|
|misonochuokoen|美薗中央公園|
|kobayashi|小林|
|shibamoto|芝本|
|gansuiji|岩水寺|
|nishikajima|西鹿島|

---

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

## サービスの一時停止

```
$ copilot svc pause
Found only one deployed service entetsu-akaden in environment test
Sure? Yes
Note: Your service will be unavailable while paused. You can resume the service once the pause operation is complete.
✔ Paused service entetsu-akaden in environment test..
Recommended follow-up action:
    Run `copilot svc resume -n entetsu-akaden` to start processing requests again.
```

## サービスの削除

*2022-02-15サービス停止済*

```
$ copilot app delete
Sure? Yes
✘ Failed to delete service entetsu-akaden from environment test: wait until stack entetsu-akaden-test-entetsu-akaden delete is complete: ResourceNotReady: failed waiting for successful resource state.
✘ execute svc delete: delete service: wait until stack entetsu-akaden-test-entetsu-akaden delete is complete: ResourceNotReady: failed waiting for successful resource state
```
