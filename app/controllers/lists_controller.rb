class ListsController < ApplicationController

  before_action :authenticate_user!
  before_action :make_gon_available_in_view, only: [:new, :edit]

  # A list of lists for this user.
  def index
    @lists = current_user.lists
  end

  # Show a specific list of this user.
  def show
    @list = current_user.lists.find(params[:id])
  end

  # Form to create a new list.
  def new
    @list = current_user.lists.new
    15.times do
      @list.links.build
    end
  end

  # Create the list submitted by the user.
  def create
    @list = current_user.lists.new(list_params)
    if @list.save
      redirect_to list_path(@list.id)
    else
      make_gon_available_in_view if !@gon
      10.times do
        @list.links.build
      end
      render 'new'
    end
  end

  # Edit a list.
  def edit
    @list = current_user.lists.find(params[:id])
    10.times do
      @list.links.build
    end
  end

  # Update a list.
  def update
    @list = current_user.lists.find(params[:id])
    if @list.update(list_params)
      redirect_to list_path(@list)
    else
      render 'edit'
    end
  end

  # Delete a list.
  def destroy
    @list = current_user.lists.find(params[:id])
    @list.destroy
    redirect_to lists_path
  end

  private
  def make_gon_available_in_view
    @gon = gon
  end

  def list_params
    params.require(:list).permit(:title, :subject, :topic1, :topic2, {links_attributes: [:word1, :word2, :id]})
  end
end
