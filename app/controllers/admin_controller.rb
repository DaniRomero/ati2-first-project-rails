class AdminController < ApplicationController
	layout 'application_footer.html.haml'
	
	def index
		@user = User.find(session[:id])
		@sucursals = Sucursal.all
		@vs = VariablesSistema.last
	end
	
	def logout
	    reset_session
	    redirect_to controller: :default, action: :index
	    return
	end

	def add_sucursal
		name = params[:name]
		dir = params[:dir]
		phone = params[:phone]
		suc = Sucursal.create(name:name,
			address:dir,
			phone_number:phone)
		if suc.save
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

	def add_operador
		suc = Sucursal.where(name:params[:sucursal])
		user = User.create(
			first_name:params[:name],
			last_name:params[:last],
			age:params[:age],
			cedula:params[:ci],
			phone:params[:phone],
			email:params[:email],
			password:Digest::MD5.hexdigest(params[:code]),
			user_type:"1",
			sucursal_id:suc[0].id
		)
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

	def add_admin
		p "HOLAAA"
		suc = Sucursal.where(name:params[:sucursal])
		user = User.create(
			first_name:params[:name],
			last_name:params[:last],
			age:params[:age],
			cedula:params[:ci],
			phone:params[:phone],
			email:params[:email],
			password:Digest::MD5.hexdigest(params[:code]),
			user_type:"2"
		)
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

	def cambiarTarifa
		id = VariablesSistema.last.id
		newVs = VariablesSistema.create(id:id+1, 
			const:params[:constante], k:params[:k])

		if newVs.save 
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
