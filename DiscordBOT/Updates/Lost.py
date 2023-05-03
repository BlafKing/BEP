import os
import asyncio
import discord
from discord.http import Route
import sys

TOKEN = open(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'token.txt'))).read().strip()
messages_file = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'messages.txt'))

client = discord.Client(intents=discord.Intents(guilds=True))

def RemoveMSG(channel_id):
    with open(messages_file, "r+") as f:
        lines = [line for line in f if str(channel_id) in line]
        f.seek(0)
        f.writelines(lines)
        f.truncate()

@client.event
async def on_ready():

    with open(messages_file, "r") as f:
                messages = [line.strip().split(",") for line in f]

    async def edit_message(channel_id, message_id, guild_name):
        route = Route('PATCH', f'/channels/{channel_id}/messages/{message_id}')
        json = {
        "embeds": [{
                "title": "King's Fall: Normal",
                "description": "Golg Maze\n\nBot has lost the checkpoint\ndue to weekly reset.\n\nWill be back online as soon as possible.",
                "color": 8518399,
                "footer": {
                            "text": "Bot made & hosted by TomDom",
                            "icon_url": "https://i.imgur.com/okySVKa.png"
                        },
                        "thumbnail": {
                            "url": "https://i.imgur.com/2h8haVO.png"
            }
        }]
    }
        try:
            await asyncio.wait_for(client.http.request(route, json=json), timeout=2.0)
            print(f"Edited message ID {message_id} in channel ID {channel_id} in server {guild_name}.")
        
        except asyncio.TimeoutError:
            print("API rate limit exceeded.")
        except Exception as e:
            if e.status == 404:
                print(f"Failed to find message ID {message_id} in channel ID {channel_id} in server {guild_name}: {e}")
                print(f"Message {message_id} removed.")
                RemoveMSG(channel_id)
            else:
                print(f"Failed to edit message ID {message_id} in channel ID {channel_id} in server {guild_name}: {e}")

    coroutines = [edit_message(channel_id, message_id, guild_name) for channel_id, message_id, guild_name in messages]
    await asyncio.gather(*coroutines)

    await client.close()

client.run(TOKEN)
sys.exit()