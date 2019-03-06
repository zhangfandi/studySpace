package AOP.aop03;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestAop03 {

	@Test
	public void testAop() throws InterruptedException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("AOP/aop03/beans.xml");
		FileController fc = (FileController)ac.getBean("fc");
		fc.doUpLoad();
	}
	
}
