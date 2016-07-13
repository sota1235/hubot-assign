# Author:
#   @sota1235

'use strict'

_ = require 'lodash'

module.exports = class AssignData
  ASSIGN = 'ASSIGN'
  ROBOT  = null

  constructor: (robot) ->
    ROBOT = robot

  ##
  # private method
  ##
  setData = (data) ->
    ROBOT.brain.set ASSIGN, data

  getData = ->
    ROBOT.brain.get(ASSIGN) or {}

  # その部屋のタスクナンバーをインクリメントする
  increment = (room) ->
    data = getData()
    num = _.get data, "#{room}.increment" or 1
    _.set data, "#{room}.increment", num + 1
    num + 1

  ##
  # API
  ##
  addTask: (room, userName, task) ->
    data = getData()

    roomData = _.get data, room, {}
    taskList = roomData[userName] or {}
    taskList[userName] =
      "#{increment()}" : task
    roomData[userName] = taskList
    data[room] = roomData
    setData data

  listTask: (room, userName) ->
    _.get getData(), "#{room}.#{userName}", null

  listAllTask: (room) ->
    _.get getData(), room, null

  completeTask: (room, userName, number) ->
    data = getData()
    delete data[room][userName][number]
    setData data

  assignTask: (room, userName, number, target) ->
    data = getData()
    task = _.get data, "#{room}.#{userName}.#{number}"
    if task is null
      return
    delete data[room][userName][number]
    _.set data, "#{room}.#{target}.#{number}", task
    setData data

  debug: () ->
    getData()
