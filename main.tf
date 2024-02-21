resource "aws_instance" "my_instance" {

  count                       = 2
  ami                         = "ami-08f0bc76ca5236b20"
  instance_type               = "t3.small"
  key_name                    = var.key_pair
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = ["${aws_security_group.security_group.id}"]

  root_block_device {
    delete_on_termination = true
    volume_size           = "8"
  }

  tags = {
    "project" = "splunk_sandbox"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  user_data_base64 = base64encode(templatefile("cloudinit/userdata.tmpl", {
    gen_key = var.pub_key
  }))
}