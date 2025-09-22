#!/usr/bin/env python3
import requests
from datetime import datetime

# Fixed application URL
URL = "http://example.com"

# Report file (all results appended here)
REPORT_FILE = "health_report.txt"

def check_app_health(url):
    try:
        response = requests.get(url, timeout=5)
        if response.status_code == 200:
            result = f"[UP] ✅ Application is UP and running at {url}"
        else:
            result = f"[DOWN] ❌ Application responded with status code {response.status_code}"

    except requests.exceptions.Timeout:
        result = f"[DOWN] ❌ Application at {url} did not respond (Timeout)."
    except requests.exceptions.ConnectionError:
        result = f"[DOWN] ❌ Cannot connect to {url} (Connection Error)."
    except Exception as e:
        result = f"[DOWN] ❌ An error occurred while checking {url}: {e}"

    # Print result to console
    print(result)

    # Append result to report file using UTF-8
    with open(REPORT_FILE, "a", encoding="utf-8") as f:
        f.write(f"[{datetime.now()}] {result}\n")

    print(f"📄 Result appended to {REPORT_FILE}")

if __name__ == "__main__":
    check_app_health(URL)
