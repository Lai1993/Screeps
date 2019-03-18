var roleBuilder = {
	run: function(creep,seq){
		creep.room.visual.circle(creep.pos,
            {fill: 'transparent', radius: 0.55, stroke: 'yellow'});
		//判斷工作內容
		if(!creep.memory.working && creep.carry.energy == creep.carryCapacity){
			creep.memory.working = true;
			creep.say("Build");
		}
		if( creep.memory.working && creep.carry.energy == 0){
			creep.memory.working = false;
			creep.say("Get");
		}
		if( creep.memory.working){
			//尋找最近的待建物
			var targets = creep.pos.findClosestByPath(FIND_CONSTRUCTION_SITES)
			if(creep.build(targets) == ERR_NOT_IN_RANGE){
				creep.moveTo(targets, {visualizePathStyle: {stroke: 'yellow'}});
			}
		}
		else if(creep.room.energyAvailable >= creep.room.energyCapacityAvailable-200){
			//1.優先從store取得
			var target = Game.spawns['Spawn1'];
			if(creep.withdraw(target,RESOURCE_ENERGY) == ERR_NOT_IN_RANGE){
				creep.moveTo(target, {visualizePathStyle: {stroke: 'yellow'}});
			}
		}
	}
};
module.exports = roleBuilder;