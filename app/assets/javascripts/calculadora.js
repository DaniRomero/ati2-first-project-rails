/*!
 * Start Bootstrap - Freelancer Bootstrap Theme (http://startbootstrap.com)
 * Code licensed under the Apache License v2.0.
 * For details, see http://www.apache.org/licenses/LICENSE-2.0.
 */

// jQuery for page scrolling feature - requires jQuery Easing plugin
function calcular() {
    var var1 = document.getElementById('miembro_ancho')
    var var2 = document.getElementById('miembro_alto')
    var var3 = document.getElementById('miembro_largo')
    var var4 = document.getElementById('miembro_peso')
    var var5 = document.getElementById('miembro_valor')
    var mult = parseFloat(var1.value) * parseFloat(var2.value) * parseFloat(var3.value) * parseFloat(var4.value)
    

    $.ajax(
    {
        url: "/default/calculadora",
        type: "GET",
        dataType: "json",
        success: function(result){
            var element=document.getElementById('miembro_result');
            element.type ="text"  
            element.value = ( mult / parseFloat(result.constante)) + (parseFloat(result.porcentaje)) *(var5.value/100)
            
        },
        error: function(request, status, errorThrown){
            var element=document.getElementById('miembro_result');
            element.type ="text"  
            element.value = -1
            alert(errorThrown)
        },
    });
}