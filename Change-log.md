# Total RP 2 version 1.032 (for patch 6.1)

A change made by Blizzard to the chanels encoding required me to work on the broadcast chanel (aka `xtensiontooltip2`) to make it work with patch 6.1. **All previous versions will no longer be able to use the broadcast protocol** (to see players on the map, hidden stashes, homes, signposts). We (Telkostrasz helped me on this release) took this opportunity to work on a new broadcast protocol for both Total RP 2 and Total RP 3. 

## Total RP 3 compatibility

* Total RP 2 is now using a new broadcast protocol (needed for 6.1) created for both Total RP 3 and 2. Total RP 3 will be updated shortly after Total RP 2 to support the new protocol. This protocol allows Total RP 3 and Total RP 2 to use the same player location system. You will now be able to see Total RP 3 users (version 1.0 minimum) on your world map and Total RP 3 users will be able to see you their map (reminder : you can disable the location feature in the settigns, in the interface tab).

* As Total RP 3 now has the player location feature, Total RP 2 will not answer location requests if Total RP 3 (version ≥ 1.0) is running to prevent duplicates. 

## Garrison's improvements

I improved the way the map related features handle garrisons. Now, you will only see location, stashes and signposts for players in your group/raid. As there is no way to know if you are in your own garrison or the group leader garrison, you will see everyone in your group, even if they are in their own garrison. 

* Also, as the garrison map represent a small area, the coordonates system is way more precise than on other maps, so keep that in mind when looking for a stash. In Total RP 3, the location system will be aware of the difference in the size area and it won't be a problem anymore.*

## Bug fixes

* When displaying players on the world map, the points representing the players will now correctly disappear when changing zones.

* Players with the map open will now appear on the map (previously, players with the map open did not respond to location request, as the map could go wild. This situation is now correctly handled).

* Fixed an issue when saving an empty description or history.