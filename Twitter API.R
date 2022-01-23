library(rtweet)

appname <- "DS6306"
api_k <- "XtMZJYKTOUKWbcv4WEzTyg8yT"
api_s <- "QQgYlwLgDzrid9DoIAtNylW2qQz85uIGxnIYiGB0Ru6f4tAWgG"
access_t <- "882430772006834177-LnZAmCrY12JOw8czpfmDrr5OnWyF7w0"
access_s <- "DjEwRs0TzRNUFtWWgUNwo1cHsraA60XbxYrgdrmqoTOTf"

twitter_token <- create_token(app = appname,consumer_key = api_k, consumer_secret = api_s, access_token = access_t, access_secret = access_s)
post_tweet("testing this")

rt <- search_tweets(
  "APPL", n = 30, include_rts = FALSE
)

rt
library(twitteR)

setup_twitter_oauth(api_k, api_s, access_t, access_s)
