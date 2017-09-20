class Delivery
  BUSINESS_START_DAY = 3
  BUSINESS_END_DAY = 14

  def initialize(base_day, target_day = nil)
    @base_day = base_day
    @target_day = target_day
  end

  def start_date
    date = @base_day
    i = 0

    loop {
      if date.workday? then
        i += 1
      end

      if i > BUSINESS_START_DAY
        break
      end

      date = date.tomorrow
    }
    
    return date
  end

  def end_date
    date = @base_day
    i = 0

    loop {
      if date.workday? then
        i += 1
      end

      if i > BUSINESS_END_DAY
        break
      end

      date = date.tomorrow
    }

    return date
  end

  def target_workday? 
    @target_day.workday?
  end
end
