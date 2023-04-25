from flask import Flask, request, jsonify
from flask_restful import Api, Resource, reqparse
import sqlite3

app = Flask(__name__)
api = Api(app)

parser = reqparse.RequestParser()
parser.add_argument('username', type=str)
parser.add_argument('email', type=str)
parser.add_argument('password', type=str)
parser.add_argument('description', type=str)

class User(Resource):
    def post(self):
        args = parser.parse_args()
        username = args['username']
        email = args['email']
        password = args['password']

        conn = sqlite3.connect('database.db')
        c = conn.cursor()

        c.execute('INSERT INTO users (username, email, password) VALUES (?, ?, ?)', (username, email, password))
        conn.commit()

        conn.close()

        return {'status': 'success'}

class Login(Resource):
    def post(self):
        args = parser.parse_args()
        email = args['email']
        password = args['password']

        conn = sqlite3.connect('database.db')
        c = conn.cursor()

        c.execute('SELECT * FROM users WHERE email = ? AND password = ?', (email, password))
        user = c.fetchone()

        conn.close()

        if user:
            return {'status': 'success'}
        else:
            return {'status': 'error'}

class Description(Resource):
    def post(self):
        args = parser.parse_args()
        description = args['description']

        # Aqui você pode obter a localização atual do usuário
        # usando uma biblioteca de geolocalização como geopy
        # Depois de obter a localização, você pode armazená-la
        # junto com a descrição no banco de dados
        # e retornar a localização ao cliente

        return {'location': 'latitude, longitude'}

api.add_resource(User, '/user')
api.add_resource(Login, '/login')
api.add_resource(Description, '/description')

if __name__ == '__main__':
    conn = sqlite3.connect('database.db')
    c = conn.cursor()

    c.execute('''CREATE TABLE IF NOT EXISTS users
                 (id INTEGER PRIMARY KEY,
                 username TEXT,
                 email TEXT,
                 password TEXT)''')

    conn.commit()
    conn.close()

    app.run(debug=True)