module.exports = function (robot) {
  robot.respond(/hoge/i, function (message) {
    message.send('fuga');
  });
};
