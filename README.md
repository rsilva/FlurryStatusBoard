# Flurry Status Board

This script generates a graph of Flurry metric data for Panic's [Status Board](http://panic.com/statusboard/) using the [Flurry API](http://support.flurry.com/index.php?title=API). It is heavily inspired by [SalesBoard](https://github.com/justin/SalesBoard) by @justin.

## Installation

1. Copy this `FlurryStatusBoard` folder somewhere.
2. Open Terminal and navigate to the location chosen in step 1.
3. Install the required gems via Bundler (`bundle install`) or individually (`gem install httparty` and `gem install json_pure`)
4. Open `flurry_status_board.rb` and adjust the values inside the configuration block.
5. Open `flurry_status_board.sh` and update its path to the `flurry_status_board.rb` script to match where you've installed it
6. Open `com.rickjsilva.flurrystatusboard.plist` and update its `ProgramArguments` value to match where you are storing the `flurry_status_board.sh` file you updated in step 5.
5. Copy `com.rickjsilva.flurrystatusboard.plist` to `~/Library/LaunchAgents`
6. Open Termimal and run `launchctl load ~/Library/LaunchAgents/com.rickjsilva.flurrystatusboard.plist`. This should generate the first version of your JSON file.
7. Go to Dropbox, get a shareable link for the JSON file and add it to Status Board on your iPad.

## Contact

[Rick Silva](http://rickjsilva.com) ([@rjsmsu](https://twitter.com/rjsmsu))

## License

This project is licensed under the terms of the MIT License.
