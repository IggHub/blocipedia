require 'will_paginate'

class WikisController < ApplicationController
  def index
    if current_user == nil
      @wikis = Wiki.visible_to_all
    else
      @wikis = policy_scope(Wiki)

    end

  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create

     @wiki = Wiki.new(wiki_params)
     @wiki.user = current_user
#     @wiki.title = params[:wiki][:title]
#     @wiki.body = params[:wiki][:body]

     if @wiki.save

       flash[:notice] = "Wiki was saved successfully."
       redirect_to @wiki
     else

       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :new
     end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated!"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end


  private
#expect these 4 attributes
   def wiki_params
     params.require(:wiki).permit(:title, :body, :private, :user)
   end
end
