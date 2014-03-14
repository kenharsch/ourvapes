class ProductMock
  attr_accessor :name, :description
end

class TankMock < ProductMock
  attr_accessor :volume_in_ml
end

class WickMock < ProductMock
  attr_accessor :resistance_in_ohm
end

class KitMock < ProductMock
  attr_accessor :tank, :wick
end

class CompCheckerMock
  
  attr_reader :conflict_parts

  attr_reader :kit

  def initialize
    conflict_parts = {}
    conflict_parts[:wick] = false
    conflict_parts[:tank] = false

  end

  def set_kit(kit)
    @kit = kit
  end

  def conflicts?(type)
    conflict_parts[type]
  end

  def conflicts?
    true
  end

  def all_conflicts
    # TODO
  end

end





class ConfigControllersController < ApplicationController
  before_action :set_config_controller, only: [:show, :edit, :update, :destroy]

  # GET /config_controllers
  # GET /config_controllers.json
  def index
    @config_controllers = ConfigController.all
  end

  # GET /config_controllers/1
  # GET /config_controllers/1.json
  def show
    kit = KitMock.new
    kit.wick = Wick.new
    kit.wick.name = "Wick Super X"
    kit.tank = Tank.new
    kit.tank.name = "Not so super tank"

    @comp_checker = CompCheckerMock.new
    @comp_checker.set_kit(kit)

    @comp_checker.conflict_parts[:kit] = true
  end

  # GET /config_controllers/new
  def new
    @config_controller = ConfigController.new
  end

  # GET /config_controllers/1/edit
  def edit
  end

  # POST /config_controllers
  # POST /config_controllers.json
  def create
    @config_controller = ConfigController.new(config_controller_params)

    respond_to do |format|
      if @config_controller.save
        format.html { redirect_to @config_controller, notice: 'Config controller was successfully created.' }
        format.json { render action: 'show', status: :created, location: @config_controller }
      else
        format.html { render action: 'new' }
        format.json { render json: @config_controller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /config_controllers/1
  # PATCH/PUT /config_controllers/1.json
  def update
    respond_to do |format|
      if @config_controller.update(config_controller_params)
        format.html { redirect_to @config_controller, notice: 'Config controller was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @config_controller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /config_controllers/1
  # DELETE /config_controllers/1.json
  def destroy
    @config_controller.destroy
    respond_to do |format|
      format.html { redirect_to config_controllers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_config_controller
      @config_controller = ConfigController.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def config_controller_params
      params.require(:config_controller).permit(:show)
    end
end
