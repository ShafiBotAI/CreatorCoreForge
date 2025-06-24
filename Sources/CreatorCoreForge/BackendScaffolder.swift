import Foundation

public enum BackendFramework {
    case express
    case fastAPI
    case firebase
}

/// Generates minimal backend scaffolding examples.
public struct BackendScaffolder {
    public init() {}

    public func generate(for framework: BackendFramework) -> String {
        switch framework {
        case .express:
            return "const express = require('express');\nconst app = express();\napp.get('/', (req, res) => res.send('ok'));\nmodule.exports = app;"
        case .fastAPI:
            return "from fastapi import FastAPI\napp = FastAPI()\n@app.get('/')\ndef read_root():\n    return {'status': 'ok'}"
        case .firebase:
            return "import * as functions from 'firebase-functions';\nexport const helloWorld = functions.https.onRequest((req, res) => { res.send('ok'); });"
        }
    }
}
