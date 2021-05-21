package com.security;


public class SecTest {
	
	public static void main(String args[]) throws Exception{
		
//		// 암복호화에 사용할 키 배열생성
		int[] seedKey = SEEDUtil.getSeedRoundKey("vodcaster.co.kr.");
		
		String nomalStr = "dev@naver.com";
		
		String encStr = SEEDUtil.getSeedEncrypt(nomalStr, seedKey);
		
		System.out.println("encStr : " + encStr);
		
		String decStr = SEEDUtil.getSeedDecrypt(encStr, seedKey);
		
		System.out.println("decStr : " + decStr);
		
		System.out.println(SEEDUtil.getSeedDecrypt("jHMJK+lrFk+uz4VzWyP+hQ==", seedKey));
		
//		byte[] aa = "vmzx,vndjhfsjfkf".getBytes();
//		byte[] bb = "1234567890123456".getBytes();
//		
//		System.out.println("xor 전 시작");
//		for(int i=0; i<16; i++){
//			System.out.println(aa[i]);
//		}
//		System.out.println("xor 전 종료");
//		
//		for(int i=0; i<16; i++){
//			aa[i] = Integer.valueOf(aa[i] ^ bb[i]).byteValue();
//		}
//		
//		System.out.println("xor 후 시작");
//		for(int i=0; i<16; i++){
//			System.out.println(aa[i]);
//		}
//		System.out.println("xor 후 종료");
//		
//		for(int i=0; i<16; i++){
//			aa[i] = Integer.valueOf(aa[i] ^ bb[i]).byteValue();
//		}
//		
//		System.out.println("xor 2차 후 시작");
//		for(int i=0; i<16; i++){
//			System.out.println(aa[i]);
//		}
//		System.out.println("xor 2차 후 종료");
	}
	
	
}
