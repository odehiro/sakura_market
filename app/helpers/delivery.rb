class Delivery
  BUSINESS_START_DAY = 3
  BUSINESS_END_DAY = 14

  def initialize(base_day, target_day)
    @base_day = base_day
    @target_day = target_day
  end

  def valid_target_day?
    date = 
    while true
      add_date = @base_day.next.day

    end
  end

  #スタート日
  def delivery_start_date
    date = @base_day
    i = 0

    while i < BUSINESS_START_DAY
      if date.workday? then
        i += 1
      end

      date = date.tomorrow
    end

    return date
  end

  #エンド日
  def delivery_end_date
    date = @base_day
    i = 0

    while i < BUSINESS_END_DAY
      if date.workday? then
        i += 1
      end

      date = date.tomorrow
    end

    return date
  end
end
