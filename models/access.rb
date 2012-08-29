# Модель доступа к кластеру
# `activate` - запускает процесс добавления ключа на кластер
# `close` - закрывает доступ удаляя ключ с кластера
# `force_close` - закрывает доступ не удаляя ключ с кластера 
# (при удалении вручную или всего пользователя на кластере)
class Access < ActiveRecord::Base
  delegate :cluster, to: :cluster_user
  delegate :state_name, to: :credential, prefix: true, allow_nil: true
  
  include Models::Asynch
  has_paper_trail
  
  default_scope order("#{table_name}.id desc")
  
  attr_accessor :skip_activation
  
  belongs_to :cluster_user
  belongs_to :credential
  has_many :tasks, as: :resource
  
  validates :credential, :cluster_user, presence: true
  validates :credential_state_name, inclusion: { in: [:active] }, on: :create
  
  after_create :activate, unless: :skip_activation
  
  state_machine initial: :pending do
    state :pending
    state :activing
    state :active
    state :closing
    state :closed
    
    event :_activate do
      transition pending: :activing
    end
    
    event :_complete_activation do
      transition activing: :active
    end
    
    event :_close do
      transition any => :closing
    end
    
    event :_complete_closure do
      transition closing: :closed
    end
    
    event :_force_close do
      transition any => :closed
    end
  end
  
  define_defaults_events :activate, :complete_activation, :failure_activation,
    :close, :complete_closure, :failure_closure, :force_close
  
  define_state_machine_scopes
  
  # активирует (создает задачу для доступа к кластеру)
  def activate!
    transaction do
      _activate!
      tasks.setup(:add_openkey)
    end
    true
  end
  
  # закрывает доступ (создает задачу для закрытия доступа к кластеру)
  def close!
    transaction do
      _close!
      tasks.setup(:del_openkey)
    end
    true
  end
  
protected
  
  def continue_add_openkey(task)
    complete_activation!
  end
  
  def continue_del_openkey(task)
    complete_closure!
  end
end
