extends Node
class Step:
	var from
	var to
	var level
	func _init(from,to,level):
		self.from = from
		self.to = to
		self.level = level
		
class Disk:
	var level
	var belongs_to
	var should_belong_to
	var disks = []
	func _init(disks,level,belongs_to,should_belong_to = null):
		self.level = level
		self.belongs_to = belongs_to
		self.should_belong_to = should_belong_to
		self.disks = disks
	func is_in_right_place():
		return self.belongs_to == self.should_belong_to
	
	func is_the_highest_disk(): #the highest disk is the disk with the smallest level group by column_name
		for disk in self.disks:
			if disk.belongs_to == self.belongs_to and self.level > disk.level:
				return false
		return true
	
	func calculate_expected_column_for_the_upper_disk():
		if self.belongs_to == "A":
			if self.should_belong_to == "B":
				return "C"
			elif self.should_belong_to == "C":
				return "B"
		elif self.belongs_to == "B":
			if self.should_belong_to == "A":
				return 'C'
			elif self.should_belong_to == 'C':
				return 'A'
		elif self.belongs_to == "C":
			if self.should_belong_to == "B":
				return "A"
			elif self.should_belong_to == 'A':
				return 'B'
	
	func can_be_pushed_onto(disk):
		return (!disk or self.level < disk.level) and self.is_the_highest_disk()

class Resolver:
	var disks = []
	var steps = []
	var the_largest_disk
	func _init(number_of_disk = 2,origin_col = 'A',target_col ='C'):
		self.disks = []
		for i in range(number_of_disk):
			disks.append(Disk.new(self.disks,i + 1,origin_col))
		disks[disks.size() - 1].should_belong_to = target_col
		self.the_largest_disk = disks[disks.size() -1]
	func the_highest_disk_of_column(column_name):
		for disk in self.disks:
			if disk.belongs_to == column_name:
				return disk 
		return false
	
	func print_steps():
		for step in self.steps:
			print("Move from %s to %s" %[step.from,step.to])
	
	func print_game_stage():
		for disk in self.disks:
			print("level(%d) - origin(%s) - shoud_be_in(%s)" % [disk.level,disk.belongs_to,disk.should_belong_to])
			
	func resolve(disk):
		if self.steps.size() != 0:
			return false
		if disk.is_in_right_place():
			if disk.level != 1:
				var upper_disk = self.disks[disk.level -2]
				upper_disk.should_belong_to = disk.belongs_to
				return true && self.resolve(upper_disk)
			else:
				return true
		elif disk.can_be_pushed_onto(self.the_highest_disk_of_column(disk.should_belong_to)):
			steps.append(Step.new(disk.belongs_to,disk.should_belong_to,disk.level))
			disk.belongs_to = disk.should_belong_to
			if disk.level != 1:
				var upper_disk = self.disks[disk.level -2]
				upper_disk.should_belong_to = disk.belongs_to
				return true && self.resolve(upper_disk)
			else:
				return true
		else:
			var upper_disk = self.disks[disk.level-2]
			upper_disk.should_belong_to = disk.calculate_expected_column_for_the_upper_disk()
			return self.resolve(upper_disk) && false
	
	
	