import boto3
import json
import os
import requests
from datetime import datetime

ALPHA_VANTAGE_API_KEY = os.environ.get("ALPHA_VANTAGE_API_KEY")
SNS_TOPIC_ARN = os.environ.get("SNS_TOPIC_ARN")
S3_BUCKET_NAME = os.environ.get("S3_BUCKET_NAME")

sns_client = boto3.client("sns")
s3_client = boto3.client("s3")

def handler(event, context):
    print("Received scheduled event:", event)

    # Construct Alpha Vantage API URL for US Retail Sales data
    url = f'https://www.alphavantage.co/query?function=RETAIL_SALES&apikey={ALPHA_VANTAGE_API_KEY}'

    try:
        # 1. Fetch retail sales data
        response = requests.get(url)
        response.raise_for_status()
        retail_data = response.json()
        message = {
            "status": "processed",
            "message": "Retail sales data pulled successfully",
            "data": retail_data
        }

        print(message)

        # 2. Publish to SNS
        sns_client.publish(
            TopicArn=SNS_TOPIC_ARN,
            Message=json.dumps(message.get("message", {}))
        )

        # 3. Push to S3
        timestamp = datetime.utcnow().strftime("%Y-%m-%dT%H-%M-%SZ")
        s3_key = f"retail_sales/retail_sales_{timestamp}.json"
        s3_client.put_object(
            Bucket=S3_BUCKET_NAME,
            Key=s3_key,
            Body=json.dumps(retail_data),
            ContentType="application/json"
        )
        print(f"Data successfully written to s3://{S3_BUCKET_NAME}/{s3_key}")

        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Retail sales data pushed to SNS and S3"})
        }

    except requests.exceptions.HTTPError as e:
        print(f"HTTP error fetching Alpha Vantage data: {e}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Failed to fetch retail sales data"})
        }

    except Exception as e:
        print(f"Unexpected error: {e}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "An unexpected error occurred"})
        }
