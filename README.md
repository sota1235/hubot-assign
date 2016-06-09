hubot-assign
====

Hubot script for assigning task to team member.

### Description

### Demo

### Requirement

- CoffeeScript

### Usage

```
$ hubot assign sota1235 プルリクエスト#10をレビューする
hubot > @sota1235 「プルリクエスト#10をレビューする」をやってね

$ hubot assign list
hubot > @sota1235は1個タスクがあります
hubot > 1 プルリクエスト#10をレビューする

$ hubot assign list all
huobt > [sota1235のタスク]
hubot > 1 プルリクエスト#10をレビューする
hubot > [nitamirのタスク]
hubot > 1 Issue#11にコメントする
hubot > 2 プルリクエスト#11をレビューする

$ hubot assign 1 done
hubot > タスク「プルリクエスト#10をレビューする」は完了したんだね！お疲れ！
hubot > 残りのタスクは0個だよ！

$ hubot assign list
hubot > @sota1235 今は何もタスクはないよ
```

### Install

```shell
$ npm i -S hubot-assign
```

#### Edit `external-script.json`

```json
["hubot-assign"]
```

### Contribution

### Licence

This software is released under the MIT License, see LICENSE.txt.

## Author

[@sota1235](https://github.com/sota1235)
