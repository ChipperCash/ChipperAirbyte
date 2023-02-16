metadata {
  path = "postgres"
  name = "deploy"
}

step "terraform-init" {
  wkdir   = "postgres/terraform"
  target  = "postgres/terraform"
  command = "terraform"

  args = [
    "init",
    "-upgrade",
  ]

  sha     = "h1:mJ5No9tRCI0Z2zu7oYiJNS5ZtZwXiEdGNbxNSjsAGRE="
  retries = 0
  verbose = false
}

step "terraform-apply" {
  wkdir   = "postgres/terraform"
  target  = "postgres/terraform"
  command = "terraform"

  args = [
    "apply",
    "-auto-approve",
  ]

  sha     = "h1:mJ5No9tRCI0Z2zu7oYiJNS5ZtZwXiEdGNbxNSjsAGRE="
  retries = 2
  verbose = false
}

step "terraform-output" {
  wkdir   = "postgres"
  target  = "postgres/terraform"
  command = "plural"

  args = [
    "output",
    "terraform",
    "postgres",
  ]

  sha     = "h1:mJ5No9tRCI0Z2zu7oYiJNS5ZtZwXiEdGNbxNSjsAGRE="
  retries = 0
  verbose = false
}

step "kube-init" {
  wkdir   = "postgres"
  target  = "postgres/.plural/NONCE"
  command = "plural"

  args = [
    "wkspace",
    "kube-init",
  ]

  sha     = "2b0a0fb65683fcb450382b83d71d89c1b8ba096ae71d2ed038fe67dc6d82d7be"
  retries = 0
  verbose = false
}

step "crds" {
  wkdir   = "postgres"
  target  = "postgres/crds"
  command = "plural"

  args = [
    "wkspace",
    "crds",
    "postgres",
  ]

  sha     = "h1:copmgn9ngt8ifBRwxGQ+GXUgx7wmLdCA/InC6/5DUkU="
  retries = 0
  verbose = false
}

step "bounce" {
  wkdir   = "postgres"
  target  = "postgres/helm"
  command = "plural"

  args = [
    "wkspace",
    "helm",
    "postgres",
  ]

  sha     = "h1:iRB7EKV0n/ernI3CToUGnx+8TapmX5BhqBPpt1LvsgE="
  retries = 2
  verbose = false
}
