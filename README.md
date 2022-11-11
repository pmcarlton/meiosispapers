# meiosispapers
## literature-scanning robot for mastodon and twitter


The repository formerly known as pubmed-rss-twitter is deprecated, and 
as of 2022-11-11, the accounts on both sites use scripts in this repository.

It can be adapted to any RSS feed by changing the feed source (see run-****-feeds.sh files).

It will work on any Mac or *nix, uses free / open software and does not depend on any proprietary or third-party services. You can customize and curate the output items at will. The principle of operation is:

- fetch the latest feed items as formatted text (using `feedstail`, a command-line RSS reader)
- change each item into a tweetable blurb (using the perl filter scripts)
- pipe the filtered output into named pipes (see run command below)
- asynchronously send one line at a time to Mastodon and Twitter (using `toot`, a command-line Mastodon client, and `oysttyer`, a command-line Twitter client)

## Requirements:


- [feedstail](https://pypi.python.org/pypi/feedstail/), an RSS watcher, which you install with `pip` above
- [oysttyer](http://oysttyer.github.io/), a command-line twitter client. 
    **you will need to create a keyfile to use oysttyer; please see the instructions**
- [toot](https://github.com/ihabunek/toot), a command-line mastodon client


## Howto:

1. Create an account for your papers feed -- **important!!** check with your 
   mastodon instance to review their bot policy. Do not create bots on 
   instances where they are not allowed and do not flood the timeline.
2. Use pip to install feedstail: `pip install feedstail`
    - caveat: as of 2022-11-11, feedstail still uses python2 so it may be 
        a headache to get running
3. Install oysttyer and toot from the locations above
4. Make the named pipes "meiotwitter.fifo" and "meiomastodon.fifo" in 
   a suitable place using `mkfifo`, and edit the scripts `meio_tweet.sh` and `meio_toot.sh` to 
   be able to find them
4. Hook the feed-gathering and feed-publishing scripts together as shown below
7. Enjoy your custom firehose of scientific literature

## Run command example:
```

>> . run-mastodon-feeds.sh &
    …feedstail is started and entries get piped into the fifo
>> < meiomastodon.fifo ./meio_toot.sh 
    …lines are read from the fifo and sent by toot to your instance
```
### Notes:

- Now with bioRχiv support!
- Once every few months or so, the bot stops—I have no idea why, but restarting it always fixes it.
- The behavior of `feedstail` seems to be to always fetch the "newest" items, so stopping and re-starting may result in repeat postings. This behavior can be filtered out in `rss-filter.pl` if you can figure out a good way.
- TODOs: easier running of the command

### Acknowledgements:

Thanks to @caseybergman for the idea and @RobLanfear for sharing implementation details

<a rel="me" href="https://mstdn.science/@meiosis_papers">🐘</a>

