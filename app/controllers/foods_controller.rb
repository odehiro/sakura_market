class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy, :image]

  def index
    @foods = Food.all
  end

  def show
  end

  def new
    @food = Food.new
    @food.display = true
  end

  def edit
  end

  def create
    @food = Food.new(food_params)
    if image = params[:food][:image]
      @food.image = image.read
    end

    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: '商品を登録しました。' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if image = params[:food][:image]
        @food.image = image.read
      end
      
      if @food.update(food_params)
        format.html { redirect_to @food, notice: '商品情報を更新しました。' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @food.destroy
      redirect_to foods_url, notice: '商品を削除しました。'
    else
      redirect_to foods_url, alert: @food.errors[:base]
    end

    #respond_to do |format|
    #  format.html { redirect_to foods_url, notice: '商品を削除しました。' }
    #  format.json { head :no_content }
    #end
  end

  def image
    send_data(@food.image, type: 'image/png', disposition: 'inline')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_params
      params.require(:food).permit(:name, :price, :caption, :display, :order)
    end
end
