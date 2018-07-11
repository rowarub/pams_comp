class ManagersController < ApplicationController

  before_action :authenticate_manager!

  before_action :set_user, only: [:index, :show, :relations]
  before_action :set_company, only: [:show, :relations]
  before_action :set_newest_answers, only: [:show, :relations]
  before_action :set_company_answers, only: [:show]
  before_action :set_manager, only: [:index, :show]
  before_action :set_ranking, only: [:show]
  before_action :set_mana_type_box, only: [:show]
  before_action :set_every_subjects, only: [:show]


  def index
    @new_pamsanswer = PamsAnswer.new(:manager_id=>current_manager.id)
  end

  def show
    @q_1_100 = q_xxx(1, 100)
    @q_1_100_ave = {}
    @q_1_100.each do |q|
      @q_1_100_ave[q] = ( @newest_answers.inject(0.0) { |s, na| s + na[q] } ) / @newest_answers.size
    end

    @company_personal_examinations = mana_result(@q_1_100_ave)

    ex_or_in = 100 - ((@company_personal_examinations[1]
                     + @company_personal_examinations[2]
                     + @company_personal_examinations[3]
                     + @company_personal_examinations[4]) * 100 / (@company_personal_examinations[1]
                                                                 + @company_personal_examinations[2]
                                                                 + @company_personal_examinations[3]
                                                                 + @company_personal_examinations[4]
                                                                 + @company_personal_examinations[6]
                                                                 + @company_personal_examinations[7]
                                                                 + @company_personal_examinations[8]
                                                                 + @company_personal_examinations[9]))

    @balance_of_you = condition_branch_mana_2(ex_or_in)
    @condition_branch_trend_1 = condition_branch_trend_1(@company_personal_examinations[2])
    @condition_branch_trend_2 = condition_branch_trend_2(@company_personal_examinations[3])
    @condition_branch_trend_3 = condition_branch_trend_3(@company_personal_examinations[7])
    @condition_branch_trend_4 = condition_branch_trend_4(@company_personal_examinations[8])

    @result_mana_4 = @company_personal_examinations.values_at(2, 8, 3, 7)

    @condition_branch_mana_type = condition_branch_mana_type(@result_mana_4, @mana_type_box)



    @ranking.each do |rank|
      ave_1 = ( @newest_answers.inject(0.0) { |s, na| s + na[rank[1]] } ) / @newest_answers.size
      ave_2 = ( @sub_answers.inject(0.0) { |s, na| s + na[rank[0]] } ) / @sub_answers.size
      ave_3 = ( @boss_answers.inject(0.0) { |s, na| s + na[rank[0]] } ) / @boss_answers.size
      ave_4 = ( @sub_answers.inject(0.0) { |s, na| s + na[rank[1]] } ) / @sub_answers.size
      ave_5 = ( @boss_answers.inject(0.0) { |s, na| s + na[rank[1]] } ) / @boss_answers.size
      rank.push(ave_1, ave_2, ave_3, ave_4, ave_5)
    end




    @ranking_r = @ranking.sort { |a, b| a[3] <=> b[3] }.reverse

    @ranking_top = @ranking_r[0]
    @importance_in_working = @ranking_top[0]
    @q_1_100_plus_importance = @q_1_100
    @q_1_100_plus_importance.unshift(@importance_in_working)

    @sub_container_pre_sort = []
    @sub_answers.each do |sub|
      box = []
      @q_1_100_plus_importance.each do |q|
        box << sub[q]
      end
      @sub_container_pre_sort.push(box)
    end

    @sub_container_sort = @sub_container_pre_sort.sort { |a, b| b[0] <=> a[0] }
    @sub_container_count_20_per = ( @sub_answers.size / 5 ).floor
    @sub_answers_upper_class = @sub_container_sort.first(@sub_container_count_20_per)
    @sub_answers_lower_class = @sub_container_sort.last(@sub_container_count_20_per)

    @sub_upper_transpose = @sub_answers_upper_class.transpose
    @sub_lower_transpose = @sub_answers_lower_class.transpose

    @sub_upper_transpose.shift(1)
    @sub_lower_transpose.shift(1)


    @sub_upper = {}
    @sub_upper_transpose.each.with_index(1) do |sub, i|
        symbol = "#{('q_' + '%03d' % i)}".to_sym
        @sub_upper[symbol] = (sub.inject(0) { |result, n| result + n} / sub.size).to_i
    end
    @sub_lower = {}
    @sub_lower_transpose.each.with_index(1) do |sub, i|
        symbol = "#{('q_' + '%03d' % i)}".to_sym
        @sub_lower[symbol] = (sub.inject(0) { |result, n| result + n} / sub.size).to_i
    end

    @sub_upper_result = mana_result(@sub_upper)
    @sub_lower_result = mana_result(@sub_lower)






    @sub_importance_of_q_13x_ave = (( @sub_answers.inject(0.0) { |s, user| s + user[@importance_in_working] } ) / @sub_answers.size).round(1)
    @boss_importance_of_q_13x_ave = (( @boss_answers.inject(0.0) { |s, user| s + user[@importance_in_working] } ) / @boss_answers.size).round(1)

    @sub_amount_of_inportance_q_13x = @sub_answers.map { |new| new[@importance_in_working] }
    @boss_amount_of_inportance_q_13x = @boss_answers.map { |new| new[@importance_in_working] }

    @below_average_of_inportance_q_13x = @sub_amount_of_inportance_q_13x.reject { |e| e < @sub_importance_of_q_13x_ave }
    @neo_below_average_of_inportance_q_13x = @boss_amount_of_inportance_q_13x.reject { |e| e < @boss_importance_of_q_13x_ave }

    @a_rate_of_turnover = (( @below_average_of_inportance_q_13x.size.to_f / @sub_amount_of_inportance_q_13x.size.to_f ) * 100).to_i
    @a_rate_of_steady = 100 - @a_rate_of_turnover

    @neo_a_rate_of_turnover = (( @neo_below_average_of_inportance_q_13x.size.to_f / @boss_amount_of_inportance_q_13x.size.to_f ) * 100).to_i
    @neo_a_rate_of_steady = 100 - @neo_a_rate_of_turnover

    if @a_rate_of_steady > @neo_a_rate_of_steady
      @neo_a_rate_of_steady = @a_rate_of_steady + 5
      @neo_a_rate_of_turnover = 100 - @neo_a_rate_of_steady
    end





    @difference_rate = []
    0.upto(9) do |i|
      @difference_rate << (@sub_upper_result[i] - @sub_lower_result[i]).abs
    end

    @every_subjects.each_with_index do |rate, i|
      rate.push(@difference_rate[i])
    end

    @difference_subject_result = @every_subjects.sort { |a, b| b[1] <=> a[1] }




    #showの422行目のjsコードに代入する
    @date = @ranking.map do |r|
      r[4] * 10
    end





    @user_answers_q_101_130 = []
    @q_101_130 = q_xxx(101, 130)
    @q_101_130.each do |q|
      @user_answers_q_101_130 << (( @sub_answers.inject(0.0) { |s, na| s + na[q] } ) / @sub_answers.size * 10).to_i
    end

    @q_101_103 = (@user_answers_q_101_130[0] + @user_answers_q_101_130[1] + @user_answers_q_101_130[2]) / 3
    @q_104_106 = (@user_answers_q_101_130[3] + @user_answers_q_101_130[4] + @user_answers_q_101_130[5]) / 3
    @q_107_110 = (@user_answers_q_101_130[6] + @user_answers_q_101_130[7] + @user_answers_q_101_130[8] + @user_answers_q_101_130[9]) / 4
    @q_111_113 = (@user_answers_q_101_130[10] + @user_answers_q_101_130[11] + @user_answers_q_101_130[12]) / 3
    @q_114_115 = (@user_answers_q_101_130[13] + @user_answers_q_101_130[14]) / 2
    @q_116_118 = (@user_answers_q_101_130[15] + @user_answers_q_101_130[16] + @user_answers_q_101_130[17]) / 3
    @q_119_120 = (@user_answers_q_101_130[18] + @user_answers_q_101_130[19]) / 2
    @q_121_124 = (@user_answers_q_101_130[20] + @user_answers_q_101_130[21] + @user_answers_q_101_130[22] + @user_answers_q_101_130[23]) / 4
    @q_125_126 = (@user_answers_q_101_130[24] + @user_answers_q_101_130[25]) / 2
    @q_127_130 = (@user_answers_q_101_130[26] + @user_answers_q_101_130[27] + @user_answers_q_101_130[28] + @user_answers_q_101_130[29]) / 3





    @satisfaction_10 = @ranking.map do |r|
      r[4] * 10 - 5
    end



    @priority_rank.each_with_index do |rank, i_1|
      @ranking.each_with_index do |r, i_2|
        if i_1 == i_2
          rank.push(r[6].round(3))
          rank.push(r[7].round(3))
        end
      end
    end

    @priority_rank_sub = @priority_rank.sort { |a, b| a[2] <=> b[2] }

    @priority_rank_sub.each.with_index(1) do |rank, i|
      rank.push(i, "#{i}位")
    end

    @priority_rank_boss = @priority_rank_sub.sort { |a, b| a[3] <=> b[3] }

    @priority_rank_boss.each.with_index(1) do |rank, i|
      rank.push("(#{i}位)")
    end

    @priority_rank_sort_fin = @priority_rank_boss.sort { |a, b| a[0] <=> b[0] }

    @priority_10 = @priority_rank_sort_fin.map do |r|
      105 - r[4] * 10
    end

    @user_count = User.where(manager_id: current_manager.id).size
    @user_count_rate_1 = (@user_count * @a_rate_of_turnover / 100).to_i
    @user_count_rate_2 = (@user_count * @a_rate_of_steady / 110).to_i



  end

  def relations
    @user = User.find(params[:user_id])
    @user_answer = PamsAnswer.find_by(user_id: @user.id)
    @user_result = result(@user_answer)
    difference = []
    @newest_answers.each do |na|
      @coworker = result(na)
      box_1 = []
      box_2 = []
      0.upto(9) do |i|
        box_1 << (@user_result[i] - @coworker[i]).abs
      end
      sum = box_1.inject(0) { |result, n| result += n }
      box_2.push(na.user_id, sum)
      difference.push(box_2)
    end

    @difference = difference.sort { |a, b| a[1] <=> b[1] }
    @difference.each_with_index do |d, i|
      d.push(i)
    end
    @user_name = @difference.shift(1)

    @difference_count_30_per = ( @difference.size * 3 / 10 ).floor
    @difference_count_middle = @difference.size - ( @difference_count_30_per * 2 )

    @top_difference = @difference.first(@difference_count_30_per)
    @middle_difference = @difference[@difference_count_30_per, @difference_count_middle]
    @bottom_difference = @difference.last(@difference_count_30_per)
  end



  private
  def set_user
    @users = User.where(manager_id: current_manager.id)
  end

  def set_company
    @sub = User.where(manager_id: current_manager.id, user_type: 0)
    @boss = User.where(manager_id: current_manager.id, user_type: 1)
  end

  def set_newest_answers
    @newest_answers = @users.map do |user|
      PamsAnswer.order(created_at: :desc).find_by(user_id: user[:id], fin_flag: 1)
    end
    @newest_answers.compact!
  end

  def set_company_answers

    @sub_answers = @sub.map do |user|
      PamsAnswer.order(created_at: :desc).find_by(user_id: user[:id], fin_flag: 1)
    end
    @sub_answers.compact!

    @boss_answers = @boss.map do |user|
      PamsAnswer.order(created_at: :desc).find_by(user_id: user[:id], fin_flag: 1)
    end
    @boss_answers.compact!

  end

  def set_manager
    @manager = Manager.find(current_manager.id)
  end

  def set_ranking
    @ranking = ranking
    @priority_rank = priority_rank
  end

  def set_mana_type_box
    @mana_type_box = mana_type_box
  end

  def set_every_subjects
    @every_subjects = every_subjects
  end





  def condition_branch_mana_2(result)
    if result < 50
      return '公的欲求'
    else
      return '私的欲求'
    end
  end

    def condition_branch_trend_1(result)
      if result < 55
        return '外向型'
      else
        return '内向型'
      end
    end

    def condition_branch_trend_2(result)
      if result < 55
        return '思慮型'
      else
        return '行動型'
      end
    end

    def condition_branch_trend_3(result)
      if result < 55
        return '革新型'
      else
        return '柔軟型'
      end
    end

    def condition_branch_trend_4(result)
      if result < 55
        return '直感型'
      else
        return '論理型'
      end
    end


    def condition_branch_mana_type(result, box)
      if result[0] >= 55
        if result[1] < 55
          if result[2] < 55
            if result[3] < 55
              return box[0]
            else
              return box[1]
            end
          else
            if result[3] < 55
              return box[2]
            else
              return box[3]
            end
          end
        else
          if result[2] < 55
            if result[3] < 55
              return box[4]
            else
              return box[5]
            end
          else
            if result[3] < 55
              return box[6]
            else
              return box[7]
            end
          end
        end
      else
        if result[1] < 55
          if result[2] < 55
            if result[3] < 55
              return box[8]
            else
              return box[9]
            end
          else
            if result[3] < 55
              return box[10]
            else
              return box[11]
            end
          end
        else
          if result[2] < 55
            if result[3] < 55
              return box[12]
            else
              return box[13]
            end
          else
            if result[3] < 55
              return box[14]
            else
              return box[15]
            end
          end
        end
      end
    end

  def ranking
    [

      [:q_131, :q_141, '部長の魅力'],
      [:q_132, :q_142, '入社前後のギャップ'],
      [:q_133, :q_143, '処遇・待遇'],
      [:q_134, :q_144, '会社方針・風土'],
      [:q_135, :q_145, '将来性'],
      [:q_136, :q_146, 'ワークライフバランス'],
      [:q_137, :q_147, '女性の働きやすさ'],
      [:q_138, :q_148, '人間関係'],
      [:q_139, :q_149, '評価方法'],
      [:q_140, :q_150, '仕事内容']

    ]
  end




  def box_1

    [
["右のチャートの左半分が公的欲求を表し、右半分が私的欲求を表します。公的欲求に偏ると、他者を大切にする反面、自己を犠牲にしがちになり、反対に私的欲求が強いと自分を優先にし、他者を蔑ろにしがちです。公的欲求の方が強いあなたは、所属のコミュニティの文化にも大きく影響を受け、周囲の価値観や考え方により添います。そのため、周りと助け合いながら生きるのが、性に合っています。価値観が合う人が多いと自己肯定感を持ち、自己効力感を発揮できるでしょう。その反面、価値観が合わない人と一緒にいると疲れてしまう傾向にあるので、環境を見直す必要もあるかもしれません。",
"右のチャートの左半分が公的欲求を表し、右半分が私的欲求を表します。公的欲求に偏ると、他者を大切にする反面、自己を犠牲にしがちになり、反対に私的欲求が強いと自分を優先にし、他者を蔑ろにしがちです。私的欲求が強いあなたは、所属のコミュニティの文化にも大きく影響を与え、自分の価値観や考え方を他者のそれより優先します。そのため、自立的に活動するのが性に合っています。周りと馴れ合うよりと競争が激しく、自分の意見をはっきり言え、切磋琢磨できる環境で力を発揮するしょう。その反面、人に合わすのがあまり得意ではなく、仲間意識を求められる環境は苦手です。他者への気遣いや思いやりを大切にしましょう。",
"右のチャートの左半分が公的欲求を表し、右半分が私的欲求を表します。公的欲求に偏ると、他者を大切にする反面、自己を犠牲にしがちになり、反対に私的欲求が強いと自分を優先にし、他者を蔑ろにしがちです。公的、私的欲求のバランスが取れているあなたは、人を大切にしながら自分自身も大切にできる稀有な存在です。バランス感覚がよく、時と場合において、どちらを優先すべきか判断できます。また他者も自分も喜べる選択肢や可能性をみる力があるとも言えます。そんなあなたの周りには、たくさんの人が寄り集ってきます。多くの人と何かを共有し共に活動をするのが生きがいになるかもしれません。"],
["あなたは、心のエネルギーが環境や周囲の人に向いています。何かに取り組む時、予期せぬ出来事が起こった時、自分自身より外側になる要因に目を向けます。自分自身より相手に質問を投げかけ理解しようとするのも特徴です。そのため、環境や周囲に対して、敏感に反応し、影響力を持ちます。その反面、ネガティブなことがあると、自身ではなく環境や他者を責める傾向があります。環境や周り人のことに対して、一生懸命なあなただからこそ、そんな時は自身の考え方や価値観に目を向けてみると、改善すべきことが見えてくるかもしれません。","あなたの心のエネルギーはバランスのとれた状態にあります。思考が外向きでも内向きでもなく偏りのない状態です。この状態を保つことは非常に難しく、外的内的両面の影響を受けやすい状態でもあります。自分を理念や行動の基準を言語化しビジョンを描いておくことで、自分を乱すことなく心の調和のとれた保つことができます。その反面、決断を求めらる場合や物事を強く推進させなくてはならない場合は、思い切った判断ができない場合があります。どんな状況においても、ブレない自分をつくるため明確なビジョンを持っておきましょう。","あなたは、心のエネルギーが自分の内面や精神性に向かっています。何か取り組む時や予期せぬ出来事が起こった時、環境や他者よりも自分自身の内側の要因に目を向けます。自らの経験や知識を元に相手を推測するのも特徴です。そのため、自身を高めることに敏感で意欲的です。その反面、ネガティブなことがあると、環境や他人の所為にするのでなく、自分自身を責め、内向的になりがちです。自己犠牲をしてしまうことあります。問題は、誰の問題か区別をすることで、自分自身を守ることができ、物事を正しくに捉える力を養いましょう。"],
["この数字が高い人は、何事も深く考え、結論を出すまで行動を起こしません。冷静沈着に時間をかけ熟考をするため、ミスが少なく、判断を誤ることがあまりありません。「石橋を叩いて渡る完璧主義」なあなたは、チームにおいても重要な戦術眼の役割を果たします。コミュニケーションに齟齬を起こさず、問題を最小限にする力は、安心安全を作ることでしょう。その反面、急な判断を要する場では、考え過ぎてしまい、行動に移せないことが欠点になってしまうことがあります。持ち前の戦術に、急な判断をできる仲間を探しておきましょう。","あなたは、考え過ぎて行動ができなくなる訳でもなく、行動し過ぎて失敗することもあまりありません。チームにおいては、思慮深い人の判断を見つつ、行動的な人の結果を考慮しながら賢く動くタイプです。その反面、自身で判断することが少なく、自分の意思を周囲に汲み取ってもらうことが少ないかもしれません。「可もなく不可もなく」当たり障りのないポジションに落ち着いてしまうこともしばしばあるかもしれません。自身の価値をアピールする場においては、迷いながらでも自身の判断を態度や言動で示していきましょう。","この数字が低い人は、行動力が高い活発な人です。そのため実行力を養っており、目に見える成果を出しやすいタイプと言えます。「とりあえずやってみる」が合言葉のあなたは、仕事をする上でアドバンテージを持っています。行動をしなければ何も始まりません。実践で磨くものほど強いものはなく、多くの経験を経て、大きな武器を形成します。その反面、考える前に行動してしまい、誤解や勘違いを産んでしまうことがあります。失敗することも多いでしょうが、創意工夫をし、失敗を糧に成功を掴みましょう。"],
["この数値が高い人は、物事を客観的に捉える能力が高い人です。それは、論理的に情報を整理する力を養い、情報を上手く伝えることに秀でています。他者とのコミュニケーションにおいても、相手の立場に立って、分かりやすく伝達することができます。その反面、主観的に捉えることが苦手で、直感的な判断を疑う傾向があるかもしれません。素早く物事の全体像を捉え、スピーディーな判断を必要とする状況には、少し苦手意識があるかもしれません。自身の主観的な考えを少し信じてみるとバランスがとれ、臨機応変に対応できるようになるでしょう。","この数値が中程度のあなたは、客観と主観を合わせ持つことで、物事の判断をします。主観は直感力を養い、客観は論理力を形成します。直感と論理を使い分けるようになるには、経験や知識が必要です。経験が少なく知識が欠如している状態であると、物事を判断するに根拠がなく、ミスをおかしがちです。集団生活をする社会においても、根拠の説明ができないと信頼を欠いてしまいます。せっかくの2面性を活かすためにも経験と知識を言語化し、根拠を持つことを意識しましょう。日々の学習があなたの判断力を高めることでしょう。","この数値が低い人は、物事を主観的に捉える能力が高い人です。その主観を信じるが強い人は、直感力が高く、物事への判断がスピーディーに行うことができます。臨機応変な判断が必要な場において、能力を発揮します。その反面、客観力が弱く、物事の経験や体験が少ないと裏付けのない浅い考えや行動をしてしまい、ミスをおかしてしまう場合があります。主観を俯瞰してみるメタ認知能力を高め得ることで、経験や体験を知識や知恵に置き換え、根拠を持った考えや判断ができるようになります。それは自分を信じる力を養うことでしょう。"],
["あなたは、周囲の人や環境が大きく変化したとしても柔軟に適応ができる人です。他者やチームの意見や意向を受け入れることが容易にでき、スムーズなコミュニケーションができます。明治維新の立役者「坂本龍馬」のように、本当の自分を上手に守り、苦境の中でも決して屈しない、したたかさを持っています。その反面、懐柔がされやすく、流されやすい傾向にあり、気づいた時には、自分が思ってもいない苦境に立たされてしまうこともあります。大きな目標をもち、物事に執着し、こだわりを持つともで、自身の表現を豊かにしましょう。","この数値が中程度の人は、周囲に適応しながらも自分の考えを貫きたいと思っています。大きなものに巻かれるタイプとも言えます。しかし、西郷隆盛のように「小さく叩けば小さく響き、大きく叩けば大きく響く」人物とも言えます。どんな環境、どんな人といるかで、人生を小さなものにするか大きくさせるか、自身で決めることができる選択肢の多い人かもしれません。今まだ迷いながら進んでいる人も多いかと思いますが、社会の大きな流れの中を掴む大局観を養い、自分自身が輝ける環境を探すことが、自らを大成させる第一歩かもしれません。","あなたは、自分の価値観や思想が非常に強く、意思を突き通したい人です。「ナポレオン」のような歴史に残る英雄は、自身の正義感を微塵も疑わなかったと言います。その精神性が、世界に革新をもたらし、新たな文化を切り開きました。死すら恐れず、正義と思うことを貫くことは、凡人には容易ではありません。その反面、支配欲が強く、人や物事をコントロールしたいという我欲が強く、価値観や思想が違う人から敵と見なされることも往々にしてあります。思い通りならないことも他者をコントロールするのではなく、自己に支配性を向けコントロールしましょう。"]
    ]

  end

  def priority_rank
    [
[1, "①社長/上司の魅力"],
[2, "②入社前後のギャップ"],
[3, "③処遇・待遇"],
[4 ,"④会社方針・風土"],
[5, "⑤将来性"],
[6, "⑥ワークライフバランス"],
[7, "⑦女性の働きやすさ"],
[8, "⑧人間関係"],
[9, "⑨評価方法"],
[10, "⑩仕事内容"]

    ]

  end

  def mana_type_box

    [
"親愛家タイプ",
"独創家タイプ",
"決断者タイプ",
"情熱家タイプ",
"社交家タイプ",
"受容者タイプ",
"責任者タイプ",
"探検家タイプ",
"理想家タイプ",
"芸術家タイプ",
"創作者タイプ",
"戦略家タイプ",
"組織人タイプ",
"職人肌タイプ",
"努力家タイプ",
"実践者タイプ"
    ]

  end

  def every_subjects

    [
["楽観性"],
["充実性"],
["内向/外向"],
["思慮/行動"],
["積極性"],
["感受性"],
["尊重性"],
["柔軟/革新"],
["論理/直感"],
["協調性"]
  ]

  end


end
