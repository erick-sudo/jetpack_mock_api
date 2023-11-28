class PhotosController < ApplicationController
    # def index
    #     images = params[:method] == "list" ? Photo.all : Photo.all.slice(0, rand(0..Photo.count))
    #     res = {
    #         "photos"  =>  {
    #             "page"  =>  1,
    #             "pages"  =>  5,
    #             "perpage"  =>  100,
    #             "total"  =>  500,
    #             "photo"  =>  images
    #         },
    #         "extra"  =>  { "explore_date"  =>  "2023-11-09", "next_prelude_interval"  =>  54576 },
    #         "stat"  =>  "ok"
    #     }
    
    #     render json: res.as_json
    # end
end
