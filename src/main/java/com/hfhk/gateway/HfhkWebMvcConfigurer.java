package com.hfhk.gateway;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.web.reactive.config.CorsRegistry;
import org.springframework.web.reactive.config.WebFluxConfigurer;

import java.time.Duration;

@Configuration
public class HfhkWebMvcConfigurer implements WebFluxConfigurer {
	@Override
	public void addCorsMappings(CorsRegistry registry) {
		//设置允许跨域的路径
		registry.addMapping("/**")
			.allowedOrigins("*")
			.allowCredentials(true)
			.allowedHeaders("*")
			.allowedMethods(HttpMethod.OPTIONS.name(), HttpMethod.POST.name(), HttpMethod.DELETE.name(), HttpMethod.PUT.name(), HttpMethod.PATCH.name())
			//跨域允许时间
			.maxAge(Duration.ofDays(30).toSeconds());
	}

}
