require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1',    text: 'Solution ADN') }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Decouvrir page" do
    before { visit decouvrir_path }

    it { should have_selector('h1',    text: 'Decouvrir') }
    it { should have_selector('title', text: full_title('Decouvrir')) }
  end

  describe "Avantages page" do
    before { visit avantages_path }

    it { should have_selector('h1',    text: 'Avantages') }
    it { should have_selector('title', text: full_title('Avantages')) }
  end

  describe "Signin_page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign-In') }
    it { should have_selector('title', text: full_title('Sign-In')) }
  end
end