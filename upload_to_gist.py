import base64
import requests
import os

GITHUB_TOKEN = os.environ.get("GITHUB_TOKEN")
GIST_ID = os.environ.get("GIST_ID")  # imposta su CapRover
FILE_PATH = "data/output/fpedia_analysis.xlsx"

with open(FILE_PATH, "rb") as f:
    content = f.read()

# Converti in base64 perché è un file binario
b64content = base64.b64encode(content).decode("utf-8")

url = f"https://api.github.com/gists/{GIST_ID}"

payload = {
    "files": {
        "fpedia_analysis.xlsx": {
            "content": b64content
        }
    }
}

resp = requests.patch(
    url,
    headers={"Authorization": f"token {GITHUB_TOKEN}"},
    json=payload
)

print(resp.status_code, resp.json().get("html_url"))
