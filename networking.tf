resource "google_compute_network" "cr460" {
    name                    = "cr460"
    auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "central1-dmz" {
    name          = "central1-dmz"
    ip_cidr_range = "172.16.1.0/24"
    network       = "${google_compute_network.cr460.self_link}"
    region        = "us-central1"
}

resource "google_compute_subnetwork" "central1-internal" {
    name          = "central1-internal"
    ip_cidr_range = "10.0.1.0/24"
    network       = "${google_compute_network.cr460.self_link}"
    region        = "us-central1"
}
