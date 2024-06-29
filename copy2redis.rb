#!/usr/bin/env ruby
require_relative 'redis-clip'

# 使用例

# p ARGV
if ARGV.size == 0
  clip_to_redis
else
  data = ARGV[0]
  paste_to_redis(data)
end

$redis.quit
