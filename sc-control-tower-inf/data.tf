data "http" "ip_whitelist" {
  url = "https://artifactory.kroger.com/artifactory/tf-modules/whitelists/ip/v0.1.11/cidr_list_output.json"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}