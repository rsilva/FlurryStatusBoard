#!/usr/bin/env ruby

require 'rubygems'
require 'httparty'
require 'json/pure'

##################################################################
# Configuration Begin
#     The README has more instructions on how to use this script
#     Flurry API: http://support.flurry.com/index.php?title=API
##################################################################

apiAccessCode = "" # Your Flurry API access code. See API url above.
apiKey = "" # Flurry API Key for the app you want to track. See API url above.
daysToShow = 30 # Number of days you want to view
graphTitle = "" # The title for the graph
graphType = "line" # Set to 'line' or 'bar'
hideTotals = false # Set to true if you want to hide totals on the y-axis, false otherwise
displayTotal = false # Set to true if you want the totals for each metric listed at the end of the graph.

# This array comtains a hash for each Flurry metric you want to track. See API url above.
metrics = [ { :metric => "ActiveUsers", :title => "Daily Active Users", :color => "green" },
            { :metric => "Sessions", :title => "Daily Sessions", :color => "blue" } ]

# Location of where you want to save the file. Using Dropbox makes things simple
outputFile = "/Users/rick/Dropbox/Status\ Board/flurry.json"

##################################################################
# Configuration End
##################################################################

months = {
   "1" => "Jan",
   "2" => "Feb",
   "3" => "Mar",
   "4" => "Apr",
   "5" => "May",
   "6" => "Jun",
   "7" => "Jul",
   "8" => "Aug",
   "9" => "Sep",
   "10" => "Oct",
   "11" => "Nov",
   "12" => "Dec"
}

endDate = Date.today - 1
startDate = (endDate - daysToShow)

dataSequences = []

metrics.each do |metric|
   url = "http://api.flurry.com/appMetrics/#{metric[:metric]}?apiAccessCode=#{apiAccessCode}&apiKey=#{apiKey}&startDate=#{startDate.to_s}&endDate=#{endDate.to_s}"
   response = HTTParty.get(url, :headers => { 'Accept' => 'application/json' })

   days = response.parsed_response["day"]

   data = []
   days.each do |datapoint|
      date = Date.parse(datapoint["@date"])
      dateString = "#{months["#{date.month}"]} #{date.day}"
      value = datapoint["@value"]
      data << { :title => dateString, :value => value }
   end

   dataSequences << { :title => metric[:title], :color => metric[:color], :datapoints => data }

   # The Flurry API is rate limited at 1 request per second. Delaying to be safe.
   sleep(1)
end

# Generate the graph
graph = {
   :graph => {
      :title => graphTitle,
      :type => graphType,
      :total => displayTotal,
      :yAxis => {
         :hide => hideTotals
      },
      :datasequences => dataSequences
   }
}

File.open(outputFile, "w") do |f|
  f.write(graph.to_json)
end

