resource "aws_ssm_parameter" "ConnectionStrings__DefaultConnection" {
  name = var.parameter_name
  type = "String"
  value = "Host=${var.address};Database=${var.dbname};Username=${var.username};Password=${var.password}"
}


resource "aws_ssm_parameter" "AllowedHosts" {
  name = var.parameter_name_AllowedHosts
  type = "String"
  value = var.AllowedHosts_value
}

resource "aws_ssm_parameter" "Logging__LogLevel__Default" {
  name = var.parameter_name_Logging__LogLevel__Default
  type = "String"
  value = var.Logging__LogLevel__Default_value
}

resource "aws_ssm_parameter" "Logging__LogLevel__Microsoft" {
  name = var.parameter_name_Logging__LogLevel__Microsoft
  type = "String"
  value = var.Logging__LogLevel__Microsoft_value
}