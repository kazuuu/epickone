require 'spec_helper'

describe StaticPagesController do
  describe "#First test" do
    it "Teste" do
      get 'about'
      response.should be_success
    end
  end
end