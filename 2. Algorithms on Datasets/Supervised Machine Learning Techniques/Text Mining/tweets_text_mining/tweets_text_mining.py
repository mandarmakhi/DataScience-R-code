import tweepy 

#Twitter API credentials
consumer_key = "Kq4mCtnOSPiNwA9ArvYq03DE7"
consumer_secret = "aWBfVbrJWppmEy3mAbrjUHa6Y8AKU6qkCBZwA6ZpAO8BEFaoC2"
access_key = "529590041-eZXHHkluorWkdRZRWiVYW3GVBuvr3VXt84cZcDYA"
access_secret = "rqlG8jzmKTPU3bZoCwgRnOUoD5UYOx8KDjhoXySPrR3mI"


def get_all_tweets(screen_name):
    auth = tweepy.OAuthHandler(consumer_key,consumer_secret)
    auth.set_access_token(access_key, access_secret)
    api = tweepy.API(auth)
    alltweets = []	
    new_tweets = api.user_timeline(screen_name = screen_name,count=200)
    alltweets.extend(new_tweets)
    
    oldest = alltweets[-1].id-1
    while len(new_tweets)>0:
        new_tweets = api.user_timeline(screen_name = screen_name,count=200,max_id=oldest)
        #save most recent tweets
        alltweets.extend(new_tweets)
        #update the id of the oldest tweet less one
        oldest = alltweets[-1].id - 1
        print ("...%s tweets downloaded so far" % (len(alltweets)))                # tweet.get('user', {}).get('location', {})
 
    outtweets = [[tweet.created_at,tweet.entities["hashtags"],tweet.entities["user_mentions"],tweet.favorite_count,
                  tweet.geo,tweet.id_str,tweet.lang,tweet.place,tweet.retweet_count,tweet.retweeted,tweet.source,tweet.text,
                  tweet._json["user"]["location"],tweet._json["user"]["name"],tweet._json["user"]["time_zone"],
                  tweet._json["user"]["utc_offset"]] for tweet in alltweets]
    
    import pandas as pd
    tweets_df = pd.DataFrame(columns = ["time","hashtags","user_mentions","favorite_count","geo","id_str","lang","place","retweet_count","retweeted","source","text","location","name","time_zone","utc_offset"])
    tweets_df["time"]  = pd.Series([str(i[0]) for i in outtweets])
    tweets_df["hashtags"] = pd.Series([str(i[1]) for i in outtweets])
    tweets_df["user_mentions"] = pd.Series([str(i[2]) for i in outtweets])
    tweets_df["favorite_count"] = pd.Series([str(i[3]) for i in outtweets])
    tweets_df["geo"] = pd.Series([str(i[4]) for i in outtweets])
    tweets_df["id_str"] = pd.Series([str(i[5]) for i in outtweets])
    tweets_df["lang"] = pd.Series([str(i[6]) for i in outtweets])
    tweets_df["place"] = pd.Series([str(i[7]) for i in outtweets])
    tweets_df["retweet_count"] = pd.Series([str(i[8]) for i in outtweets])
    tweets_df["retweeted"] = pd.Series([str(i[9]) for i in outtweets])
    tweets_df["source"] = pd.Series([str(i[10]) for i in outtweets])
    tweets_df["text"] = pd.Series([str(i[11]) for i in outtweets])
    tweets_df["location"] = pd.Series([str(i[12]) for i in outtweets])
    tweets_df["name"] = pd.Series([str(i[13]) for i in outtweets])
    tweets_df["time_zone"] = pd.Series([str(i[14]) for i in outtweets])
    tweets_df["utc_offset"] = pd.Series([str(i[15]) for i in outtweets])
    tweets_df.to_csv(screen_name+"_tweets.csv")
    return tweets_df

srt = get_all_tweets("sachin_rt")

srt1 =srt.iloc[:,11]
##Converting into list
srt1 =list(srt1)

##Joining all the reviews into single paragraph
srt_string =' '.join(srt1)

##Removing unwanted symbols
import re
srt_string = re.sub("[^A-Za-z" "]+"," ",srt_string).lower()
srt_string = re.sub("[0-9" "]+"," ",srt_string)

##Performing tokenization
srt_words = srt_string.split(" ")

##Removing the stopwords
from nltk.corpus import stopwords
stop_words = stopwords.words('english')

srt_words = [w for w in srt_words if not w in stop_words]

##Joining all the words into single paragraph
srt_string = ' '.join(srt_words)

##Building wordcloud 
from wordcloud import WordCloud
import matplotlib.pyplot as plt

word_cloud = WordCloud(
        background_color ='black',
        width =1800,
        height=1400).generate(srt_string)
plt.imshow(word_cloud)

##Importing postive words
with open("C:\Users\Mandar\Desktop\data\assignments\text mining\IMDB\positive-words.txt","r") as pos:
    poswords = pos.read().split("\n")
    
poswords =poswords[36:]
pos_words = ' '.join([w for w in srt_words if w in poswords])

cloud_pos = WordCloud(
        background_color = 'black',
        width =1800,
        height =1400).generate(pos_words)
plt.imshow(cloud_pos)

##Importing negative words
with open("C:\Users\Mandar\Desktop\data\assignments\text mining\IMDB\negative-words.txt","r") as nos:
    negwords = nos.read().split("\n")
negwords = negwords[37:]

neg_words = ' '.join([w for w in srt_words if w in negwords])

cloud_neg = WordCloud(
        background_color ='black',
        width =1800,
        height =1400).generate(neg_words)
plt.imshow(cloud_neg)