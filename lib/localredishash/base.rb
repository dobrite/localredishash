require 'redis'

class LocalRedisHash
  class << self
    attr_accessor :redis
  end

  def initialize url = 'redis://localhost/0'
    self.class.redis ||= Redis.new url: url
  end

  def [] key
    if @hash[key]
      @hash[key]
    else
      @hash[key] = Time.now.to_s
    end
  end

  def use key
    pull key
    yield self
    push key
  end

  private

  def pull key
    @hash = self.class.redis.hgetall(key)
  end

  def push key
    self.class.redis.mapped_hmset key, @hash
  end
end


