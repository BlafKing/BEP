import firebase_admin
from firebase_admin import credentials, db

cred = credentials.Certificate("C:/Users/Bep/Desktop/Bot/DiscordBOT/cred.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://bepbot-0-default-rtdb.europe-west1.firebasedatabase.app'
})

ref = db.reference('/')

ref.update({
    'text' : "<strong>Lobby Status: CLOSED</strong><br/>Bot is currently being updated<br/><br/>Will be back online as soon as possible."
})
print(ref.get())