require 'spec_helper'

describe SingleBattlesController do
  describe 'GET #index' do
    it 'populates an array of single_battles with the id' do
      energy = create(:single_battle, theme: "Energy")
      dirt = create(:single_battle, theme: "Dirt")
      get :index
      expect(assigns(:single_battles)).to eq([energy,dirt])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end     # GET #index

  describe 'GET #show' do
    it 'assigns the requested message to @single_battle' do
      battle = create(:single_battle)
      get :show, id: battle
      expect(assigns(:single_battle)).to eq battle
    end
    it 'renders the :show template' do
     battle = create(:single_battle)
     get :show, id: battle
     expect(response).to render_template :show
    end
  end     # GET #show

  describe 'GET #new' do
    it 'assigns a new single_battle to @single_battle' do
      get :new
      expect(assigns(:single_battle)).to be_a_new(SingleBattle)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end     # GET #new

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new single_battle in the database' do
        expect do
          (post :create, single_battle: attributes_for(:single_battle)).to change(SingleBattle, :count).by(1)
        end
      end

      # it 'saves the values of host_id as the current_user.id' do
      #   current_user = controller.current_user
      #   post :create, single_battle: attributes_for(:single_battle)
      #   expect(single_battle: :host_id).to eq(current_user.id)
      # end

      it 'redirects to single_battles#show'do
        post :create, single_battle: attributes_for(:single_battle)
        expect(response).to redirect_to single_battle_path(assigns[:single_battle])
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new single_battle in the database' do
        expect do
          (post :create, single_battle: attributes_for(:invalid_single_battle)).to_not change(SingleBattle, :count).by(1)
        end
      end
      it 're-renders the :new template' do
        post :create, single_battle: attributes_for(:invalid_single_battle)
        expect(response).to render_template :new
      end
    end
  end     # POST #create

  describe 'GET #edit' do
    it 'assigns the requested single_battle to @single_battle' do
      battle = create(:single_battle)
      get :edit, id: battle
      expect(assigns(:single_battle)).to eq battle
    end

    it 'renders the :edit template' do
      battle = create(:single_battle)
      get :edit, id: battle
      expect(response).to render_template :edit
    end
  end     # GET #edit

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the single_battle in the database' do
        battle = create(:single_battle)
        patch :update, id: battle, single_battle: attributes_for(:single_battle)
        expect(assigns(:single_battle)).to eq battle
      end

      it 'changes single_battles attributes' do
        battle = create(:single_battle)
        patch :update, id: battle, single_battle: attributes_for(:single_battle, theme:"Dirt")
        battle.reload
        expect(battle.theme).to eq("Dirt")
      end

      it 'redirects to the updated single_battle' do
        battle = create(:single_battle)
        patch :update, id: battle, single_battle: attributes_for(:single_battle)
        expect(response).to redirect_to battle
      end
    end

    context 'with invalid attributes' do
      it 'does not update the single_battle' do
        battle = create(:single_battle)
        patch :update, id: battle, single_battle: attributes_for(:single_battle, host_id: nil)
        battle.reload
        expect(battle.theme).to_not eq(1)
      end
      it 're-renders the #edit template' do
        battle = create(:single_battle)
        patch :update, id: battle, single_battle: attributes_for(:invalid_single_battle)
        expect(response).to render_template :edit
      end
    end
  end     # PUT #update

  describe 'DELETE #destroy' do
    before(:each) do
      @battle = create(:single_battle)
    end

    it 'deletes the single_battle from the database' do
      expect{
        delete :destroy, id: @battle
      }.to change(SingleBattle, :count).by(-1)
    end

    it "redirects to single_battle#index" do
      delete :destroy, id: @battle
      expect(response).to redirect_to single_battle_path
    end
  end     # DELETE #destroy
end    # SingleBattleController