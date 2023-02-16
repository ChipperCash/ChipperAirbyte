metadata {
  path = "airbyte"
  name = "deploy"
}

step "terraform-init" {
  wkdir   = "airbyte/terraform"
  target  = "airbyte/terraform"
  command = "terraform"

  args = [
    "init",
    "-upgrade",
  ]

  sha     = "h1:F3VRv0zKj2DJab7t14lSTx9vrRX29fqpxkuBfqq46Ds="
  retries = 0
  verbose = false
}

step "terraform-apply" {
  wkdir   = "airbyte/terraform"
  target  = "airbyte/terraform"
  command = "terraform"

  args = [
    "apply",
    "-auto-approve",
  ]

  sha     = "h1:F3VRv0zKj2DJab7t14lSTx9vrRX29fqpxkuBfqq46Ds="
  retries = 2
  verbose = false
}

step "terraform-output" {
  wkdir   = "airbyte"
  target  = "airbyte/terraform"
  command = "plural"

  args = [
    "output",
    "terraform",
    "airbyte",
  ]

  sha     = "h1:F3VRv0zKj2DJab7t14lSTx9vrRX29fqpxkuBfqq46Ds="
  retries = 0
  verbose = false
}

step "kube-init" {
  wkdir   = "airbyte"
  target  = "airbyte/.plural/NONCE"
  command = "plural"

  args = [
    "wkspace",
    "kube-init",
  ]

  sha     = "4261f783a88b5fc22ece4cb07569a3a4fdda8dc305fd8141532f0b38a9d2017a"
  retries = 0
  verbose = false
}

step "crds" {
  wkdir   = "airbyte"
  target  = "airbyte/crds"
  command = "plural"

  args = [
    "wkspace",
    "crds",
    "airbyte",
  ]

  sha     = "h1:47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU="
  retries = 0
  verbose = false
}

step "bounce" {
  wkdir   = "airbyte"
  target  = "airbyte/helm"
  command = "plural"

  args = [
    "wkspace",
    "helm",
    "airbyte",
  ]

  sha     = "h1:0R6XXqMFEm4cbf1p9D69Gjn19Jxi9HRDzw3fvbJ6akA="
  retries = 2
  verbose = false
}
