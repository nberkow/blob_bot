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

	# Grab random words from a selected text to use as tags
	text = " ".join(open(sys.argv[1], 'r').readlines())
	words = re.split("\s", text)
	regex = re.compile('[^a-zA-Z]')

	wset = set()
	for w in words:
		w = regex.sub('', w)
		if len(w) > 2:
			wset.add(w)
	

	# tumblr authentication details
	# details about setting up tokens available from tumblr:
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

		# set the tags
		rtags = random.sample(wset, 3)
	
		# run the R script to make some blobs
		subprocess.call(["Rscript",  "random_plot.R"])

		# post
		client.create_photo('myBot', state="published", tags=rtags, data="/home/ubuntu/tbot/random_plot.png")


	# Run forever, posting every day and a half or so
	s = 60 * 60 * 48
	noise = random.randint(-18,18) * 60 * 60

	while True:
		print "attempting a post!"
		make_and_post()
		time.sleep(s + noise)





