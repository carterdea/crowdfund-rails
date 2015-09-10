# lib/tasks/kill_postgres_connections.rake
task kill_postgres_connections: :environment do
  db_name = 'at-dev'
  sh = <<EOF
ps xa \
  | grep postgres: \
  | grep #{db_name} \
  | grep -v grep \
  | awk '{print $1}' \
  | sudo xargs kill
EOF
  puts `#{sh}`
end
