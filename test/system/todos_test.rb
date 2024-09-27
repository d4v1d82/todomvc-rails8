require "application_system_test_case"

class TodosTest < ApplicationSystemTestCase
  setup do
    @todo = todos(:one)
  end

  test "visiting the index" do
    visit todos_url
    assert_selector "h1", text: "todos"

    within ".todo-list" do
      assert_selector "li", count: Todo.count
    end
  end

  test "should create todo" do
    visit todos_url
    fill_in "todo[title]", with: "New Todo\n" # \n is the Enter key

    within ".todo-list" do
      assert_selector "li", text: "New Todo"
    end
  end

  test "should update todo" do
    visit todos_url
    within ".todo-list" do
      targetTodo = find("li", text: @todo.title).find("form")
      targetTodo.double_click
      assert_selector "li form input[type=text]", visible: true

      targetTodo.fill_in "todo[title]", with: "Edited Todo\n" # \n is the Enter key
      assert_selector "li", text: "Edited Todo"
    end
  end

  test "should destroy todo" do
    visit todos_url
    within ".todo-list" do
      targetButton = find("li", text: @todo.title).hover.find("button.destroy",  visible: false)
      targetButton.click
      assert_no_selector "li", text: @todo.title
    end
  end

  test "should clear completed todos" do
    @todo.update_attribute!(:completed, true)

    visit todos_url
    find("button.clear-completed").click

    within ".todo-list" do
      assert_no_selector "li", text: @todo.title
    end
  end

  test "should filter active todos" do
    @todo.update_attribute!(:completed, true)
    todo2 = todos(:two)
    todo2.update_attribute!(:completed, false)

    visit todos_url
    find("a", text: "Active").click

    within ".todo-list" do
      assert_no_selector "li", text: @todo.title
      assert_selector "li", text: todo2.title
    end
  end

  test "should filter completed todos" do
    @todo.update_attribute!(:completed, true)
    todo2 = todos(:two)
    todo2.update_attribute!(:completed, false)

    visit todos_url
    find("a", text: "Completed").click

    within ".todo-list" do
      assert_selector "li", text: @todo.title
      assert_no_selector "li", text: todo2.title
    end
  end
end
