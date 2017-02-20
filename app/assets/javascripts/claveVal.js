$(document).ready(function(){
	$("#client_clave").keyup(function(){
		var var1 = this.value
		if (var1 !== null || var1 !== ""){
			$.ajax({
				url : "/client/modificar_perfil",
				type: "POST",
				data: {pass:var1},
				dataType: "text",
				success: function(result){
					if (result==="true"){
						$('#cambiar_perfil').prop('disabled', false);
					}else{
						$('#cambiar_perfil').prop('disabled', true);
					}
				},
				error: function(errorThrown){
					$('#cambiar_perfil').prop('disabled', true);
				}
			});
		}
	});
});
