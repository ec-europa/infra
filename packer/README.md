#Packer reference

##Description

This will build the default Linux environment in either virtualbox/aws/docker used to run Joinup

##Build for AWS

```
packer build --var "aws_access_key=$AWS_ACCESS_KEY" --var "aws_secret_key=$AWS_SECRET_KEY" packer.json 
```

This assumes your AWS credentials are in your environment variables

##Build for Virtualbox

```
packer build virtualbox.json
```

##Build for Docker

Not implemented yet
