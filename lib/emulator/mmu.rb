module Emulator
  class Mmu
    def []=(position, data)
      raise NotImplementedError
    end

    def [](position)
      raise NotImplementedError
    end
  end
end