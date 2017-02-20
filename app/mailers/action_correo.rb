class ActionCorreo < ApplicationMailer

	default from: "atiacc2014@gmail.com"

	def welcome_email(user)
		@user = user
		mail(to: @user.email , subject: "Bienvenido")
		
	end

 	def cambiar_contrasena(user,clave)
 		@user = user
 		@clave = clave
 		mail(to: @user.email, subject: 'Cambio de contraseña')
 	end

 	def status_confirmado(users, sucursal)
 		@userE = users[0]
 		@userR = users[1]
 		@sucursal = sucursal
 		mail(to: [@userE.email,@userR.email], subject: "Su paquete ha llegado!!")
 	end
end
