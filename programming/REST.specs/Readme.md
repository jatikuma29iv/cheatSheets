# REST spec

# Spec

In 2008, Leonard Richardson [introduced a maturity model](https://www.crummy.com/writing/speaking/2008-QCon/act3.html) for web services, based on the three primary technologies in the web stack:

-   URI
-   HTTP
-   Hypermedia

### URI

URI's are defined by [RFC 3986](https://tools.ietf.org/html/rfc3986).

### HTTP

HTTP is currently defined by

-   [RFC 7230](https://tools.ietf.org/html/rfc7230) -- Message Syntax and Routing
-   [RFC 7231](https://tools.ietf.org/html/rfc7231) -- Semantics and Content
-   [RFC 7232](https://tools.ietf.org/html/rfc7232) -- Conditional Requests
-   [RFC 7233](https://tools.ietf.org/html/rfc7233) -- Range Requests
-   [RFC 7234](https://tools.ietf.org/html/rfc7234) -- Caching
-   [RFC 7235](https://tools.ietf.org/html/rfc7235) -- Authentication

### Hypermedia

This is the hard one. The ubiquitous hypermedia media type is still HTML, you could start with [HTML 5.2](https://www.w3.org/TR/html52/).

A number of API try to use [JSON](https://tools.ietf.org/html/rfc8259), but JSON doesn't define _links_; so if you want to go that route, you need to find a JSON variant which defines links.

[Kevin Sookocheff wrote](https://sookocheff.com/post/api/on-choosing-a-hypermedia-format/) a nice overview of some options

-   [JSON-LD](https://json-ld.org/)
-   [HAL](http://stateless.co/hal_specification.html)
-   [Collection+JSON](http://amundsen.com/media-types/collection/)
-   [SIREN](https://github.com/kevinswiber/siren)

# Ref

https://restcookbook.com/

https://www.restapitutorial.com/

