package AOP.aop02;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestAop02 {

	@Test
	public void testAop() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("AOP/aop02/beans.xml");
		OrderInfoDao od = (OrderInfoDao)ac.getBean("dao");
		od.getAll();
	}
	
}
