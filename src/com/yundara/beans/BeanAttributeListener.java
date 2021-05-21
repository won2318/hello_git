/*
 * ������ : 2004. 12. 24.
 *
 * 1. �����
 * <b>InfoBeanExt �� �̺�Ʈ ���������� ����</b><br>
 * InfoBeanExt Ŭ�������� �� �������̽��� �����ϰ� �ִ�.
 * 
 */

package com.yundara.beans;

/**
 * @author ������
 *
 * TODO Ŭ������ ���� ����
 */

interface BeansAttributeListener {
    /**
     * TODO 
     * InfoBeanExt�� getAttribute �޼ҵ带 ���Ͽ� �Ӽ��� ������
     * ���� �Ӽ��� �����ϱ� ���� �߻��Ǵ� �̺�Ʈ
     */
    void attributeGetBefore(BeansEvent evt);

    /**
     * TODO 
     * InfoBeanExt�� setAttribute �޼ҵ带 ���Ͽ� �Ӽ��� �����Ҷ�
     * ������ ���� �������� �ʰ�, ����Ÿ�� �����ϱ� ���� �߻�
     */
    void attributeAddBefore(BeansEvent evt);
    
    /**
     * TODO 
     * InfoBeanExt�� setAttribute �޼ҵ带 ���Ͽ� �Ӽ��� �߰��� ��
     * ����Ÿ �����Ŀ� �߻��Ǵ� �̺�Ʈ
     */
    void attributeAdded(BeansEvent evt);

    /**
     * TODO 
     * InfoBeanExt�� removeAttribute �޼ҵ带 ���Ͽ� �Ӽ��� ������ ��
     * �����ϱ� ���� �߻��Ǵ� �̺�Ʈ
     */
    void attributeRemoveBefore(BeansEvent evt);    
    
    /**
     * TODO 
     * InfoBeanExt�� removeAttribute �޼ҵ带 ���Ͽ� �Ӽ��� ������ ��
     * ������ �Ŀ� �߻��Ǵ� �̺�Ʈ
     */    
    void attributeRemoved(BeansEvent evt);
    
    /**
     * TODO 
     * InfoBeanExt�� setAttribute �޼ҵ带 ���Ͽ� �Ӽ��� ������ ��
     * ������ ����Ÿ�� ������ ��� ���ο� ������ ��ü�Ǵµ�, ��ü�Ǳ� ���� �߻��Ǵ� �̺�Ʈ
     */  
    void attributeReplaceBefore(BeansEvent evt);    
    
    /**
     * TODO 
     * InfoBeanExt�� setAttribute �޼ҵ带 ���Ͽ� �Ӽ��� ������ ��
     * ����Ÿ�� ��ü�� �Ŀ� �߻��Ǵ� �̺�Ʈ
     */
    void attributeReplaced(BeansEvent evt);
}
