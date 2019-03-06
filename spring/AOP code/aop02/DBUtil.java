package AOP.aop02;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class DBUtil {
	
	private boolean flag;
	
	@Pointcut("execution(* AOP.aop02.*.*())")
	private void any(){}
	//打开连接
	@Before("any()")
	public void getConn() throws InterruptedException {
		System.out.println("开始连接到数据库loading...");
//		flag = true;
//		String dot = ".";
//		while(flag) {
//			if (dot.length() > 3) {
//				dot = ".";
//			}
//			System.out.println("正在与数据库连接" + dot);
//			Thread.sleep(1000);
//			dot += ".";
//		}
		
	}
	//关闭连接
	@After("any()")
	public void close() {
		System.out.println("已关闭数据库连接");
	}

}
