class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy]

  def renderError(message, code, description)
  render status: code,json: {
    message: message,
    code: code,
    description: description
  }
  end

  def showPendingPaybyUser
    if !(Integer(params[:user_id]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 406, "The parameter user_id is not an integer")
      return -1
    end
    list = List.by_user(params[:user_id])
    if(list)
  	  render json: list, status: 200
  	else
        renderError("Not Found", 404, "The resource does not exist")
  	end
  end

  # GET /lists
  def index
    if(params[:firstResult])
      @first=params[:firstResult]
      if !(Integer( @first) rescue false)
        renderError("Not Acceptable (Invalid Params)", 406, "The parameter firstResult is not an integer")
        return -1
      end
      @first=params[:firstResult].to_f-1
      if(params[:maxResult])
          @max=params[:maxResult]
          if !(Integer( @max) rescue false)
            renderError("Not Acceptable (Invalid Params)", 406, "The parameter maxResult is not an integer")
            return -1
          end
          @lists = List.all.limit(@max).offset(@first)
      else
        @lists = List.all.offset(@first)
      end
    else
      if(params[:maxResult])
          @max=params[:maxResult]
          if !(Integer( @max) rescue false)
            renderError("Not Acceptable (Invalid Params)", 406, "The parameter maxResult is not an integer")
            return -1
          end
          @lists = List.all.limit(@max)
      else
        @lists = List.all
      end
    end
    render json: @lists
  end


  # GET /lists/1
  def show
  	if !(Integer(params[:id]) rescue false)
        renderError("Not Acceptable (Invalid Params)", 406, "The parameter id is not an integer")
  	  return -1
  	end
  	if(@list)
  	  render json: @list
  	else
        renderError("Not Found", 404, "The resource does not exist")
  	end
  end


  def create
    #if !(Integer(params[:number]) rescue false)
    #  renderError("Bad Request", 400, "The parameter number is not a Integer")
    #  return -1

    puts params[:user_id]
    if !(Integer(params[:user_id]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 400, "The parameter user_id is not an Integer")
      return -1
    elsif !(Integer(params[:cost]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 400, "The parameter cost is not an Integer")
      return -1
    elsif !(Integer(params[:target_account]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 400, "The parameter target_pay is not an Integer")
	  return -1
    else
      @list = List.new(list_params)
    end

    if @list.save
      head 201
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
	if !(Integer(params[:id]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 406, "The parameter id is not an integer")
      return -1
	end
	if(@list)
      ##
    else
      renderError("Not Found", 404, "The resource does not exist")
      return -1
    end
    if(params[:user_id])
      if !(Integer(params[:user_id]) rescue false)
        renderError("Not Acceptable (Invalid Params)", 406, "The parameter user_id is not an Integer")
        return -1
      end
    end
    if(params[:cost])
      if !(Integer(params[:cost]) rescue false)
        renderError("Not Acceptable (Invalid Params)", 406, "The parameter cost is not an Integer")
        return -1
      end
    end
    if(params[:target_account])
      if !(Integer(params[:target_account]) rescue false)
        renderError("Not Acceptable (Invalid Params)", 406, "The parameter target_account is not an Integer")
        return -1
      end
    end

    if @list.update(list_params)
      head 204
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/1
  def destroy
    if !(Integer(params[:id]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 406, "The parameter id is not an integer")
      return -1
    end
    if(@list)
      @list.destroy
      head 200
    else
      renderError("Not Found", 404, "The resource does not exist")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def list_params
      params.require(:list).permit(:user_id, :description,
        :date_pay, :cost, :target_account, :state)
    end
end
