package env.service;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import javax.crypto.Cipher;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import env.model.RSA;

@Service
public class RSAService {
	private static final Logger logger = LoggerFactory.getLogger(RSAService.class);
	private KeyPairGenerator generator;
    private KeyFactory keyFactory;
    private KeyPair keyPair;
    private Cipher cipher; //복호화를 위한 객체
    
    public RSAService(){
    	try {
    		generator = KeyPairGenerator.getInstance("RSA");
    		generator.initialize(1024);
    		keyFactory = KeyFactory.getInstance("RSA");
    		cipher = Cipher.getInstance("RSA"); //☆
		} catch (Exception e) {
			// TODO: handle exception
		}
    }
    
    // 새로운 키값을 가진 RSA 생성
    public RSA createRSA() {
        RSA rsa = null;
        try {
            keyPair = generator.generateKeyPair();
 
            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();
 
            RSAPublicKeySpec publicSpec = (RSAPublicKeySpec)keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class); //오토 언박싱
            //RSAPublicKeySpec publicSpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class); //오토 언박싱
            String modulus = publicSpec.getModulus().toString(16);
            String exponent = publicSpec.getPublicExponent().toString(16);
            rsa = new RSA(privateKey, modulus, exponent);
        } catch (Exception e) {
            logger.warn("RSAservice.createRSA()", e);
        }
        return rsa;
    }
 
    // 개인키를 이용한 RSA 복호화
    public String getDecryptText(PrivateKey privateKey, String encryptedText) throws Exception {
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(hexToByteArray(encryptedText));
        return new String(decryptedBytes, "UTF-8");
    }
 
    // 16진수 문자열을 byte 배열로 변환
    private byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[] {};
        }
        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }
}
