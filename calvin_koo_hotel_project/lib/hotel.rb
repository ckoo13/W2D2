require_relative "room"

class Hotel
    def initialize(name, capacities)
        @name = name
        @rooms = Hash.new()

        capacities.each do |k,v|
            @rooms[k] = Room.new(v)
        end
    end

    def name
        @name.split(" ").map(&:capitalize).join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(room_name)
        if @rooms.has_key?(room_name)
            return true
        else
            return false
        end
    end

    def check_in(person, room_name)
        if self.room_exists?(room_name)
            if @rooms[room_name].add_occupant(person)
                puts "check in successful"
            else
                puts "sorry, room is full"
            end
        else
            puts "sorry, room does not exits"
        end
    end

    def has_vacancy?
        @rooms.each_value do |capacity|
            if capacity.available_space > 0
                return true
            end
        end

        false
    end

    def list_rooms
        @rooms.each do |room, capacity|
            puts "#{room} : #{capacity.available_space}"
        end
    end
end
