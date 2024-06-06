class BaseService
  def self.call(...)
    new(...).call
  end

  def call
    raise NotImplementedError
  end

  def transaction(&block)
    ActiveRecord::Base.transaction(&block) if block
  end
end
