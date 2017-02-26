resource "google_compute_instance" "instance1" {
    name = "instance1"
    machine_type = "f1-micro"
    zone = "us-central1-a"

    disk {
        image = "debian-cloud/debian-8"
    }

    network_interface {
        subnetwork = "${google_compute_subnetwork.central1-dmz.name}"
        access_config {
            // IP
        }
    }

    metadata_startup_script = "apt-get -y install apache2 && systemctl start apache2"
}

resource "google_compute_firewall" "web" {
    name = "web"
    network = "${google_compute_network.cr460.name}"
    allow {
        protocol = "tcp"
        ports = ["80"]
    }
}

resource "google_compute_firewall" "ssh" {
    name = "ssh"
    network = "${google_compute_network.cr460.name}"
    allow {
        protocol = "tcp"
        ports = ["22"]
    }
}

resource "google_dns_record_set" "www" {
    name = "dokonb.cr460lab.com."
    type = "A"
    ttl = 300
    managed_zone = "cr460lab"
    rrdatas = ["${google_compute_instance.instance1.network_interface.0.access_config.0.assigned_nat_ip}"]
}
