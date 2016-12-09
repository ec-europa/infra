s3-bucket:
  pkg.installed:
    - pkgs:
        - automake
        - autotools-dev
        - g++
        - git
        - libcurl4-gnutls-dev
        - libfuse-dev
        - libssl-dev
        - libxml2-dev
        - make
        - pkg-config

/opt/s3fsfuse-build.sh:
  file.managed:
    - mode: 755
    - template: jinja
    - source: salt://S3Bucket/files/s3fsfuse-build.sh

/opt/run-migration.sh:
  file.managed:
    - mode: 755
    - template: jinja
    - source: salt://S3Bucket/files/run-migration.sh

Run_s3fsfuse-build.sh:
  cmd.run:
    - name: /opt/s3fsfuse-build.sh
    - runas: root
    - output_loglevel: DEBUG
    - cwd: /opt
    - stateful: True

/mnt/s3fs/joinup:
  file.directory:
    - file_mode: 774
    - dir_mode: 775
    - makedirs: True
  mount.mounted:
    - device: joinup2
    - fstype: fuse.s3fs
    - opts: allow_other,umask=0002
    - mkmnt: True
