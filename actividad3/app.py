from flask import Flask, jsonify
import os
import sys
import socket

# 12-Factor: configuración vía variables de entorno (sin valores codificados)
PORT = int(os.environ.get("PORT", "8080"))
MESSAGE = os.environ.get("MESSAGE", "Hola")
RELEASE = os.environ.get("RELEASE", "v0")

SERVICE_PORT = int(os.environ.get("SERVICE_PORT", "9999"))

app = Flask(__name__)

counter = 0

@app.route("/")
def root():
    
    global counter
    counter += 1
    print(f"[INFO] GET /  message={MESSAGE} release={RELEASE} counter={counter}", file=sys.stdout, flush=True)
    return jsonify(
        status="ok",
        message=MESSAGE,
        release=RELEASE,
        counter=counter,
        port=PORT,
    )
    resp.headers["Cache-Control"] = "no-cache"
    resp.headers["ETag"] = "v1.0"
    resp.headers["Strict-Transport-Security"] = "max-age=31536000; includeSubDomains"
    
    print(f"[INFO] GET /  release=v1.0", file=sys.stdout, flush=True)
    return resp

@app.route("/healthz/live")
def liveness():

    return jsonify(status="alive")

@app.route("/healthz/ready")
def readiness():
    return jsonify(status="ready")

@app.route("/service")
def service_check():
    try:
        # Intentar conectarse a un "backing service"
        s = socket.create_connection(("127.0.0.1", SERVICE_PORT), timeout=2)
        s.close()
        print(f"[INFO] /service OK en puerto {SERVICE_PORT}", file=sys.stdout, flush=True)
        return jsonify(status="ok", port=SERVICE_PORT)
    except Exception as e:
        print(f"[ERROR] /service fallo en puerto {SERVICE_PORT} -> {e}", file=sys.stdout, flush=True)
        return jsonify(status="error", port=SERVICE_PORT, error=str(e))

if __name__ == "__main__":
    # 12-Factor: vincular a un puerto; proceso único; sin estado
    app.run(host="127.0.0.1", port=PORT)
