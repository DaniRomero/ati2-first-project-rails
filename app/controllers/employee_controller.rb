class EmployeeController < ApplicationController
	layout 'application_footer.html.haml'
	def index
		@user = User.find(session[:id])
		sucursalId = User.find(session[:id]).sucursal_id
		@sucursal = Sucursal.find(sucursalId)
		@sucursals = Sucursal.all
		@vs = VariablesSistema.last

		@packageAll = Package.all

		@packageSucursal = Package.where(session)
		
		senderE = Sender.where(sender_sucursal:session[:sucursal])
		senderR = Sender.where(reciever_sucursal:session[:sucursal])


		@packageRecibir = []
		senderR.each do |sender|
			aux = Package.where(sender_id:sender.id)
			@packageRecibir.push aux
		end
		if @packageRecibir.size>0
			p "Mira"
			p @packageRecibir
		end
		@packageEnviar = []
		senderE.each do |sender|
			aux = Package.where(sender_id:sender.id)
			@packageEnviar.push aux
		end
		if @packageEnviar.size>0
			p "Mira2"
			p @packageEnviar
		end

	end

	def logout
	    reset_session
	    redirect_to controller: :default, action: :index
	    return
	end

	def nuevo_paquete
		p params[:valor]
		time = Time.new
		envio = time.year.to_s + "-" + time.month.to_s + "-" + time.day.to_s

		sender_id = User.where(email:params[:correoE])
		receiver_id = User.where(email:params[:correoR])

		if (sender_id.size==0)
			retorno = "Usuario emisor no encontrado"
			respond_to do |format|
				format.json {render json:retorno}
			end
			return
		end
		if (receiver_id.size==0)
			retorno = "Usuario receptor no encontrado"
			respond_to do |format|
				format.json {render json:retorno}
			end
			return
		end

		sender_sucursal_id = Sucursal.where(name:params[:sucursal])

		sender_row = Sender.create(sender_user:sender_id[0].id,
			reciever_user:receiver_id[0].id,
			sender_sucursal:session[:sucursal],
			reciever_sucursal:sender_sucursal_id[0].id,
			fecha_envio:envio)
		sender_row.save

		sender_last = Sender.last

		if(params[:desc] != "" )
			paquete = Package.create(
				weight:params[:peso],
				height:params[:alto],
				status:"Recibido",
				width:params[:ancho],
				large:params[:largo],
				valor:params[:valor],
				sender_id:sender_last.id,
				descripcion:params[:desc]
			)
		else
			paquete = Package.create(
				weight:params[:peso],
				height:params[:alto],
				status:"Recibido",
				width:params[:ancho],
				large:params[:largo],
				valor:params[:valor],
				sender_id:sender_last.id,
				descripcion:""
			)
		end
		if paquete.save
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

	def cambiar_estado
		id = params[:id]
		status = params[:status]
		

		begin
			pack = Package.find(id)
		rescue ActiveRecord::RecordNotFound => e
			pack = nil
		end

		if (pack == nil)
			retorno = "no"
			respond_to do |format|
				format.json {render json:retorno}
			end
			return
		end
		
		pack.status=status

		if (pack.save)

			if (status == "Entregado")
				time = Time.new
				entrega = time.year.to_s + "-" + time.month.to_s + "-" + time.day.to_s
				senders =  Sender.where(id:pack.sender_id)
				senders[0].fecha_entrega = entrega
				senders[0].save
				users = []
				userE = senders[0].sender_user
				userR = senders[0].reciever_user
				users.push User.find(userE)
				users.push User.find(userR)
				sucursalName = Sucursal.find(session[:sucursal])
				sucursal = sucursalName.name
				ActionCorreo.status_confirmado(users,sucursal).deliver_now
			end
			
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

end
