class PodcastsController < ApplicationController

  before_filter :authenticate_admin!, :except => [:show, :index] 

  # GET /podcasts
  # GET /podcasts.json
  def index
    @podcasts = Podcast.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @podcasts }
    end
  end

  # GET /podcasts/1
  # GET /podcasts/1.json
  def show
    if params[:id]
      @podcast = Podcast.find(params[:id])
    elsif params[:podcast_shortname]
      @podcast = Podcast.where(:shortname => params[:podcast_shortname]).first
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @podcast }
      format.rss  # show.builder
    end
  end

  # GET /podcasts/new
  # GET /podcasts/new.json
  def new
    @podcast = Podcast.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @podcast }
    end
  end

  # GET /podcasts/1/edit
  def edit
    if params[:id]
      @podcast = Podcast.find(params[:id])
    elsif params[:podcast_shortname] 
      @podcast = Podcast.where(:shortname => params[:podcast_shortname]).first
    end
  end

  # POST /podcasts
  # POST /podcasts.json
  def create
    @podcast = Podcast.new(params[:podcast])

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to @podcast, notice: 'Podcast was successfully created.' }
        format.json { render json: @podcast, status: :created, location: @podcast }
      else
        format.html { render action: "new" }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /podcasts/1
  # PUT /podcasts/1.json
  def update
    @podcast = Podcast.find(params[:id])

    respond_to do |format|
      if @podcast.update_attributes(params[:podcast])
        format.html { redirect_to @podcast, notice: 'Podcast was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1
  # DELETE /podcasts/1.json
  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.destroy

    respond_to do |format|
      format.html { redirect_to podcasts_url }
      format.json { head :no_content }
    end
  end
end
