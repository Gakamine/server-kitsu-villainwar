module Types
    class OpponentType < Types::BaseObject

        description "Opponents information"
        field :id, ID, null:false
        field :name, String, null:false
        field :image, String, null: true
        def image
            Rails.application.routes.url_helpers
            .rails_blob_path(object.image, only_path: true)
        end

    end
end 