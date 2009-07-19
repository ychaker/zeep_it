class ZeepSmsController < ApplicationController

  # GET /zeep_sms
  # GET /zeep_sms.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sms }
    end
  end
  
  # GET /zeep_sms/incoming
  # GET /zeep_sms/incoming.xml
  #
  # Callback URL
  # When users send SMS messages to your website, Zeep Mobile send the requests to this URL.
  # I.e. http://example.com/zeep_sms/incoming
  def incoming    
    response.headers["Content-Type"] = "text/plain; charset=utf-8"
    #Read params from the text message
    
    if (params[:uid] && params[:body])
      @userid = params[:uid]
      @body = params[:body]    
      sms = ZeepSms.new(:raw => @body, :login => @userid)
    end
  
  end
  
  # CRUD method templates:
  
  # GET /zeep_sms/1
  # GET /zeep_sms/1.xml
  # def show
  #   @sms = ZeepSms.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @sms }
  #   end
  # end

  # GET /zeep_sms/new
  # GET /zeep_sms/new.xml
  # def new
  #   @sms = ZeepSms.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @sms }
  #   end
  # end

  # GET /zeep_sms/1/edit
  # def edit
  #   @sms = ZeepSms.find(params[:id])
  # end

  # POST /zeep_sms
  # POST /zeep_sms.xml
  # def create
  #   @sms = ZeepSms.new(params[:sms])
  # 
  #   respond_to do |format|
  #     if @sms.save
  #       flash[:notice] = 'Sms was successfully created.'
  #       format.html { redirect_to(@sms) }
  #       format.xml  { render :xml => @sms, :status => :created, :location => @sms }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @sms.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /zeep_sms/1
  # PUT /zeep_sms/1.xml
  # def update
  #   @sms = ZeepSms.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @sms.update_attributes(params[:sms])
  #       flash[:notice] = 'Sms was successfully updated.'
  #       format.html { redirect_to(@sms) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @sms.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /zeep_sms/1
  # DELETE /zeep_sms/1.xml
  # def destroy
  #   @sms = ZeepSms.find(params[:id])
  #   @sms.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(sms_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
