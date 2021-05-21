package com.hrlee.silver;

import com.yundara.beans.InfoBeanExt;

public class MemoInfoBean extends InfoBeanExt
{
  String ocode = "";
  String uid = "";
  String replystr = "";
  String replytime = "";
  int rid = 0;

  public String getOcode()
  {
    return this.ocode; }

  public void setOcode(String ocode) {
    this.ocode = ocode; }

  public String getUid() {
    return this.uid; }

  public void setUid(String uid) {
    this.uid = uid; }

  public String getReplystr() {
    return this.replystr; }

  public void setReplystr(String replystr) {
    this.replystr = replystr; }

  public String getReplyTime() {
    return this.replytime; }

  public void setReplytime(String replytime) {
    this.replytime = replytime; }

  public int getRid() {
    return this.rid; }

  public void setRid(int rid) {
    this.rid = rid;
  }
}