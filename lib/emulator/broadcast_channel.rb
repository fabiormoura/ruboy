module Emulator
  class BroadcastChannel
    def initialize
      @subscribers = {}
    end

    def attach(event_class, subscriber)
      @subscribers[event_class] ||= []
      @subscribers[event_class] << subscriber
    end

    # @param [Object] event
    def announce(event)
      @subscribers[event.class]&.each {|subscriber| subscriber.call(event)}
    end
  end
end