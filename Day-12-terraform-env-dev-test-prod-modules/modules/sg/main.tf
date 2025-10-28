// modules/sg/main.tf
// Reusable AWS Security Group module that can reference other security groups and CIDR rules.

variable "name" {
    type        = string
    description = "Name of the security group"
}

variable "description" {
    type        = string
    default     = "Managed by Terraform"
}

variable "vpc_id" {
    type        = string
    description = "VPC ID where the security group will be created"
}

variable "ingress_cidrs" {
    type = list(object({
        cidr        = string
        from_port   = number
        to_port     = number
        protocol    = string
        description = optional(string)
    }))
    default = []
    description = "List of ingress rules that use CIDR blocks"
}

variable "ingress_security_groups" {
    type = list(object({
        source_security_group_id = string
        from_port                = number
        to_port                  = number
        protocol                 = string
        description              = optional(string)
    }))
    default = []
    description = "List of ingress rules that allow traffic from other security group IDs"
}

variable "egress_rules" {
    type = list(object({
        cidr        = string
        from_port   = number
        to_port     = number
        protocol    = string
        description = optional(string)
    }))
    default = [{
        cidr      = "0.0.0.0/0"
        from_port = 0
        to_port   = 0
        protocol  = "-1"
    }]
    description = "Egress rules (defaults to allow all outbound)"
}

variable "tags" {
    type    = map(string)
    default = {}
}

resource "aws_security_group" "this" {
    name        = var.name
    description = var.description
    vpc_id      = var.vpc_id
    tags        = var.tags
}

resource "aws_security_group_rule" "ingress_cidr" {
    for_each = { for idx, r in var.ingress_cidrs : tostring(idx) => r }

    type              = "ingress"
    from_port         = each.value.from_port
    to_port           = each.value.to_port
    protocol          = each.value.protocol
    cidr_blocks       = [each.value.cidr]
    security_group_id = aws_security_group.this.id
    description       = lookup(each.value, "description", null)
}

resource "aws_security_group_rule" "ingress_sg" {
    for_each = { for idx, r in var.ingress_security_groups : tostring(idx) => r }

    type                     = "ingress"
    from_port                = each.value.from_port
    to_port                  = each.value.to_port
    protocol                 = each.value.protocol
    source_security_group_id = each.value.source_security_group_id
    security_group_id        = aws_security_group.this.id
    description              = lookup(each.value, "description", null)
}

resource "aws_security_group_rule" "egress" {
    for_each = { for idx, r in var.egress_rules : tostring(idx) => r }

    type              = "egress"
    from_port         = each.value.from_port
    to_port           = each.value.to_port
    protocol          = each.value.protocol
    cidr_blocks       = [each.value.cidr]
    security_group_id = aws_security_group.this.id
    description       = lookup(each.value, "description", null)
}

output "security_group_id" {
    value = aws_security_group.this.id
}

output "security_group_name" {
    value = aws_security_group.this.name
}

output "security_group_arn" {
    value = aws_security_group.this.arn
}