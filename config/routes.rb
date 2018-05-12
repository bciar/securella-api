# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  scope :api do # rubocop:disable Metrics/BlockLength
    scope :v1 do
      scope :admin do
        get  'companies',             to: 'admins#companies'
        get  'company/:id',           to: 'admins#company'
        post 'create_company',        to: 'admins#create_company'
        put  'company/:id',           to: 'admins#update_company'
        get  'messages',              to: 'messages#messages'
        get  'messages/company/:id',  to: 'messages#company_messages'
        get  'messages/guard/:id',    to: 'messages#guard_messages'
        get  'messages/alarm/:id',    to: 'messages#alarm_messages'
        get  'messages/user/:id',     to: 'messages#user_messages'
      end
      scope :company do
        get  'guards',                      to: 'companies#guardians'
        get  'guard/:id',                   to: 'companies#guardian'
        post 'create_guard',                to: 'companies#create_guardian'
        put  'guard/:id',                   to: 'companies#update_guardian'
        put  'set_guardian_inactive/:id',   to: 'companies#set_guardian_inactive'
        put  'set_guardian_occupied/:id',   to: 'companies#set_guardian_occupied'
        put  'set_guardian_available/:id',  to: 'companies#set_guardian_available'
        put  'set_guardian_operating/:id',  to: 'companies#set_guardian_operating'
        get  'inactive_guards',             to: 'companies#inactive_guardians'
        get  'available_guards',            to: 'companies#available_guardians'
        get  'operating_guards',            to: 'companies#operating_guardians'
        get  'occupied_guards',             to: 'companies#occupied_guardians'
        get  'open_alarms',                 to: 'companies#open_alarms'
        get  'alarm_status/:id',            to: 'companies#alarm_status'
        post 'ack_request',                 to: 'companies#ack_request'
        post 'deny_request',                to: 'companies#deny_request'
        post 'cancel_delegation',           to: 'companies#cancel_delegation'
      end
      scope :guardian do
        get 'status',                 to: 'guardians#status'
        put 'update_status',          to: 'guardians#update_status'
        put 'update_location',        to: 'guardians#update_location'
        get 'alarms',                 to: 'guardians#open_alarms'
        post 'ack_alarm',             to: 'guardians#ack_alarm'
        post 'deny_alarm',            to: 'guardians#deny_alarm'
        post 'close_alarm',           to: 'guardians#close_alarm'
        put  'set_status_occupied',   to: 'guardians#set_status_occupied'
        put  'set_status_available',  to: 'guardians#set_status_available'
      end
      scope :user do
        post 'new_alarm',      to: 'users#create_alarm'
        put  'update_alarm',   to: 'users#update_alarm'
        post 'close_alarm',    to: 'users#close_alarm'
        get  'alarm_status',   to: 'users#alarm_status'
        put  'update_image',   to: 'users#update_image'
      end
    end
  end

  mount_devise_token_auth_for 'Admin',    at: 'api/v1/admin'
  mount_devise_token_auth_for 'Company',  at: 'api/v1/company'
  mount_devise_token_auth_for 'Guardian', at: 'api/v1/guardian'
  mount_devise_token_auth_for 'User',     at: 'api/v1/user'

  scope :users do
    put :update, to: 'users#update'
  end

  scope :status do
    get :health, to: 'app_status#health'
    get :info, to: 'app_status#info'
  end
end
