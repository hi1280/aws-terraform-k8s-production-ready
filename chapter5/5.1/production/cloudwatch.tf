resource "aws_cloudwatch_metric_alarm" "front_end_elb_5XX_count" {

  alarm_name        = "front-end-elb-5XX-count"
  alarm_description = "front-endのALBからの5XXサーバエラーの数"

  alarm_actions = ["arn:aws:sns:ap-northeast-1:123456789012:slack"] # 変更箇所
  ok_actions    = ["arn:aws:sns:ap-northeast-1:123456789012:slack"] # 変更箇所

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = 100

  datapoints_to_alarm = 1
  treat_missing_data  = "notBreaching"

  metric_name = "HTTPCode_Target_5XX_Count"
  namespace   = "AWS/ApplicationELB"
  period      = "60"
  statistic   = "Sum"

  dimensions = {
    LoadBalancer = aws_lb.example.arn_suffix
  }
}