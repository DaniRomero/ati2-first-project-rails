function registro(){
	var pass = $("#registro_clave").val()
	var email = $("#registro_email").val()
	var name = $("#registro_nombre").val()
	var last = $("#registro_apellido").val()
	var age = $("#registro_edad").val()
	var ci = $("#registro_cedula").val()
	var phone = $("#registro_telefono").val()


  if(email.length == 0){
    alert("Por favor, ingreso un correo electrónico válido")
  }

	if (pass.length < 8){
		alert("La clave debe tener al menos 8 digitos")
		return
	}
	if (age < 18){
		alert("Debes ser mayor de 18 años")
		return
	}
	if (ci.length < 7){
		alert("Introduzca un cédula de identidad válida")
		return
	}
	$.ajax({
		url : "/default/registro",
		type : "POST",
		data : {clave:pass, email:email, nombre:name, apellido:last, edad:age, cedula:ci,telefono:phone},
    dataType : "text",
    success: function(result){
      if (result === "ee"){
        alert("Este correo ya se encuentra en uso, intente con uno nuevo")
      }else if (result === "true"){
        window.location.replace("/default/index")
      }else if (result === "false"){
        alert ("Hubo un error al momento de registrarse, por favor vuelva a intentar")
      }
    },
    error: function(errorThrown){
      alert(errorThrown)
      alert("error")
    }
	})
};
