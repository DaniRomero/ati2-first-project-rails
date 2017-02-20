$(document).ready(function() {
	var tablaPaquetes = $("#tablaPaquetes");
	
	$("#verTodoPaquete").bind("click", function(){
		$("#tablaPaquetes").removeClass("hidden");
		
	});
	
	
	$("#paquete_busqueda").keyup(function() {
		
		//este plugin gestiona de forma autonoma el filtrado en cliente (navegador)
		$.uiTableFilter(tablaPaquetes, this.value);
		
		
		if ($(this).val()==""){
			$("#tablaPaquetes").addClass("hidden");
		}else{
			
			$("#tablaPaquetes").removeClass("hidden");
		}
		
	});

	var tablaPaquetes = $("#tablaPaquetesRecibir");
	
	$("#verTodoPaqueteRecibir").bind("click", function(){
		$("#tablaPaquetesRecibir").removeClass("hidden");
		
	});
	
	
	$("#paquete_busquedaRecibir").keyup(function() {
		
		//este plugin gestiona de forma autonoma el filtrado en cliente (navegador)
		$.uiTableFilter(tablaPaquetes, this.value);
		
		
		if ($(this).val()==""){
			$("#tablaPaquetesRecibir").addClass("hidden");
		}else{
			
			$("#tablaPaquetesRecibir").removeClass("hidden");
		}
		
	});

	var tablaPaquetes = $("#tablaPaquetesEnviar");
	
	$("#verTodoPaqueteEnviar").bind("click", function(){
		$("#tablaPaquetesEnviar").removeClass("hidden");
		
	});
	
	
	$("#paquete_busquedaEnviar").keyup(function() {
		
		//este plugin gestiona de forma autonoma el filtrado en cliente (navegador)
		$.uiTableFilter(tablaPaquetes, this.value);
		
		
		if ($(this).val()==""){
			$("#tablaPaquetesEnviar").addClass("hidden");
		}else{
			
			$("#tablaPaquetesEnviar").removeClass("hidden");
		}
		
	});
	
});