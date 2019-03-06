package AOP.aop03;

import java.util.Random;
//目标对象，核心功能类
public class FileController {
	//这个是连接点
	public void doUpLoad() throws InterruptedException {
		Random rd = new Random();
		long tim = rd.nextInt(1000);
		Thread.sleep(tim);
	}

}
