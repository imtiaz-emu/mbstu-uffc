# README

It's a minimal website for have a good look into our opponetns in UFFC. 
University Fantasy Football Cup based on Fantasy Premier league.

### Overview

> Root of the application contains our fixtures. Fixtures are coming from a `.json` file.

> There are 2 Links for every fixture. `Results` & `Teams`

1. Results: Will only work if the gameweek is already started. 
2. Gameweek is started: When first game kickoff time exceeds current time.
3. Teams: It's also like Results. But, if you want to see your next opponent, then it'll show you your opponents last GW's team vs your current team.

> What is not included?
- If your opponent took a hit, it will not reflect to the Points showing on top.
- Getting the number of transfers made by the opponent required multiple API calls, that why we didn't do that.

> What is expected from the contributer? 
- It's a project built within a minimal amount of time just to look and analyze the opponent team players
- Please Fork the repo and use/tweak based on your need
- If you've done any modification which will help others, please create a PR. After all, sharing is caring! 


### Installation (Run locally)

1. Install Ruby >= 2.7
2. Install dependencies. To learn how to, please check: [this](https://bokdharmik.wordpress.com/2015/06/27/%e0%a6%89%e0%a6%ac%e0%a7%81%e0%a6%a8%e0%a7%8d%e0%a6%9f%e0%a7%81%e0%a6%a4%e0%a7%87-ruby-on-rails-%e0%a6%b8%e0%a7%87%e0%a6%9f%e0%a6%be%e0%a6%aa/)
3. In your project directory run `bundle install`
4. No database required
5. go to `lib/fixtures.json` edit the file according to your need
6. run the project with `rails s` in project directory
7. If something is not working, please check step 3 to get proper insight from the log.

### Deployment

1. As there is no DB required, so use [Heroku](https://dashboard.heroku.com/login).
2. It's free
3. [Here is the guide](https://devcenter.heroku.com/articles/getting-started-with-rails5) how to setup Heroku CLI and deploy.



Enjoy! 
 