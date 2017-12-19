class PictureController < ApplicationController
    before_action :set_hotel
    def create
       add_more_pictures(picture_params[:picture])
       flash[:error] = "Failed uploading images" unless @hotel.save
       redirect_back(fallback_location: root_path)
    end
    def destroy
      remove_picture_at_index(params[:id].to_i)
      flash[:error] = "Failed deleting image" unless @hotel.save
      redirect_back(fallback_location: root_path)
    end
      private
    
      def set_hotel
        @hotel = Hotel.find(params[:hotel_id])
      end
    
      def add_more_pictures(new_images)
        pictures = @hotel.picture # copy the old images 
        pictures += new_images # concat old images with new ones
        @hotel.picture = pictures # assign back
      end
      
      def remove_picture_at_index(index)
        remain_picture = @hotel.picture # copy the array
        deleted_picture = remain_picture.delete_at(index) # delete the target image
        deleted_picture.try(:remove!) # delete image from S3
        @hotel.picture = remain_picture # re-assign back
        @hotel.remove_picture! if remain_picture.empty?
      end

      def picture_params
        params.require(:hotel).permit({picture: []}) # allow nested params as array
      end
    end
