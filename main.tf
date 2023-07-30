module "cadvisor" {
  source                 = "./modules/cadvisor"
  cluster_name           = var.cluster_name
  enable_cadvisor        = var.enable_cadvisor
  cadvisor_name          = var.cadvisor_name
  cadvisor_chart_name    = var.cadvisor_chart_name
  cadvisor_template_path = var.cadvisor_template_path
}

module "cloudwatch" {
  source                         = "./modules/cloudwatch"
  cluster_name                   = var.cluster_name
  fluent_bit_template_path       = var.fluent_bit_template_path
  enable_fluent_bit              = var.enable_fluent_bit
  enable_cloudwatch_agent        = var.enable_cloudwatch_agent
  cloudwatch_agent_template_path = var.cloudwatch_agent_template_path

}

module "metrics_server" {
  source                      = "./modules/metrics-server"
  cluster_name                = var.cluster_name
  metrics_server_chart_name   = var.metrics_server_chart_name
  metrics_server_release_name = var.metrics_server_release_name
  metrics_server_version      = var.metrics_server_version
  metrics_server_chart_repo   = var.metrics_server_chart_repo
  create_namespace            = var.create_namespace
  metrics_server_namespace    = var.metrics_server_namespace
}

module "aws_loadbalancer" {
  source                      = "./modules/aws-loadbalancer"
  cluster_name                = var.cluster_name
  ingress_gateway_name          = var.ingress_gateway_name
  ingress_gateway_iam_role      = var.ingress_gateway_iam_role
  ingress_gateway_chart_name    = var.ingress_gateway_chart_name
  ingress_gateway_chart_repo    = var.ingress_gateway_chart_repo
  ingress_gateway_chart_version = var.ingress_gateway_chart_version
}

module "cluster_autoscaler" {
  source                          = "./modules/cluster-autoscaler"
  cluster_name                    = var.cluster_name
  cluster_autoscaler_role_name    = var.cluster_autoscaler_role_name
  cluster_autoscaler_policy_name  = var.cluster_autoscaler_policy_name
  cluster_autoscaler_sa_name      = var.cluster_autoscaler_sa_name
  cluster_autoscaler_sa_namespace = var.cluster_autoscaler_sa_namespace
  cluster_autoscaler_policy_path  = var.cluster_autoscaler_policy_path
  cluster_oidc_provider_arn       = var.cluster_oidc_provider_arn
}

module "nginx_ingress" {
  source                      = "./modules/nginx-ingress"
  cluster_name                = var.cluster_name
  nginx_ingress_name          = var.nginx_ingress_name
  nginx_ingress_chart_name    = var.nginx_ingress_chart_name
  nginx_ingress_chart_repo    = var.nginx_ingress_chart_repo
  nginx_ingress_chart_version = var.nginx_ingress_chart_version
  # ingress_list                = var.ingress_list
  nginx_template_path = var.nginx_template_path
}

module "acm_manager" {
  source                      = "./modules/acm-manager"
}

module "service_account" {
  source = "./modules/service-account"

  for_each         = { for sa in var.service_accounts : sa.role_name => sa }
  policy_path      = each.value.policy_path
  condition_values = each.value.condition_values
  policy_name      = each.value.policy_name
  role_name        = each.value.role_name
  service_account  = each.value.service_account
  cluster_name     = each.value.cluster_name
  oidc_arn         = each.value.oidc_arn
}

module "aws-auth" {
  source = "./modules/awsauth"

  for_each         = { for aws_auth in var.aws_auths : aws_auth.role_metadata.name => aws_auth }
  additional_roles = each.value.additional_roles
  additional_users = each.value.additional_users
  role_metadata    = each.value.role_metadata
  rules = each.value.rules
  role_binding_name = each.value.role_binding_name
  subject_name = each.value.subject_name
}
