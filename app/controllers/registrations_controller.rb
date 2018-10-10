class RegistrationsController < Devise::RegistrationsController


 def create
    @user = User.new(sign_up_params)
		    
    respond_to do |format|
      if @user.save
        @cancel_id = @user.id
		#conversation = current_user.send_message(current_user,  @user.created_at.in_time_zone.strftime("%Y/%m/%d %H:%M"), 'Welcome!').conversation
    	  
        # flash message - set message
        @action_message = t(:flash_save_success, scope: "simple_form.labels.user")

        format.html { redirect_to edit_user_path(@user), :flash => { :success => @action_message } }
        format.js
        format.json { render json: @user, status: :created, location: @user }
      else
	
            @cancel_id = nil

        # flash message - set message
        @action_message = t(:flash_save_failed, scope: "simple_form.labels.user")

        format.html { render action: "new", :flash => { :error => @action_message } }
        format.js
        format.json { render json: @user.errors, status: :unprocessable_entity } 
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :enabled, :is_admin)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :current_password, :password_confirmation, :enabled, :is_admin, :avatar)
  end
end