# はじめに
このWorkflowは、s3_waitオペレーターを使って、s3からデータを定期取り込みするWorkflowです。
詳細は以下のリンクをご確認ください。
https://docs.digdag.io/operators/s3_wait.html

# tips
1. ファイル名に日付を入れる。
`${moment(session_time).add(-1, 'days').format("YYYYMMDD")}  `
今日`2020/02/02` -> 前日日付の`20200201`が代入される。
1. Secrets設定
https://docs.digdag.io/command_reference.html#secrets

```
aws.s3.access_key_id, aws.access_key_id
- The AWS Access Key ID to use when accessing S3.

aws.s3.secret_access_key, aws.secret_access_key
- The AWS Secret Access Key to use when accessing S3.

aws.s3.region, aws.region
- An optional explicit AWS Region in which to access S3.

aws.s3.endpoint
- An optional explicit API endpoint to use when accessing S3. This overrides the region secret.

aws.s3.sse_c_key
- An optional Customer-Provided Server-Side Encryption (SSE-C) key to use when accessing S3. Must be Base64 encoded.

aws.s3.sse_c_key_algorithm
- An optional Customer-Provided Server-Side Encryption (SSE-C) key algorithm to use when accessing S3.

aws.s3.sse_c_key_md5
- An optional MD5 digest of the Customer-Provided Server-Side Encryption (SSE-C) key to use when accessing S3. Must be Base64 encoded.
```

