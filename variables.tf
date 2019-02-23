variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = "basic"  
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "A list of availability zones, in which to create the subnets."
  default     = ["a", "b", "c"]
}

variable "subnet_cidr_newbits" {
  description = "The number of bits to append to the VPC cidr to build the cidr of the subnets. For example if the VPC cidr is 10.0.0.0/16 and this value is 4, 20 bits are used for the network part for the subnets (first subdnet would be created with cidr 10.0.0.0/20)."
  default     = 4
}

variable "subnet_ipv6_cidr_newbits" {
  description = "The number of bits to append to the VPC IPv6 cidr (always /56) to build the IPv6 cidr of the subnets. For example if this value is 8, 64 bits are used for the network part for the subnets."
  default     = 8
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  default     = "public"
}

variable "protected_subnet_suffix" {
  description = "Suffix to append to protected subnets name"
  default     = "protected"
}

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  default     = "private"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  default     = {}
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  default     = {}
}

variable "protected_subnet_tags" {
  description = "Additional tags for the public subnets"
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for the public subnets"
  default     = {}
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  default     = {}
}

variable "egress_igw_tags" {
  description = "Additional tags for the egress internet gateway"
  default     = {}
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route table"
  default     = {}
}