resource "aws_autoscaling_policy" "cpu_up" {
    name = format("%s-nodes-cpu-scale-up", var.CLUSTER_NAME)
    adjustment_type = "ChangeInCapacity"

    cooldown                = lookup(var.AUTO_SCALE_CPU, "scale_up_cooldown")
    scaling_adjustment      = lookup(var.AUTO_SCALE_CPU, "scale_up_add")

    autoscaling_group_name = aws_eks_node_group.cluster.resources[0].autoscaling_groups[0].name
}

resource "aws_cloudwatch_metric_alarm" "cpu_up" {

    alarm_name = format("%s-nodes-cpu-high", var.CLUSTER_NAME)

    comparison_operator = "GreaterThanOrEqualToThreshold"
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    statistic           = "Average"

    evaluation_periods  = lookup(var.AUTO_SCALE_CPU, "scale_up_evaluation")
    period              = lookup(var.AUTO_SCALE_CPU, "scale_up_period")
    threshold           = lookup(var.AUTO_SCALE_CPU, "scale_up_threshold")

    dimensions = {
        AutoScalingGroupName = aws_eks_node_group.cluster.resources[0].autoscaling_groups[0].name
    }

    alarm_actions = [ aws_autoscaling_policy.cpu_up.arn ]
  
}

resource "aws_autoscaling_policy" "cpu_down" {
    name = format("%s-nodes-cpu-scale-down", var.CLUSTER_NAME)
    adjustment_type = "ChangeInCapacity"

    cooldown                = lookup(var.AUTO_SCALE_CPU, "scale_down_cooldown")
    scaling_adjustment      = lookup(var.AUTO_SCALE_CPU, "scale_down_remove")

    autoscaling_group_name = aws_eks_node_group.cluster.resources[0].autoscaling_groups[0].name
}

resource "aws_cloudwatch_metric_alarm" "cpu_down" {

    alarm_name = format("%s-nodes-cpu-low", var.CLUSTER_NAME)

    comparison_operator = "LessThanOrEqualToThreshold"
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    statistic           = "Average"

    evaluation_periods  = lookup(var.AUTO_SCALE_CPU, "scale_down_evaluation")
    period              = lookup(var.AUTO_SCALE_CPU, "scale_down_period")
    threshold           = lookup(var.AUTO_SCALE_CPU, "scale_down_threshold")

    dimensions = {
        AutoScalingGroupName = aws_eks_node_group.cluster.resources[0].autoscaling_groups[0].name
    }

    alarm_actions = [ aws_autoscaling_policy.cpu_down.arn ]
  
}