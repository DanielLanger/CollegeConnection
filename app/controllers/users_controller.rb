class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  
   before_filter :authenticate_user!,
    :except => [:welcome]
        
  def welcome
  	respond_to do |format|
  		format.html
  	end
  end
  
  def weightquiz(refquiz, thisquiz)  	
    weight = 0.0
    
    newref = Array.new
    newthis= Array.new
    
    refquiz.q2.each do |q|
      if (q != "") 
        newref.push(q)
      end
	end
	
	thisquiz.q2.each do |q|
      if (q != "") 
        newthis.push(q)
      end
	end
	#current users quiz is refquiz
	if(current_user.position =="High School")
      if (refquiz.q1[0] == thisquiz.q1) then
        weight += 40.0
      end  
      if (refquiz.q1[1] == thisquiz.q1) then
        weight += 30.0
      end  
      if (refquiz.q1[2] == thisquiz.q1) then
        weight += 20.0
      end 
    else
      if (thisquiz.q1[0] == refquiz.q1) then
        weight += 40.0
      end  
       if (thisquiz.q1[1] == refquiz.q1) then
        weight += 30.0
      end  
       if (thisquiz.q1[2] == refquiz.q1) then
        weight += 20.0
      end  
    end 
    
    common=0.0
    
   	newthis.zip(newref) do |ans, ans2|
        if ans == ans2  then
          common+=6.0
        end
    end
    
    average=((newref.length).to_f + (newthis.length).to_f)/2.0
    
      return weight+ (common/average)*10.0
  end
  
  def index
  	
  	if(current_user.quiz!=nil && current_user.position=="High School")
  	@short=Array.new  
      current_user.quiz.q5.each do |q|
      if (q != "") 
        @short.push(q)
      end
  	  end	
  	end
  	  
  
    if current_user.position == "High School"
      if (params["filter"]=="" or params["filter"]==nil)
        @quizzes= Quiz.where(:q3 => "College")
       else
        @quizzes= Quiz.where(:q3 => "College", :q4=> params["filter"])
       end
    else
      @quizzes= Quiz.where(:q3 => "High School") 
    end
    
    @hash = Hash.new();
    @me = current_user.quiz
    
    if(@me== nil)
      @me=Quiz.new
      @me.q1=""
      @me.q2=[]
    end
    
    counter=0.00
    @quizzes.each do |quiz|
      @hash[weightquiz(@me, quiz)+counter] = quiz
      counter+=0.01
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/edit
  def edit
  	 @user=current_user
     respond_to do |format|
  		format.html
  		format.json { render json: @user }
  	  end
  end


  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        Notifier.signup_email(@user).deliver
        UserMailer.welcome_email(@user).deliver
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
