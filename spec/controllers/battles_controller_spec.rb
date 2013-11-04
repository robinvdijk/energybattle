require 'spec_helper'

describe BattlesController do
  before :each do
      request.env["HTTP_REFERER"] = ""
      current_user = create(:user)
  end

  describe 'GET #index' do
    it 'populates an array of battles with the id' do
      energy = create(:battle, theme: "Energy")
      dirt = create(:battle, theme: "Dirt")
      get :index
      expect(assigns(:battles)).to eq([energy,dirt])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end     # GET #index

  describe 'GET #show' do
    it 'assigns the requested message to @battle' do
      battle = create(:battle)
      get :show, id: battle
      expect(assigns(:battle)).to eq battle
    end

    it 'renders the :show template' do
     battle = create(:battle)
     get :show, id: battle
     expect(response).to render_template :show
    end
  end     # GET #show

  describe 'GET #new' do
    it 'assigns a new battle to @battle' do
      get :new
      expect(assigns(:battle)).to be_a_new(Battle)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end     # GET #new

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new battle in the database' do
        expect do
          (post :create, battle: attributes_for(:battle)).to change(Battle, :count).by(1)
        end
      end

      it 'redirects to battles#show'do
        post :create, battle: attributes_for(:battle)
        expect(response).to redirect_to battle_path(assigns[:battle])
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new battle in the database' do
        expect do
          (post :create, battle: attributes_for(:invalid_battle)).to_not change(Battle, :count).by(1)
        end
      end
      it 're-renders the :new template' do
        post :create, battle: attributes_for(:invalid_battle)
        get :new
        expect(response).to render_template :new
      end
    end
  end     # POST #create

  describe 'GET #edit' do
    it 'assigns the requested battle to @battle' do
      battle = create(:battle)
      get :edit, id: battle
      expect(assigns(:battle)).to eq battle
    end

    it 'renders the :edit template' do
      battle = create(:battle)
      get :edit, id: battle
      expect(response).to render_template :edit
    end
  end     # GET #edit

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the battle in the database' do
        battle = create(:battle)
        patch :update, id: battle, battle: attributes_for(:battle)
        expect(assigns(:battle)).to eq battle
      end

      it 'changes battles attributes' do
        battle = create(:battle)
        patch :update, id: battle, battle: attributes_for(:battle, theme:"Dirt")
        battle.reload
        expect(battle.theme).to eq("Dirt")
      end

      it 'redirects to the updated battle' do
        battle = create(:battle)
        patch :update, id: battle, battle: attributes_for(:battle)
        expect(response).to redirect_to battle
      end
    end

    context 'with invalid attributes' do
      it 'does not update the battle' do
        battle = create(:battle)
        patch :update, id: battle, battle: attributes_for(:battle, host_id: nil)
        battle.reload
        expect(battle.host_id).to_not eq(:nil)
      end
      it 're-renders the #edit template' do
        battle = create(:battle)
        patch :update, id: battle, battle: attributes_for(:invalid_battle)
        get :edit, id: battle
        expect(response).to render_template :edit
      end
    end
  end     # PUT #update

  describe 'DELETE #destroy' do
    before(:each) do
      @battle = create(:battle)
    end

    it 'deletes the battle from the database' do
      expect{
        delete :destroy, id: @battle
      }.to change(Battle, :count).by(-1)
    end

    it "redirects to battle#index" do
      delete :destroy, id: @battle
      expect(response).to redirect_to battle_path
    end
  end     # DELETE #destroy
end    # BattleController