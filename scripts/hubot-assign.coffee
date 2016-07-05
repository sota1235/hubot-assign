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

module.exports = (robot) ->
  robot.respond /assign create (.+) (.+)/i, (msg) ->
    msg.send 'hubot assign create'

  robot.respond /assign list/i, (msg) ->
    msg.send 'hubot assign list'

  robot.respond /assign list all/i, (msg) ->
    msg.send 'hubot assign list all'

  robot.respond /assign (.+) done/i, (msg) ->
    msg.send 'hubot assign done'

  robot.respond /assign (.+) (.+)/i, (msg) ->
    msg.send 'hubot assign'

  robot.respond /assign __rest/, (msg) ->
    msg.send 'hubot assign data reset'
