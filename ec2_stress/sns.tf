resource "aws_sns_topic" "sns_example" {
  name = "email-example"
}

resource "aws_sns_topic_subscription" "email_example" {
  topic_arn = aws_sns_topic.sns_example.arn
  protocol  = "email"
  endpoint  = var.email_example
}