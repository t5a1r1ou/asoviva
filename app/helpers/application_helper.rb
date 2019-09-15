# frozen_string_literal: true

module ApplicationHelper
  def current_user?(user)
    current_user == user
  end

  # rubocop:disable Metrics/MethodLength
  def default_meta_tags
    {
      site: 'asoviva!',
      title: '気軽に遊び相手を募集できるサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'asoviva!は自分の行きたいところや暇な日をリスト化して共有することで、一緒に行く人もついでに見つけられるかもといったサービスです。',
      keywords: '遊び相手, 募集, 週末, 予定',
      canonical: request.original_url,
      separator: '|',
      # icon: [
      #   { href: image_url('favicon.ico') },
      #   { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      # ],
      # あとで作成
      og: {
        site_name: :site, # もしくは site_name: :site
        title: :title, # もしくは title: :title
        description: :description, # もしくは description: :description
        type: 'website',
        url: request.original_url,
        image: image_url('dammy_man.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image'
      }
    }
  end
  # rubocop:enable Metrics/MethodLength
end
