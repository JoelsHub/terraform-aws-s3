resource "aws_s3_bucket_policy" "bucket_policy_log" {
    count = var.create_logging_bucket ? 1 : 0
  bucket = aws_s3_bucket.s3_nolog[count.index].id
  policy = jsonencode(
    {
          Id        = "BUCKET-POLICY"
          Statement = [
              {
                  Action    = "s3:*"
                  Condition = {
                      Bool = {
                          "aws:SecureTransport" = "false"
                        }
                    }
                  Effect    = "Deny"
                  Principal = "*"
                  Resource  = [
                      "arn:aws:s3:::${aws_s3_bucket.s3_log[count.index].id}/*",
                      "arn:aws:s3:::${aws_s3_bucket.s3_log[count.index].id}",
                    ]
                  Sid       = "AllowSSLRequestsOnly"
                },
            ]
          Version   = "2012-10-17"
        }
    )
}

resource "aws_s3_bucket_policy" "bucket_policy_nolog" {
    count = var.create_logging_bucket ? 0 : 1
  bucket = aws_s3_bucket.s3_log[count.index].id
  policy = jsonencode(
    {
          Id        = "BUCKET-POLICY"
          Statement = [
              {
                  Action    = "s3:*"
                  Condition = {
                      Bool = {
                          "aws:SecureTransport" = "false"
                        }
                    }
                  Effect    = "Deny"
                  Principal = "*"
                  Resource  = [
                      "arn:aws:s3:::${aws_s3_bucket.s3_nolog[count.index].id}/*",
                      "arn:aws:s3:::${aws_s3_bucket.s3_nolog[count.index].id}",
                    ]
                  Sid       = "AllowSSLRequestsOnly"
                },
            ]
          Version   = "2012-10-17"
        }
    )
}

resource "aws_s3_bucket_policy" "logging_bucket_policy" {
    count = var.create_logging_bucket ? 1 : 0
    bucket = aws_s3_bucket.logging_bucket[count.index].id
    policy = jsonencode(
    {
          Id        = "BUCKET-POLICY"
          Statement = [
              {
                  Action    = "s3:*"
                  Condition = {
                      Bool = {
                          "aws:SecureTransport" = "false"
                        }
                    }
                  Effect    = "Deny"
                  Principal = "*"
                  Resource  = [
                      "arn:aws:s3:::${aws_s3_bucket.logging_bucket[count.index].id}/*",
                      "arn:aws:s3:::${aws_s3_bucket.logging_bucket[count.index].id}",
                    ]
                  Sid       = "AllowSSLRequestsOnly"
                },
            ]
          Version   = "2012-10-17"
        }
    )
}