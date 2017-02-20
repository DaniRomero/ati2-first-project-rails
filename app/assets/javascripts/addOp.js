function addOp(){
	var name = $("#op_name").val()
	var apellido = $("#op_apellido").val()
	var edad = $("#op_edad").val()
	var cedula = $("#op_cedula").val()
	var telefono = $("#op_phone").val()
	var email = $("#op_email").val()
	var sucursal = $("#sucursalop").val()
	var clave = $("#op_password").val()
	$.ajax({
		url: "/admin/add_operador",
		method: "POST",
		data: {name:name, 
			   last:apellido, 
			   age:edad, ci:cedula, 
			   phone:telefono, 
			   email:email, 
			   sucursal:sucursal, 
			   code:clave},
		dataType: "text",
		success: function(result){
			if (result==="true")
				alert("Operador añadido existosamente")
			else if (result==="false")
				alert("Error al añadir operador")
		},
		error: function(result){

		}
	});
};