require 'redis'
require 'clipboard'


RedisServer = "192.168.1.47"
# RedisServer = "localhost"
RedisKey = "clipboard"

puts ARGV[1]

# Redisサーバーに接続
$redis = Redis.new(host: RedisServer, port: 6379, db: 0)

# コピー関数
def paste_to_redis(text)
  $redis.set(RedisKey, text)
  puts "redisに '#{text}' をコピーしました"
end

def clip_to_redis
  text = Clipboard.paste
  $redis.set('clipboard', text)
  puts "redisに '#{text}' をコピーしました"
end

# ペースト関数
def redis_to_clipboard
  data = $redis.get(RedisKey)
  if data
    Clipboard.copy(data)
    puts "クリップボードに '#{data}' を貼り付けました"
  else
    puts 'クリップボードが空です'
  end
end

# # 使用例
# copy_to_clipboard('Hello, World!') # クリップボードとRedisにコピー
# paste_from_clipboard # Redisからクリップボードに貼り付け

# # Redisサーバーから切断
# $redis.quit
