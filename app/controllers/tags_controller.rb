class TagsController < ApplicationController

  # GET /tags/1
  def show
    @tag = Tag.find(params[:id])
    @questions = @tag.questions
  end

  private

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:show)
    end
end
