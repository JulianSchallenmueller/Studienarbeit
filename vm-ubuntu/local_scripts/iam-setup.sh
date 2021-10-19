gcloud compute instances add-iam-policy-binding jsa-vm-instance-sa --zone='europe-west3-b' --member="serviceAccount:jsa-sa@active-woodland-324808.iam.gserviceaccount.com" --role="roles/compute.osAdminLogin"
gcloud iam service-accounts add-iam-policy-binding jsa-sa@active-woodland-324808.iam.gserviceaccount.com --member="user:juscit06@hs-esslingen.de" --role="roles/iam.serviceAccountUser"
gcloud iam service-accounts keys create key.json --iam-account=jsa-sa@active-woodland-324808.iam.gserviceaccount.com
gcloud auth activate-service-account jsa-sa@active-woodland-324808.iam.gserviceaccount.com --key-file=./key.json
ssh-keygen -t rsa -f ./jsa-vm-instance-sa -C jsa-sa -N ''
gcloud compute os-login ssh-keys add --key-file=./jsa-vm-instance-sa.pub --ttl=30d | grep 'username' > username.txt
gcloud config set core/account juscit06@hs-esslingen.de