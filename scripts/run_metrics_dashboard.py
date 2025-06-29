#!/usr/bin/env python3
import http.server
import json
import random
from typing import Dict

class MetricsHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        data: Dict[str, float] = {
            "cpu": random.random(),
            "memory": random.random()*100,
            "errors": random.randint(0, 5),
        }
        body = json.dumps(data).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(body)

if __name__ == '__main__':
    http.server.HTTPServer(('0.0.0.0', 8000), MetricsHandler).serve_forever()
