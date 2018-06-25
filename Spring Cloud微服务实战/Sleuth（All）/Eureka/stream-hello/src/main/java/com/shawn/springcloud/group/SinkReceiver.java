package com.shawn.springcloud.group;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.stream.annotation.EnableBinding;
import org.springframework.cloud.stream.annotation.StreamListener;
import org.springframework.cloud.stream.messaging.Sink;

@EnableBinding(value = { Sink.class })
public class SinkReceiver {

	private static Logger logger = LoggerFactory.getLogger(SinkReceiver.class);

	@StreamListener(Sink.INPUT)
	public void receive(User user) {
		logger.info("Received：" + user);
	}
}