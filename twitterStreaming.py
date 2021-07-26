import tweepy
import pandas as pd
import json

#Import file containing credentials
import credentials

#print all columns
pd.options.display.max_columns = None

#Authenticate
class twitter_authentication:    
    def authenticate(self):
        
        auth = tweepy.OAuthHandler(credentials.CONSUMER_KEY, credentials.CONSUMER_SECRET)
        auth.set_access_token(credentials.ACCESS_TOKEN, credentials.ACCESS_TOKEN_SECRET)
        return auth
    

#Create a class inheriting from StreamListener
class MyStreamListener(tweepy.StreamListener):
    
    """
    This is a basic listener that just prints received tweets to stdout.
    """
    
    def __init__(self, fetched_tweets_filename):
        self.fetched_tweets_filename = fetched_tweets_filename

    def on_data(self, data):
        try:
            print(data)
            #Store the tweets in a file
            with open(self.fetched_tweets_filename, 'a') as tf:
                tf.write(data)
            return True
        except BaseException as e:
            print("Error on_data %s" % str(e))
        return True
          
    def on_error(self, status):
        if status == 420:
            # Returning False on_data method in case rate limit occurs.
            return False
        print(status)



#Using that class create a Stream object

class Streaming():
    def __init__(self):
        self.twitter_authenticator = twitter_authentication()
        
        
    def start(self, fetched_tweets_filename, keyword_list):
        auth = self.twitter_authenticator.authenticate()
        listener = MyStreamListener(fetched_tweets_filename)
        myStream = tweepy.Stream(auth, listener)
        
        #Filter the hashtags
        myStream.filter(track=keyword_list)
    
    
#Connect to the Twitter API using the Stream.

if __name__ == "__main__":
    
    '''
    keylist = ["#HappyBirthdayDada"]
    fetched_tweets_filename = 'tweets.txt'
    
    #Start streaming
    stream = Streaming()  
    stream.start(fetched_tweets_filename, keylist)
    
    
    
    '''
    
    #Reading the extracted tweets
    pdobj = pd.read_csv("tweets.txt",sep = "\n", header= None)
    pdobj.columns = ['Tweets']
    
    #print the first element of pdobj
    
    #print(pdobj['Tweets'][0]) 
    #print(type(pdobj['Tweets'][0]))
    
    
    

    #Convert the string into Dictionary
    
    for i in range(len(pdobj['Tweets'])):
       pdobj['Tweets'][i] = json.loads(pdobj['Tweets'][i])
      
  
    print(type(pdobj['Tweets'][0]))
      
    #Lets make a dataframe now
    #Exploring the options for all the possible columns
    #print(pdobj['Tweets'][0].keys())
    
    
    
    
    #Dataframe
    df = pd.DataFrame(data=[tweet['id'] for tweet in pdobj['Tweets']], columns=['Tweet ID'])
    df['Tweet length'] = [len(tweet['text']) for tweet in pdobj['Tweets']]
    df['User'] = [tweet['user'] for tweet in pdobj['Tweets']]
    df['Language'] = [tweet['lang'] for tweet in pdobj['Tweets']]
    df['DateTime'] = [tweet['created_at'] for tweet in pdobj['Tweets']]
    df['Source'] = [tweet['source'] for tweet in pdobj['Tweets']]
  
    
    print(df.head(10))
    