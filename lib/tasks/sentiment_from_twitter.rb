class Tasks::SentimentFromTwitter

  def self.execute(query)

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = 'consumer_key'
      config.consumer_secret = 'consumer_secret'
      config.access_token = 'access_token'
      config.access_token_secret = 'access_token_secret'
    end

    tweets = client.search(query, lang: "en").take(20).map{|tweet| tweet.text}

    comprehend = Aws::Comprehend::Client.new(
      region: 'us-west-2',
      access_key_id: 'access_key_id',
      secret_access_key: 'secret_access_key'
      )

    resp = comprehend.batch_detect_sentiment({
      text_list: tweets,
      language_code: "en"
      })

    res = {
      positive: resp.result_list.map{|res| res.sentiment_score.positive}.sum / resp.result_list.size,
      negative: resp.result_list.map{|res| res.sentiment_score.negative}.sum / resp.result_list.size,
      neutral: resp.result_list.map{|res| res.sentiment_score.neutral}.sum / resp.result_list.size,
      mixed: resp.result_list.map{|res| res.sentiment_score.mixed}.sum / resp.result_list.size
    }

    puts "positive : #{res[:positive]}"
    puts "negative : #{res[:negative]}"
    puts "neutral : #{res[:neutral]}"
    puts "mixed : #{res[:mixed]}"
  end
end
