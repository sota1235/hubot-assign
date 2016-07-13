# Description:
#   タスク管理をざっくりやろう
#
# Commands:
#   hubot assign create $<username> Task description -- タスクを作成し、ユーザにアサインする
#   hubot assign list -- 自分のタスク一覧を表示する
#   hubot assign list all -- 全員のタスク一覧を表示する
#   hubot assign $<task number> done -- タスクを完了する
#   hubot assign $<task number> $<username> -- タスクを別のユーザにアサインする
#
# Author:
#   @sota1235

AssignData = require '../libs/assign-data'

module.exports = (robot) ->
  assignData = new AssignData robot

  robot.respond /assign create (.+) (.+)/i, (msg) ->
    userName = msg.match[1]
    task     = msg.match[2]
    room     = msg.message.room

    assignData.addTask room, userName, task

    msg.send "#{userName}にタスク：#{task}を追加しました"

  robot.respond /assign list$/i, (msg) ->
    room = msg.message.room
    user = msg.message.user.name

    tasks = assignData.listTask room, user

    msg.send "#{user}のタスク一覧です"
    msg.send tasks

  robot.respond /assign list all/i, (msg) ->
    room = msg.message.room

    tasks = assignData.listAllTask room

    msg.send "#{room}の全タスク一覧です"
    msg.send tasks

  robot.respond /assign (.+) done/i, (msg) ->
    room    = msg.message.room
    user    = msg.message.user.name
    taskNum = msg.match[1]

    assignData.completeTask room, user, taskNum

    msg.send "タスク No.#{taskNum}を完了しました"

  robot.respond /assign ([0-9]+) (.+)/i, (msg) ->
    room    = msg.message.room
    user    = msg.message.user.name
    taskNum = msg.match[1]
    target  = msg.match[2]

    assignData.assignTask room, user, taskNum, target

    msg.send 'hubot assign'

  robot.respond /assign __reset/i, (msg) ->
    assignData.reset()
    msg.send 'hubot assign data reset'

  robot.respond /assign debug/i, (msg) ->
    msg.send JSON.stringify assignData.debug()
