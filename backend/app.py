from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/')
def home():
    return jsonify({"message": "Welcome to the Flask app!"})

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "OK"})

@app.route('/chat', methods=['POST'])
def chat():
    message = request.json.get('message', '')
    return jsonify({"response": f"You said: {message}"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
