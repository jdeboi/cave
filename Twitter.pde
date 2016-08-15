

void initTwitter() {
  //Credentials
  cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("4bzdsxURiqbluY2EGqE3PbD2b");
  cb.setOAuthConsumerSecret("BA1xaelLXX47m3vOdiUBYsHCSJGiFabyDHq84gbaZyKdKgBzRK");
  cb.setOAuthAccessToken("567399817-QIyM8fyLFuYbkHsRi3RqyrYbnO6llSH7Fev3bLvZ");
  cb.setOAuthAccessTokenSecret("C0iBx6BmMKRbp2abRcBVA5l2FdMqPzATFOUnqh1o0vdf2");

  FilterQuery query = new FilterQuery("#lunacave");
  twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
  
  listener = new StatusListener() {
    @Override
      public void onStatus(Status status) {
      //println("@" + status.getUser().getScreenName() + " - " + status.getText());
      MediaEntity[] media = status.getMediaEntities();
      String url = media[0].getMediaURL();
      println(url);
      if (savedImages.size() > 10) savedImages.remove(0);
      PImage p = loadImage(url, "jpg");
      if (savedImages.size() > 0) savedImages.add(savedImages.size()-1, p);
      else savedImages.add(0, p);
      println(savedImages.size());
    }

    @Override
      public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
      println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
    }

    @Override
      public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
      println("Got track limitation notice:" + numberOfLimitedStatuses);
    }

    @Override
      public void onScrubGeo(long userId, long upToStatusId) {
      println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
    }

    @Override
      public void onStallWarning(StallWarning warning) {
      println("Got stall warning:" + warning);
    }

    @Override
      public void onException(Exception ex) {
      println("Couldn't connect: " + ex);
    }
  };
  twitterStream.addListener(listener);
  twitterStream.filter(query);
}