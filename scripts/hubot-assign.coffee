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

  robot.respond /assign list/i, (msg) ->
    room = msg.message.room
    user = msg.message.user.name

    tasks = assignData.listTask room, user

    msg.send JSON.stringify tasks

  robot.respond /assign list all/i, (msg) ->
    room = msg.message.room

    tasks = assignData.listAllTask room

    msg.send JSON.stringify tasks

  robot.respond /assign (.+) done/i, (msg) ->
    room    = msg.message.room
    user    = msg.message.user.name
    taskNum = mgs.match[1]

    assignData.completeTask room, user, taskNum

    msg.send 'hubot assign done'

  robot.respond /assign (.+) (.+)/i, (msg) ->
    room    = msg.message.room
    user    = msg.message.user.name
    taskNum = msg.match[1]
    target  = msg.match[2]

    if /^create/i.test taskNum
      return

    assignData.assignTask room, user, taskNum, target

    msg.send 'hubot assign'

  robot.respond /assign __reset/, (msg) ->
    msg.send 'hubot assign data reset'

  robot.respond /assign debug/, (msg) ->
    msg.send JSON.stringify assignData.debug()
