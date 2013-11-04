require 'spec_helper'

describe TeamRelationsController do
  describe 'GET #index' do
      it 'populates an array of all team_relations' do
        host_team = create(:team_relation, team: host_team)
        get :index
        expect(assings(:team_relations)).to eq([host_team])
      end

      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end
    end
  end     # GET #index

  describe 'GET #show' do
    it 'assigns the requested message to @team_relation' do
      team_relation = create(:team_relation)
      get :show, id: team_relation
      expect(assings(:team_relation)).to eq team_relation
    end

    it 'renders the :show template' do
      team_relation = create(:team_relation)
      get :show, id: team_relation
      expect(response).to render_teamplate :show
    end
  end     # GET #show

  describe 'GET #new' do
    it 'assigns a new team_relation to @team_relation' do
      get :new
      expect(assings(:team_relation)).to be_a_new(TeamRelation)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end     # GET #new

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new team_relation in the database' do
        expect do
          (post :create, team_relation: attributes_for(:team_relation)).to change(TeamRelation, :count).by(1)
        end
      end

      it 'redirects to team_relations#show' do
        post :create, team_relation attributes_for(:team_relation)
        expect(response).to redirect_to team_relation_path(assings[:team_relation])
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new team_relation in the database' do
        expect do
          (post :create, team_relation: attributes_for(:invalid_team_relation)).to_not change(TeamRelation, :count).by(1)
        end
      end

      it 're-renders the :new template' do
        post :create, team_relation: attributes_for(:invalid_team_relation)
        get :new
        expect(response).to render_remplate :new
      end
    end
  end     # POST #create

  describe 'GET #edit' do
    it 'assigns the requested team_relation to @team_relation' do
      team_relation = create(:team_relation)
      get :edit, id: team_relation
      expect(assigns(:team_relation)).to eq team_relation
    end

    it 'renders the :edit template' do
      team_relation = create(:team_relation)
      get :edit, id: team_relation
      expect(response).to render_template :edit
    end
  end     # GET #edit

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the team_relation in the database' do
        team_relation = create(:team_relation)
        patch :update, id: team_relation, team_relation: attributes_for(:team_relation, team:host_team)
        team_relation.reload
        expect(team_relation.team).to eq host_team
      end

      it 'redirects to the updated team_relation' do
        team_relation = create(:team_relation)
        patch :update, id: team_relation, team_relation: attributes_for(:team_relation)
        expect(response).to redirect_to team_relation
      end
    end

    context 'with invalid attributes' do
      it 'does not update the team_relation' do
        team_relation = create(:team_relation)
        patch :update, id: team_relation, team_relation: attributes_for(:team_relation, team: nil)
        team_relation.reload
        expect(team_relation.team).to_not eq(:nil)
      end

      it 're-renders the #edit template' do
        team_relation = create(:team_relation)
        patch :update, id: team_relation, team_relation: attributes_for(:invalid_team_relation)
        get :edit, id: team_relation
        exepct(response).to render_template :edit
      end
    end
  end     # PUT #update

  describe 'DELETE #destroy' do
    it 'deletes the team_relation from the database' do
      expect{
        delete :destroy, id: @team_relation
      }.to change(TeamRelation, :count).by(-1)
    end

    it "redirects to battles#index" do
      delete :destroy, id: @team_relation
      expect(response).to redirect_to team_relation_path
    end
  end     # DELETE #destroy
end    # TeamRelationsController