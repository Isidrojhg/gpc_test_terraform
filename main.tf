# Replace the placeholder values with your own.

# Configure the Google Cloud provider
provider "google" {
   project     =  var.project_id
   region      = "us-central1"
 }
# --- Resources for the Service Account Policy ---
# The policy "TEST - MMS: GCP Custom Role Service Account Policy"
# checks for a service account assigned a custom role with 'iam.roles.update'.

# Create a new service account
resource "google_service_account" "test_service_account" {
  project      = "your-gcp-project-id"
  account_id   = "test-sa-for-iam-policy"
  display_name = "Test SA for IAM Policy"
}

# Create a custom role with the critical permission 'iam.roles.update'
resource "google_project_iam_custom_role" "test_sa_role" {
  project     = "your-gcp-project-id"
  role_id     = "testSARoleWithUpdatePerm"
  title       = "Test SA Role"
  permissions = ["iam.roles.update"]
}

# Assign the custom role to the service account
resource "google_project_iam_member" "test_sa_member" {
  project = "your-gcp-project-id"
  role    = google_project_iam_custom_role.test_sa_role.id
  member  = "serviceAccount:${google_service_account.test_service_account.email}"
}

# --- Resources for the User Policy ---
# The policy "TEST - MMS: GCP Custom Role User Policy"
# checks for a user assigned a custom role with 'iam.roles.create'.

# Create a custom role with the critical permission 'iam.roles.create'
resource "google_project_iam_custom_role" "test_user_role" {
  project     = "your-gcp-project-id"
  role_id     = "testUserRoleWithCreatePerm"
  title       = "Test User Role"
  permissions = ["iam.roles.create"]
}

# Assign the custom role to a specific user
resource "google_project_iam_member" "test_user_member" {
  project = "your-gcp-project-id"
  role    = google_project_iam_custom_role.test_user_role.id
  member  = "user:test@example.com"
}
