# AWS CloudFront

- Content Delivery Network (CDN)
- 216 Points of Presence globally (edge locations)
- DDos protection (because worldwide), integration with Shield, AWS Web Application Firewall (WAF)



## CloudFront Settings

- Origin Control Policy (OCP): setting determines whether cloudfront connects to your origin using HTTP or HTTPS, or matches(Match Viewer) the protocol that the viewer used to connect to CloudFront
- Origin Request Policy (ORP): setting determines whether CloudFront caches the response from your origin and, if so, under what conditions
- Origin Access Identity (OAI): setting determines whether CloudFront uses an origin access identity (OAI) to require users to access your files using a CloudFront URL instead of the Amazon S3 URL
- Custom Headers: setting whether to add custom headers to requests that CloudFront sends to your origin
- Behavior Settings: setting determines whether CloudFront caches the response from your origin and, if so, under what conditions
- Origin Groups: setting determines whether CloudFront distributes requests across multiple origins or sends all requests to a single origin


## References

https://tutorialsdojo.com/amazon-cloudfront/

S3 Pre-signed URLs vs CloudFront Signed URLs vs Origin Access Identity (OAI)

https://tutorialsdojo.com/s3-pre-signed-urls-vs-cloudfront-signed-urls-vs-origin-access-identity-oai/