/*
 * The region to be used.
 * https://www.terraform.io/docs/providers/aws/d/region.html
 */
data "aws_region" "current" {}

/*
 * Retrieve the AZ where we want to create network resources
 * This must be in the region selected on the AWS provider.
 * https://www.terraform.io/docs/providers/aws/d/availability_zone.html
 */
data "aws_availability_zone" "availability_zones" {
    count = "${length(var.availability_zones)}"
    
    name = "${data.aws_region.current.name}${element(var.availability_zones, count.index)}"
}

