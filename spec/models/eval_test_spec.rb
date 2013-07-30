require 'spec_helper'

describe EvalTest do

  let(:user) { FactoryGirl.create(:user) }
  before { @eval_test = user.eval_tests.build(name: "Lorem ipsum", description: "Evaluation Test description") }

  subject { @eval_test }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @eval_test.user_id = nil }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @eval_test.name = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        EvalTest.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @eval_test.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { @eval_test.name = " " }
    it { should_not be_valid }
  end

  describe "with blank description" do
    before { @eval_test.description = " " }
    it { should_not be_valid }
  end

  describe "with description that is too long" do
    before { @eval_test.description = "a" * 351 }
    it { should_not be_valid }
  end

end