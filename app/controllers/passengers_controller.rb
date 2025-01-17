class PassengersController < ApplicationController
  def index
    @passengers = Passenger.alpha_passengers
  end
  
  def new
    @passenger = Passenger.new
  end
  
  def create
    @passenger = Passenger.new(name: params[:passenger][:name], phone_number: params[:passenger][:phone_number]) 
    if @passenger.save
      redirect_to passenger_path(@passenger.id) 
      return
    else 
      render :new 
      return
    end
  end
  
  def show
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      redirect_to root_path
      return 
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])
    
    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end
  
  def update
    @passenger = Passenger.find_by(id: params[:id])
    
    if @passenger.nil?
      redirect_to passengers_path
      return
    elsif @passenger.update(
      name: params[:passenger][:name], 
      phone_number: params[:passenger][:phone_number]
    )
    redirect_to passenger_path(@passenger.id)
    return
  else 
    render :edit
    return
  end
end

def destroy
  @passenger = Passenger.find_by(id: params[:id])
  
  if @passenger.nil?
    head :not_found
    return
  end
  
  @passenger.destroy
  redirect_to passengers_path
  return
end

end
