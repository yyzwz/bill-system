package cn.zwz;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.activiti.spring.boot.SecurityAutoConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.core.task.TaskExecutor;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

/**
 * @author 郑为中
 */
// Activiti5.22需要排除
@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
// 启用JPA审计
@EnableJpaAuditing
// 启用缓存
@EnableCaching
// 启用异步
@EnableAsync
// 启用自带定时任务
@EnableScheduling
// 启用Admin监控
@EnableAdminServer
public class ZwzApplication {

    @Primary
    @Bean
    public TaskExecutor primaryTaskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        return executor;
    }

    public static void main(String[] args) {
        SpringApplication.run(ZwzApplication.class, args);
    }
}
