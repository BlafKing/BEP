import discord
import os

# Get the bot's token from token.txt
script_dir = os.path.dirname(os.path.abspath(__file__))
token_file = os.path.join(script_dir, "token.txt")

with open(token_file) as f:
    TOKEN = f.readline().strip()

# Create a client object for the bot
client = discord.Client()

@client.event
async def on_ready():
    # Once the bot is connected to Discord, write the names of the servers it's in to servers.txt
    with open(os.path.join(script_dir, "guilds.txt"), "w") as f:
        for guild in client.guilds:
            f.write(str(guild.name) + "\n")
    await client.close()
# Run the bot
client.run(TOKEN)
