data "aws_iam_policy_document" "site" {
  statement {
    effect = "Allow"
    principals {
      identifiers = module.cdn.cloudfront_origin_access_identity_iam_arns
      type        = "AWS"
    }
    actions   = ["s3:GetObject"]
    resources = ["${module.site.bucket_arn}/*"]
  }
}

data "aws_caller_identity" "current" {}

locals {
  site_domain = var.domain
  mime_types = {
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
    mp4  = "video/mp4"
    jpg  = "image/jpeg"
  }
}

module "site" {
  source      = "../s3"
  bucket_name = var.domain
  environment = var.environment
}

resource "aws_s3_bucket_policy" "this" {
  bucket = module.site.s3_bucket_id
  policy = data.aws_iam_policy_document.site.json
}

resource "aws_s3_object" "website-object" {
  bucket       = module.site.s3_bucket_id
  for_each     = { for f in fileset("./files/", "**/*") : f => f if f != "index.html.old" }
  key          = each.value
  source       = "./files/${each.value}"
  etag         = filemd5("./files/${each.value}")
  content_type = lookup(local.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}