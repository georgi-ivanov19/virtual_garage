module CarsHelper
    def allow_car_edit(car)
        return false unless current_user
        @car.user_id == current_user.id
      end
end
