require_relative './lib/remote_log'

LOG_WRONG_ARGS_ERR = 'ERROR: Expected one argument, log message level'
LAST_WRONG_ARGS_ERR = 'ERROR: Expected no arguments or one positive numeric argument'
REMOTE_UNAVAILABLE_ERR = 'ERROR: The remote logging service is unavailable.'
WRONG_COMMAND_ERR = 'ERROR: Unexpected command:'

PROMPT = "\n> "

log = RemoteLog.new('http://localhost:8080')

puts 'Welcome to LogService Ruby Client!'
puts
puts 'To log a message, use the following command:'
puts '  LOG (DEBUG|INFO|WARN|ERROR)'
puts '  Your multiline message... (end with an empty line)'
puts
puts 'To retrieve last n messages, use:'
puts '  LAST n'
puts
puts 'To retrieve the last message, use:'
puts '  LAST'
puts
puts 'To stop the client, use:'
puts '  EXIT'

def execute_log(log, command_parts)
  if command_parts.length != 2
    puts LOG_WRONG_ARGS_ERR
    return
  end

  begin
    level = LogLevel.resolve(command_parts[1].to_sym)
  rescue TypeError
    puts LOG_WRONG_ARGS_ERR
    return
  end

  if level.nil?
    puts LOG_WRONG_ARGS_ERR
    return
  end

  message = ""
  while true
    line = STDIN.readline.strip
    break if line.empty?
    message += line + "\n"
  end

  begin
    log.log(level, message.strip)
  rescue
    puts REMOTE_UNAVAILABLE_ERR
  end
end

def execute_last(log, command_parts)
  if command_parts.length > 2
    puts LAST_WRONG_ARGS_ERR
    return
  end

  begin
    if command_parts.length == 1
      messages = [ log.last ]
    elsif
      count = command_parts[1].to_i
      if count <= 0
        puts LAST_WRONG_ARGS_ERR
        return
      end
      messages = log.last(count).message.reverse
    end
  rescue
    puts REMOTE_UNAVAILABLE_ERR
    return
  end

  messages.each do |message|
    puts "#{message.level}\t#{message.message}"
  end
end

while true do
  print PROMPT

  begin
    parts = STDIN.readline.strip.split
  rescue EOFError
    puts
    break
  end

  case parts[0]
  when 'LOG'
    execute_log(log, parts)
  when 'LAST'
    execute_last(log, parts)
  when 'EXIT'
    break
  else
    puts "#{WRONG_COMMAND_ERR} #{parts[0]}"
  end
end

puts
puts 'Terminating LogService Ruby Client...'
