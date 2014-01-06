class QuizzesController < ApplicationController
before_filter :authenticate_user!

  # GET /quizzes
  # GET /quizzes.json
  def index
      @quizzes = Quiz.all  
      
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quizzes }
    end
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quiz }
    end
  end

  # GET /quizzes/new
  # GET /quizzes/new.json
  def new
    @quiz = Quiz.new
    @quiz.q1=Array.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quiz }
    end
  end

  # GET /quizzes/1/edit
  def edit
    @quiz = current_user.quiz.find(params[:id])
    @activities = Activity.all
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
  	if(current_user.quiz != nil)
      current_user.quiz.destroy
    end
    
    @quiz = Quiz.new(params[:quiz])
    @quiz.userName=current_user.name
    @quiz.user_id=current_user.id
    @activities = Activity.all  
    if current_user.position == "High School"
       @quiz.q3="High School"
       @quiz.q4= "High School"      
    else
       @quiz.q3="College"
       @quiz.q5= "None"
    end
    respond_to do |format|
      if @quiz.save
        current_user.quiz=@quiz
        format.html { redirect_to @quiz, notice: 'Thank You for Taking the Quiz!.' }
        format.json { render json: @quiz, status: :created, location: @quiz }
      else
        format.html { render action: "new" }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quizzes/1
  # PUT /quizzes/1.json
  def update
    @quiz = Quiz.find(params[:id])
    
    respond_to do |format|
      if @quiz.update_attributes(params[:quiz])
        format.html { redirect_to @quiz, notice: 'Quiz was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy

    respond_to do |format|
      format.html { redirect_to quizzes_url }
      format.json { head :ok }
    end
  end
end
