/*
 * ������ : 2004. 12. 24.
 *
 * ����� : 
 */

package com.yundara.beans;

import java.util.Map;

/**
 * @author ������
 *
 * TODO InfoBeanExt�� �̺�Ʈ�� �߻��ɶ� �̺�Ʈ �Ķ���� ������ ���ȴ�.
 * �̺�Ʈ�� �߻��Ǵ� ������ ���¸� �����ϰ� �ִ�.
 */

public class BeansEvent {
    /**
     * InfoBeanExt �� Ű
     */
    private String name = "";
    /**
     * InfoBeanExt �� ��
     */
    private Object value = null;
    /**
     * InfoBeanExt �� ��ü �Ӽ��� ������ �ִ� Map
     */
    private Map data = null;
 
    public BeansEvent(String key, Object value, Map data) {
        this.name = key;
        this.value = value;
        this.data = data;
    }

    /**
     * 
     * @uml.property name="name"
     */
    public String getName() {
        return name;
    }

    /**
     * 
     * @uml.property name="value"
     */
    public Object getValue() {
        return value;
    }

    /**
     * 
     * @uml.property name="data"
     */
    public Map getData() {
        return data;
    }

}
