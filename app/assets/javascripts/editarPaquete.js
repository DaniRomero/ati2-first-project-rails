function editarPaquete(){
	var id = $("#paquete_id").val()
	var status = $("#status").val()
	if (status == ""){
		alert("Seleccione un status para el paquete, por favor")
		return
	}

	$.ajax({
		url : "/employee/cambiar_estado",
		type: "POST",
		data: {id:id,status:status},
		dataType: "text",
		success: function(result){
			if (result==="true"){
				alert("Paquete actualizado")
			}else if (result === "false") {
				alert("Error actualizando paquete, intente nuevamente")
			}else
				alert("Identificador de paquete no encontrado")
		},
		error: function(errorThrown){
			alert("Error ")
		}
	});
};