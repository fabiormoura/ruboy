module Emulator
  class MmuStub < Mmu
    def initialize
      @data = []
    end

    def []=(position, data)
      @data[position] = data
    end

    def [](position)
      @data[position]
    end

    def to_s
      "#{@data}"
    end
  end
end