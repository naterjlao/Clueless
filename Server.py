#Reference: https://www.youtube.com/watch?v=BSGGAzsgFvk (Anguar and Python Socket IO)
# pip install socketio

from aiohttp import web
import socketio


socketio = socketio.AsyncServer()
app = web.Application()
socketio.attach(app)


async def index(request):
	return web.Response(text = "Hello World", content_type = 'text/html')


@socketio.on('message')
def print_message(sid, message)
	print("Socket ID: ", sid)
	print(message, broadcast = True)



app.router.add_get('/', index)

if __name__ == '__main__':
	web.run(app)



class Game(object):

	def __init__(self):

		self.player 
		self.game_id
		self.game_id


	def addPlayerToGame(self, name):


	def startGame():


	def endGame(self):


	def movePlayerPosition(self, player, suspect, room):


	def getSuggestion():



	def sendSuggestion():



	def getAccusation():



	def endPlayerTurn():



	def nextPlayerTurn();



	def selectSuspect()



class Cards(objecr):


	def __init__(self):

		#initialize suspects
		#initialize rooms
		#initialize weapons
		#initialize 


	def shuffleCards(self):


	def dealCards(self):


	def winningCards(self):




