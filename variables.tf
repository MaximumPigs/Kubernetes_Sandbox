# provider information

variable "key_pair" {
  type    = string
  default = "MaximumPigs_Key_Pair"
}

# network information

variable "my_ip" {
  type    = string
  default = ""
}

variable "pub_key" {
  type    = string
  default = ""
}

variable "runner_access_enabled" {
  type    = bool
  default = true
}