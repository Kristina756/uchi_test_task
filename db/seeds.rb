SchoolClass.find_or_create_by!(id: 1) do |c|
  c.number = 1
  c.letter = 'А'
  c.students_count = 0
end

puts "Тестовые данные созданы!"