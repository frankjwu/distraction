require 'net/http'
require 'json'

class Distraction
	def self.reddit_TIL(open)
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
				puts result_title + "\n\nHint: type 'distraction til open' to open the link in a browser."
			end

		rescue
			puts "Reddit isn't responding right now. Let's try again later."
		end
	end
end
