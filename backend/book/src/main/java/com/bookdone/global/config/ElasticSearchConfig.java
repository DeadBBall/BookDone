package com.bookdone.global.config;

import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.elasticsearch.client.ClientConfiguration;
import org.springframework.data.elasticsearch.client.RestClients;
import org.springframework.data.elasticsearch.config.AbstractElasticsearchConfiguration;
import org.springframework.data.elasticsearch.repository.config.EnableElasticsearchRepositories;

@Configuration
@EnableElasticsearchRepositories // elasticsearch repository 허용
public class ElasticSearchConfig extends AbstractElasticsearchConfiguration {

	@Value("${spring.elasticsearch.host}")
	String host;
	@Value("${spring.elasticsearch.port}")
	String port;

	@Override
	public RestHighLevelClient elasticsearchClient() {
		ClientConfiguration clientConfiguration = ClientConfiguration.builder()
			.connectedTo(host + ":" + port)
			.build();
		return RestClients.create(clientConfiguration).rest();
	}
}