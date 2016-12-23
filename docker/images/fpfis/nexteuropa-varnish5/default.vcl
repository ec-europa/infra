vcl 4.0;

import std;
import drupal7;
import cookie;
import header;
import vsthrottle;

backend default {
  .host = "web";
  .port = "80";
}

include "nexteuropa/nexteuropa.vcl";
