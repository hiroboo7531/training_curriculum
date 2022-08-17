class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    # コントロール内でインスタンスメソッドの定義文を使いたい場合は上記のように裸で入力して良い
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
                # (plan:params[:plan])という書き方はありか？
                # プライベートメソッドでrequireとpermitを引張ってくるための引数だからダメ
    redirect_to action: :index
  end

  private

  def plan_params

    params.require(:plan).permit(:date, :plan)

    # パラメータからどの情報を受け取るか(モデル名)=require、
    # 取得したいキーを指定、キーと値のセットのみを取得permit

  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例) 今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)
    # モデル名.where("条件") "条件"に name:〇〇 とかいたらnameカラムから〇〇が入ったレコードを全て取得
    #(name: "〇〇", age: ０) や (name: "〇〇").or(User.where(age: 0))  の書き方がある
    #ドットの二連続は範囲オブフェクトと言ってどこからどこかを指定

    #このプログラムにおけるカラムはマイグレートファイルから  :date  :plan  モデルはPlan

    7.times do |x|
      # 0からブロック変数を繰り返す
      today_plans = []
      # 変数today_plansに空の配列を設定
      plans.each do |plan|
      # planに変数plansを入れ、それぞれを繰り返す
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end



      wday_num = Date.today.wday + x
      if wday_num >= 7
        wday_num = wday_num -7
      end
#{current_username}
      days = { :month => (@todays_date + x).month, :date => (@todays_date+x).day, :wday => wdays[wday_num], :plans => today_plans}
        #  .monthを消す、 .dayを消すとそれぞれが表記されていたところが西暦に
        # 
                                                                          

      @week_days.push(days)
    end
  end
end
