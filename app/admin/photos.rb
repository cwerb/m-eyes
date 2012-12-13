# -*- encoding : utf-8 -*-
ActiveAdmin.register Photo do
  menu label: 'Фотографии'
  scope :непросмотренные, default: true
  scope :опубликованные
  scope :неопубликованные
  actions :index
  batch_action :Разрешить, if: proc { [:непросмотренные, :неопубликованные].include? @current_scope.scope_method } do |selection|
    Photo.find(selection).each do |i|
      i.is_legal = true
      i.save
    end
    redirect_to admin_photos_path
  end
  batch_action :Запретить, if: proc { [:непросмотренные, :опубликованные].include? @current_scope.scope_method } do |selection|
    Photo.find(selection).each do |i|
      i.is_legal = false
      i.save
    end
    redirect_to admin_photos_path
  end

  sidebar :Операции do
    div id: 'batch_actions_selector' do
      ul do
        li a 'Запретить', href:'#', class: "batch_action", :'data-action' => "Запретить" if %w(непросмотренные опубликованные).include? params[:scope]
        li a 'Разрешить', href:'#', class: "batch_action permit", :'data-action' => "Разрешить" if %w(непросмотренные неопубликованные).include? params[:scope]
      end
    end
  end

  filter :created_at, label: 'Появилась в...'

  index title: 'Фотографии', as: :grid do |photo|
    resource_selection_cell photo
    img src: photo.link, width: "200px"
    p %(Автор: @#{photo.author})
  end
end
