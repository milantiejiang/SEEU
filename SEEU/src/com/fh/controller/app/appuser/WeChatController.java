package com.fh.controller.app.appuser;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.Security;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.controller.base.BaseController;
import com.fh.util.AppUtil;
import com.fh.util.PageData;
import com.fh.util.Tools;

import net.sf.json.JSONObject;
 
@Controller
@RequestMapping("/appwechat")
public class WeChatController extends BaseController{
	// 算法名称
    final String KEY_ALGORITHM = "AES";

    // 加解密算法/模式/填充方式
    final String algorithmStr = "AES/CBC/PKCS7Padding";
    //
    private Key key;
    private Cipher cipher;
    private String code=null;
    private String sessionKey=null;
    
    @RequestMapping(value="/getcode")
	@ResponseBody
	public Object getcode(){
    	Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		code=pd.getString("CODE");
		try {
			if(code!=null){
				sessionKey = getSessionKey(code);
				map.put("code", "100");
				map.put("message","sucess");
			}else{
				map.put("code", "300");
				map.put("message","code null");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("code", "200");
			map.put("message","faile");
		}
		return AppUtil.returnObject(new PageData(), map);
    }
    
    @RequestMapping(value="/getuserinfo")
	@ResponseBody
	public Object getuserinfo(){
    	
    	Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String encryptedData=pd.getString("ENCRYPTEDDATA");
		String iv=pd.getString("IV");
		
		try {
			if(sessionKey!=null){
				byte[] result = decrypt(encryptedData, sessionKey, iv);
				System.out.println(new String(result,"UTF-8"));
				map.put("code", "100");
				map.put("message","sucess");
			}else{
				map.put("code", "300");
				map.put("message","sessionKey null");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("code", "200");
			map.put("message","faile");
		}
		return AppUtil.returnObject(new PageData(), map);
    }
    

    public void init(byte[] keyBytes) {

        // 如果密钥不足16位，那么就补足. 这个if 中的内容很重要
        int base = 16;
        if (keyBytes.length % base != 0) {
            int groups = keyBytes.length / base + (keyBytes.length % base != 0 ? 1 : 0);
            byte[] temp = new byte[groups * base];
            Arrays.fill(temp, (byte) 0);
            System.arraycopy(keyBytes, 0, temp, 0, keyBytes.length);
            keyBytes = temp;
        }
        // 初始化
        Security.addProvider(new BouncyCastleProvider());
        // 转化成JAVA的密钥格式
        key = new SecretKeySpec(keyBytes, KEY_ALGORITHM);
        try {
            // 初始化cipher
            cipher = Cipher.getInstance(algorithmStr);
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 解密方法
     *
     * @param encryptedData
     *            要解密的字符串
     * @param keyBytes
     *            解密密钥
     * @return
     */
    public byte[] decrypt(String encryptedDataStr, String keyBytesStr, String ivStr) {
        byte[] encryptedText = null;
        byte[] encryptedData = null;
        byte[] sessionkey = null;
        byte[] iv = null;

        try {
            sessionkey = Base64.decodeBase64(keyBytesStr.getBytes());
            encryptedData = Base64.decodeBase64(encryptedDataStr.getBytes());
            iv = Base64.decodeBase64(ivStr.getBytes());

            init(sessionkey);

            cipher.init(Cipher.DECRYPT_MODE, key, new IvParameterSpec(iv));
            encryptedText = cipher.doFinal(encryptedData);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return encryptedText;
    }

    public static void main(String[] args) throws UnsupportedEncodingException{
    	WeChatController d = new WeChatController();
        String content = "CNtSo3kCTxYoaxdhxzmVN/CvIJK41+1DOTZcrXUVMd9+5Z8jTDvbn6kExXRzH+EqWD6oyXwxUzYsW5nyZ7hGAx4pqYylJUzshx+R9DrpQ7HAb5ScH1e0zk//UAiD11W19uFo2/nYyx5ug99jCj6YOgicpfNHSatqkLVRryQlDEzNyaEuo/84uHIpxwC7t8yqmuwUtW2qedtJxWmYWOC1ZQ==";
        String key = getSessionKey("");
        String iv = "SABdIDCax6u7H0f6OILGzw==";
        byte[] result = d.decrypt(content, key, iv);
        System.out.println(new String(result,"UTF-8"));
    }

	public static String getSessionKey(String code) {
		String url = "https://api.weixin.qq.com/sns/jscode2session";
		String param="appid=" + "wx9dffbf10af04e0ab" + "&secret="
				+ "fa2f100d7ee50549d61407f96c0f89d0" + "&js_code=" + code + "&grant_type=authorization_code";
		String reusult = sendGet(url,param);
		JSONObject oppidObj = JSONObject.fromObject(reusult);
		String openid = (String) oppidObj.get("openid");
		String session_key = (String) oppidObj.get("session_key");
		return session_key;
	}
	
	public static String sendGet(String url, String param) {
        String result = "";
        BufferedReader in = null;
        try {
            String urlNameString = url + "?" + param;
            URL realUrl = new URL(urlNameString);
            // 打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 建立实际的连接
            connection.connect();
            // 获取所有响应头字段
            Map<String, List<String>> map = connection.getHeaderFields();
            // 遍历所有的响应头字段
            for (String key : map.keySet()) {
                System.out.println(key + "--->" + map.get(key));
            }
            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(
                    connection.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            System.out.println("发送GET请求出现异常！" + e);
            e.printStackTrace();
        }
        // 使用finally块来关闭输入流
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return result;
    }
 
 
}

