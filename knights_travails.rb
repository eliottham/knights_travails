class Position
	attr_accessor :position, :children, :previous, :parent
	attr_reader :row, :col
	def initialize(position)
		@position = position
		@row = position[0]
		@col = position[1]
		@children = Array.new
		@parent = Array.new
	end
end

class PositionTree
	def initialize(initial, target)
		@initial = Position.new(initial)
		@target = target
		@path = []
	end

	def backwards_search																	#Run a BFS from the found target position
		queue = [forwards_search]															#to find the shortest path of the paths
		until queue.empty?																	#that found the target by checking
			return if queue.first.position == @initialize									#each node's parent
			queue.first.parent.each do |parent|
				queue << parent
			end
			@path << queue.first
			queue.shift
		end
	end

	def forwards_search																		#Run a BFS from the initial position
		queue = [@initial]																	#to find the target position by checking
		until queue.empty?																	#through each node's children
			return queue.first if queue.first.position == @target
			find_children(queue.first)
			queue.first.children.each do |child|
				queue << child
			end
			queue.shift
		end
		return nil
	end

	def find_children(node)
		offset = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [-1, 2], [1, -2], [-1, -2]]

		offset.each do |x|																	#Adds the offsets from the current position
			new_position = [x[0] + node.row, x[1] + node.col]								#and checks to see if they fit on the board.
			if (0..7).include?(new_position[0]) and (0..7).include?(new_position[1])		#Positions that fit are made into nodes and
				child = Position.new(new_position)											#are added to the current positions array
				node.children << child  													#of children.
				child.parent << node
			end
		end
	end

	def find_path																			#Runs both search methods to find
		forwards_search																		#the shortest possible path and
		backwards_search																	#returns the path as an array of Position nodes.
		return @path		
	end
end

def knight_moves(initial, target)
	moves = PositionTree.new(initial, target)
	path = moves.find_path
	puts "You made it in #{path.length} moves! Here's your path:"
	until path.empty?
		print "#{path.pop.position} \n"
	end
end