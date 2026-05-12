resource "aws_cloudwatch_log_group" "this" {
	name              = "/aws/lambda/hellow-world"
	retention_in_days = 14

	tags = {
		"cloudlab" = "c203865a5200625l14544807t1w623933043284"
	}
	
}