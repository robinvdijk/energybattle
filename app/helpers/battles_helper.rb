module BattlesHelper
  def prepare
    unless @battle.status =! "Pending"
      @battle.update_attributes(status: "Prepare")
      redirect_to :back
    end
  end
end