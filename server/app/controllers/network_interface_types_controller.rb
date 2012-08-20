class NetworkInterfaceTypesController < ApplicationController
  before_filter :get_obj_auth
  before_filter :modelperms

  # GET /network_interface_types
  # GET /network_interface_types.xml
  def index
    @network_interface_types = NetworkInterfaceType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @network_interface_types }
    end
  end

  # GET /network_interface_types/1
  # GET /network_interface_types/1.xml
  def show
	  @network_interface_type = @object
    #@network_interface_type = NetworkInterfaceType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @network_interface_type }
    end
  end

  # GET /network_interface_types/new
  # GET /network_interface_types/new.xml
  def new
    @network_interface_type = NetworkInterfaceType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @network_interface_type }
    end
  end

  # GET /network_interface_types/1/edit
  def edit
    @network_interface_type = NetworkInterfaceType.find(params[:id])
  end

  # POST /network_interface_types
  # POST /network_interface_types.xml
  def create
    @network_interface_type = NetworkInterfaceType.new(params[:network_interface_type])

    respond_to do |format|
      if @network_interface_type.save
        format.html { redirect_to(@network_interface_type, :notice => 'NetworkInterfaceType was successfully created.') }
        format.xml  { render :xml => @network_interface_type, :status => :created, :location => @network_interface_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @network_interface_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /network_interface_types/1
  # PUT /network_interface_types/1.xml
  def update
    @network_interface_type = NetworkInterfaceType.find(params[:id])

    respond_to do |format|
      if @network_interface_type.update_attributes(params[:network_interface_type])
        format.html { redirect_to(@network_interface_type, :notice => 'NetworkInterfaceType was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @network_interface_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /network_interface_types/1
  # DELETE /network_interface_types/1.xml
  def destroy
    @network_interface_type = NetworkInterfaceType.find(params[:id])
    @network_interface_type.destroy

    respond_to do |format|
      format.html { redirect_to(network_interface_types_url) }
      format.xml  { head :ok }
    end
  end
end
