variable "unit_id" {
    default = "basic"  
}

/* AWS regions and availability zones
 * https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html
 */
variable "region" {
    default = "us-east-2"
}

variable "availability_zones" {
    default = ["a", "b", "c"]
}

variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}

variable "subnet_cidr_newbits" {
  default = 4
}

variable "subnet_ipv6_cidr_newbits" {
  default = 8
}