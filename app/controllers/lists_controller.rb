class ListsController < ApplicationController

  before_action :authenticate_user!

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

  # Get more link fields by AJAX.
  def get_more_fields

  end

  private
  def list_params
    params.require(:list).permit(:title, :subject, :topic1, :topic2, {links_attributes: [:word1, :word2, :id]})
  end
end
