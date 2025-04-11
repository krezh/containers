# Environment variables

| Variable   | Key                           | Description                                                                       |
| ---------- | ----------------------------- | --------------------------------------------------------------------------------- |
| TZ         | Europe/Brussels               | timezone for ntpdate                                                              |
| SERVERNAME | published servername          | mandatory setting that overrules the ServerHostSettings.json entry                |
| WORLDNAME  | optional worldname            | default = world1. No real need to alter this. saves will be in a subdir WORLDNAME |
| GAMEPORT   | optional game udp port        | to overrule Port in ServerHostSettings.json config                                |
| QUERYPORT  | optional query port           | to overrule QueryPort in ServerHostSettings.json config                           |
| LOGDAYS    | optional lifetime of logfiles | overrule default of 30 days                                                       |

## Ports

| Exposed Container port | Type | Default |
| ---------------------- | ---- | ------- |
| 9876                   | UDP  | ✔️      |
| 9877                   | UDP  | ✔️      |

## Volumes

| Volume             | Container path              | Description                             |
| ------------------ | --------------------------- | --------------------------------------- |
| steam install path | /mnt/vrising/server         | path to hold the dedicated server files |
| world              | /mnt/vrising/persistentdata | path that holds the world files         |

## RCON <small>- Optional</small>

To enable RCON edit `ServerHostSettings.json` and paste following lines after `QueryPort`. To communicate using RCON protocal use the [RCON CLI](https://github.com/gorcon/rcon-cli) by gorcon.

```json
"Rcon": {
  "Enabled": true,
  "Password": "docker",
  "Port": 25575
},
```
