unless Client.find_by(name: 'recruit')
  puts '採用管理データの作成開始'

  ActiveRecord::Base.transaction do
    client = Client.create!(name: 'recruit')
    my_client = Client.create!(name: 'myapp')

    configs = [
      {kind: :notification, value: 'slack'}
    ]
    configs.each { |c| Client::Config.create!(client_id: client.id, kind: c[:kind], value: c[:value]) }

    user = User.create!(
      cognito_id: Rails.application.credentials[:sample_user][:recruit][:cognito_id]
    )

    ClientUser.create!(client_id: client.id, user_id: user.id, role: :admin)
    ClientUser.create!(client_id: my_client.id, user_id: user.id, role: :admin)
    User::Profile.create!(
      user_id: user.id,
      first_name: '太郎',
      last_name: '採用',
      email: Rails.application.credentials[:sample_user][:recruit][:email],
      phone_number: '000-0000-0000'
    )

    # ユーザー一覧表示用データ、ログインの想定はしないため正しいcognitoIdは付与しない
    (1..49).each do |idx|
      temp_user = User.create!(cognito_id: "recruit_#{idx.to_s}")
      ClientUser.create!(client_id: client.id, user_id: temp_user.id, role: :normal)
      User::Profile.create!(
        user_id: temp_user.id,
        first_name: "#{idx}太郎",
        last_name: "佐藤",
        phone_number: "000-0000-#{sprintf("%04d", idx)}",
        email: "recruit_sample#{idx}@akiumi.net"
      )
    end

    first_flow = Flow.create!(
      client_id: client.id,
      name: '候補者面談フロー'
    )

    second_flow = Flow.create!(
      client_id: client.id,
      name: '求人管理'
    )

    %w[応募前 書類選考 一次面接 二次面接 最終面接 内定 内定承諾 不通過 保留].each_with_index do |step_name, idx|
      status = if step_name == '応募前'
                 'lead'
               elsif step_name == '不通過'
                 'ng'
               elsif step_name == '保留'
                 'stay'
               elsif step_name == '内定承諾'
                 'complete'
               else
                 'active'
               end

      step = Flow::Step.create!(
        flow_id: first_flow.id,
        order_index: idx + 1,
        status: status,
        name: step_name
      )

      flow_fields = if step_name == '応募前'
                      [
                        { name: '面談日時', input_type: 'datetime' },
                        { name: '接触日', input_type: 'date' },
                        { name: 'エントリー日', input_type: 'date' },
                        { name: '事前接触内容', input_type: 'text_area' },
                      ]
                    elsif step_name == '内定'
                      [
                        { name: 'オファー内容', input_type: 'text_area' },
                        { name: '接触内容', input_type: 'text_area' },
                      ]
                    elsif step_name == '内定承諾'
                      [
                        { name: '承諾内容', input_type: 'text_area' },
                        # {name: '内定承諾書', input_type: 'document'},
                      ]
                    elsif step_name == '不通過'
                      [
                        { name: 'NG理由', input_type: 'pulldown' },
                        { name: '補足', input_type: 'text_area' },
                      ]
                    elsif step_name == '保留'
                      [
                        { name: '保留理由', input_type: 'pulldown' },
                        { name: '補足', input_type: 'text_area' },
                      ]
                    else
                      [
                        { name: '面談日時', input_type: 'datetime' },
                        { name: '実施日', input_type: 'date' },
                        { name: '通過日', input_type: 'date' },
                        { name: '面談内容', input_type: 'date' },
                      ]
                    end

      flow_fields.each_with_index do |field, idx|
        Flow::Step::Field.create!(
          flow_step_id: step.id,
          name: field[:name],
          input_type: field[:input_type],
          order_index: idx + 1
        )
      end
    end

    %w[募集前 募集中 終了].each_with_index do |step_name, idx|
      status = if step_name == '募集前'
                 'lead'
               elsif step_name == '終了'
                 'complete'
               else
                 'active'
               end

      step = Flow::Step.create!(
        flow_id: second_flow.id,
        order_index: idx + 1,
        status: status,
        name: step_name
      )

      flow_fields = if step_name == '募集前'
                      []
                    elsif step_name == '終了'
                      [{ name: '終了理由', input_type: 'pulldown' }]
                    else
                      []
                    end

      flow_fields.each_with_index do |field, idx|
        Flow::Step::Field.create!(
          flow_step_id: step.id,
          name: field[:name],
          input_type: field[:input_type],
          order_index: idx + 1
        )
      end
    end

    tag_groups = [
      { name: '言語', tag_names: %w[Ruby PHP Python] },
      { name: '職種', tag_names: %w[エンジニア 営業 マーケター] },
      { name: '特徴', tag_names: %w[リモート 私服OK] },
    ]

    tag_groups.each do |tag_group|
      group = TagGroup.create!(
        client_id: client.id,
        name: tag_group[:name]
      )

      tag_group[:tag_names].each do |tag_name|
        TagGroup::Item.create!(
          tag_group_id: group.id,
          name: tag_name
        )
      end
    end

    first_resource = Resource.create!(
      client_id: client.id,
      first_parent_resource_id: nil,
      second_parent_resource_id: nil,
      flow_id: first_flow.id,
      name: '候補者'
    )

    first_resource_fields = [
      { input_type: 'text',    name: '氏名' },
      { input_type: 'text',    name: 'メールアドレス' },
      { input_type: 'text',    name: '電話番号' },
      { input_type: 'text',    name: '住所' },
      { input_type: 'tag',     name: '希望職種' },
      { input_type: 'integer', name: '希望年収' },
    ]

    second_resource = Resource.create!(
      client_id: client.id,
      first_parent_resource_id: nil,
      second_parent_resource_id: nil,
      flow_id: second_flow.id,
      name: '求人'
    )

    second_resource_fields = [
      { input_type: 'text',    name: '求人名' },
      { input_type: 'integer', name: '年収下限' },
      { input_type: 'integer', name: '年収上限' },
      { input_type: 'text',    name: '勤務地' },
      { input_type: 'tag',     name: '必要スキル' },
      { input_type: 'tag',     name: '特徴' },
    ]

    first_resource_fields.each do |field|
      Resource::Field.create!(
        resource_id: first_resource.id,
        name: field[:name],
        input_type: field[:input_type]
      )
    end

    second_resource_fields.each do |field|
      Resource::Field.create!(
        resource_id: second_resource.id,
        name: field[:name],
        input_type: field[:input_type]
      )
    end

    # 候補者データ作成
    first_steps = first_flow.steps
    (1..50).each do |num|
      item = Resource::Item.create!(
        resource_id: first_resource.id,
        step_item_id: nil,
        status: :lead
      )

      item.resource.fields.each do |field|
        case field.name
        when '氏名' then
          Value.create!(value: "鈴木 #{num}郎", kind: :resource, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
        when 'メールアドレス' then
          Value.create!(value: "candidate+#{num}@akiumi.net", kind: :resource, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
        when '電話番号' then
          Value.create!(value: "000-0000-#{sprintf("%04d", num)}", kind: :resource, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
        when '住所' then
          Value.create!(value: "東京都新宿区新宿x-x-x", kind: :resource, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
        when '企業職種' then
          Value.create!(value: "XXX", kind: :resource, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
        when '希望年収' then
          Value.create!(value: "xxx,xxx円", kind: :resource, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
        end

      end

      (0..( num % first_steps.count ) ).each do |step_num|
        flow_step = first_steps[step_num]

        step_item = Resource::Step::Item.create!(
          flow_step_id: flow_step.id,
          resource_item_id: item.id,
          order_index: step_num + 1,
        )

        if step_num == num % first_steps.count
          item.update!(
            step_item_id: step_item.id,
            status: flow_step.status
          )
        end

        step_item.origin_step.fields.each do |field|
          case field.name
          when '面談日時' then
            Value.create!(value: (Time.zone.now - 7.days).strftime('%Y-%m-%d %H:%M'), kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when '接触日時' then
            Value.create!(value: (Time.zone.now - 10.days).strftime('%Y-%m-%d %H:%M'), kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when 'エントリー日' then
            Value.create!(value: (Time.zone.now - 13.days).strftime('%Y-%m-%d'), kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when '事前接触内容' then
            Value.create!(value: "会社説明会にて初接触\nエントリーシート回収済み", kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when 'オファー内容' then
            Value.create!(value: "月給：xxx,xxx円\n職種：yy\n勤務開始：XX/YY", kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when '接触内容' then
            Value.create!(value: "オンラインMTGにて実施\n福利厚生/採用条件資料送付済み", kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when '承諾内容' then
            Value.create!(value: "内定承諾済み\n一部資料の押印が遅延", kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when 'NG理由' then
            Value.create!(value: "スキル不足\n第N次面接にて不通過", kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when '補足' then
            Value.create!(value: "エージェント連絡済み\n本人連絡済み", kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when '保留理由' then
            Value.create!(value: "現職の継続\n半年以降先にて再アプローチ", kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when '保留理由' then
            Value.create!(value: "現職の継続\n半年以降先にて再アプローチ", kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when '面談日時' then
            Value.create!(value: (Time.zone.now - 7.days + step_num.days).strftime('%Y-%m-%d %H:%M'), kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when '実施日' then
            Value.create!(value: (Time.zone.now - 7.days + step_num.days).strftime('%Y-%m-%d'), kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when '通過日' then
            Value.create!(value: (Time.zone.now - 7.days + (step_num + 1).days).strftime('%Y-%m-%d'), kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          when '面談内容' then
            Value.create!(value: "先行通過\n評価：B\n伝達事項：ー", kind: :flow_step, item_id: item.id, field_id: field.id, user_id: user.id, version: 1)
          end
        end
      end

    end

  end

  puts '採用管理データの作成終了'
end
