function addSucursal(){
	var name = $("#sucursal_name").val()	
	var dir = $("#sucursal_dir").val()	
	var phone = $("#sucursal_phone").val()
	$.ajax({
		url: "/admin/add_sucursal",
		method: "POST",
		data: {name:name, dir:dir, phone:phone},
		dataType: "text",
		success: function(result){
			if (result==="true")
				alert("Surcursal añadida existosamente")
			else if (result==="false")
				alert("Error al añadir sucursal")
		},
		error: function(result){
			alert("Error al añadir sucursal")
		}
	});	
};