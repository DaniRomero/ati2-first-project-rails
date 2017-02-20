function nuevoPaquete(){
	var correoE = $("#Npaquete_sender").val()
	var correoR = $("#Npaquete_receiver").val()
	var sucursal = $("#sucursales").val()
	var alto = $("#Npaquete_alto").val()
	var ancho = $("#Npaquete_ancho").val()
	var peso = $("#Npaquete_peso").val()
	var largo = $("#Npaquete_largo").val()
	var valor = $("#Npaquete_valor").val()
	var descripcion = $("#Npaquete_description").val()
	$.ajax({
		url : "/employee/nuevo_paquete",
		type: "POST",
		data: {correoE:correoE, correoR:correoR, sucursal:sucursal, alto:alto, ancho:ancho, peso:peso, largo:largo, desc:descripcion, valor:valor},
		dataType: "text",
		success: function(result){
			if (result==="true"){
				alert("Paquete añadido satisfactoriamente")
				$("#Npaquete_sender").val() = ""
				$("#Npaquete_receiver").val() = ""
				$("#Npaquete_sucursal").val() = ""
				$("#Npaquete_alto").val() = ""
				$("#Npaquete_ancho").val() = ""
				$("#Npaquete_peso").val() = ""
				$("#Npaquete_largo").val() = ""
				$("#Npaquete_valor").val() = ""
				$("#Npaquete_description").val() = ""
			}else if (result==="false"){
				alert("No se pudo añadir su paquete, intente nuevamente")
				$("#Npaquete_sender").val() = ""
				$("#Npaquete_receiver").val() = ""
				$("#Npaquete_sucursal").val() = ""
				$("#Npaquete_alto").val() = ""
				$("#Npaquete_ancho").val() = ""
				$("#Npaquete_peso").val() = ""
				$("#Npaquete_largo").val() = ""
				$("#Npaquete_valor").val() = ""
				$("#Npaquete_description").val() = ""
			}else if(result==="Usuario emisor no encontrado"){
				alert("Usuario emisor no encontrado")
				$("#Npaquete_sender").val() = ""
				$("#Npaquete_receiver").val() = ""
				$("#Npaquete_sucursal").val() = ""
				$("#Npaquete_alto").val() = ""
				$("#Npaquete_ancho").val() = ""
				$("#Npaquete_peso").val() = ""
				$("#Npaquete_largo").val() = ""
				$("#Npaquete_valor").val() = ""
				$("#Npaquete_description").val() = ""
			}else{
				alert("Usuario receptor no encontrado")
				$("#Npaquete_sender").val() = ""
				$("#Npaquete_receiver").val() = ""
				$("#Npaquete_sucursal").val() = ""
				$("#Npaquete_alto").val() = ""
				$("#Npaquete_ancho").val() = ""
				$("#Npaquete_peso").val() = ""
				$("#Npaquete_largo").val() = ""
				$("#Npaquete_valor").val() = ""
				$("#Npaquete_description").val() = ""

			}
		},
		error: function(request, error, errorThrown){
			$("#Npaquete_sender").val() = ""
			$("#Npaquete_receiver").val() = ""
			$("#Npaquete_sucursal").val() = ""
			$("#Npaquete_alto").val() = ""
			$("#Npaquete_ancho").val() = ""
			$("#Npaquete_peso").val() = ""
			$("#Npaquete_largo").val() = ""
			$("#Npaquete_valor").val() = ""
			$("#Npaquete_description").val() = ""
			alert("Error al añadir el paquete")
		}
	});
};
