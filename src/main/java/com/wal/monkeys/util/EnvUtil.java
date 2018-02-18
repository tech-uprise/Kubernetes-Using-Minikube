package com.wal.monkeys.util;

public class EnvUtil {
	
	private int adminPort = 9200; // ADMIN_PORT
	private int socketPort = 9300; // SOCKET_PORT
	private String elasticHost = "localhost"; // ELASTICSEARCH_HOST
	private String elasticIndex = "spring_elastic_kibana"; // ELASTICSEARCH_INDEX
	
	public int getAdminPort() {
		return adminPort;
	}
	public void setAdminPort(int adminPort) {
		this.adminPort = adminPort;
	}
	public int getSocketPort() {
		return socketPort;
	}
	public void setSocketPort(int socketPort) {
		this.socketPort = socketPort;
	}
	public String getElasticHost() {
		return elasticHost;
	}
	public void setElasticHost(String elasticHost) {
		this.elasticHost = elasticHost;
	}
	public String getElasticIndex() {
		return elasticIndex;
	}
	public void setElasticIndex(String elasticIndex) {
		this.elasticIndex = elasticIndex;
	}
	
	

}
