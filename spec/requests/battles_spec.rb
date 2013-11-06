require 'spec_helper'

describe "Battles" do
  subject { page }

  describe "page information" do
      before { visit invoeren_path }
      it { should have_title(full_title('Nieuwe meterstanden')) }
  end