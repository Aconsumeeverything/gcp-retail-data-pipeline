import os
from google.cloud import storage

# === CONFIG ===
BUCKET_NAME = "retail-bucket-anass-debug-457208"
LOCAL_DATA_DIR = "../project_dataset"  
GCS_TARGET_FOLDER = "raw"       


# === Authenticate ===
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "../../keys/terraform_serv_creds.json"  
# === Upload files to GCS ===
client = storage.Client()
bucket = client.bucket(BUCKET_NAME)

def upload_files():
    for filename in os.listdir(LOCAL_DATA_DIR):
        if filename.endswith(".csv"):
            local_path = os.path.join(LOCAL_DATA_DIR, filename)
            blob_path = f"{GCS_TARGET_FOLDER}/{filename}"
            blob = bucket.blob(blob_path)
            blob.upload_from_filename(local_path)
            print(f" Uploaded: {filename} → gs://{BUCKET_NAME}/{blob_path}")

if __name__ == "__main__":
    upload_files()
