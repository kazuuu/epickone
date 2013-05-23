require 'spec_helper'

describe "quizzes/new" do
  before(:each) do
    assign(:quiz, stub_model(Quiz,
      :title => "MyString",
      :event_id => 1
    ).as_new_record)
  end

  it "renders new quiz form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", quizzes_path, "post" do
      assert_select "input#quiz_title[name=?]", "quiz[title]"
      assert_select "input#quiz_event_id[name=?]", "quiz[event_id]"
    end
  end
end
