# frozen_string_literal: true

module PostsHelper
  def searched_name_by
    params[:q][:name_cont].present? ? "「#{params[:q][:name_cont]}」、" : nil
  end

  def searched_category_by
     params[:q][:category_eq].present? ? "カテゴリ：#{ Post.categories_i18n.values[params[:q][:category_eq].to_i] }" : 'カテゴリ："全カテゴリ" '
  end

  def searched_area_by
    params[:q][:area_eq].present? ? "、エリア：#{ Post.areas_i18n.values[params[:q][:area_eq].to_i] }" : nil
  end
end
