class ListsController < ApplicationController

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
    puts @list.inspect
    if @list.save
      redirect_to list_path(@list.id)
    else
      render 'new'
    end
  end

  # Edit a list.
  def edit

  end

  # Update a list.
  def update

  end

  # Get more link fields by AJAX.
  def get_more_fields

  end

  private
  def list_params
    params.require(:list).permit(:title, :subject, :topic1, :topic2, {links_attributes: [:word1, :word2]})
  end
end
