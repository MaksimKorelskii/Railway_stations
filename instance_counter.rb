module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances

    def define_instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.define_instances
      self.class.instances += 1
    end
  end
end
