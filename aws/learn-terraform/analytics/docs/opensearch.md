# AWS OpenSearch 

- Amazon OpenSearch lets you **search, analyze, and visualize** your data in real-time. This service manages the capacity, scaling, patching, and administration of your Elasticsearch clusters for you, while still giving you direct access to the Elasticsearch APIs.

- The service offers open-source Elasticsearch APIs, managed Kibana, and integrations with Logstash and other AWS Services. This combination is often coined as the ELK Stack.

## Data Ingestion

- Easily ingest structured and unstructured data into your Amazon Elasticsearch domain with Logstash, an open-source data pipeline that helps you process logs and other event data.

## Kibana and Logstash

- Kibana is a popular open source visualization tool designed to work with Elasticsearch.
- The URL is elasticsearch-domain-endpoint/_plugin/kibana/.
- You can configure your own Kibana instance aside from using the default provided Kibana.
- Amazon OpenSearch uses Amazon Cognito to offer username and password protection for Kibana. (Optional feature)

## References

https://tutorialsdojo.com/amazon-opensearch-service/

https://docs.aws.amazon.com/opensearch-service/latest/developerguide/walkthrough.html#walkthrough-analysis