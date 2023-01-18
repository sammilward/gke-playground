variable "project_id" {
  type        = string
  default     = "gke-playground-374709"
}

variable "cluster_name" {
  type        = string
  default     = "gke-playground-374709-gke"
}

variable "region" {
  type        = string
  default     = "europe-west1-b"
}

variable "network" {
  type        = string
  default     = "default"
}

variable "subnet" {
  type        = string
  default     = "projects/gke-playground-374709/regions/europe-west1/subnetworks/default"
}

variable "machine_type" {
  type        = string
  default     = "e2-standard-4"
}

variable "min_node_count" {
  type        = number
  default     = "1"
}

variable "max_node_count" {
  type        = number
  default     = "5"
}
