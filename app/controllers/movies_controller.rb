class MoviesController < ApplicationController
  

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  
  
  #######################################################################################

  def index
    
    print params
    
    if params[:sort]  #saves the parameters so that they are remembered later on
      session[:sort] = params[:sort]
    end
    
    
    @all_ratings = Movie.all_ratings
    

    
    if session[:sort] #loads previous paramaters
      hiliteFlag = session[:sort]
    else
      hiliteFlag = params[:sort]
    end
    
    case hiliteFlag
    
      when 'title'
        @titulo = {:title => :asc}, 'hilite'
      when 'release_date'
        @fecha = {:release_date => :asc}, 'hilite'
    end
   
  if (params[:sort])
    @movies = Movie.order(params[:sort])
  else
    @movies = Movie.order(session[:sort])
  end
  
    #@movies = Movie.where{params[:ratings].keys. }
    
  end
  
  ######################################################################################

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  

end