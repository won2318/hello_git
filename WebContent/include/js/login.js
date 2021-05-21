function validateEncryptedForm() {
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
   
    if (!username || !password) {
        alert("ID/��й�ȣ�� �Է����ּ���.");
        return ;
    }

    try {
        var rsaPublicKeyModulus = document.getElementById("rsaPublicKeyModulus").value;
        var rsaPublicKeyExponent = document.getElementById("rsaPublicKeyExponent").value;
        submitEncryptedForm(username,password, rsaPublicKeyModulus, rsaPublicKeyExponent);
    
    } catch(err) {
        alert(err);
    }
    return ;
}

function submitEncryptedForm(username, password, rsaPublicKeyModulus, rsaPpublicKeyExponent) {
    var rsa = new RSAKey();
    rsa.setPublic(rsaPublicKeyModulus, rsaPpublicKeyExponent);

    // �����ID�� ��й�ȣ�� RSA�� ��ȣȭ�Ѵ�.
    var securedUsername = rsa.encrypt(username);
    var securedPassword = rsa.encrypt(password);

    // POST �α��� ���� ���� �����ϰ� ����(submit) �Ѵ�.
    var securedLoginForm = document.getElementById("securedLoginForm");
    securedLoginForm.securedUsername.value = securedUsername;
    securedLoginForm.securedPassword.value = securedPassword;
    securedLoginForm.submit();
}