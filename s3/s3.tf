variable "bucketname" {}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucketname}"
  acl = "public"
  force_destroy = "true"

 

}

resource "aws_iam_user" "s3" {
    name = "${var.bucketname}-s3"
    force_destroy = "true"
}

resource "aws_iam_access_key" "s3" {
    user = "${aws_iam_user.s3.name}"
}

resource "aws_iam_user_policy" "s3_policy" {
    name = "${var.bucketname}-s3-policy"
    user = "${aws_iam_user.s3.name}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::${var.bucketname}",
        "arn:aws:s3:::${var.bucketname}/*"
      ]
    }
  ]
}
EOF
}

output "iam_access_key_id" {
  value = "${aws_iam_access_key.s3.id}"
}
output "iam_access_key_secret" {
  value = "${aws_iam_access_key.s3.secret}"
}
output "bucket" {
    value = "${aws_s3_bucket.bucket.bucket}"
}
output "bucket_id" {
    value = "${aws_s3_bucket.bucket.id}"
}