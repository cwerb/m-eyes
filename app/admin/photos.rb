# -*- encoding : utf-8 -*-
ActiveAdmin.register Photo do
  menu label: 'Фотографии'
  scope :непросмотренные, default: true
  scope :опубликованные
  scope :неопубликованные
  actions :index
  batch_action :Разрешить, if: proc { @current_scope.scope_method == :непросмотренные } do |selection|
    Photo.find(selection).each do |i|
      i.is_legal = true
      i.save
    end
    redirect_to admin_photos_path
  end
  batch_action :Разрешить, if: proc { @current_scope.scope_method == :неопубликованные } do |selection|
    Photo.find(selection).each do |i|
      i.is_legal = true
      i.save
    end
    redirect_to admin_photos_path
  end
  batch_action :Запретить, if: proc { @current_scope.scope_method == :непросмотренные } do |selection|
    Photo.find(selection).each do |i|
      i.is_legal = false
      i.save
    end
    redirect_to admin_photos_path
  end
  batch_action :Запретить, if: proc { @current_scope.scope_method == :опубликованные } do |selection|
    Photo.find(selection).each do |i|
      i.is_legal = false
      i.save
    end
    redirect_to admin_photos_path
  end

  filter :author, label: 'Автору'
  filter :link, label: 'Ссылке'
  filter :created_at, label: 'Появилась в...'
  index title: 'Фотографии', as: :grid do |photo|
    resource_selection_cell photo
    img src: photo.link, width: "200px"
    p %(Автор: @#{photo.author})
  end
end
