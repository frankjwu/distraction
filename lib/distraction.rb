require 'net/http'
require 'json'

class Distraction
	# display the top link from TIL
	def self.reddit_fact(open)
		begin
			ping = Net::HTTP.get(URI('http://www.reddit.com/r/todayilearned.json?limit=5'))
			listing = JSON.parse(ping)
			listing = listing['data']['children']

			# check if NSFW
			result = listing.each do |l|
				break l['data'] if (!l['data']['over_18'])
			end
			result_title = result['title'].gsub('TIL', 'Did you know...')
			result_domain = result['domain']
			result_url = result['url']

			case open
			when true
				puts result_title + "\n\nOpening link from (#{result_domain}) in 10 seconds... CTRL + C to quit."
				sleep(10)
				`open #{result_url}`
			when false
				puts result_title + "\n\nYou can type 'distraction til open' to open the link in a browser."
			end

		rescue
			puts "Reddit isn't responding right now. Let's try again later."
		end
	end

	# display the top ten links on Reddit frontpage
	def self.reddit_top(subreddit)
		begin
			ping = Net::HTTP.get(URI('http://www.reddit.com/r/' + subreddit + '.json?limit=10'))
			listing = JSON.parse(ping)
			listing = listing['data']['children']

			listing.each_with_index do |l, i|
				line = " " + (i+1).to_s.rjust(2, " ") + ".  " + l['data']['title'] + " (" + l['data']['domain'] + ")"
				if l['data']['over_18']
					line = line + " (NSFW)"
				end
				puts line
			end
			puts "\nWhich link would you like to open?"
			story = STDIN.gets.chomp()
			story = story.to_i

			if ((story < 11) && (story > 0))
				result = listing[story-1]['data']
				result_domain = result['domain']
				result_url = result['url']
				puts "\nOpening link from (#{result_domain}) in 5 seconds... CTRL + C to quit."
				sleep(5)
				`open #{result_url}`
			else
				puts "Come on, son."
			end
		rescue
			puts "Reddit isn't responding right now. Let's try again later."
		end
	end

	# display the top ten links on HN homepage
	def self.hn()
		begin
			ping = Net::HTTP.get(URI('http://api.ihackernews.com/page/'))
			listing = JSON.parse(ping)
			listing = listing['items']
			i = 1
			while (i < 11)
				line = "  " + i.to_s.rjust(2, " ") + ".  " + listing[i]['title']
				i += 1
				puts line
			end
			puts "\nWhich article would you like to open?"
			story = STDIN.gets.chomp()
			story = story.to_i

			if ((story < 11) && (story > 0))
				result_url = listing[story]['url']
				if result_url.start_with?("/comments/")
					result_url = "http://news.ycombinator.com/item?id=" + listing[story]['id']
				end
				puts "\nOpening link (#{result_url}) in 5 seconds... CTRL + C to quit."
				sleep(5)
				`open #{result_url}`
			else
				puts "Come on, son."
			end
		rescue
			puts "HN isn't responding right now. Let's try again later."
		end
	end
end
