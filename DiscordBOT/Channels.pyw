import discord
import os
import requests
from discord_slash import SlashCommand, SlashContext
from discord.utils import escape_markdown, escape_mentions
import logging

script_dir = os.path.dirname(os.path.abspath(__file__))

messages_file = os.path.join(script_dir, "messages.txt")
token_file = os.path.join(script_dir, "token.txt")
url_file = os.path.join(script_dir, "url.txt")
log_file = os.path.join(script_dir, "log.txt")

Log = logging.getLogger('Log')
Log.setLevel(logging.ERROR)
Handler = logging.FileHandler(log_file)
Formatter = logging.Formatter('%(asctime)s - Info    : %(message)s', datefmt='%m/%d %H:%M:%S')
Handler.setFormatter(Formatter)
Log.addHandler(Handler)

with open(token_file) as f:
    TOKEN = f.read().strip()

sent_messages = []

with open(messages_file, 'r') as f:
    lines = f.readlines()
for line in lines:
    channel_id, message_id, guild_id = line.strip().split(',')
    sent_messages.append((int(channel_id), int(message_id)))

with open(url_file) as f:
    url = f.read().strip()

headers = {
    "Authorization": f"Bot {TOKEN}",
}

json = {
    "name": "bep-status",
    "type": 1,
    "description": "Sends the live status of the BEP Bot."
}

response = requests.post(url, headers=headers, json=json)

Log.error(f"/bep-status response code: {response.status_code}")

json = {
    "name": "bep-stop",
    "type": 1,
    "description": "Removes the live status of the BEP Bot."
}

response = requests.post(url, headers=headers, json=json)

Log.error(f"/bep-stop   response code: {response.status_code}")

json = {
    "name": "join",
    "type": 1,
    "description": "Explains how to use the /join command."
}

response = requests.post(url, headers=headers, json=json)

Log.error(f"/join       response code: {response.status_code}")

bot = discord.ext.commands.Bot(command_prefix='/', intents=discord.Intents(messages=True, guilds=True))
slash = SlashCommand(bot, sync_commands=True)

@slash.slash(name="join", description="Explains how to use the /join command.")
async def join(ctx: SlashContext):
    Log.error(f"Received /join command in \"{ctx.guild.name}\"")

    if not ctx.channel.permissions_for(ctx.guild.me).send_messages:
        await ctx.send("I don't have permission to send messages in this channel.", hidden=True)
        return

    if not ctx.channel.permissions_for(ctx.guild.me).embed_links:
        await ctx.send("I don't have permission to use embedded links in this channel.", hidden=True)
        return

    if not ctx.channel.permissions_for(ctx.guild.me).use_external_emojis:
        await ctx.send("I don't have permission to use external emojis in this channel.", hidden=True)
        return

    embed = discord.Embed.from_dict({
        "title": "How to use the `/join` command: ",
        "color": 0x81FAFF,
        "fields": [
            {
                "name": "\u200B\nPC:",
                "value": "In Destiny 2, Press `Enter` to open text chat\n\nthen type `/join BEP#0923` and press `Enter`\n\u200B\n\u200B",
                "inline": False
            },
            {
                "name": "Xbox or Playstation:",
                "value": "In Destiny 2, While in orbit, press <:RightDPad:1096463020760248350> to open text chat\n\nPress <:XboxY:1096463141854007480> or <:PS4Triangle:1096463138766983240> to open the virtual keyboard\n\nthen type `/join BEP#0923` and press <:XboxA:1096463137340915782> or <:Ps4Cross:1096463134870470707>\n\u200B\n\u200B",
                "inline": False
            },
            {
                "name": "If your game is not in English:",
                "value": "Replace `/join` with one of the following:",
                "inline": False
            },
            {
                "name": "**Español**",
                "value": "`/unirse`",
                "inline": True
            },
            {
                "name": "**Deutsch**",
                "value": "`/beitreten`",
                "inline": True
            },
            {
                "name": "**Français**",
                "value": "`/rejoindre`",
                "inline": True
            },
            {
                "name": "**Italiano**",
                "value": "`/partecipa`",
                "inline": True
            },
            {
                "name": "**Polski**",
                "value": "`/dolacz`",
                "inline": True
            },
            {
                "name": "**Português**",
                "value": "`/juntar-se`",
                "inline": True
            },
            {
                "name": "**русский**",
                "value": "`/вступить`",
                "inline": True
            },
            {
                "name": "**汉语 & 漢語**",
                "value": "`/加入`",
                "inline": True
            },
            {
                "name": "**한국어**",
                "value": "`/합류`",
                "inline": True
            }
        ]
    })
    await ctx.send(embed=embed, hidden=True)

@slash.slash(name="bep-status", description="Sends the live status of the BEP Bot.")
async def bepstatus(ctx: SlashContext):
    Log.error(f"Received /bep-status command in \"{ctx.guild.name}\"")

    if not ctx.channel.permissions_for(ctx.guild.me).send_messages:
        await ctx.send("I don't have permission to send messages in this channel.", hidden=True)
        return

    if not ctx.channel.permissions_for(ctx.guild.me).embed_links:
        await ctx.send("I don't have permission to use embedded links in this channel.", hidden=True)
        return

    if not ctx.channel.permissions_for(ctx.guild.me).use_external_emojis:
        await ctx.send("I don't have permission to use external emojis in this channel.", hidden=True)
        return

    # Check if any of the last messages were sent by the bot
    with open(messages_file, 'r') as f:
        messages = f.read().splitlines()
        channels = [msg.split(',')[0] for msg in messages]
        if str(ctx.channel.id) in channels:
            await ctx.send("There is already a message sent by the bot in this channel.\nPlease use `/bep-stop` first!\n(If the Status message was manually deleted, please try again in 5 minutes.)", hidden=True)
            return

    await ctx.send("BOT status has been successfully posted.", hidden=True)

    embed = discord.Embed(
    title="King's Fall: Normal",
    description="Golg Maze\n\nBot successfully initiated!\nStatus will update soon.\n\nThis should not take longer than 10 minutes.\nIf it does please make sure the bot has all the required permissions.",
    color=0x81FAFF
)
    embed.set_thumbnail(url="https://www.bungie.net/common/destiny2_content/icons/bc809878e0c2ed8fd32feb62aaae690c.png")

    message = await ctx.channel.send(embed=embed)
    with open(messages_file, 'a' if os.path.exists(messages_file) else 'w') as f:
        f.write(f"{ctx.channel.id},{message.id},{ctx.guild.name}\n")

@slash.slash(name="bep-stop", description="Removes the live status of the BEP Bot.")
async def bepstop(ctx: SlashContext):
    Log.error(f"Received /bep-stop command in \"{ctx.guild.name}\"")

    with open(messages_file, 'r') as f:
        lines = f.readlines()

    for i, line in enumerate(lines):
        channel_id, message_id, guild_id = line.strip().split(',')
        if channel_id == str(ctx.channel.id):
            channel = bot.get_channel(int(channel_id))
            message = discord.Object(int(message_id))
            await channel.delete_messages([message])
            del lines[i]
            with open(messages_file, 'w') as f:
                f.write(''.join(lines))
            await ctx.send("BEP Status removed!", hidden=True)
            return

    await ctx.send("No status message present in this channel.\n(If there is, please delete it manually)", hidden=True)

bot.run(TOKEN)