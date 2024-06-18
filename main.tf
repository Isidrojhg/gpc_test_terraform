# Create a Google Compute instance
resource "google_compute_instance" "example" {
  name         = "example"
  machine_type = "f1-micro"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
  labels = {
    yor_trace = "b140cb97-2017-4bfe-b10c-3c38b00c18b9"
  }
}
