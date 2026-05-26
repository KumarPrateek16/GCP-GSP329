gcloud iam service-accounts create ml-api-service-account --display-name "ML APIs Service Account"
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT   --member="serviceAccount:ml-api-service-account@$GOOGLE_CLOUD_PROJECT.iam.gserviceaccount.com"   --role="roles/bigquery.admin"
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT   --member="serviceAccount:ml-api-service-account@$GOOGLE_CLOUD_PROJECT.iam.gserviceaccount.com"   --role="roles/storage.objectAdmin"
gcloud iam service-accounts keys create key.json   --iam-account=ml-api-service-account@$GOOGLE_CLOUD_PROJECT.iam.gserviceaccount.com
export GOOGLE_APPLICATION_CREDENTIALS=key.json
gsutil cp gs://$GOOGLE_CLOUD_PROJECT/analyze-images-v2.py .
python3 analyze-images-v2.py $GOOGLE_CLOUD_PROJECT
python3 analyze-images-v2.py $GOOGLE_CLOUD_PROJECT $GOOGLE_CLOUD_PROJECT
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT   --member="serviceAccount:ml-api-service-account@$GOOGLE_CLOUD_PROJECT.iam.gserviceaccount.com"   --role="roles/serviceusage.serviceUsageConsumer"
python3 analyze-images-v2.py $GOOGLE_CLOUD_PROJECT $GOOGLE_CLOUD_PROJECT
