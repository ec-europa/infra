/mnt/shared:
  file.directory:
    - user: root
    - group: root
    - file_mode: 777
    - dir_mode: 777
    - makedirs: True

  mount.mounted:
    - device: fs-03f539ca.efs.eu-west-1.amazonaws.com:/
    - fstype: nfs4
    - opts: nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2
    - mkmnt: True