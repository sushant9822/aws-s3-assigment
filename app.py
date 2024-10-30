from flask import Flask, jsonify, abort
import boto3
from botocore.exceptions import ClientError
from dotenv import load_dotenv
import os


load_dotenv()

app = Flask(__name__)


AWS_ACCESS_KEY_ID = os.getenv("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")
AWS_REGION = os.getenv("AWS_REGION")
BUCKET_NAME = os.getenv("S3_BUCKET_NAME")

s3_client = boto3.client(
    's3',
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
    region_name=AWS_REGION
)

@app.route("/list-bucket-content/", defaults={'path': ''}, methods=['GET'])
@app.route("/list-bucket-content/<path:path>", methods=['GET'])
def list_bucket_content(path):
    try:
       
        if path and not path.endswith('/'):
            path += '/'

       
        response = s3_client.list_objects_v2(Bucket=BUCKET_NAME, Prefix=path, Delimiter='/')
        
        
        directories = []
        files = []

       
        if 'Contents' not in response and 'CommonPrefixes' not in response:
            abort(404, description="Path not found in S3 bucket.")

       
        if 'CommonPrefixes' in response:
            for prefix in response['CommonPrefixes']:
               
                directory_name = prefix['Prefix'].split('/')[-2]
                directories.append(directory_name)
        
       
        if 'Contents' in response:
            for obj in response['Contents']:
              
                if obj['Key'] != path and obj['Key'] != f"{path}/":
                    file_name = obj['Key'].split('/')[-1]
                    files.append(file_name)

    
        content = directories if path == '' else directories + files
        return jsonify({"content": content})
    
    except ClientError as e:
      
        abort(400, description=str(e))

@app.route("/health", methods=['GET'])
def health_check():
    """Health check endpoint to verify if the application is healthy."""
    return jsonify({"status": "healthy"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
