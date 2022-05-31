require "employee"

class Startup
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end 

    def name
        @name
    end

    def funding
        @funding
    end

    def salaries
        @salaries
    end

    def employees
        @employees
    end

    def valid_title?(title)
        if @salaries.has_key?(title)
            return true
        else
            return false
        end
    end

    def >(startup)
        if @funding > startup.funding
            return true
        else
            return false
        end
    end

    def hire(employee_name, title)
        if valid_title?(title)
            employee = Employee.new(employee_name,title)
            @employees << employee
        else
            raise "Title is invalid!"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        salary = @salaries[employee.title]

        if funding < salary
            raise "Not enough funding!"
        else
            employee.pay(salary)
            @funding -= salary
        end
    end

    def payday
        @employees.each do |employee|
            self.pay_employee(employee)
        end
    end 

    def average_salary
        total = 0

        @employees.each do |employee|
            total += @salaries[employee.title]
        end

        total / @employees.length
    end

    def close
        @employees = []
        @funding = 0 
    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each do |k,v|
            if !@salaries.has_key?(k)
                @salaries[k] = v
            end
        end
        @employees += startup.employees

        startup.close
    end
end 
