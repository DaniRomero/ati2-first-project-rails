class ClientController < ApplicationController
	layout 'application_footer.html.haml'
	def index
		@user = User.find(session[:id])
		@vs = VariablesSistema.last
		senderE = Sender.where(sender_user:session[:id])
		senderR = Sender.where(reciever_user:session[:id])

		@package = []
		senderR.each do |sender|
			
			aux = Package.where(sender_id:sender.id) 
			aux[1] = "Receptor"
			aux[2] = aux[0].weight*aux[0].height*aux[0].width*aux[0].large/@vs.const + @vs.k/100*aux[0].valor
			aux[3] = sender.fecha_envio
			if sender.fecha_entrega != nil 
				aux[4] = sender.fecha_entrega
			else 
				aux[4] = "-"
			end
			@package.push aux
		end
		senderE.each do |sender|
			aux = Package.where(sender_id:sender.id)
			aux[1] = "Emisor"
			aux[2] = aux[0].weight*aux[0].height*aux[0].width*aux[0].large/@vs.const+@vs.k/100*aux[0].valor
			aux[3] = sender.fecha_envio
			if sender.fecha_entrega != nil 
				aux[4] = sender.fecha_entrega
			else 
				aux[4] = "-"
			end
			@package.push aux
		end
	end

	def logout
	    reset_session
	    redirect_to controller: :default, action: :index
	    return
	end

	def modificar_perfil
		clave_form = Digest::MD5.hexdigest(params[:pass])
		user = User.find(session[:id])
		clave = user.password
		p params[:pass]
		if (clave == clave_form)
			
			respond_to do |format|
				retorno = "true"
				format.json {render json:retorno}
			end
		else	
	
			respond_to do |format|
				retorno = "false"
				format.json {render json:retorno}
			end
		end
	end

	def editar_perfil
		nombre = params[:name]
		apellido = params[:last]
		edad = params[:age]
		cedula = params[:id]
		email = params[:mail]
		telefono = params[:phone]
		user = User.find(session[:id])
		user.first_name = nombre
		user.last_name = apellido
		user.age = edad
		user.phone = telefono
		user.cedula = cedula
		user.email = email
		if user.save
			retorno = "true"
			respond_to do |format|
				format.json {render json:retorno}
			end
		else
			retorno = "false"
			respond_to do |format|
				format.json {render json:retorno}
			end
		end
	end

	def tracking
		
		senderE = Sender.where(sender_user:session[:id])
		senderR = Sender.where(reciever_user:session[:id])

		@package = []
		senderR.each do |sender|
			@package.push Package.where(sender_id:sender.id)
		end
		senderE.each do |sender|
			@package.push Package.where(sender_id:sender.id)
		end
		p @package[1][0].id

				


	end 

end

