function cambiarTarifa(){
	var constant = $('#constante_name').val()
	var k = $('#k_name').val()

	$.ajax({
		url: "/admin/cambiarTarifa",
		method: "POST",
		data: {constante:constant, k:k},
		dataType: "text",
		success: function(result){
			if (result==="true"){
				$('#fraccion').html(constant+' fraccion de ganancia')
				$('#porcentaje').html(k+' porcentaje de ganancia ')
				$('#formula').html('formula => ((peso*alto*ancho*largo)/'+constant+') + ('+k+'/100) * Precio del contenido')
				alert("Tarifa cambiada existosamente")
			}else if (result==="false")
				alert("Error al cambiar tarifa")
		},
		error: function(result){
			alert("Error al cambiar tarifa")
		}
	});	
}