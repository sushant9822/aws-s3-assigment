regions = {
  prod = "ap-south-1"
}
environment = {
  prod = {
    region  = "ap-south-1"
    profile = "personal"
    azs = [
      "ap-south-1a",
      "ap-south-1b",
      "ap-south-1c"
    ]
    vpc_conf = {
      vpc_cidr_block  = "10.40.0.0/20"
      private_subnets = ["10.40.1.0/24", "10.40.2.0/24", "10.40.3.0/24"]
      public_subnets  = ["10.40.4.0/24", "10.40.5.0/24", "10.40.6.0/24"]

    }
  }
}