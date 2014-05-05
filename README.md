# Local Redis Hash

Checks out a hash from redis, use the hash locally, then push it back up when
done. The pushing and pulling is handled automatically. Not at all concurrent
and most likely a pretty bad idea in general but it can be useful in specific
use cases.

``` ruby
hash_key = 'whatever'
lrh = LocalRedisHash.new
lrh.use(hash_key) do |hash|
  # use hash here
end
```
