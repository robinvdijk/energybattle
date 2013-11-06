require 'spec_helper'

describe TeamRelationsController do
  before :each do
      request.env["HTTP_REFERER"] = ""
      @battle = create(:battle)
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new team_relation in the database' do
        expect do
          (post :create, team_relation: attributes_for(:team_relation)).to change(TeamRelation, :count).by(1)
        end
      end

      it 'redirects to battle_path' do
        post :create, team_relation: attributes_for(:team_relation)
        expect(response).to redirect_to battle_path(@battle)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new team_relation in the database' do
        expect do
          (post :create, team_relation: attributes_for(:invalid_team_relation)).to_not change(TeamRelation, :count).by(1)
        end
      end

      it 'redirects back to battle_path' do
        post :create, team_relation: attributes_for(:invalid_team_relation)
        expect(response).to redirect_to battle_path(@battle)
      end
    end
  end     # POST #create

  describe 'DELETE #destroy' do
    before do
      @team_relation = create(:team_relation)
    end

    it 'deletes the team_relation from the database' do
      expect{
        delete :destroy, id: @team_relation
      }.to change(TeamRelation, :count).by(-1)
    end

    it "redirects to battles#index" do
      delete :destroy, id: @team_relation
      expect(response).to redirect_to battles_path
    end
  end     # DELETE #destroy
end    # TeamRelationsController