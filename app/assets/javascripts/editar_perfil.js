 $(document).ready(function(){
    $("#modiPerfil").submit(function(event){
      
		event.preventDefault();
    });
});

function editar_perfil(){
	var nombre = $("#client_nombre").val()
	var apellido = $("#client_apellido").val()
	var edad = $("#client_edad").val()
	var cedula = $("#client_cedula").val()
	var email = $("#client_email").val()
	var telefono = $("#client_telefono").val()
	$.ajax({
		url : "/client/editar_perfil",
		type: "POST",
		data: {name:nombre,last:apellido,age:edad,id:cedula,mail:email,phone:telefono},
		dataType: "text",
		success: function(result){
			if (result==="true"){
				alert("Perfil actualizado")
			}else{
				alert("Error actualizando perfil")
			}
		},
		error: function(errorThrown){
			alert("Error actualizando perfil2222222222")
			$("#client_clave").value = ""
			$('#cambiar_perfil').prop('disabled', true);
		}
	});
}

