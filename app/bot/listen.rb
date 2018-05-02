require "facebook/messenger"
include Facebook::Messenger
Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

# message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
# message.sender      # => { 'id' => '1008372609250235' }
# message.sent_at     # => 2016-04-22 21:30:36 +0200
# message.text        # => 'Hello, bot!'
Bot.on :message do |message|
  puts "Received '#{message.inspect}' from #{message.sender}"
  case message.text
  when /hello/i, /salut/i, /bonjour/i, /yep/i
    message.reply(
      text: 'Hello, human!',
      quick_replies: [
        { content_type: 'text', title: 'Hello, bot!', payload: 'yep'},
        { content_type: 'text', title: 'nope', payload: 'nope'}
      ]
    )
  when /nope/i
    message.reply(
      text: 'see you!',
      quick_replies: [
        { content_type: 'text', title: 'bye', payload: 'yep'},
        { content_type: 'text', title: 'something else', payload: 'nope'}
      ]
    )
  when /band/i
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Did human like it?',
          buttons: [
            { type: 'postback', title: 'Yes', payload: 'HUMAN_LIKED' },
            { type: 'postback', title: 'No', payload: 'HUMAN_DISLIKED' }
          ]
        }
      }
    )
    when /articles/i
    @articles = Article.all
      elements = @articles.map do |article|
        {
          title: article.title, # helpers.image_path('logo.jpg'),
          buttons: [
            {
              type: 'postback',
              title: 'Pricey article?',
              payload: "article_#{article.id}"
            }
          ]
        }
      end
      message.reply(
        attachment: {
          type: 'template',
          payload: {
            template_type: 'generic',
            elements: elements.sample(10)
          }
        }
      )
    end
Bot.on :postback do |postback|
  case postback.payload
  when 'HUMAN_LIKED'
    text = 'That makes bot happy!'
  when 'HUMAN_DISLIKED'
    text = 'Oh.'
  end

  postback.reply(
    text: text
  )
  end
end

