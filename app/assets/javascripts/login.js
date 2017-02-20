function login(){

	var email = $("#login_email").val()
	var password = $("#login_password").val()

	$.ajax({
		url: "/default/login",
		type: "POST",
		data: {email:email,password:password},
		dataType: "text",
		success: function(result){
			if(result ==="ne"){
				alert("Este usuario no existe")
			}else if (result === "mnf"){
				alert("Este usuario no existe")
			}else if (result === "cn"){
				alert("Clave incorrecta")
			}else if (result === "true"){
				window.location.replace("/default/index")
			}
		},
		error: function(errorThrown){
			alert(errorThrown)
			alert("error")
		}
	});

};