/**
 * @use ���� ���� ���ε������ ���۵Ǿ����ϴ�.
 * @author cielo
 * @See nhn.husky.SE2M_Configuration 
 * @ �˾� ��ũ���� SimplePhotoUpload.html�� SimplePhotoUpload_html5.html�� �ֽ��ϴ�. 
 */

nhn.husky.SE2M_AttachQuickPhoto = jindo.$Class({		
	name : "SE2M_AttachQuickPhoto",

	$init : function(){},
	
	$ON_MSG_APP_READY : function(){
		this.oApp.exec("REGISTER_UI_EVENT", ["photo_attach", "click", "ATTACHPHOTO_OPEN_WINDOW"]);
	},
	
	$LOCAL_BEFORE_FIRST : function(sMsg){
		if(!!this.oPopupMgr){ return; }
		// Popup Manager���� ����� param
		this.htPopupOption = {
			oApp : this.oApp,
			sName : this.name,
			bScroll : false,
			sProperties : "",
			sUrl : ""
		};
		this.oPopupMgr = nhn.husky.PopUpManager.getInstance(this.oApp);
	},
	
	/**
	 * ���� ��ž ����
	 */
	$ON_ATTACHPHOTO_OPEN_WINDOW : function(){			
		this.htPopupOption.sUrl = this.makePopupURL();
		this.htPopupOption.sProperties = "left=0,top=0,width=383,height=339,scrollbars=no,location=no,status=0,resizable=no";

		this.oPopupWindow = this.oPopupMgr.openWindow(this.htPopupOption);
		
		// ó�� �ε��ϰ� IE���� Ŀ���� ���� ���� ���
		// ���� ���ε�ÿ� ������ �ٲ�	
		this.oApp.exec('FOCUS');
		return (!!this.oPopupWindow ? true : false);
	},
	
	/**
	 * ���񽺺��� �˾���  parameter�� �߰��Ͽ� URL�� �����ϴ� �Լ�	 
	 * nhn.husky.SE2M_AttachQuickPhoto.prototype.makePopupURL�� ����Ἥ ����Ͻø� ��.
	 */
	makePopupURL : function(){
		var sPopupUrl = "./popup/quick_photo/Photo_Quick_UploadPopup.html"; 
		return sPopupUrl;
	},
	
	/**
	 * �˾����� ȣ��Ǵ� �޼���.
	 */
	$ON_SET_PHOTO : function(aPhotoData){
		var sContents, 
			aPhotoInfo,
			htData;
		
		if( !aPhotoData ){ 
			return; 
		}
		
		try{
			sContents = "";
			for(var i = 0; i <aPhotoData.length; i++){				
				htData = aPhotoData[i];
				
				if(!htData.sAlign){
					htData.sAlign = "";
				}
				
				aPhotoInfo = {
				    sName : htData.sFileName || "",
				    sOriginalImageURL : htData.sFileURL,
					bNewLine : htData.bNewLine || false 
				};
				
				sContents += this._getPhotoTag(aPhotoInfo);
			}

			this.oApp.exec("PASTE_HTML", [sContents]); // ���� ÷�� ���� �κ� Ȯ��
		}catch(e){
			// upload�� error�߻��� ���ؼ� skip��
			return false;
		}
	},

	/**
	 * @use �Ϲ� ���� tag ����
	 */
	_getPhotoTag : function(htPhotoInfo){
		// id�� class�� ����ϰ� ������ �����ϴ�. ������ ����� ������ Test
		var sTag = '<img src="{=sOriginalImageURL}" title="{=sName}" >';
		if(htPhotoInfo.bNewLine){
			sTag += '<br style="clear:both;">';
		}
		sTag = jindo.$Template(sTag).process(htPhotoInfo);
		
		return sTag;
	}
});