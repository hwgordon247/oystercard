
class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def fare(journey)

    if journey[:out] == nil || journey[:in] == nil
      PENALTY_FARE
    else
      MINIMUM_FARE
    end

  end

end
