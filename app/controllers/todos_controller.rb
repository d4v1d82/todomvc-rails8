class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]

  # GET /todos or /todos.json
  def index
    @scope = params[:scope] || "all"
    @todos = Todo.all
    @todos = case @scope
    when "active"
        @todos.active
    when "completed"
        @todos.completed
    else
        @todos
    end

    @todo = Todo.new
    @todosLeftCount = Todo.active.count
  end

  # GET /todos/1 or /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos or /todos.json
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to action: :index }

      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        # sleep 3
        format.html { redirect_to action: :index }
      else
        format.html { render :edit, status: :unprocessable_entity }

      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy!

    respond_to do |format|
      format.html { redirect_to todos_path, status: :see_other, notice: "Todo was successfully destroyed." }
    end
  end

  def clear_completed
    Todo.completed.destroy_all

    respond_to do |format|
      format.html { redirect_to todos_path, status: :see_other, notice: "Completed todos were successfully destroyed" }
    end
  end

  def toggle_all
    check_all = params[:check_all]
    Todo.update_all(completed: check_all)
    @todos = Todo.all

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(:list, partial: "list")
      end
      format.html { redirect_to todos_path, status: :see_other, notice: "All todos were successfully toggled" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.expect(todo: [ :title, :completed ])
    end
end
