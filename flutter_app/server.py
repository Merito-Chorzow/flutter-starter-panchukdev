from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # вот эта строка позволяет Flutter Web обращаться к API

entries = []

@app.route('/api/entries/get', methods=['GET'])
def get_entries():
    return jsonify(entries), 200

@app.route('/api/entries/add', methods=['POST'])
def add_entry():
    data = request.json
    entries.append(data)
    return jsonify({"message": "Data Added"}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=50764)