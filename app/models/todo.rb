# class Todo<ActiveRecord::Base
#     def to_pleasant_string
#         is_completed=completed ? "[X]" : "[ ]"
#         " #{id} . #{due_date.to_s(:long)} #{todo_text} #{is_completed}"
# end
# end
class Todo < ActiveRecord::Base
    belongs_to :user
    validates :todo_text, presence: true
    validates :due_date, presence: true
  
    def to_pleasant_string
      is_completed = completed ? "[X]" : "[ ]"
      "#{id}. #{due_date.to_s(:long)} #{todo_text} #{is_completed}"
    end
  
    def due_today?
      due_date == Date.today
    end
  
    def self.overdue
      where("due_date < ? and completed = ?", Date.today, false)
    end
  
    def self.due_today
      where(due_date: Date.today)
    end
  
    def self.due_later
      where("due_date > ? ", Date.today)
    end
  
    def self.completed
      all.where(completed: true)
    end
  end