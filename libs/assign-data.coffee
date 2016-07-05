# Author:
#   @sota1235

'use strict'

_ = require 'lodash'

module.exports = class AssignData
  ASSIGN = 'ASSIGN'

  constructor: (@robot) ->
    return

  ##
  # private method
  ##
  setData = (data) ->
    @robot.brain.set ASSIGN, data

  getData = ->
    return @robot.brain.get ASSIGN or {}

  # その部屋のタスクナンバーをインクリメントする
  increment = (room) ->
    data = @robot.brain.get ASSIGN or {}
    num = data[room]['increment'] or 1
    data[room]['increment'] = num + 1
    num + 1

  ##
  # API
  ##
  addTask: (room, userName, task) ->
    data = getData()

    roomData = data[room] or {}
    taskList = roomData[userName] or {}
    taskList[userName] =
      increment() : task
    roomData[userName] = taskList
    data[room] = roomData
    setData data

  listTask: (room, userName) ->
    getData()[room][userName]

  listAllTask: (room) ->
    getData()[room]

  completeTask: (room, userName, number) ->
    data = getData()
    delete data[room][userName][number]
    setData data

  assignTask: (room, userName, number, target) ->
    data = getData()
    task = _.get data, [room, userName, number].join ','
    delete data[room][userName][number]
    data[room][target][number] = task
    setData data
