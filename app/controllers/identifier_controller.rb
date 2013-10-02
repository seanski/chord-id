class IdentifierController < ApplicationController
  def index
    @identifier = Identifier.new
  end

  def show
  end

  def identify
    @identifier = Identifier.new
    @chord = @identifier.identify(params[:identifier][:notes])
  end
end