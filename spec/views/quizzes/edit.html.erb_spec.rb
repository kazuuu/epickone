require 'spec_helper'

describe "quizzes/edit" do
  before(:each) do
    @quiz = assign(:quiz, stub_model(Quiz,
      :title => "MyString",
      :event_id => 1
    ))
  end

  it "renders the edit quiz form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", quiz_path(@quiz), "post" do
      assert_select "input#quiz_title[name=?]", "quiz[title]"
      assert_select "input#quiz_event_id[name=?]", "quiz[event_id]"
    end
  end
end
