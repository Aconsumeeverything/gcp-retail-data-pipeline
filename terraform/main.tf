provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
}

resource "google_storage_bucket" "retail_bucket" {
  name          = var.gcs_bucket_name
  location      = "US"
  force_destroy = true
}

resource "google_bigquery_dataset" "bronze" {
  dataset_id = "bronze"
  location   = var.region
  delete_contents_on_destroy = true
}

resource "google_bigquery_dataset" "silver" {
  dataset_id = "silver"
  location   = var.region
}
