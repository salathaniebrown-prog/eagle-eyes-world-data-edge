from flask import Flask, request, jsonify
import json

app = Flask(__name__)

@app.route('/validate', methods=['POST'])
def validate():
    data = request.get_json()
    print("📥 Received:")
    print(json.dumps(data, indent=2))
    
    uid = data.get('request', {}).get('uid', 'unknown')
    pod_name = data.get('request', {}).get('object', {}).get('metadata', {}).get('name', 'unknown')

    return jsonify({
        "apiVersion": "admission.k8s.io/v1",
        "kind": "AdmissionReview",
        "response": {
            "uid": uid,
            "allowed": True,
            "status": {"message": f"Approved pod: {pod_name}"}
        }
    })

@app.route('/', methods=['GET'])
def health():
    return "Webhook alive - POST to /validate", 200

if __name__ == '__main__':
    # if you only have one .pem file, use it for both, or generate a self-signed pair
    app.run(host='0.0.0.0', port=8443, ssl_context=('webhook-cert.pem', 'webhook-key.pem'))
