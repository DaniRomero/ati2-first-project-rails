function addAdmin(){
	var name = $("#ad_name").val()
	var apellido = $("#ad_apellido").val()
	var edad = $("#ad_edad").val()
	var cedula = $("#ad_cedula").val()
	var telefono = $("#ad_phone").val()
	var email = $("#ad_email").val()
	var clave = $("#ad_password").val()
	$.ajax({
		url: "/admin/add_admin",
		method: "POST",
		data: {name:name, 
			   last:apellido, 
			   age:edad, 
			   ci:cedula, 
			   phone:telefono, 
			   email:email, 
			   code:clave},
		dataType: "text",
		success: function(result){
			if (result==="true")
				alert("Administrador añadido existosamente")
			else if (result==="false")
				alert("Error al añadir Administrador")
		},
		error: function(errorThrown){
			alert(errorThrown)
		}
	});
};