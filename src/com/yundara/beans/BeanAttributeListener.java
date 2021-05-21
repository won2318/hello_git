/*
 * 생성일 : 2004. 12. 24.
 *
 * 1. 사용방법
 * <b>InfoBeanExt 의 이벤트 인터페이지 정의</b><br>
 * InfoBeanExt 클래스에서 이 인터페이스를 구현하고 있다.
 * 
 */

package com.yundara.beans;

/**
 * @author 오영석
 *
 * TODO 클래스에 대한 설명
 */

interface BeansAttributeListener {
    /**
     * TODO 
     * InfoBeanExt의 getAttribute 메소드를 통하여 속성을 읽을때
     * 읽은 속성을 리턴하기 전에 발생되는 이벤트
     */
    void attributeGetBefore(BeansEvent evt);

    /**
     * TODO 
     * InfoBeanExt의 setAttribute 메소드를 통하여 속성을 저장할때
     * 기존에 값이 존재하지 않고, 데이타를 저장하기 전에 발생
     */
    void attributeAddBefore(BeansEvent evt);
    
    /**
     * TODO 
     * InfoBeanExt의 setAttribute 메소드를 통하여 속성을 추가할 때
     * 데이타 저장후에 발생되는 이벤트
     */
    void attributeAdded(BeansEvent evt);

    /**
     * TODO 
     * InfoBeanExt의 removeAttribute 메소드를 통하여 속성을 삭제할 때
     * 삭제하기 전에 발생되는 이벤트
     */
    void attributeRemoveBefore(BeansEvent evt);    
    
    /**
     * TODO 
     * InfoBeanExt의 removeAttribute 메소드를 통하여 속성을 삭제할 때
     * 삭제한 후에 발생되는 이벤트
     */    
    void attributeRemoved(BeansEvent evt);
    
    /**
     * TODO 
     * InfoBeanExt의 setAttribute 메소드를 통하여 속성을 저장할 때
     * 기존에 데이타가 존재할 경우 새로운 값으로 교체되는데, 교체되기 전에 발생되는 이벤트
     */  
    void attributeReplaceBefore(BeansEvent evt);    
    
    /**
     * TODO 
     * InfoBeanExt의 setAttribute 메소드를 통하여 속성을 저장할 때
     * 데이타가 교체된 후에 발생되는 이벤트
     */
    void attributeReplaced(BeansEvent evt);
}
