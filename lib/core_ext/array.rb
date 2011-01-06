if RUBY_VERSION =~ /1\.8/
  class Array
    alias :sample :choice
  end
end
