require 'ffi'

module FFI
  def self.alias_type(type,aliased)
    add_typedef(find_type(type),aliased.to_sym)
  end

  alias_type :int, :pid_t
end
