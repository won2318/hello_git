/*
 * 생성일 : 2004. 12. 24.
 *
 * 사용방법 : 
 */

package com.yundara.beans;

import java.util.Map;

/**
 * @author 오영석
 *
 * TODO InfoBeanExt의 이벤트가 발생될때 이벤트 파라메터 변수로 사용된다.
 * 이벤트가 발생되는 순간의 상태를 저장하고 있다.
 */

public class BeansEvent {
    /**
     * InfoBeanExt 의 키
     */
    private String name = "";
    /**
     * InfoBeanExt 의 값
     */
    private Object value = null;
    /**
     * InfoBeanExt 의 전체 속성을 가지고 있는 Map
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
