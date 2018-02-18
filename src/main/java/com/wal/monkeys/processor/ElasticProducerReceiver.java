package com.wal.monkeys.processor;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.entity.ContentType;
import org.apache.http.nio.entity.NStringEntity;
import org.apache.http.util.EntityUtils;
import org.elasticsearch.client.Response;
import org.elasticsearch.client.RestClient;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wal.monkeys.model.User;
import com.wal.monkeys.util.EnvUtil;

public class ElasticProducerReceiver {
	
	
	public RestClient getRestClient() {
		
		RestClient restClient = RestClient.builder(
		        new HttpHost(getEnvValue().getElasticHost(), getEnvValue().getAdminPort(), "http"),
		        new HttpHost(getEnvValue().getElasticHost(), getEnvValue().getSocketPort(), "http")).build();
		
			System.out.println("Rest Client: " +restClient.toString());
		
		return (restClient);		
	}
	
	public void sendRequest(String jsonString) {		
		try {			
			RestClient restClient = getRestClient();		
			//index the document
			HttpEntity entity = new NStringEntity(jsonString, ContentType.APPLICATION_JSON);
			
			System.out.println("Entity..:"+entity.toString());	
			
			String endpoint = "/"+getEnvValue().getElasticIndex()+"/post";
			
			System.out.println("End point in sendRequest(): "+endpoint);
			
			Response indexResponse = restClient.performRequest("POST",endpoint , Collections.<String, String>emptyMap(), entity);
			
			System.out.println("User Object as JSON String document has been sent to elasticsearch: ");
			
			System.out.println(EntityUtils.toString(indexResponse.getEntity()));
			
			System.out.println("Response code from the server: " +indexResponse.getStatusLine().getStatusCode());
				
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("Excetion in sendRequest(): "+e.getMessage());
			e.printStackTrace();
		}
		
	}
	
	public void sendDocument(User user)
	{
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			String userObjString = objectMapper.writeValueAsString(user);
			
			sendRequest(userObjString);
			
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			System.out.println("Excetion in sendDocument(): "+e.getMessage());
			e.printStackTrace();
		}
		
	}

	public void getDocuments()
	{
		
		try {
			RestClient restClient = getRestClient();
			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("q", "firstName:xyz");
			paramMap.put("pretty", "true");		
			String endpoint = "/"+getEnvValue().getElasticIndex()+"/_search";
			System.out.println("End point in getDocuement(): "+endpoint);
			//Response response = restClient.performRequest("GET", "/spring/_search", paramMap);
			Response response = restClient.performRequest("GET", endpoint);
				System.out.println(EntityUtils.toString(response.getEntity()));
				System.out.println("Host -" + response.getHost() );
				System.out.println("RequestLine -"+ response.getRequestLine() );
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("Excetion in getDocument(): "+e.getMessage());
			e.printStackTrace();
		}
		
	}
	
	private EnvUtil getEnvValue() {
		
		EnvUtil envUtil = new EnvUtil();
		
		try {
			Map<String, String> env = System.getenv();
			for (String envName : env.keySet()) {
			    System.out.println("Environment variables:");
	            System.out.format("%s=%s%n", envName, env.get(envName));
	            if(envName.equals("ADMIN_PORT")) {
	            		envUtil.setAdminPort(Integer.parseInt(env.get(envName)));
	            } else if (envName.equals("SOCKET_PORT")) {
	            		envUtil.setSocketPort(Integer.parseInt(env.get(envName)));
	            } else if (envName.equals("ELASTICSEARCH_HOST")) {
            			envUtil.setElasticHost(env.get(envName));
	            } else if (envName.equals("ELASTICSEARCH_INDEX")) {
            			envUtil.setElasticIndex(env.get(envName));
	            }
			}			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("Excetion in getEnvVariables():"+e.getMessage());
			e.printStackTrace();
		}
		return (envUtil);
	}
	

	
}