# Solr5 basic usage instructions

*download the container*
```sh
docker pull fpfis/solr5
```

*run the container*
```sh
docker run --name solr5.local --rm -p 8983:8983 -it fpfis/solr5
```

*test the connection*
```sh
curl -v http://localhost:8983/solr/
*   Trying 127.0.0.1...
* Connected to localhost (127.0.0.1) port 8983 (#0)
> GET /solr/ HTTP/1.1
> Host: localhost:8983
> User-Agent: curl/7.47.1
> Accept: */*
>
< HTTP/1.1 200 OK
< X-Frame-Options: DENY
< Content-Type: text/html; charset=UTF-8
< Content-Length: 6288
<
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>

<!--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements...
```

