require 'redis'

class LocalRedisHash
  def initialize url = 'redis://localhost/0'
    @@redis ||= Redis.new url: url
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
    @hash = @@redis.hgetall(key)
  end

  def push key
    @@redis.mapped_hmset key, @hash
  end
end


