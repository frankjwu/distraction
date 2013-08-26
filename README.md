# Distraction

## About
Distraction is a way to temporarily distract yourself in your terminal. It's for those moments when you're too deep in your code and need a quick break, but don't want to leave your development environment.

It uses Reddit's official API and [this unofficial Hacker News API](http://api.ihackernews.com/).

## Install

	$ gem install distraction

## Usage
	$ distraction reddit
	Displays the top ten posts on the Reddit homepage

	$ distraction reddit [subreddit]
	Displays the top ten posts in [subreddit]
	
	$ distraction fact
	Displays an interesting fact
	
	$ distraction fact open
	Displays a fact and opens up a URL with more information
	
	$ distraction vid
	Displays a random video
	
	$ distraction hn
	Displays the top ten posts on Hacker News
