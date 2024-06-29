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
  puts text
  # textをUTF-8に変換 (変換できない文字は置換)
  #text_utf8 = text.encode('UTF-8', 'Shift_JIS', invalid: :replace, replace: '?')
  text_utf8 = text.encode('UTF-8', invalid: :replace, replace: '?')
  puts text_utf8

  $redis.set('clipboard', text_utf8)
  puts "redisに '#{text_utf8}' をコピーしました"
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

def get_redis_clip
  data = $redis.get(RedisKey)
  puts data
end

# # 使用例
# copy_to_clipboard('Hello, World!') # クリップボードとRedisにコピー
# paste_from_clipboard # Redisからクリップボードに貼り付け

# # Redisサーバーから切断
# $redis.quit
