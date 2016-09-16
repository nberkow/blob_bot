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

	text = " ".join(open(sys.argv[1], 'r').readlines())
	words = re.split("\s", text)
	prohibited = ['the', 'MarieFrances', 'mike', 'tablishment']
	regex = re.compile('[^a-zA-Z]')

	wset = set()
	for w in words:
		w = regex.sub('', w)
		if len(w) > 2 and w not in prohibited:
			wset.add(w)
	



	REQUEST_TOKEN_URL = 'http://www.tumblr.com/oauth/request_token'
	AUTHORIZATION_URL = 'http://www.tumblr.com/oauth/authorize'
	ACCESS_TOKEN_URL = 'http://www.tumblr.com/oauth/access_token'
	CONSUMER_KEY = 'hdXV9JhkLN1tdVivsDFxWozKic48SeKuyZDHQpeGWxN74p0yJV'
	CONSUMER_SECRET = 'C9iaQjBIasc7HWV2TOXTRpb5sgTkgrhJapifLmxugwzFnOugHS'

	client = pytumblr.TumblrRestClient(
	    CONSUMER_KEY,
	    CONSUMER_SECRET,
	    "2ySYcIiNvJ8jgYvYiJ7ZSJ17ZekpqZOjqi7xxoRTDaH21RxUmV",
	    "Ehh8UDqzbNb9XK0FBDsPqvWUu4UBF9mRpFbCcAFyDWcpHroL3y"
	)	

	def make_and_post():
		rtags = random.sample(wset, 3)
		subprocess.call(["Rscript",  "random_plot.R"])
		client.create_photo('marlykrushkova', state="published", tags=rtags, data="/home/ubuntu/tbot/random_plot.png")

	s = 60 * 60 * 48
	noise = random.randint(-18,18) * 60 * 60

	while True:
		print "attempting a post!"
		make_and_post()
		time.sleep(s + noise)





