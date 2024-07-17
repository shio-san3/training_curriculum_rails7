class CalendarsController < ApplicationController

  # １週間のカレンダー・予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    plan = Plan.new(plan_params)
    if plan.save
      redirect_to action: :index
    else
      get_week
      @plan = plan
      render :index
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    
    wdays = ['(日)', '(月)', '(火)', '(水)', '(木)', '(金)', '(土)']
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    @todays_date = Date.today
    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end

      wday_num = (@todays_date + x).wday # wdayメソッドを用いて曜日の数値を取得
      if wday_num >= 7
        wday_num = wday_num - 7
      end
      days = { 
        month: (@todays_date + x).month, 
        date: (@todays_date + x).day, 
        plans: today_plans, 
        wday: wdays[wday_num] # wdays配列から値を取り出す
      }
      days = { month: (@todays_date + x).month, date: (@todays_date + x).day, plans: today_plans }
      @week_days.push(days)
    end
  end
end