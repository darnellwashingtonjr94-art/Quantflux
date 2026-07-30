import argparse
import logging
import requests
import os

logging.basicConfig(level=logging.INFO, format="%(asctime)s [NOTIFICATION_ROUTER] %(message)s")

def dispatch_alert(event_type: str, message: str):
    webhook_url = os.getenv("DISCORD_TELEGRAM_WEBHOOK_URL")
    
    payload = {
        "event": event_type,
        "message": message,
        "status": "DISPATCHED"
    }

    logging.info(f"Broadcasting [{event_type}]: {message}")

    if webhook_url:
        try:
            requests.post(webhook_url, json={"content": f"**[{event_type}]** {message}"}, timeout=5)
        except Exception as e:
            logging.error(f"Failed to post alert to webhook: {e}")
    else:
        logging.info("No Webhook URL configured. Alert printed to stdout.")

def main():
    parser = argparse.ArgumentParser(description="Notification Router Utility")
    parser.add_argument("--event", type=str, default="INFO", help="Event severity/type")
    parser.add_argument("--message", type=str, required=True, help="Message content")
    args = parser.parse_args()

    dispatch_alert(args.event, args.message)

if __name__ == "__main__":
    main()
