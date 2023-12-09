resource "aws_security_group" "sg_self" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id
  tags = {
    Name    = var.sg_name
    Project = var.project_name
  }
}

resource "aws_security_group_rule" "ingress_rule" {
  for_each = { for index, rule in var.ingress_rules : rule.rule_name => rule }

  type              = "ingress"
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.ip_protocol
  cidr_blocks       = [each.value.cidr_ipv4]
  security_group_id = aws_security_group.sg_self.id
}


resource "aws_security_group_rule" "egress_rule" {
  for_each = { for index, rule in var.egress_rules : rule.rule_name => rule }

  type              = "egress"
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.ip_protocol
  cidr_blocks       = [each.value.cidr_ipv4]
  security_group_id = aws_security_group.sg_self.id
}



