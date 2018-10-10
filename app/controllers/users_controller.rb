class UsersController < ApplicationController



  before_action :set_user, only: [:show, :edit, :update, :destroy, :avatar, :upload_avatar, :destroy_avatar]
    before_action :has_access , :only => [:edit, :update, :delete]

   require 'rest-client'

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end


  def has_access
    redirect_to('/') unless current_user.is_admin?
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end


   def call_action


      @report_output_file_name = "Report"
     
  
      @report_format = "pdf"
	  @path_to_report = "/reports/TEST"


	  @login = "jasperadmin"
      @password = "jasperadmin"

	   user_auth_str = "#{@login}"        
       auth = "Basic " + Base64::strict_encode64("#{user_auth_str}:#{@password}") 

	   report_url =  "http://127.0.0.1:8080/jasperserver/rest_v2/reports#{@path_to_report}.#{@report_format}"

	   report_url = URI.escape(report_url)




	begin
      #run the report
      response = RestClient.get("#{report_url}", :authorization=>auth)
      #response = RestClient.post("#{report_url}", :authorization=>auth)


    rescue Exception => exception
      
      Rails.logger.info "Got exception when report was running: #{exception.message}"
      render plain: "Error! Got exception when report was running: #{exception.message}"
      return
    end


	#send_data response.body, :filename => "#{@report_output_file_name}.#{@report_format}",disposition: "attachment", :type => "application/pdf"


	#THIS DOES NOT WORK IN WINDOWS
	 mailer = ActionMailer::Base.mail(:to => "geordie.guenther@erasoft.ca", :from => "easyerasolutions@gmail.com", :content_type=>"application/pdf", :body=> '')
	 mailer.attachments["TEST.pdf"]= { :content_type => "application/pdf", :body => File.read("public/res.pdf", mode: "rb")  }
	 mailer.deliver_now!

	 end

  

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    # flash message - set message
    @action_message = t(:flash_edit, scope: "simple_form.labels.user") + @user.first_name.to_s

    respond_to do |format|
      format.html do
      end
      format.js
      format.json
    end
  end

  # POST /users
  # POST /users.json
  def create

      recipient_emails = conversation_params(:recipients).split(',')
    recipients = User.where(email: recipient_emails).all



    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @cancel_id = @user.id

        # flash message - set message
        @action_message = t(:flash_save_success, scope: "simple_form.labels.user")

        format.html { redirect_to edit_user_path(@user), :flash => { :success => @action_message } }
        format.js
        format.json { render json: @user, status: :created, location: @user }
      else

        @cancel_id = nil

        # flash message - set message
        @action_message = "Fail!"

        format.html { render action: "new", :flash => { :error => @action_message } }
        format.js
        format.json { render json: @user.errors, status: :unprocessable_entity } 
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|


	p 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
	p user_params
	p 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
      if @user.update(user_params)
        format.html { redirect_to @user}
        format.json { render :show, status: :ok, location: @user }
      else


        @action_message = t(:flash_save_failed, scope: "simple_form.labels.user")

        format.html { flash[:error] = @action_message }
        format.js
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy

    @destroyed_user_id = @user.id
    @user.destroy


  
      @cancel_id = nil


    respond_to do |format|
      format.html { redirect_to new_user_url }
      format.js
      format.json { head :no_content }
    end
  end


  def avatar
  end

  def upload_avatar

  p 'xxxxxxxxxxxxxxxxxxx'
  p user_avatar_params
    if @user.update(user_avatar_params)
	 respond_to do |format|
			  # flash message - set message
			  @action_message = "Success"
			  format.html { redirect_to edit_user_path(@user), :flash => { :success => @action_message } }
	    end
    else        
      # flash message - set message
      @action_message  = "Failed"
    end
  end

  def destroy_avatar
    @user.avatar = nil
    @user.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :enabled, :is_admin, :avatar)
	  user_params.delete(:password) unless user_params[:password].present?
	  user_params
    end


  def user_avatar_params
    params.require(:user).permit(:avatar, :lock_version)
  end

end


   
