class PupsController < ApplicationController
    def index
        @pups = Pup.all
    end
end
