# 自分のslackのURL
slack_url = "https://temakizushiparty.slack.com"

  # どんな文字列があっても拾う
  # idにドットがあるとURLを展開してくれないので取り除く
module.exports = (robot) ->
  robot.hear /.+/, (msg) ->
    room = msg.envelope.room
    id = msg.message.id.replace(".","")

    # ユーザ名_channelの部屋だけウォッチ対象
          # 展開可能なURLを作成し、タイムライン表示用の部屋に投稿する
          # roomの指定で、 投稿するchannelを指定
          # 第二引数でslackのパーマネントURLを構築
    roomName = robot.adapter.client.rtm.dataStore.getChannelGroupOrDMById(room).name
    console.log(roomName)
    if roomName.match(/^times_.+/)
      robot.send {room: "#timeline_test"}, "#{slack_url}/archives/#{room}/p#{id}"
