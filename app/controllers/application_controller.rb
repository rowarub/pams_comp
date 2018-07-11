class ApplicationController < ActionController::Base
  #サインイン時のpath
  def after_sign_in_path_for(resource)
    if resource.is_a?(Manager)
      managers_path(resource)
    elsif resource.is_a?(User)
      pams_answers_path(resource)
    else
      new_user_session_path
    end
  end

  #サインアウト時のpath
  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  private
  #q_(a)からq_(b)を配列化
  def q_xxx(a, b)
    q_xxx = []
    a.upto(b) { |n|
      q_xxx << ('q_' + '%03d' % n).to_sym
    }
    return q_xxx
  end

  #結果診断計算式
  def result(pa)
    [
(30 - pa.q_020 - pa.q_021 - pa.q_046 - pa.q_062 - pa.q_095) * 4,
(12 + pa.q_002 + pa.q_006 - pa.q_010 + pa.q_026 - pa.q_028 + pa.q_058) * 10/3,
(12 + pa.q_003 + pa.q_053 + pa.q_071 + pa.q_081 - pa.q_087 + pa.q_093 - pa.q_096 + pa.q_097) * 5/2,
(42 + pa.q_004 + pa.q_011 - pa.q_014 + pa.q_018 + pa.q_023 - pa.q_025 + pa.q_035 - pa.q_056 - pa.q_064 - pa.q_065 - pa.q_067 - pa.q_074 + pa.q_076 + pa.q_091 + pa.q_098) * 10/7,
(pa.q_032 + pa.q_061 + pa.q_070 + pa.q_089 + pa.q_090 + pa.q_100) * 10/3,
(6 + pa.q_008 - pa.q_013 + pa.q_063 + pa.q_068 + pa.q_069 + pa.q_072 + pa.q_079 + pa.q_085 + pa.q_086 + pa.q_092 + pa.q_099) * 20/11,
(36 - pa.q_005 - pa.q_009 - pa.q_015 - pa.q_019 + pa.q_026 + pa.q_066 - pa.q_077 - pa.q_078) * 5/2,
(18 + pa.q_016 - pa.q_017 - pa.q_031 + pa.q_036 - pa.q_039 + pa.q_088) * 10/3,
(pa.q_059 + pa.q_073 + pa.q_075 + pa.q_082 + pa.q_083 + pa.q_084) * 10/3,
(36 + pa.q_001 - pa.q_007 + pa.q_012 + pa.q_022 - pa.q_024 - pa.q_027 - pa.q_036 + pa.q_048 + pa.q_051 - pa.q_052 + pa.q_055 - pa.q_057 + pa.q_080 + pa.q_094) * 10/7
    ]

  end

  def mana_result(pa)
    [
(30 - pa[:q_020] - pa[:q_021] - pa[:q_046] - pa[:q_062] - pa[:q_095]) * 4,
(12 + pa[:q_002] + pa[:q_006] - pa[:q_010] + pa[:q_026] - pa[:q_028] + pa[:q_058]) * 10/3,
(12 + pa[:q_003] + pa[:q_053] + pa[:q_071] + pa[:q_081] - pa[:q_087] + pa[:q_093] - pa[:q_096] + pa[:q_097]) * 5/2,
(42 + pa[:q_004] + pa[:q_011] - pa[:q_014] + pa[:q_018] + pa[:q_023] - pa[:q_025] + pa[:q_035] - pa[:q_056] - pa[:q_064] - pa[:q_065] - pa[:q_067] - pa[:q_074] + pa[:q_076] + pa[:q_091] + pa[:q_098]) * 10/7,
(pa[:q_032] + pa[:q_061] + pa[:q_070] + pa[:q_089] + pa[:q_090] + pa[:q_100]) * 10/3,
(6 + pa[:q_008] - pa[:q_013] + pa[:q_063] + pa[:q_068] + pa[:q_069] + pa[:q_072] + pa[:q_079] + pa[:q_085] + pa[:q_086] + pa[:q_092] + pa[:q_099]) * 20/11,
(36 - pa[:q_005] - pa[:q_009] - pa[:q_015] - pa[:q_019] + pa[:q_026] + pa[:q_066] - pa[:q_077] - pa[:q_078]) * 5/2,
(18 + pa[:q_016] - pa[:q_017] - pa[:q_031] + pa[:q_036] - pa[:q_039] + pa[:q_088]) * 10/3,
(pa[:q_059] + pa[:q_073] + pa[:q_075] + pa[:q_082] + pa[:q_083] + pa[:q_084]) * 10/3,
(36 + pa[:q_001] - pa[:q_007] + pa[:q_012] + pa[:q_022] - pa[:q_024] - pa[:q_027] - pa[:q_036] + pa[:q_048] + pa[:q_051] - pa[:q_052] + pa[:q_055] - pa[:q_057] + pa[:q_080] + pa[:q_094]) * 10/7
    ]

  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:manager_id, :email])
  end

end
