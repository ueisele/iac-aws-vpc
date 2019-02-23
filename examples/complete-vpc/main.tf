module "vpc" {
  source                    = "../.."

  name                      = "example-complete-vpc"
  cidr                      = "10.0.0.0/16"
  availability_zones        = ["a", "b", "c"]
  subnet_cidr_newbits       = 4
  subnet_ipv6_cidr_newbits  = 8

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  vpc_tags = {
    SomeVPCTag = "someTag"
  }

  subnet_tags = {
    SomeSubnetTag       = "someTag"
  }
}