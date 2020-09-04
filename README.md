# TRZ (The Resident Zombie) - App

# Job

# Codeminer42 - Mobile Software Engineer

App starts on main.dart file

## Boot - App start strategy

The first thing is define a start route
The first thing the app do is check for data stored on device if it's true, i made a call to getItems on server
to avoid problems with server reset or other sync problems.
After that is defined the initial route and app continue render screens.
In case of user dont have data on his device a register screen is presented.

## User position

Before create a new user the app ask for permission to use device sensor location, if the user allows the start to monitoring his position and save
periodically(about 100 meters change from lastlocation). If dont then app use the defauilt location(codminer42 SP adress).

## Maingame - MapScreen

After boot section app show an screen with a map and the last knowing position of this user with a marker, if user start to change his position the map is updated
In the bottom side of this screeen is showed cards with all players in the world, this cards are presented using PageView and has an listener so when the current card is changed the maps is updated corresponding user position in the card.
The marker on map has an tap listener if tapped show a default maps indicator with "see profile" title and user name an tap again Push on screen the profile screen

## Profile screen

A simple screen data presented is based on route arguments passaed by navigator, if arguments its null i assume the user in question is the player not oyther survivor. So i use the player id to call your basic profile.
If player seeing another survivor screen is showed on actions button options a trade action all other option is always showed.

- See itens => push itens screen
- Change itens => push tradeitens screen
- See on map => pop to main game screen (map)
  On bottomsheet has an button to report infection, after is called is showed an alert with result

## All players

This screen is simple and just show an list with results of all players call on api

## Trade itens

I think in this screen the mais chalange was the UX but i've been made about 4 different layouts.
About data dart streans do the job, anyway it would be worth refactoring here, but looking at the deadline I believe a good solution has been given
using the strategy is possible check for point values and other checkes before mak the api call

## App organization

- Appstate store all needed vars and streans if you need something be acessed by other classes just put here
- It's my first time using RxDart but i found it very easy and the result was far superior for me when using other strategies for streans
- Provider is another great library and helpfull to passa down the trhree things the will be accessed in a global way
- I started with a applocalization but was impossible for me put all string there

## Tasks check list

- [x] Sign in as survivor
- [x] Update your survivor location
- [ ] List of contacts
      Looking at the api it was not clear how to do this. In addition it was possible to make exchanges only when close
- [x] Flag survivor as infected
- [x] An infected survivor cannot trade with others, cannot access/manipulate their inventory
- [x] Trade items **but for it to happen they should be near from one another**
- [x] All trades must respect the price table
- [x] Both sides of the trade should offer the same amount of points
- [x] Flutter
- [x] You're not allowed to use WebView strategy
- You should send a README explaining how decisions were made;
- [x] Use git and try to make small commits.
- [ ] Tests

## PLUS

- [x] Use the GPS location
- [x] Google maps
- [ ] Use a QRCode strategy to meet new people;
