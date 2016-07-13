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

  ##
  # API
  ##
  addTask: (room, userName, task) ->
    data = getData()

    taksObj =
      description: task
      assign: userName

    # Create object when data doesn't have room object
    if not _.has data, room
      data[room] =
        tasks: {}
        increment: 1

    taskNumber = _.get data, "#{room}.increment", 1

    data[room]['tasks'][taskNumber] = taksObj
    data[room]['increment'] = taskNumber + 1

    setData data

  listTask: (room, userName) ->
    roomTasks = _.get getData(), "#{room}.tasks", null
    userTasks = []
    for k, v of roomTasks
      if v.assign is userName
        userTasks.push "#{k}: #{v.description}"

    userTasks.join "\n"

  listAllTask: (room) ->
    tasks = _.get getData(), "#{room}.tasks", null
    shapedTasks = []

    for k, v of tasks
      shapedTasks.push "#{k}: #{v.description} (#{v.assign} assigned)"

    shapedTasks.join "\n"

  completeTask: (room, userName, number) ->
    data = getData()
    delete data[room]['tasks'][number]
    setData data

  assignTask: (room, userName, number, target) ->
    data = getData()
    task = _.get data, "#{room}.#{userName}.#{number}"
    if task is null
      return
    delete data[room]['tasks'][number]
    _.set data, "#{room}.#{target}.#{number}", task
    setData data

  debug: () ->
    getData()

  reset: () ->
    setData {}
