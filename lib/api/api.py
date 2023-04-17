from flask import Flask, request, jsonify
import firebase_admin
from firebase_admin import credentials, auth, db, firestore

# Inicializa o Flask
app = Flask(__name__)

# Inicializa o SDK do Firebase
cred = credentials.Certificate("path/to/serviceAccountKey.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://nasruas-dddfe-default-rtdb.firebaseio.com/'
})

# Rota de cadastro de usuário
@app.route('/signup', methods=['POST'])
def signup():
    email = request.json['email']
    password = request.json['password']
    name = request.json['name']

    # Cria o usuário no Firebase Authentication
    user = auth.create_user(
        email=email,
        password=password,
        display_name=name
    )

    # Retorna o token de autenticação do usuário
    return jsonify({'token': user['idToken']})

# Rota de login de usuário
@app.route('/login', methods=['POST'])
def login():
    email = request.json['email']
    password = request.json['password']

    # Faz o login do usuário no Firebase Authentication
    user = auth.sign_in_with_email_and_password(email, password)

    # Retorna o token de autenticação do usuário
    return jsonify({'token': user['idToken']})

# Rota de registro de postagem
@app.route('/post', methods=['POST'])
def post():
    # Obtém os dados da postagem e a localização
    text = request.json['text']
    lat = request.json['lat']
    lng = request.json['lng']

    # Salva a postagem no Firebase Firestore
    posts_ref = firestore.client().collection('posts')
    post_data = {'text': text, 'lat': lat, 'lng': lng}
    post_ref = posts_ref.add(post_data)

    # Retorna a localização da postagem
    return jsonify({'location': f'{lat},{lng}'})

if __name__ == '__main__':
    app.run(debug=True)

# https://nasruas-dddfe-default-rtdb.firebaseio.com/


# CHAVE DA FIREBASE AIzaSyBUxQPLWKB2eF5Zi72AVJks_lobBMPz5zc