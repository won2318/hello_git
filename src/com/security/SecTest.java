package com.security;


public class SecTest {
	
	public static void main(String args[]) throws Exception{
		
//		// �Ϻ�ȣȭ�� ����� Ű �迭����
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
//		System.out.println("xor �� ����");
//		for(int i=0; i<16; i++){
//			System.out.println(aa[i]);
//		}
//		System.out.println("xor �� ����");
//		
//		for(int i=0; i<16; i++){
//			aa[i] = Integer.valueOf(aa[i] ^ bb[i]).byteValue();
//		}
//		
//		System.out.println("xor �� ����");
//		for(int i=0; i<16; i++){
//			System.out.println(aa[i]);
//		}
//		System.out.println("xor �� ����");
//		
//		for(int i=0; i<16; i++){
//			aa[i] = Integer.valueOf(aa[i] ^ bb[i]).byteValue();
//		}
//		
//		System.out.println("xor 2�� �� ����");
//		for(int i=0; i<16; i++){
//			System.out.println(aa[i]);
//		}
//		System.out.println("xor 2�� �� ����");
	}
	
	
}
