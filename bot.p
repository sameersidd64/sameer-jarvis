import discord
import requests
import os

TOKEN = os.environ['DISCORD_TOKEN']
WEBHOOK_URL = os.environ['N8N_WEBHOOK_URL']
CHANNEL_NAME = 'ocg-logs'

intents = discord.Intents.default()
intents.message_content = True
client = discord.Client(intents=intents)

@client.event
async def on_ready():
    print(f'Sameer-Jarvis is online')

@client.event
async def on_message(message):
    if message.author == client.user:
        return
    if message.channel.name == CHANNEL_NAME:
        data = {
            'content': message.content,
            'author': str(message.author.name),
            'timestamp': str(message.created_at),
            'channel': message.channel.name
        }
        requests.post(WEBHOOK_URL, json=data)
        await message.add_reaction('✅')

client.run(TOKEN)
