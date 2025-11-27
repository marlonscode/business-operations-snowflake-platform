variable "slack_webhook_url" {
  description = "The Slack webhook URL for sending notifications"
  type        = string
  sensitive   = true
}

variable "alpha_vantage_api_key" {
  description = "API key for Alpha Vantage"
  type        = string
  sensitive   = true
}