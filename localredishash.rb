require 'redis'

class LocalRedisHashError < StandardError; end

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
    @key = key
    pull key
    if block_given?
      yield self
      push key
    else
      self
    end
  end

  def done
    if @key
      push @key
    else
      raise LocalRedisHashError, 'Must call #use prior to calling #done'
    end
  end

  private

  def pull key
    @hash = @@redis.hgetall(key)
  end

  def push key
    @@redis.mapped_hmset key, @hash
  end
end
