# BEP - Destiny 2 Golgoroth Maze Checkpoint bot

Hi all, This is a bot I made in AHK for use in Destiny 2.

I used to host this bot myself, but I am no longer able to.
If you're interested in reading why I stopped hosting the bot, click [here](https://github.com/tombon12/BEP/blob/main/Reasoning.md)

In case anyone wants to take on hosting this bot, feel free to use any of my code.
I have based this bot around a 1920x1080 resolution, so all the button presses will corelate to that resolution.

There's probably many ways that my code can be improved since I'm not at all a good programmer, however this repository is not intended to be used to improve the code, just to share it.

You are free to do whatever you want this code.

# General Info

Destiny 2 BOT

- AFKBot1.AHK & AFKBot2.AHK are basically the same file, once one is completed it opens the other, I used this method because I remotely connected to the PC hosting this bot and then I could edit both files without the need to restart any AHK script, it would use the updates files once either one has finished

- AFKBot3.AHK starts from the HELM, since I use image detection on the top left radar to see when the player is in the HELM, if you ever move the mouse while in the helm, It won't detect the player being in the helm, so AFKBOT3 is for when you are at the helm, have moved the mouse and want to start the script.

- Slots.AHK This file is ran each time a player is detected, so it sets the player count to 1 and starts detecting new players.

- SlotsEmpty.AHK This file is ran once the 7 minute timer has passed and no players have joined, this way the server won't get kicked for being AFK in the HELM and if there are other problems, it will eventually restart.

Discord BOT

- Channels.pyw receives commands 

- Updates/Messages.pyw Updates all the servers the discord bot is inside of with the live status.
