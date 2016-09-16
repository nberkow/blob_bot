#!/usr/bin/python

import pytumblr
import yaml
import os
import urlparse
import code
import oauth2
import subprocess
import random
import time 
import sys
import re
import random

if __name__ == "__main__":


	# A source text for randomly selecting tags
	text = " ".join(open(sys.argv[1], 'r').readlines())
	words = re.split("\s", text)
	regex = re.compile('[^a-zA-Z]')

	wset = set()
	for w in words:
		w = regex.sub('', w)
		wset.add(w)
	
	# tumblr authentication tokens
	# authentication details are available from tumblr once you register an account
	# https://www.tumblr.com/docs/en/api/v2
	REQUEST_TOKEN_URL = 'http://www.tumblr.com/oauth/request_token'
	AUTHORIZATION_URL = 'http://www.tumblr.com/oauth/authorize'
	ACCESS_TOKEN_URL = 'http://www.tumblr.com/oauth/access_token'
	CONSUMER_KEY = sys.argv[2]
	CONSUMER_SECRET = sys.argv[3]

	client = pytumblr.TumblrRestClient(
	    CONSUMER_KEY,
	    CONSUMER_SECRET,
	    sys.argv[4],
	    sys.argv[5]
	)	

	def make_and_post():
		rtags = random.sample(wset, 3)
		subprocess.call(["Rscript",  "random_plot.R"])
		client.create_photo('my photo', state="published", tags=rtags, data="./random_plot.png")

	s = 60 * 60 * 48
	noise = random.randint(-18,18) * 60 * 60

	while True:
		print "attempting a post!"
		make_and_post()
		time.sleep(s + noise)





