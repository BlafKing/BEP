import firebase_admin
from firebase_admin import credentials, db

cred = credentials.Certificate("C:/Users/Bep/Desktop/Bot/DiscordBOT/cred.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://bepbot-0-default-rtdb.europe-west1.firebasedatabase.app'
})

ref = db.reference('/')

ref.update({
    'text' : "<strong>Lobby Status: CLOSED</strong><br/>Destiny 2 Servers are experiencing issues/outage<br/>bot is currently unable to login.<br/><br/>Waiting for servers to come back online."
})
print(ref.get())