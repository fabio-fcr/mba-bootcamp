resource "aws_vpc" "BootCamp" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "BootCamp"
  }
}