###
# Sample test
###

assert = require 'assert'

describe 'Sample test', ->
  it '1 equal 1', (done) ->
    assert 1, 1
    done()
