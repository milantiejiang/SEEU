package com.fh.filter;

import java.io.IOException;
import java.net.UnknownHostException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

//import org.eclipse.jetty.server.Connector;
//import org.eclipse.jetty.server.Handler;
//import org.eclipse.jetty.server.Server;
//import org.eclipse.jetty.server.ServerConnector;
//import org.eclipse.jetty.server.handler.DefaultHandler;
//import org.eclipse.jetty.server.handler.HandlerList;
//import org.eclipse.jetty.server.session.SessionHandler;
//import org.eclipse.jetty.servlet.ServletContextHandler;
//import org.eclipse.jetty.servlet.ServletHolder;
import org.java_websocket.WebSocketImpl;
import org.quartz.Job;

import com.fh.plugin.websocketInstantMsg.ChatServer;
import com.fh.plugin.websocketOnline.OnlineChatServer;
import com.fh.util.Const;
import com.fh.util.DbFH;
import com.fh.util.QuartzManager;
import com.fh.util.TokenUpdateJob;
import com.fh.util.Tools;
import com.aliyun.oss.appservermaven.App;
import com.fh.controller.base.BaseController;

/**
 * 启动tomcat时运行此类 创建人：FH FH QQ 313596790[青苔] 创建时间：2014年2月17日
 * 
 * @version
 */
public class startFilter extends BaseController implements Filter {

	/**
	 * 初始化
	 */
	public void init(FilterConfig fc) throws ServletException {
		this.startWebsocketInstantMsg();
		this.startWebsocketOnline();
		this.reductionDbBackupQuartzState();
		this.tokenUpdate();
//		this.startOSSServer();
	}

	/**
	 * 启动即时聊天服务
	 */
	public void startWebsocketInstantMsg() {
		WebSocketImpl.DEBUG = false;
		ChatServer s;
		try {
			String strWEBSOCKET = Tools.readTxtFile(Const.WEBSOCKET);// 读取WEBSOCKET配置,获取端口配置
			if (null != strWEBSOCKET && !"".equals(strWEBSOCKET)) {
				String strIW[] = strWEBSOCKET.split(",fh,");
				if (strIW.length == 5) {
					s = new ChatServer(Integer.parseInt(strIW[1]));
					s.start();
				}
			}
			// System.out.println( "websocket服务器启动,端口" + s.getPort() );
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 启动在线管理服务
	 */
	public void startWebsocketOnline() {
		WebSocketImpl.DEBUG = false;
		OnlineChatServer s;
		try {
			String strWEBSOCKET = Tools.readTxtFile(Const.WEBSOCKET);// 读取WEBSOCKET配置,获取端口配置
			if (null != strWEBSOCKET && !"".equals(strWEBSOCKET)) {
				String strIW[] = strWEBSOCKET.split(",fh,");
				if (strIW.length == 5) {
					s = new OnlineChatServer(Integer.parseInt(strIW[3]));
					s.start();
				}
			}
			// System.out.println( "websocket服务器启动,端口" + s.getPort() );
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}

	/**
	 * web容器重启时，所有定时备份状态关闭
	 */
	public void reductionDbBackupQuartzState() {
		try {
			DbFH.executeUpdateFH("update DB_TIMINGBACKUP set STATUS = '2'");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 计时器(废弃)用quartz代替
	 */
	public void timer() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 9); // 控制时
		calendar.set(Calendar.MINUTE, 0); // 控制分
		calendar.set(Calendar.SECOND, 0); // 控制秒
		Date time = calendar.getTime(); // 得出执行任务的时间
		Timer timer = new Timer();
		timer.scheduleAtFixedRate(new TimerTask() {
			public void run() {
				// PersonService personService =
				// (PersonService)ApplicationContext.getBean("personService");
				// System.out.println("-------设定要指定任务--------");
			}
		}, time, 1000 * 60 * 60 * 24);// 这里设定将延时每天固定执行
	}

	/**
	 * 定时修改token 每天一次
	 */
	public void tokenUpdate() {
		QuartzManager.addJob("token_update", TokenUpdateJob.class, "0 0 0 1-2 * ?");
		QuartzManager.startJobs();
	}

	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * 启动OSS服务
	 * @throws Exception 
	 */
	public void startOSSServer() {
		App app=new App();
		try {
			app.main(null);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
