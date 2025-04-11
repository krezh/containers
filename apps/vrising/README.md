# vrising-server

Container for running V-Rising dedicated on Debian Linux with Wine.

## Usage

Persistent storage should be mounted to /savedata and /serverdata

## Environment Variables

| Name                 | Description                                                                                                             | Default           | Required |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------- | ----------------- | -------- |
| SERVER_NAME          | Name for the Server                                                                                                     | None              | True     |
| SERVER_PASSWORD      | Password for the server                                                                                                 | None              | True     |
| GAME_PORT            | Port for server connections                                                                                             | 27015             | False    |
| QUERY_PORT           | Port for steam query of server                                                                                          | 27016             | False    |
| DESCRIPTION          | Description for server                                                                                                  | None              | False    |
| BIND_ADDRESS         | IP address for server to listen on                                                                                      | 0.0.0.0           | False    |
| HIDE_IP              | Hide IP on server browser                                                                                               | True              | False    |
| LOWER_FPS_WHEN_EMPTY | Lower server FPS when server is empty                                                                                   | True              | False    |
| SECURE               | Enable Steam VAC                                                                                                        | True              | False    |
| EOS_LIST             | Register on EOS list server or not. The client looks for servers here by default, due to additional features available. | True              | False    |
| STEAM_LIST           | Register on Steam list server or not.                                                                                   | False             | False    |
| GAME_PRESET          | Load a ServerGameSettings preset.                                                                                       | StandardPvP       | False    |
| DIFFICULTY           | Load a GameDifficulty preset.                                                                                           | Difficulty_Normal | False    |
| SAVE_NAME            | Name of save file/directory. Must be a valid directory name.                                                            | vrising_world     | False    |
