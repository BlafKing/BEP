import os
import asyncio
import keyboard
import discord
from discord.ext import tasks
from discord.http import Route
from datetime import datetime, timedelta
import logging

TOKEN = open(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'token.txt'))).read().strip()
messages_file = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'messages.txt'))
log_msg_file = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'log_msg.txt'))
log_file = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'log.txt'))

MsgLog = logging.getLogger('MsgLog')
MsgLog.setLevel(logging.ERROR)
MsgHandler = logging.FileHandler(log_msg_file)
MsgFormatter = logging.Formatter('%(asctime)s : %(message)s', datefmt='%m/%d %H:%M:%S')
MsgHandler.setFormatter(MsgFormatter)
MsgLog.addHandler(MsgHandler)

Log = logging.getLogger('Log')
Log.setLevel(logging.ERROR)
Handler = logging.FileHandler(log_file)
Formatter = logging.Formatter('%(asctime)s - MsgInfo : %(message)s', datefmt='%m/%d %H:%M:%S')
Handler.setFormatter(Formatter)
Log.addHandler(Handler)

countdown = None
client = discord.Client(intents=discord.Intents(messages=True))

def unix_time():
    now = datetime.now()
    time = now + timedelta(minutes=2, seconds=30)

    if time.second > 30:
        time += timedelta(minutes=1)

    return int(time.timestamp())

def countdown_time():
    now = datetime.now()
    time = now + timedelta(minutes=3, seconds=10)

    return int(time.timestamp())

def RemoveMSG(channel_id):
    with open(messages_file, "r") as f:
        lines = f.readlines()

    filtered_lines = [line for line in lines if str(channel_id) not in line]
    with open(messages_file, "w") as f:
        f.writelines(filtered_lines)

@tasks.loop()
async def check_keyboard():
    global EditSuccesCount, EditFailCount, countdown
    while True:
        pressed_key = keyboard.read_event().name
        if pressed_key in ["f13", "f14", "f15", "f16", "f17", "f18", "f19", "f20"]:
            number = int(pressed_key[1:]) - 13
            if number == 7:
                countdown = countdown_time()
                return
            
            if number in [5, 6]:
                time = unix_time()
                countdown = None
            else:
                time = None

            with open(log_msg_file, 'w'):
                pass

            with open(messages_file, "r") as f:
                messages = [line.strip().split(",") for line in f]
            nextline = "\n"
            EditSuccesCount = 0
            EditFailCount   = 0

            async def edit_message(channel_id, message_id, guild_name):
                global EditSuccesCount, EditFailCount, countdown
                route = Route('PATCH', f'/channels/{channel_id}/messages/{message_id}')
                json = {
                "embeds": [{
                        "title": "King's Fall: Normal",
                        "description": f"Golg Maze\n\n**Lobby Status: {'CRASHED' if number == 6 else 'CLOSED' if time is not None else 'OPEN'}**\n{f'Opens again around <t:{time}:t>' if time is not None else f'Current Fireteam: {number}/5'}{f'{nextline}Closes <t:{countdown}:R>' if countdown is not None else ''}\n\n`/join BEP#0923`",
                        "color": 8518399,
                        "footer": {
                            "text": "Bot made & hosted by TomDom#7157",
                            "icon_url": "https://i.imgur.com/okySVKa.png"
                        },
                        "thumbnail": {
                            "url": "https://i.imgur.com/2h8haVO.png"
                    }
                }]
            }
                try:
                    await asyncio.wait_for(client.http.request(route, json=json), timeout=2.0)
                    MsgLog.error(f"\"{f'Crashed' if number == 6 else 'Closed' if time is not None else f'{number}/5'}\" Message applied to ChannelID \"{channel_id}\" MessageID \"{message_id}\" In server \"{guild_name}\"")
                    EditSuccesCount += 1
                except asyncio.TimeoutError:
                    Log.error("API rate limit exceeded.")
                except Exception as e:
                    if e.status == 404:
                        Log.error(f"Failed to find message ID \"{message_id}\" in channel ID \"{channel_id}\" from server \"{guild_name}\": {e}")
                        RemoveMSG(channel_id)
                        Log.error(f"Message \"{message_id}\" removed from server \"{guild_name}\" from channel ID \"{channel_id}\".")
                    else:
                        MsgLog.error(f"Failed to edit message ID \"{message_id}\" in channel ID \"{channel_id}\" from server \"{guild_name}\": {e}")
                        EditFailCount += 1

            coroutines = [edit_message(channel_id, message_id, guild_name) for channel_id, message_id, guild_name in messages]
            await asyncio.gather(*coroutines)
            Log.error(f"{'Crashed' if number == 6 else 'Closed' if time is not None else f'{number}/5'} Message sent to {EditSuccesCount} Servers{f' Of which {EditFailCount} has failed.' if EditFailCount == 1 else f' Of which {EditFailCount} have failed.' if EditFailCount != 0 else ''}")

@check_keyboard.before_loop
async def before_check_keyboard():
    await client.wait_until_ready()
    Log.error("Ready!")

check_keyboard.start()
client.run(TOKEN)