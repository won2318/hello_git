function validateEncryptedForm() {
 
    var id = document.getElementById("id").value;
    var pwd = document.getElementById("pwd").value;
    var name = document.getElementById("name").value;
    var email = document.getElementById("email").value;
    var sex = document.getElementById("sex").value;
    var tel = document.getElementById("tel").value;
    var hp = document.getElementById("hp").value;
    var zip = document.getElementById("zip").value;
    var address1 = document.getElementById("address1").value;
    var address2 = document.getElementById("address2").value;
    var office_name = document.getElementById("office_name").value;
    var level = document.getElementById("level").value;
    var use_mailling = document.getElementById("use_mailling").value;
    var auth_key = document.getElementById("auth_key").value;
    var approval = document.getElementById("approval").value;
    var pwd_ask_num = document.getElementById("pwd_ask_num").value;
    var pwd_answer = document.getElementById("pwd_answer").value;
    var member_group = document.getElementById("member_group").value;
    var buseo = document.getElementById("buseo").value;
    var gray = document.getElementById("gray").value;
    var ssn = document.getElementById("ssn").value;
 
    if (!id ) {
        alert("ID를 입력해주세요.");
        return ;
    }

    if (!name ) {
        alert("이름을 입력해주세요.");
        return ;
    }
 

    try {
        var rsaPublicKeyModulus = document.getElementById("rsaPublicKeyModulus").value;
        var rsaPublicKeyExponent = document.getElementById("rsaPublicKeyExponent").value;
        submitEncryptedForm(id,pwd,name,email,sex,tel,hp,zip,address1,address2,office_name,level,use_mailling,auth_key,approval,pwd_ask_num,pwd_answer,member_group,buseo,gray,ssn, rsaPublicKeyModulus, rsaPublicKeyExponent);
  
    } catch(err) {
        alert(err);
    }
    return ;
}

function submitEncryptedForm(id,pwd,name,email,sex,tel,hp,zip,address1,address2,office_name,level,use_mailling,auth_key,approval,pwd_ask_num,pwd_answer,member_group,buseo,gray,ssn, rsaPublicKeyModulus, rsaPpublicKeyExponent) {
    var rsa = new RSAKey();
    rsa.setPublic(rsaPublicKeyModulus, rsaPpublicKeyExponent);

    // 사용자ID와 비밀번호를 RSA로 암호화한다.
    var id_ = rsa.encrypt(id);
    var pwd_ = rsa.encrypt(pwd);
    var name_ = rsa.encrypt(name);
    var email_ = rsa.encrypt(email);
    var sex_ = rsa.encrypt(sex);
    var tel_ = rsa.encrypt(tel);
	var hp_ = rsa.encrypt(hp);
	var zip_ = rsa.encrypt(zip);
	var address1_ = rsa.encrypt(address1);
    var address2_ = rsa.encrypt(address2);
    var office_name_ = rsa.encrypt(office_name);
    var level_ = rsa.encrypt(level);
    var use_mailling_ = rsa.encrypt(use_mailling);
    var auth_key_ = rsa.encrypt(auth_key);
    var approval_ = rsa.encrypt(approval);
    var pwd_ask_num_ = rsa.encrypt(pwd_ask_num);
    var pwd_answer_ = rsa.encrypt(pwd_answer);
	var member_group_ = rsa.encrypt(member_group);
    var buseo_ = rsa.encrypt(buseo);
	var gray_ = rsa.encrypt(gray);
    var ssn_ = rsa.encrypt(ssn);
  

    // POST 로그인 폼에 값을 설정하고 발행(submit) 한다.
    var securedLoginForm = document.getElementById("securedLoginForm");
    securedLoginForm.id_.value = id_;
    securedLoginForm.pwd_.value = pwd_;
    securedLoginForm.name_.value = name_;
    securedLoginForm.email_.value = email_;
    securedLoginForm.sex_.value = sex_;
    securedLoginForm.tel_.value = tel_;
    securedLoginForm.hp_.value = hp_;
    securedLoginForm.zip_.value = zip_;
    securedLoginForm.address1_.value = address1_;
    securedLoginForm.address2_.value = address2_;
    securedLoginForm.office_name_.value = office_name_;
    securedLoginForm.level_.value = level_;
    securedLoginForm.use_mailling_.value = use_mailling_;
    securedLoginForm.auth_key_.value = auth_key_;
    securedLoginForm.approval_.value = approval_;
    securedLoginForm.pwd_ask_num_.value = pwd_ask_num_;
    securedLoginForm.pwd_answer_.value = pwd_answer_;
    securedLoginForm.member_group_.value = member_group_;
	securedLoginForm.buseo_.value = buseo_;
    securedLoginForm.gray_.value = gray_;
    securedLoginForm.ssn_.value = ssn_;
    securedLoginForm.submit();
}