aws s3 cp s3://aws-codedeploy-us-east-1/latest/install /tmp/cd-install –region

aws-stack:
  pkg.installed:
    - pkgs:
      - python-pip
      - ruby2.0
      - awscli


