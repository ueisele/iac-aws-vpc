/* Creates a VPC in the region specified for the provider
 * https://www.terraform.io/docs/providers/aws/r/vpc.html
 * https://docs.aws.amazon.com/de_de/vpc/latest/userguide/what-is-amazon-vpc.html
 */
resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr_block}"
    assign_generated_ipv6_cidr_block = true

    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "${var.unit_id}-main"
        UnitId = "${var.unit_id}"
    }
}

/*
 * Subnet which is publicly available through an Internet getway
 * https://www.terraform.io/docs/providers/aws/r/subnet.html
 * https://www.terraform.io/docs/configuration/interpolation.html
 * https://docs.aws.amazon.com/de_de/vpc/latest/userguide/VPC_Internet_Gateway.html
 */
resource "aws_subnet" "public" {
    count = "${length(data.aws_availability_zone.availability_zones.*.name)}"

    vpc_id            = "${aws_vpc.main.id}"
    availability_zone = "${element(data.aws_availability_zone.availability_zones.*.name, count.index)}"
    cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, var.subnet_cidr_newbits, count.index)}"
    ipv6_cidr_block   = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, var.subnet_ipv6_cidr_newbits, count.index)}"
    
    map_public_ip_on_launch = true
    assign_ipv6_address_on_creation = true

    tags = {
        Name = "${var.unit_id}-public"
        UnitId = "${var.unit_id}"
    }
}

/*
 * Subnet which is not publicly available but can access the internet through a NAT gateway (IPv4) and an Egress only Internet gateway (IPv6)
 * https://www.terraform.io/docs/providers/aws/r/subnet.html
 * https://www.terraform.io/docs/configuration/interpolation.html
 * https://docs.aws.amazon.com/de_de/vpc/latest/userguide/vpc-nat-gateway.html
 * https://docs.aws.amazon.com/de_de/vpc/latest/userguide/egress-only-internet-gateway.html 
 */
resource "aws_subnet" "protected" {
    count = "${length(data.aws_availability_zone.availability_zones.*.name)}"

    vpc_id            = "${aws_vpc.main.id}"
    availability_zone = "${element(data.aws_availability_zone.availability_zones.*.name, count.index)}"
    cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, var.subnet_cidr_newbits, count.index + length(data.aws_availability_zone.availability_zones.*.name))}"
    ipv6_cidr_block   = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, var.subnet_ipv6_cidr_newbits, count.index + length(data.aws_availability_zone.availability_zones.*.name))}"
    
    map_public_ip_on_launch = true
    assign_ipv6_address_on_creation = true

    tags = {
        Name = "${var.unit_id}-protected"
        UnitId = "${var.unit_id}"
    }
}

/*
 * Subnet which is completely private and therefore cannot access the internet
 * https://www.terraform.io/docs/providers/aws/r/subnet.html
 * https://www.terraform.io/docs/configuration/interpolation.html
 */
resource "aws_subnet" "private" {
    count = "${length(data.aws_availability_zone.availability_zones.*.name)}"

    vpc_id            = "${aws_vpc.main.id}"
    availability_zone = "${element(data.aws_availability_zone.availability_zones.*.name, count.index)}"
    cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, var.subnet_cidr_newbits, count.index + 2 * length(data.aws_availability_zone.availability_zones.*.name))}"
    ipv6_cidr_block   = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, var.subnet_ipv6_cidr_newbits, count.index + 2 * length(data.aws_availability_zone.availability_zones.*.name))}"
    
    map_public_ip_on_launch = true
    assign_ipv6_address_on_creation = true

    tags = {
        Name = "${var.unit_id}-private"
        UnitId = "${var.unit_id}"
    }
}