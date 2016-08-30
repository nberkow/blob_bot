#!/usr/bin/python

import pytumblr
import yaml
import os
import urlparse
import code
import oauth2 as oauth

if __name__ == "__main__":

	client = pytumblr.TumblrRestClient(
		'hdXV9JhkLN1tdVivsDFxWozKic48SeKuyZDHQpeGWxN74p0yJV',
		'C9iaQjBIasc7HWV2TOXTRpb5sgTkgrhJapifLmxugwzFnOugHS',
		'zgjRhxtLvXvwasWH5u5x1PnuCMsTplzONWhSe4oLn2wfNDBfhU',
		'1shevDLQ6TvFIDDq7UVpE8VExwnXePW1mZTOCTpbV2wpWl6lhz'
	)
