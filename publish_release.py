import os
import requests
from datetime import datetime

GITHUB_TOKEN = os.environ["GITHUB_TOKEN"]
REPO = os.environ["GITHUB_REPO"]
FILE_PATH = os.environ["FILE_PATH"]
TAG = datetime.utcnow().strftime("%Y.%m.%d")

release_url = f"https://api.github.com/repos/{REPO}/releases"
headers = {"Authorization": f"token {GITHUB_TOKEN}"}
payload = {
    "tag_name": TAG,
    "name": f"Automated release {TAG}",
    "body": "Generated automatically from CapRover app.",
    "draft": False,
    "prerelease": False
}
release_resp = requests.post(release_url, headers=headers, json=payload)
release_resp.raise_for_status()
release = release_resp.json()
upload_url = release["upload_url"].split("{")[0]

with open(FILE_PATH, "rb") as f:
    file_data = f.read()

asset_name = os.path.basename(FILE_PATH)
upload_resp = requests.post(
    f"{upload_url}?name={asset_name}",
    headers={
        "Authorization": f"token {GITHUB_TOKEN}",
        "Content-Type": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    },
    data=file_data
)

upload_resp.raise_for_status()
print("✅ Release created:", release["html_url"])
print("✅ Asset uploaded:", upload_resp.json()["browser_download_url"])
