package AOP.aop03;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class Perform {
	
	private long bgTime;
	@Before("any()")//记录开始时间
	public void start() {
		bgTime = System.currentTimeMillis();
	}
	@After("any()")//记录结束时间
	public void end() {
		long endTime = System.currentTimeMillis();
		System.out.println("运行耗时：" + (endTime - bgTime));
	}
	
	@Pointcut("execution(* AOP.aop03.*.*(..))")
	public void any(){}
	
}
